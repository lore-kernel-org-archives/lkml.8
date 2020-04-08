Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC49C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5B20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDHGA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:00:26 -0400
Received: from gecko.sbs.de ([194.138.37.40]:42883 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgDHGA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:00:26 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0385x3BM017885
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 07:59:03 +0200
Received: from [167.87.145.84] ([167.87.145.84])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0385wr4o028544;
        Wed, 8 Apr 2020 07:58:54 +0200
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200407174824.5e97a597@gandalf.local.home>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
Date:   Wed, 8 Apr 2020 07:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407174824.5e97a597@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.20 23:48, Steven Rostedt wrote:
> On Tue, 07 Apr 2020 13:02:40 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> Since we now have infrastructure to analyze module text, disallow
>> modules that write to CRn and DRn registers.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>   arch/x86/kernel/module.c |   21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> --- a/arch/x86/kernel/module.c
>> +++ b/arch/x86/kernel/module.c
>> @@ -266,6 +266,22 @@ static bool insn_is_vmx(struct insn *ins
>>   	return false;
>>   }
>>   
>> +static bool insn_is_mov_CRn(struct insn *insn)
>> +{
>> +	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x22)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static bool insn_is_mov_DRn(struct insn *insn)
>> +{
>> +	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x23)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>   static int decode_module(struct module *mod, void *text, void *text_end, bool sld_safe)
>>   {
>>   	bool allow_vmx = sld_safe || !split_lock_enabled();
>> @@ -285,6 +301,11 @@ static int decode_module(struct module *
>>   			return -ENOEXEC;
>>   		}
>>   
>> +		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
>> +			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
>> +			return -ENOEXEC;
>> +		}
> 
> Hmm, wont this break jailhouse?

Yes, possibly. We load the hypervisor binary via request_firmware into 
executable memory and then jump into it. So most of the "suspicious" 
code is there - except two cr4_init_shadow() calls to propagate the 
non-transparent update of VMXE into that shadow. We could hide that CR4 
flag, but that could mislead root Linux to try to use VMX while in jail.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
