Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777F8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F51B207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="lIe/aXUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgGWNfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgGWNfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:35:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DEEC0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:35:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n5so3113113pgf.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=cwVPi0Cn4h2WH4C8S19ASg8aJejy3Y+/nEhD+9llv+M=;
        b=lIe/aXUucMOPiz/OXbLJLoTNdmO8U6F//K4bpATeZ7Qvr1NHKFxbt/BidSit7gvdZ4
         jGbUgla6NmnrChfi+XoPbf8qsFRE6R0Xw5CmRO6x5C6GTWuHa8TRw6xIcbRAj9kMX5xC
         Opa8OYI/qeofN7ancNGl5hhstiUdnWZIkfLL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cwVPi0Cn4h2WH4C8S19ASg8aJejy3Y+/nEhD+9llv+M=;
        b=j3JMaeAmOyibfzUTdHtvTGrY3HyvHqghTyaQQWhstbkSENVm8tJONjZVV8UAk7IDme
         i/cEBM1IaGA3a3hQldcNU9E1eQ5xlSbuxTDZphNJlMBFGlV0flvrMuXZP3FHwovFUTzk
         z/MFCDWkqz7K1OF2/9sxvrPN6K+A78D6+fNwLhAwvPHzLCdTZoH2sij2XMO3P7LaK7UL
         lufuhkZr5naa2H402XsqQOy/JXlupTW9VeT9we7AClzgMbBVNj8Wqe4hcduliE08fjwZ
         jECn5IIDu22dCkmmlmSeMfQeJAnRcv3wzszPi1DJeRT/uA9VrIY+q5TW6T+4YSgwFmLG
         7szQ==
X-Gm-Message-State: AOAM5321ZJIU5wdQNCZJZDHSxP5zy6YygrlNu93Psk0XjwDxdTMe6DUJ
        S2uLWrCpHRJLyjmKF16HQ/lD1w==
X-Google-Smtp-Source: ABdhPJwpmaoVdBtL1TggEkAp2g7fzQLYdBpNl5qWeNK/pKx/DYAV+TaVosTRobJq28Geqe135bCZpw==
X-Received: by 2002:aa7:930b:: with SMTP id 11mr4359011pfj.320.1595511340121;
        Thu, 23 Jul 2020 06:35:40 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-8915-8b02-da60-7583.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:8915:8b02:da60:7583])
        by smtp.gmail.com with ESMTPSA id b82sm3064805pfb.215.2020.07.23.06.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 06:35:39 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com
Subject: Re: [PATCH 2/5] powerpc: Allow 4096 bytes of stack expansion for the signal frame
In-Reply-To: <20200703141327.1732550-2-mpe@ellerman.id.au>
References: <20200703141327.1732550-1-mpe@ellerman.id.au> <20200703141327.1732550-2-mpe@ellerman.id.au>
Date:   Thu, 23 Jul 2020 23:35:36 +1000
Message-ID: <87blk6tkuv.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Unfortunately, this patch doesn't completely solve the problem.

Trying the original reproducer, I'm still able to trigger the crash even
with this patch, although not 100% of the time. (If I turn ASLR off
outside of tmux it reliably crashes, if I turn ASLR off _inside_ of tmux
it reliably succeeds; all of this is on a serial console.)

./foo 1241000 & sleep 1; killall -USR1 foo; echo ok

If I add some debugging information, I see that I'm getting
address + 4096 = 7fffffed0fa0
gpr1 =           7fffffed1020

So address + 4096 is 0x80 bytes below the 4k window. I haven't been able
to figure out why, gdb gives me a NIP in __kernel_sigtramp_rt64 but I
don't know what to make of that.

Kind regards,
Daniel

P.S. I don't know what your policy on linking to kernel bugzilla is, but
if you want:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205183


> Reported-by: Tom Lane <tgl@sss.pgh.pa.us>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 641fc5f3d7dd..ed01329dd12b 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -274,7 +274,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  	/*
>  	 * N.B. The POWER/Open ABI allows programs to access up to
>  	 * 288 bytes below the stack pointer.
> -	 * The kernel signal delivery code writes up to about 1.5kB
> +	 * The kernel signal delivery code writes up to 4KB
>  	 * below the stack pointer (r1) before decrementing it.
>  	 * The exec code can write slightly over 640kB to the stack
>  	 * before setting the user r1.  Thus we allow the stack to
> @@ -299,7 +299,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  		 * between the last mapped region and the stack will
>  		 * expand the stack rather than segfaulting.
>  		 */
> -		if (address + 2048 >= uregs->gpr[1])
> +		if (address + 4096 >= uregs->gpr[1])
>  			return false;
>  
>  		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
> -- 
> 2.25.1
