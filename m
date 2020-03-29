Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB026C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A96820675
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgC2JN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:13:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:16808 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgC2JN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:13:28 -0400
IronPort-SDR: x0C9mPzMu1gC4NAwHL3HwjUN8RnTZk8lvBP1432dVrKD7JbPabqFX09ufP0GuPKnJvFeFjAlZ0
 TI/nv5iWw9Yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 02:13:27 -0700
IronPort-SDR: jH37F2LboNIJIKtOVgFW9v/vR4xm6nRh4WvBixPk7Wfi0B4GL+u5XabM83K6yT8DRzP3bTLlie
 OHrdYS8Qk03w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,319,1580803200"; 
   d="scan'208";a="272059284"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.31.41]) ([10.255.31.41])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2020 02:13:23 -0700
Subject: Re: [PATCH v7 2/2] x86/split_lock: Avoid runtime reads of the
 TEST_CTRL MSR
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200325030924.132881-3-xiaoyao.li@intel.com>
 <20200328163412.GJ8104@linux.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <e641c746-0dde-cfb8-ea23-45c011174b08@intel.com>
Date:   Sun, 29 Mar 2020 17:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328163412.GJ8104@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2020 12:34 AM, Sean Christopherson wrote:
> On Wed, Mar 25, 2020 at 11:09:24AM +0800, Xiaoyao Li wrote:
>> In a context switch from a task that is detecting split locks
>> to one that is not (or vice versa) we need to update the TEST_CTRL
>> MSR. Currently this is done with the common sequence:
>> 	read the MSR
>> 	flip the bit
>> 	write the MSR
>> in order to avoid changing the value of any reserved bits in the MSR.
>>
>> Cache unused and reserved bits of TEST_CTRL MSR with SPLIT_LOCK_DETECT
>> bit cleared during initialization, so we can avoid an expensive RDMSR
>> instruction during context switch.
>>
>> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Originally-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   arch/x86/kernel/cpu/intel.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index deb5c42c2089..1f414578899c 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -45,6 +45,7 @@ enum split_lock_detect_state {
>>    * split lock detect, unless there is a command line override.
>>    */
>>   static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
>> +static u64 msr_test_ctrl_cache __ro_after_init;
> 
> What about using "msr_test_ctrl_base_value", or something along those lines?
> "cache" doesn't make it clear that SPLIT_LOCK_DETECT is guaranteed to be
> zero in this variable.
> 
>>   
>>   /*
>>    * Processors which have self-snooping capability can handle conflicting
>> @@ -1037,6 +1038,8 @@ static void __init split_lock_setup(void)
>>   		break;
>>   	}
>>   
>> +	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
> 
> If we're going to bother skipping the RDMSR if state=sld_off on the command
> line then it also makes sense to skip it if enabling fails, i.e. move this
> below split_lock_verify_msr(true).

OK.

Then, the sld bit is 1 for msr_test_ctrl_base_value. Do you think 
"msr_test_ctrl_base_value" still make sense?

or we keep the "else" branch in sld_update_msr() to not rely on the sld 
bit in the base_value?

>> +
>>   	if (!split_lock_verify_msr(true)) {
>>   		pr_info("MSR access failed: Disabled\n");
>>   		return;
>> @@ -1053,14 +1056,10 @@ static void __init split_lock_setup(void)
>>    */
>>   static void sld_update_msr(bool on)
>>   {
>> -	u64 test_ctrl_val;
>> -
>> -	rdmsrl(MSR_TEST_CTRL, test_ctrl_val);
>> +	u64 test_ctrl_val = msr_test_ctrl_cache;
>>   
>>   	if (on)
>>   		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>> -	else
>> -		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>>   
>>   	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
>>   }
>> -- 
>> 2.20.1
>>

