Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A65C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D137220656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgFHIJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:09:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:47531 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbgFHIJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:09:00 -0400
IronPort-SDR: zuJh6/P6g1dlplYp+TMWRh2jpoBULq0NYyray/JlzMO/WtTMGf1IoPfKXimfJDu5/vCt9C7iBr
 9zt3G1UgaSFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 01:08:59 -0700
IronPort-SDR: 3AVKcQ2unnKJNV1nHrHB3Xphz+4a+T7KyV4GZt1jCXlpRnyCJcSkAKoZhTNZ2RQXYMW/BL+NKA
 y5vvE2ra+uRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="472611541"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2020 01:08:59 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id 0A78E5805B5;
        Mon,  8 Jun 2020 01:08:56 -0700 (PDT)
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
Organization: Intel Corp.
Message-ID: <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
Date:   Mon, 8 Jun 2020 11:08:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.06.2020 19:15, Alexey Budankov wrote:
> 
> On 05.06.2020 14:38, Jiri Olsa wrote:
>> On Fri, Jun 05, 2020 at 12:50:54PM +0200, Jiri Olsa wrote:
>>> On Wed, Jun 03, 2020 at 06:52:59PM +0300, Alexey Budankov wrote:
>>>>
>>>> Implement adding of file descriptors by fdarray__add_stat() to
>>>> fix-sized (currently 1) stat_entries array located at struct fdarray.
>>>> Append added file descriptors to the array used by poll() syscall
>>>> during fdarray__poll() call. Copy poll() result of the added
>>>> descriptors from the array back to the storage for analysis.
>>>>
>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> ---
>>>>  tools/lib/api/fd/array.c                 | 42 +++++++++++++++++++++++-
>>>>  tools/lib/api/fd/array.h                 |  7 ++++
>>>>  tools/lib/perf/evlist.c                  | 11 +++++++
>>>>  tools/lib/perf/include/internal/evlist.h |  2 ++
>>>>  4 files changed, 61 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
>>>> index 58d44d5eee31..b0027f2169c7 100644
>>>> --- a/tools/lib/api/fd/array.c
>>>> +++ b/tools/lib/api/fd/array.c
>>>> @@ -11,10 +11,16 @@
>>>>  
>>>>  void fdarray__init(struct fdarray *fda, int nr_autogrow)
>>>>  {
>>>> +	int i;
>>>> +
>>>>  	fda->entries	 = NULL;
>>>>  	fda->priv	 = NULL;
>>>>  	fda->nr		 = fda->nr_alloc = 0;
>>>>  	fda->nr_autogrow = nr_autogrow;
>>>> +
>>>> +	fda->nr_stat = 0;
>>>> +	for (i = 0; i < FDARRAY__STAT_ENTRIES_MAX; i++)
>>>> +		fda->stat_entries[i].fd = -1;
>>>>  }
>>>>  
>>>>  int fdarray__grow(struct fdarray *fda, int nr)
>>>> @@ -83,6 +89,20 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
>>>>  	return pos;
>>>>  }
>>>>  
>>>> +int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
>>>> +{
>>>> +	int pos = fda->nr_stat;
>>>> +
>>>> +	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
>>>> +		return -1;
>>>> +
>>>> +	fda->stat_entries[pos].fd = fd;
>>>> +	fda->stat_entries[pos].events = revents;
>>>> +	fda->nr_stat++;
>>>> +
>>>> +	return pos;
>>>> +}
>>>> +
>>>>  int fdarray__filter(struct fdarray *fda, short revents,
>>>>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>>>>  		    void *arg)
>>>> @@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
>>>>  
>>>>  int fdarray__poll(struct fdarray *fda, int timeout)
>>>>  {
>>>> -	return poll(fda->entries, fda->nr, timeout);
>>>> +	int nr, i, pos, res;
>>>> +
>>>> +	nr = fda->nr;
>>>> +
>>>> +	for (i = 0; i < fda->nr_stat; i++) {
>>>> +		if (fda->stat_entries[i].fd != -1) {
>>>> +			pos = fdarray__add(fda, fda->stat_entries[i].fd,
>>>> +					   fda->stat_entries[i].events);
>>>
>>> so every call to fdarray__poll will add whatever is
>>> in stat_entries to entries? how is it removed?
>>>
>>> I think you should either follow what Adrian said
>>> and put 'static' descriptors early and check for
>>> filter number to match it as an 'quick fix'
>>>
>>> or we should fix it for real and make it generic
>>>
>>> so currently the interface is like this:
>>>
>>>   pos1 = fdarray__add(a, fd1 ... );
>>>   pos2 = fdarray__add(a, fd2 ... );
>>>   pos3 = fdarray__add(a, fd2 ... );
>>>
>>>   fdarray__poll(a);
>>>
>>>   num = fdarray__filter(a, revents, destructor, arg);
>>>
>>> when fdarray__filter removes some of the fds the 'pos1,pos2,pos3'
>>> indexes are not relevant anymore
> 
> and that is why the return value of fdarray__add() should be converted
> to bool (added/not added). Currently the return value is used as bool
> only allover the calling code.
> 
> fdarray__add_fixed() brings the notion of fd with fixed pos which is
> valid after fdarray__add_fixed() call so the pos could be used to access
> pos fd poll status after poll() call.
> 
> pos = fdarray__add_fixed(array, fd);
> fdarray_poll(array);
> revents = fdarray_fixed_revents(array, pos);
> fdarray__del(array, pos);

So how is it about just adding _revents() and _del() for fixed fds with
correction of retval to bool for fdarray__add()?

~Alexey
