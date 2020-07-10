Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12960C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA5E20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGJLjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:39:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:38773 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJLjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:39:41 -0400
IronPort-SDR: U020MTDseJVQP2XmF3sdgYuIT45t9U2H627FiVBWE2KZZMWYdh7kSyTjnM/DkvjGHJUi4OmyMu
 gcsoDJ900PpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="213069824"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="213069824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 04:39:39 -0700
IronPort-SDR: nmSW/1qXDTwTPG2HtnjUC5giB701dq8DaNbi0+MuCjvYRGMVvUPWhPFBnfJ2XrBXNNKJbRtV1r
 LKiX2geot3Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="389502671"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2020 04:39:35 -0700
Subject: Re: [PATCH V7 15/15] perf script: Show text poke address symbol
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
 <20200512121922.8997-16-adrian.hunter@intel.com>
 <20200710113415.GA22500@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b68c6133-6079-43ef-fd98-9d0054ecc1c8@intel.com>
Date:   Fri, 10 Jul 2020 14:38:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200710113415.GA22500@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 2:34 pm, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 12, 2020 at 03:19:22PM +0300, Adrian Hunter escreveu:
>> It is generally more useful to show the symbol with an address. In this
>> case, the print function requires the 'machine' which means changing
>> callers to provide it as a parameter. It is optional because most events
>> do not need it and the callers that matter can provide it.
> 
> I'm just inverting the order of the parameters for
> perf_event__fprintf(), to keep as the first arg the pointer to the type
> that is the prefix for the function, i.e. instead of:
> 
> size_t perf_event__fprintf_text_poke(struct machine *machine,
> 				     union perf_event *event, FILE *fp)
> 
> I'll make it be:
> 
> size_t perf_event__fprintf_text_poke(union perf_event *event,
> 				     struct machine *machine,FILE *fp)
> 
> Ok?

Yup! Thank you!
