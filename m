Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55151C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 04:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2628D2078B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 04:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="zYRoi4VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgEXEib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 00:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEXEia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 00:38:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92204C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 21:38:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id er16so6711661qvb.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+fnQ1L4MZVHDyySMrLvQ4yTq8ju47rHA9BsyU3/N81c=;
        b=zYRoi4VKK6bgQlFXVl+FQcITJXNKj8Jn/g2POzeRNJeqF2M3IMmaTlCSWdfjmIwZQ/
         VM5GRCweZa3Hpb12Bxf7HpLAa7SQidSvOVaMm9t3Hp9Ml23jndLpA1JNf5/v+AnMfy/c
         fJ7hkeNzZZoq19BSzGopfytIf82g55h0c0rxwDH3RwbqoaFPQIKAg+zNDANN9r32Nagn
         qX78orv1n7FrzFpeSHqI6lpCKiaJkOh0FNkMJhGw75IcFedJt0N0P57Jq41pksAhlvdb
         //5o5kOkkB9iRAiW+a2J7ODRrlqe3OO1A9jBJpANbQ/jlMH40yJM1UNZUIt2WBxKICUu
         5F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+fnQ1L4MZVHDyySMrLvQ4yTq8ju47rHA9BsyU3/N81c=;
        b=MbTrEqLPDFFEDU0PZwrt0XuoTIcVcPRqpW8139iZ5rWgXH+PrxrGw/5v5I2XvXfVAl
         nimxl4aqU/DXjXgL28C2f4M/KaFMANwNATJXX/Ysj4C0xwkIFie6Xjym0UdTH2MVEiLO
         63pXu4TGHNyj0B9LQANABNGDJ8H+fEVnruEXBa2PgwJm5mPki3Tqe7ZTbhF3HmguDdlD
         71KxdWh10wb7alpYelgCmPKKVIQEMyP+4lW1vpwMKi65p0DcY8LU0Yuhm2BoFDnJK7Po
         NGQ+IhWiVRKi6hmAiboOBkydsVxHRCwaqqmIJNOPWPMLY9aEys5OfPJ1bedk30hP5ooM
         o/8Q==
X-Gm-Message-State: AOAM531xyz/wlXgY1WPZ8MI1tN6e50FM7t1lo1B148dZh71tXXQIu9yu
        oojNBH0+vaRLlNBRWeb2sd3TPEbVU0U=
X-Google-Smtp-Source: ABdhPJwj5LmFx9xHLXq7ePBifECS8a1ivGjTNH8FdA2EAYUeQZ10YdRGzUeTqym64H2OMvVdQN/64A==
X-Received: by 2002:a05:6214:3e4:: with SMTP id cf4mr10587958qvb.33.1590295109524;
        Sat, 23 May 2020 21:38:29 -0700 (PDT)
Received: from juliacomputing.com ([2601:184:4780:3aef:9054:eb80:3431:1b34])
        by smtp.gmail.com with ESMTPSA id c197sm11523352qkg.133.2020.05.23.21.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 21:38:29 -0700 (PDT)
Date:   Sun, 24 May 2020 00:38:27 -0400
From:   Keno Fischer <keno@juliacomputing.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, oleg@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: ptrace: Fix PTRACE_SINGLESTEP into signal handler
Message-ID: <20200524043827.GA33001@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Executing PTRACE_SINGLESTEP at a signal stop is special. It
is supposed to step merely the signal setup work that the
kernel does, but not any instructions in user space. Since
not all architectures have the ability to generate a
single-step exception directly upon return from user-space,
there is a generic pseudo-single-step-stop that may be used
for this purpose (tracehook_signal_handler). Now, arm64 does
have the ability to generate single-step exceptions directly
upon return to userspace and was using this capability (rather
than the generic pseudo-trap) to obtain a similar effect. However,
there is actually a subtle difference that becomes noticeable
when the signal handler in question attempts to block SIGTRAP
(either because it is set in sa_mask, or because it is a handler
for SIGTRAP itself and SA_NODEFER is not set). In such a
situation, a real single step exception will cause the SIGTRAP
signal to be forcibly unblocked and the signal disposition
to be reset to SIG_DFL. The generic pseudo-single-step does
not suffer from this problem, because the SIGTRAP it delivers
is not real. The arm64 behavior is problematic, because a forced
reset of the signal disposition can be quite disruptive to the
userspace program. This patch brings the arm64 behavior in line
with the other major architectures by using the generic
pseudo-single-step-stop, avoiding the problematic interaction
with SIGTRAP masks.

Fixes: 2c020ed8 ("arm64: Signal handling support")
Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 arch/arm64/kernel/signal.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 339882db5a91..cf237ee9443b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -808,14 +808,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	 */
 	ret |= !valid_user_regs(&regs->user_regs, current);
 
-	/*
-	 * Fast forward the stepping logic so we step into the signal
-	 * handler.
-	 */
-	if (!ret)
-		user_fastforward_single_step(tsk);
-
-	signal_setup_done(ret, ksig, 0);
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
 /*
-- 
2.25.1

