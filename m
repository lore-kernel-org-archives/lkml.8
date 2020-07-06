Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A7920663
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iqizygs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgGFS1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbgGFS1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:27:24 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33950C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:27:24 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id d185so9741761oia.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qqoupK5Oq6XKew6i6oyqJ6+pHqm95p/dfVqnR40LUaA=;
        b=Iqizygs0Qd97GZDMVr5MpvwQmOfgjGa2UIYaRHiioHiJ0vLDD6W8swj+li7Hr5Svhx
         LO9/lPvsugaN0/6egSTnXgsy1EAyz4KJfFrZkFR3QfG5BCtd18pLxBtTzFA1CaLlqbCt
         jEQOGwpkEXPy06MIkntvurVJNu6a9JgL7UByfxIbHsVXnoEyOJIeT8aFVonyvm+CJ3aZ
         t+s1JZPyorXK4j2tSOLwFoLeEu6MA/Z9EYSoxsjont9Q0X1H4GaAcgtCMEvAPlLLJEuw
         RZuxLdkZO/u32IzVhZf6kw4qro5XTFTAe+CI7wDg0ODIHGUzHlAtbeIzRiLNK2m11JyB
         V8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qqoupK5Oq6XKew6i6oyqJ6+pHqm95p/dfVqnR40LUaA=;
        b=ASIebniY9fSj6XVPGGmxvTyzrvvLgsmqFIxWe+xl6jy01YVs0LkHg12HjkHPd0ipdo
         HiuLGQoK39Bz8nfAvLb62rMOmmyVcNjGisayG+J4KaM1MoC/1oDkWBhTCZYMxTO0V0Vf
         Hgkm+L5dG+bg5mApGKjijsMq5+yUNKxVBgTh7HSJR0HtlCkcJos0Cz5VPZvA1ZmC+IA4
         xQGKLjCLVrFQty8b7xfMvAy7StKyKup6jLvlRxjABn9RU8PXm1bIubH9/XAsBIiEf77k
         qp45OHa91KWc6sCZZGhzwpenQZC0c34k4anfTqC5di4zrz55yF257O1FC+hcXk5j1Hc4
         PoXA==
X-Gm-Message-State: AOAM530H0PldT4Ykm+Pmlfm5fLmF1OtvWqEWuay/2yy7ovs+/huU0Brj
        3fZVMfLFBYhjy+fd3cj0M/TAF7oXDg==
X-Google-Smtp-Source: ABdhPJyWVGryZT5XObBbMQLsdgzLLnVckhY0wPAFG2dfmer9W5MvZSPtNAV1kDIPh+YBKZzAr3C5UarrWg==
X-Received: by 2002:aca:c683:: with SMTP id w125mr443202oif.37.1594060043510;
 Mon, 06 Jul 2020 11:27:23 -0700 (PDT)
Date:   Mon,  6 Jul 2020 18:27:13 +0000
In-Reply-To: <1592531704.23014.1.camel@mtkswgap22>
Message-Id: <20200706182713.3693762-1-nhuck@google.com>
Mime-Version: 1.0
References: <1592531704.23014.1.camel@mtkswgap22>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2] ARM: stacktrace: Fix unwind_frame for clang-built kernels
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux@armlinux.org.uk, vincent.whitchurch@axis.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Huckleberry <nhuck@google.com>,
        Miles Chen <miles.chen@mediatek.com>, stable@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
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
Reported-by: Miles Chen <miles.chen@mediatek.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
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
2.27.0.212.ge8ba1cc988-goog

