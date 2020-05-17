Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC953C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 13:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD9120727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 13:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgEQNQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 09:16:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:39668 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEQNQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 09:16:37 -0400
IronPort-SDR: DFlw8e1o+WHH2jeI38efaqFE2zt8ucTCRnPH57TZTW8DuyulRG/QRmPSwPR2c4cK6iqjQmf30Z
 pMPtl3zEXRrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 06:16:36 -0700
IronPort-SDR: zhQWz6zJtdh7KjcmjnZKRjeXHNtHBqtNt3KExXT8g1fzGRy1IuLP23L6G3vJftLQ6AvuYdON9u
 n6dyaOResZ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,403,1583222400"; 
   d="scan'208";a="263688852"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2020 06:16:33 -0700
Subject: Re: [PATCH V7 00/15] perf/x86: Add perf text poke events
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bee04840-143c-18bb-df82-5aa58d70730e@intel.com>
Date:   Sun, 17 May 2020 16:16:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/20 3:19 pm, Adrian Hunter wrote:
> Hi
> 
> Here are patches to add a text poke event to record changes to kernel text
> (i.e. self-modifying code) in order to support tracers like Intel PT
> decoding through jump labels, kprobes and ftrace trampolines.
> 
> The first 8 patches make the kernel changes and the subsequent patches are
> tools changes.
> 
> The next 4 patches add support for updating perf tools' data cache
> with the changed bytes.
> 
> The next patch is an Intel PT specific tools change.
> 
> The final 2 patches add perf script --show-text-poke-events option
> 
> Patches also here:
> 
> 	git://git.infradead.org/users/ahunter/linux-perf.git text_poke
> 
> Changes in V7
> 
>   perf: Add perf text poke event
>   perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
>   kprobes: Add symbols for kprobe insn pages
>   kprobes: Add perf ksymbol events for kprobe insn pages
>   perf/x86: Add perf text poke events for kprobes
>   ftrace: Add symbols for ftrace trampolines
>   ftrace: Add perf ksymbol events for ftrace trampolines
>   ftrace: Add perf text poke events for ftrace trampolines
> 
> 	Added Peter's Ack
> 	Improved commit message for text_poke events for ftrace trampolines
> 
>   perf kcore_copy: Fix module map when there are no modules loaded
>   perf evlist: Disable 'immediate' events last
>   perf tools: Add support for PERF_RECORD_TEXT_POKE
>   perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
>   perf intel-pt: Add support for text poke events
>   perf script: Add option --show-text-poke-events
>   perf script: Show text poke address symbol
> 
> 	Re-based on Arnaldo's perf/core branch
> 

Arnaldo, any comments on the tools patches?
