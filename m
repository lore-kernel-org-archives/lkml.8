Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6525720768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrphKBtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgHKLTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:19:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728663AbgHKLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597144789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/b3MlPnS2fuBzmiz0g+4SKXMuO51LxW4Hm59pIWy/s=;
        b=JrphKBtE+mCM54WnO6U2ii+LNIMoAGvcVEodfM3mMAlO4WKqh1bEOwkEZSXq6LPW/7ZN80
        uZJrvJHM6zw6YfiujOJIQsxjIy5CGCZslPmjVtUy9ef8oLlEgKNZDUg/WK8LRM/5FbzeLy
        CBH7h9vUUjnVXjnHXQgglNNyKS5TfpY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-JlRBKp6ePPSKYeLhUDku4g-1; Tue, 11 Aug 2020 07:19:47 -0400
X-MC-Unique: JlRBKp6ePPSKYeLhUDku4g-1
Received: by mail-wm1-f70.google.com with SMTP id g72so856801wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/b3MlPnS2fuBzmiz0g+4SKXMuO51LxW4Hm59pIWy/s=;
        b=NR4QP/pIL/o8jK9bhSv71BG9/X2E5Yu8y3cZ7YyZKHqfAxrqGPTkdN8+Mw5HVQNodb
         WnACeaHXYVgvKBXQWVquWhSOnhzpi0CVwElIW0ptjC2/nFxVgBU+7BTUGmhhMOMB3LWr
         fvTdl1Fjysu26VIXl/37LbHzmSHTP/HhsBApryMzFYmKnhmIMnZs6EaaOPrUXAEMIHVM
         86PlzIP6YSVNBrRDeQF/oSAGZfgSculv36lsXCW2t1vGo/MThxSFiN1Lxz2eeyRu1lfV
         3lDeu4nE0QPikvEA2R76WrnQUpOufcU8a/ZHJt9GBhKRxPI2RK72n0gIXSYVQaHxbb1P
         d7sQ==
X-Gm-Message-State: AOAM530SN4t1eCWIji4EvzvbZCUHgYy0vqb72sRspbdhn7u5TwCKvqIS
        AFJfbIabRXOF0TBORNoqNTeka+U9mNamQK7Ir2cWQbmweXapIOmLtOM+V4cHKL5ML+OenydB3td
        shUoxKKqGipbcbWfnn6fMxUba
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr3679295wmk.145.1597144786097;
        Tue, 11 Aug 2020 04:19:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycs8UIHN4QlqH2I4HQWZaGHCNRAKLSrQG2kEthrAyxd1vyOM7wNG5kQKcp+EWkaj8Ozb+JXQ==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr3679278wmk.145.1597144785885;
        Tue, 11 Aug 2020 04:19:45 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.12.249])
        by smtp.gmail.com with ESMTPSA id d11sm26253533wrw.77.2020.08.11.04.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 04:19:45 -0700 (PDT)
Subject: Re: [PATCH RESEND] KVM: MIPS/VZ: Fix build error caused by 'kvm_run'
 cleanup
To:     Xingxing Su <suxingxing@loongson.cn>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc:     kvm@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1597138297-2105-1-git-send-email-suxingxing@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbbd9ca6-431a-26be-a9c9-18b7e6ce363c@redhat.com>
Date:   Tue, 11 Aug 2020 13:19:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1597138297-2105-1-git-send-email-suxingxing@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/20 11:31, Xingxing Su wrote:
> Commit c34b26b98caca48ec9ee9 ("KVM: MIPS: clean up redundant 'kvm_run'
> parameters") remove the 'kvm_run' parameter in kvm_vz_gpsi_lwc2.
> 
> The following build error:
> 
> arch/mips/kvm/vz.c: In function Ã¢â‚¬Ëœkvm_trap_vz_handle_gpsiÃ¢â‚¬â„¢:
> arch/mips/kvm/vz.c:1243:43: error: Ã¢â‚¬ËœrunÃ¢â‚¬â„¢ undeclared (first use in this function)
>    er = kvm_vz_gpsi_lwc2(inst, opc, cause, run, vcpu);
>                                            ^~~
> arch/mips/kvm/vz.c:1243:43: note: each undeclared identifier is reported only 
> once for each function it appears in
> scripts/Makefile.build:283: recipe for target 'arch/mips/kvm/vz.o' failed
> make[2]: *** [arch/mips/kvm/vz.o] Error 1
> scripts/Makefile.build:500: recipe for target 'arch/mips/kvm' failed
> make[1]: *** [arch/mips/kvm] Error 2
> Makefile:1785: recipe for target 'arch/mips' failed
> make: *** [arch/mips] Error 2
> 
> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
> ---
>  +cc Paolo Bonzini <pbonzini@redhat.com> and kvm@vger.kernel.org.
> 
>  arch/mips/kvm/vz.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
> index 3932f76..49c6a2a 100644
> --- a/arch/mips/kvm/vz.c
> +++ b/arch/mips/kvm/vz.c
> @@ -1142,7 +1142,6 @@ static enum emulation_result kvm_vz_gpsi_cache(union mips_instruction inst,
>  #ifdef CONFIG_CPU_LOONGSON64
>  static enum emulation_result kvm_vz_gpsi_lwc2(union mips_instruction inst,
>  					      u32 *opc, u32 cause,
> -					      struct kvm_run *run,
>  					      struct kvm_vcpu *vcpu)
>  {
>  	unsigned int rs, rd;
> @@ -1240,7 +1239,7 @@ static enum emulation_result kvm_trap_vz_handle_gpsi(u32 cause, u32 *opc,
>  #endif
>  #ifdef CONFIG_CPU_LOONGSON64
>  	case lwc2_op:
> -		er = kvm_vz_gpsi_lwc2(inst, opc, cause, run, vcpu);
> +		er = kvm_vz_gpsi_lwc2(inst, opc, cause, vcpu);
>  		break;
>  #endif
>  	case spec3_op:
> 

Queued, thanks.

Paolo

