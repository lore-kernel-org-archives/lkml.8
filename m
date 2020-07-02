Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A72C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B4520760
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AtbcP8kb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FpbwoDE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGBRU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:20:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25672 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbgGBRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:20:26 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 062HAjsV030632;
        Thu, 2 Jul 2020 10:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=h7+unMwb1awoG/YD+nPVHcYE+/7KXr2lgIeblW12xxU=;
 b=AtbcP8kbhkUYNs2ILmKQaAtOhAVL3LmGGVRQar/rgKIAqinQpxeoPTU4u5CJ745CYhR8
 sEbN1nmc+4zci+nZ+8NY+AM/Zoet62342XcWWp3Hyebtxb7b9qiPAXlwQAh1d40Fx/0X
 4A/Xi9SsM1DCN5aaMZBoyxH3n9Z0rexhVYE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3216k83eqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Jul 2020 10:19:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 10:19:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGQguW6qDeReqVcswERP/8iaaym9aBOBV8UKU6FMA42ci1+JaQWDL0kAgpbbX63vRsIwU7l+26Wai6mturJLvO5iSZzubKTxGv5180+5TUUFuHlC8ufntPMo7/U2CqAvFtTX+BlOJgremOxfS/WSlymHtmky+gpYXwpw2JCNdFNapGD9IsD4zoU4UkeucMbOQKi7MNKkOBxdzyzz2aCQaULNTE9uUMJbpOS2txKlLYs0ip75VRNtWxsLno6CG71dcr9dXhjeIExj//8JrJqon7qVb0WKq4KTlSnuNArCmvgf2i9DY/0Jel2NgurL6tJ2u6lBV4NOZOGhU/nmR3U5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7+unMwb1awoG/YD+nPVHcYE+/7KXr2lgIeblW12xxU=;
 b=YSkBmRCr+nlO7rI5Nk4Mf0Uqgk5HowRlqqk1xOZiU9hGcK/l/VtlOIZC/otuRfgDxxIH2dd2hnPxKhSol77c2jmp8l6uZAX2frn0V4ASZZ5gzcrN6fRV9R1D+9oKBv3tG1fKfKfzSSHDP0zE9UQEG8ESlhN5FL0P+p2qpEMEQbuxoEd1c3E4dyYmYU9wRaCb7BfpKFsh0TiE7BYhZiyLTnuRfHGhf+t4XREtRBYbZoW/EKqPnMSTecX6o3LBSK7hcTPrVrNEvf+Rd4oKRs6Dmp/AN9kbHBywJtLSpgn9PHSdqlPzg5xp948wVwIrssH9FyEMiLHQMXPs+mmH3u0pxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7+unMwb1awoG/YD+nPVHcYE+/7KXr2lgIeblW12xxU=;
 b=FpbwoDE7eXV+jIZJck07vqcLwCMzIplQHlCO0YEQ/cRk8ww8kMdnG+Ymtn274iRVqdNREnNwz0UKrANUnqktpIwvPatPc18pVQx77g8lB3NLrHb1aJujLHY9B7boJbBVj/fpVGKMgFy+2zyb0E3wW3c91aqw1pkdKb24EV/N/LA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 17:19:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.034; Thu, 2 Jul 2020
 17:19:45 +0000
Date:   Thu, 2 Jul 2020 10:19:42 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>, Chris Down <chris@chrisdown.name>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200702171942.GC106423@carbon.dhcp.thefacebook.com>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
 <20200702162202.GI18446@dhcp22.suse.cz>
 <20200702163738.GA106423@carbon.dhcp.thefacebook.com>
 <20200702171302.GK18446@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702171302.GK18446@dhcp22.suse.cz>
