Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7D9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ED720714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bwGtZqu4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="lNfSUtN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCQUhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:37:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36186 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbgCQUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:37:00 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HKaGjU030657;
        Tue, 17 Mar 2020 13:36:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LqE6Nlcm++u/r6jtITO3vr20fSbJXiIQaJ6SVe+cjQc=;
 b=bwGtZqu4StTAJjq9y2rdipBFux8GADsjjbf7iKHpIXNeJT8W5wVKnccO8CC6/JnJusiz
 E8hwkOq5gua+Xwgd3C/grkizKht/M5yYXhC6qn0WzhZA4broIEced/f+o2+WKb5if5fx
 LBKyHhAjzvfrjAVESf/WpPFl0Qmc6B1CTq4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yrw0pxvhe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Mar 2020 13:36:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 17 Mar 2020 13:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOBIRt7SB2gdjb+9XvB3i9NJ7SjOWxow5mXnwR6+VP9ey49J5tSdn0Xggt2nWO9dssYLLSoZqgL3jJHc++XND3PxpiEgsniihUjbhA0iwTnyXA0WbfMT82RkYBehGlzsUknZ/tNBcYODTsDRlJnwDQfxKkyQEE6lnp16uPkuBqXPV/BF20pn4u6XvvKAzgOVj4WAjaY5WU4BuEcuRSH93s8qYIO1vO1brA5WG4zk1QJa4d4r8vSfIf6CYRKTdp/s4KQnWqhsH6gs9eu3Nznpy82zWw9Gb9ok+aewyY4M2y/UJWxtouYCLoJxtBosusWMSXc/Qwuod7F4cJoakut+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqE6Nlcm++u/r6jtITO3vr20fSbJXiIQaJ6SVe+cjQc=;
 b=JdFIb/IpT3Kwknd/qlR2UqRGNMKW/Xe0uRuxLUoywOWD2OOCnb01I8lpvpuOZFfmGc1uuUwc6cprKiaaW3wPDJnlpg5T6XqW7fGgkuBIk9ZXCxkz+/XJDvyOG/L2Mja177Yi3jaZU+d4ktrmQ9oxnKGxXnroDN7fqGVIgEyzQooQqHFslsfhk027kRNKEZ+5cp7xC+82q4176+EoJdvr5jKrXv8yFhpOwYAmHNvPEf+XY/5fR+qfLzituDnd5+ZS+Wow+bBNrpsQGga6h0CfNk0Vvc3+NJ2B4JCsJ9795tKCDvOvN0mHl0XSPYiQUEOVC3aBk9Nuwg82RIwodl470Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqE6Nlcm++u/r6jtITO3vr20fSbJXiIQaJ6SVe+cjQc=;
 b=lNfSUtN2GButSasU0jIVIpYHGpy7uueBHKAiQCJIp2OAxE7tJMpcEXoxFPy5naOIPSEk5JkrQKzY6Kol4O4JO4w7KCmo2Dcbt+NOp8xAuZR5AgJwlYY2gXM3Q5Dl5P/GSaq1e1YReOjNAr2mOFSDla/L1vm69RllLdBkgSWRr9Q=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2517.namprd15.prod.outlook.com (2603:10b6:a03:151::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Tue, 17 Mar
 2020 20:36:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::a0af:3ebe:a804:f648]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::a0af:3ebe:a804:f648%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 20:36:49 +0000
Date:   Tue, 17 Mar 2020 13:36:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcg: make memory.oom.group tolerable to task
 migration
Message-ID: <20200317203645.GC276471@carbon.DHCP.thefacebook.com>
References: <20200316223510.3176148-1-guro@fb.com>
 <20200317075212.GC26018@dhcp22.suse.cz>
 <20200317183836.GA276471@carbon.DHCP.thefacebook.com>
 <20200317185529.GV26018@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317185529.GV26018@dhcp22.suse.cz>
