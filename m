Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C3C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A727F208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJsGXarV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgBUNnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:43:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58556 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727161AbgBUNnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582292594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jxnMeM03TNX5Hwe3Ya5c3ghPkANO7e19ew4skX/ljXI=;
        b=jJsGXarVtSN3t61tqx4KYdRKbVXw1U3MbNiQUktOdvurecOY98SPYdoa1Tv0KSJCUFEfMd
        DdHHHh7dAT91ll/f8YzJGa60KfTr62r3B2X3jH4v26DTi9Pkj56qetMzbB7dd4nT675MSl
        aOtV3NQjQt+zAen05W39yh5N+Q8kFiw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-THPZF0GgOWezd4wu21-qww-1; Fri, 21 Feb 2020 08:43:13 -0500
X-MC-Unique: THPZF0GgOWezd4wu21-qww-1
Received: by mail-wm1-f69.google.com with SMTP id f66so585576wmf.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jxnMeM03TNX5Hwe3Ya5c3ghPkANO7e19ew4skX/ljXI=;
        b=LuMEdFfjLfLdk6VvvLvGBtbONKNqxkuLKJp3pcFpvxUyJ6iOXFKqCTrbm+e9IhWR0V
         uriKyHKgQeZlv19Yq5CCDa6f1vv/kpb6TJb4CmgeZMSEwPPYH0v1PKIoEHyJpvBbW1+9
         Fux+TaC0BtXyFnLHv3sA0+TUh59u/Vq4G24xkkPPcARhujPPyYAYlErTe3BTHvh2faEm
         ONMWbNG+mXCp4xShOTFaof/e+TYzLyQvwiOFLGp4yi8LR58Memrd0Kl2hJ/NsW/COUM6
         +TZmGRpvHLoaOIYqz/jlFCs8mWPctkg4CClDy/danFi3zgfVpQ67hbe9udJ6g+WRPPnD
         E2PQ==
X-Gm-Message-State: APjAAAXi1VaT6k5zxyMGItqnWcy/itvjEuBFLZ6QzdcP6KDLEgdjiuOz
        wplWAaRmV+0c7j/xCaxB7kSieZaEMm03uKL5I+3Iigw6z89wVimpweWiMws5mfw7I/0g3t2kENi
        cRewqPh7Dg2FBYhunxeSf7raK
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr50232130wrv.9.1582292589889;
        Fri, 21 Feb 2020 05:43:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYjfMp0GXLA0Adtce96YFtLai3dGPE9oQ19+qhhnyjr/+5T/nNg1RRP70iIAwzi8r4Uxbw6w==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr50232104wrv.9.1582292589636;
        Fri, 21 Feb 2020 05:43:09 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h18sm4214888wrv.78.2020.02.21.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:43:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] KVM: nVMX: Use vpid_sync_vcpu_addr() to emulate INVVPID with address
In-Reply-To: <20200220204356.8837-6-sean.j.christopherson@intel.com>
References: <20200220204356.8837-1-sean.j.christopherson@intel.com> <20200220204356.8837-6-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 14:43:08 +0100
Message-ID: <87wo8grr83.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use vpid_sync_vcpu_addr() to emulate the "individual address" variant of
> INVVPID now that said function handles the fallback case of the (host)
> CPU not supporting "individual address".
>
> Note, the "vpid == 0" checks in the vpid_sync_*() helpers aren't
> actually redundant with the "!operand.vpid" check in handle_invvpid(),
> as the vpid passed to vpid_sync_vcpu_addr() is a KVM (host) controlled
> value, i.e. vpid02 can be zero even if operand.vpid is non-zero.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 19ac4083667f..5a174be314e5 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5150,11 +5150,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
>  		    is_noncanonical_address(operand.gla, vcpu))
>  			return nested_vmx_failValid(vcpu,
>  				VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
> -		if (cpu_has_vmx_invvpid_individual_addr()) {
> -			__invvpid(VMX_VPID_EXTENT_INDIVIDUAL_ADDR,
> -				vpid02, operand.gla);
> -		} else
> -			vpid_sync_context(vpid02);
> +		vpid_sync_vcpu_addr(vpid02, operand.gla);
>  		break;
>  	case VMX_VPID_EXTENT_SINGLE_CONTEXT:
>  	case VMX_VPID_EXTENT_SINGLE_NON_GLOBAL:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

