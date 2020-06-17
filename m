Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBE9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE225207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFQJkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:40:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:1552 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQJkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:40:00 -0400
IronPort-SDR: Lm54+dSbrZvU8BdOle+W6UES7HSD1BkCP5eZ/QJ70ubPufPRKnAUlCwbBrB4ipervfDB/rrRsE
 PjHhWF6UBh4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 02:39:59 -0700
IronPort-SDR: qtYX9FlNTIfI+G036Jcw/EpYV4Ng2tQWlmj4nY+/Ah4sxHyiKHP+KwIcusIbAqiizNCHxnNMV+
 MBPuJZQ4d8Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="277222463"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2020 02:39:59 -0700
Received: from [10.249.225.191] (abudanko-mobl.ccr.corp.intel.com [10.249.225.191])
        by linux.intel.com (Postfix) with ESMTP id 7913B5802A3;
        Wed, 17 Jun 2020 02:39:57 -0700 (PDT)
Subject: Re: [PATCH v7 01/13] tools/libperf: introduce notion of static polled
 file descriptors
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <bde9bcc3-9ec0-6e37-26f6-139b038ad3de@linux.intel.com>
 <20200615123048.GB2088119@krava>
 <8b29e324-eb8d-2266-562b-ca46aec76a3e@linux.intel.com>
 <20200615165802.GD2088119@krava> <20200617092706.GB2210496@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2818512e-e383-e2be-73ea-92a8b596e593@linux.intel.com>
Date:   Wed, 17 Jun 2020 12:39:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617092706.GB2210496@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17.06.2020 12:27, Jiri Olsa wrote:
> On Mon, Jun 15, 2020 at 06:58:04PM +0200, Jiri Olsa wrote:
>> On Mon, Jun 15, 2020 at 05:37:53PM +0300, Alexey Budankov wrote:
>>>
>>> On 15.06.2020 15:30, Jiri Olsa wrote:
>>>> On Mon, Jun 15, 2020 at 08:20:38AM +0300, Alexey Budankov wrote:
>>>>>
>>>>> On 08.06.2020 19:07, Jiri Olsa wrote:
>>>>>> On Mon, Jun 08, 2020 at 12:54:31PM +0300, Alexey Budankov wrote:
>>>>>>>
>>>>>>> On 08.06.2020 11:43, Jiri Olsa wrote:
>>>>>>>> On Mon, Jun 08, 2020 at 11:08:56AM +0300, Alexey Budankov wrote:
>>>>>>>>>
>>>>>>>>> On 05.06.2020 19:15, Alexey Budankov wrote:
>>>>>>>>>>
>>>>>>>>>> On 05.06.2020 14:38, Jiri Olsa wrote:
>>>>> <SNIP>
>>>>>>>>>> revents = fdarray_fixed_revents(array, pos);
>>>>>>>>>> fdarray__del(array, pos);
>>>>>>>>>
>>>>>>>>> So how is it about just adding _revents() and _del() for fixed fds with
>>>>>>>>> correction of retval to bool for fdarray__add()?
>>>>>>>>
>>>>>>>> I don't like the separation for fixed and non-fixed fds,
>>>>>>>> why can't we make generic?
>>>>>>>
>>>>>>> Usage models are different but they want still to be parts of the same class
>>>>>>> for atomic poll(). The distinction is filterable vs. not filterable.
>>>>>>> The distinction should be somehow provided in API. Options are:
>>>>>>> 1. expose separate API calls like __add_nonfilterable(), __del_nonfilterable();
>>>>>>>    use nonfilterable quality in __filter() and __poll() and, perhaps, other internals;
>>>>>>> 2. extend fdarray__add(, nonfilterable) with the nonfilterable quality
>>>>>>>    use the type in __filter() and __poll() and, perhaps, other internals;
>>>>>>>    expose less API calls in comparison with option 1
>>>>>>>
>>>>>>> Exposure of pos for filterable fds should be converted to bool since currently
>>>>>>> the returned pos can become stale and there is no way in API to check its state.
>>>>>>> So it could look like this:
>>>>>>>
>>>>>>> fdkey = fdarray__add(array, fd, events, type)
>>>>>>> type: filterable, nonfilterable, somthing else
>>>>>>> revents = fdarray__get_revents(fdkey);
>>>>>>> fdarray__del(array, fdkey);
>>>>>>
>>>>>> I think there's solution without having filterable type,
>>>>>> I'm not sure why you think this is needed
>>>>>>
>>>>>> I'm busy with other things this week, but I think I can
>>>>>> come up with some patch early next week if needed
>>>>>
>>>>> Friendly reminder.
>>>>
>>>> hm? I believe we discussed this in here:
>>>>   https://lore.kernel.org/lkml/20200609145611.GI1558310@krava/
>>>
>>> Do you want it to be implemented like in the patch posted by the link?
>>
>> no idea.. looking for good solution ;-)
> 
> Friendly reminder.

Please see v8: https://lore.kernel.org/lkml/0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com/

~Alexey
