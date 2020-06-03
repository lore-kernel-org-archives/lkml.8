Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A4AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD19206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgFCPyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:54:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:58551 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgFCPyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:54:02 -0400
IronPort-SDR: a5O8sEgNOpaAPkb9ZNmdCQzf9SJSTIBHcAjrRTpPBLknIc2dPTP5Z5vycKgrkUy0uJ54t/WbZA
 hapIu38QF8vQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:54:02 -0700
IronPort-SDR: nN8q+kBXMvqMGYjnEK172x6cX7tp3rz/J1qdjyE0Cw7At8HvfU+sYXts4F8LyE14U+VADSd98l
 e+U0Jj1KAgPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="269115388"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 08:53:59 -0700
Subject: Re: [PATCH v6 01/13] tools/libperf: introduce notion of static polled
 file descriptors
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
 <40643542-6676-e0bc-2d10-165dfde41e29@linux.intel.com>
 <33c91520-7040-bd6b-b176-004ddbec2a63@intel.com>
 <b04311d6-b1c6-d625-b227-9ae4f4370626@linux.intel.com>
 <eb31a2a4-ab3b-54a7-2d5a-51457f78394e@intel.com>
 <363DA0ED52042842948283D2FC38E464B4151F86@IRSMSX106.ger.corp.intel.com>
 <40d44cd8-ecdb-53c9-99f8-1737e04c84ff@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2d264b14-7f60-9d43-2d52-3709c7295c4a@intel.com>
Date:   Wed, 3 Jun 2020 18:53:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <40d44cd8-ecdb-53c9-99f8-1737e04c84ff@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/06/20 3:52 pm, Alexey Budankov wrote:
> 
> On 03.06.2020 15:30, Hunter, Adrian wrote:
>>
>>
>>> -----Original Message-----
>>> From: Hunter, Adrian <adrian.hunter@intel.com>
>>> Sent: Wednesday, June 3, 2020 3:24 PM
>>> To: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>; Jiri Olsa
>>> <jolsa@redhat.com>; Namhyung Kim <namhyung@kernel.org>; Alexander
>>> Shishkin <alexander.shishkin@linux.intel.com>; Peter Zijlstra
>>> <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Andi Kleen
>>> <ak@linux.intel.com>; linux-kernel <linux-kernel@vger.kernel.org>
>>> Subject: Re: [PATCH v6 01/13] tools/libperf: introduce notion of static polled
>>> file descriptors
>>>
>>> On 3/06/20 3:01 pm, Alexey Budankov wrote:
>>>> Hi,
>>>>
>>>> On 03.06.2020 14:38, Adrian Hunter wrote:
>>>>> On 1/06/20 11:05 pm, Alexey Budankov wrote:
>>>>>>
>>>>>> Implement adding of file descriptors by fdarray__add_stat() to
>>>>>> fix-sized (currently 1) stat_entries array located at struct fdarray.
>>>>>> Append added file descriptors to the array used by poll() syscall
>>>>>> during fdarray__poll() call. Copy poll() result of the added
>>>>>> descriptors from the array back to the storage for separate analysis.
>>>>>
>>>>> Why not instead call evlist__add_pollfd() before other fds are added,
>>>>> so the fda->entries[] position is always fixed. Then this patch is not
>>> needed.
>>>>
>>>> It then will block event consumption loop, at least in record mode,
>>>> due to change sin initial assumptions behind fdarray__filter(). So
>>>> extension of the API with 'static' fds looks safer w.r.t. possible
>>>> functional regressions at the same time extending the API with ability
>>>> to atomically wait for (poll()) not only event fds but also any other fds
>>> during monitoring.
>>>
>>> So make fdarray__filter() return the number of filterable fds remaining.
>>>
>>
>>
>> Or perhaps simpler, compare the return value to the number of fds that are known not to be filterable
> 
> Well, various implementations are for sure possible but the proposed design
> avoids implicit code assumptions and dependency on API calls order as in API
> implementation as in client code and that is why it's been proposed this way.
> 

The dependencies are confined one function, namely __cmd_record(), it is
simpler, and avoids the inelegant changes to fdarray__poll().
