Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C64C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BC322CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="sI+hqjvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHECBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHECBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:01:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078A1C061757
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 19:01:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so3651033pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 19:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=kJcpV3FFFfsD2l55JahUfRW8uq2TSc6p0u2YdLtfElo=;
        b=sI+hqjvRrwWh582aNgQiqkG2hjMhJaMuduojBE29+CtdYVAKWZMeahFLnr+VsDAHDj
         xyXqs7tqdRfi2Ie4zFfZwIWY0i7jezrHbCxDvha1AVTrngUAe19Io2J2+OWApT93in/d
         4WVezYpqJOdMNKiL/Us16O0iLMBd2B4ewCuxjm/2PTNeaK2vcXTRFYrVMAiBmcFgFA0F
         Kd9QWJtrcYnsW3U+3Aq301UK+FyWwT5xuqfy+Qn3QTMip8DBK20tP7at0G4UuyI5bYYJ
         TaQhgyLoYB5IJ7LViGAHAYVNPbDKMRYgAMAQAmA6+AVYh8rl4vltO0+OKUTSF80tZEIx
         KsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=kJcpV3FFFfsD2l55JahUfRW8uq2TSc6p0u2YdLtfElo=;
        b=M8X4qZoSaxHGih9q3prhZQWnwFZwLL/kMMC1m4fm2UR+YXEacpKwJCWT2mYAV7UF+y
         kyVFU4nwgw4xMtRq+2cguoMXNA6bc7Y05jv8QOxiKNTTk0jPxdeFshT/d03WZWXAUmdg
         xLkxynEr8nf3zPehX9r4iqQclRKOAvWTbydoiDn2hf12VKGEscNoKVHNwp/yGqU2PMpr
         8kj6SyFIBoYXiQoJ0sTaJ+xh7/9lR9imMEaq9D2tfHfbmruNfQj364TEuhIeM137Vsft
         rzomPqkBFXuIHqQTH+N9W4KtLujfKp1iVdE/uzx3vtuBxUnaHsg9TJGX4WrnkyWmG0gi
         Cvaw==
X-Gm-Message-State: AOAM5323e8u5qATMJfv2dFy26EQfkazuwEB69s5Lqofu9QRe4+YlzxLp
        3AxNTQjDl7iVBoxyPnhEtfhy2A==
X-Google-Smtp-Source: ABdhPJxf9Ivj52yHuPOhnrAktIWy7INuXCJ1yMVqmLgBHLBpNMK7tJiwnUKeTzthHlO7ATskrL+cbg==
X-Received: by 2002:a17:90a:ff85:: with SMTP id hf5mr934567pjb.79.1596592863295;
        Tue, 04 Aug 2020 19:01:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t11sm541305pjo.41.2020.08.04.19.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 19:01:02 -0700 (PDT)
Date:   Tue, 04 Aug 2020 19:01:02 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Aug 2020 19:00:52 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: ptrace: Improve the style in NT_PRFPREG regset handling
In-Reply-To: <alpine.DEB.2.20.2007232216420.4462@tpp.orcam.me.uk>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     macro@wdc.com
Message-ID: <mhng-eba72823-400f-40a2-b76a-4132385840bd@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 16:22:30 PDT (-0700), macro@wdc.com wrote:
> Use an auxiliary variable for the size taken by floating point general
> registers in `struct __riscv_d_ext_state' to improve the readability of
> code in the `riscv_fpr_get' and `riscv_fpr_set' handlers, by avoiding
> excessive line wrapping and extending beyond 80 columns.  Also shuffle
> local variables in the reverse Christmas tree order.  No functional
> change.
>
> Signed-off-by: Maciej W. Rozycki <macro@wdc.com>
> ---
>  arch/riscv/kernel/ptrace.c |   24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> linux-riscv-ptrace-fpr-style.diff
> Index: linux-hv/arch/riscv/kernel/ptrace.c
> ===================================================================
> --- linux-hv.orig/arch/riscv/kernel/ptrace.c
> +++ linux-hv/arch/riscv/kernel/ptrace.c
> @@ -58,18 +58,16 @@ static int riscv_fpr_get(struct task_str
>  			 unsigned int pos, unsigned int count,
>  			 void *kbuf, void __user *ubuf)
>  {
> -	int ret;
> +	const size_t fgr_size = offsetof(struct __riscv_d_ext_state, fcsr);
>  	struct __riscv_d_ext_state *fstate = &target->thread.fstate;
> +	int ret;
>
>  	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fstate->f, 0,
> -				  offsetof(struct __riscv_d_ext_state, fcsr));
> +				  fgr_size);
>  	if (!ret) {
>  		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -					  &fstate->fcsr,
> -					  offsetof(struct __riscv_d_ext_state,
> -						   fcsr),
> -					  offsetof(struct __riscv_d_ext_state, fcsr) +
> -					  sizeof(fstate->fcsr));
> +					  &fstate->fcsr, fgr_size,
> +					  fgr_size + sizeof(fstate->fcsr));
>  	}
>
>  	return ret;
> @@ -80,18 +78,16 @@ static int riscv_fpr_set(struct task_str
>  			 unsigned int pos, unsigned int count,
>  			 const void *kbuf, const void __user *ubuf)
>  {
> -	int ret;
> +	const size_t fgr_size = offsetof(struct __riscv_d_ext_state, fcsr);
>  	struct __riscv_d_ext_state *fstate = &target->thread.fstate;
> +	int ret;
>
>  	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fstate->f, 0,
> -				 offsetof(struct __riscv_d_ext_state, fcsr));
> +				 fgr_size);
>  	if (!ret) {
>  		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> -					 &fstate->fcsr,
> -					 offsetof(struct __riscv_d_ext_state,
> -						  fcsr),
> -					 offsetof(struct __riscv_d_ext_state, fcsr) +
> -					 sizeof(fstate->fcsr));
> +					 &fstate->fcsr, fgr_size,
> +					 fgr_size + sizeof(fstate->fcsr));
>  	}
>
>  	return ret;

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

(Though the comments in the first patch apply here)

Thanks!
