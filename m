Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F172C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7172076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N8jjGJR3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iealIl3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGJSmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:42:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2454 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727082AbgGJSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:42:20 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06AIU6b9025607;
        Fri, 10 Jul 2020 11:42:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QtXSzGKuR2rea3jMjJ8UPKiTFTYPDePJ8cxKdgSQIfE=;
 b=N8jjGJR34M6r0/viM0ewB03QWI0CtmgcNSbpSn4ck8PqwZNnGJFia8qm1SRF7AB5TR5z
 KVEEl/sLjXB8XtFRIcaWo7PhISlmJYXbkXkAdCeBcYgTfSejql7EfkmThqRDUjNbFm8x
 R7jF02akvwC64ldhRtsveWb1gd1N8Akqz9M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 325k2ukr1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 11:42:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 11:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEnPf3bl/ahAFziXJbHn9kzjSFbcDiYf4Fi6tecgvkOgcqVEKudALcrT+Fl0Gloz7lt7G92BiiuiHUkylDACzwGNtfZ9bgEhP6nWIV4qF9dnXzO52z961KaX44Z9ISrH1AtfJ5nPED4CsYzlVoSWSsojHAxIJfR8hNNWtnJDFaNz74O+vESxpMt+cRrhJExbsXfoJVD9A4YK4PMLZLPpCas6PQr+CdyCUKngJx0Zzx42Oac8e3ofpFLrNR7hwfQlXeIUHrRweqHVJcnBt/LcqBbDYstFo88RoIGVePMNoIoDROLqOw5rN2UABtJXicG6Y8yzE+Iu4VrdsKPs2Fh/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtXSzGKuR2rea3jMjJ8UPKiTFTYPDePJ8cxKdgSQIfE=;
 b=MCOpGVdh8gDC9Us1GH2lAB5Mn/tteRkkMxrTmuVcbtDcZbwcwZUO6vzEFCLbx1XIQyoXh4tU9IuP+nmSTwqbJdpyN8ES7V9e1VPzMZ2RvI7ThkOPnY1la/CzhhRX5yKfheV2tmHjI61+7x8G/jrpVzazCE/+D1asRssVMDDaexcpOxk6j9eDH08cuD2iPBO6Bwvgr9X70iCXAJLrxXebfFoD5cF7Klt9QRtIfKJZE1LM+H4d8/PfQXhqYXEHiEY/bKrWBvw3albkr6kP0bwfXtcQEQlNbjH7Yie9xZGZWpVY6GhkBdnmJ+vfd2ZdQFKyXJMgZvdyHs/WsUpgsgWFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtXSzGKuR2rea3jMjJ8UPKiTFTYPDePJ8cxKdgSQIfE=;
 b=iealIl3yI3fa9+YPJusDmH5HWZB1ibmtWW4HBFlJrek+co26LvpkFE1LWxxv/fL0OSXxB4FKOcIy1JQR4Ia2RwI8gQrHINfSs1BkNwEmy3UT0aeEXll+w8O2axtysCoZbn2/et1TEz4RoDbaUWptZdkOmNi8YHynC/dR//wq7G4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2630.namprd15.prod.outlook.com (2603:10b6:a03:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 18:42:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 18:42:09 +0000
