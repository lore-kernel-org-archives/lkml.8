Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EBEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7998C21744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583392903;
	bh=HUqhpqkPwtD1SgCGWyg8TkWqxocPUgCFtxNvGFcrLM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mq2ktb5knOhFwI/gitF6couDaCrBiCdbt70BpLyk67hgRHHR/2Mc9+0nItWC/aB+m
	 eHmRlZJMRWHsEXz7r0E83SAsmp5UWyC73jOEuk9So7oMNJWtEnErAM82Hx8DDnxgRZ
	 pHXHEAfpql/h6i28qxdt4Cei8JLU2NHjZqNExQN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCEHVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEHVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:21:42 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16ACC2073B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Mar 2020 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583392901;
        bh=HUqhpqkPwtD1SgCGWyg8TkWqxocPUgCFtxNvGFcrLM0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BvS5CeEWR8hg+rvFq7sVoiQ+4W2bzp+ApQxpB+D+XJDapWIZBnfTPRPMKPsCpLTbS
         GxfEb8eTojWcyrGTfeV53N0Hxt7VqE9mtayKV/D7BEOVdNu+rRE/Whlc91QD0kkgOn
         z4ZM31HzHRtwOqxQHOaQO0vMQg9MsZnbu2chv/Kc=
Received: by mail-wr1-f43.google.com with SMTP id 6so223514wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:21:41 -0800 (PST)
X-Gm-Message-State: ANhLgQ2EQHwGkP/ki1rbXf+LFiWKF6/6/bNvxxDDZhmYa709gI22SM29
        nrk0odFQIosURSfm1TwqUXH07Hg0bn2GyK3wCBdVfg==
X-Google-Smtp-Source: ADFU+vvfuLeudqOLwTXeiLBbDJRZOudsOWwevSZk8iXl6R9OxpneeAisQmD0eVAGnlo8q20zeBM/k9dCM4ppbTGBGn8=
X-Received: by 2002:a5d:6051:: with SMTP id j17mr8472350wrt.151.1583392899556;
 Wed, 04 Mar 2020 23:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20200305052052.30757-1-masahiroy@kernel.org>
In-Reply-To: <20200305052052.30757-1-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Mar 2020 08:21:29 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9XSfA5BWBkecb4zjXMxk2rK+rE4Q3Z75v21o7X6_AKEw@mail.gmail.com>
Message-ID: <CAKv+Gu9XSfA5BWBkecb4zjXMxk2rK+rE4Q3Z75v21o7X6_AKEw@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: add efi-entry.o to targets instead of extra-$(CONFIG_EFI)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Torsten Duwe <duwe@lst.de>, James Morse <james.morse@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 06:21, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> efi-entry.o is built on demand for efi-entry.stub.o, so you do not have
> to repeat $(CONFIG_EFI) here. Adding it to 'targets' is enough.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>  arch/arm64/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index fc6488660f64..4e5b8ee31442 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -21,7 +21,7 @@ obj-y                 := debug-monitors.o entry.o irq.o fpsimd.o              \
>                            smp.o smp_spin_table.o topology.o smccc-call.o       \
>                            syscall.o
>
> -extra-$(CONFIG_EFI)                    := efi-entry.o
> +targets                        += efi-entry.o
>
>  OBJCOPYFLAGS := --prefix-symbols=__efistub_
>  $(obj)/%.stub.o: $(obj)/%.o FORCE
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
