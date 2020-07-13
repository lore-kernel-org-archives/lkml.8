Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A853FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786A520899
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOzwig1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgGMWX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgGMWRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:17:48 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AFC08C5E0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z63so13836930qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8mP0/ymvYdWX4Ld0g89D/EXAhNhPehRLoxYuTMnOItM=;
        b=eOzwig1MEKj6WwbUfNm+F7dSk4yDh93j3Yi6iCNKuIez0XT9IKb8IognTEJcIDtDr0
         gwZEBXqf840eO7XynL2UX+VvKkMZRa4gt2FxjpDgLMo/YCSRDUw/GSvt92R3s0hd1wEW
         ViPs7L4vuiTXlyXqNk3pq3JU72yKOs1X4fA5s0ha01KJpwR1Vc3xBRjO65kFkBGtjk1C
         ps6CB4c8OGM7zLzp4xykhq52kk1R+TFrYb7fEi/wrQsvrjYAsK296yNtgtsd28QdxSFu
         e+uHTJSywgRkgJ8ciRr0fGkpB9mqMDNLfsjRa2k4zEEaih+z7KvzjF0AJGHSslzHmgAy
         5YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8mP0/ymvYdWX4Ld0g89D/EXAhNhPehRLoxYuTMnOItM=;
        b=ceeTOJ00FcHt4r2pHoCY9cGUCWzanGd6EMSdRSJxyHzfUiU91AM8QEINRa95bxfGLx
         o69DxHodbM37C/17L8ATN9pAgv1REFUgKetgNYo5Y/ENEXhOEblBL/gCN85tvwkJqpO1
         0R/pq9pT5vyPKUBz0UHMA2dGyXZSxHk/L52a2sUwb5HBkRczu6REaXpmmKCCJsSYf5gh
         So0sPZVCympsn2BXQjTdhQnxbVo/3Cmu7OLwilFwZ7RfJakC63HuEUAOEBHhQ4CYe8PD
         9qsiB6cafC67ZHwBFO2tTIrjlYSQ8HoytoJnjTNsLY/cV/iREhEqdjQa0x/zFK4B3lrO
         6sWg==
X-Gm-Message-State: AOAM530Mvkg8VTRrMnsll8XwYwcMVAmbf3euB7xYOwqdOeWJUFTv5947
        2ioZjp9kwW2D/dW5g6j0Xlc=
X-Google-Smtp-Source: ABdhPJyued74AMBeYTSae/krqvjOPAeZcMvZFKgr1Ct9UOmmNgGEc/uOW+zkCn7kB3gbXBEg+NL36A==
X-Received: by 2002:a05:620a:24cc:: with SMTP id m12mr1779104qkn.318.1594678659036;
        Mon, 13 Jul 2020 15:17:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d14sm20694364qti.41.2020.07.13.15.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:17:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Jul 2020 18:17:36 -0400
To:     Jian Cai <caij2003@gmail.com>
Cc:     jiancai@google.com, ndesaulniers@google.com, manojgupta@google.com,
        sedat.dilek@gmail.com, Brian Gerst <brgerst@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86/entry: add compatibility with IAS
Message-ID: <20200713221736.GA1904448@rani.riverdale.lan>
References: <20200713012428.1039487-1-caij2003@gmail.com>
 <20200713213803.1274795-1-caij2003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713213803.1274795-1-caij2003@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:38:01PM -0700, Jian Cai wrote:
> Clang's integrated assembler does not allow symbols with non-absolute
> values to be reassigned. This patch allows the affected code to be
> compatible with IAS.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Jian Cai <caij2003@gmail.com>
> ---
>  arch/x86/include/asm/idtentry.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index f3d70830bf2a..7d22684eafdf 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -469,16 +469,15 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  	.align 8
>  SYM_CODE_START(irq_entries_start)
>      vector=FIRST_EXTERNAL_VECTOR
> -    pos = .
>      .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
> +0 :
>  	UNWIND_HINT_IRET_REGS

I know I had it this way, but I think it may be slightly safer to put
the label immediately after UNWIND_HINT_IRET_REGS instead of before,
just in case anyone adds a 0: inside that macro.
