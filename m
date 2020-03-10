Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33411C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B2420873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCJQyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:54:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:39029 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgCJQyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:54:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 09:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="234406247"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2020 09:54:08 -0700
Received: from [10.251.24.33] (kliang2-mobl.ccr.corp.intel.com [10.251.24.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 666A85804A0;
        Tue, 10 Mar 2020 09:54:07 -0700 (PDT)
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
 <00ebb51d-0282-8181-7285-c60aec27566c@linux.intel.com>
 <20200310140421.GD15931@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fa4e32f0-1572-a9aa-e609-3cecaae7ef9e@linux.intel.com>
Date:   Tue, 10 Mar 2020 12:54:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310140421.GD15931@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2020 10:04 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 10, 2020 at 09:53:24AM -0400, Liang, Kan escreveu:
>> On 3/10/2020 9:06 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Mar 09, 2020 at 10:46:31AM -0700, kan.liang@linux.intel.com escreveu:
>>>> +static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
>>>> +{
>>>> +	struct perf_pmu_caps *caps;
>>>> +
>>>> +	caps = zalloc(sizeof(*caps));
>>>> +	if (!caps)
>>>> +		return -ENOMEM;
> 
>>> So here you check if zalloc fails and returns a proper error
> 
>>>> +	caps->name = strdup(name);
>>>> +	caps->value = strndup(value, strlen(value) - 1);
> 
>>> But then you don't check strdup()?
>   
>> Right, I should check strdup(), otherwise the capability information may be
>> incomplete. I will fix it in V3.
> 
> Thanks, overall just consider making the patches smaller if possible,
> with prep patches paving the way for more complex changes so that
> reviewing becomes easier, for instance:
> 
>    perf machine: Refine the function for LBR call stack reconstruction
> 
> Seems to do too many things at once. It was unfortunate, for instance,
> that the pre-existing code had that
> 
> resolve_lbr_callchain_sample()
> {
> 	/* LBR only affects the user callchain */
> 	if (i != chain_nr) {
> 		body of the function, long
> 		....
> 		return err;
> 	}
> 
> 	return 0;
> }
> 
> One of the things you did in this patch was to the more sensible:
> 
> 	/* LBR only affects the user callchain */
> 	if (i == chain_nr)
> 		return 0;
> 
> 	body of the function
> 	...
> 	return err;
> 
> So if you had a prep patch at this point just removing that silly
> indent, then we would see that that is just removing the indent, the
> next patch wouldn't have that check for user callchains, would be
> smaller, I think that would help reduce the patch sizes.
> 
> Then if you just moved to a separate function the (callchain_param.order
> == ORDER_CALLEE) part, the patch would again be smaller, etc.
> 
> This helps reviewing and usually helps us later, with bisection, when
> some bug is introduced,


Sure, I will go through all patches and see what I can do to reduce the 
size of patches in V3.


Thanks,
Kan

> 
> Regards,
> 
> - Arnaldo
> 
>> Thanks,
>> Kan
>>
>>>
>>>> +	list_add_tail(&caps->list, list);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Reading/parsing the given pmu capabilities, which should be located at:
>>>> + * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
>>>> + * Return the number of capabilities
>>>> + */
>>>> +int perf_pmu__caps_parse(struct perf_pmu *pmu)
>>>> +{
>>>> +	struct stat st;
>>>> +	char caps_path[PATH_MAX];
>>>> +	const char *sysfs = sysfs__mountpoint();
>>>> +	DIR *caps_dir;
>>>> +	struct dirent *evt_ent;
>>>> +	int nr_caps = 0;
>>>> +
>>>> +	if (!sysfs)
>>>> +		return -1;
>>>> +
>>>> +	snprintf(caps_path, PATH_MAX,
>>>> +		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
>>>> +
>>>> +	if (stat(caps_path, &st) < 0)
>>>> +		return 0;	/* no error if caps does not exist */
>>>> +
>>>> +	caps_dir = opendir(caps_path);
>>>> +	if (!caps_dir)
>>>> +		return -EINVAL;
>>>> +
>>>> +	while ((evt_ent = readdir(caps_dir)) != NULL) {
>>>> +		char path[PATH_MAX + NAME_MAX + 1];
>>>> +		char *name = evt_ent->d_name;
>>>> +		char value[128];
>>>> +		FILE *file;
>>>> +
>>>> +		if (!strcmp(name, ".") || !strcmp(name, ".."))
>>>> +			continue;
>>>> +
>>>> +		snprintf(path, sizeof(path), "%s/%s", caps_path, name);
>>>> +
>>>> +		file = fopen(path, "r");
>>>> +		if (!file)
>>>> +			break;
>>>> +
>>>> +		if (!fgets(value, sizeof(value), file) ||
>>>> +		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
>>>> +			fclose(file);
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		nr_caps++;
>>>> +		fclose(file);
>>>> +	}
>>>> +
>>>> +	closedir(caps_dir);
>>>> +
>>>> +	return nr_caps;
>>>> +}
>>>> +
>>>> +struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
>>>> +					  struct perf_pmu_caps *caps)
>>>> +{
>>>> +	if (!pmu)
>>>> +		return NULL;
>>>> +
>>>> +	if (!caps)
>>>> +		caps = list_prepare_entry(caps, &pmu->caps, list);
>>>> +
>>>> +	list_for_each_entry_continue(caps, &pmu->caps, list)
>>>> +		return caps;
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>>>> index 6737e3d5d568..a228e27ae462 100644
>>>> --- a/tools/perf/util/pmu.h
>>>> +++ b/tools/perf/util/pmu.h
>>>> @@ -21,6 +21,12 @@ enum {
>>>>    struct perf_event_attr;
>>>> +struct perf_pmu_caps {
>>>> +	char *name;
>>>> +	char *value;
>>>> +	struct list_head list;
>>>> +};
>>>> +
>>>>    struct perf_pmu {
>>>>    	char *name;
>>>>    	__u32 type;
>>>> @@ -32,6 +38,7 @@ struct perf_pmu {
>>>>    	struct perf_cpu_map *cpus;
>>>>    	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>>>>    	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
>>>> +	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>>>>    	struct list_head list;    /* ELEM */
>>>>    };
>>>> @@ -102,4 +109,9 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
>>>>    int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>>>> +int perf_pmu__caps_parse(struct perf_pmu *pmu);
>>>> +
>>>> +struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
>>>> +					  struct perf_pmu_caps *caps);
>>>> +
>>>>    #endif /* __PMU_H */
>>>> -- 
>>>> 2.17.1
>>>>
>>>
> 
