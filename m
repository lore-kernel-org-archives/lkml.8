Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7FDC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33196217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgBEBlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 20:41:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbgBEBlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:41:15 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0151bXHH170406
        for <linux-kernel@vger.kernel.org>; Tue, 4 Feb 2020 20:41:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmx40fs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 20:41:13 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maddy@linux.ibm.com>;
        Wed, 5 Feb 2020 01:41:11 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Feb 2020 01:41:07 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0151f6gI35651772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 01:41:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89FA542049;
        Wed,  5 Feb 2020 01:41:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81F9A42045;
        Wed,  5 Feb 2020 01:41:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Feb 2020 01:41:00 +0000 (GMT)
Subject: Re: [RFC] per-CPU usage in perf core-book3s
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
References: <20200127150620.taio2txyqreg4kn6@linutronix.de>
From:   maddy <maddy@linux.ibm.com>
Date:   Wed, 5 Feb 2020 07:10:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127150620.taio2txyqreg4kn6@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20020501-0016-0000-0000-000002E3BB4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020501-0017-0000-0000-000033469948
Message-Id: <c26f6c2c-980f-c1b2-ff7c-7a5e2a5771cd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_09:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=816 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002050009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/20 8:36 PM, Sebastian Andrzej Siewior wrote:
> I've been looking at usage of per-CPU variable cpu_hw_events in
> arch/powerpc/perf/core-book3s.c.
>
> power_pmu_enable() and power_pmu_disable() (pmu::pmu_enable() and
> pmu::pmu_disable()) are accessing the variable and the callbacks are
> invoked always with disabled interrupts.
>
> power_pmu_event_init() (pmu::event_init()) is invoked from preemptible
> context and uses get_cpu_var() to obtain a stable pointer (by disabling
> preemption).
>
> pmu::pmu_enable() and pmu::pmu_disable() can be invoked via a hrtimer
> (perf_mux_hrtimer_handler()) and it invokes pmu::pmu_enable() and
> pmu::pmu_disable() as part of the callback.
>
> Is there anything that prevents the timer callback to interrupt
> pmu::event_init() while it is accessing per-CPU data?

Sorry for the delayed response.

Yes, currently we dont have anything that prevents the timer
callback to interrupt pmu::event_init. Nice catch. Thanks for
pointing this out.

Looking at the code, per-cpu variable access are made to
check for constraints and for Branch Stack (BHRB). So could
wrap this block of  pmu::event_init with local_irq_save/restore.
Will send a patch to fix it.


Maddy

>
> Sebastian

