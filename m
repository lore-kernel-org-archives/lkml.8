Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DC6C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ABA2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgAaHW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 02:22:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:41834 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbgAaHW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 02:22:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 23:22:56 -0800
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; 
   d="scan'208";a="223055979"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.168.169]) ([10.249.168.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2020 23:22:54 -0800
Subject: Re: [PATCH 2/2] KVM: VMX: Extend VMX's #AC handding
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <cf79eeeb-e107-bdff-13a8-c52288d0d123@intel.com>
 <A2E4B0E3-EDDF-46FD-8CE9-62A2E2E4BF20@amacapital.net>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <3499ee3f-e734-50fd-1b50-f6923d1f4f76@intel.com>
Date:   Fri, 31 Jan 2020 15:22:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <A2E4B0E3-EDDF-46FD-8CE9-62A2E2E4BF20@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2020 1:16 AM, Andy Lutomirski wrote:
> 
> 
>> On Jan 30, 2020, at 8:30 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> ﻿On 1/30/2020 11:18 PM, Andy Lutomirski wrote:
>>>>> On Jan 30, 2020, at 4:24 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>>>
>>>> ﻿There are two types of #AC can be generated in Intel CPUs:
>>>> 1. legacy alignment check #AC;
>>>> 2. split lock #AC;
>>>>
>>>> Legacy alignment check #AC can be injected to guest if guest has enabled
>>>> alignemnet check.
>>>>
>>>> When host enables split lock detection, i.e., split_lock_detect!=off,
>>>> guest will receive an unexpected #AC when there is a split_lock happens in
>>>> guest since KVM doesn't virtualize this feature to guest.
>>>>
>>>> Since the old guests lack split_lock #AC handler and may have split lock
>>>> buges. To make guest survive from split lock, applying the similar policy
>>>> as host's split lock detect configuration:
>>>> - host split lock detect is sld_warn:
>>>>    warning the split lock happened in guest, and disabling split lock
>>>>    detect around VM-enter;
>>>> - host split lock detect is sld_fatal:
>>>>    forwarding #AC to userspace. (Usually userspace dump the #AC
>>>>    exception and kill the guest).
>>> A correct userspace implementation should, with a modern guest kernel, forward the exception. Otherwise you’re introducing a DoS into the guest if the guest kernel is fine but guest userspace is buggy.
>>
>> To prevent DoS in guest, the better solution is virtualizing and advertising this feature to guest, so guest can explicitly enable it by setting split_lock_detect=fatal, if it's a latest linux guest.
>>
>> However, it's another topic, I'll send out the patches later.
>>
> 
> Can we get a credible description of how this would work? I suggest:
> 
> Intel adds and documents a new CPUID bit or core capability bit that means “split lock detection is forced on”.  If this bit is set, the MSR bit controlling split lock detection is still writable, but split lock detection is on regardless of the value.  Operating systems are expected to set the bit to 1 to indicate to a hypervisor, if present, that they understand that split lock detection is on.
> 
> This would be an SDM-only change, but it would also be a commitment to certain behavior for future CPUs that don’t implement split locks.

It sounds a PV solution for virtualization that it doesn't need to be 
defined in Intel-SDM but in KVM document.

As you suggested, we can define new bit in KVM_CPUID_FEATURES 
(0x40000001) as KVM_FEATURE_SLD_FORCED and reuse MSR_TEST_CTL or use a 
new virtualized MSR for guest to tell hypervisor it understand split 
lock detection is forced on.

> Can one of you Intel folks ask the architecture team about this?
> 

