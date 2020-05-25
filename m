Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF48C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6893E2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdwSkphG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgEYFYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35167 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbgEYFYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590384245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=m8Q62JV0BmlHzoSRYQ9uz5MfhUk1rLzhDZGQnnGc94o=;
        b=VdwSkphGHCXKYQJUYFlGobKSCnb04N/QG128RhsYz7XjMf5ZWHzi29cBrHBkg/Aw4z03UI
        cLE1cF2cwIeBDHahvVIWiSVl6qTIXtwfzdwMAFyNpzVfUdDWTGYeFP+43poQEM/gUxE7A/
        vtBsQN0cCI5RKH17ibsapCW5CxdjkMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-llTZDW1GOX6Nm6zbld2OqQ-1; Mon, 25 May 2020 01:24:02 -0400
X-MC-Unique: llTZDW1GOX6Nm6zbld2OqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AF831005510;
        Mon, 25 May 2020 05:24:01 +0000 (UTC)
Received: from unused.redhat.com (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABBE319D7B;
        Mon, 25 May 2020 05:23:53 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, ebiederm@xmission.com, jbohac@suse.cz,
        jmorris@namei.org, mjg59@google.com, dyoung@redhat.com,
        bhe@redhat.com
Subject: [PATCH] kexec: Do not verify the signature without the lockdown or mandatory signature
Date:   Mon, 25 May 2020 13:23:51 +0800
Message-Id: <20200525052351.24134-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signature verification is an important security feature, to protect
system from being attacked with a kernel of unknown origin. Kexec
rebooting is a way to replace the running kernel, hence need be
secured carefully.

In the current code of handling signature verification of kexec kernel,
the logic is very twisted. It mixes signature verification, IMA signature
appraising and kexec lockdown.

If there is no KEXEC_SIG_FORCE, kexec kernel image doesn't have one of
signature, the supported crypto, and key, we don't think this is wrong,
Unless kexec lockdown is executed. IMA is considered as another kind of
signature appraising method.

If kexec kernel image has signature/crypto/key, it has to go through the
signature verification and pass. Otherwise it's seen as verification
failure, and won't be loaded.

Seems kexec kernel image with an unqualified signature is even worse than
those w/o signature at all, this sounds very unreasonable. E.g. If people
get a unsigned kernel to load, or a kernel signed with expired key, which
one is more dangerous?

So, here, let's simplify the logic to improve code readability. If the
KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
is mandated. Otherwise, we lift the bar for any kernel image.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kernel/kexec_file.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index faa74d5f6941..e4bdf0c42f35 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -181,52 +181,27 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 static int
 kimage_validate_signature(struct kimage *image)
 {
-	const char *reason;
 	int ret;
 
 	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
 					   image->kernel_buf_len);
-	switch (ret) {
-	case 0:
-		break;
+	if (ret) {
+		pr_debug("kernel signature verification failed (%d).\n", ret);
 
-		/* Certain verification errors are non-fatal if we're not
-		 * checking errors, provided we aren't mandating that there
-		 * must be a valid signature.
-		 */
-	case -ENODATA:
-		reason = "kexec of unsigned image";
-		goto decide;
-	case -ENOPKG:
-		reason = "kexec of image with unsupported crypto";
-		goto decide;
-	case -ENOKEY:
-		reason = "kexec of image with unavailable key";
-	decide:
-		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
-			pr_notice("%s rejected\n", reason);
+		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE))
 			return ret;
-		}
 
-		/* If IMA is guaranteed to appraise a signature on the kexec
+		/*
+		 * If IMA is guaranteed to appraise a signature on the kexec
 		 * image, permit it even if the kernel is otherwise locked
 		 * down.
 		 */
 		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
 		    security_locked_down(LOCKDOWN_KEXEC))
 			return -EPERM;
-
-		return 0;
-
-		/* All other errors are fatal, including nomem, unparseable
-		 * signatures and signature check failures - even if signatures
-		 * aren't required.
-		 */
-	default:
-		pr_notice("kernel signature verification failed (%d).\n", ret);
 	}
 
-	return ret;
+	return 0;
 }
 #endif
 
-- 
2.17.1

