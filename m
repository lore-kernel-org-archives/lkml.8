Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C26C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F420D20774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJ/o+2Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgHNWgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgHNWgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:36:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D604EC061388
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:36:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so5200350pgd.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1Gm4DBq2aKiHPSTyt1FIj1F/+D7DhQ4fc8VI2sz0rsI=;
        b=lJ/o+2Nt05U5e0lpQPxqMtSE2E7+/KYFBl+vbHoFZ2b2zxLWZnJaieenezGM3PFgTq
         WS2o0XYtew02RQO3Fd3ntzN3idtpMBg32SI8dHA0ztqWw69TIOjST2gfSC8jAUJorrTJ
         Yv9s0ID87nAT1oQeJlbkb94alXD2B7X3/r31NItPQ6CRyvJo3ldLKYRYnLfgcF4j8O1f
         dDNlzXtKLL+W5OA2dV8LS14ife/GCS6TNLWHktTsZnc7Qust4yLgCt2iMZUHD8FTMNMi
         9arAaxIiI44nVNEMtTQexxiWc4GxwcBIonig4orLKuXGeyBIHvx2FvE8ilEYTpWG8I5e
         a3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1Gm4DBq2aKiHPSTyt1FIj1F/+D7DhQ4fc8VI2sz0rsI=;
        b=bFWRhj6rdkdC610+WFgn5njCXhMtkIDq2V0LMXj5fbs/bWev3kl9S63MRLKOLWkRx5
         v/8EF9yVfeaMGZBQmdGV5dS9+tluuD/RzCJN2BB2AQM8fRK+hxtQ97vNK/cuBqhrPdys
         /6V4ckJ8TE5eIRR22IsdqC+Tak+08UnOMmJxJ2aaXTZnyOCELwJBt+vYRI4J6GCT/dHy
         iDtnkaTlEJleoFLjryHohhJCpPVgHNwfz/VphlsYMQhx6mNP1nzd6MR1KD5YL5vTu1M1
         6GlAxSFx21oXsyUl4KbyyJDg8t3MhzIgE3VU5wrdrNt47OElrZ3bcoUOnTCiDuq+NySA
         BP6g==
X-Gm-Message-State: AOAM531rcq0n82Wfi5T9GiWuv+UpoI0NpaTsQ1T4kUiRyuZPDsE6DJ9F
        rXMuxyd+0S865kIioAhXR6CGKw==
X-Google-Smtp-Source: ABdhPJxSggPlmWg3KIB8rUnjcpOCqr5iuQ37qtyRCNb+C/Wl89zCMHW8/n9UhEL046/uVKT0MxbZQQ==
X-Received: by 2002:a63:1e65:: with SMTP id p37mr3058000pgm.58.1597444567189;
        Fri, 14 Aug 2020 15:36:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w6sm8540368pgr.82.2020.08.14.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:36:06 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:36:06 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Aug 2020 15:34:49 PDT (-0700)
Subject:     Re: [PATCH v3 3/7] riscv: Fixup kprobes handler couldn't change pc
In-Reply-To: <1594683562-68149-4-git-send-email-guoren@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, mhiramat@kernel.org,
        oleg@redhat.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        linux-csky@vger.kernel.org, greentime.hu@sifive.com,
        zong.li@sifive.com, guoren@kernel.org, me@packi.ch,
        Bjorn Topel <bjorn.topel@gmail.com>, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-296dd63e-71de-4d30-acfb-df374d12388d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 16:39:18 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The "Changing Execution Path" section in the Documentation/kprobes.txt
> said:
>
> Since kprobes can probe into a running kernel code, it can change the
> register set, including instruction pointer.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/kernel/mcount-dyn.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index 35a6ed7..4b58b54 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -123,6 +123,7 @@ ENDPROC(ftrace_caller)
>  	sd	ra, (PT_SIZE_ON_STACK+8)(sp)
>  	addi	s0, sp, (PT_SIZE_ON_STACK+16)
>
> +	sd ra,  PT_EPC(sp)
>  	sd x1,  PT_RA(sp)
>  	sd x2,  PT_SP(sp)
>  	sd x3,  PT_GP(sp)

So that's definately not going to be EPC any more.  I'm not sure that field is
sanely named, though, as it's really just the PC when it comes to other ptrace
stuff.

> @@ -157,6 +158,7 @@ ENDPROC(ftrace_caller)
>  	.endm
>
>  	.macro RESTORE_ALL
> +	ld ra,  PT_EPC(sp)
>  	ld x1,  PT_RA(sp)

x1 is ra, so loading it twice doesn't seem reasonable.

>  	ld x2,  PT_SP(sp)
>  	ld x3,  PT_GP(sp)
> @@ -190,7 +192,6 @@ ENDPROC(ftrace_caller)
>  	ld x31, PT_T6(sp)
>
>  	ld	s0, (PT_SIZE_ON_STACK)(sp)
> -	ld	ra, (PT_SIZE_ON_STACK+8)(sp)
>  	addi	sp, sp, (PT_SIZE_ON_STACK+16)
>  	.endm

If you're dropping the load you should drop the store above as well.  In
general this seems kind of mixed up, both before and after this patch.
