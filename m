Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532A0C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3F121D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCJNx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:53:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:1525 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCJNx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:53:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="260794840"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2020 06:53:27 -0700
Received: from [10.251.24.33] (kliang2-mobl.ccr.corp.intel.com [10.251.24.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 759D05804A0;
        Tue, 10 Mar 2020 06:53:26 -0700 (PDT)
Subject: Re: [PATCH V2 1/9] perf pmu: Add support for PMU capabilities
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
References: <20200309174639.4594-1-kan.liang@linux.intel.com>
 <20200309174639.4594-2-kan.liang@linux.intel.com>
 <20200310130644.GC15931@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <00ebb51d-0282-8181-7285-c60aec27566c@linux.intel.com>
Date:   Tue, 10 Mar 2020 09:53:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310130644.GC15931@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2020 9:06 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 09, 2020 at 10:46:31AM -0700, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The PMU capabilities information, which is located at
>> /sys/bus/event_source/devices/<dev>/caps, is required by perf tool.
>> For example, the max LBR information is required to stitch LBR call
>> stack.
>>
>> Add perf_pmu__caps_parse() to parse the PMU capabilities information.
>> The information is stored in a list.
>>
>> Add perf_pmu__scan_caps() to scan the capabilities one by one.
>>
>> The following patch will store the capabilities information in perf
>> header.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/util/pmu.c | 87 +++++++++++++++++++++++++++++++++++++++++++
>>   tools/perf/util/pmu.h | 12 ++++++
>>   2 files changed, 99 insertions(+)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 8b99fd312aae..13634ca09096 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -844,6 +844,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>   
>>   	INIT_LIST_HEAD(&pmu->format);
>>   	INIT_LIST_HEAD(&pmu->aliases);
>> +	INIT_LIST_HEAD(&pmu->caps);
>>   	list_splice(&format, &pmu->format);
>>   	list_splice(&aliases, &pmu->aliases);
>>   	list_add_tail(&pmu->list, &pmus);
>> @@ -1565,3 +1566,89 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
>>   	va_end(args);
>>   	return ret;
>>   }
>> +
>> +static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
>> +{
>> +	struct perf_pmu_caps *caps;
>> +
>> +	caps = zalloc(sizeof(*caps));
>> +	if (!caps)
>> +		return -ENOMEM;
>> +
> 
> So here you check if zalloc fails and returns a proper error
> 
>> +	caps->name = strdup(name);
>> +	caps->value = strndup(value, strlen(value) - 1);
> 
> But then you don't check strdup()?

Right, I should check strdup(), otherwise the capability information may 
be incomplete. I will fix it in V3.

Thanks,
Kan

> 
>> +	list_add_tail(&caps->list, list);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Reading/parsing the given pmu capabilities, which should be located at:
>> + * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
>> + * Return the number of capabilities
>> + */
>> +int perf_pmu__caps_parse(struct perf_pmu *pmu)
>> +{
>> +	struct stat st;
>> +	char caps_path[PATH_MAX];
>> +	const char *sysfs = sysfs__mountpoint();
>> +	DIR *caps_dir;
>> +	struct dirent *evt_ent;
>> +	int nr_caps = 0;
>> +
>> +	if (!sysfs)
>> +		return -1;
>> +
>> +	snprintf(caps_path, PATH_MAX,
>> +		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
>> +
>> +	if (stat(caps_path, &st) < 0)
>> +		return 0;	/* no error if caps does not exist */
>> +
>> +	caps_dir = opendir(caps_path);
>> +	if (!caps_dir)
>> +		return -EINVAL;
>> +
>> +	while ((evt_ent = readdir(caps_dir)) != NULL) {
>> +		char path[PATH_MAX + NAME_MAX + 1];
>> +		char *name = evt_ent->d_name;
>> +		char value[128];
>> +		FILE *file;
>> +
>> +		if (!strcmp(name, ".") || !strcmp(name, ".."))
>> +			continue;
>> +
>> +		snprintf(path, sizeof(path), "%s/%s", caps_path, name);
>> +
>> +		file = fopen(path, "r");
>> +		if (!file)
>> +			break;
>> +
>> +		if (!fgets(value, sizeof(value), file) ||
>> +		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
>> +			fclose(file);
>> +			break;
>> +		}
>> +
>> +		nr_caps++;
>> +		fclose(file);
>> +	}
>> +
>> +	closedir(caps_dir);
>> +
>> +	return nr_caps;
>> +}
>> +
>> +struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
>> +					  struct perf_pmu_caps *caps)
>> +{
>> +	if (!pmu)
>> +		return NULL;
>> +
>> +	if (!caps)
>> +		caps = list_prepare_entry(caps, &pmu->caps, list);
>> +
>> +	list_for_each_entry_continue(caps, &pmu->caps, list)
>> +		return caps;
>> +
>> +	return NULL;
>> +}
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 6737e3d5d568..a228e27ae462 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -21,6 +21,12 @@ enum {
>>   
>>   struct perf_event_attr;
>>   
>> +struct perf_pmu_caps {
>> +	char *name;
>> +	char *value;
>> +	struct list_head list;
>> +};
>> +
>>   struct perf_pmu {
>>   	char *name;
>>   	__u32 type;
>> @@ -32,6 +38,7 @@ struct perf_pmu {
>>   	struct perf_cpu_map *cpus;
>>   	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>>   	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
>> +	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>>   	struct list_head list;    /* ELEM */
>>   };
>>   
>> @@ -102,4 +109,9 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
>>   
>>   int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>>   
>> +int perf_pmu__caps_parse(struct perf_pmu *pmu);
>> +
>> +struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
>> +					  struct perf_pmu_caps *caps);
>> +
>>   #endif /* __PMU_H */
>> -- 
>> 2.17.1
>>
> 
