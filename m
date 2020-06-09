Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80051C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC1D2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgFISvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:51:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:53546 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFISva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:51:30 -0400
IronPort-SDR: BVBabLHmwSS5KJHCRUsjOKxy4t0JM4rfk0IcKOe+UBA0RPYsL8s189er3FMH609SFLsU4WHDij
 D1x7NrII3KZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 11:51:29 -0700
IronPort-SDR: jNteCUgJmuYJEfKlmx6qY6h/yczCWDGpL+55towu6/h1vx0dFkoEi9B2E2yeQqhp/ijsQRNVqd
 ARcKt0fNLPmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; 
   d="scan'208";a="260179919"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2020 11:51:29 -0700
Received: from [10.249.230.136] (abudanko-mobl.ccr.corp.intel.com [10.249.230.136])
        by linux.intel.com (Postfix) with ESMTP id 677D5580583;
        Tue,  9 Jun 2020 11:51:26 -0700 (PDT)
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
References: <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
 <20200605105051.GA1404794@krava> <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <345e3f6e-627d-89fc-364d-59f76071ccaa@linux.intel.com>
 <6a861ce4-3769-fc2a-5f9d-3003238a9736@linux.intel.com>
 <20200609145611.GI1558310@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0f556820-59d9-88aa-f1e6-997019ce0073@linux.intel.com>
Date:   Tue, 9 Jun 2020 21:51:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609145611.GI1558310@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.06.2020 17:56, Jiri Olsa wrote:
> On Mon, Jun 08, 2020 at 08:18:20PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>>>>>> So how is it about just adding _revents() and _del() for fixed fds with
>>>>>>> correction of retval to bool for fdarray__add()?
>>>>>>
>>>>>> I don't like the separation for fixed and non-fixed fds,
>>>>>> why can't we make generic?
>>>>>
>>>>> Usage models are different but they want still to be parts of the same class
>>>>> for atomic poll(). The distinction is filterable vs. not filterable.
>>>>> The distinction should be somehow provided in API. Options are:
>>>>> 1. expose separate API calls like __add_nonfilterable(), __del_nonfilterable();
>>>>>    use nonfilterable quality in __filter() and __poll() and, perhaps, other internals;
>>>>> 2. extend fdarray__add(, nonfilterable) with the nonfilterable quality
>>>>>    use the type in __filter() and __poll() and, perhaps, other internals;
>>>>>    expose less API calls in comparison with option 1
>>>>>
>>>>> Exposure of pos for filterable fds should be converted to bool since currently
>>>>> the returned pos can become stale and there is no way in API to check its state.
>>>>> So it could look like this:
>>>>>
>>>>> fdkey = fdarray__add(array, fd, events, type)
>>>>> type: filterable, nonfilterable, somthing else
>>>>> revents = fdarray__get_revents(fdkey);
>>>>> fdarray__del(array, fdkey);
>>>>
>>>> I think there's solution without having filterable type,
> 
> so with the changes I proposed it could no longer be called fdarray ;-)
> which I think was the idea at the begning.. just an array of fds
> 
> I'd like to have fully flaged events object.. but that's bigger change
> 
>>>
>>> and still making the atomic fdarray__poll()?
>>
>> How is it about design like this?
>>
>>     int fdarray__poll(struct fdarray *fda, int timeout)
>>
>> with additional external array of fds to simultaneously poll() on:
>>
>>     int fdarray__poll(struct fdarray *fda, int timeout,
>>                       int *fds, size_t fds_size)
>>
>> fds would be added to array just prior poll() call.
> 
> yep, I was considering something like this, having:
> 
>   fdarray__poll2(fda1, fda2)
>   fdarray__pollx(fda, ...)
> 
> but it would need to create an pollfd array and write
> the poll results back to arrays.. might be expensive

This is quite similar to currently proposed design options.
Saying expensive how do you estimate the cost?

> 
> another idea is to forbid filter to screw the array
> and return only remaining number, like below

Important thing with all this is to have atomic poll() on
all fds signalling to the tool in order to avoid tricky races
and complicated design covering them.

Signals can also be consumed via fd and recent pidfd kernel
extension can be subject for this general atomic poll().

So ideally it should look like this:
fdarray__poll(events_fds + ctl_fds + pid_fd + signal_fds)

~Alexey

