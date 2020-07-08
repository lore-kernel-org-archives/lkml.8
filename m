Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6827C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D537206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtHjIh2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgGHPbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:31:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54733 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729022AbgGHPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594222280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=59uaosHXgT6qmldDLKNeyh6mr1S59liDZ+jRzuKa0uE=;
        b=PtHjIh2D3jFSiXtSTx40jUKhzbo3G/+QQ2b0XUSjprKiUZMDQyWShCiU1pNtIxIg98Dcd5
        ZAEc0UQ7Pb9sGWrFoXUWXtAU5hewaP9Q16h9tVseftrDMJTp8taSI2tp6TkE2RiBCDXdrA
        4bVuWvHKaWCp3cq4WFxtg7jbO2Yi93U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-QOc7kpD8O4Si-HaCi82yOA-1; Wed, 08 Jul 2020 11:31:18 -0400
X-MC-Unique: QOc7kpD8O4Si-HaCi82yOA-1
Received: by mail-wm1-f71.google.com with SMTP id c81so2109997wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=59uaosHXgT6qmldDLKNeyh6mr1S59liDZ+jRzuKa0uE=;
        b=jJ5r6/ToUEfe5YMOUDJMJ8ZH1zjmVAKEFYfTkeCLwX8LxuYTnbAUk7H0qmOoishAK5
         RIkMOzoFldFwZH4ua8ybZLbVveB0Fi4311660GAJRIZywnYZ3O+FNMgvMWCLIr8ug8dh
         oBKt/YJd3zJ9w3DBRJLVbpDdteQauw1RTcvgheWmc8I4BMN6H2Slk3fRZpTKlnof6qJL
         wlFAQq4wK8F988ICQnhpRInanteGnlwk3duE576RbNsNcVwlBvqeL7BBWbQIbrhYkJs3
         EQh9W/OobDLgbmxi6oU8EmYsbV1UXhFtTV+jy5QYxLOzFptWj2tVoQZItV6A9gISSJxa
         Vsew==
X-Gm-Message-State: AOAM531EMRxCHNL7ejze95pcthv/CK7ZttNM3qlfxNW1jd0YEYQgPt0v
        I6Uf3qUHlrA8X+YeSE3zn2RpKKUlfblGyvhP8Y0ZpmVSk2CadnYVh81SdYGyNZGxmBZ2zp+5lq9
        huqwcBtKz5RFZg2xFr3skIaet
X-Received: by 2002:a7b:c5c4:: with SMTP id n4mr9638601wmk.67.1594222276521;
        Wed, 08 Jul 2020 08:31:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy0WT3rLNI0em+sO8R/UAW8LZSJNdJTXnuAaTTSym1frgpG8b2UGa/jS7r5G1c/YH3r8JJjA==
X-Received: by 2002:a7b:c5c4:: with SMTP id n4mr9638575wmk.67.1594222276235;
        Wed, 08 Jul 2020 08:31:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id j15sm426678wrx.69.2020.07.08.08.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:31:15 -0700 (PDT)
Subject: Re: [PATCH] KVM/x86: pmu: Fix #GP condition check for RDPMC emulation
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Like Xu <like.xu@linux.intel.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
References: <20200708074409.39028-1-like.xu@linux.intel.com>
 <20200708151824.GA22737@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e285ccb3-29bd-dcb8-73d1-eeee11d72198@redhat.com>
Date:   Wed, 8 Jul 2020 17:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708151824.GA22737@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 17:18, Sean Christopherson wrote:
> On Wed, Jul 08, 2020 at 03:44:09PM +0800, Like Xu wrote:
>> in guest protected mode, if the current privilege level
>> is not 0 and the pce flag in the cr4 register is cleared,
>> we will inject a #gp for rdpmc usage.
> 
> Wrapping at ~58 characters is a bit aggressive.  checkpatch enforces 75
> chars, something near that would be prefereable.
> 
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> ---
>>  arch/x86/kvm/pmu.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index b86346903f2e..d080d475c808 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -372,6 +372,11 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>>  	if (!pmc)
>>  		return 1;
>>  
>> +	if ((kvm_x86_ops.get_cpl(vcpu) != 0) &&
>> +	    !(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
>> +	    (kvm_read_cr4(vcpu) & X86_CR0_PE))
> 
> This reads CR4 but checks CR0.PE.
> 
> And maybe put the X86_CR4_PCE check first so that it's the focus of the
> statement?

I'll squash this to fix it (I'm OOO next week and would like to get kvm/queue
sorted out these few days that I've left).

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index d080d475c808..67741d2a0308 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -372,9 +372,9 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	if (!pmc)
 		return 1;
 
-	if ((kvm_x86_ops.get_cpl(vcpu) != 0) &&
-	    !(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
-	    (kvm_read_cr4(vcpu) & X86_CR0_PE))
+	if (!(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
+	    (kvm_x86_ops.get_cpl(vcpu) != 0) &&
+	    (kvm_read_cr0(vcpu) & X86_CR0_PE))
 		return 1;
 
 	*data = pmc_read_counter(pmc) & mask;


The order follows the SDM.  I'm tempted to remove the CR0 check
altogether, since non-protected-mode always runs at CPL0 AFAIK, but let's
keep it close to what the manual says.

Paolo

