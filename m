Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCA0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6CE20724
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404023AbgFXOAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:00:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:22056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403781AbgFXOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:00:16 -0400
IronPort-SDR: ZoOsFt/VOlVslvC7EP8bEsugmd8aV6GlyY2ejKNTCQI8CVpNe9irPfIVYLLJny4f5Rr1AdJm9h
 lwfIQgQ2T/AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205968222"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="205968222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 07:00:16 -0700
IronPort-SDR: t9zRy+M+jG/vIQR4eT1EhJAChy4qMB2lbHjKm6AGunEVfUsUhx0bgP5nIPJSGkcWpDEGznCpa9
 wAsTfnNeK/Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="310789745"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 24 Jun 2020 07:00:16 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id D8AEB5805B5;
        Wed, 24 Jun 2020 07:00:13 -0700 (PDT)
Subject: Re: [PATCH v8 12/13] perf record: implement control commands handling
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <f48c5f58-96ea-b1f0-a7e6-55315a292bce@linux.intel.com>
 <20200623145434.GD2619137@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3107d9cd-03ec-34aa-4226-393547c55517@linux.intel.com>
Date:   Wed, 24 Jun 2020 17:00:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623145434.GD2619137@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.06.2020 17:54, Jiri Olsa wrote:
> On Wed, Jun 17, 2020 at 11:43:58AM +0300, Alexey Budankov wrote:
>>
>> Implement handling of 'enable' and 'disable' control commands
>> coming from control file descriptor.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index d0b29a1070a0..0394e068dde8 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1527,6 +1527,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	bool disabled = false, draining = false;
>>  	int fd;
>>  	float ratio = 0;
>> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
>>  
>>  	atexit(record__sig_exit);
>>  	signal(SIGCHLD, sig_handler);
>> @@ -1830,6 +1831,21 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  				alarm(rec->switch_output.time);
>>  		}
>>  
>> +		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
>> +			switch (cmd) {
>> +			case EVLIST_CTL_CMD_ENABLE:
>> +				pr_info(EVLIST_ENABLED_MSG);
>> +				break;
>> +			case EVLIST_CTL_CMD_DISABLE:
>> +				pr_info(EVLIST_DISABLED_MSG);
>> +				break;
>> +			case EVLIST_CTL_CMD_ACK:
>> +			case EVLIST_CTL_CMD_UNSUPPORTED:
>> +			default:
>> +				break;
>> +			}
>> +		}
> 
> so there's still the filter call like:
> 
>                         if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
>                                 draining = true;
> 
> it will never be 0 if the control fds are stil alive no?

Due to change in filter_pollfd() and preceding evlist__ctlfd_process() call
now control fd is not counted by filter_pollfd().

However event fds with .revents == 0 are not counted either and this breaks
the algorithm thus something more is still required to cover this gap.

~Alexey

> 
> jirka
> 
