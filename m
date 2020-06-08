Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A48C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DF02074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgFHPFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:05:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:54929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgFHPFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:05:55 -0400
IronPort-SDR: r5+z+c0js2ENdqaQ7ZqT1joNeQrMS12ndT2thXf94/lHgHLKaZvvL1qNJ3nIG1IPeK8AhVTXjG
 m+UjcoFHfBwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 08:05:54 -0700
IronPort-SDR: LRkKkFVX9sS2/zTHW18Q9QjcZyHNOsadTvcZYrE5DbIksld+ytT8i1vRFAXlS2qpvd994YYt/p
 b2WgjVkhZkxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="259828219"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2020 08:05:54 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id 28D36580458;
        Mon,  8 Jun 2020 08:05:51 -0700 (PDT)
Subject: Re: [PATCH v7 01/13] tools/libperf: introduce notion of static polled
 file descriptors
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
 <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
 <20200605105051.GA1404794@krava> <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ebbfc433-5691-2f48-e07e-b1e086472218@linux.intel.com>
Date:   Mon, 8 Jun 2020 18:05:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.06.2020 12:54, Alexey Budankov wrote:
> 
> On 08.06.2020 11:43, Jiri Olsa wrote:
>> On Mon, Jun 08, 2020 at 11:08:56AM +0300, Alexey Budankov wrote:
>>>
>>> On 05.06.2020 19:15, Alexey Budankov wrote:
>>>>
>>>> On 05.06.2020 14:38, Jiri Olsa wrote:
>>>>> On Fri, Jun 05, 2020 at 12:50:54PM +0200, Jiri Olsa wrote:
>>>>>> On Wed, Jun 03, 2020 at 06:52:59PM +0300, Alexey Budankov wrote:
>>>>>>>
>>>>>>> Implement adding of file descriptors by fdarray__add_stat() to
>>>>>>> fix-sized (currently 1) stat_entries array located at struct fdarray.
>>>>>>> Append added file descriptors to the array used by poll() syscall
>>>>>>> during fdarray__poll() call. Copy poll() result of the added
>>>>>>> descriptors from the array back to the storage for analysis.
>>>>>>>
>>>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>>>> ---
<SNIP>
>>>>>>> +					   fda->stat_entries[i].events);
>>>>>>
>>>>>> so every call to fdarray__poll will add whatever is
>>>>>> in stat_entries to entries? how is it removed?
>>>>>>
>>>>>> I think you should either follow what Adrian said
>>>>>> and put 'static' descriptors early and check for
>>>>>> filter number to match it as an 'quick fix'
>>>>>>
>>>>>> or we should fix it for real and make it generic
>>>>>>
>>>>>> so currently the interface is like this:
>>>>>>
>>>>>>   pos1 = fdarray__add(a, fd1 ... );
>>>>>>   pos2 = fdarray__add(a, fd2 ... );
>>>>>>   pos3 = fdarray__add(a, fd2 ... );
>>>>>>
>>>>>>   fdarray__poll(a);
>>>>>>
>>>>>>   num = fdarray__filter(a, revents, destructor, arg);
>>>>>>
>>>>>> when fdarray__filter removes some of the fds the 'pos1,pos2,pos3'
>>>>>> indexes are not relevant anymore
>>>>
>>>> and that is why the return value of fdarray__add() should be converted
>>>> to bool (added/not added). Currently the return value is used as bool
>>>> only allover the calling code.
>>>>
>>>> fdarray__add_fixed() brings the notion of fd with fixed pos which is
>>>> valid after fdarray__add_fixed() call so the pos could be used to access
>>>> pos fd poll status after poll() call.
>>>>
>>>> pos = fdarray__add_fixed(array, fd);
>>>> fdarray_poll(array);
>>>> revents = fdarray_fixed_revents(array, pos);
>>>> fdarray__del(array, pos);
>>>
>>> So how is it about just adding _revents() and _del() for fixed fds with
>>> correction of retval to bool for fdarray__add()?
>>
>> I don't like the separation for fixed and non-fixed fds,
>> why can't we make generic?
> 
> Usage models are different but they want still to be parts of the same class
> for atomic poll(). The distinction is filterable vs. not filterable.
> The distinction should be somehow provided in API. Options are:
> 1. expose separate API calls like __add_nonfilterable(), __del_nonfilterable();
>    use nonfilterable quality in __filter() and __poll() and, perhaps, other internals;
> 2. extend fdarray__add(, nonfilterable) with the nonfilterable quality
>    use the type in __filter() and __poll() and, perhaps, other internals;
>    expose less API calls in comparison with option 1
> 
> Exposure of pos for filterable fds should be converted to bool since currently
> the returned pos can become stale and there is no way in API to check its state.
> So it could look like this:
> 
> fdkey = fdarray__add(array, fd, events, type)
> type: filterable, nonfilterable, somthing else
> revents = fdarray__get_revents(fdkey);
> fdarray__del(array, fdkey);

Are there any thoughts regarding this?

~Alexey
