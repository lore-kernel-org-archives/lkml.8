Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0F32177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHDMN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:13:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23615 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbgHDMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:11:02 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074C5Bs1186779;
        Tue, 4 Aug 2020 08:10:16 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32q1uph5td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 08:10:15 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074CADsb015506;
        Tue, 4 Aug 2020 12:10:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 32n01839f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 12:10:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074CAAVA19792202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 12:10:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F5652054;
        Tue,  4 Aug 2020 12:10:10 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 6EA9052051;
        Tue,  4 Aug 2020 12:10:08 +0000 (GMT)
Date:   Tue, 4 Aug 2020 17:40:07 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH 1/2] sched/topology: Allow archs to override cpu_smt_mask
Message-ID: <20200804121007.GJ24375@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
 <20200804104520.GB2657@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200804104520.GB2657@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008040090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* peterz@infradead.org <peterz@infradead.org> [2020-08-04 12:45:20]:

> On Tue, Aug 04, 2020 at 09:03:06AM +0530, Srikar Dronamraju wrote:
> > cpu_smt_mask tracks topology_sibling_cpumask. This would be good for
> > most architectures. One of the users of cpu_smt_mask(), would be to
> > identify idle-cores. On Power9, a pair of cores can be presented by the
> > firmware as a big-core for backward compatibility reasons.
> > 
> > In order to maintain userspace backward compatibility with previous
> > versions of processor, (since Power8 had SMT8 cores), Power9 onwards there
> > is option to the firmware to advertise a pair of SMT4 cores as a fused
> > cores (referred to as the big_core mode in the Linux Kernel). On Power9
> > this pair shares the L2 cache as well. However, from the scheduler's point
> > of view, a core should be determined by SMT4. The load-balancer already
> > does this. Hence allow PowerPc architecture to override the default
> > cpu_smt_mask() to point to the SMT4 cores in a big_core mode.
> 
> I'm utterly confused.
> 
> Why can't you set your regular siblings mask to the smt4 thing? Who
> cares about the compat stuff, I thought that was an LPAR/AIX thing.

There are no technical challenges to set the sibling mask to SMT4.
This is for Linux running on PowerVM. When these Power9 boxes are sold /
marketed as X core boxes (where X stand for SMT8 cores).  Since on PowerVM
world, everything is in SMT8 mode, the device tree properties still mark
the system to be running on 8 thread core. There are a number of utilities
like ppc64_cpu that directly read from device-tree. They would get core
count and thread count which is SMT8 based.

If the sibling_mask is set to small core, then same user when looking at
output from lscpu and other utilities that look at sysfs will start seeing
2x number of cores to what he had provisioned and what the utilities from
the device-tree show. This can gets users confused.

So to keep the device-tree properties, utilities depending on device-tree,
sysfs and utilities depending on sysfs on the same page, userspace are only
exposed as SMT8.

-- 
Thanks and Regards
Srikar Dronamraju
