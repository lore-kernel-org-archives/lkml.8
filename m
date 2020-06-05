Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806992063A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgFELu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:50:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:37514 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgFELu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:50:27 -0400
IronPort-SDR: HAcpdxWUCfEnhWSBkW2fMK6NgfTCmK5PfD6n1ofiYxPa6uMJsg3ppPwBWi7RQmyFY3jxbnQwhi
 sudtz41iVYIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 04:50:26 -0700
IronPort-SDR: 9Zr71LGna9tos8vciIEEwPAEvBtFlLlSVKLzz8i0DRY3gY0S/rjZHrBX3HUsxDXZ1ylTAIFNDr
 Qmpoa3dv2Dog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="417248582"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2020 04:50:26 -0700
Received: from [10.249.226.228] (abudanko-mobl.ccr.corp.intel.com [10.249.226.228])
        by linux.intel.com (Postfix) with ESMTP id D654C5805B5;
        Fri,  5 Jun 2020 04:50:23 -0700 (PDT)
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
 <20200605105051.GA1404794@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b1934951-1dc2-a6b8-ddb3-25643ba37a00@linux.intel.com>
Date:   Fri, 5 Jun 2020 14:50:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605105051.GA1404794@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.06.2020 13:50, Jiri Olsa wrote:
> On Wed, Jun 03, 2020 at 06:52:59PM +0300, Alexey Budankov wrote:
>>
>> Implement adding of file descriptors by fdarray__add_stat() to
>> fix-sized (currently 1) stat_entries array located at struct fdarray.
>> Append added file descriptors to the array used by poll() syscall
>> during fdarray__poll() call. Copy poll() result of the added
>> descriptors from the array back to the storage for analysis.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/lib/api/fd/array.c                 | 42 +++++++++++++++++++++++-
>>  tools/lib/api/fd/array.h                 |  7 ++++
>>  tools/lib/perf/evlist.c                  | 11 +++++++
>>  tools/lib/perf/include/internal/evlist.h |  2 ++
>>  4 files changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
>> index 58d44d5eee31..b0027f2169c7 100644
>> --- a/tools/lib/api/fd/array.c
>> +++ b/tools/lib/api/fd/array.c
>> @@ -11,10 +11,16 @@
>>  
>>  void fdarray__init(struct fdarray *fda, int nr_autogrow)
>>  {
>> +	int i;
>> +
>>  	fda->entries	 = NULL;
>>  	fda->priv	 = NULL;
>>  	fda->nr		 = fda->nr_alloc = 0;
>>  	fda->nr_autogrow = nr_autogrow;
>> +
>> +	fda->nr_stat = 0;
>> +	for (i = 0; i < FDARRAY__STAT_ENTRIES_MAX; i++)
>> +		fda->stat_entries[i].fd = -1;
>>  }
>>  
>>  int fdarray__grow(struct fdarray *fda, int nr)
>> @@ -83,6 +89,20 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
>>  	return pos;
>>  }
>>  
>> +int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
>> +{
>> +	int pos = fda->nr_stat;
>> +
>> +	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
>> +		return -1;
>> +
>> +	fda->stat_entries[pos].fd = fd;
>> +	fda->stat_entries[pos].events = revents;
>> +	fda->nr_stat++;
>> +
>> +	return pos;
>> +}
>> +
>>  int fdarray__filter(struct fdarray *fda, short revents,
>>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>>  		    void *arg)
>> @@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
>>  
>>  int fdarray__poll(struct fdarray *fda, int timeout)
>>  {
>> -	return poll(fda->entries, fda->nr, timeout);
>> +	int nr, i, pos, res;
>> +
>> +	nr = fda->nr;
>> +
>> +	for (i = 0; i < fda->nr_stat; i++) {
>> +		if (fda->stat_entries[i].fd != -1) {
>> +			pos = fdarray__add(fda, fda->stat_entries[i].fd,
>> +					   fda->stat_entries[i].events);
> 
> so every call to fdarray__poll will add whatever is
> in stat_entries to entries? how is it removed?

Whatever stat fd which is not -1 is added. If static fd is -1 then it is skipped for
poll() call. Complete stat slot (fd == -1) isn't expected to be reused but reuse could
be supported by simple change at fdarray__add_stat()
and probably bring required generality.

> 
> I think you should either follow what Adrian said
> and put 'static' descriptors early and check for
> filter number to match it as an 'quick fix'
> 
> or we should fix it for real and make it generic

It would complicate without a reason. If it really matters I would add possibility of
realloc of stat entries in fdarray__add_stat() and that would make stat entries usage
more similar to filterable ones without dramatic change and risk of regressions.

~Alexey

> 
> so currently the interface is like this:
> 
>   pos1 = fdarray__add(a, fd1 ... );
>   pos2 = fdarray__add(a, fd2 ... );
>   pos3 = fdarray__add(a, fd2 ... );
> 
>   fdarray__poll(a);
> 
>   num = fdarray__filter(a, revents, destructor, arg);
> 
> when fdarray__filter removes some of the fds the 'pos1,pos2,pos3'
> indexes are not relevant anymore
> 
> how about we make the 'pos indexes' being stable by allocating
> separate object for each added descriptor and each poll call
> would create pollfd array from current objects, and entries
> would keep pointer to its pollfd entry
> 
>   struct fdentry *entry {
>        int              fd;
>        int              events;
>        struct pollfd   *pollfd;
>   }
> 
>   entry1 = fdarray__add(a, fd1 ...);
>   entry2 = fdarray__add(a, fd2 ...);
>   entry3 = fdarray__add(a, fd3 ...);
> 
>   fdarray__poll(a);
> 
>   struct pollfd *fdarray__entry_pollfd(a, entry1);
> 
> or smoething like that ;-)
> 
> jirka
> 
