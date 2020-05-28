Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E545C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0932075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WL/+nwCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbgE1L3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:29:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29992 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388271AbgE1L3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590665345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jkGnU9IhZ9f76OQSbwe6teWCCTmgG0EZGcGlII1Znw=;
        b=WL/+nwCMDMOUu4W9VzIpOhZaV3hdfckNRK8cTX/ywWHznORPLVoGiYlU/PmF+lPsEUtdha
        RJblRjnk0wrLN3bCUlaaoYm1UKgrMPGPSSmVBvw6r/qNmhXLWjlG4O+CVHK9vdhRwmmvfw
        sYWMg86ddOd2prWReBqQoNaUrzs5lcc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-FjGJksUQN8eNdHSYxK7IuA-1; Thu, 28 May 2020 07:29:04 -0400
X-MC-Unique: FjGJksUQN8eNdHSYxK7IuA-1
Received: by mail-ed1-f69.google.com with SMTP id y5so3485532edw.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5jkGnU9IhZ9f76OQSbwe6teWCCTmgG0EZGcGlII1Znw=;
        b=YjypOEVgnkOdK6ZBZxI2YyL+DZRHjQhotPzGg7kZi2+2AQd2u9jvSXzMKixzASB8bW
         NI7r4ebQO7+XLHYyU+YBGVWEO/i/cgIbCh+4V8+a/1No9bXEaA+xNaOputG1zjZMfP7x
         kbWCahJ2wnyKG24VsRGSmAa1ArKwszz+RbMoCwEkE2+dwTOI+DkDdAFp0Iu8dBit1lWg
         QGJg0xI7acsKlixuOpWCfxI3ihd/1AgwKSAlbT2e38O03s389he+kg+ri9sPGxFOt+mN
         XlMjcGYs0nWzh4m17HSInabesdQ3aWl0L5UkQnFgtcIUOwVIB6mynCakpl4slpNt94dv
         ci+g==
X-Gm-Message-State: AOAM530QZDzZDKxH5/zuxRg1Zr3yIE3FpOBizzLX1rpegmenRLQfoIyF
        qg7YbSuShBIcHqd0e3T1ybrdSbKKPZnRbBDGmLE2DCnq2AKU1id5HCNwGXaPZM1tzHT9R+PCelh
        TbelRojlYf/i7E1ff7bIr9v2J
X-Received: by 2002:a50:fc83:: with SMTP id f3mr2710541edq.138.1590665342665;
        Thu, 28 May 2020 04:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySYdErOVnXb5nGRwttKS53jtfg1bKwk3/b9HzdBfcf3eYOFduECx7Urge3ndc527hNlaGAgg==
X-Received: by 2002:a50:fc83:: with SMTP id f3mr2710523edq.138.1590665342479;
        Thu, 28 May 2020 04:29:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id a3sm4469745edv.70.2020.05.28.04.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 04:29:01 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] KVM: x86: acknowledgment mechanism for async pf
 page ready notifications
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200525144125.143875-1-vkuznets@redhat.com>
 <20200525144125.143875-7-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9d32c25-9167-f1a7-cda7-182a785b92aa@redhat.com>
Date:   Thu, 28 May 2020 13:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200525144125.143875-7-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/20 16:41, Vitaly Kuznetsov wrote:
> +	case MSR_KVM_ASYNC_PF_ACK:
> +		if (data & 0x1) {
> +			vcpu->arch.apf.pageready_pending = false;
> +			kvm_check_async_pf_completion(vcpu);
> +		}
> +		break;
>  	case MSR_KVM_STEAL_TIME:
>  
>  		if (unlikely(!sched_info_on()))
> @@ -3183,6 +3189,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_KVM_ASYNC_PF_INT:
>  		msr_info->data = vcpu->arch.apf.msr_int_val;
>  		break;
> +	case MSR_KVM_ASYNC_PF_ACK:
> +		msr_info->data = 0;
> +		break;

How is the pageready_pending flag migrated?  Should we revert the
direction of the MSR (i.e. read the flag, and write 0 to clear it)?

Paolo

