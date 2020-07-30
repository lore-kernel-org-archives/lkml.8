Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD32BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7189E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lG1Eor+G";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YovdFdMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgG3QYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:24:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63820 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727072AbgG3QYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:24:11 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06UGLlDH014438;
        Thu, 30 Jul 2020 09:23:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=m0u9wtXG8lIQ1ZrTfyw/HuORNAtdzaJwhfXi2kHExUk=;
 b=lG1Eor+GVpfnvUuP66uAV+Yrz2Quc4gv5DNoRMJ/SIdl+VGMG6+fER8X1wCeqpTJCrfz
 ufvBnXLSHN2Z1nVmaCnvTTNHB33i/9d7Ohua6RN1WGx4aQL1vd/8bhK4gCPzsxTsDwuN
 ELQL4MNmaRyaEBDNiJ5fCg/4eTcUhs8Tu00= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32kcbuwj3r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Jul 2020 09:23:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 09:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItySUf4gsNjDV27Xv8HRCNvhtQ+9bCZRoApY108o6JTASxlG3Hy3iNqW5Ea0wjqbHwsVcmgBwCg/vCCgZqOYJWc7HbML8jLoBcK5YvzrM+OQj0//SaCXMMQZmXShA6t+Dt9C2ONCZVkyBv6R0+0CcG7hDv6PhaACQJnQfAMzIBFbk670WFgP36ZMPJaZ+vQbCeOVJPcZV35S6cn3/swcHniiGKZZci5MbbkROs47oe05qEgn3bjYXVNMWRngbyLXo8O7H/653LtCrg9/ljpsHtsBGGFWp/tEtG+PCXlTL3qSFHtj23ghhZcn3O1WOcPu+O83uj//8pdfX068hWtz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0u9wtXG8lIQ1ZrTfyw/HuORNAtdzaJwhfXi2kHExUk=;
 b=CKq9We2eUBIN0lI1M2asyaktuXd5KvktqlkWCkroj3tsAZo2E56IpFDb1naScN9hBVvULAnoiHRxNI9WK/A2hKdeWrcPSYeo5vquJhop7rAzI+JpfFjfmfBrcqThY6GmtbG/3xFZYFBhHh+S7q/d8yxTMUgKKEcrnrjuPwcsfRvsNGdYeT80ZOXEJLhCS/pflg8wVGhGuLPlAt/dL8C4sXDd7xI7hwtJs4ArZvbwRR5YA56O4LgkwECTqcrjU7gPPWJhCCXhPr2xsapJHzpevQZHfTZGTLU+L6XOI/3wo+Nwxqa5JV5Lcz0B6tdb4b4NxYb3bCnL1AJ6vd/RMhX9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0u9wtXG8lIQ1ZrTfyw/HuORNAtdzaJwhfXi2kHExUk=;
 b=YovdFdMHI3Ff6i/fRu4QAwKGiHOkS8ZdrU4IeMNtrlY3/H53jfDqOTYc2B0xCPs3i7UnKUS0jSbYA7dy7DbGSiEJCUTpU25cqeIH/90rR4CpkWFLrfBq8KFl6kWpgTLixI2LcmcnFt5x8BLkCu8YgTvVe44qRoBDVBuuT6XxKZ4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3128.namprd15.prod.outlook.com (2603:10b6:a03:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Thu, 30 Jul
 2020 16:23:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 16:23:52 +0000
Date:   Thu, 30 Jul 2020 09:23:48 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <20200730162348.GA679955@carbon.dhcp.thefacebook.com>
References: <20200714173920.3319063-1-guro@fb.com>
 <alpine.LSU.2.11.2007291902340.6363@eggly.anvils>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007291902340.6363@eggly.anvils>
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:931) by BYAPR08CA0024.namprd08.prod.outlook.com (2603:10b6:a03:100::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 16:23:51 +0000
X-Originating-IP: [2620:10d:c090:400::5:931]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9a57c14-e7c4-4a99-43a4-08d834a4f269
X-MS-TrafficTypeDiagnostic: BYAPR15MB3128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB31289D621A8BE5DA4ADFF25FBE710@BYAPR15MB3128.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hET7ViKh/F4NZkDIgey3eqgXAzGemeXQWnbmMQC0vSoDTG3GTqWWB8LE3b9dFVb6pDKvXmweT2ubkLebfGRUuQtbtCO0T5u0Xo8xZ/RfX80vt4XToBiCJ2EPKytPw22Mo5+kdbYDiIc8Tt5oX8U6qIlR013EiZTIE2YAtKQi4Tkwmyc/Kp2wM0M4t0xhH1FXXFG28eEj9v+AKTwPqsEe+rAfdzg15gSIZ2YiTzUyEuSi9C7yyX4Zd+kJ+3iC5SHNEtsANBrxW4MgQKCYoqVDPM8f06GGPEBwhe2rX6FYxb7ETO3OTtaPbSFLZVrlGSyg/kbjHtIBMOOhG74BLid1ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(396003)(376002)(346002)(9686003)(6916009)(6666004)(66946007)(1076003)(86362001)(55016002)(66476007)(66556008)(8936002)(8676002)(186003)(6506007)(16526019)(316002)(4326008)(478600001)(5660300002)(7696005)(2906002)(83380400001)(52116002)(33656002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jzavAX/KHgMG7mrzz19sjy+XTbiicfQT65W0rZhw99Fk0U2IbiX5V++OwnYr3KqT0WUgJRHGco49rp5cxmaNWLWQ07u4IYaRqb/bLI/jIG9tYAzOeqp38seT9bz2P6gdG7I6DZ16vIOYGYJD08nS5Yz3LcNVXljG9n6shIe5Dr8W85YrGGk9XeRUt5rY2WVeXLqWIglT0wO7TeDr/yo/fUwXnBimqmqBPkw7JhLrLyO2aLhRlsOue3vhEiM/qlVBZFkTyVsTMIw8asWeQvrH6OPfWI/h3KJXGaQliDKeDCw72ZMrXBbv/po4e+HVKgog1PM8XpbcY+7kaoev5usn5Xc0+xVp+BJwK4pquRzMXmkx8c0f58+JVmOSal3w9dSsn92EYRkgEPc1WBKoUi3L9JrOfGCyR5PD6oe6WeDE8DoC60YM9ft+odVpob4iUayuLknyagbi8gTDbndgefVlohQ0/GIuXM8FQ0WcTNNqmCsZb9Xz9q2mTq998Pc8IWEnJVQXhA/mvfD550FGaFUJjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a57c14-e7c4-4a99-43a4-08d834a4f269
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 16:23:52.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZ8pFNCne4ahW05G/Cw30b8wnZXO7UTBb0rvaDCHeFk3ot3XIp/qxZa0sLsdHFnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3128
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_12:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 suspectscore=5 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300116
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:45:47PM -0700, Hugh Dickins wrote:
> On Tue, 14 Jul 2020, Roman Gushchin wrote:
> 
> > I've noticed a number of warnings like "vmstat_refresh: nr_free_cma
> > -5" or "vmstat_refresh: nr_zone_write_pending -11" on our production
> > hosts. The numbers of these warnings were relatively low and stable,
> > so it didn't look like we are systematically leaking the counters.
> > The corresponding vmstat counters also looked sane.
> 
> nr_zone_write_pending: yes, I've looked at our machines, and see that
> showing up for us too (-49 was the worst I saw).  Not at all common,
> but seen.  And not followed by increasingly worse numbers, so a state
> that corrects itself.  nr_dirty too (fewer instances, bigger numbers);
> but never nr_writeback, which you'd expect to go along with those.

NR_DIRTY and NR_WRITEBACK are node counters, so we don't check them?

> 
> I wish I could explain that (I've wondered if somewhere delays
> incrementing the stat, and can be interrupted by the decrementer of
> the stat before it has reached incrementing), but have not succeeded.
> Perhaps it is all down to the vmstat_refresh() skid that you hide in
> this patch; but I'm not convinced.
> 
> > 
> > These warnings are generated by the vmstat_refresh() function, which
> > assumes that atomic zone and numa counters can't go below zero.
> > However, on a SMP machine it's not quite right: due to per-cpu
> > caching it can in theory be as low as -(zone threshold) * NR_CPUs.
> > 
> > For instance, let's say all cma pages are in use and NR_FREE_CMA_PAGES
> > reached 0. Then we've reclaimed a small number of cma pages on each
> > CPU except CPU0, so that most percpu NR_FREE_CMA_PAGES counters are
> > slightly positive (the atomic counter is still 0). Then somebody on
> > CPU0 consumes all these pages. The number of pages can easily exceed
> > the threshold and a negative value will be committed to the atomic
> > counter.
> > 
> > To fix the problem and avoid generating false warnings, let's just
> > relax the condition and warn only if the value is less than minus
> > the maximum theoretically possible drift value, which is 125 *
> > number of online CPUs. It will still allow to catch systematic leaks,
> > but will not generate bogus warnings.
> 
> Sorry, but despite the acks of others, I want to NAK this in its
> present form.

Sorry to hear this.
> 
> You're right that there's a possibility of a spurious warning,
> but is that so terrible?

We do collect all warnings fleet-wide and false warnings are
creating a noise, which makes it easier to miss real problems.
Of course, we can filter out these particular warnings, but then
what's the point of generating them?

In my opinion such warnings with a bad signal/ratio aren't good because
initially they cause somebody to look into the "problem" and waste
their time, and later they are usually just ignored, even when the real
problem appears.

In this particular case I was testing some cma-related changes,
and when I saw a bunch a new warnings (cma was not used on these hosts
before), I was concerned that something's wrong with my changes.

> 
> I'm imagining a threshold of 125, and 128 cpus, and the following
> worst case.  Yes, it is possible that when vmstat_refresh() schedules
> its refresh on all the cpus, that the first 127 cpus to complete all
> sync a count of 0, but immediately after each allocates 125 of whatever
> (raising their per-cpu counters without touching the global counter);
> and then, before the 128th cpu starts its sync, somehow that 128th
> gets to be the lucky cpu to free all of those 127*125 items,
> so arriving at a mistaken count of -15875 for that stat.

First, I have to agree, 125 * number of cpus is definitely a very high
number, so it's extremely unlikely that any vmstat value will reach it
in the real life. I'm totally happy to go with a (much) lower limit,
I just have no good idea how to justify any particular number below.
I you can suggest something, I'd appreciate it a lot.
I like the number 400 :)

> 
> And I guess you could even devise a test which conspires to do that.
> But is it so likely, that it's worth throwing away the warning when
> we leak (or perhaps it's unleak) 16000 huge pages?  I don't think so:
> I think it makes those warnings pretty much useless, and it would be
> better just to delete the code that issues them.

Of course, it's an option too (delete the warnings at all).

> 
> But there's other things you could do, that we can probably agree on.
> 
> When stat_refresh first went in, there were two stats (NR_ALLOC_BATCH
> and NR_PAGES_SCANNED) which were peculiarly accounted, and gave rise
> to negative reports: the original commit just filtered those cases out
> in a switch.  Maybe you should filter out NR_ZONE_WRITE_PENDING and
> NR_FREE_CMA_PAGES, if there's nothing to fix in their accounting.

In fact, there is nothing specific to NR_ZONE_WRITE_PENDING and
NR_FREE_CMA_PAGES, any value which is often bouncing around 0 can go
negative, and it's not an indication of any issues.

> 
> I'm not sure exactly what your objection is to the warning: would
> you prefer pr_info or pr_debug to pr_warn?  I'd prefer to leave it
> as pr_warn, but can compromise.

Yeah, we can go with pr_debug as well.

> 
> (IIRC xfstests can fail a test if an unexpected message appears
> in the log; but xfstests does not use /proc/sys/vm/stat_refresh.)
> 
> But a better idea is perhaps to redefine the behavior of
> "echo >/proc/sys/vm/stat_refresh".  What if
> "echo someparticularstring >/proc/sys/vm/stat_refresh" were to
> disable or enable the warning (permanently? or just that time?):
> disable would be more "back-compatible", but I think it's okay
> if you prefer enable.  Or "someparticularstring" could actually
> specify the warning threshold you want to use - you might echo
> 125 or 16000, I might echo 0.  We can haggle over the default.

May I ask you, what kind of problems you have in your in mind,
which can be revealed by these warnings? Or maybe there is some
history attached?

If it's all about some particular counters, which are known to be
strictly positive, maybe we should do the opposite, and check only
those counters? Because in general it's not an indication of a problem.

> 
> And there's a simpler change we already made internally: we didn't
> mind the warning at all, but the accompanying -EINVALs became very
> annoying.  A lot of testing scripts have "set -e" in them, and for
> test B of feature B to fail because earlier test A of feature A
> had tickled a bug in A that wrapped some stat negative, that
> was very irritating.  We deleted those "err = -EINVAL;"s -
> which might be what's actually most annoying you too?

> 
> Nit in this patch called out below.
> 
> Hugh
> 
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst |  4 ++--
> >  mm/vmstat.c                             | 30 ++++++++++++++++---------
> >  2 files changed, 21 insertions(+), 13 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index 4b9d2e8e9142..95fb80d0c606 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -822,8 +822,8 @@ e.g. cat /proc/sys/vm/stat_refresh /proc/meminfo
> >  
> >  As a side-effect, it also checks for negative totals (elsewhere reported
> >  as 0) and "fails" with EINVAL if any are found, with a warning in dmesg.
> > -(At time of writing, a few stats are known sometimes to be found negative,
> > -with no ill effects: errors and warnings on these stats are suppressed.)
> > +(On a SMP machine some stats can temporarily become negative, with no ill
> > +effects: errors and warnings on these stats are suppressed.)
> >  
> >  
> >  numa_stat
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index a21140373edb..8f0ef8aaf8ee 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -169,6 +169,8 @@ EXPORT_SYMBOL(vm_node_stat);
> >  
> >  #ifdef CONFIG_SMP
> >  
> > +#define MAX_THRESHOLD 125
> > +
> >  int calculate_pressure_threshold(struct zone *zone)
> >  {
> >  	int threshold;
> > @@ -186,11 +188,9 @@ int calculate_pressure_threshold(struct zone *zone)
> >  	threshold = max(1, (int)(watermark_distance / num_online_cpus()));
> >  
> >  	/*
> > -	 * Maximum threshold is 125
> > +	 * Threshold is capped by MAX_THRESHOLD
> >  	 */
> > -	threshold = min(125, threshold);
> > -
> > -	return threshold;
> > +	return min(MAX_THRESHOLD, threshold);
> >  }
> >  
> >  int calculate_normal_threshold(struct zone *zone)
> 
> calculate_normal_threshold() also contains a 125:
> better change that to MAX_THRESHOLD too, if you do pursue this.

Totally agree, good catch.

Thanks!

Roman
