Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A91C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83822080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FQ8/WBuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgHZLp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:45:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728937AbgHZLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:33:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QBXNog102735;
        Wed, 26 Aug 2020 07:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xGvxLqGFlrJEgy/PRkSIuvKr93kWjxHeuG4oSS3mJ2s=;
 b=FQ8/WBuWGF7wIcUrArbIJBOHkfI9lz0DQQd5HrOyEvVlkXmpLRAk+5XEvjyWlGUjXmuY
 5bhYOI+jowlAAUwXTZC8kEjfps2Jms6cU6xfglKoJ6n4QIOmhibgddM4BFaJCBUB2zQu
 /mT+R3zaIKOtLgb0NbEsPWALk7JewAfKJMsJlvmOSAI4O4i33iQRs7SfMofNCfdPTfMo
 IFgmA4x+mxVHt6AuN6pS8fPGA39BNl7S7qIz6dIWzfvmB2jLqkI5/Eb9xpZ1kB/DdAtf
 dGyjRmoBcBq/NSqN9uBxnlDivp9Dmc+N6ItTFs7J1KaZSM/OhVpXilvBppWTIP55P3Eh gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335nxh1uxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:33:30 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QBXR8S102994;
        Wed, 26 Aug 2020 07:33:27 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335nxh1uwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:33:27 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QBVpsn032007;
        Wed, 26 Aug 2020 11:33:24 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 335kvc9md1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 11:33:24 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QBXOGW53477768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:33:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9B09AE05C;
        Wed, 26 Aug 2020 11:33:23 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2E60AE062;
        Wed, 26 Aug 2020 11:33:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.94])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 11:33:20 +0000 (GMT)
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <20200826105712.GE703542@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <5f902ab4-c156-8011-7cbc-8706cc96489f@linux.ibm.com>
Date:   Wed, 26 Aug 2020 17:03:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826105712.GE703542@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=2 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 4:27 PM, Jiri Olsa wrote:
> On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
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
>> @@ -485,11 +476,8 @@ static char *real_event(const char *name, char *event)
>>  }
>>  
>>  static int
>> -try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>> -	  char **name, char **long_desc, char **pmu, char **filter,
>> -	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
>> -	  char **metric_group, unsigned long long eventcode,
>> -	  char **deprecated, char **metric_constraint)
>> +try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
>> +	  struct json_event *je)
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
> 
> should you free je->event in here?

Sure, I will add that.

Thanks,
Kajol Jain
> 
> jirka
> 
