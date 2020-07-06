Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69381C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5072070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgGFNGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:06:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:54386 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbgGFNGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:06:00 -0400
IronPort-SDR: z3jAbM14aDygqBXuqo9dx3mHcbdWco+5nnCV0Pp7LYkSoQn38+OCSUVsJbF0xyYs9nEC6MMo/m
 7jK+EutUg3Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="146488585"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="146488585"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 06:05:57 -0700
IronPort-SDR: aYS46YDa8awy/eI/dw9Hx3SLOfW/Nqbkc4B3A7/eh8+yYhWw5sZ6z2f6XllRLaxaNHr9FJu4ye
 XK/Ri+ojY3RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="313956434"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 06:05:56 -0700
Received: from [10.249.225.12] (abudanko-mobl.ccr.corp.intel.com [10.249.225.12])
        by linux.intel.com (Postfix) with ESMTP id 44698580378;
        Mon,  6 Jul 2020 06:05:49 -0700 (PDT)
Subject: Re: [PATCH v9 02/15] tools/libperf: add properties to struct pollfd
 *entries objects
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <09bbbc85-7ef9-ff9f-9865-fce6a1a4e903@linux.intel.com>
 <20200706122413.GB3401866@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cd132d6b-89ec-1408-f4da-44020e13d4b2@linux.intel.com>
Date:   Mon, 6 Jul 2020 16:05:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706122413.GB3401866@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.07.2020 15:24, Jiri Olsa wrote:
> On Fri, Jul 03, 2020 at 10:41:45AM +0300, Alexey Budankov wrote:
>>
>> Store boolean properties per struct pollfd *entries object in a
>> bitmap of int size. Implement fdarray_prop__nonfilterable property
>> to skip object from counting by fdarray_filter().
> 
> ok, I think can do it like this, few comments below
> 
> thanks,
> jirka
> 
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/lib/api/fd/array.c                 | 17 +++++++++--------
>>  tools/lib/api/fd/array.h                 | 18 +++++++++++++-----
>>  tools/lib/perf/evlist.c                  | 10 +++++-----
>>  tools/lib/perf/include/internal/evlist.h |  2 +-
>>  tools/perf/tests/fdarray.c               |  2 +-
>>  tools/perf/util/evlist.c                 |  2 +-
>>  6 files changed, 30 insertions(+), 21 deletions(-)

<SNIP>

>>
>> diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
>> index b39557d1a88f..19b6a34aeea5 100644
>> --- a/tools/lib/api/fd/array.h
>> +++ b/tools/lib/api/fd/array.h
>> @@ -21,10 +21,18 @@ struct fdarray {
>>  	int	       nr_alloc;
>>  	int	       nr_autogrow;
>>  	struct pollfd *entries;
>> -	union {
>> -		int    idx;
>> -		void   *ptr;
>> -	} *priv;
>> +	struct {
>> +		union {
>> +			int    idx;
>> +			void   *ptr;
>> +		} priv;
>> +		int bits;
>> +	} *prop;
>> +};
> 
> why not keeping the 'priv' as a struct, like:
> 
> 	struct {
> 		union {
> 			int    idx;
> 			void   *ptr;
> 		};
> 		unsigned int flags;
> 	} *priv;
> 
> I think we would have much less changes, also please rename bits
> to flags and use some unsigned type for that

Well, I supposed that priv is short for private what means the layout
of struct priv object is opaque to fdarray implementation and it just
passes the object as a void pointer to external callbacks (e.g in __filter()).
So I preserved this semantics and wrapped and extended priv object
with with flags field. It can be implemented with struct priv if you like.

> 
>> +
>> +enum fdarray_props {
>> +	fdarray_prop__default	    = 0x00000000,
>> +	fdarray_prop__nonfilterable = 0x00000001
>>  };
> 
> s/fdarray_props/fdarray_flag/

Accepted.

Alexey
