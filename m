Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39DFC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C435120724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gtq3rU1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCRNFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:05:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49107 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgCRNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584536743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkaCpn6X3ojkC9QhiPVu3kih5zKrO75Q+2APioIdYPI=;
        b=Gtq3rU1r6zhq4z6BMSQP/fbOInlT2jPVXkxmk8CYyyzjj/YscG8TMHWWPPsscU+WHyBdJo
        GPdpCnBrgJGT7SitfEfD07XhobB13gdmzzis+EpK3Nz1WBKWKuUObcuX2jIpdRsaJxJwC5
        em3DpA+7Kln+oa/oCuz1xQ9+HA1RXfs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-99q2lhcLN4qWU4Bro6n0rw-1; Wed, 18 Mar 2020 09:05:41 -0400
X-MC-Unique: 99q2lhcLN4qWU4Bro6n0rw-1
Received: by mail-wm1-f71.google.com with SMTP id z16so1026707wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZkaCpn6X3ojkC9QhiPVu3kih5zKrO75Q+2APioIdYPI=;
        b=rVJIlCZ9N8cJdoBTeXJNBmxO6snR4v/+4LyhrjSywiN2UaCPbKIaW23LB1KDb/6HDF
         PjC33QdFVMdVXyKg0NIDMG9ygvJ2/g/ZarzFn/oAMlUFzz9riVQTpGtL6k1V+kYMVj0C
         DcLFsXcfPmEMXxIbAFkm62Sv1zLJ+phGBFdxLZTKP5iSYa608gE7cbnMhOLLbGf6550i
         KoZ7O4umY7fcTuO+idhngz41/yLkmh7UG9JWtY1HOnMoTz+qtmX2vs5CxRHr5Xr5hAIp
         9AywjQ7v5bzuNwdU5LMKRrdzF6Hy/F8GVuZ4ywlxOQ8xQ0x36P1WQqDgRsNs5kdgBwyZ
         +xOQ==
X-Gm-Message-State: ANhLgQ1kVQ/S5+kfTvj0q/hPzNhZfbZdUhOui4Df9yDtOJbq++J9xZBJ
        Iv+qPRtUsEUvd4ftXKPS7InR9Fvtx15qKPXuy1tnQQWNHjyvLAm4NYIVcRpU9MDDmaFOknh8a4N
        gagEsiLUGMfeb/l41GZr9iMGW
X-Received: by 2002:adf:b245:: with SMTP id y5mr5331659wra.136.1584536738538;
        Wed, 18 Mar 2020 06:05:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtPhqqH7GoQGtGR1qDUke2gX5UyDmHFJnjxEcKacgbD29xkclCmkhgNsGDRTocZ2mNGR/tqNA==
X-Received: by 2002:adf:b245:: with SMTP id y5mr5331639wra.136.1584536738275;
        Wed, 18 Mar 2020 06:05:38 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id b4sm3793259wmj.12.2020.03.18.06.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 06:05:37 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: Remove unnecessary brackets in
 kvm_arch_dev_ioctl()
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200229025212.156388-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <faafb5ba-56cf-ec32-e5b5-244d7939c19a@redhat.com>
Date:   Wed, 18 Mar 2020 14:05:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200229025212.156388-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/02/20 03:52, Xiaoyao Li wrote:
> In kvm_arch_dev_ioctl(), the brackets of case KVM_X86_GET_MCE_CAP_SUPPORTED
> accidently encapsulates case KVM_GET_MSR_FEATURE_INDEX_LIST and case
> KVM_GET_MSRS. It doesn't affect functionality but it's misleading.
> 
> Remove unnecessary brackets and opportunistically add a "break" in the
> default path.
> 
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5de200663f51..e49f3e735f77 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3464,7 +3464,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
>  		r = 0;
>  		break;
>  	}
> -	case KVM_X86_GET_MCE_CAP_SUPPORTED: {
> +	case KVM_X86_GET_MCE_CAP_SUPPORTED:
>  		r = -EFAULT;
>  		if (copy_to_user(argp, &kvm_mce_cap_supported,
>  				 sizeof(kvm_mce_cap_supported)))
> @@ -3496,9 +3496,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
>  	case KVM_GET_MSRS:
>  		r = msr_io(NULL, argp, do_get_msr_feature, 1);
>  		break;
> -	}
>  	default:
>  		r = -EINVAL;
> +		break;
>  	}
>  out:
>  	return r;
> 

Queued as "KVM: x86: Code style cleanup in kvm_arch_dev_ioctl()", thanks.

Paolo

