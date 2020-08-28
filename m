Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF702C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DFB20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLYQM+vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgH1Lft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbgH1Ld1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:33:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C359C061233
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:32:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g1so316573pgm.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sJlJAZsPRsD+xt0Gc+U8XLwW9T9mmZah5YOzeNxtWsw=;
        b=uLYQM+vka2RYRGHsi4U4RPVXWSwQT64Ppm672AWI6TdxMES7oeAOuyYlyXLS5GP0Dw
         /CRL5j0DcH8Alr1MKSZZIByH9Tw1K3SLiAPyb8r+vfZHlJ6Kre1472BCZkWsCb7OhhKz
         suR4BdACHkLBSAFp7mTZxp/bAQ61zlm2Uj6evqvaY6NeIKXjqiPytAGo5Hq+jID/tc+I
         lfU2csEiwNa8sHYqTK1aB9nh8fnGyF/4axHmk8jTRvjYdH0gdtNpeKb2Q74dMF+if8DE
         9rTfqd+skkNnsWm9DAOfU4MP21N9/GXak5E9sAGbhvFWQBLYbH0PQBMqMu5ZbYezi+x4
         NI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sJlJAZsPRsD+xt0Gc+U8XLwW9T9mmZah5YOzeNxtWsw=;
        b=LOXO8M8/32sFdC+C486TI7yiUzj1+0kWPBxsrN+CypzMTClaky2TPG0RobI8g7wKv5
         Kx9MLJmAYO/ZWzSuN+M/YP73jy/CYGeTAboeVHtRNj45/4UOEKqvzjiu0wnsj7UE6q4l
         sKE3Qe0ZfoS90vONkR3mhlkqe3vG3hB6qKoKvPcQx7N4hhFyYCVJvchGKxAPJqK76iGw
         zh2+B727cgLiA42Jx2xgnDFn0lKkl0uVtY4hh1aPGbaeaFQxvk3++cpI6c3m/AN72Kcn
         dH04zhfWIdqiIlQhj0AV5jIohPR0ziflyUdOxjceQK6W/7PuqBC3gqTuFl85ANILVYxw
         Emaw==
X-Gm-Message-State: AOAM530GkKI5xuuGzLoAe7Rt7PAbJ1cJ4JJ5WbRTaT/LZJiEKXTjUfbt
        Ks0Moa7iYCX4m2FrBR3S0LY=
X-Google-Smtp-Source: ABdhPJxKmkf+J/hlM82diV7dv+qCAjQqm8Iz8p0rYb0Kow+MfjgaWD3fHOVXXswU/IrjgWfNN/qwVA==
X-Received: by 2002:a63:4246:: with SMTP id p67mr938773pga.110.1598614373289;
        Fri, 28 Aug 2020 04:32:53 -0700 (PDT)
Received: from cosmos ([103.113.142.250])
        by smtp.gmail.com with ESMTPSA id q71sm1158750pja.9.2020.08.28.04.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 04:32:52 -0700 (PDT)
Date:   Fri, 28 Aug 2020 17:02:46 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     mhiramat@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        davem@davemloft.net, oleg@redhat.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes, x86/ptrace.h: fix regs argument order for i386
Message-ID: <20200828113242.GA1424@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, the order of parameters passed on regs is eax,edx,and ecx
(as per regparm(3) calling conventions).

Change the mapping in regs_get_kernel_argument(), so that arg1=ax
arg2=dx, and arg3=cx.

Running the selftests testcase kprobes_args_use.tc shows the result
as passed.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 arch/x86/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 40aa69d..d8324a2 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -327,8 +327,8 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 	static const unsigned int argument_offs[] = {
 #ifdef __i386__
 		offsetof(struct pt_regs, ax),
-		offsetof(struct pt_regs, cx),
 		offsetof(struct pt_regs, dx),
+		offsetof(struct pt_regs, cx),
 #define NR_REG_ARGUMENTS 3
 #else
 		offsetof(struct pt_regs, di),
-- 
2.7.4

