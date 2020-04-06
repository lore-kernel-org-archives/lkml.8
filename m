Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E737C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC98206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgDFLsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:48:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:34617 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbgDFLsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:48:19 -0400
IronPort-SDR: M8pKhfpnqor5CimuhrZdjerM4d7zmsqM54FJo9XoSZk262q7whc/lZMH2gaJyuXLFemDxoem0B
 k4H2JhXdrkoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 04:48:18 -0700
IronPort-SDR: ODiObN0tnmXfnHxO2IELb4fSrbSIDd/5L7fZAeoI3/mkfE2h3JTTE3wHkjKqnwXLRyuafG6IZE
 NabX4fxesHbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; 
   d="scan'208";a="254091912"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.169.157]) ([10.249.169.157])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2020 04:48:14 -0700
Subject: Re: [PATCH 1/1] x86/split_lock: check split lock feature on
 initialization
To:     Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     philipp.eppelt@kernkonzept.com, bp@alien8.de, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, nivedita@alum.mit.edu, pbonzini@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, tony.luck@intel.com,
        x86@kernel.org
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200403174403.306363-1-benjamin.lamowski@kernkonzept.com>
 <20200403174403.306363-2-benjamin.lamowski@kernkonzept.com>
 <20200403180149.GH2701@linux.intel.com>
 <f072e3e0-48b0-346e-b383-3e802069fc3a@kernkonzept.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <30e141b8-f9c9-370a-4667-1e2f0116b6f7@intel.com>
Date:   Mon, 6 Apr 2020 19:48:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f072e3e0-48b0-346e-b383-3e802069fc3a@kernkonzept.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/2020 4:23 PM, Benjamin Lamowski wrote:
> [...]
>> Calling split_lock_verify_msr() with X86_FEATURE_SPLIT_LOCK_DETECT=0 is
>> intentional, the idea is to ensure SLD is disabled on all CPUs, e.g. in the
>> unlikely scenario that BIOS enabled SLD.
> 
> I was aware of the intention, but I still don't understand under which
> scenario this could be set by the BIOS although the earlier feature
> detection has failed, 

It's for the case that SLD is explicitly disabled by kernel params 
"split_lock_detect=off". You know, BIOS may turn SLD on for itself. So 
if user uses "split_lock_detect=off", we have to clear the SLD bit in 
case BIOS forgets to clear it.

> i.e. shouldn't the feature have been detected in
> all cases where SLD can actually be disabled? If so, checking for
> availability first instead of catching a #GP(0) if it is not implemented
> seems to be the cleaner solution.

I understand what you want. i.e., X86_FEATURE_SPLIT_LOCK_DETECT is 
independent from sld_off. I guess you have to make tglx accept it first.

> 
>> The first rdmsrl_safe() should short circuit split_lock_verify_msr() if
>> the RDMSR faults, i.e. it might fault, but it shouldn't WARN.  Are you
>> seeing issues or was this found via code inspection?
> 
> We stumbled across this issue because the x86 version of our VMM is not
> yet ready for production and when accessing unimplemented MSRs would
> simply return 0 and issue a warning. This is of course a deviation from
> rdmsr as defined in the SDM and the pieces are ours to keep, it will be
> changed to generate a #GP(0) once the last missing MSRs are emulated
> properly.
> 

Got it. you are running linux guest in your own VMM and there is warning 
in the VMM.

If you really want to avoid the MSR access on the platform without SLD. 
You could make the default sld_state as sld_unsupported. It can only be 
changed to other value in split_lock_setup() when SLD is enumerated. So 
in split_lock_init(), we can use if (sld_state == sld_unsupported) to 
skip the MSR_TEST_CTRL access.

