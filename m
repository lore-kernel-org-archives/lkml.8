Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2652AC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE8120747
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEGI6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:58:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:65414 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEGI6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:58:54 -0400
IronPort-SDR: DG19b6s4QGM7MK4g7/wvh6tYdhn//T5eAz98RislogxWLKMjuGKqP0eoQpihvN+m9wdQPfleRj
 SqXITlt5SCww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 01:58:54 -0700
IronPort-SDR: fzkNCAkn7C3kYXeMTMFqhh2tP44Z3Z7ApxvjNMe3ExAVhWT07bJuDhdrfLjfyd8XJPlX3USrpk
 pdVA3jzRHEQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="263865751"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 May 2020 01:58:49 -0700
Received: from [10.249.225.10] (abudanko-mobl.ccr.corp.intel.com [10.249.225.10])
        by linux.intel.com (Postfix) with ESMTP id E348758048A;
        Thu,  7 May 2020 01:58:46 -0700 (PDT)
Subject: Re: [PATCH v2 09/11] perf record: implement control commands handling
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <db9bb4c3-14d2-aa9f-c281-f81ca698913d@linux.intel.com>
 <20200506202339.GH9893@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4971d2b6-a95a-d53d-515d-7f0ba95fb2f8@linux.intel.com>
Date:   Thu, 7 May 2020 11:58:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506202339.GH9893@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.05.2020 23:23, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 06, 2020 at 09:29:05PM +0300, Alexey Budankov escreveu:
>>
>> Implement handling of 'enable' and 'disable' control commands
>> coming from control file descriptor.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 8a14e68b86ad..2278a3efc747 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1496,6 +1496,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	bool disabled = false, draining = false;
>>  	int fd;
>>  	float ratio = 0;
>> +	enum evlist_ctl_cmd cmd = CTL_CMD_UNSUPPORTED;
>>  
>>  	atexit(record__sig_exit);
>>  	signal(SIGCHLD, sig_handler);
>> @@ -1793,8 +1794,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  			 * Propagate error, only if there's any. Ignore positive
>>  			 * number of returned events and interrupt error.
>>  			 */
>> -			if (err > 0 || (err < 0 && errno == EINTR))
>> +			if (err > 0 || (err < 0 && errno == EINTR)) {
>>  				err = 0;
>> +				if (perf_evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
>> +					switch (cmd) {
>> +					case CTL_CMD_ENABLE:
>> +						pr_info(PERF_EVLIST__ENABLED_MSG);
>> +						break;
>> +					case CTL_CMD_DISABLE:
>> +						pr_info(PERF_EVLIST__DISABLED_MSG);
>> +						break;
>> +					case CTL_CMD_ACK:
>> +					case CTL_CMD_UNSUPPORTED:
> 
> Shouldn't we have a pr_debug() or even pr_err() for the unsupported one?

It already exists on lower level, at perf_evlist__ctlfd_process() (see patch 02/11).

~Alexey
