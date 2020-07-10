Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC33CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD92E2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OG0eqMHX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eNndz+s2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGJTmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:42:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18212 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgGJTmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:42:04 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06AJdQLm024957;
        Fri, 10 Jul 2020 12:41:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8CGWzK0PHZ9+96l8iseDnSJ0gOsW4hYEbCPZpOcsY7M=;
 b=OG0eqMHX06TyPGSCkiLvVVGQS+LdV70/StD2MzTdUc3srLt+5zSkz/qFdcgxWTJTmG1C
 +7d3Ldj79IiYVoywqBe5KfmAc558J4J5DsTTtDqpAugCOeOGJ9pzknfVyofqdlBMpRam
 QNFiig1DOpeTWdrhU33wX28zDkgsP4wR9V0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 325k2um09d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 12:41:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 12:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6GW2Vx12taPbF692QtAmfGReYL/fFYifgYpZx5kIXMwXkiyqGye3pPOEBR5PTxTIK9KXEOrhZ2fNSgJ+5X3oDgYnhJ7roTB4CJVe7btFhl5QUGLGskIoiYjPVH32yIO/oVYkfmvgemyJYAx5jUlSqQFQxxS2XMVxmMcYEFIgHoojoqS+auPyjXpvLrK8icVSgwlA/Q0y2grdWeAz9iXyNKxVqcYJ5Hgem1wY5IGaXBn0GAyL2Ml3mnQaDsiebvKy+2AjyXpd2b5z32hJQ1oWZkdTfLpGjQ+IO5iY5sJTzKUAx73tW//GAFMnuKOTSeL4+Ok2lm1G1NjPu/zp5ADJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CGWzK0PHZ9+96l8iseDnSJ0gOsW4hYEbCPZpOcsY7M=;
 b=RhPBtfoZvhwsFys4MaBPQ4XUizc31r5fYD5IxaVpIelPv1MXqgvN+gknOM5LwMWWziWgWGYuwhXzpvMPEXnAYr241OOM1pghuRJv63+rEn2xQRi34rqrX3bR+t2qlzm6hoQiRLGOdr/ZdZQcghBBQRljeIcv7/r/tEF88LVSDEVmi5AuM4BR3Q55CyMbIujMPVpDpqBFR1QKD3YFXWWRp2DkeUE3UfdKgiDnqbRG74yZ83CKvfGRYq6KkbjOB3yTAHu2Jk8lUCLFOJKYZNwabFHGV2MeYZnfdgr76ASqTvLpKWzWsJ7oro9QgF/gWXkMq2rjDjHXLDOJHgZCIHhBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CGWzK0PHZ9+96l8iseDnSJ0gOsW4hYEbCPZpOcsY7M=;
 b=eNndz+s2jy1/bneOGc6HMzscExvcs4BmNOw3aY/wDhmKZdhxl5X5CjYCMad+X6sMsRlIJt/xAMq4CmZOahrTrJwFr2iE7TBwOrTMPkG6aFsXew/7erVK6UDuiuuDGJnhJ9hUxtbI557HVYhZopoXBMHPKdbgy+v1X8fNcvY9JOA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3445.namprd15.prod.outlook.com (2603:10b6:a03:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 19:41:46 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 19:41:46 +0000
Date:   Fri, 10 Jul 2020 12:41:43 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering
 memory.high
Message-ID: <20200710194143.GC350256@carbon.dhcp.thefacebook.com>
References: <20200709194718.189231-1-guro@fb.com>
 <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
 <20200710184205.GB350256@carbon.dhcp.thefacebook.com>
 <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:bfc1) by BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 19:41:45 +0000
