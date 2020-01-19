Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D0C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 08:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708B020684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 08:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYQicjQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgASI5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 03:57:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52178 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgASI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 03:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579424250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9cBCNFLdYb5b5nntvKG/XFjJpBa8yu/J2hg4sweBzU=;
        b=SYQicjQppZVOiGKTutpLYJFW0amd91DTiAziqlMt6LfV/si0hFXwQsb/TnL6rtgTcUuA+o
        qnjal+GS6YW0LOsyeEwOif9IUy0RzDbhwF3MVh/VPQfUq7hqCllMpaqln6lgnqsPfG/gQD
        pTNDfXnP6HYTtTvYtFbUq+z3UppCNyU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-nKpIfxFJOOSGLKIDNbW1nw-1; Sun, 19 Jan 2020 03:57:28 -0500
X-MC-Unique: nKpIfxFJOOSGLKIDNbW1nw-1
Received: by mail-wm1-f71.google.com with SMTP id n17so1699835wmk.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 00:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f9cBCNFLdYb5b5nntvKG/XFjJpBa8yu/J2hg4sweBzU=;
        b=EcQ8noQBY8nZkZ2Ce/P/Gb0PAG9AOI+QO0y/L2zU9lNA/Jodntk3GHMliGVJ5pRUEe
         SQXWVFJh1MMRlcfPuLRXv7MAuktdM854WBkrdFAc3p+b5PiKKVFnQ0aVbxDwS5Q5nhQ5
         6taFCg2qSPaBWlJHtQWsO21LMcGpm9DQrroOoE7/8F/m/XwN9c3L1dMKbrfKCW1WIbQx
         T21U7W6GGnQ1s50hTIlGQbBQb1PoK9Ob9rsR60XL9bKxaxXlL0WcfufjeWEaMg/vFD6P
         eSTa6o7im1uto/QHigKlE/YgOzDyY5zzg669wsjZh6rusSiojH775Q27f8pzXQjVXp4x
         H++w==
X-Gm-Message-State: APjAAAX7VChpisBK544o/cFRm7WGtHwLTOr00vmYnog39aSRgX6TeiHI
        b/W2RJIbUf54rHzmHtRTYSwYygkNEW8+sPF0fsS1lqbb7UKoWIguh9/+Io8SuM3bEVvAOoRqhWK
        vp6s71I8wcqaNvh/RiIJatvaS
X-Received: by 2002:adf:df0e:: with SMTP id y14mr11984359wrl.377.1579424247707;
        Sun, 19 Jan 2020 00:57:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBqnpZg3USfXApN03BQr+Wlr/EQmxqFrwMUXboaZgSmzOtI7UT2/y3ZcHjcezLF1HuPS360w==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr11984342wrl.377.1579424247449;
        Sun, 19 Jan 2020 00:57:27 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id n3sm39994970wrs.8.2020.01.19.00.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 00:57:26 -0800 (PST)
Subject: Re: [PATCH RFC 3/3] x86/kvm/hyper-v: don't allow to turn on
 unsupported VMX controls for nested guests
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Liran Alon <liran.alon@oracle.com>, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>
References: <20200115171014.56405-1-vkuznets@redhat.com>
 <20200115171014.56405-4-vkuznets@redhat.com>
 <CF37ED31-4ED0-45C2-A309-3E1E2C2E54F8@oracle.com>
 <874kwvixuq.fsf@vitty.brq.redhat.com>
 <20200116162101.GD20561@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdfcbb9d-42fd-1189-1dac-4ece14708890@redhat.com>
Date:   Sun, 19 Jan 2020 09:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200116162101.GD20561@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/20 17:21, Sean Christopherson wrote:
> On Thu, Jan 16, 2020 at 09:55:57AM +0100, Vitaly Kuznetsov wrote:
>> Liran Alon <liran.alon@oracle.com> writes:
>>
>>>> On 15 Jan 2020, at 19:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>>>
>>>> Sane L1 hypervisors are not supposed to turn any of the unsupported VMX
>>>> controls on for its guests and nested_vmx_check_controls() checks for
>>>> that. This is, however, not the case for the controls which are supported
>>>> on the host but are missing in enlightened VMCS and when eVMCS is in use.
>>>>
>>>> It would certainly be possible to add these missing checks to
>>>> nested_check_vm_execution_controls()/_vm_exit_controls()/.. but it seems
>>>> preferable to keep eVMCS-specific stuff in eVMCS and reduce the impact on
>>>> non-eVMCS guests by doing less unrelated checks. Create a separate
>>>> nested_evmcs_check_controls() for this purpose.
>>>>
>>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>>> ---
>>>> arch/x86/kvm/vmx/evmcs.c  | 56 ++++++++++++++++++++++++++++++++++++++-
>>>> arch/x86/kvm/vmx/evmcs.h  |  1 +
>>>> arch/x86/kvm/vmx/nested.c |  3 +++
>>>> 3 files changed, 59 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
>>>> index b5d6582ba589..88f462866396 100644
>>>> --- a/arch/x86/kvm/vmx/evmcs.c
>>>> +++ b/arch/x86/kvm/vmx/evmcs.c
>>>> @@ -4,9 +4,11 @@
>>>> #include <linux/smp.h>
>>>>
>>>> #include "../hyperv.h"
>>>> -#include "evmcs.h"
>>>> #include "vmcs.h"
>>>> +#include "vmcs12.h"
>>>> +#include "evmcs.h"
>>>> #include "vmx.h"
>>>> +#include "trace.h"
>>>>
>>>> DEFINE_STATIC_KEY_FALSE(enable_evmcs);
>>>>
>>>> @@ -378,6 +380,58 @@ void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
>>>> 	*pdata = ctl_low | ((u64)ctl_high << 32);
>>>> }
>>>>
>>>> +int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
>>>> +{
>>>> +	int ret = 0;
>>>> +	u32 unsupp_ctl;
>>>> +
>>>> +	unsupp_ctl = vmcs12->pin_based_vm_exec_control &
>>>> +		EVMCS1_UNSUPPORTED_PINCTRL;
>>>> +	if (unsupp_ctl) {
>>>> +		trace_kvm_nested_vmenter_failed(
>>>> +			"eVMCS: unsupported pin-based VM-execution controls",
>>>> +			unsupp_ctl);
>>>
>>> Why not move "CC” macro from nested.c to nested.h and use it here as-well instead of replicating it’s logic?
>>>
>>
>> Because error messages I add are both human readable and conform to SDM!
>> :-)
>>
>> On a more serious not yes, we should probably do that. We may even want
>> to use it in non-nesting (and non VMX) code in KVM.
> 
> No, the CC() macro is short for Consistency Check, i.e. specific to nVMX.
> Even if KVM ends up adding nested_evmcs_check_controls(), which I'm hoping
> can be avoided, I'd still be hesitant to expose CC() in nested.h.
> 

For now let's keep Vitaly's patch as is.  It's definitely a good one as
it would catch Hyper-V's issue immediately even without patch 2 (which
is the only really contentious change).

Paolo

