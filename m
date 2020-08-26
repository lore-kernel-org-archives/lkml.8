Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32040C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0869F2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VwLa+QOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgHZLgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:36:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2790 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729014AbgHZLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:32:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QB3od4080051;
        Wed, 26 Aug 2020 07:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4eXDfD5rVGDAjc8r1Yuvxe5ZNNL4uH8zIUNDwtPm2/M=;
 b=VwLa+QOBaclHgcdSrYDrU4k2ccZpZfrFYXMy4HnR2EiTVtfhjUJMYEO7+Q1JDufbf+3r
 cqzb1ORB6ygSBZmS6J0ZwAIRkEe23hgrwiW0z7EC+CbXSpMwqQaOqQnSZu4gA3wjHNk4
 9AtUx1ZRlAD+kFOGF+wghrbEzHIIb7/0FYRgGLu3YBlC9N0KOP5toVsdQ69V8CtF/Of6
 tk6QqHqSG1pujaRO4MM17IWU6I7LB24B7ozLF0kUKUeoKqMUmcoAv5M0fsfftbuReN+7
 pKgd2ouXvNtzuyv+QKMQCm6xMhac2HHhyNFhfW5Ip4JQ8D2Yxf+iGzvVmE3yrtcTJ7Gs YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335pe1916n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:32:10 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QBKATr145051;
        Wed, 26 Aug 2020 07:32:10 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335pe1916d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:32:10 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QBVg97012085;
        Wed, 26 Aug 2020 11:32:09 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 332uttsn3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 11:32:09 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QBW8ne30015866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:32:08 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A55AE05F;
        Wed, 26 Aug 2020 11:32:08 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B48D2AE05C;
        Wed, 26 Aug 2020 11:32:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.94])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 11:32:05 +0000 (GMT)
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <20200826105656.GC703542@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <6a4e977e-4f77-6a2a-252c-cfdda26db3e2@linux.ibm.com>
Date:   Wed, 26 Aug 2020 17:02:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826105656.GC703542@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=2 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 4:26 PM, Jiri Olsa wrote:
> On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>>  {
>>  	/* try to find matching event from arch standard values */
>>  	struct event_struct *es;
>> @@ -498,8 +486,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>>  		if (!strcmp(arch_std, es->name)) {
>>  			if (!eventcode && es->event) {
>>  				/* allow EventCode to be overridden */
>> -				free(*event);
>> -				*event = NULL;
>> +				je->event = NULL;
>>  			}
>>  			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
>>  			return 0;
>> @@ -513,13 +500,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>>  
>>  /* Call func with each event in the json file */
>>  int json_events(const char *fn,
>> -	  int (*func)(void *data, char *name, char *event, char *desc,
>> -		      char *long_desc,
>> -		      char *pmu, char *unit, char *perpkg,
>> -		      char *metric_expr,
>> -		      char *metric_name, char *metric_group,
>> -		      char *deprecated, char *metric_constraint),
>> -	  void *data)
>> +		int (*func)(void *data, struct json_event *je),
>> +			void *data)
>>  {
>>  	int err;
>>  	size_t size;
>> @@ -537,24 +519,16 @@ int json_events(const char *fn,
>>  	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
>>  	tok = tokens + 1;
>>  	for (i = 0; i < tokens->size; i++) {
>> -		char *event = NULL, *desc = NULL, *name = NULL;
>> -		char *long_desc = NULL;
>>  		char *extra_desc = NULL;
>> -		char *pmu = NULL;
>>  		char *filter = NULL;
>> -		char *perpkg = NULL;
>> -		char *unit = NULL;
>> -		char *metric_expr = NULL;
>> -		char *metric_name = NULL;
>> -		char *metric_group = NULL;
>> -		char *deprecated = NULL;
>> -		char *metric_constraint = NULL;
>> +		struct json_event *je;
>>  		char *arch_std = NULL;
>>  		unsigned long long eventcode = 0;
>>  		struct msrmap *msr = NULL;
>>  		jsmntok_t *msrval = NULL;
>>  		jsmntok_t *precise = NULL;
>>  		jsmntok_t *obj = tok++;
>> +		je = (struct json_event *)calloc(1, sizeof(struct json_event));
> 
> hum, you don't check je pointer in here.. but does it need to be allocated?
> looks like you could just have je on stack as well..

Hi Jiri,
   Yes I will add check for je pointer here.The reason for allocating memory to 'je' is,
later we are actually referring one by one to its field and in case if won't allocate memory
we will get segmentaion fault as otherwise je will be NULL. Please let me know if I am
getting correct.

Thanks,
Kajol Jain

> 
> thanks,
> jirka
> 
