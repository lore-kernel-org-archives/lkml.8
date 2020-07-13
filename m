Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98346C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733D0206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594638816;
	bh=7BFyTGq3T0n6nBXIHCozsdRHsTRy1plXleZ3pU9J3FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QW1+H/OWctwDhWYEo2qvbchX2V+CrruQsZjXHMnPawzgVhigFaEpG0fpiEB8Fz07H
	 PVmtZjAYzcI+YXSkb9GA1zpZaN5+cPV61AvKA2aRqGzn62Rz6tgUdhRlNJRO+hVeAy
	 4LQODG7BJXcJCym0SHW5LlS9RwwHO8gaevMxkcIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgGMLNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:13:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51426 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgGMLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:13:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so12916741wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+bQksqtMBYbc7jVH6wFxH9Kq69FFLyptC26npBtvTYE=;
        b=c6BXBtSCUk5sXLw2Cerm68nl9u+hBlMGBS2cMbre0b9nZlneqLJLtHKt0YcWqXyX6L
         ZI0qhUNLq6Eze/B1/O8DoTdo04a2Wx46lcJzh6cJRS2s0fzZPO2hF7wEy6RwyhXyYU1p
         SLr6YBcAe4eLLo09AR6+B9s2x25b49ZD3BWPdhGDxCyJ8DstkrHe62K3xS63Qe6mFzSt
         zpTSW2hP2Qs3IrgPkSLwdrVctLUhLCz5gDIhTS3XuOyydxRRRTUReXQSBXZFCyfSUJcN
         yzcubI8ICLc6IK1wIEc+6XQsga+6zxpMKtKwTMK7/Hv16gKV/tqP0dXnvUtECNxJ7laj
         2uaw==
X-Gm-Message-State: AOAM530zEAnHyFPuOT7cppc8Uzbo0KdoZPwkrjIVHaZlheDOcE0m83q5
        vgoL33vls5FbskSlkZxbYQ0=
X-Google-Smtp-Source: ABdhPJzWXopo/Sru6lHx3SGvFcTn4aXBvxRIt/ZcYPWrpJFvBJ2uWxnYCij8nXsMhKMfeG85kWxwpQ==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr19002816wmc.45.1594638811968;
        Mon, 13 Jul 2020 04:13:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s15sm21310898wmj.41.2020.07.13.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:13:31 -0700 (PDT)
Date:   Mon, 13 Jul 2020 11:13:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] x86/entry: Fix vectors to IDTENTRY_SYSVEC for
 CONFIG_HYPERV
Message-ID: <20200713111330.kpppbjbjwwij2rgq@liuwe-devbox-debian-v2>
References: <20200712231050.5147-1-sedat.dilek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712231050.5147-1-sedat.dilek@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:10:50AM +0200, Sedat Dilek wrote:
> When using Clang's Integrated Assembler (LLVM_IAS=1) we fell over
> ClangBuiltLinux (CBL) issue #1043 where Jian Cai provided a fix.
> 
> With Jian's fix applied another issue raised up when CONFIG_HYPERV=m.
> 
> It turned out that the conversion of vectors to IDTENTRY_SYSVEC in
> case of CONFIG_HYPERV was incomplete and fails with a build error:
> 
> <instantiation>:9:6: error: expected absolute expression
>  .if HYPERVISOR_REENLIGHTENMENT_VECTOR == 3
>      ^
> <instantiation>:1:1: note: while in macro instantiation
> idtentry HYPERVISOR_REENLIGHTENMENT_VECTOR asm_sysvec_hyperv_reenlightenment sysvec_hyperv_reenlightenment has_error_code=0
> ^
> ./arch/x86/include/asm/idtentry.h:627:1: note: while in macro instantiation
> idtentry_sysvec HYPERVISOR_REENLIGHTENMENT_VECTOR sysvec_hyperv_reenlightenment;
> ^
> <instantiation>:9:6: error: expected absolute expression
>  .if HYPERVISOR_STIMER0_VECTOR == 3
>      ^
> <instantiation>:1:1: note: while in macro instantiation
> idtentry HYPERVISOR_STIMER0_VECTOR asm_sysvec_hyperv_stimer0 sysvec_hyperv_stimer0 has_error_code=0
> ^
> ./arch/x86/include/asm/idtentry.h:628:1: note: while in macro instantiation
> idtentry_sysvec HYPERVISOR_STIMER0_VECTOR sysvec_hyperv_stimer0;

Hmm... Interesting. GCC never complained. Guests are perhaps broken in a
rather subtle way.

> 
> I and Nathan double-checked the hyperv(isor) vectors:
> 
> $ rg --no-heading "HYPERVISOR_REENLIGHTENMENT_VECTOR|HYPERVISOR_STIMER0_VECTOR"
> $ rg --no-heading "HYPERV_REENLIGHTENMENT_VECTOR|HYPERV_STIMER0_VECTOR"
> 
> Fix these typos in arch/x86/include/asm/idtentry.h:
> 
> HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
> HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR
> 
> For more details see CBL issue #1088.
> 
> With both fixes applied I was able to build/assemble with a snapshot
> version of LLVM/Clang from Debian/experimental.

I think the issue found here is independent of the other. This patch
shouldn't need to wait for the other to land.

> 
> Cc: Jian Cai <caij2003@gmail.com>
> Cc: clang-built-linux@googlegroups.com
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> Link: https://github.com/ClangBuiltLinux/linux/issues/1088
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  arch/x86/include/asm/idtentry.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 513eb2ccbdbf..a811f6c6cf15 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -624,8 +624,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
> -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
> -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);

Reviewed-by: Wei Liu <wei.liu@kernel.org>

Thomas, can you pick this up for 5.8? Thanks.

Wei.
