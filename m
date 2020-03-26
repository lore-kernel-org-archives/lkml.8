Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE90C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9A0206F8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgCZHmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:42:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:55669 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCZHmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:42:54 -0400
IronPort-SDR: I9u99FjHiVME2oXhciG4xPzQ37tjCElPYLvMrrJ1T+jH5zFA4IOOS5T3DrZvrq1K5ELw7vqOmY
 IqrA0YKvvMUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 00:42:53 -0700
IronPort-SDR: BCQlscc2Ao0LLN9eDbMUiLdVyzmpXnZzGDRoCxZTvg2CIQa6z31Vm85sZwDVxTljZwbGhJnJaS
 6h1Yjhc0bNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,307,1580803200"; 
   d="scan'208";a="271078911"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2020 00:42:50 -0700
Subject: Re: [PATCH V4 05/13] perf/x86: Add perf text poke events for kprobes
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20200304090633.420-1-adrian.hunter@intel.com>
 <20200304090633.420-6-adrian.hunter@intel.com>
 <20200324122150.GN20696@hirez.programming.kicks-ass.net>
 <20200326105805.0723cd10325ad301de061743@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <07415abd-5084-f16c-cc62-6c9a237951f3@intel.com>
Date:   Thu, 26 Mar 2020 09:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200326105805.0723cd10325ad301de061743@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/20 3:58 am, Masami Hiramatsu wrote:
> On Tue, 24 Mar 2020 13:21:50 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> We optimize only after having already installed a regular probe, that
>> is, what we're actually doing here is replacing INT3 with a JMP.d32. But
>> the above will make it appear as if we're replacing the original text
>> with a JMP.d32. Which doesn't make sense, since we've already poked an
>> INT3 there and that poke will have had a corresponding
>> perf_event_text_poke(), right? (except you didn't, see below)
>>
>> At this point we'll already have constructed the optprobe trampoline,
>> which contains however much of the original instruction (in whole) as
>> will be overwritten by our 5 byte JMP.d32. And IIUC, we'll have a
>> perf_event_text_poke() event for the whole of that already -- except I
>> can't find that in the patches (again, see below).
> 
> Thanks Peter to point it out.
> 
>>
>>> @@ -454,9 +463,16 @@ void arch_optimize_kprobes(struct list_head *oplist)
>>>   */
>>>  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>>>  {
>>> +	u8 old[POKE_MAX_OPCODE_SIZE];
>>> +	u8 new[POKE_MAX_OPCODE_SIZE] = { op->kp.opcode, };
>>> +	size_t len = INT3_INSN_SIZE + DISP32_SIZE;
>>> +
>>> +	memcpy(old, op->kp.addr, len);
>>>  	arch_arm_kprobe(&op->kp);
>>>  	text_poke(op->kp.addr + INT3_INSN_SIZE,
>>>  		  op->optinsn.copied_insn, DISP32_SIZE);
>>> +	memcpy(new + INT3_INSN_SIZE, op->optinsn.copied_insn, DISP32_SIZE);
>>
>> And then this is 'wrong' too. You've not written the original
>> instruction, you've just written an INT3.
>>
>>> +	perf_event_text_poke(op->kp.addr, old, len, new, len);
>>>  	text_poke_sync();
>>>  }
>>
>>
>> So how about something like the below, with it you'll get 6 text_poke
>> events:
>>
>> 1:  old0 -> INT3
>>
>>   // kprobe active
>>
>> 2:  NULL -> optprobe_trampoline
>> 3:  INT3,old1,old2,old3,old4 -> JMP32
>>
>>   // optprobe active
>>
>> 4:  JMP32 -> INT3,old1,old2,old3,old4
>> 5:  optprobe_trampoline -> NULL
>>
>>   // kprobe active
>>
>> 6:  INT3 -> old0
>>
>>
>>
>> Masami, did I get this all right?
> 
> Yes, you understand correctly. And there is also boosted kprobe
> which runs probe.ainsn.insn directly and jump back to old place.
> I guess it will also disturb Intel PT.
> 
> 0:  NULL -> probe.ainsn.insn (if ainsn.boostable && !kp.post_handler)
> 
>> 1:  old0 -> INT3
>>
>   // boosted kprobe active
>>
>> 2:  NULL -> optprobe_trampoline
>> 3:  INT3,old1,old2,old3,old4 -> JMP32
>>
>>   // optprobe active
>>
>> 4:  JMP32 -> INT3,old1,old2,old3,old4
> 
>    // optprobe disabled and kprobe active (this sometimes goes back to 3)
> 
>> 5:  optprobe_trampoline -> NULL
>>
>   // boosted kprobe active
>>
>> 6:  INT3 -> old0
> 
> 7:  probe.ainsn.insn -> NULL (if ainsn.boostable && !kp.post_handler)
> 
> So you'll get 8 events in max.
> 
> Adrian, would you also need to trace the buffer which is used for
> single stepping? If so, as you did, we need to trace p->ainsn.insn
> always.

Peter's simplification (thanks for that I will test it) didn't look
at that aspect but it was covered in the original patch in the chunk
below.  That will be included in the next version also.

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 579d30e91a36..12ea05d923ec 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -33,6 +33,7 @@
 #include <linux/hardirq.h>
 #include <linux/preempt.h>
 #include <linux/sched/debug.h>
+#include <linux/perf_event.h>
 #include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
@@ -470,6 +471,9 @@ static int arch_copy_kprobe(struct kprobe *p)
 	/* Also, displacement change doesn't affect the first byte */
 	p->opcode = buf[0];
 
+	p->ainsn.tp_len = len;
+	perf_event_text_poke(p->ainsn.insn, NULL, 0, buf, len);
+
 	/* OK, write back the instruction(s) into ROX insn buffer */
 	text_poke(p->ainsn.insn, buf, len);
 
@@ -514,6 +518,9 @@ void arch_disarm_kprobe(struct kprobe *p)
 void arch_remove_kprobe(struct kprobe *p)
 {
 	if (p->ainsn.insn) {
+		/* Record the perf event before freeing the slot */
+		perf_event_text_poke(p->ainsn.insn, p->ainsn.insn,
+				     p->ainsn.tp_len, NULL, 0);
 		free_insn_slot(p->ainsn.insn, p->ainsn.boostable);
 		p->ainsn.insn = NULL;
 	}


