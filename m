Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA56C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87C5206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GaJaDE4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgHZLav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:30:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16598 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728954AbgHZL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:29:23 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QB3lqv132483;
        Wed, 26 Aug 2020 07:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/uMfs8dcLFyfmE0VQ362ldwbklg2TggVGTlXGfFXvUU=;
 b=GaJaDE4OXTeEux+o5cisoAMdbP1x+nVHZB2KWllZP/wuz1Qx0ekSWQg11wOhkEgM1SZP
 21nz6S0ClxiZfaNs0K7nUr14qmSzamrQM251XsuzT10b4L53YsJ1MoDsTMtd2Lg1mfa6
 mmJs4vClCOmvoG6kT7xOFSjHiuqgNQqT/lohP8sdC6gGLVyblsMYCg5TPmawl1mNRv/R
 qNzv4qXgeKdQxAujhGDPB9QorMlXgDLfOoR9LwRslDDztQmP4ja+Dwj5EUUOD/7K6eEs
 XP3sYfDSVfYgqZpOZTb7OaKdoB98YVlqhBgGPu55jaL7vdv4EXXGNXMcGgS3/l8jYVMg bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335mhv3sgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:28:19 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QB44Pm133240;
        Wed, 26 Aug 2020 07:28:18 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335mhv3seq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:28:17 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QBQr1d005557;
        Wed, 26 Aug 2020 11:28:15 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 332uw7h7gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 11:28:15 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QBSFtp12911158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:28:15 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EAFEAE05F;
        Wed, 26 Aug 2020 11:28:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BCF8AE05C;
        Wed, 26 Aug 2020 11:28:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.94])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 11:28:10 +0000 (GMT)
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <20200826105705.GD703542@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <88deef00-2e14-5261-d31d-9b1117d6592e@linux.ibm.com>
Date:   Wed, 26 Aug 2020 16:58:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826105705.GD703542@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 4:27 PM, Jiri Olsa wrote:
> On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
>> index 2afc8304529e..e696edf70e9a 100644
>> --- a/tools/perf/pmu-events/jevents.h
>> +++ b/tools/perf/pmu-events/jevents.h
>> @@ -2,14 +2,28 @@
>>  #ifndef JEVENTS_H
>>  #define JEVENTS_H 1
>>  
>> +#include "pmu-events.h"
>> +
>> +struct json_event {
>> +	char *name;
>> +	char *event;
>> +	char *desc;
>> +	char *topic;
>> +	char *long_desc;
>> +	char *pmu;
>> +	char *unit;
>> +	char *perpkg;
>> +	char *metric_expr;
>> +	char *metric_name;
>> +	char *metric_group;
>> +	char *deprecated;
>> +	char *metric_constraint;
>> +};
>> +
>>  int json_events(const char *fn,
>> -		int (*func)(void *data, char *name, char *event, char *desc,
>> -				char *long_desc,
>> -				char *pmu,
>> -				char *unit, char *perpkg, char *metric_expr,
>> -				char *metric_name, char *metric_group,
>> -				char *deprecated, char *metric_constraint),
>> -		void *data);
>> +		int (*func)(void *data, struct json_event *je),
>> +			void *data);
> 
> please also add typedef for the function,
> it's used in other places as well

Ok I will add that part.

Thanks,
Kajol Jain
> 
> thanks,
> jirka
> 
