Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600A3C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3580D2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRFkLO04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgBFORO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:17:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49567 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbgBFORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580998632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07gd7gdweIOy39pTPvnuNu/vUJNdEFHQ8hzDybfwE4U=;
        b=dRFkLO04HSaHujh3FaMlfpKhV7zkDq280pkY/TGNEWvWDVZiNIJFHZokzcxd6ah2B1qBGb
        jZQTM8dHfcqIyJCrNauFUbZNvcdq/yXTZ9zr7LiTSTbsmxKpTUIE+tbAi+nUr2gsQT/yB+
        qLpCiBrkbGw2NLubkOdIvRbSbvqqWm0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-e2S3pKFeNFS3p9zKdTDMWg-1; Thu, 06 Feb 2020 09:17:10 -0500
X-MC-Unique: e2S3pKFeNFS3p9zKdTDMWg-1
Received: by mail-wr1-f71.google.com with SMTP id c6so3420871wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=07gd7gdweIOy39pTPvnuNu/vUJNdEFHQ8hzDybfwE4U=;
        b=Zi6RSg0gl4tjIPP+K7cSfH2Ww9Zp3Dn88rPEfpW9F3qLEhQLTXByRQPgBK2Ar/DdxG
         GYHgS8YbLOaH+KZrRyYlyutP1Ql+d72w6IAiI4Be+muZeJsvlQzVbLGV7i5wnfXB5PoA
         pi5QO+ABf7tsfdygFkuoyykvQLoFjtXx64EBG1SON+nAA7FR6pNZ5SSEF89tvGcjoC4R
         Ga9p9ifBZioPFnFXiziNSH8MWJXN8snlwkB9KLbv3R68Esb7AJdIjc+boT1yUfeJBgpW
         2XrI+i5dzIuirYfLwX6YiIzpCf/ODNYc65EyIskNv71zKn8TT/zsSW4sWgrVxgMjQkBM
         W+hw==
X-Gm-Message-State: APjAAAUQE4Q4N2nJUT3TLnQmoSh6w1o3aGePPd0P4JAi+jNvibdGv2dI
        UxPOCKaj4/gCKt/719cGwioEK7ZemR8TIA0CUJ+P6my+cy1S+oh9rzt1vdhgPDKvcflXjbZEzzd
        IjAvlNRUZQ7zM897YFYMFB3Og
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4002439wrn.245.1580998628181;
        Thu, 06 Feb 2020 06:17:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUc4CdZTILhzVi27Kj5fMUhgBxHWENUsjzPNPmZVLMx8Pt04I1MX+pQMKzcRQHLf6jqdashw==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4002421wrn.245.1580998627893;
        Thu, 06 Feb 2020 06:17:07 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v22sm3757493wml.11.2020.02.06.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 06:17:07 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     dgilbert@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: relax conditions for allowing MSR_IA32_SPEC_CTRL accesses
In-Reply-To: <1580915628-42930-1-git-send-email-pbonzini@redhat.com>
References: <1580915628-42930-1-git-send-email-pbonzini@redhat.com>
Date:   Thu, 06 Feb 2020 15:17:06 +0100
Message-ID: <87v9ojg5r1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Userspace that does not know about the AMD_IBRS bit might still
> allow the guest to protect itself with MSR_IA32_SPEC_CTRL using
> the Intel SPEC_CTRL bit.  However, svm.c disallows this and will
> cause a #GP in the guest when writing to the MSR.  Fix this by
> loosening the test and allowing the Intel CPUID bit, and in fact
> allow the AMD_STIBP bit as well since it allows writing to
> MSR_IA32_SPEC_CTRL too.
>
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Analyzed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Analyzed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index bf0556588ad0..a3e32d61d60c 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4225,6 +4225,8 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		break;
>  	case MSR_IA32_SPEC_CTRL:
>  		if (!msr_info->host_initiated &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) &&
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
>  			return 1;
> @@ -4310,6 +4312,8 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		break;
>  	case MSR_IA32_SPEC_CTRL:
>  		if (!msr->host_initiated &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) &&
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
>  			return 1;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

but out of pure curiosity, why do we need these checks?

At least for the 'set' case right below them we have:

        if (data & ~kvm_spec_ctrl_valid_bits(vcpu))
                 return 1;

so if guest will try using unsupported features it will #GP. So
basically, these checks will only fire when reading/writing '0' and all
features are missing, right? Do we care?

-- 
Vitaly

