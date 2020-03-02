Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90FCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911F6246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iuvn6YtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgCBJB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:01:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58316 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgCBJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583139716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+cKCStZlaFnACnF/GtwjtjakSchn0Oxyd9JsHfbu4KE=;
        b=Iuvn6YtMdxoqtTBeFQpTP+xDKnZQ6fqVRTpZtwAKVSd1aA0YHNnd6uOgoQVxebSyFE8LK3
        FM0aHZcksuHuwUioLcIdvEO9JkJfmdzJIEYIwXFTkFop9n4lfWJX6mj9+gp3BHnu0w0ZvJ
        SXmukxkGwupuvTjVw5SSO6EMlAfcqZc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-I1qrsPoFOmu4YBWQMEABag-1; Mon, 02 Mar 2020 04:01:55 -0500
X-MC-Unique: I1qrsPoFOmu4YBWQMEABag-1
Received: by mail-wm1-f71.google.com with SMTP id y7so2643112wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 01:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+cKCStZlaFnACnF/GtwjtjakSchn0Oxyd9JsHfbu4KE=;
        b=gLN7HJEyZ1zg9E0Iq+1T4J7vP5FFgOkw+wXAQm0Zr/FYk9J2Sv4oiZaBNH94DluheV
         mlaFW4Z/8e4QhYe052RcCY8T/nkxmoGhNNqXaibdtraMfmBbWgBpVwG+lbHSr0PCl/8U
         5GlUw/mXyCiZHh3JaZftLNYsXHjrsw3xNkOBcyXM4SwV2xbtJqSHuW9FO13+2/UiudHE
         2SwWVkkDt6/3eSsm6jjuYx197qqmYnPq4PZO1nazpGGRwKfYiZ7PyyoxW+PbxpmN0bVi
         3mm7lt4x9Q/I2LT70M2DAjOUF55UIvdRnehbxDf9etm913zxKnVBbdknmdaX0VqVJoqZ
         saOA==
X-Gm-Message-State: ANhLgQ3Yr3+JI75S6ifujzg1ib03C7l0hpGU4l7scYZZCulC39tXFjId
        IYFTTFc8e9JBHgV8dPGLxYuxPNM2lz2x/hKb/dEnbJzd5vFepzIi128D+oT7e7GMGg/vCmSvFGU
        swLuyEJEca+IFGESXm11SOtjg
X-Received: by 2002:a5d:538e:: with SMTP id d14mr10266194wrv.62.1583139713889;
        Mon, 02 Mar 2020 01:01:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vugaTJBFeQrMq8aQNmO8wrOwb5Q1L0SrJJuYOv3anP+L+JfncyGZAAgaay46uJHvS+mTnXzHQ==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr10266175wrv.62.1583139713721;
        Mon, 02 Mar 2020 01:01:53 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a7sm13794928wmj.12.2020.03.02.01.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 01:01:52 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] KVM: x86: Remove unnecessary brackets in kvm_arch_dev_ioctl()
In-Reply-To: <20200229025212.156388-1-xiaoyao.li@intel.com>
References: <20200229025212.156388-1-xiaoyao.li@intel.com>
Date:   Mon, 02 Mar 2020 10:01:52 +0100
Message-ID: <875zfni0zj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

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

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

