Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D3CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5679420678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgFCMBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:01:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:39838 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCMBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:01:53 -0400
IronPort-SDR: 0y0hastG5IOCw0q7gzW/CFji7Y7TFck/mgxJ0zLis0ZG0Ms0wNm6hKhWq0kZrYzAxLINJ9jrJx
 0RzkNwlt+tKA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 05:01:52 -0700
IronPort-SDR: rbg3z6jFAbPtmY2X6lN/SvzgffBc9LROu4aPUQXjqOT+q9jEL/BRzVTiSbzUx9a06u4RGEzHJ/
 4fPPiNcKm/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="304585228"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2020 05:01:46 -0700
Received: from [10.249.225.188] (abudanko-mobl.ccr.corp.intel.com [10.249.225.188])
        by linux.intel.com (Postfix) with ESMTP id 8766E58045A;
        Wed,  3 Jun 2020 05:01:44 -0700 (PDT)
Subject: Re: [PATCH v6 01/13] tools/libperf: introduce notion of static polled
 file descriptors
To:     Adrian Hunter <adrian.hunter@intel.com>
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b04311d6-b1c6-d625-b227-9ae4f4370626@linux.intel.com>
Date:   Wed, 3 Jun 2020 15:01:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <33c91520-7040-bd6b-b176-004ddbec2a63@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03.06.2020 14:38, Adrian Hunter wrote:
> On 1/06/20 11:05 pm, Alexey Budankov wrote:
>>
>> Implement adding of file descriptors by fdarray__add_stat() to
>> fix-sized (currently 1) stat_entries array located at struct fdarray.
>> Append added file descriptors to the array used by poll() syscall
>> during fdarray__poll() call. Copy poll() result of the added
>> descriptors from the array back to the storage for separate analysis.
> 
> Why not instead call evlist__add_pollfd() before other fds are added, so
> the fda->entries[] position is always fixed. Then this patch is not needed.

It then will block event consumption loop, at least in record mode, due to
change sin initial assumptions behind fdarray__filter(). So extension of the
API with 'static' fds looks safer w.r.t. possible functional regressions at 
the same time extending the API with ability to atomically wait for (poll())
not only event fds but also any other fds during monitoring.

Feel free to ask more.

~Alexey
