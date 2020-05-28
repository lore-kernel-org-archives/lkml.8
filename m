Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BD9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E5421475
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgE1H7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:59:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:17342 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgE1H7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:59:18 -0400
IronPort-SDR: LSSGo7e/mPDd8n8AS1G+2RUx0fBRHEfIMKWQAPI055ZE/1GTD8zAwfxNVI1Hh75uPQpro+LDjF
 0ZBbsSjs8B0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 00:59:17 -0700
IronPort-SDR: uA22schnODGB7VawxSgXdwQGKqWAhOhJSX5RxNNbBbG+fSzWFNyhKwNzshopI4FYwfwrCCYHI4
 Hs9kZ2TSoGIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="469029754"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga005.fm.intel.com with ESMTP; 28 May 2020 00:59:07 -0700
Subject: Re: [PATCH V7 04/15] kprobes: Add perf ksymbol events for kprobe insn
 pages
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <20200512121922.8997-5-adrian.hunter@intel.com>
 <20200527161732.GA706495@hirez.programming.kicks-ass.net>
 <20200527172011.GA706518@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b9609bc3-2aee-9bf3-87bf-38a8f3d60eee@intel.com>
Date:   Thu, 28 May 2020 10:58:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527172011.GA706518@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 8:20 pm, Peter Zijlstra wrote:
> On Wed, May 27, 2020 at 06:17:32PM +0200, Peter Zijlstra wrote:
>> On Tue, May 12, 2020 at 03:19:11PM +0300, Adrian Hunter wrote:
>>> @@ -202,6 +207,13 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
>>>  		 * next time somebody inserts a probe.
>>>  		 */
>>>  		if (!list_is_singular(&kip->list)) {
>>> +			/*
>>> +			 * Record perf ksymbol unregister event before removing
>>> +			 * the page.
>>> +			 */
>>> +			perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
>>> +					   (u64)kip->insns, PAGE_SIZE, true,
>>> +					   kip->cache->sym);
>>>  			list_del_rcu(&kip->list);
>>>  			synchronize_rcu();
>>>  			kip->cache->free(kip->insns);
>>
>> My manual build script haz complaints:
>>
>> i386-defconfig  ../kernel/kprobes.c: In function ‘__get_insn_slot’:
>> ../kernel/kprobes.c:190:51: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>> perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)kip->insns,
>> ^
>> ../kernel/kprobes.c: In function ‘collect_one_slot’:
>> ../kernel/kprobes.c:215:9: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>> (u64)kip->insns, PAGE_SIZE, true,
>> ^
>> FAIL
>>
>>
>> Now, there's a ton of such warnings elsewhere in the tree, but still I
>> feel we should perhaps strive for a clean build.
> 
> Fixed those for you. On to cross-builds... :/
> 

Thank you!
