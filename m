Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57ACC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA62468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgCJMxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:53:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:16674 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbgCJMxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 05:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="245690241"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2020 05:53:40 -0700
Received: from [10.251.24.33] (kliang2-mobl.ccr.corp.intel.com [10.251.24.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 77AFF5804A0;
        Tue, 10 Mar 2020 05:53:38 -0700 (PDT)
Subject: Re: [PATCH 01/12] perf tools: Add hw_idx in struct branch_stack
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200228163011.19358-2-kan.liang@linux.intel.com>
 <20200310004240.GB15931@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0ba1d2f6-ce9a-3822-9617-2f9a66e4bfa3@linux.intel.com>
Date:   Tue, 10 Mar 2020 08:53:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310004240.GB15931@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2020 8:42 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 28, 2020 at 08:30:00AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The low level index of raw branch records for the most recent branch can
>> be recorded in a sample with PERF_SAMPLE_BRANCH_HW_INDEX
>> branch_sample_type. Extend struct branch_stack to support it.
>>
>> However, if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied, only nr and
>> entries[] will be output by kernel. The pointer of entries[] could be
>> wrong, since the output format is different with new struct branch_stack.
>> Add a variable no_hw_idx in struct perf_sample to indicate whether the
>> hw_idx is output.
>> Add get_branch_entry() to return corresponding pointer of entries[0].
>>
>> To make dummy branch sample consistent as new branch sample, add hw_idx
>> in struct dummy_branch_stack for cs-etm and intel-pt.
>>
>> Apply the new struct branch_stack for synthetic events as well.
>>
>> Extend test case sample-parsing to support new struct branch_stack.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/include/uapi/linux/perf_event.h         |  8 ++-
>>   tools/perf/builtin-script.c                   | 70 ++++++++++---------
>>   tools/perf/tests/sample-parsing.c             |  7 +-
>>   tools/perf/util/branch.h                      | 22 ++++++
>>   tools/perf/util/cs-etm.c                      |  1 +
>>   tools/perf/util/event.h                       |  1 +
>>   tools/perf/util/evsel.c                       |  5 ++
>>   tools/perf/util/evsel.h                       |  5 ++
>>   tools/perf/util/hist.c                        |  3 +-
>>   tools/perf/util/intel-pt.c                    |  2 +
>>   tools/perf/util/machine.c                     | 35 +++++-----
>>   .../scripting-engines/trace-event-python.c    | 30 ++++----
>>   tools/perf/util/session.c                     |  8 ++-
>>   tools/perf/util/synthetic-events.c            |  6 +-
>>   14 files changed, 131 insertions(+), 72 deletions(-)
>>
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index 377d794d3105..397cfd65b3fe 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -181,6 +181,8 @@ enum perf_branch_sample_type_shift {
>>   
>>   	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
>>   
>> +	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
>> +
>>   	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
>>   };
>>   
>> @@ -208,6 +210,8 @@ enum perf_branch_sample_type {
>>   	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
>>   		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
>>   
>> +	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
>> +
>>   	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
>>   };
>>   
>> @@ -853,7 +857,9 @@ enum perf_event_type {
>>   	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
>>   	 *
>>   	 *	{ u64                   nr;
>> -	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
>> +	 *	  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
>> +	 *        { u64 from, to, flags } lbr[nr];
>> +	 *      } && PERF_SAMPLE_BRANCH_STACK
>>   	 *
>>   	 * 	{ u64			abi; # enum perf_sample_regs_abi
>>   	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index e2406b291c1c..acf3107bbda2 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -735,6 +735,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>>   					struct perf_event_attr *attr, FILE *fp)
>>   {
>>   	struct branch_stack *br = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	struct addr_location alf, alt;
>>   	u64 i, from, to;
>>   	int printed = 0;
>> @@ -743,8 +744,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>>   		return 0;
>>   
>>   	for (i = 0; i < br->nr; i++) {
>> -		from = br->entries[i].from;
>> -		to   = br->entries[i].to;
>> +		from = entries[i].from;
>> +		to   = entries[i].to;
>>   
>>   		if (PRINT_FIELD(DSO)) {
>>   			memset(&alf, 0, sizeof(alf));
>> @@ -768,10 +769,10 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>>   		}
>>   
>>   		printed += fprintf(fp, "/%c/%c/%c/%d ",
>> -			mispred_str( br->entries + i),
>> -			br->entries[i].flags.in_tx? 'X' : '-',
>> -			br->entries[i].flags.abort? 'A' : '-',
>> -			br->entries[i].flags.cycles);
>> +			mispred_str(entries + i),
>> +			entries[i].flags.in_tx ? 'X' : '-',
>> +			entries[i].flags.abort ? 'A' : '-',
>> +			entries[i].flags.cycles);
>>   	}
>>   
>>   	return printed;
>> @@ -782,6 +783,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>>   					   struct perf_event_attr *attr, FILE *fp)
>>   {
>>   	struct branch_stack *br = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	struct addr_location alf, alt;
>>   	u64 i, from, to;
>>   	int printed = 0;
>> @@ -793,8 +795,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>>   
>>   		memset(&alf, 0, sizeof(alf));
>>   		memset(&alt, 0, sizeof(alt));
>> -		from = br->entries[i].from;
>> -		to   = br->entries[i].to;
>> +		from = entries[i].from;
>> +		to   = entries[i].to;
>>   
>>   		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
>>   		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
>> @@ -813,10 +815,10 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>>   			printed += fprintf(fp, ")");
>>   		}
>>   		printed += fprintf(fp, "/%c/%c/%c/%d ",
>> -			mispred_str( br->entries + i),
>> -			br->entries[i].flags.in_tx? 'X' : '-',
>> -			br->entries[i].flags.abort? 'A' : '-',
>> -			br->entries[i].flags.cycles);
>> +			mispred_str(entries + i),
>> +			entries[i].flags.in_tx ? 'X' : '-',
>> +			entries[i].flags.abort ? 'A' : '-',
>> +			entries[i].flags.cycles);
>>   	}
>>   
>>   	return printed;
>> @@ -827,6 +829,7 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>>   					   struct perf_event_attr *attr, FILE *fp)
>>   {
>>   	struct branch_stack *br = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	struct addr_location alf, alt;
>>   	u64 i, from, to;
>>   	int printed = 0;
>> @@ -838,8 +841,8 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>>   
>>   		memset(&alf, 0, sizeof(alf));
>>   		memset(&alt, 0, sizeof(alt));
>> -		from = br->entries[i].from;
>> -		to   = br->entries[i].to;
>> +		from = entries[i].from;
>> +		to   = entries[i].to;
>>   
>>   		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
>>   		    !alf.map->dso->adjust_symbols)
>> @@ -862,10 +865,10 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>>   			printed += fprintf(fp, ")");
>>   		}
>>   		printed += fprintf(fp, "/%c/%c/%c/%d ",
>> -			mispred_str(br->entries + i),
>> -			br->entries[i].flags.in_tx ? 'X' : '-',
>> -			br->entries[i].flags.abort ? 'A' : '-',
>> -			br->entries[i].flags.cycles);
>> +			mispred_str(entries + i),
>> +			entries[i].flags.in_tx ? 'X' : '-',
>> +			entries[i].flags.abort ? 'A' : '-',
>> +			entries[i].flags.cycles);
>>   	}
>>   
>>   	return printed;
>> @@ -1053,6 +1056,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>>   					    struct machine *machine, FILE *fp)
>>   {
>>   	struct branch_stack *br = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	u64 start, end;
>>   	int i, insn, len, nr, ilen, printed = 0;
>>   	struct perf_insn x;
>> @@ -1073,31 +1077,31 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>>   	printed += fprintf(fp, "%c", '\n');
>>   
>>   	/* Handle first from jump, of which we don't know the entry. */
>> -	len = grab_bb(buffer, br->entries[nr-1].from,
>> -			br->entries[nr-1].from,
>> +	len = grab_bb(buffer, entries[nr-1].from,
>> +			entries[nr-1].from,
>>   			machine, thread, &x.is64bit, &x.cpumode, false);
>>   	if (len > 0) {
>> -		printed += ip__fprintf_sym(br->entries[nr - 1].from, thread,
>> +		printed += ip__fprintf_sym(entries[nr - 1].from, thread,
>>   					   x.cpumode, x.cpu, &lastsym, attr, fp);
>> -		printed += ip__fprintf_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
>> +		printed += ip__fprintf_jump(entries[nr - 1].from, &entries[nr - 1],
>>   					    &x, buffer, len, 0, fp, &total_cycles);
>>   		if (PRINT_FIELD(SRCCODE))
>> -			printed += print_srccode(thread, x.cpumode, br->entries[nr - 1].from);
>> +			printed += print_srccode(thread, x.cpumode, entries[nr - 1].from);
>>   	}
>>   
>>   	/* Print all blocks */
>>   	for (i = nr - 2; i >= 0; i--) {
>> -		if (br->entries[i].from || br->entries[i].to)
>> +		if (entries[i].from || entries[i].to)
>>   			pr_debug("%d: %" PRIx64 "-%" PRIx64 "\n", i,
>> -				 br->entries[i].from,
>> -				 br->entries[i].to);
>> -		start = br->entries[i + 1].to;
>> -		end   = br->entries[i].from;
>> +				 entries[i].from,
>> +				 entries[i].to);
>> +		start = entries[i + 1].to;
>> +		end   = entries[i].from;
>>   
>>   		len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, false);
>>   		/* Patch up missing kernel transfers due to ring filters */
>>   		if (len == -ENXIO && i > 0) {
>> -			end = br->entries[--i].from;
>> +			end = entries[--i].from;
>>   			pr_debug("\tpatching up to %" PRIx64 "-%" PRIx64 "\n", start, end);
>>   			len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, false);
>>   		}
>> @@ -1110,7 +1114,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>>   
>>   			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
>>   			if (ip == end) {
>> -				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, ++insn, fp,
>> +				printed += ip__fprintf_jump(ip, &entries[i], &x, buffer + off, len - off, ++insn, fp,
>>   							    &total_cycles);
>>   				if (PRINT_FIELD(SRCCODE))
>>   					printed += print_srccode(thread, x.cpumode, ip);
>> @@ -1134,9 +1138,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>>   	 * Hit the branch? In this case we are already done, and the target
>>   	 * has not been executed yet.
>>   	 */
>> -	if (br->entries[0].from == sample->ip)
>> +	if (entries[0].from == sample->ip)
>>   		goto out;
>> -	if (br->entries[0].flags.abort)
>> +	if (entries[0].flags.abort)
>>   		goto out;
>>   
>>   	/*
>> @@ -1147,7 +1151,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>>   	 * between final branch and sample. When this happens just
>>   	 * continue walking after the last TO until we hit a branch.
>>   	 */
>> -	start = br->entries[0].to;
>> +	start = entries[0].to;
>>   	end = sample->ip;
>>   	if (end < start) {
>>   		/* Missing jump. Scan 128 bytes for the next branch */
>> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
>> index 2762e1155238..14239e472187 100644
>> --- a/tools/perf/tests/sample-parsing.c
>> +++ b/tools/perf/tests/sample-parsing.c
>> @@ -99,6 +99,7 @@ static bool samples_same(const struct perf_sample *s1,
>>   
>>   	if (type & PERF_SAMPLE_BRANCH_STACK) {
>>   		COMP(branch_stack->nr);
>> +		COMP(branch_stack->hw_idx);
>>   		for (i = 0; i < s1->branch_stack->nr; i++)
>>   			MCOMP(branch_stack->entries[i]);
>>   	}
>> @@ -186,7 +187,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>>   		u64 data[64];
>>   	} branch_stack = {
>>   		/* 1 branch_entry */
>> -		.data = {1, 211, 212, 213},
>> +		.data = {1, -1ULL, 211, 212, 213},
>>   	};
>>   	u64 regs[64];
>>   	const u64 raw_data[] = {0x123456780a0b0c0dULL, 0x1102030405060708ULL};
>> @@ -208,6 +209,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>>   		.transaction	= 112,
>>   		.raw_data	= (void *)raw_data,
>>   		.callchain	= &callchain.callchain,
>> +		.no_hw_idx      = false,
>>   		.branch_stack	= &branch_stack.branch_stack,
>>   		.user_regs	= {
>>   			.abi	= PERF_SAMPLE_REGS_ABI_64,
>> @@ -244,6 +246,9 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>>   	if (sample_type & PERF_SAMPLE_REGS_INTR)
>>   		evsel.core.attr.sample_regs_intr = sample_regs;
>>   
>> +	if (sample_type & PERF_SAMPLE_BRANCH_STACK)
>> +		evsel.core.attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
>> +
>>   	for (i = 0; i < sizeof(regs); i++)
>>   		*(i + (u8 *)regs) = i & 0xfe;
>>   
>> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
>> index 88e00d268f6f..7fc9fa0dc361 100644
>> --- a/tools/perf/util/branch.h
>> +++ b/tools/perf/util/branch.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/stddef.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/types.h>
>> +#include "event.h"
>>   
>>   struct branch_flags {
>>   	u64 mispred:1;
>> @@ -39,9 +40,30 @@ struct branch_entry {
>>   
>>   struct branch_stack {
>>   	u64			nr;
>> +	u64			hw_idx;
>>   	struct branch_entry	entries[0];
>>   };
>>   
>> +/*
>> + * The hw_idx is only available when PERF_SAMPLE_BRANCH_HW_INDEX is applied.
>> + * Otherwise, the output format of a sample with branch stack is
>> + * struct branch_stack {
>> + *	u64			nr;
>> + *	struct branch_entry	entries[0];
>> + * }
>> + * Check whether the hw_idx is available,
>> + * and return the corresponding pointer of entries[0].
>> + */
>> +inline struct branch_entry *get_branch_entry(struct perf_sample *sample)
>> +{
>> +	u64 *entry = (u64 *)sample->branch_stack;
>> +
>> +	entry++;
>> +	if (sample->no_hw_idx)
>> +		return (struct branch_entry *)entry;
>> +	return (struct branch_entry *)(++entry);
>> +}
>> +
>>   struct branch_type_stat {
>>   	bool	branch_to;
>>   	u64	counts[PERF_BR_MAX];
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 5471045ebf5c..e697fe1c67b3 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -1202,6 +1202,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>>   	if (etm->synth_opts.last_branch) {
>>   		dummy_bs = (struct dummy_branch_stack){
>>   			.nr = 1,
>> +			.hw_idx = -1ULL,
>>   			.entries = {
>>   				.from = sample.ip,
>>   				.to = sample.addr,
> 
> This one breaks the build when cross building to arm64:
> 
>    CC       /tmp/build/perf/util/cs-etm.o
>    CC       /tmp/build/perf/util/parse-branch-options.o
>    CC       /tmp/build/perf/util/dump-insn.o
> util/cs-etm.c: In function 'cs_etm__synth_branch_sample':
> util/cs-etm.c:1205:5: error: 'struct dummy_branch_stack' has no member named 'hw_idx'
>      .hw_idx = -1ULL,
>       ^~~~~~
> util/cs-etm.c:1203:14: error: missing braces around initializer [-Werror=missing-braces]
>     dummy_bs = (struct dummy_branch_stack){
>                ^
> util/cs-etm.c:1205:14:
>      .hw_idx = -1ULL,
>                {    }
> util/cs-etm.c:1206:15: error: initialized field overwritten [-Werror=override-init]
>      .entries = {
>                 ^
> util/cs-etm.c:1206:15: note: (near initialization for '(anonymous).entries')
> util/cs-etm.c:1203:14: error: missing braces around initializer [-Werror=missing-braces]
>     dummy_bs = (struct dummy_branch_stack){
>                ^
> util/cs-etm.c:1205:14:
>      .hw_idx = -1ULL,
>                {    }
> cc1: all warnings being treated as errors
> mv: cannot stat '/tmp/build/perf/util/.cs-etm.o.tmp': No such file or directory
> 
> As that is 'struct dummy_branck_stack', not 'struct branch_stack', where you
> added that hw_idx, please check the logic, I'm adding the following quick fix
> and restarting the builds overnight, please check if this is the right thing to
> do.

Yes, it's correct. Thanks for the quick fix.

Thanks,
Kan

> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index e697fe1c67b3..b3b3fe3ea345 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1172,6 +1172,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>   	union perf_event *event = tidq->event_buf;
>   	struct dummy_branch_stack {
>   		u64			nr;
> +		u64			hw_idx;
>   		struct branch_entry	entries;
>   	} dummy_bs;
>   	u64 ip;
> 
>> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
>> index 85223159737c..3cda40a2fafc 100644
>> --- a/tools/perf/util/event.h
>> +++ b/tools/perf/util/event.h
>> @@ -139,6 +139,7 @@ struct perf_sample {
>>   	u16 insn_len;
>>   	u8  cpumode;
>>   	u16 misc;
>> +	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
>>   	char insn[MAX_INSN];
>>   	void *raw_data;
>>   	struct ip_callchain *callchain;
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index c8dc4450884c..05883a45de5b 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2169,7 +2169,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>   
>>   		if (data->branch_stack->nr > max_branch_nr)
>>   			return -EFAULT;
>> +
>>   		sz = data->branch_stack->nr * sizeof(struct branch_entry);
>> +		if (perf_evsel__has_branch_hw_idx(evsel))
>> +			sz += sizeof(u64);
>> +		else
>> +			data->no_hw_idx = true;
>>   		OVERFLOW_CHECK(array, sz, max_size);
>>   		array = (void *)array + sz;
>>   	}
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index dc14f4a823cd..99a0cb60c556 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -389,6 +389,11 @@ static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
>>   	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
>>   }
>>   
>> +static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
>> +{
>> +	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
>> +}
>> +
>>   static inline bool evsel__has_callchain(const struct evsel *evsel)
>>   {
>>   	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index ca5a8f4d007e..808ca27bd5cf 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -2584,9 +2584,10 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>>   			  u64 *total_cycles)
>>   {
>>   	struct branch_info *bi;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   
>>   	/* If we have branch cycles always annotate them. */
>> -	if (bs && bs->nr && bs->entries[0].flags.cycles) {
>> +	if (bs && bs->nr && entries[0].flags.cycles) {
>>   		int i;
>>   
>>   		bi = sample__resolve_bstack(sample, al);
>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>> index 33cf8928cf05..23c8289c2472 100644
>> --- a/tools/perf/util/intel-pt.c
>> +++ b/tools/perf/util/intel-pt.c
>> @@ -1295,6 +1295,7 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
>>   	struct perf_sample sample = { .ip = 0, };
>>   	struct dummy_branch_stack {
>>   		u64			nr;
>> +		u64			hw_idx;
>>   		struct branch_entry	entries;
>>   	} dummy_bs;
>>   
>> @@ -1316,6 +1317,7 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
>>   	if (pt->synth_opts.last_branch && sort__mode == SORT_MODE__BRANCH) {
>>   		dummy_bs = (struct dummy_branch_stack){
>>   			.nr = 1,
>> +			.hw_idx = -1ULL,
>>   			.entries = {
>>   				.from = sample.ip,
>>   				.to = sample.addr,
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index c8c5410315e8..62522b76a924 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -2083,15 +2083,16 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
>>   {
>>   	unsigned int i;
>>   	const struct branch_stack *bs = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	struct branch_info *bi = calloc(bs->nr, sizeof(struct branch_info));
>>   
>>   	if (!bi)
>>   		return NULL;
>>   
>>   	for (i = 0; i < bs->nr; i++) {
>> -		ip__resolve_ams(al->thread, &bi[i].to, bs->entries[i].to);
>> -		ip__resolve_ams(al->thread, &bi[i].from, bs->entries[i].from);
>> -		bi[i].flags = bs->entries[i].flags;
>> +		ip__resolve_ams(al->thread, &bi[i].to, entries[i].to);
>> +		ip__resolve_ams(al->thread, &bi[i].from, entries[i].from);
>> +		bi[i].flags = entries[i].flags;
>>   	}
>>   	return bi;
>>   }
>> @@ -2187,6 +2188,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
>>   	/* LBR only affects the user callchain */
>>   	if (i != chain_nr) {
>>   		struct branch_stack *lbr_stack = sample->branch_stack;
>> +		struct branch_entry *entries = get_branch_entry(sample);
>>   		int lbr_nr = lbr_stack->nr, j, k;
>>   		bool branch;
>>   		struct branch_flags *flags;
>> @@ -2212,31 +2214,29 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
>>   					ip = chain->ips[j];
>>   				else if (j > i + 1) {
>>   					k = j - i - 2;
>> -					ip = lbr_stack->entries[k].from;
>> +					ip = entries[k].from;
>>   					branch = true;
>> -					flags = &lbr_stack->entries[k].flags;
>> +					flags = &entries[k].flags;
>>   				} else {
>> -					ip = lbr_stack->entries[0].to;
>> +					ip = entries[0].to;
>>   					branch = true;
>> -					flags = &lbr_stack->entries[0].flags;
>> -					branch_from =
>> -						lbr_stack->entries[0].from;
>> +					flags = &entries[0].flags;
>> +					branch_from = entries[0].from;
>>   				}
>>   			} else {
>>   				if (j < lbr_nr) {
>>   					k = lbr_nr - j - 1;
>> -					ip = lbr_stack->entries[k].from;
>> +					ip = entries[k].from;
>>   					branch = true;
>> -					flags = &lbr_stack->entries[k].flags;
>> +					flags = &entries[k].flags;
>>   				}
>>   				else if (j > lbr_nr)
>>   					ip = chain->ips[i + 1 - (j - lbr_nr)];
>>   				else {
>> -					ip = lbr_stack->entries[0].to;
>> +					ip = entries[0].to;
>>   					branch = true;
>> -					flags = &lbr_stack->entries[0].flags;
>> -					branch_from =
>> -						lbr_stack->entries[0].from;
>> +					flags = &entries[0].flags;
>> +					branch_from = entries[0].from;
>>   				}
>>   			}
>>   
>> @@ -2283,6 +2283,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
>>   					    int max_stack)
>>   {
>>   	struct branch_stack *branch = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	struct ip_callchain *chain = sample->callchain;
>>   	int chain_nr = 0;
>>   	u8 cpumode = PERF_RECORD_MISC_USER;
>> @@ -2330,7 +2331,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
>>   
>>   		for (i = 0; i < nr; i++) {
>>   			if (callchain_param.order == ORDER_CALLEE) {
>> -				be[i] = branch->entries[i];
>> +				be[i] = entries[i];
>>   
>>   				if (chain == NULL)
>>   					continue;
>> @@ -2349,7 +2350,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
>>   				    be[i].from >= chain->ips[first_call] - 8)
>>   					first_call++;
>>   			} else
>> -				be[i] = branch->entries[branch->nr - i - 1];
>> +				be[i] = entries[branch->nr - i - 1];
>>   		}
>>   
>>   		memset(iter, 0, sizeof(struct iterations) * nr);
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
>> index 80ca5d0ab7fe..02b6c87c5abe 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -464,6 +464,7 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
>>   					struct thread *thread)
>>   {
>>   	struct branch_stack *br = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	PyObject *pylist;
>>   	u64 i;
>>   
>> @@ -484,28 +485,28 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
>>   			Py_FatalError("couldn't create Python dictionary");
>>   
>>   		pydict_set_item_string_decref(pyelem, "from",
>> -		    PyLong_FromUnsignedLongLong(br->entries[i].from));
>> +		    PyLong_FromUnsignedLongLong(entries[i].from));
>>   		pydict_set_item_string_decref(pyelem, "to",
>> -		    PyLong_FromUnsignedLongLong(br->entries[i].to));
>> +		    PyLong_FromUnsignedLongLong(entries[i].to));
>>   		pydict_set_item_string_decref(pyelem, "mispred",
>> -		    PyBool_FromLong(br->entries[i].flags.mispred));
>> +		    PyBool_FromLong(entries[i].flags.mispred));
>>   		pydict_set_item_string_decref(pyelem, "predicted",
>> -		    PyBool_FromLong(br->entries[i].flags.predicted));
>> +		    PyBool_FromLong(entries[i].flags.predicted));
>>   		pydict_set_item_string_decref(pyelem, "in_tx",
>> -		    PyBool_FromLong(br->entries[i].flags.in_tx));
>> +		    PyBool_FromLong(entries[i].flags.in_tx));
>>   		pydict_set_item_string_decref(pyelem, "abort",
>> -		    PyBool_FromLong(br->entries[i].flags.abort));
>> +		    PyBool_FromLong(entries[i].flags.abort));
>>   		pydict_set_item_string_decref(pyelem, "cycles",
>> -		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));
>> +		    PyLong_FromUnsignedLongLong(entries[i].flags.cycles));
>>   
>>   		thread__find_map_fb(thread, sample->cpumode,
>> -				    br->entries[i].from, &al);
>> +				    entries[i].from, &al);
>>   		dsoname = get_dsoname(al.map);
>>   		pydict_set_item_string_decref(pyelem, "from_dsoname",
>>   					      _PyUnicode_FromString(dsoname));
>>   
>>   		thread__find_map_fb(thread, sample->cpumode,
>> -				    br->entries[i].to, &al);
>> +				    entries[i].to, &al);
>>   		dsoname = get_dsoname(al.map);
>>   		pydict_set_item_string_decref(pyelem, "to_dsoname",
>>   					      _PyUnicode_FromString(dsoname));
>> @@ -561,6 +562,7 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
>>   					   struct thread *thread)
>>   {
>>   	struct branch_stack *br = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	PyObject *pylist;
>>   	u64 i;
>>   	char bf[512];
>> @@ -581,22 +583,22 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
>>   			Py_FatalError("couldn't create Python dictionary");
>>   
>>   		thread__find_symbol_fb(thread, sample->cpumode,
>> -				       br->entries[i].from, &al);
>> +				       entries[i].from, &al);
>>   		get_symoff(al.sym, &al, true, bf, sizeof(bf));
>>   		pydict_set_item_string_decref(pyelem, "from",
>>   					      _PyUnicode_FromString(bf));
>>   
>>   		thread__find_symbol_fb(thread, sample->cpumode,
>> -				       br->entries[i].to, &al);
>> +				       entries[i].to, &al);
>>   		get_symoff(al.sym, &al, true, bf, sizeof(bf));
>>   		pydict_set_item_string_decref(pyelem, "to",
>>   					      _PyUnicode_FromString(bf));
>>   
>> -		get_br_mspred(&br->entries[i].flags, bf, sizeof(bf));
>> +		get_br_mspred(&entries[i].flags, bf, sizeof(bf));
>>   		pydict_set_item_string_decref(pyelem, "pred",
>>   					      _PyUnicode_FromString(bf));
>>   
>> -		if (br->entries[i].flags.in_tx) {
>> +		if (entries[i].flags.in_tx) {
>>   			pydict_set_item_string_decref(pyelem, "in_tx",
>>   					      _PyUnicode_FromString("X"));
>>   		} else {
>> @@ -604,7 +606,7 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
>>   					      _PyUnicode_FromString("-"));
>>   		}
>>   
>> -		if (br->entries[i].flags.abort) {
>> +		if (entries[i].flags.abort) {
>>   			pydict_set_item_string_decref(pyelem, "abort",
>>   					      _PyUnicode_FromString("A"));
>>   		} else {
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index d0d7d25b23e3..dab985e3f136 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -1007,6 +1007,7 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
>>   {
>>   	struct ip_callchain *callchain = sample->callchain;
>>   	struct branch_stack *lbr_stack = sample->branch_stack;
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	u64 kernel_callchain_nr = callchain->nr;
>>   	unsigned int i;
>>   
>> @@ -1043,10 +1044,10 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
>>   			       i, callchain->ips[i]);
>>   
>>   		printf("..... %2d: %016" PRIx64 "\n",
>> -		       (int)(kernel_callchain_nr), lbr_stack->entries[0].to);
>> +		       (int)(kernel_callchain_nr), entries[0].to);
>>   		for (i = 0; i < lbr_stack->nr; i++)
>>   			printf("..... %2d: %016" PRIx64 "\n",
>> -			       (int)(i + kernel_callchain_nr + 1), lbr_stack->entries[i].from);
>> +			       (int)(i + kernel_callchain_nr + 1), entries[i].from);
>>   	}
>>   }
>>   
>> @@ -1068,6 +1069,7 @@ static void callchain__printf(struct evsel *evsel,
>>   
>>   static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>>   {
>> +	struct branch_entry *entries = get_branch_entry(sample);
>>   	uint64_t i;
>>   
>>   	printf("%s: nr:%" PRIu64 "\n",
>> @@ -1075,7 +1077,7 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>>   		sample->branch_stack->nr);
>>   
>>   	for (i = 0; i < sample->branch_stack->nr; i++) {
>> -		struct branch_entry *e = &sample->branch_stack->entries[i];
>> +		struct branch_entry *e = &entries[i];
>>   
>>   		if (!callstack) {
>>   			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x\n",
>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>> index c423298fe62d..dd3e6f43fb86 100644
>> --- a/tools/perf/util/synthetic-events.c
>> +++ b/tools/perf/util/synthetic-events.c
>> @@ -1183,7 +1183,8 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>>   
>>   	if (type & PERF_SAMPLE_BRANCH_STACK) {
>>   		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
>> -		sz += sizeof(u64);
>> +		/* nr, hw_idx */
>> +		sz += 2 * sizeof(u64);
>>   		result += sz;
>>   	}
>>   
>> @@ -1344,7 +1345,8 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>>   
>>   	if (type & PERF_SAMPLE_BRANCH_STACK) {
>>   		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
>> -		sz += sizeof(u64);
>> +		/* nr, hw_idx */
>> +		sz += 2 * sizeof(u64);
>>   		memcpy(array, sample->branch_stack, sz);
>>   		array = (void *)array + sz;
>>   	}
>> -- 
>> 2.17.1
>>
> 