Date:   Fri, 10 Jul 2020 11:42:05 -0700
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
Message-ID: <20200710184205.GB350256@carbon.dhcp.thefacebook.com>
References: <20200709194718.189231-1-guro@fb.com>
 <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:40f0) by BY5PR16CA0017.namprd16.prod.outlook.com (2603:10b6:a03:1a0::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Fri, 10 Jul 2020 18:42:08 +0000
X-Originating-IP: [2620:10d:c090:400::5:40f0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d28e454-933c-4ee5-b7a2-08d82500f369
X-MS-TrafficTypeDiagnostic: BYAPR15MB2630:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB263011028E3F50B88B1A834DBE650@BYAPR15MB2630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0SdQZotVhwmrei4O63smVAgEmrsBF5jUq2xvhtFwNZfpYdwGcQ9ekSJ3+tdvfx54Rt6ex1Xxf+qo+hyr6eM7/cSD0sqhESKOmYUw16F34YaGoUASRWcZAkIfQ/5OWnIarKeHvSMxaTKwdVyfOegEfEXkJpRI4OuD5wpeY5sjlWWJ2xXaEEnDnANzUc2i4lKiAdDHxIj6HcdG+EMznskBzfYJYU/NAJXT7k18mQF0e+m6Qqxisvvr6d67SY15ZomqmKpFIEFdpSLqG4Osy3UyRub9/0coFLddNU5EMhm20SvQbRwIvLKZuBqtfj5aqYsJhpkOJMunGYTvtY12SedxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(396003)(346002)(136003)(376002)(186003)(478600001)(8676002)(8936002)(2906002)(33656002)(66556008)(316002)(66476007)(66946007)(86362001)(6666004)(7696005)(6506007)(54906003)(16526019)(6916009)(5660300002)(9686003)(55016002)(53546011)(1076003)(4326008)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lXCWI6pU22wt6xrI+V+zXfuid0BZ0hwRyqD+Jf5yojSrMFvDfqksspcbXwyrTcZaqMHiCr7E8JKt3Kmg0rRQjhgVMkFF34fYMVtWKhRuQNwrJ94WAYm+vrxJkHbD14QJJAlTnNjlw8QZ39JxToUwDBKYazoxHsY3NIunRnU/pWyHimCA+BTG3hbBwob5I0o+6g/FlCMml+Fq4aASAuVHSW0fLseC1lX7Epq+qApNPxxAnk9i8vNNJF6TGLL3SYw4NhkbrM/OEwNplSyQ+JkNwJhSBbwdnr2yjbWYy6eELhyK/w6GSYjnb/pCL2X6jQ3vb7WDCPbqaaswCqEa/x8ayJWSdt6akzS8aAp196PN8uel5NvpCgQf9za2T9wEpj/xdmy5FHYLn62Z9vywgcJDhk06zMXvYLY96s83fGybEfIxvvR1uTIFKFXzACyEbnmnbYilKMHoxZnLR//H8Hqqp7akajcwm9EXJPfZ+LlHdgusF6XxrMiFoLfXFkRE3SQhS6kSVwFN93SMYASRdmXgBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d28e454-933c-4ee5-b7a2-08d82500f369
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 18:42:08.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K123M33Pkbz7uIj7+oERub//32/2pX8IAgVLLd6nfNBD2N0Ddg81uBnitk4jd6ep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=1 priorityscore=1501 clxscore=1015
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100123
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:12:22AM -0700, Shakeel Butt wrote:
> On Fri, Jul 10, 2020 at 5:29 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> > > Memory.high limit is implemented in a way such that the kernel
> > > penalizes all threads which are allocating a memory over the limit.
> > > Forcing all threads into the synchronous reclaim and adding some
> > > artificial delays allows to slow down the memory consumption and
> > > potentially give some time for userspace oom handlers/resource control
> > > agents to react.
> > >
> > > It works nicely if the memory usage is hitting the limit from below,
> > > however it works sub-optimal if a user adjusts memory.high to a value
> > > way below the current memory usage. It basically forces all workload
> > > threads (doing any memory allocations) into the synchronous reclaim
> > > and sleep. This makes the workload completely unresponsive for
> > > a long period of time and can also lead to a system-wide contention on
> > > lru locks. It can happen even if the workload is not actually tight on
> > > memory and has, for example, a ton of cold pagecache.
> > >
> > > In the current implementation writing to memory.high causes an atomic
> > > update of page counter's high value followed by an attempt to reclaim
> > > enough memory to fit into the new limit. To fix the problem described
> > > above, all we need is to change the order of execution: try to push
> > > the memory usage under the limit first, and only then set the new
> > > high limit.
> >
> > Shakeel would this help with your pro-active reclaim usecase? It would
> > require to reset the high limit right after the reclaim returns which is
> > quite ugly but it would at least not require a completely new interface.
> > You would simply do
> >         high = current - to_reclaim
> >         echo $high > memory.high
> >         echo infinity > memory.high # To prevent direct reclaim
> >                                     # allocation stalls
> >
> 
> This will reduce the chance of stalls but the interface is still
> non-delegatable i.e. applications can not change their own memory.high
> for the use-cases like application controlled proactive reclaim and
> uswapd.

Can you, please, elaborate a bit more on this? I didn't understand
why.

> 
> One more ugly fix would be to add one more layer of cgroup and the
> application use memory.high of that layer to fulfill such use-cases.
> 
> I think providing a new interface would allow us to have a much
> cleaner solution than to settle on a bunch of ugly hacks.
> 
> > The primary reason to set the high limit in advance was to catch
> > potential runaways more effectively because they would just get
> > throttled while memory_high_write is reclaiming. With this change
> > the reclaim here might be just playing never ending catch up. On the
> > plus side a break out from the reclaim loop would just enforce the limit
> > so if the operation takes too long then the reclaim burden will move
> > over to consumers eventually. So I do not see any real danger.
> >
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reported-by: Domas Mituzas <domas@fb.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Shakeel Butt <shakeelb@google.com>
> > > Cc: Chris Down <chris@chrisdown.name>
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> 
> This patch seems reasonable on its own.
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you!
