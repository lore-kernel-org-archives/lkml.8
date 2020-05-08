Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C78C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87490208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEHLTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:19:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:19:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048B2u2I022139;
        Fri, 8 May 2020 07:19:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtxq117q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 07:19:13 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048B3GoK023430;
        Fri, 8 May 2020 07:19:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtxq116v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 07:19:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048BFeIT009146;
        Fri, 8 May 2020 11:19:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5wa1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 11:19:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048BJ8nI46792730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 11:19:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C5B84204D;
        Fri,  8 May 2020 11:19:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E19CB42047;
        Fri,  8 May 2020 11:19:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.16.192])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 May 2020 11:19:05 +0000 (GMT)
Subject: Re: [RFC 3/4] sched/idle: Disable idle call on least latency
 requirements
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-4-parth@linux.ibm.com>
 <20200508083601.GJ19464@codeaurora.org>
From:   Parth Shah <parth@linux.ibm.com>
Message-ID: <328de1bf-57d1-023d-29aa-11a540212015@linux.ibm.com>
Date:   Fri, 8 May 2020 16:49:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200508083601.GJ19464@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_08:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 5/8/20 2:06 PM, Pavan Kondeti wrote:
> On Thu, May 07, 2020 at 07:07:22PM +0530, Parth Shah wrote:
>> Restrict the call to deeper idle states when the given CPU has been set for
>> the least latency requirements
>>
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>> ---
>>  kernel/sched/idle.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index b743bf38f08f..85d72a6e2521 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -262,7 +262,8 @@ static void do_idle(void)
>>  		 * broadcast device expired for us, we don't want to go deep
>>  		 * idle as we know that the IPI is going to arrive right away.
>>  		 */
>> -		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
>> +		if (cpu_idle_force_poll || tick_check_broadcast_expired() ||
>> +		    per_cpu(nr_lat_sensitive, cpu)) {
>>  			tick_nohz_idle_restart_tick();
>>  			cpu_idle_poll();
>>  		} else {
>> -- 
>> 2.17.2
>>
> 
> Since nr_lat_sensitive updates can happen remotely (when a latency sensitive
> task becomes non-latency sensitive task), we may need to add this condition
> in cpu_idle_poll() as well.
> 

Right. but if the CPU is running idle_task then it will again come back to
do_idle and read the refcount. Its a penalty in power-saving for 1
do_idle() loop but it is difficult to put up checks for any change in
latency_nice value.

Thanks,
Parth
