Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD8C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA86206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgBUPmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:42:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:3970 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgBUPmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:42:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 07:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; 
   d="scan'208";a="436986282"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2020 07:42:16 -0800
Received: from [10.251.3.245] (kliang2-mobl.ccr.corp.intel.com [10.251.3.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 564525803FA;
        Fri, 21 Feb 2020 07:42:15 -0800 (PST)
Subject: Re: [PATCH 4/5] perf metricgroup: Support metric constraint
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
 <1582139320-75181-5-git-send-email-kan.liang@linux.intel.com>
 <20200220113530.GA565976@krava>
 <fea147db-2af3-e9ec-fb23-f9db8cf1c77a@linux.intel.com>
 <20200221130903.GC652992@krava>
 <300208e8-2526-8f17-a28a-d4e244baaf90@linux.intel.com>
 <20200221144803.GB657629@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <42831850-9969-435f-6713-7bf82b628d29@linux.intel.com>
Date:   Fri, 21 Feb 2020 10:42:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221144803.GB657629@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2020 9:48 AM, Jiri Olsa wrote:
> On Fri, Feb 21, 2020 at 09:30:15AM -0500, Liang, Kan wrote:
>>
>>
>> On 2/21/2020 8:09 AM, Jiri Olsa wrote:
>>> On Thu, Feb 20, 2020 at 11:14:09AM -0500, Liang, Kan wrote:
>>>>
>>>>
>>>> On 2/20/2020 6:35 AM, Jiri Olsa wrote:
>>>>> On Wed, Feb 19, 2020 at 11:08:39AM -0800, kan.liang@linux.intel.com wrote:
>>>>>
>>>>> SNIP
>>>>>
>>>>>> +static bool violate_nmi_constraint;
>>>>>> +
>>>>>> +static bool metricgroup__has_constraint(struct pmu_event *pe)
>>>>>> +{
>>>>>> +	if (!pe->metric_constraint)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
>>>>>> +	    sysctl__nmi_watchdog_enabled()) {
>>>>>> +		pr_warning("Splitting metric group %s into standalone metrics.\n",
>>>>>> +			   pe->metric_name);
>>>>>> +		violate_nmi_constraint = true;
>>>>>
>>>>> no static flags plz.. can't you just print that rest of the warning in here?
>>>>>
>>>>
>>>> Because we only want to print the NMI watchdog warning once.
>>>> If there are more than one metric groups with constraint, the warning may be
>>>> printed several times. For example,
>>>>     $ perf stat -M Page_Walks_Utilization,Page_Walks_Utilization
>>>>     Splitting metric group Page_Walks_Utilization into standalone metrics.
>>>>     Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric
>>>> constraint:
>>>>         echo 0 > /proc/sys/kernel/nmi_watchdog
>>>>         perf stat ...
>>>>         echo 1 > /proc/sys/kernel/nmi_watchdog
>>>>     Splitting metric group Page_Walks_Utilization into standalone metrics.
>>>>     Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric
>>>> constraint:
>>>>         echo 0 > /proc/sys/kernel/nmi_watchdog
>>>>         perf stat ...
>>>>         echo 1 > /proc/sys/kernel/nmi_watchdog
>>>> Is it OK?
>>>>
>>>> If it's OK, I think we can remove the flag.
>>>
>>> we use the 'print once' static flags in functions,
>>> so plz keep it inside like WARN_ONCE, or use it directly
>>>
>>
>> If using WARN_ONCE, the warning is always printed for the first violation.
>> For example,
>>
>>   #perf stat -M Page_Walks_Utilization,Page_Walks_Utilization
>>   Splitting metric group Page_Walks_Utilization into standalone metrics.
>>   Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
>>       echo 0 > /proc/sys/kernel/nmi_watchdog
>>       perf stat ...
>>       echo 1 > /proc/sys/kernel/nmi_watchdog
>>   Splitting metric group Page_Walks_Utilization into standalone metrics.
>>
>>
>> The output of current patch is as below.
>>   #perf stat -M Page_Walks_Utilization,Page_Walks_Utilization
>>   Splitting metric group Page_Walks_Utilization into standalone metrics.
>>   Splitting metric group Page_Walks_Utilization into standalone metrics.
>>   Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
>>       echo 0 > /proc/sys/kernel/nmi_watchdog
>>       perf stat ...
>>       echo 1 > /proc/sys/kernel/nmi_watchdog
>>
>>
>> Personally, I think the output of current patch looks better.
>> But there is nothing wrong with the output of WARN_ONCE.
>>
>> Should I use WARN_ONCE in next V2?
> 
> I just wanted you to keep that static flag inside the function,
> so we don't have another static variable used across the code
> 
> if the WARN_ONCE does not fit, just use your own flag inside
> the function


Here is the current code flow. The metric groups are processed one by 
one. When perf tool processes the metric group in 
metricgroup__has_constraint(), we have no idea whether the following 
groups break the constraint.

metricgroup__parse_groups():
   metricgroup__add_metric_list():
   while ((p = strsep(&llist, ",")) != NULL) {
     metricgroup__add_metric():
       metricgroup__has_constraint()
   }

The watchdog hint has to be printed after all metric groups are processed.

What about the patch as below?

A dedicated function for warnings is introduced. But it has to be 
invoked twice. One is in the middle of processing. The other is after 
all metric groups are processed.

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f9a9b50..c3a8c70 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -441,7 +441,24 @@ static void 
metricgroup__add_metric_non_group(struct strbuf *events,
  		strbuf_addf(events, ",%s", ids[i]);
  }

-static bool violate_nmi_constraint;
+static void metricgroup___watchdog_constraint_hint(const char *name, 
bool foot)
+{
+	static bool violate_nmi_constraint;
+
+	if (!foot) {
+		pr_warning("Splitting metric group %s into standalone metrics.\n", name);
+		violate_nmi_constraint = true;
+		return;
+	}
+
+	if (!violate_nmi_constraint)
+		return;
+
+	pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG 
metric constraint:\n"
+		   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
+		   "    perf stat ...\n"
+		   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
+}

  static bool metricgroup__has_constraint(struct pmu_event *pe)
  {
@@ -450,9 +467,7 @@ static bool metricgroup__has_constraint(struct 
pmu_event *pe)

  	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
  	    sysctl__nmi_watchdog_enabled()) {
-		pr_warning("Splitting metric group %s into standalone metrics.\n",
-			   pe->metric_name);
-		violate_nmi_constraint = true;
+		metricgroup___watchdog_constraint_hint(pe->metric_name, false);
  		return true;
  	}

@@ -535,6 +550,10 @@ static int metricgroup__add_metric_list(const char 
*list, struct strbuf *events,
  		}
  	}
  	free(nlist);
+
+	if (!ret)
+		metricgroup___watchdog_constraint_hint(NULL, true);
+
  	return ret;
  }

@@ -577,13 +596,6 @@ int metricgroup__parse_groups(const struct option *opt,
  	strbuf_release(&extra_events);
  	ret = metricgroup__setup_events(&group_list, perf_evlist,
  					metric_events);
-
-	if (violate_nmi_constraint) {
-		pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG 
metric constraint:\n"
-			   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
-			   "    perf stat ...\n"
-			   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
-	}
  out:
  	metricgroup__free_egroups(&group_list);
  	return ret;


Thanks,
Kan



