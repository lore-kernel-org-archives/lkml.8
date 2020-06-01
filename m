Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F0AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D5A206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFAHeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:34:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:18801 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFAHeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:34:10 -0400
IronPort-SDR: 9tZuvrGp8G3zUqqOMTCb1ORI5YYusO6tGJ+MjBOf9f9pp4Fdi7fkaoLgKS7cswXfhVxkQdLMaX
 50AFFt+v5vJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 00:34:08 -0700
IronPort-SDR: Cac736ptcxbsLp+gZlilKceM85eh+ueZdoNBBewTgzs2ETGZfwXL8ZeimMB8ZgEhxqSmZL2Cav
 eesdnnVx/cCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,460,1583222400"; 
   d="scan'208";a="415718629"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2020 00:34:08 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id B5BDA580522;
        Mon,  1 Jun 2020 00:34:06 -0700 (PDT)
Subject: Re: [PATCH v4 01/10] tools/libperf: introduce static poll file
 descriptors
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
 <024af6a7-8085-c28d-5067-6ab3225bdc82@linux.intel.com>
 <20200531181912.GC881900@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d36ac0e2-3f79-6662-c3a8-03c06798f8d3@linux.intel.com>
Date:   Mon, 1 Jun 2020 10:34:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200531181912.GC881900@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31.05.2020 21:19, Jiri Olsa wrote:
> On Mon, May 25, 2020 at 05:17:31PM +0300, Alexey Budankov wrote:
> 
> SBIP
> 
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
>> +			if (pos >= 0)
>> +				fda->priv[pos].idx = i;
>> +		}
>> +	}
> 
> hum, so every time we call evlist__poll we end up in here
> adding more stuff to entries?

It depends on whether static fds were added by perf_evlist__add_pollfd_stat() or not.
If they weren't then poll() checks only event fds added by perf_evlist__add_pollfd().
If static fds have been added and there are valid (!=-1) fds still then  they are
appended to fds array. After return from poll() its result copied back to static fds
storage so fds state could be checked separately from event fds.

~Alexey
