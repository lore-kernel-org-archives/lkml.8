Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BEDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AB8206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IqQKAjEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgH0NGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:06:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16720 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbgH0M63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:58:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RCiDni061963;
        Thu, 27 Aug 2020 08:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6u143REuCEptKkPtojuvg5U/HgdT48IJG4XvG8rZ6I0=;
 b=IqQKAjEilrvBEWQMj/Jvw0lA7/GVCKNHxXHfXBfh6X/FrWDQJNnOl0u1AlttKy5wl6wx
 9i7wmMXdXEvsXvGiZeYBQ/rHpAFX4skcNYzSlgSuNufkjZJ2ZKVyxgNRoDHZc7xJVpF2
 0yLkw0BnrJ4ZF3egqft3dvcA2GydHtRh0KpxlOpQ3a16i+iQZGa/AKBYJv8rdh6EWD7v
 AqJ93IMX+QbwKNgFpS6vHjlEBIiGwKHblGWwgZQgZbIt4m7KE1dmAgaGcOHTCHlMTX/C
 OsZpfFg4RVvsjNLMjyuE9VeTC+79M2SYm7GOD3dHLJpTphV7OZKkhZ0JgXnt9ZUGcU7R Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336d3ggav1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:58:17 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RCjNnQ064633;
        Thu, 27 Aug 2020 08:58:14 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336d3ggarw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:58:14 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RCpjcE025382;
        Thu, 27 Aug 2020 12:58:07 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 332utu4gtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 12:58:07 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RCw7bT15270402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 12:58:07 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B083AE064;
        Thu, 27 Aug 2020 12:58:07 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1B92AE05C;
        Thu, 27 Aug 2020 12:58:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.210.202])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 12:58:03 +0000 (GMT)
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <20200826105656.GC703542@krava>
 <6a4e977e-4f77-6a2a-252c-cfdda26db3e2@linux.ibm.com>
 <20200826115954.GA766216@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <135098ed-b5cd-31e3-9e0b-f78b08f91c04@linux.ibm.com>
