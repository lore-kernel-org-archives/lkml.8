Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBD9C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8DB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io1tk0Tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgEKV7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:59:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50838 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727835AbgEKV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589234351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lG05Rn0O+ELWikk9dZBI+YfJaiuIbJQEERVy0w4Y7tg=;
        b=io1tk0TqFvFfIqkf3VjPVBy76av9HQaTz/R20worBO71xUArtKBOw11pEDzURhOc6OYC9e
        VU0aULnO3adoEZLVohKDwbavWQrP5Snq1zvljkg+NdaX7lL+0h03baycSo5umPcVdU8LbH
        leYFOSU2GnerONzdOLU2NzK8HhExQrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-igxqb0uCNjCy1dgbOX5KDw-1; Mon, 11 May 2020 17:59:10 -0400
X-MC-Unique: igxqb0uCNjCy1dgbOX5KDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED3E281C9A7;
        Mon, 11 May 2020 21:59:08 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C18638DE2;
        Mon, 11 May 2020 21:59:07 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com
Subject: [PATCH] kernel: sysctl: ignore invalid taint bits introduced via kernel.tainted and taint the kernel with TAINT_USER on writes
Date:   Mon, 11 May 2020 17:59:04 -0400
Message-Id: <20200511215904.719257-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysctl knob allows any user with SYS_ADMIN capability to
taint the kernel with any arbitrary value, but this might
produce an invalid flags bitset being committed to tainted_mask.

This patch introduces a simple way for proc_taint() to ignore
any eventual invalid bit coming from the user input before
committing those bits to the kernel tainted_mask, as well as
it makes clear use of TAINT_USER flag to mark the kernel
tainted by user everytime a taint value is written
to the kernel.tainted sysctl.

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 kernel/sysctl.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..f0a4fb38ac62 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2623,17 +2623,32 @@ static int proc_taint(struct ctl_table *table, int write,
 		return err;
 
 	if (write) {
+		int i;
+
+		/*
+		 * Ignore user input that would make us committing
+		 * arbitrary invalid TAINT flags in the loop below.
+		 */
+		tmptaint &= (1UL << TAINT_FLAGS_COUNT) - 1;
+
 		/*
 		 * Poor man's atomic or. Not worth adding a primitive
 		 * to everyone's atomic.h for this
 		 */
-		int i;
 		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
 			if ((tmptaint >> i) & 1)
 				add_taint(i, LOCKDEP_STILL_OK);
 		}
+
+		/*
+		 * Users with SYS_ADMIN capability can include any arbitrary
+		 * taint flag by writing to this interface. If that's the case,
+		 * we also need to mark the kernel "tainted by user".
+		 */
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
 
+
 	return err;
 }
 
-- 
2.25.4

