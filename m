Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E724C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3D3206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZRY+X0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgELRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:47:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725938AbgELRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589305634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aTDE0AT5JEjaYvlv8ybgmqDXB2+aHsj7B8GrIzk2ub4=;
        b=aZRY+X0C/wf5xfF2cz2e0GADJgEF2TXBQ58gIE/4BQtKlhz2njEQV+ZrMKuidZPHaPk1qx
        4MHZPVtgOQenwJRW6BXjNLU66Dubbar+T0TpQOop9/DtpUP1Fd1fnECtCFtJcAicfIP1+A
        xiyvlzTt0wNc3m9/jaI9Zv7SQZ8IyUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-HQyPs03eOOy3ZbfrLxDFjQ-1; Tue, 12 May 2020 13:47:09 -0400
X-MC-Unique: HQyPs03eOOy3ZbfrLxDFjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6011918FE860;
        Tue, 12 May 2020 17:47:08 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 758925D9E5;
        Tue, 12 May 2020 17:47:06 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org
Cc:     keescook@chromium.org, akpm@linux-foundation.org,
        yzaikin@google.com, tytso@mit.edu
Subject: [PATCH] kernel: sysctl: ignore out-of-range taint bits introduced via kernel.tainted
Date:   Tue, 12 May 2020 13:46:53 -0400
Message-Id: <20200512174653.770506-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysctl knob allows users with SYS_ADMIN capability to
taint the kernel with any arbitrary value, but this might
produce an invalid flags bitset being committed to tainted_mask.

This patch introduces a simple way for proc_taint() to ignore
any eventual invalid bit coming from the user input before
committing those bits to the kernel tainted_mask.

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 include/linux/kernel.h |  2 ++
 kernel/sysctl.c        | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9b7a8d74a9d6..e8c22a9bbc95 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -597,6 +597,8 @@ extern enum system_states {
 #define TAINT_RANDSTRUCT		17
 #define TAINT_FLAGS_COUNT		18
 
+#define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
+
 struct taint_flag {
 	char c_true;	/* character printed when tainted */
 	char c_false;	/* character printed when not tainted */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..fb2d693fc08c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2623,11 +2623,23 @@ static int proc_taint(struct ctl_table *table, int write,
 		return err;
 
 	if (write) {
+		int i;
+
+		/*
+		 * Ignore user input that would cause the loop below
+		 * to commit arbitrary and out of valid range TAINT flags.
+		 */
+		if (tmptaint > TAINT_FLAGS_MAX) {
+			tmptaint &= TAINT_FLAGS_MAX;
+			pr_warn_once("%s: out-of-range taint input ignored."
+				     " tainted_mask adjusted to 0x%lx\n",
+				     __func__, tmptaint);
+		}
+
 		/*
 		 * Poor man's atomic or. Not worth adding a primitive
 		 * to everyone's atomic.h for this
 		 */
-		int i;
 		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
 			if ((tmptaint >> i) & 1)
 				add_taint(i, LOCKDEP_STILL_OK);
-- 
2.25.4

