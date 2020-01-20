Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2DCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869DA21835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgATR10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:27:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgATR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:27:26 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KHRNri121570
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 12:27:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgbp9qd5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 12:27:24 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 20 Jan 2020 17:27:14 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 17:27:10 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KHR9GP58917074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 17:27:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E7224C04A;
        Mon, 20 Jan 2020 17:27:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D3C34C05A;
        Mon, 20 Jan 2020 17:27:07 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 20 Jan 2020 17:27:06 +0000 (GMT)
Date:   Mon, 20 Jan 2020 22:57:06 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200114101319.GO3466@techsingularity.net>
 <20200117175631.GC20112@linux.vnet.ibm.com>
 <20200117215853.GS3466@techsingularity.net>
 <20200120080935.GD20112@linux.vnet.ibm.com>
 <20200120083354.GT3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200120083354.GT3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 20012017-0016-0000-0000-000002DF23A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012017-0017-0000-0000-00003341C877
Message-Id: <20200120172706.GE20112@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_07:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001200147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And this is why I'm curious as to why your workload is affected at all
> because it uses many tasks.  I stopped allowing an imbalance for higher
> task counts partially on the basis of your previous report.
> 

With this hunk on top of your patch and 5 runs of numa02, there were 0
traces.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ade7a8dca5e4..7506cf67bde8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8714,8 +8714,10 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * the risk that lower domains have to be rebalanced.
 			 */
 			imbalance_min = 2;
-			if (busiest->sum_nr_running <= imbalance_min)
+			if (busiest->sum_nr_running <= imbalance_min) {
+				trace_printk("Reseting imbalance: busiest->sum_nr_running=%d, local->sum_nr_running=%d\n", busiest->sum_nr_irunning, local->sum_nr_running);
 				env->imbalance = 0;
+			}
 		}
 
 		return;


perf stat for the 5 iterations this time shows: 
77.817 +- 0.995 seconds time elapsed  ( +-  1.28% )
which I think is significantly less than last time around.

So I think it may be some other noise that could have contributed to the
jump last time. Also since the time consumption of numa02 is very small, a
small disturbance can show up as a big number from a percentage perspective.

-- 
Thanks and Regards
Srikar Dronamraju

