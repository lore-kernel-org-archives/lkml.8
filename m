Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C40C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 06:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864D3206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 06:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgBWGIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 01:08:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26753 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgBWGIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 01:08:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01N64rkU074664
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 01:08:38 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yax36dbeg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 01:08:37 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Sun, 23 Feb 2020 06:08:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 23 Feb 2020 06:08:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01N68TJm40173634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Feb 2020 06:08:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BE604C052;
        Sun, 23 Feb 2020 06:08:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 760224C044;
        Sun, 23 Feb 2020 06:08:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.3.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 23 Feb 2020 06:08:24 +0000 (GMT)
Subject: Re: [PATCH v4 0/5] remove runnable_load_avg and improve
 group_classify
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com, hdanton@sina.com
References: <20200221132715.20648-1-vincent.guittot@linaro.org>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Sun, 23 Feb 2020 11:38:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200221132715.20648-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022306-0008-0000-0000-000003559290
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022306-0009-0000-0000-00004A76A812
Message-Id: <a095f3ef-10d8-b58b-4d84-ac4b06fd91d1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-22_08:2020-02-21,2020-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002230052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/20 6:57 PM, Vincent Guittot wrote:
> This new version stays quite close to the previous one and should 
> replace without problems the previous one that part of Mel's patchset:
> https://lkml.org/lkml/2020/2/14/156
> 
> NUMA load balancing is the last remaining piece of code that uses the 
> runnable_load_avg of PELT to balance tasks between nodes. The normal
> load_balance has replaced it by a better description of the current state
> of the group of cpus.  The same policy can be applied to the numa
> balancing.
> 
> Once unused, runnable_load_avg can be replaced by a simpler runnable_avg
> signal that tracks the waiting time of tasks on rq. Currently, the state
> of a group of CPUs is defined thanks to the number of running task and the
> level of utilization of rq. But the utilization can be temporarly low
> after the migration of a task whereas the rq is still overloaded with
> tasks. In such case where tasks were competing for the rq, the
> runnable_avg will stay high after the migration.
> 
> Some hackbench results:
> 
> - small arm64 dual quad cores system
> hackbench -l (2560/#grp) -g #grp
> 
> grp    tip/sched/core         +patchset              improvement
> 1       1,327(+/-10,06 %)     1,247(+/-5,45 %)       5,97 %
> 4       1,250(+/- 2,55 %)     1,207(+/-2,12 %)       3,42 %
> 8       1,189(+/- 1,47 %)     1,179(+/-1,93 %)       0,90 %
> 16      1,221(+/- 3,25 %)     1,219(+/-2,44 %)       0,16 %						
> 
> - large arm64 2 nodes / 224 cores system
> hackbench -l (256000/#grp) -g #grp
> 
> grp    tip/sched/core         +patchset              improvement
> 1      14,197(+/- 2,73 %)     13,917(+/- 2,19 %)     1,98 %
> 4       6,817(+/- 1,27 %)      6,523(+/-11,96 %)     4,31 %
> 16      2,930(+/- 1,07 %)      2,911(+/- 1,08 %)     0,66 %
> 32      2,735(+/- 1,71 %)      2,725(+/- 1,53 %)     0,37 %
> 64      2,702(+/- 0,32 %)      2,717(+/- 1,07 %)    -0,53 %
> 128     3,533(+/-14,66 %)     3,123(+/-12,47 %)     11,59 %
> 256     3,918(+/-19,93 %)     3,390(+/- 5,93 %)     13,47 %

[...]

I performed similar experiment on IBM POWER9 system with 2 nodes 44 cores
system (22 per node)

- hackbench -l (256000/#grp) -g #grp
+-----+----------------+-------+
| grp | tip/sched/core |  v4   |
+-----+----------------+-------+
|   1 |          76.97 | 76.31 |
|   4 |          56.56 | 56.86 |
|   8 |          54.23 | 54.25 |
|  16 |          53.94 | 53.24 |
|  32 |          54.10 | 54.01 |
|  64 |          54.38 | 54.35 |
| 128 |          55.11 | 55.08 |
| 256 |          55.97 | 56.04 |
| 512 |          54.81 |  55.5 |
+-----+----------------+-------+
- deviation in the result is very marginal ( < 1%)

The results shows no changes with respect to the hackbench. I will do
further benchmarking to see if any observable changes occurs.


- Parth

