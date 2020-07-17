Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2385DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000322070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGQGGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:06:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:49732 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgGQGGz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:06:55 -0400
IronPort-SDR: eZh1oPQR0rLjrA0I4kzMRbjAjxfIzX20B3k5yAnGPn65BAq54aOxF68d6V+QLhsRZxoM4iXQHs
 H0C0JFdwxVEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="149529434"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="149529434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:06:54 -0700
IronPort-SDR: ptPEv6rJ2eJvTWc5xj8k8WqCMpUnD7bRj4njTtJb0dquww5TJ7sejdQdyiJ3h0pMeieGmmZntn
 OU4RTCI4rIHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="318674249"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2020 23:06:52 -0700
Subject: Re: [PATCH 0/2] Update CascadelakeX and SkylakeX events list
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
References: <20200603021818.27028-1-yao.jin@linux.intel.com>
 <911b4132-d1a1-f3c4-a2ed-2fcfe9a28fc6@linux.intel.com>
 <CAP-5=fW3OCuVkQ8csYfHXj5c_pCSY5-6vDrj2r=MNDZmpo0f8g@mail.gmail.com>
 <c7edd282-f58a-4efe-5961-6c1369b6b77b@linux.intel.com>
 <20200616193856.GC6393@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <681a333b-e4dc-9481-715e-a65a34e10f83@linux.intel.com>
Date:   Fri, 17 Jul 2020 14:06:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200616193856.GC6393@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/17/2020 3:38 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 16, 2020 at 02:27:40PM +0800, Jin, Yao escreveu:
>> On 6/16/2020 2:16 PM, Ian Rogers wrote:
>>> On Mon, Jun 15, 2020 at 6:00 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>>>> Can I get an ACK for this patchset?
>>>> On 6/3/2020 10:18 AM, Jin Yao wrote:
>>>>> This patchset updates CascadelakeX events to v1.08 and
>>>>> updates SkylakeX events to v1.21.
> 
>>>>> The events have been tested on CascadelakeX and SkylakeX
>>>>> servers with latest perf/core branch.
> 
>>> could you rebase this on Arnaldo's tmp.perf/core tree?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core
>>> I tried using git am but get:
>>> Applying: perf vendor events: Update CascadelakeX events to v1.08
>>> error: patch fragment without header at line 279: @@ -213,14 +220,14 @@
>>> error: could not build fake ancestor
>>> Patch failed at 0001 perf vendor events: Update CascadelakeX events to v1.08
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> The patchset are applied OK on perf/core branch.
>>
>> As far as I understand, the patch for posting should be based on perf/core branch, is it right?
> 
> Sorry, I've been testing with using tmp.perf/core as a way to more
> quickly make available what I've processed, before I test it thoroughly
> both with container builds and with manual testing, so the bleeding edge
> is there, perf/core becoming a bit more stable, as I'll try not to
> rebase it like before.
> 
> - Arnaldo
> 

Can this event update be accepted?

Thanks
Jin Yao
