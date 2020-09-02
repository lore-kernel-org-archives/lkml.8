Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C0D20829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X9O0/KTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgIBP62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:58:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726726AbgIBP6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:58:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082FWqwC106915;
        Wed, 2 Sep 2020 11:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QIDdtCOgueWMp2J0F3PUAzScjnSVqXQwKJu2mfqhqhU=;
 b=X9O0/KTQPEY8w/PyubqXFRQpYKPAxk1KtZw25XXYPTLXfuRp377S/QvityzlUVHaDTVu
 5sRWVgbFgEL74zH1NsxmhaRT7Fbu4N8PX30fzdT92miG1WpTEz9xLhTzQoXKKlWnwxec
 H/EVKRxQyIlRWXncmYLe7o2gkk9JW2ZuBXe4Srho1Pdo/m89bPcFYy0qQJppP0oFJ31Q
 fmdiyjH4bTtXYHhrwLhKHnk0bYUhBpRiD637NQgkJqSd1YzprE/fahxDjwxU7tJQYEzW
 j1IBB3NBzwO+IW/MbXDbAYjbenvcGD8YTwVlJo4POsBgjfEPwmy3DTX1PyaFp0Q6S2bG UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33ac9un2ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 11:58:04 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082FXdri110595;
        Wed, 2 Sep 2020 11:58:03 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33ac9un29w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 11:58:03 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082FqBT9023909;
        Wed, 2 Sep 2020 15:58:02 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 337ena19hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 15:58:02 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082FvwRw36569532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 15:57:58 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74038C605D;
        Wed,  2 Sep 2020 15:58:01 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BA35C6057;
        Wed,  2 Sep 2020 15:57:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.83.99])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 15:57:55 +0000 (GMT)
Subject: Re: [PATCH] perf/core: Fix hung issue on perf stat command during cpu
 hotplug
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com
References: <20200827064732.20860-1-kjain@linux.ibm.com>
 <20200902150516.GA3474644@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <42e61c14-4774-600d-2347-2cf2f8b2a59e@linux.ibm.com>
Date:   Wed, 2 Sep 2020 21:27:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200902150516.GA3474644@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009020148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/20 8:35 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 27, 2020 at 12:17:32PM +0530, Kajol Jain escreveu:
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
>>
>> Patch here removes the tertiary condition added as part of that
>> commit and added a check for NULL and -EAGAIN.
> 
> I reproduced this issue with v5.9-rc3, now have to reboot for a conf
> call, will try to test the patch afterwards,
> 
> [65108.467416] IRQ 165: no longer affine to CPU23
> [65108.468495] smpboot: CPU 23 is now offline
> [65129.003879] Uhhuh. NMI received for unknown reason 1c on CPU 20.
> [65129.003880] Do you have a strange power saving mode enabled?
> [65129.003880] Dazed and confused, but trying to continue
> [65156.155539] Uhhuh. NMI received for unknown reason 1c on CPU 2.
> [65156.155539] Do you have a strange power saving mode enabled?
> [65156.155540] Dazed and confused, but trying to continue
> [65161.985284] Uhhuh. NMI received for unknown reason 1c on CPU 21.
> [65161.985285] Do you have a strange power saving mode enabled?
> [65161.985285] Dazed and confused, but trying to continue
> [65183.154444] Uhhuh. NMI received for unknown reason 1c on CPU 1.
> [65183.154445] Do you have a strange power saving mode enabled?
> [65183.154446] Dazed and confused, but trying to continue
> [65189.724797] Uhhuh. NMI received for unknown reason 0c on CPU 4.
> [65189.724798] Do you have a strange power saving mode enabled?
> [65189.724799] Dazed and confused, but trying to continue
> [65196.259918] Uhhuh. NMI received for unknown reason 1c on CPU 11.
> [65196.259918] Do you have a strange power saving mode enabled?
> [65196.259918] Dazed and confused, but trying to continue
> [65234.794490] Uhhuh. NMI received for unknown reason 0c on CPU 5.
> [65234.794491] Do you have a strange power saving mode enabled?
> [65234.794491] Dazed and confused, but trying to continue
> [65454.559831] Uhhuh. NMI received for unknown reason 1c on CPU 19.
> [65454.559832] Do you have a strange power saving mode enabled?
> [65454.559832] Dazed and confused, but trying to continue
> [65529.657789] Uhhuh. NMI received for unknown reason 1c on CPU 3.
> [65529.657790] Do you have a strange power saving mode enabled?
> [65529.657790] Dazed and confused, but trying to continue
> [acme@five perf]$
> 
> 
> Things seems to be working again after bringing that CPU back online:

Hi Arnaldo,
    You are right, once we bring back the CPU again, things will start working as our 'smp_call_function_single'
will not fail and we will come out of the loop. But till then, task_function_call will be hung.

Thanks,
Kajol Jain
> 
> [root@five ~]# perf top --stdio -C 0-22
> Error:
> The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (cycles).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> [root@five ~]# perf stat -e cycles sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (cycles).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> [root@five ~]# perf record -e cycles sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (cycles).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> [root@five ~]# echo 1 > /sys/devices/system/cpu/cpu23/online
> [root@five ~]# perf record -e cycles sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.039 MB perf.data (7 samples) ]
> [root@five ~]# perf stat -e cycles sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>            842,743      cycles
> 
>        1.000903853 seconds time elapsed
> 
>        0.000902000 seconds user
>        0.000000000 seconds sys
> 
> 
> [root@five ~]# perf stat -e cycles sleep 1
> 
> 
> - Arnaldo
> 
>  
>> Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reviewed-by: Barret Rhoden <brho@google.com>
>> Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> ---
>>  kernel/events/core.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> Changelog:
>> - Remove RFC tag
>> - Resolve some nits issues like space after if and
>>   added -ENXIO in comment msg of function 'task_function_call'
>>   as suggested by Barret Rhoden.
>>
>> Link to the RFC: https://lkml.org/lkml/2020/8/26/896
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 5bfe8e3c6e44..cef646084198 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -99,7 +99,7 @@ static void remote_function(void *data)
>>   * retry due to any failures in smp_call_function_single(), such as if the
>>   * task_cpu() goes offline concurrently.
>>   *
>> - * returns @func return value or -ESRCH when the process isn't running
>> + * returns @func return value or -ESRCH or -ENXIO when the process isn't running
>>   */
>>  static int
>>  task_function_call(struct task_struct *p, remote_function_f func, void *info)
>> @@ -115,7 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>>  	for (;;) {
>>  		ret = smp_call_function_single(task_cpu(p), remote_function,
>>  					       &data, 1);
>> -		ret = !ret ? data.ret : -EAGAIN;
>> +		if (!ret)
>> +			ret = data.ret;
>>  
>>  		if (ret != -EAGAIN)
>>  			break;
>> -- 
>> 2.26.2
>>
> 