X-Originating-IP: [2620:10d:c090:400::5:bfc1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8efa0c51-32f6-435f-b93d-08d8250947d0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3445E8845F3846EC4DA13274BE650@BYAPR15MB3445.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MI06lfDmqI3xOGU0hhRDFtAVC/3RCkF5TSjss2JJweWqKj+FBQM0QKzlui4lZC8AJzX2c9Fz4DQXBcNGuEa7ypxm/czHsPGmjn4mAWwBhuYNFdm+HcYFDwr4c83GCVvCJQ8biQmBITZEoKJfJlk8DRQJm/+d0TiCnKoVzi4y98Gi/w+x5qxCI3OvTQN19QhLTp4hh/9IuQJdEbtckwBib+p+0YpkAlrreuS13E6BM4gMEw4PLhaO6MA/DsiTPZ3NYVGImPP7xJB/bIQRnT7dupZQhzGX6LwJv4ZE8nBKnV+qNxAVum3ySyPT16brYqo8NLuvK4WT651zd188gKnCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(39860400002)(366004)(376002)(4326008)(478600001)(55016002)(186003)(9686003)(5660300002)(8936002)(1076003)(8676002)(54906003)(52116002)(53546011)(7696005)(316002)(6506007)(2906002)(86362001)(83380400001)(6916009)(33656002)(66556008)(66946007)(66476007)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: GqfvVqP7dvHum4XVvL9XfYEtXjl45CEwODZ7qDJ9ZAk7p+E6Jl8e2Eh20ktg9MNVAcOjYePR39kASNIA4V3JMJMi50udRS971dt+nvvKdAgtbjiMcRm2MhO57xXiXtA+biwZgzMnC1BwRNo4jbfIKY190yMa2zTH2LOShuERqWdbLNilVU3LqEOrKWc5SmAwqFdWxKmtEZRhC5arGkDQrYZxF0RqUhZKZV6r4fmytjpHTX7KX89fRBgrID18VaFUwlphAOSVHtm56+iNie76s67jemqlNKqahy0pwn1A/WcWSsMoR7Kndi9opEP1aKo023Use9xSDXaQ1ZcdtRrexjSBxYh1vgfsdsER3wiYEjwd/dqcihdvaermeR6A3PSrQ1DDq3O8DYLgDGtpAuVWIbgMr3BVQeERLpa591/PBKIkxSvhxYkE2UQKBIIh7YuFHvOFs1vaQG8c15qMJyG/Jux3A6Uj0wC/wFOap4lxzDOBakM1Qbr9WgdhSBJ61/WPjlPBbtOl7RpFpygw0OVMwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efa0c51-32f6-435f-b93d-08d8250947d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 19:41:46.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CN/8vkRCg3POL/H27sNkcksPYoC9ViwWlHHS+3Ut3I8HfTGj/m38YtA5561tnWOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3445
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=1 priorityscore=1501 clxscore=1015
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100131
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:19:37PM -0700, Shakeel Butt wrote:
> On Fri, Jul 10, 2020 at 11:42 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Jul 10, 2020 at 07:12:22AM -0700, Shakeel Butt wrote:
> > > On Fri, Jul 10, 2020 at 5:29 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> > > > > Memory.high limit is implemented in a way such that the kernel
> > > > > penalizes all threads which are allocating a memory over the limit.
> > > > > Forcing all threads into the synchronous reclaim and adding some
> > > > > artificial delays allows to slow down the memory consumption and
> > > > > potentially give some time for userspace oom handlers/resource control
> > > > > agents to react.
> > > > >
> > > > > It works nicely if the memory usage is hitting the limit from below,
> > > > > however it works sub-optimal if a user adjusts memory.high to a value
> > > > > way below the current memory usage. It basically forces all workload
> > > > > threads (doing any memory allocations) into the synchronous reclaim
> > > > > and sleep. This makes the workload completely unresponsive for
> > > > > a long period of time and can also lead to a system-wide contention on
> > > > > lru locks. It can happen even if the workload is not actually tight on
> > > > > memory and has, for example, a ton of cold pagecache.
> > > > >
> > > > > In the current implementation writing to memory.high causes an atomic
> > > > > update of page counter's high value followed by an attempt to reclaim
> > > > > enough memory to fit into the new limit. To fix the problem described
> > > > > above, all we need is to change the order of execution: try to push
> > > > > the memory usage under the limit first, and only then set the new
> > > > > high limit.
> > > >
> > > > Shakeel would this help with your pro-active reclaim usecase? It would
> > > > require to reset the high limit right after the reclaim returns which is
> > > > quite ugly but it would at least not require a completely new interface.
> > > > You would simply do
> > > >         high = current - to_reclaim
> > > >         echo $high > memory.high
> > > >         echo infinity > memory.high # To prevent direct reclaim
> > > >                                     # allocation stalls
> > > >
> > >
> > > This will reduce the chance of stalls but the interface is still
> > > non-delegatable i.e. applications can not change their own memory.high
> > > for the use-cases like application controlled proactive reclaim and
> > > uswapd.
> >
> > Can you, please, elaborate a bit more on this? I didn't understand
> > why.
> >
> 
> Sure. Do we want memory.high a CFTYPE_NS_DELEGATABLE type file? I
> don't think so otherwise any job on a system can change their
> memory.high and can adversely impact the isolation and memory
> scheduling of the system.
> 
> Next we have to agree that there are valid use-cases to allow
> applications to reclaim from their cgroups and I think uswapd and
> proactive reclaim are valid use-cases. Let's suppose memory.high is
> the only way to trigger reclaim but the application can not write to
> their top level memory.high, so, it has to create a dummy cgroup of
> which it has write access to memory.high and has to move itself to
> that dummy cgroup to use memory.high to trigger reclaim for
> uswapd/proactive-reclaim.

Got it, good point. I tend to agree that memory.high is not enough.
I'll think a little bit more about how the new interface should look like.

Thank you!