Date:   Thu, 27 Aug 2020 18:28:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826115954.GA766216@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_06:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=2 adultscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 5:29 PM, Jiri Olsa wrote:
> On Wed, Aug 26, 2020 at 05:02:04PM +0530, kajoljain wrote:
>>
>>
>> On 8/26/20 4:26 PM, Jiri Olsa wrote:
>>> On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
>>>
>>> SNIP
>>>
>>>>  {
>>>>  	/* try to find matching event from arch standard values */
>>>>  	struct event_struct *es;
>>>> @@ -498,8 +486,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>>>>  		if (!strcmp(arch_std, es->name)) {
>>>>  			if (!eventcode && es->event) {
>>>>  				/* allow EventCode to be overridden */
>>>> -				free(*event);
>>>> -				*event = NULL;
>>>> +				je->event = NULL;
>>>>  			}
>>>>  			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
>>>>  			return 0;
>>>> @@ -513,13 +500,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>>>>  
>>>>  /* Call func with each event in the json file */
>>>>  int json_events(const char *fn,
>>>> -	  int (*func)(void *data, char *name, char *event, char *desc,
>>>> -		      char *long_desc,
>>>> -		      char *pmu, char *unit, char *perpkg,
>>>> -		      char *metric_expr,
>>>> -		      char *metric_name, char *metric_group,
>>>> -		      char *deprecated, char *metric_constraint),
>>>> -	  void *data)
>>>> +		int (*func)(void *data, struct json_event *je),
>>>> +			void *data)
>>>>  {
>>>>  	int err;
>>>>  	size_t size;
>>>> @@ -537,24 +519,16 @@ int json_events(const char *fn,
>>>>  	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
>>>>  	tok = tokens + 1;
>>>>  	for (i = 0; i < tokens->size; i++) {
>>>> -		char *event = NULL, *desc = NULL, *name = NULL;
>>>> -		char *long_desc = NULL;
>>>>  		char *extra_desc = NULL;
>>>> -		char *pmu = NULL;
>>>>  		char *filter = NULL;
>>>> -		char *perpkg = NULL;
>>>> -		char *unit = NULL;
>>>> -		char *metric_expr = NULL;
>>>> -		char *metric_name = NULL;
>>>> -		char *metric_group = NULL;
>>>> -		char *deprecated = NULL;
>>>> -		char *metric_constraint = NULL;
>>>> +		struct json_event *je;
>>>>  		char *arch_std = NULL;
>>>>  		unsigned long long eventcode = 0;
>>>>  		struct msrmap *msr = NULL;
>>>>  		jsmntok_t *msrval = NULL;
>>>>  		jsmntok_t *precise = NULL;
>>>>  		jsmntok_t *obj = tok++;
>>>> +		je = (struct json_event *)calloc(1, sizeof(struct json_event));
>>>
>>> hum, you don't check je pointer in here.. but does it need to be allocated?
>>> looks like you could just have je on stack as well..
>>
>> Hi Jiri,
>>    Yes I will add check for je pointer here.The reason for allocating memory to 'je' is,
>> later we are actually referring one by one to its field and in case if won't allocate memory
>> we will get segmentaion fault as otherwise je will be NULL. Please let me know if I am
>> getting correct.
> 
> I don't see reason why not to use automatic variable in here,
> I tried and it seems to work.. below is diff to your changes,
> feel free to squash it with your changes

Hi Jiri,
    Thanks for the changes, I will update.

Thanks,
Kajol Jain
> 
> jirka
> 
> ---
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 606805af69fe..eaac5c126a52 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -521,14 +521,13 @@ int json_events(const char *fn,
>  	for (i = 0; i < tokens->size; i++) {
>  		char *extra_desc = NULL;
>  		char *filter = NULL;
> -		struct json_event *je;
> +		struct json_event je = {};
>  		char *arch_std = NULL;
>  		unsigned long long eventcode = 0;
>  		struct msrmap *msr = NULL;
>  		jsmntok_t *msrval = NULL;
>  		jsmntok_t *precise = NULL;
>  		jsmntok_t *obj = tok++;
> -		je = (struct json_event *)calloc(1, sizeof(struct json_event));
>  
>  		EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
>  		for (j = 0; j < obj->size; j += 2) {
> @@ -544,7 +543,7 @@ int json_events(const char *fn,
>  			       "Expected string value");
>  
>  			nz = !json_streq(map, val, "0");
> -			if (match_field(map, field, nz, &je->event, val)) {
> +			if (match_field(map, field, nz, &je.event, val)) {
>  				/* ok */
>  			} else if (json_streq(map, field, "EventCode")) {
>  				char *code = NULL;
> @@ -557,14 +556,14 @@ int json_events(const char *fn,
>  				eventcode |= strtoul(code, NULL, 0) << 21;
>  				free(code);
>  			} else if (json_streq(map, field, "EventName")) {
> -				addfield(map, &je->name, "", "", val);
> +				addfield(map, &je.name, "", "", val);
>  			} else if (json_streq(map, field, "BriefDescription")) {
> -				addfield(map, &je->desc, "", "", val);
> -				fixdesc(je->desc);
> +				addfield(map, &je.desc, "", "", val);
> +				fixdesc(je.desc);
>  			} else if (json_streq(map, field,
>  					     "PublicDescription")) {
> -				addfield(map, &je->long_desc, "", "", val);
> -				fixdesc(je->long_desc);
> +				addfield(map, &je.long_desc, "", "", val);
> +				fixdesc(je.long_desc);
>  			} else if (json_streq(map, field, "PEBS") && nz) {
>  				precise = val;
>  			} else if (json_streq(map, field, "MSRIndex") && nz) {
> @@ -584,34 +583,34 @@ int json_events(const char *fn,
>  
>  				ppmu = field_to_perf(unit_to_pmu, map, val);
>  				if (ppmu) {
> -					je->pmu = strdup(ppmu);
> +					je.pmu = strdup(ppmu);
>  				} else {
> -					if (!je->pmu)
> -						je->pmu = strdup("uncore_");
> -					addfield(map, &je->pmu, "", "", val);
> -					for (s = je->pmu; *s; s++)
> +					if (!je.pmu)
> +						je.pmu = strdup("uncore_");
> +					addfield(map, &je.pmu, "", "", val);
> +					for (s = je.pmu; *s; s++)
>  						*s = tolower(*s);
>  				}
> -				addfield(map, &je->desc, ". ", "Unit: ", NULL);
> -				addfield(map, &je->desc, "", je->pmu, NULL);
> -				addfield(map, &je->desc, "", " ", NULL);
> +				addfield(map, &je.desc, ". ", "Unit: ", NULL);
> +				addfield(map, &je.desc, "", je.pmu, NULL);
> +				addfield(map, &je.desc, "", " ", NULL);
>  			} else if (json_streq(map, field, "Filter")) {
>  				addfield(map, &filter, "", "", val);
>  			} else if (json_streq(map, field, "ScaleUnit")) {
> -				addfield(map, &je->unit, "", "", val);
> +				addfield(map, &je.unit, "", "", val);
>  			} else if (json_streq(map, field, "PerPkg")) {
> -				addfield(map, &je->perpkg, "", "", val);
> +				addfield(map, &je.perpkg, "", "", val);
>  			} else if (json_streq(map, field, "Deprecated")) {
> -				addfield(map, &je->deprecated, "", "", val);
> +				addfield(map, &je.deprecated, "", "", val);
>  			} else if (json_streq(map, field, "MetricName")) {
> -				addfield(map, &je->metric_name, "", "", val);
> +				addfield(map, &je.metric_name, "", "", val);
>  			} else if (json_streq(map, field, "MetricGroup")) {
> -				addfield(map, &je->metric_group, "", "", val);
> +				addfield(map, &je.metric_group, "", "", val);
>  			} else if (json_streq(map, field, "MetricConstraint")) {
> -				addfield(map, &je->metric_constraint, "", "", val);
> +				addfield(map, &je.metric_constraint, "", "", val);
>  			} else if (json_streq(map, field, "MetricExpr")) {
> -				addfield(map, &je->metric_expr, "", "", val);
> -				for (s = je->metric_expr; *s; s++)
> +				addfield(map, &je.metric_expr, "", "", val);
> +				for (s = je.metric_expr; *s; s++)
>  					*s = tolower(*s);
>  			} else if (json_streq(map, field, "ArchStdEvent")) {
>  				addfield(map, &arch_std, "", "", val);
> @@ -620,7 +619,7 @@ int json_events(const char *fn,
>  			}
>  			/* ignore unknown fields */
>  		}
> -		if (precise && je->desc && !strstr(je->desc, "(Precise Event)")) {
> +		if (precise && je.desc && !strstr(je.desc, "(Precise Event)")) {
>  			if (json_streq(map, precise, "2"))
>  				addfield(map, &extra_desc, " ",
>  						"(Must be precise)", NULL);
> @@ -629,34 +628,33 @@ int json_events(const char *fn,
>  						"(Precise event)", NULL);
>  		}
>  		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
> -		addfield(map, &je->event, ",", buf, NULL);
> -		if (je->desc && extra_desc)
> -			addfield(map, &je->desc, " ", extra_desc, NULL);
> -		if (je->long_desc && extra_desc)
> -			addfield(map, &je->long_desc, " ", extra_desc, NULL);
> +		addfield(map, &je.event, ",", buf, NULL);
> +		if (je.desc && extra_desc)
> +			addfield(map, &je.desc, " ", extra_desc, NULL);
> +		if (je.long_desc && extra_desc)
> +			addfield(map, &je.long_desc, " ", extra_desc, NULL);
>  		if (filter)
> -			addfield(map, &je->event, ",", filter, NULL);
> +			addfield(map, &je.event, ",", filter, NULL);
>  		if (msr != NULL)
> -			addfield(map, &je->event, ",", msr->pname, msrval);
> -		if (je->name)
> -			fixname(je->name);
> +			addfield(map, &je.event, ",", msr->pname, msrval);
> +		if (je.name)
> +			fixname(je.name);
>  
>  		if (arch_std) {
>  			/*
>  			 * An arch standard event is referenced, so try to
>  			 * fixup any unassigned values.
>  			 */
> -			err = try_fixup(fn, arch_std, eventcode, je);
> +			err = try_fixup(fn, arch_std, eventcode, &je);
>  			if (err)
>  				goto free_strings;
>  		}
> -		je->event = real_event(je->name, je->event);
> -		err = func(data, je);
> +		je.event = real_event(je.name, je.event);
> +		err = func(data, &je);
>  free_strings:
>  		free(extra_desc);
>  		free(filter);
>  		free(arch_std);
> -		free(je);
>  
>  		if (err)
>  			break;
> 
