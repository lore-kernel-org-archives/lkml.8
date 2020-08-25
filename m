Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE51DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8955420738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nod9U/+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHYC7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:59:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727935AbgHYC7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:59:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P2WEcp104893;
        Mon, 24 Aug 2020 22:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=/qls1/xChu/1XznckOaVVuSv1KynuZebmcC+LdDqFqc=;
 b=nod9U/+GopzB9ZJ766O+EVSFOyRFBHmRtm9PAzt4nFUTQxiX3sRK2DI/NGLyj5NaapyX
 6x4BmngJCaV6nZ/FQ/TxPqsDUlZuKPvfkth0irv8TQHHkWYTBs/AFpDQM2SPEVF90UHi
 mv40zzk1jg3F8+eIGm0B5hyekpGS+GUqWL+GXbqcZ1wt8pJg1sG/FRwAQSvnaORiVgkq
 WsjY7xTaRLFmidRQN9hAYbdGfERz+qgTmSTdx679ySWfhNI1zmSUc+whGOkKqqZcUrr+
 8af/Ezyf7IJJjlNO/pm8diBdC/eYg0vIE3gY8ZfJDi6Bm2dbaMyYzHMBsqmCCGWQTdKd gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334sekh46v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 22:59:42 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07P2WcdB105939;
        Mon, 24 Aug 2020 22:59:42 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334sekh46c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 22:59:41 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P2qSLm026477;
        Tue, 25 Aug 2020 02:59:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 332ujjstkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 02:59:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07P2w7XI60883386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 02:58:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC05911C04C;
        Tue, 25 Aug 2020 02:59:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BB5B11C04A;
        Tue, 25 Aug 2020 02:59:36 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 25 Aug 2020 02:59:36 +0000 (GMT)
Date:   Tue, 25 Aug 2020 08:29:35 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     xunlei <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix wrong cpu selecting from isolated domain
Message-ID: <20200825025935.GB31355@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
 <20200824133820.GA31355@linux.vnet.ibm.com>
 <b84b9194-b79e-a708-6151-1bbb0826b70e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b84b9194-b79e-a708-6151-1bbb0826b70e@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* xunlei <xlpang@linux.alibaba.com> [2020-08-25 10:11:24]:

> On 2020/8/24 PM9:38, Srikar Dronamraju wrote:
> > * Xunlei Pang <xlpang@linux.alibaba.com> [2020-08-24 20:30:19]:
> > 
> >> We've met problems that occasionally tasks with full cpumask
> >> (e.g. by putting it into a cpuset or setting to full affinity)
> >> were migrated to our isolated cpus in production environment.
> >>
> >> After some analysis, we found that it is due to the current
> >> select_idle_smt() not considering the sched_domain mask.
> >>
> >> Fix it by checking the valid domain mask in select_idle_smt().
> >>
> >> Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
> >> Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
> >> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> >> ---
> >>  kernel/sched/fair.c | 9 +++++----
> >>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 1a68a05..fa942c4 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6075,7 +6075,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> >>  /*
> >>   * Scan the local SMT mask for idle CPUs.
> >>   */
> >> -static int select_idle_smt(struct task_struct *p, int target)
> >> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> >>  {
> >>  	int cpu;
> >>  
> >> @@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p, int target)
> >>  		return -1;
> >>  
> >>  	for_each_cpu(cpu, cpu_smt_mask(target)) {
> >> -		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >> +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> >> +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> >>  			continue;
> > 
> > Don't think this is right thing to do.  What if this task had set a cpumask
> > that doesn't cover all the cpus in this sched_domain_span(sd)

ah, right I  missed the 'or' part.
> 
> It doesn't matter, without this patch, it selects an idle cpu from:
> "cpu_smt_mask(target) and p->cpus_ptr"
> 
> with this patch, it selects an idle cpu from:
> "cpu_smt_mask(target) and p->cpus_ptr and sched_domain_span(sd)"
> 
> > 
> > cpu_smt_mask(target) would already limit to the sched_domain_span(sd) so I
> > am not sure how this can help?
> > 
> > 
> 
> Here is an example:
> CPU0 and CPU16 are hyper-thread pair, CPU16 is domain isolated. So its
> sd_llc doesn't contain CPU16, and cpu_smt_mask(0) is 0 and 16.
> 
> Then we have @target is 0, select_idle_smt() may return the isolated(and
> idle) CPU16 without this patch.

Okay.

-- 
Thanks and Regards
Srikar Dronamraju
