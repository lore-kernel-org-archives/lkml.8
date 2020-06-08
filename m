Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E1AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A1A206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgFHQng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:43:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:54613 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgFHQng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:43:36 -0400
IronPort-SDR: rIh6n8OVaqIMo9OZO5dK7NGmjU1GaAUH6rKxKR5SzeukpTpeDPQo/VA1jGCBR1YUVoVvfRtPmQ
 kGMgi/v90vfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 09:43:34 -0700
IronPort-SDR: QYScgKYI1XZ1OHVPJDkPjLM3IidF2MYbz0JYgObUdKhfpWwbAg6CV7Rmf4LsihlnajAry4Vy5y
 Um+77JuQ3Pbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="295521094"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2020 09:43:34 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id 0AB5D580458;
        Mon,  8 Jun 2020 09:43:31 -0700 (PDT)
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
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
 <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
 <20200605105051.GA1404794@krava> <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <345e3f6e-627d-89fc-364d-59f76071ccaa@linux.intel.com>
Date:   Mon, 8 Jun 2020 19:43:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200608160758.GD1558310@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.06.2020 19:07, Jiri Olsa wrote:
> On Mon, Jun 08, 2020 at 12:54:31PM +0300, Alexey Budankov wrote:
>>
>> On 08.06.2020 11:43, Jiri Olsa wrote:
>>> On Mon, Jun 08, 2020 at 11:08:56AM +0300, Alexey Budankov wrote:
>>>>
>>>> On 05.06.2020 19:15, Alexey Budankov wrote:
>>>>>
>>>>> On 05.06.2020 14:38, Jiri Olsa wrote:
>>>>>> On Fri, Jun 05, 2020 at 12:50:54PM +0200, Jiri Olsa wrote:
>>>>>>> On Wed, Jun 03, 2020 at 06:52:59PM +0300, Alexey Budankov wrote:
>>>>>>>>
>>>>>>>> Implement adding of file descriptors by fdarray__add_stat() to
>>>>>>>> fix-sized (currently 1) stat_entries array located at struct fdarray.
>>>>>>>> Append added file descriptors to the array used by poll() syscall
>>>>>>>> during fdarray__poll() call. Copy poll() result of the added
>>>>>>>> descriptors from the array back to the storage for analysis.
>>>>>>>>
>>>>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>>>>> ---
>>>>>>>>  tools/lib/api/fd/array.c                 | 42 +++++++++++++++++++++++-
>>>>>>>>  tools/lib/api/fd/array.h                 |  7 ++++
>>>>>>>>  tools/lib/perf/evlist.c                  | 11 +++++++
>>>>>>>>  tools/lib/perf/include/internal/evlist.h |  2 ++
>>>>>>>>  4 files changed, 61 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
>>>>>>>> index 58d44d5eee31..b0027f2169c7 100644
>>>>>>>> --- a/tools/lib/api/fd/array.c
>>>>>>>> +++ b/tools/lib/api/fd/array.c
>>>>>>>> @@ -11,10 +11,16 @@
>>>>>>>>  
>>>>>>>>  void fdarray__init(struct fdarray *fda, int nr_autogrow)
>>>>>>>>  {
>>>>>>>> +	int i;
>>>>>>>> +
>>>>>>>>  	fda->entries	 = NULL;
>>>>>>>>  	fda->priv	 = NULL;
>>>>>>>>  	fda->nr		 = fda->nr_alloc = 0;
>>>>>>>>  	fda->nr_autogrow = nr_autogrow;
>>>>>>>> +
>>>>>>>> +	fda->nr_stat = 0;
>>>>>>>> +	for (i = 0; i < FDARRAY__STAT_ENTRIES_MAX; i++)
>>>>>>>> +		fda->stat_entries[i].fd = -1;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>>  int fdarray__grow(struct fdarray *fda, int nr)
>>>>>>>> @@ -83,6 +89,20 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
>>>>>>>>  	return pos;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
>>>>>>>> +{
>>>>>>>> +	int pos = fda->nr_stat;
>>>>>>>> +
>>>>>>>> +	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
>>>>>>>> +		return -1;
>>>>>>>> +
>>>>>>>> +	fda->stat_entries[pos].fd = fd;
>>>>>>>> +	fda->stat_entries[pos].events = revents;
>>>>>>>> +	fda->nr_stat++;
>>>>>>>> +
>>>>>>>> +	return pos;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  int fdarray__filter(struct fdarray *fda, short revents,
>>>>>>>>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>>>>>>>>  		    void *arg)
>>>>>>>> @@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
>>>>>>>>  
>>>>>>>>  int fdarray__poll(struct fdarray *fda, int timeout)
>>>>>>>>  {
>>>>>>>> -	return poll(fda->entries, fda->nr, timeout);
>>>>>>>> +	int nr, i, pos, res;
>>>>>>>> +
>>>>>>>> +	nr = fda->nr;
>>>>>>>> +
>>>>>>>> +	for (i = 0; i < fda->nr_stat; i++) {
>>>>>>>> +		if (fda->stat_entries[i].fd != -1) {
>>>>>>>> +			pos = fdarray__add(fda, fda->stat_entries[i].fd,
>>>>>>>> +					   fda->stat_entries[i].events);
>>>>>>>
>>>>>>> so every call to fdarray__poll will add whatever is
>>>>>>> in stat_entries to entries? how is it removed?
>>>>>>>
>>>>>>> I think you should either follow what Adrian said
>>>>>>> and put 'static' descriptors early and check for
>>>>>>> filter number to match it as an 'quick fix'
>>>>>>>
>>>>>>> or we should fix it for real and make it generic
>>>>>>>
>>>>>>> so currently the interface is like this:
>>>>>>>
>>>>>>>   pos1 = fdarray__add(a, fd1 ... );
>>>>>>>   pos2 = fdarray__add(a, fd2 ... );
>>>>>>>   pos3 = fdarray__add(a, fd2 ... );
>>>>>>>
>>>>>>>   fdarray__poll(a);
>>>>>>>
>>>>>>>   num = fdarray__filter(a, revents, destructor, arg);
>>>>>>>
>>>>>>> when fdarray__filter removes some of the fds the 'pos1,pos2,pos3'
>>>>>>> indexes are not relevant anymore
>>>>>
>>>>> and that is why the return value of fdarray__add() should be converted
>>>>> to bool (added/not added). Currently the return value is used as bool
>>>>> only allover the calling code.
>>>>>
>>>>> fdarray__add_fixed() brings the notion of fd with fixed pos which is
>>>>> valid after fdarray__add_fixed() call so the pos could be used to access
>>>>> pos fd poll status after poll() call.
>>>>>
>>>>> pos = fdarray__add_fixed(array, fd);
>>>>> fdarray_poll(array);
>>>>> revents = fdarray_fixed_revents(array, pos);
>>>>> fdarray__del(array, pos);
>>>>
>>>> So how is it about just adding _revents() and _del() for fixed fds with
>>>> correction of retval to bool for fdarray__add()?
>>>
>>> I don't like the separation for fixed and non-fixed fds,
>>> why can't we make generic?
>>
>> Usage models are different but they want still to be parts of the same class
>> for atomic poll(). The distinction is filterable vs. not filterable.
>> The distinction should be somehow provided in API. Options are:
>> 1. expose separate API calls like __add_nonfilterable(), __del_nonfilterable();
>>    use nonfilterable quality in __filter() and __poll() and, perhaps, other internals;
>> 2. extend fdarray__add(, nonfilterable) with the nonfilterable quality
>>    use the type in __filter() and __poll() and, perhaps, other internals;
>>    expose less API calls in comparison with option 1
>>
>> Exposure of pos for filterable fds should be converted to bool since currently
>> the returned pos can become stale and there is no way in API to check its state.
>> So it could look like this:
>>
>> fdkey = fdarray__add(array, fd, events, type)
>> type: filterable, nonfilterable, somthing else
>> revents = fdarray__get_revents(fdkey);
>> fdarray__del(array, fdkey);
> 
> I think there's solution without having filterable type,

and still making the atomic fdarray__poll()?

> I'm not sure why you think this is needed

In order to cause min changes to the existing code,
as in libperf as in the tool.

~Alexey

> 
> I'm busy with other things this week, but I think I can
> come up with some patch early next week if needed
> 
> jirka
> 
