Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B36C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40BD208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgH2Cvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 22:51:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:62212 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgH2Cvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 22:51:53 -0400
IronPort-SDR: 8mTdMjcQdMH1UOY3aVTWyGXfW9ubOv8shkX3PYtroC0uPb+HkJD1mRcsPJ3av6H6oHkxSIasuO
 E9oL2O1xFUYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="218325043"
X-IronPort-AV: E=Sophos;i="5.76,366,1592895600"; 
   d="scan'208";a="218325043"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 19:51:52 -0700
IronPort-SDR: nXToNeIKugJp6cS9bPH9eXz6pmgmYpZ4D6j+NQLTaLUrOBzjDJPVuSJ4LHYpV2gQ97pLxJn0JR
 AtyedJXORm+g==
X-IronPort-AV: E=Sophos;i="5.76,366,1592895600"; 
   d="scan'208";a="475939800"
Received: from jli113-mobl1.ccr.corp.intel.com (HELO [10.254.212.55]) ([10.254.212.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 19:51:50 -0700
Subject: Re: [PATCH 1/5] KVM: nVMX: Fix VMX controls MSRs setup when nested
 VMX enabled
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200828085622.8365-1-chenyi.qiang@intel.com>
 <20200828085622.8365-2-chenyi.qiang@intel.com>
 <CALMp9eThyqWuduU=JN+w3M3ANeCYN+7=s-gippzyu_GmvgtVGA@mail.gmail.com>
 <534a4ad5-b083-1278-a6ac-4a7e2b6b1600@intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <1fbfb77d-4f28-bcb6-a95c-f4ac7a313d2d@intel.com>
Date:   Sat, 29 Aug 2020 10:51:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <534a4ad5-b083-1278-a6ac-4a7e2b6b1600@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2020 9:49 AM, Chenyi Qiang wrote:
> 
> 
> On 8/29/2020 1:43 AM, Jim Mattson wrote:
>> On Fri, Aug 28, 2020 at 1:54 AM Chenyi Qiang <chenyi.qiang@intel.com> 
>> wrote:
>>>
>>> KVM supports the nested VM_{EXIT, ENTRY}_LOAD_IA32_PERF_GLOBAL_CTRL and
>>> VM_{ENTRY_LOAD, EXIT_CLEAR}_BNDCFGS, but they doesn't expose during
>>> the setup of nested VMX controls MSR.
>>>
>>
>> Aren't these features added conditionally in
>> nested_vmx_entry_exit_ctls_update() and
>> nested_vmx_pmu_entry_exit_ctls_update()?
>>
> 
> Yes, but I assume vmcs_config.nested should reflect the global 
> capability of VMX MSR. KVM supports these two controls, so should be 
> exposed here.

No. I prefer to say they are removed conditionally in 
nested_vmx_entry_exit_ctls_update() and 
nested_vmx_pmu_entry_exit_ctls_update().

Userspace calls vmx_get_msr_feature() to query what KVM supports for 
these VMX MSR. In vmx_get_msr_feature(), it returns the value of 
vmcs_config.nested. As KVM supports these two bits, we should advertise 
them in vmcs_config.nested and report to userspace.
