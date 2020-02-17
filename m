Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3169C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E802072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxA/tjgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgBQQQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:16:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728296AbgBQQQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581956199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFyPUeouQuhyDga5QKhl60tvsLU2HEYGyhP5oV1KBMw=;
        b=XxA/tjgUqIlOeC6wKXlZJR0NvZqgj05XHD5oQFdfq268M3iB9RLg9mFnfY8M6VFYxbb5wb
        attYTgVlv4gi3u0+TX6mNzIOkvW3V6DjmFMP/KK4XOkLa52NuOH/bGaL+aUKvQkI5Bc6pK
        d9PBc0f7YhpvQEIW76HIoo/eIIJrx/c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-d9bbAWpxNzeMYKah1Q5tXw-1; Mon, 17 Feb 2020 11:16:37 -0500
X-MC-Unique: d9bbAWpxNzeMYKah1Q5tXw-1
Received: by mail-wr1-f72.google.com with SMTP id d15so9184473wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NFyPUeouQuhyDga5QKhl60tvsLU2HEYGyhP5oV1KBMw=;
        b=t83GD2MkUalgEwtLO1lifsgy4UlviZNPgWnyglWJGQFqgDNuzBovH/igcCP8IUV+g4
         9io/TwbzlG48ygsjye5jUXtsdvL/MHhrOcA+8+2+67dADMYJ309oKSrfth22zQ3jQRzV
         vRSYAXxjfO1Mmv3vzA/Hv0rC5MqdECYKNgTgCyNLtF9x1KdXfA6/+NDkwdUYH5K5/gi7
         I25j0nYIrD5vDNdIczO7VJTCgZARCO/m9Ffbh6ZmgxSOKD/+HGYfbKmflZ10czte3QZ6
         saadolVSBK7SggXc0LXi66USq81C96A3k8XmoUku8XHWgRqEbZ6UsdyDvf2ag2NTKRFG
         wTHQ==
X-Gm-Message-State: APjAAAUnOpKOCQoruRYX4EeCNI3FZlmM14e5RgiU3N/iWjp/4wzSRLyl
        edV+1nFdkNVuT2Ll0nd5xjPu2pIpZk3A7fC/IHONiPBSJ1He1Q5XoA8uPIvgFjRrYigqzXwZzAT
        MGkjyZ8nLL8NAAMgVTZ16NFSG
X-Received: by 2002:adf:806c:: with SMTP id 99mr22007642wrk.328.1581956196305;
        Mon, 17 Feb 2020 08:16:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRq0gQ7zvGxbVQD6lwCfxtSvMB5tAOlMD0x3vB242pZN7eh2YO0YBMLfDRNd31zyWvwFRRzA==
X-Received: by 2002:adf:806c:: with SMTP id 99mr22007622wrk.328.1581956196116;
        Mon, 17 Feb 2020 08:16:36 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm1188765wme.9.2020.02.17.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:16:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: x86: eliminate some unreachable code
In-Reply-To: <1581562405-30321-1-git-send-email-linmiaohe@huawei.com>
References: <1581562405-30321-1-git-send-email-linmiaohe@huawei.com>
Date:   Mon, 17 Feb 2020 17:16:34 +0100
Message-ID: <87k14l9okd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> These code are unreachable, remove them.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 1 -
>  arch/x86/kvm/x86.c     | 3 ---
>  2 files changed, 4 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index bb5c33440af8..b6d4eafe01cf 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4505,7 +4505,6 @@ static bool rmode_exception(struct kvm_vcpu *vcpu, int vec)
>  	case GP_VECTOR:
>  	case MF_VECTOR:
>  		return true;
> -	break;
>  	}
>  	return false;
>  }

Unrelated to your change but what I don't in rmode_exception() is the
second "/* fall through */" instead of just 'return true;', it makes it
harder to read.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fbabb2f06273..a597009aefd7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3081,7 +3081,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		break;
>  	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
>  		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
> -		break;
>  	case MSR_IA32_TSCDEADLINE:
>  		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
>  		break;
> @@ -3164,7 +3163,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		return kvm_hv_get_msr_common(vcpu,
>  					     msr_info->index, &msr_info->data,
>  					     msr_info->host_initiated);
> -		break;
>  	case MSR_IA32_BBL_CR_CTL3:
>  		/* This legacy MSR exists but isn't fully documented in current
>  		 * silicon.  It is however accessed by winxp in very narrow
> @@ -8471,7 +8469,6 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
>  		break;
>  	default:
>  		return -EINTR;
> -		break;
>  	}
>  	return 1;
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

