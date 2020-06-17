Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B080FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2B32078D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTzfX1pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgFQJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:19:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20518 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgFQJTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592385580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kkEXKyGt2pSGVeN/088gzrGbTggjvieYaVp7yoqIgIc=;
        b=CTzfX1pT8nuQVF26AgAbJ8E7twcExn32ny4Xjr4XPH73f6YoUlUYJnN/OVgfwYllOlzH0D
        D9TFxL8lh9wGQVg5r2d88HauDLV56fXWK23Q+xz5qaKW7+pKDUjHXMkU7B0ehDoduVehUb
        GK1Cct8cibKEZeK91gnL97vDNn3+Vs0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-dVtHbVnkMZucx-GrMSwLgg-1; Wed, 17 Jun 2020 05:19:37 -0400
X-MC-Unique: dVtHbVnkMZucx-GrMSwLgg-1
Received: by mail-ej1-f71.google.com with SMTP id p27so752448ejn.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kkEXKyGt2pSGVeN/088gzrGbTggjvieYaVp7yoqIgIc=;
        b=VAWv1FgaISClolyhaKwAqvD1JaFI2ygRxH6CNh6EzwyoRyRALsQy+hxw/Bluu5Xg4p
         ycxotADnuMh9Y6Ypf5I5yk7+307JFmn2st1cCC279+GBDEHcNXw/aVbKS2XfV5ID9Dqt
         6Rtd+oN78Nb878+4O2NaUQKsnW67NfjzaRkE1I1ZNTHTELU03/qcEitTwxEGHpZDJChf
         etPtgGzyDmgBTfORdcTQiEr5oT1uYmrit+V+a9B0wX+BOmzSJOXV9mn7gc+0lE9u4Euy
         sU2pdGudpaMR9W9gyueGeHKFKW3RpOHubJnQLx6HMPIFckGFx4oimdMBW2F+2knATGOs
         6USQ==
X-Gm-Message-State: AOAM530sHKtl0U94Xucwqk7eEmqiK6HR/1VI0fkB8fGxiLQ2mwrd5GMb
        +2/nKrpI0ZTbkEqOBih8uDMnEBl6caSmC+MYMVRkKKCFGxc/Gl9LqNqH6ZXhb3QztvRddV2rtmV
        hS40E830D5kW1UNR4YM+QgvPB
X-Received: by 2002:a17:907:217a:: with SMTP id rl26mr6508699ejb.209.1592385576317;
        Wed, 17 Jun 2020 02:19:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrJXQCxLImLWsBTGLvp8iRfU4f8nD2ldLoRX71FQCLOBA0I2c2dEM5Z3bO5UcktbATy/FZlQ==
X-Received: by 2002:a17:907:217a:: with SMTP id rl26mr6508687ejb.209.1592385576150;
        Wed, 17 Jun 2020 02:19:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z15sm13057695ejw.8.2020.06.17.02.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:19:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: VMX: Remove vcpu_vmx's defunct copy of host_pkru
In-Reply-To: <20200617034123.25647-1-sean.j.christopherson@intel.com>
References: <20200617034123.25647-1-sean.j.christopherson@intel.com>
Date:   Wed, 17 Jun 2020 11:19:34 +0200
Message-ID: <87zh92gic9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Remove vcpu_vmx.host_pkru, which got left behind when PKRU support was
> moved to common x86 code.
>
> No functional change intended.
>
> Fixes: 37486135d3a7b ("KVM: x86: Fix pkru save/restore when guest CR4.PKE=0, move it to x86.c")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 8a83b5edc820..639798e4a6ca 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -288,8 +288,6 @@ struct vcpu_vmx {
>  
>  	u64 current_tsc_ratio;
>  
> -	u32 host_pkru;
> -
>  	unsigned long host_debugctlmsr;
>  
>  	/*

(Is there a better [automated] way to figure out whether the particular
field is being used or not than just dropping it and trying to compile
the whole thing? Leaving #define-s, configs,... aside ...)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

