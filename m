Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9FC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC8420786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCXJaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:30:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:48654 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgCXJae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:30:34 -0400
IronPort-SDR: v2znpTQB3eJtJdRfdXFoAfgQE2DZlB5OTHd55fScwJy4hPu41IxbT9yMaUAZaVRcAPOQrChGAZ
 iYKYfyr8aA0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 02:30:34 -0700
IronPort-SDR: 1OYImAC0DclsHar7+GK4ODpVJmtGgaMQv3RRJKfFtRt1FYyHpx/Zbx7tVqlBA1zz3jOhDEkkjA
 8bEnj5c2A6VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,299,1580803200"; 
   d="scan'208";a="240215118"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga008.jf.intel.com with ESMTP; 24 Mar 2020 02:30:30 -0700
Subject: Re: [PATCH V4 00/13] perf/x86: Add perf text poke events
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
 <2daf9e8e-cd3a-8201-6443-8c17f215552e@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <25dee9c8-afcc-2541-6456-41ea17f9150b@intel.com>
Date:   Tue, 24 Mar 2020 11:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2daf9e8e-cd3a-8201-6443-8c17f215552e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/20 9:07 am, Adrian Hunter wrote:
> On 4/03/20 11:06 am, Adrian Hunter wrote:
>> Hi
>>
>> Here are patches to add a text poke event to record changes to kernel text
>> (i.e. self-modifying code) in order to support tracers like Intel PT
>> decoding through jump labels, kprobes and ftrace trampolines.
>>
>> The first 8 patches make the kernel changes and the subsequent patches are
>> tools changes.
>>
>> The next 4 patches add support for updating perf tools' data cache
>> with the changed bytes.
>>
>> The last patch is an Intel PT specific tools change.
>>
>> Patches also here:
>>
>> 	git://git.infradead.org/users/ahunter/linux-perf.git text_poke
> 
> Any comments?

Peter, do you have any comments on the first 2 patches?  They are pretty
much what we have already discussed.
