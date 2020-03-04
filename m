Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365E2C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A59B215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgCDQHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:07:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:51651 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDQHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:07:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 08:07:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="258805368"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 04 Mar 2020 08:07:46 -0800
Received: from [10.251.18.151] (kliang2-mobl.ccr.corp.intel.com [10.251.18.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E833A5802A4;
        Wed,  4 Mar 2020 08:07:44 -0800 (PST)
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
 <20200304134902.GB12612@kernel.org> <20200304154552.GB2854@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d0888c78-a610-57e4-245b-170db295d93c@linux.intel.com>
Date:   Wed, 4 Mar 2020 11:07:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304154552.GB2854@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/2020 10:45 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 04, 2020 at 10:49:02AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Feb 28, 2020 at 08:30:00AM -0800, kan.liang@linux.intel.com escreveu:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>> The low level index of raw branch records for the most recent branch can
>>> be recorded in a sample with PERF_SAMPLE_BRANCH_HW_INDEX
>>> branch_sample_type. Extend struct branch_stack to support it.
> 
>>> However, if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied, only nr and
>>> entries[] will be output by kernel. The pointer of entries[] could be
>>> wrong, since the output format is different with new struct branch_stack.
>>> Add a variable no_hw_idx in struct perf_sample to indicate whether the
>>> hw_idx is output.
>>> Add get_branch_entry() to return corresponding pointer of entries[0].
>    
>> This should be broken up in at least two patches, one that syncs
>> tools/include/uapi/linux/perf_event.h with the kernel, and another to do
>> what this changeset log message states, I'll do it this time to expedite
>> processing of this patchset, please do it that way next time.
>

Thanks. I will keep it in mind.

> So, after doing that split I'm also suggesting/tentatively applying this
> patch on top of it, to keep the naming convention we have in tools/perf,
> and also the 'static' to that inline, 

Thanks. The changes look good to me.

Thanks,
Kan

> please holler if you disagree,
> I'll put the end result in a branch for further visualization/comments.
> 
> At some point these functions obtaining stuff from a 'struct perf_sample' to
> tools/lib/perf/ (aka libperf), so better go doing proper namespacing,
> etc, right Jiri?
> 
> - Arnaldo
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index acf3107bbda2..656b347f6dd8 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -735,7 +735,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>   					struct perf_event_attr *attr, FILE *fp)
>   {
>   	struct branch_stack *br = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	struct addr_location alf, alt;
>   	u64 i, from, to;
>   	int printed = 0;
> @@ -783,7 +783,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>   					   struct perf_event_attr *attr, FILE *fp)
>   {
>   	struct branch_stack *br = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	struct addr_location alf, alt;
>   	u64 i, from, to;
>   	int printed = 0;
> @@ -829,7 +829,7 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>   					   struct perf_event_attr *attr, FILE *fp)
>   {
>   	struct branch_stack *br = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	struct addr_location alf, alt;
>   	u64 i, from, to;
>   	int printed = 0;
> @@ -1056,7 +1056,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>   					    struct machine *machine, FILE *fp)
>   {
>   	struct branch_stack *br = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	u64 start, end;
>   	int i, insn, len, nr, ilen, printed = 0;
>   	struct perf_insn x;
> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
> index 014c3cd4cb32..154a05cd03af 100644
> --- a/tools/perf/util/branch.h
> +++ b/tools/perf/util/branch.h
> @@ -54,7 +54,7 @@ struct branch_stack {
>    * Check whether the hw_idx is available,
>    * and return the corresponding pointer of entries[0].
>    */
> -inline struct branch_entry *get_branch_entry(struct perf_sample *sample)
> +static inline struct branch_entry *perf_sample__branch_entries(struct perf_sample *sample)
>   {
>   	u64 *entry = (u64 *)sample->branch_stack;
>   
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 808ca27bd5cf..e74a5acf66d9 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2584,7 +2584,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>   			  u64 *total_cycles)
>   {
>   	struct branch_info *bi;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   
>   	/* If we have branch cycles always annotate them. */
>   	if (bs && bs->nr && entries[0].flags.cycles) {
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index b0623f99fb9c..fd14f1489802 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2081,7 +2081,7 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
>   {
>   	unsigned int i;
>   	const struct branch_stack *bs = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	struct branch_info *bi = calloc(bs->nr, sizeof(struct branch_info));
>   
>   	if (!bi)
> @@ -2186,7 +2186,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
>   	/* LBR only affects the user callchain */
>   	if (i != chain_nr) {
>   		struct branch_stack *lbr_stack = sample->branch_stack;
> -		struct branch_entry *entries = get_branch_entry(sample);
> +		struct branch_entry *entries = perf_sample__branch_entries(sample);
>   		int lbr_nr = lbr_stack->nr, j, k;
>   		bool branch;
>   		struct branch_flags *flags;
> @@ -2281,7 +2281,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
>   					    int max_stack)
>   {
>   	struct branch_stack *branch = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	struct ip_callchain *chain = sample->callchain;
>   	int chain_nr = 0;
>   	u8 cpumode = PERF_RECORD_MISC_USER;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 02b6c87c5abe..8c1b27cd8b99 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -464,7 +464,7 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
>   					struct thread *thread)
>   {
>   	struct branch_stack *br = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	PyObject *pylist;
>   	u64 i;
>   
> @@ -562,7 +562,7 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
>   					   struct thread *thread)
>   {
>   	struct branch_stack *br = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	PyObject *pylist;
>   	u64 i;
>   	char bf[512];
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index dab985e3f136..055b00abd56d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1007,7 +1007,7 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
>   {
>   	struct ip_callchain *callchain = sample->callchain;
>   	struct branch_stack *lbr_stack = sample->branch_stack;
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	u64 kernel_callchain_nr = callchain->nr;
>   	unsigned int i;
>   
> @@ -1069,7 +1069,7 @@ static void callchain__printf(struct evsel *evsel,
>   
>   static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>   {
> -	struct branch_entry *entries = get_branch_entry(sample);
> +	struct branch_entry *entries = perf_sample__branch_entries(sample);
>   	uint64_t i;
>   
>   	printf("%s: nr:%" PRIu64 "\n",
> 
