Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C33C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836DF2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBKBtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 20:49:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:9430 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbgBKBtD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:49:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 17:49:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,427,1574150400"; 
   d="scan'208";a="405790353"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.249.160.130]) ([10.249.160.130])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2020 17:48:59 -0800
Subject: Re: [PATCH] perf stat: Show percore counts in per CPU output
To:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <20200206015613.527-1-yao.jin@linux.intel.com>
 <20200210132804.GA9922@krava>
 <f749694f-b3b3-c498-74ea-ec2e6bb0d0f1@linux.intel.com>
 <20200210140120.GD9922@krava> <20200210170159.GV302770@tassilo.jf.intel.com>
 <20200210210419.GD36715@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d1eb5ce7-8c2c-3f15-5218-67de334897a6@linux.intel.com>
Date:   Tue, 11 Feb 2020 09:48:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210210419.GD36715@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2020 5:04 AM, Jiri Olsa wrote:
> On Mon, Feb 10, 2020 at 09:01:59AM -0800, Andi Kleen wrote:
>>>> With --percore-show-thread, CPU0 and CPU4 have the same counts (CPU0 and
>>>> CPU4 are siblings, e.g. 2,453,061 in my example). The value is sum of CPU0 +
>>>> CPU4.
>>>
>>> so it shows percore stats but displays all the cpus? what is this good for?
>>
>> This is essentially a replacement for the any bit (which is gone in Icelake).
>> Per core counts are useful for some formulas, e.g. CoreIPC
>>
>> The original percore version was inconvenient to post process. This
>> variant matches the output of the any bit.
> 
> I see, please put this to the changelog/doc
> 
> thanks,
> jirka
> 

Thanks Jiri, thanks Andi!

I will put the explanation in v2.

Thanks
Jin Yao
