Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF819C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88216207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HheB+LyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFPWg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgFPWg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:36:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:36:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a188so230478ybg.20
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cHSpMAjXfyGfwJeb9KkrKwdJRoh7Aq/xdZj4zd+a3E4=;
        b=HheB+LyCA6QLhPuMgTXI9D4bM/sjHW46HrcniylyQpWYVvVz0VvbgMrMwmtT/VTMSn
         ozdxEbd4FiuD1Vz2/vxIo70UD+65D7QAeN3ds6hUUgEgYyIkK+Pj1QgwXUx6QytmEvLt
         DT+PNGSewXZi9ezwE2rkJRb3fvvRV8MpWXByslv2PBIba6elzAF0EoAUwGexIfUqUksw
         3PAPYtIzAHEWJ0hrQcDp9/La/txp56hLNX0CufNivY+1H9y093X05ti4+rGg08OsiWEK
         rUbmcjGkW8rDJ/PCllYvS/jtXtiMv2tSdKhTcN9BDVdfFlEaABGDXNcskFfD6tY/O02Q
         4fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cHSpMAjXfyGfwJeb9KkrKwdJRoh7Aq/xdZj4zd+a3E4=;
        b=JXbQejI+DOjVvlVyBGRRgumUAg8UDxeJvNMGcbe8cKsp8LvegMKdmhhGey/fYtsAAv
         Qf7DrMQi8KY41qULizddERo4GGKUCZxciLF2WJpgsnLKC1ayMrKxlDM1cZrgc89v7Ps7
         xk+eK8pkNCGnadKPv+DowYtQWnFBUYtkBhxXT1Mj6kdWSJ1zNIB30v4T0a0VAO5zkG9L
         vj+U4vyoolAVVjw7kfKcQGUBhwoL3xa7pGW1ZZvK6RWg+KdPpbFO/SyPGLVGa9j7xqNm
         qm04f8Zf2YXsdewksC03ZXpNTuCtOHWm7en5XoxalHsrxIp3ZubF5F7EoAwTpcGNw91k
         w+7w==
X-Gm-Message-State: AOAM531gm6wsTzXQGkiiPtY4bHekNSqDhfsGK45eh9DYE4k00FHoeLEc
        SifE8+ZdItsnxyUr+EWB0znIq7DysQ==
X-Google-Smtp-Source: ABdhPJz97JiuiNeTxt8V2AAsnvn1Ge3fjw/Spk4/6TFwHd5hb2O+4+a0e1D7100P4MNwrcg15aJ7cqhRsA==
X-Received: by 2002:a25:d8cd:: with SMTP id p196mr8176207ybg.55.1592347012784;
 Tue, 16 Jun 2020 15:36:52 -0700 (PDT)
Date:   Tue, 16 Jun 2020 22:36:33 +0000
Message-Id: <20200616223633.73971-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] Fix unwind_frame for clang-built kernels
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux@armlinux.org.uk, vincent.whitchurch@axis.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since clang does not push pc and sp in function prologues, the current
implementation of unwind_frame does not work. By using the previous
frame's lr/fp instead of saved pc/sp we get valid unwinds on clang-built
kernels.

The bounds check on next frame pointer must be changed as well since
there are 8 less bytes between frames.

This fixes /proc/<pid>/stack.

Link: https://github.com/ClangBuiltLinux/linux/issues/912
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/arm/kernel/stacktrace.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index cc726afea023..76ea4178a55c 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -22,6 +22,19 @@
  * A simple function epilogue looks like this:
  *	ldm	sp, {fp, sp, pc}
  *
+ * When compiled with clang, pc and sp are not pushed. A simple function
+ * prologue looks like this when built with clang:
+ *
+ *	stmdb	{..., fp, lr}
+ *	add	fp, sp, #x
+ *	sub	sp, sp, #y
+ *
+ * A simple function epilogue looks like this when built with clang:
+ *
+ *	sub	sp, fp, #x
+ *	ldm	{..., fp, pc}
+ *
+ *
  * Note that with framepointer enabled, even the leaf functions have the same
  * prologue and epilogue, therefore we can ignore the LR value in this case.
  */
@@ -34,6 +47,16 @@ int notrace unwind_frame(struct stackframe *frame)
 	low = frame->sp;
 	high = ALIGN(low, THREAD_SIZE);
 
+#ifdef CONFIG_CC_IS_CLANG
+	/* check current frame pointer is within bounds */
+	if (fp < low + 4 || fp > high - 4)
+		return -EINVAL;
+
+	frame->sp = frame->fp;
+	frame->fp = *(unsigned long *)(fp);
+	frame->pc = frame->lr;
+	frame->lr = *(unsigned long *)(fp + 4);
+#else
 	/* check current frame pointer is within bounds */
 	if (fp < low + 12 || fp > high - 4)
 		return -EINVAL;
@@ -42,6 +65,7 @@ int notrace unwind_frame(struct stackframe *frame)
 	frame->fp = *(unsigned long *)(fp - 12);
 	frame->sp = *(unsigned long *)(fp - 8);
 	frame->pc = *(unsigned long *)(fp - 4);
+#endif
 
 	return 0;
 }
-- 
2.27.0.290.gba653c62da-goog