X-ClientProxiedBy: BYAPR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::47) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6671) by BYAPR07CA0106.namprd07.prod.outlook.com (2603:10b6:a03:12b::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 17:19:45 +0000
X-Originating-IP: [2620:10d:c090:400::5:6671]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfec7526-c385-463d-3724-08d81eac1dc4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2631:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2631627429842010AE399E72BE6D0@BYAPR15MB2631.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEQ00Nsi6nfJ6yA7U12TVq2wcLRKKyWyfw/+R3+FpYxinZY+Y+rk/Balw3Gl2pgvn5gdh6kuvhxWLXwhrtgbP20lmmS4S66gxSoDb8gVbpqxq+fnptQxRxCAYaMU6Vlr5cl3GISp2ShpDnrWzs81R6brpXJiYjwT7i2lFAAAYqMVKPLOrpJM8gueBivshlWeifgFUxsiRp3/SP4qf83w2UUQdUx5u9LiyFfMUKycCnZAy45N9dTu3PVKF67Q6ST86QhZGcGnqo7mOYTr6Bm9H3MdAf2Zzyf0H0YoGpmZOFu600elQ7B4hC5ulaWmLU+R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(39860400002)(366004)(396003)(55016002)(2906002)(86362001)(9686003)(478600001)(8676002)(33656002)(6666004)(6916009)(5660300002)(186003)(16526019)(54906003)(8936002)(6506007)(316002)(1076003)(4326008)(66476007)(52116002)(66946007)(83380400001)(66556008)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YXtKvk4b1BcNPd/5MwkJPUoBe0W2CjgzdHt/a4YIGgXyQxvJ8+OlHOL8RYOW/jyTVHwYGZQGEFXitEKhg7ZKmMJ0GDLRHzMaKdfc97eLyr9YnTZooupYwQe36Gdwt4mlue8iExJZBCPsoy27RviNGakzXnPR7KvWQKwXsIh7QxqVAcqOJBs6l7OEf+jShHe4I9o/NayujZsziKyY2rN0whzQY5gFmUezRQtd0YYB8zF5wTCE6Iutq9o6wCdWThogrkdiM4YlaEc8HJj72CxqloHvOabl/ipEhz1RatnW/fuxtClIjhFe102JraxQyz6viA46K+Qo2JeT5e1EXBMgH7ZQKJLx/GeXJ46VX9gJnsv0T2u5jde/7CuJ0XXzJFDTKNY6fdBIzBvTzX2l6iBCYYt345PgQey+aoxHxHal/hzE40/se84c9Olxm2JILn+QwvKl5wtyMamJka1FZhUd47WM+glD9nBiGPh0FRo4DbqTLzIjb+c+cRPe3IdQC7J+hiof7PGLeIR3wW7ik+GKvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfec7526-c385-463d-3724-08d81eac1dc4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 17:19:45.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vvh/d1Xe/TDRCCQdoq7pCj1gUslnBjoHZfNkn32dMhrrR255XlhloLR09ogzv6fB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2631
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_09:2020-07-02,2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=1 spamscore=0 mlxlogscore=999 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020118
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 07:13:02PM +0200, Michal Hocko wrote:
> On Thu 02-07-20 09:37:38, Roman Gushchin wrote:
> > On Thu, Jul 02, 2020 at 06:22:02PM +0200, Michal Hocko wrote:
> > > On Wed 01-07-20 11:45:52, Roman Gushchin wrote:
> > > [...]
> > > > >From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
> > > > From: Roman Gushchin <guro@fb.com>
> > > > Date: Wed, 1 Jul 2020 11:05:32 -0700
> > > > Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
> > > > 
> > > > Historically the kernel memory accounting was an opt-in feature, which
> > > > could be enabled for individual cgroups. But now it's not true, and
> > > > it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> > > > user has at least one non-root memory cgroup, the kernel memory
> > > > accounting is on. So in most setups it's either always on (if memory
> > > > cgroups are in use and kmem accounting is not disabled), either always
> > > > off (otherwise).
> > > > 
> > > > memcg_kmem_enabled() is used in many places to guard the kernel memory
> > > > accounting code. If memcg_kmem_enabled() can reverse from returning
> > > > true to returning false (as now), we can't rely on it on release paths
> > > > and have to check if it was on before.
> > > > 
> > > > If we'll make memcg_kmem_enabled() irreversible (always returning true
> > > > after returning it for the first time), it'll make the general logic
> > > > more simple and robust. It also will allow to guard some checks which
> > > > otherwise would stay unguarded.
> > > > 
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > ---
> > > >  mm/memcontrol.c | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 50ae77f3985e..2d018a51c941 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -3582,7 +3582,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
> > > >  	objcg->memcg = memcg;
> > > >  	rcu_assign_pointer(memcg->objcg, objcg);
> > > >  
> > > > -	static_branch_inc(&memcg_kmem_enabled_key);
> > > > +	if (!memcg_kmem_enabled())
> > > > +		static_branch_inc(&memcg_kmem_enabled_key);
> > > 
> > > Wouldn't be static_branch_enable() more readable?
> > 
> > Agree, will change, add reported-by and tested-by tags and resend.
> > Thanks!
> 
> Feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you!

> 
> > Btw, don't we wanna to change memcg_kmem_enabled() definition
> > from static_branch_unlikely() to static_branch_likely()?
> 
> Honestly, I do not know what would be the impact but considering kmem
> is enabled unless explicitly disabled these days then likely sounds more
> logical from reading POV. I do not think that early allocations until
> the first memcg is created is the case to optimize for.
> Worth a separate patch I guess.

Yeah, I doubt there will be any measurable difference, it just strained my eyes.
I prepare a small set of cleanups/cosmetic fixes, will add it to them.

Thanks!
