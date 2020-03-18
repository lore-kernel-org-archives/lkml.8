Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE12C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAF820773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgCROTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:19:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:51613 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCROTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:19:39 -0400
IronPort-SDR: XJ30pEZRwJu1quGkeZRzQeMpQzlkuF5ymjciGJlCu5jKQOZcvOuTTLL1BOXNYhPv0xIeWr4P6z
 nO5D8iY66RDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 07:19:38 -0700
IronPort-SDR: vYvwspyD10pH6LHL/J1HNvCiSyUbx8YEq05bbbHWeuoj5Euhi2AENcRP4tcS1S630TSi/HUe/q
 9qJ23NbxEkGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,567,1574150400"; 
   d="scan'208";a="268369285"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2020 07:19:37 -0700
Received: from [10.254.69.88] (kliang2-mobl.ccr.corp.intel.com [10.254.69.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7F5C0580270;
        Wed, 18 Mar 2020 07:19:30 -0700 (PDT)
Subject: Re: [PATCH V3 15/17] perf top: Add option to enable the LBR stitching
 approach
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
 <20200313183319.17739-16-kan.liang@linux.intel.com>
 <20200318121405.GA849721@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c714171d-3ead-39a9-fcc8-ab21fc79271f@linux.intel.com>
Date:   Wed, 18 Mar 2020 10:19:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318121405.GA849721@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2020 8:14 AM, Jiri Olsa wrote:
> On Fri, Mar 13, 2020 at 11:33:17AM -0700, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>>   #include "util/top.h"
>> @@ -766,6 +767,9 @@ static void perf_event__process_sample(struct perf_tool *tool,
>>   	if (machine__resolve(machine, &al, sample) < 0)
>>   		return;
>>   
>> +	if (top->stitch_lbr)
>> +		al.thread->lbr_stitch_enable = true;
>> +
>>   	if (!machine->kptr_restrict_warned &&
>>   	    symbol_conf.kptr_restrict &&
>>   	    al.cpumode == PERF_RECORD_MISC_KERNEL) {
>> @@ -1543,6 +1547,8 @@ int cmd_top(int argc, const char **argv)
>>   			"number of thread to run event synthesize"),
>>   	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
>>   		    "Record namespaces events"),
>> +	OPT_BOOLEAN(0, "stitch-lbr", &top.stitch_lbr,
>> +		    "Enable LBR callgraph stitching approach"),
>>   	OPTS_EVSWITCH(&top.evswitch),
>>   	OPT_END()
>>   	};
>> @@ -1612,6 +1618,11 @@ int cmd_top(int argc, const char **argv)
>>   		}
>>   	}
>>   
>> +	if (top.stitch_lbr && !(callchain_param.record_mode == CALLCHAIN_LBR)) {
>> +		pr_err("Error: --stitch-lbr must be used with --call-graph lbr\n");
>> +		goto out_delete_evlist;
>> +	}
> 
> why is this check not added for script/report/c2c..?
>

You are right. We should add a check for other tools as well.
I will print a warning as below for other tools in V3.

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c798763f62db..0d544c4fb4be 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2605,6 +2605,12 @@ static int setup_callchain(struct evlist *evlist)
  		}
  	}

+	if (c2c.stitch_lbr && (mode != CALLCHAIN_LBR)) {
+		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			    "Please apply --call-graph lbr when recording.\n");
+		c2c.stitch_lbr = false;
+	}
+
  	callchain_param.record_mode = mode;
  	callchain_param.min_percent = 0;
  	return 0;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index e41cedb9256c..3bdbd3649be7 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -411,6 +411,12 @@ static int report__setup_sample_type(struct report 
*rep)
  			callchain_param.record_mode = CALLCHAIN_FP;
  	}

+	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
+		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			    "Please apply --call-graph lbr when recording.\n");
+		rep->stitch_lbr = false;
+	}
+
  	/* ??? handle more cases than just ANY? */
  	if (!(perf_evlist__combined_branch_type(session->evlist) &
  				PERF_SAMPLE_BRANCH_ANY))
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f8f50bf95e40..e0ec4a0e7b35 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3299,6 +3299,12 @@ static void script__setup_sample_type(struct 
perf_script *script)
  		else
  			callchain_param.record_mode = CALLCHAIN_FP;
  	}
+
+	if (script->stitch_lbr && (callchain_param.record_mode != 
CALLCHAIN_LBR)) {
+		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			   "Please apply --call-graph lbr when recording.\n");
+		script->stitch_lbr = false;
+	}
  }

  static int process_stat_round_event(struct perf_session *session,

Thanks,
Kan
