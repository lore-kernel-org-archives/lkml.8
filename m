Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B1AC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1FA208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgD2I4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:56:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgD2I4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:56:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T8XZOn038708;
        Wed, 29 Apr 2020 04:56:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhq9cbdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 04:56:20 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03T8YN0K042932;
        Wed, 29 Apr 2020 04:56:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhq9cbc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 04:56:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03T8uD4Q024356;
        Wed, 29 Apr 2020 08:56:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5r142-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 08:56:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03T8uDf361473168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 08:56:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28B78AE051;
        Wed, 29 Apr 2020 08:56:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6942AE045;
        Wed, 29 Apr 2020 08:56:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.16])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Apr 2020 08:56:07 +0000 (GMT)
Subject: Re: [PATCH v7 1/5] powerpc/perf/hv-24x7: Fix inconsistent output
 values incase multiple hv-24x7 events run
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
References: <20200327063642.26175-1-kjain@linux.ibm.com>
 <20200327063642.26175-2-kjain@linux.ibm.com>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
Message-ID: <3c209251-ceab-7381-99e3-b5664ce3104b@linux.ibm.com>
Date:   Wed, 29 Apr 2020 14:26:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200327063642.26175-2-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_02:2020-04-28,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/20 12:06 PM, Kajol Jain wrote:
> Commit 2b206ee6b0df ("powerpc/perf/hv-24x7: Display change in counter
> values")' added to print _change_ in the counter value rather then raw
> value for 24x7 counters. Incase of transactions, the event count
> is set to 0 at the beginning of the transaction. It also sets
> the event's prev_count to the raw value at the time of initialization.
> Because of setting event count to 0, we are seeing some weird behaviour,
> whenever we run multiple 24x7 events at a time.
>
> For example:
>
> command#: ./perf stat -e "{hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/,
> 			   hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/}"
> 	  		   -C 0 -I 1000 sleep 100
>
>       1.000121704                120 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>       1.000121704                  5 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
>       2.000357733                  8 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>       2.000357733                 10 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
>       3.000495215 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>       3.000495215 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
>       4.000641884                 56 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>       4.000641884 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
>       5.000791887 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>
> Getting these large values in case we do -I.
>
> As we are setting event_count to 0, for interval case, overall event_count is not
> coming in incremental order. As we may can get new delta lesser then previous count.
> Because of which when we print intervals, we are getting negative value which create
> these large values.
>
> This patch removes part where we set event_count to 0 in function
> 'h_24x7_event_read'. There won't be much impact as we do set event->hw.prev_count
> to the raw value at the time of initialization to print change value.
>
> With this patch
> In power9 platform
>
> command#: ./perf stat -e "{hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/,
> 		           hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/}"
> 			   -C 0 -I 1000 sleep 100
>
>       1.000117685                 93 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>       1.000117685                  1 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
>       2.000349331                 98 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>       2.000349331                  2 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
>       3.000495900                131 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>       3.000495900                  4 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
>       4.000645920                204 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>       4.000645920                 61 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
>       4.284169997                 22 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Suggested-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Tested-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> ---
>   arch/powerpc/perf/hv-24x7.c | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 573e0b309c0c..48e8f4b17b91 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1400,16 +1400,6 @@ static void h_24x7_event_read(struct perf_event *event)
>   			h24x7hw = &get_cpu_var(hv_24x7_hw);
>   			h24x7hw->events[i] = event;
>   			put_cpu_var(h24x7hw);
> -			/*
> -			 * Clear the event count so we can compute the _change_
> -			 * in the 24x7 raw counter value at the end of the txn.
> -			 *
> -			 * Note that we could alternatively read the 24x7 value
> -			 * now and save its value in event->hw.prev_count. But
> -			 * that would require issuing a hcall, which would then
> -			 * defeat the purpose of using the txn interface.
> -			 */
> -			local64_set(&event->count, 0);
>   		}
>
>   		put_cpu_var(hv_24x7_reqb);

