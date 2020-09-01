Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E1BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE85208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gh/qvBgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIAGDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:03:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgIAGDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:03:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08161tZG153601;
        Tue, 1 Sep 2020 02:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7TuxWzGI8/26QpuPWvUdOUgFxq+QIN06HjfsU5pjiFc=;
 b=Gh/qvBgH1CZFHuSq4RW0tq8IML8GsnxxXgqL6E1wE2N92f93uvE8ZnBVetfpUH55dcqt
 THlU9MbppIvWG/RwTHsvhggJ/p/sdiSloxB9cyr21HDPZt5yhWBmv2zTTwpknFQOPKKz
 Z3mAoyXGyHepHl49Vmb6KrgRzmzDAYjIpO/T5nOoy1rx/ckiQJR/bPRrlerniKCORVg7
 YTKN9UOzJnBWlheSYQqQfYWybtQDP0BZs5DlyYdBpqEkHyS/pf4mhu1kG1bIV9ru4NEh
 F/uyzJ7h1RbDP5EMwC2+mwsPDK32dnQkfrs6Y/XE+cfa5eiKo9V2FLMRdZHRLdhheZFa VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339fxps4pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 02:03:00 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08162AN0155044;
        Tue, 1 Sep 2020 02:02:59 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339fxps4nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 02:02:58 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0815v8S4017714;
        Tue, 1 Sep 2020 06:02:57 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 337en95nmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 06:02:57 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08162ujg50201072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 06:02:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3439112061;
        Tue,  1 Sep 2020 06:02:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51A53112067;
        Tue,  1 Sep 2020 06:02:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.82.45])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 06:02:47 +0000 (GMT)
Subject: Re: [PATCH v6 2/5] perf/jevents: Add new structure to pass json
 fields.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-3-kjain@linux.ibm.com> <20200831084357.GC287892@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <e0cd9e5c-2e9a-5198-108e-14998a757d62@linux.ibm.com>
Date:   Tue, 1 Sep 2020 11:32:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200831084357.GC287892@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/20 2:13 PM, Jiri Olsa wrote:
> On Thu, Aug 27, 2020 at 06:39:55PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> -	if (!*field)						\
>> +#define TRY_FIXUP_FIELD(field) do { if (es->field && !je->field) {\
>> +	je->field = strdup(es->field);				\
>> +	if (!je->field)						\
>>  		return -ENOMEM;					\
>>  } } while (0)
>>  
>> @@ -428,11 +440,7 @@ static void free_arch_std_events(void)
>>  	}
>>  }
>>  
>> -static int save_arch_std_events(void *data, char *name, char *event,
>> -				char *desc, char *long_desc, char *pmu,
>> -				char *unit, char *perpkg, char *metric_expr,
>> -				char *metric_name, char *metric_group,
>> -				char *deprecated, char *metric_constraint)
>> +static int save_arch_std_events(void *data, struct json_event *je)
>>  {
>>  	struct event_struct *es;
>>  
>> @@ -486,17 +494,16 @@ static char *real_event(const char *name, char *event)
>>  		return NULL;
>>  
>>  	for (i = 0; fixed[i].name; i++)
>> -		if (!strcasecmp(name, fixed[i].name))
>> -			return (char *)fixed[i].event;
>> +		if (!strcasecmp(name, fixed[i].name)) {
>> +			strcpy(event, fixed[i].event);
> 
> hum what's this strcpy for in here? we're just replacing separated
> variables with struct members, why do you need to copy the event in
> here?
> 

Hi Jiri,
    Actually, initially when events is not part of 'json_event' structure, we are not
assigning result of function `real_event` to event field. But as we are not passing
event filed separately in functions like 'save_arch_std_events', freeing event
memory was giving me issue as we are returning pointer from real_event function in some cases.
So, that's why I replace it to strcpy to make sure we free je.event memory. Or should I remove
free(je.event) part?

-		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated, metric_constraint);
+		je.event = real_event(je.name, je.event);

This is the part, I am referring, here we are assigning result of real_event into je.event field.

Thanks,
Kajol Jain
> thanks,
> jirka
> 
