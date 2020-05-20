Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE1EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D31420671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgETSGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:06:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:47203 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgETSGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:06:54 -0400
IronPort-SDR: CYh3q2d11wKl5AfaRMqB3l8bSMmjXNbKahiHqHB2GFd+3QzrubrCjl2zlhE5jBRgeg3vlRSgLL
 MFApj09NAN9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 11:06:53 -0700
IronPort-SDR: y4TAj5LuH/3XDp/qr/BXcqJuuf3jzmX8mc87XEewhYq9zb08w8kkZbOUihK3Msf4wb8K7inFvA
 nUWpA3oj1dRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="268351859"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2020 11:06:53 -0700
Received: from [10.249.231.6] (abudanko-mobl.ccr.corp.intel.com [10.249.231.6])
        by linux.intel.com (Postfix) with ESMTP id CD19B580100;
        Wed, 20 May 2020 11:06:50 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] perf record: implement control commands handling
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <25f98682-5ef2-4257-f302-93b29da707a9@linux.intel.com>
 <20200520123833.GG157452@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <df2cd76d-a9ae-7092-1ee2-83fee8f557c8@linux.intel.com>
Date:   Wed, 20 May 2020 21:06:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520123833.GG157452@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.05.2020 15:38, Jiri Olsa wrote:
> On Wed, May 13, 2020 at 11:04:25AM +0300, Alexey Budankov wrote:
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
>> index 50dc2fe626e5..72f388623364 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1505,6 +1505,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	bool disabled = false, draining = false;
>>  	int fd;
>>  	float ratio = 0;
>> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
>>  
>>  	atexit(record__sig_exit);
>>  	signal(SIGCHLD, sig_handler);
>> @@ -1802,8 +1803,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  			 * Propagate error, only if there's any. Ignore positive
>>  			 * number of returned events and interrupt error.
>>  			 */
>> -			if (err > 0 || (err < 0 && errno == EINTR))
>> +			if (err > 0 || (err < 0 && errno == EINTR)) {
>>  				err = 0;
>> +				if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
>> +					switch (cmd) {
>> +					case EVLIST_CTL_CMD_ENABLE:
>> +						pr_info(EVLIST_ENABLED_MSG);
>> +						break;
>> +					case EVLIST_CTL_CMD_DISABLE:
>> +						pr_info(EVLIST_DISABLED_MSG);
>> +						break;
>> +					case EVLIST_CTL_CMD_ACK:
>> +					case EVLIST_CTL_CMD_UNSUPPORTED:
>> +					default:
>> +						break;
>> +					}
>> +				}
>> +			}
> 
> so this will be processed only when:
> 
> 	if (hits == rec->samples) {
> 
> what if there's always somethign in the buffer? will this stall?
> 
>>  			waking++;
>>  
>>  			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
> 
> evlist__filter_pollfd will trigger draining if all the maps are closed,
> but there's one more fd in pollfd now, will this prevent draining?

Good catch. This needs redesign to notice pending commands during 
active trace streaming. The same is regarding draining.

> 
> I wonder this would fit better to the sideband thread (util/sideband_evlist.c)
> so we don't disturb the main thread with another check

~Alexey

