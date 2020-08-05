Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13182207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgHEA0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:26:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:43980 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHEA0F (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:26:05 -0400
IronPort-SDR: oZALgKiiDiUfJiRmRpeZeDkTpl8ewV/0Ab86baYEhu8IXW1Pe+LeszMf7oWQy/BXRIt6NIJDE4
 duOeU+ParPsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="149875268"
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208";a="149875268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 17:26:04 -0700
IronPort-SDR: 0XseFrFnQTDiwnC6CoOtEwieWaz6KBwVkkkLhONfRJc+5ganZtinuV8Fv1TT2W8CVaSeIqzXil
 TmBIBLc1oFSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208";a="330774101"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2020 17:26:01 -0700
Subject: Re: [PATCH v1 1/2] Missing instruction_pointer_set() instances
To:     peterz@infradead.org
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        nickhu@andestech.com, green.hu@gmail.com, chris@zankel.net,
        jcmvbkbc@gmail.com
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200804113130.GH2657@hirez.programming.kicks-ass.net>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <9ad63dcf-5c52-5e12-4b04-5357773c4c07@linux.intel.com>
Date:   Wed, 5 Aug 2020 08:26:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804113130.GH2657@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/4/2020 7:31 PM, peterz@infradead.org wrote:
> On Fri, Jul 31, 2020 at 10:56:16AM +0800, Jin Yao wrote:
>> There is a potential security issue that perf kernel samples
>> may be leaked even though kernel sampling is disabled. For fixing
>> the potential leakage, the idea is to use instruction_pointer_set
>> to set invalid ip address in leaked perf samples in some cases.
>>
>> But instruction_pointer_set is missing on some architectures.
>> Define instruction_pointer_set for these architectures.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   arch/alpha/include/asm/ptrace.h  | 6 ++++++
>>   arch/arc/include/asm/ptrace.h    | 6 ++++++
>>   arch/nds32/include/asm/ptrace.h  | 7 +++++++
>>   arch/xtensa/include/asm/ptrace.h | 6 ++++++
>>   4 files changed, 25 insertions(+)
> 
> AFAICT you forgot to actually Cc the maintainers for all that.
> 

Thanks so much for helping to Cc the maintainers. I just checked the MAINTAINERS file and Cc the 
maintainer for PTRACE SUPPORT but I forgot to use the get_maintainer.pl script. :(

Thanks
Jin Yao

>> diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
>> index df5f317ab3fc..c464d525c110 100644
>> --- a/arch/alpha/include/asm/ptrace.h
>> +++ b/arch/alpha/include/asm/ptrace.h
>> @@ -25,4 +25,10 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>>   	return regs->r0;
>>   }
>>   
>> +static inline void instruction_pointer_set(struct pt_regs *regs,
>> +					   unsigned long val)
>> +{
>> +	regs->pc = val;
>> +}
>> +
>>   #endif
>> diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
>> index 2fdb87addadc..8869a6c0fe8c 100644
>> --- a/arch/arc/include/asm/ptrace.h
>> +++ b/arch/arc/include/asm/ptrace.h
>> @@ -154,6 +154,12 @@ static inline long regs_return_value(struct pt_regs *regs)
>>   	return (long)regs->r0;
>>   }
>>   
>> +static inline void instruction_pointer_set(struct pt_regs *regs,
>> +					   unsigned long val)
>> +{
>> +	regs->ret = val;
>> +}
>> +
>>   #endif /* !__ASSEMBLY__ */
>>   
>>   #endif /* __ASM_PTRACE_H */
>> diff --git a/arch/nds32/include/asm/ptrace.h b/arch/nds32/include/asm/ptrace.h
>> index 919ee223620c..19a916bef7f5 100644
>> --- a/arch/nds32/include/asm/ptrace.h
>> +++ b/arch/nds32/include/asm/ptrace.h
>> @@ -62,6 +62,13 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>>   {
>>   	return regs->uregs[0];
>>   }
>> +
>> +static inline void instruction_pointer_set(struct pt_regs *regs,
>> +					   unsigned long val)
>> +{
>> +	regs->ipc = val;
>> +}
>> +
>>   extern void show_regs(struct pt_regs *);
>>   /* Avoid circular header include via sched.h */
>>   struct task_struct;
>> diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
>> index b109416dc07e..82ab1ba99259 100644
>> --- a/arch/xtensa/include/asm/ptrace.h
>> +++ b/arch/xtensa/include/asm/ptrace.h
>> @@ -90,6 +90,12 @@ struct pt_regs {
>>   # define return_pointer(regs) (MAKE_PC_FROM_RA((regs)->areg[0], \
>>   					       (regs)->areg[1]))
>>   
>> +static inline void instruction_pointer_set(struct pt_regs *regs,
>> +					   unsigned long val)
>> +{
>> +	regs->pc = val;
>> +}
>> +
>>   # ifndef CONFIG_SMP
>>   #  define profile_pc(regs) instruction_pointer(regs)
>>   # else
>> -- 
>> 2.17.1
>>