X-ClientProxiedBy: CO1PR15CA0107.namprd15.prod.outlook.com
 (2603:10b6:101:21::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:96a1) by CO1PR15CA0107.namprd15.prod.outlook.com (2603:10b6:101:21::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend Transport; Tue, 17 Mar 2020 20:36:48 +0000
X-Originating-IP: [2620:10d:c090:400::5:96a1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 195e57d5-a7f3-4fba-813b-08d7cab2ead8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2517:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2517B4557B4FDF280AFE5C9FBEF60@BYAPR15MB2517.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(199004)(81166006)(8676002)(16526019)(1076003)(6506007)(4326008)(33656002)(81156014)(6916009)(8936002)(55016002)(52116002)(9686003)(7696005)(66946007)(186003)(6666004)(5660300002)(86362001)(66556008)(498600001)(66476007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2517;H:BYAPR15MB4136.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +i7Jq3/2UNzIX8oPJfNK5zUtA+2pLA0culOQsHgUupycPs3ZbyUghlI96a6y5mBGbvbIpil8BIMDm38QLYSSpswgIcJ8uetX9Wx6WBPiuC0XX4qsE7aUzmh090FnqU3lEnoXdJaa+TAclM3u4RRq6G9dZfSkE2atfudCe7dzHWUDDp3YphxQBhn60c3L2mzsNgKoCzycf46FUfwhZNLx23ANpGod0Oso0OqmS2SpKSJ8Psh75vTmujb3twIgss6+FU3JS9bgBQ80iUd/c4qFwXqkl3Df/Tl5kVpoTZqtnzaPUaRujWglHnFIdWttRcpi0F28LoLIgF0uLlyrFzgI3i0DGVJDHewrIvSfOktRKuB27+xeOpJPE9qytu1FxukZXa5aerZb0ztulgvLwaf5IGYrZT91+iGb4N8vXuJTOMa3oVa2B2FRH8H+2ZnoNP/T
X-MS-Exchange-AntiSpam-MessageData: Ljtgufhx4HPjrxrojpJG4U74+zwAXkvC+d1S/V88qVFZ5HyRvX03mRsAJmqjj1YNIdZtwS168tpUTjxbp/vHiFMeuoJ+hudtgGMhaCrZhjuBbjYT8mNmfjfs+L7yAX9CJgGNJP2P65wdlPWRx5kV68RGpGLy1eJTNNY9A/nCKu8wE1kn1Ms/hFmRD/lMIHdP
X-MS-Exchange-CrossTenant-Network-Message-Id: 195e57d5-a7f3-4fba-813b-08d7cab2ead8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 20:36:49.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVyeoeP+7i0kRCKivTnJhrNAcDMwzsJVkqOvC0DjXw9zDMazpr0Io7/eeCZESvS0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2517
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_09:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=2 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170077
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 07:55:29PM +0100, Michal Hocko wrote:
> On Tue 17-03-20 11:38:36, Roman Gushchin wrote:
> > On Tue, Mar 17, 2020 at 08:52:12AM +0100, Michal Hocko wrote:
> > > On Mon 16-03-20 15:35:10, Roman Gushchin wrote:
> > > > If a task is getting moved out of the OOMing cgroup, it might
> > > > result in unexpected OOM killings if memory.oom.group is used
> > > > anywhere in the cgroup tree.
> > > > 
> > > > Imagine the following example:
> > > > 
> > > >           A (oom.group = 1)
> > > >          / \
> > > >   (OOM) B   C
> > > > 
> > > > Let's say B's memory.max is exceeded and it's OOMing. The OOM killer
> > > > selects a task in B as a victim, but someone asynchronously moves
> > > > the task into C.
> > > 
> > > I can see Reported-by here, does that mean that the race really happened
> > > in real workloads? If yes, I would be really curious. Mostly because
> > > moving tasks outside of the oom domain is quite questionable without
> > > charge migration.
> > 
> > Yes, I've got a number of OOM messages where oom_cgroup != task_cgroup.
> > The only reasonable explanation is that the task has been moved out after
> > being selected as a victim. In my case it resulted in killing all tasks
> > in A, and it what hurt the workload.
> 
> Is this an expected behavior of the workload or potentially a bug.
> Because really, migrating outside of the oom domain is problematic
> already. Essentially you are going to kill a wrong task if the largest
> memory consumer is migrating before the oom killer manages to find the
> task.

I don't think it's easy to a userspace program to predict OOMs and avoid migrations
in these circumstances. In my case one cgroup is some sort of execution
engine and the other is the workload which it starts. All inside the bigger
cgroup managed by systemd.

Generally speaking, charge migration was always very problematic, and it's
super easy to expose weird corner cases with migrating large tasks.
I hope that long-term we will switch to entering cgroups using clone3
or something similar.

> 
> > > > mem_cgroup_get_oom_group() will iterate over all
> > > > ancestors of C up to the root cgroup. In theory it had to stop
> > > > at the oom_domain level - the memory cgroup which is OOMing.
> > > > But because B is not an ancestor of C, it's not happening.
> > > > Instead it chooses A (because it's oom.group is set), and kills
> > > > all tasks in A. This behavior is wrong because the OOM happened in B,
> > > > so there is no reason to kill anything outside.
> > > > 
> > > > Fix this by checking it the memory cgroup to which the task belongs
> > > > is a descendant of the oom_domain. If not, memory.oom.group should
> > > > be ignored, and the OOM killer should kill only the victim task.
> > > 
> > > I was about to suggest storing the memcg in oom_evaluate_task but then I
> > > have realized that this would be both more complex and I am not yet
> > > sure it would be better so much better after all.
> > > 
> > > The thing is that killing the selected task makes a lot of sense
> > > because it was the largest consumer. No matter it has run away. On the
> > > other hand if your B was oom.group = 1 then one could expect that any
> > > OOM killer event in that group will result in the whole group tear
> > > down. This is however a gray zone because we do emit MEMCG_OOM event but
> > > MEMCG_OOM_KILL event will go to the victim's at-the-time memcg. So the
> > > observer B could think that the oom was resolved without killing while
> > > observer C would see a kill event without oom.
> > 
> > I agree. Killing the task outside of the OOMing cgroup is already strange.
> 
> Strange? Maybe but if you think about it, not that much in fact because
> you are still killing a task that was in the memcg at the time of the
> evaluation. Sure that largest task might not be the biggest contributor
> to the charged memory - as mentioned above - but well, this is what you
> ask for when migrating over oom domains.
> 
> > Should we somehow lock the OOMing cgroup? So that tasks can not escape
> > and enter it until the finish of the OOM killing?
> 
> I do not think this is going to help all that much. Sure we can note the
> memcg at the oom_evaluate_task and use it later for the group oom
> handling. But races will always be there. Having oom path to depend on
> locks used elsewhere is a can of worms. It would add a very hard to
> evaluate dependences.

Well, it can be just a single cgroup flag/bit. But I agree that it can
create more problems, so maybe it's better to avoid this path.

> 
> > It seems to be a better idea, because it will also make the oom.group
> > killing less racy: currently a forking app can potentially escape from it.
> > 
> > And the we can put something like
> > 	if (WARN_ON_ONCE(!mem_cgroup_is_descendant(memcg, oom_domain)))
> > 		goto out;
> > to mem_cgroup_get_oom_group?
> 
> This would be a user triggerable warning and that sounds like a bad idea
> to me. We should just live with races. The only question I still do not
> have a proper answer for is how much we do care. If we do not care all
> that much about the original memcg then go with your patch. But if we
> want to be slightly more careful then we should note the memcg in
> oom_evaluate_task and use it when killing.

But it won't close the race, right?

oom_evaluate_task() can race with a task migration too, so we can record
the old or the new cgroup.

Then I'd stick with my original patch which solves the main problem here:
unnecessary killing of too many tasks.

Thanks!
