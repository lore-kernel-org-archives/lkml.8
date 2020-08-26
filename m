Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF5F221E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aVQlORT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHZOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:37:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbgHZOhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:37:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QEYtOg142777;
        Wed, 26 Aug 2020 10:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Z558S2nodXLm4F/1ZPPki9oJvRdlnNOJaMdxJSjvL/g=;
 b=aVQlORT09BYK3fDkFGQefoV5xK4mz0LJfg9CSLhbdRX1GoPDxxVaG13f9xTOIyQEQlLg
 JpC3jEXRQOv2e8VsRwtFS/rjbsJ+A5xnvvT3vjTPfww4I5PCsIFdUD5Rcy42Ork3Sdvl
 QPVBc0i3J9k7XJOI9utc+eEeQ951tTRXbW7Dbq3LdNeNASShBpqHSIvAW6zDqfv7VVod
 zjdW9rwzmT5NptpCPzoITftnjjKzMhKDlhXrlb6rHmXqf3iotRaKf37EMy6BGasmmetq
 tcPhuGVVXxq3TQOx92IBzzxao/yMQzUm/1Ua4XgtNgtYaPR2n8vuicMZWoWHvLbs8E39 Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335sccrjxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 10:37:28 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QEZ6Fm143953;
        Wed, 26 Aug 2020 10:37:28 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335sccrjwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 10:37:28 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QELqgK024981;
        Wed, 26 Aug 2020 14:37:27 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 335kvcb299-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 14:37:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QEbQ3749021196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 14:37:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DC3AB206A;
        Wed, 26 Aug 2020 14:37:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88462B2064;
        Wed, 26 Aug 2020 14:37:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.63.208])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 14:37:22 +0000 (GMT)
Subject: Re: [RFC] perf/core: Fixes hung issue on perf stat command during cpu
 hotplug
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com
References: <20200826093236.446024-1-kjain@linux.ibm.com>
 <20200826132107.GH1059382@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <135a1238-9a43-8335-e8a6-961678e95f65@linux.ibm.com>
Date:   Wed, 26 Aug 2020 20:07:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826132107.GH1059382@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_09:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 6:51 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 26, 2020 at 03:02:36PM +0530, Kajol Jain escreveu:
>> Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
>> added assignment of ret value as -EAGAIN in case function
>> call to 'smp_call_function_single' fails.
>> For non-zero ret value, it did 
>> 'ret = !ret ? data.ret : -EAGAIN;', which always
>> assign -EAGAIN to ret and make second if condition useless.
>>
>> In scenarios like when executing a perf stat with --per-thread option, and 
>> if any of the monitoring cpu goes offline, the 'smp_call_function_single'
>> function could return -ENXIO, and with the above check,
>> task_function_call hung and increases CPU
>> usage (because of repeated 'smp_call_function_single()')
>>
>> Recration scenario:
>> 	# perf stat -a --per-thread && (offline a CPU )
> 
> Peter, this is kernel stuff, can you take a look?
> 
> - Arnaldo
>  
>> Patch here removes the tertiary condition added as part of that 
>> commit and added a check for NULL and -EAGAIN.
>>
>> Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> ---
>>  kernel/events/core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 5bfe8e3c6e44..330c53f7df9c 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -115,9 +115,9 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>>  	for (;;) {
>>  		ret = smp_call_function_single(task_cpu(p), remote_function,
>>  					       &data, 1);
>> -		ret = !ret ? data.ret : -EAGAIN;
>> -
>> -		if (ret != -EAGAIN)
>> +		if (!ret)
>> +			ret = data.ret;
>> +		else if (ret != -EAGAIN)
>>  			break;
>>  
>>  		cond_resched();
>> -- 

Hi,
  Sorry for the confusion, I send wrong version of the patch. We don't have else in second
condition.

The right patch changes are:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5bfe8e3c6e44..53d960394af9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -115,8 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
        for (;;) {
                ret = smp_call_function_single(task_cpu(p), remote_function,
                                               &data, 1);
-               ret = !ret ? data.ret : -EAGAIN;
-
+               if (!ret)
+                       ret = data.ret;
                if (ret != -EAGAIN)
                        break;

I will again send the patch, please ignore this one.

Thanks,
Kajol Jain
 
>> 2.26.2
>>
> 
