Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0241C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B277120737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390634AbgDCKb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:31:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:50248 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390315AbgDCKb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:31:57 -0400
IronPort-SDR: ORq9SGnWZr4hBToxHha6cIOTIiuqNQh9frXMMGLK4yI6Mt6yCgWivLcODAGvtuii7tIVkPlBPg
 mPzsrbN8fL8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:31:57 -0700
IronPort-SDR: p9ZJEByTg6bXCmiThboA2/cXbUZ4QOUBpYtQ91hJlI7hAoJGglC6Cj7pujFsF8HFRG4SRQNcLu
 /OqKJXjoaebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; 
   d="scan'208";a="242780191"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga008.fm.intel.com with ESMTP; 03 Apr 2020 03:31:53 -0700
Subject: Re: [PATCH] perf script: Simplify auxiliary event printing functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200402141548.21283-1-adrian.hunter@intel.com>
 <20200403100111.GI2784502@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <25c0b5e1-5888-5086-0921-8b0400e62863@intel.com>
Date:   Fri, 3 Apr 2020 13:31:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403100111.GI2784502@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/04/20 1:01 pm, Jiri Olsa wrote:
> On Thu, Apr 02, 2020 at 05:15:48PM +0300, Adrian Hunter wrote:
>> This simplifies the print functions for the following perf script
>> options:
>>
>> 	--show-task-events
>> 	--show-namespace-events
>> 	--show-cgroup-events
>> 	--show-mmap-events
>> 	--show-switch-events
>> 	--show-lost-events
>> 	--show-bpf-events
>>
>> Example:
>> 	# perf record --switch-events -a -e cycles -c 10000 sleep 1
>>  Before:
>> 	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-before.txt
>>  After:
>> 	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-after.txt
>> 	# diff -s out-before.txt out-after.txt
>> 	Files out-before.txt and out-after.tx are identical
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/builtin-script.c | 304 ++++++++----------------------------
>>  1 file changed, 66 insertions(+), 238 deletions(-)
> 
> awesome ;-)
> 
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 186ebf827fa1..348fec9743a4 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -2040,7 +2040,7 @@ static int cleanup_scripting(void)
>>  
>>  static bool filter_cpu(struct perf_sample *sample)
>>  {
>> -	if (cpu_list)
>> +	if (cpu_list && sample->cpu != (u32)-1)
>>  		return !test_bit(sample->cpu, cpu_bitmap);
> 
> why is this needed? filter_cpu seems to be already called
> from all the changed functions..

Yes, just paranoia

