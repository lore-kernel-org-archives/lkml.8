Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4D1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98482065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgGHL4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:56:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:16973 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbgGHL4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:56:20 -0400
IronPort-SDR: V5cYHhqw5dMkIVzPyqDcivJICn6TpytbZ3tCJnougu++MHHRoZyy9UuZ1egT5uFDniG3BCiD2n
 Ez0sff+cFngg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="136010711"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="136010711"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 04:56:19 -0700
IronPort-SDR: JTmqEsPKG7c2Ui1Jb6NbjcV9xBhXiQKx2WxYM8F1sfEhJZ6YSc/v1OgSvMtv+8hoF7S9Oc75a9
 xRJW0nFNfsHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="457478440"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2020 04:56:17 -0700
Subject: Re: [PATCH V7 00/15] perf/x86: Add perf text poke events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <bee04840-143c-18bb-df82-5aa58d70730e@intel.com>
 <20200520014001.GF28228@kernel.org>
 <20200520155634.GQ317569@hirez.programming.kicks-ass.net>
 <20200527154716.GC16490@kernel.org>
 <20200527155436.GA706460@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <79ca46d6-5d7c-7729-b51e-f9a447abe2a2@intel.com>
Date:   Wed, 8 Jul 2020 14:55:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527155436.GA706460@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 6:54 pm, Peter Zijlstra wrote:
> On Wed, May 27, 2020 at 12:47:16PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, May 20, 2020 at 05:56:34PM +0200, Peter Zijlstra escreveu:
>>> On Tue, May 19, 2020 at 10:40:01PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> PeterZ, from what we discussed for the next merge Window, perhaps we
>>>> should route the kernel bits via the tip tree while I will push the
>>>> tooling bits on my 5.8 merge request to Linus, Ok?
>>>
>>> Sure, I can take the kernel bits. Thanks!
>>
>> So, I'm going thru the userpace bits and stopped at the patch copying
>> include/uapi/linux/perf_events.h to
>> tools/include/uapi/linux/perf_events.h to get the text_poke
>> perf_event_attr bit, looked at tip/ and this hasn't landed there yet,
>> any issues with the kernel bits?
> 
> Nah, I was waiting on the 0day robot, but its broken *again* :-(
> 
> Let me go move things along manually.
> 

Hi

The kernel patches are in tip and the remaining tools patches still apply.
Remaining patches 11-15 are:

      perf tools: Add support for PERF_RECORD_TEXT_POKE
      perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
      perf intel-pt: Add support for text poke events
      perf script: Add option --show-text-poke-events
      perf script: Show text poke address symbol

Is there anything else I can do for these?

Regards
Adrian
