Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFBAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5786120720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgGHM2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:28:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:48782 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgGHM2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:28:12 -0400
IronPort-SDR: CJG59X0UWRhyJ7IqDP92GKogb4vHrgwcjOxHR4FMEv1iB56h+usIyYp5eXdsArQThMiNyZXeKQ
 FVKi2ku/EMLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127863519"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="127863519"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 05:28:11 -0700
IronPort-SDR: FUd5V6V+Zb/6AmDbJ2PLs57bqLdaJUswr9jHXDI29+EHvW2nSpctpcbD/k6Cglp9oNomO9Rduj
 TGYgLKeZTqMg==
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="283781706"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.31.184]) ([10.255.31.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 05:28:08 -0700
Subject: Re: [PATCH v3 3/8] KVM: X86: Introduce kvm_check_cpuid()
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200708065054.19713-1-xiaoyao.li@intel.com>
 <20200708065054.19713-4-xiaoyao.li@intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <3a085ea6-1f2b-904a-99a4-e10ed00e99a0@intel.com>
Date:   Wed, 8 Jul 2020 20:28:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708065054.19713-4-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/2020 2:50 PM, Xiaoyao Li wrote:
> Use kvm_check_cpuid() to validate if userspace provides legal cpuid
> settings and call it before KVM updates CPUID.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
[...]
> @@ -202,12 +208,16 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
>   		vcpu->arch.cpuid_entries[i].padding[2] = 0;
>   	}
>   	vcpu->arch.cpuid_nent = cpuid->nent;
> +	r = kvm_check_cpuid(vcpu);
> +	if (r) {
> +		vcpu->arch.cpuid_nent = 0;

Paolo,

here lack a kvfree(cpuid_entries);
Can you help fix it?

Apologize for it.


> +		goto out;
> +	}
> +
>   	cpuid_fix_nx_cap(vcpu);
>   	kvm_apic_set_version(vcpu);
>   	kvm_x86_ops.cpuid_update(vcpu);
> -	r = kvm_update_cpuid(vcpu);
> -	if (r)
> -		vcpu->arch.cpuid_nent = 0;
> +	kvm_update_cpuid(vcpu);
>   
>   	kvfree(cpuid_entries);
>   out:
