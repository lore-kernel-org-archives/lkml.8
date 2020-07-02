Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B721C20720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HZrKPWfS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BDzsrPNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgGBRH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:07:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19188 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbgGBRH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:07:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 062H5TXC018960;
        Thu, 2 Jul 2020 10:07:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aLL3heh/KToWDwFZAJTdruALZ+ESFZzpE7HR/Ki23wQ=;
 b=HZrKPWfSSZgRIXoa4RGqACTM+4n3hHmth70rhXzlDmh3S0Rv82aSIZzRIcOwrdXQwfSk
 2/pvAfeXTxJzApPCJNOK2CZzxbVtf9Zk9VQzP7lU6gx2aW833dk7JruQWW+dLWlXxtQD
 n3K6MbnqAEB9lFR4J9vJkf9mnFpR+pgUHtc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 320amq2kjc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Jul 2020 10:07:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 10:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2QRaeWjvP5LWT7wKEJW5Kmt2rn2rWDRtoX8AcT1Q3q17PF9jlY8sbqvCTlZLNYLSOrXmRIbGo8hfrTLxHIapk/leenFJNFl919BLGWcZUP9LFOAXshDd8JWVgaaFDdb51K4adj+i8wfl7tI/HtQqzgGGbOnHfgOL5F0xvP4Xm0aO7wfdRKWYvxnlJvLKYZSfHToMC1oRjYhdG0PCVmNfVTUrxKP/3F9Zd2iiTKmO5/LvnihNRMeHg5OqtAY+TMpePTPSba1sru/YA4pPMlnL0wGD6mYFB/LL2cwBeRMB4vIma0asWYP8M4t7o+Huutcdq7M61NuRG+dYMwYakncOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLL3heh/KToWDwFZAJTdruALZ+ESFZzpE7HR/Ki23wQ=;
 b=dH0bZlOA9RVW47IW3r/0msagcdOPI/NligcadpCbBjn0O6AQi6N4+FA0r6JSA0fqFCayuWjYGRivVLGOD1yzmHohESRBPGSILpCabKQDjacGhCGurTtWBBxAk38e+IVsdyuwcS7Fm3nuAplQ70NCJ/wJcR9FcyCawqxN1C1daJ+sNpaKJPtsVcfBNHDtFHxdqeJy3LBzpw70UaYQe5L2WWwOYKGjs4agp7kvSb5sIJUrNJY3LuPXEb5B21jDdp446jFihS5Fzqf+1VZng9EGzfumnocj4X0zsq91fp4CiCekYr+ig4b5mgzZunXJnWQheAzJYm5FixS2IQaXV/vN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLL3heh/KToWDwFZAJTdruALZ+ESFZzpE7HR/Ki23wQ=;
 b=BDzsrPNL81luoRATLUibtLqqflVrPqCjuj0y0XCZVYTMZh60g1H+3gkOU1qEEsWXJw1O2imIxyK6Pc7Eu6eXxl5NoHx039EycYdNz+PzKBr6ta9uF4UnsZnazf2oLG8BhEWv6kMV49HMYyrs0XGwYSbahFqXGXObut02xBXaSMA=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3480.namprd15.prod.outlook.com (2603:10b6:a03:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 2 Jul
 2020 17:07:15 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.034; Thu, 2 Jul 2020
 17:07:15 +0000
Date:   Thu, 2 Jul 2020 10:07:12 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Michal Hocko <mhocko@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>, Chris Down <chris@chrisdown.name>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200702170712.GB106423@carbon.dhcp.thefacebook.com>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
 <20200702162202.GI18446@dhcp22.suse.cz>
 <57270a15-a792-5175-757b-c4bde6da3694@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57270a15-a792-5175-757b-c4bde6da3694@suse.cz>
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b0bf) by BY3PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:217::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Thu, 2 Jul 2020 17:07:14 +0000
X-Originating-IP: [2620:10d:c090:400::5:b0bf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27cc454e-a51e-46ed-9901-08d81eaa5e81
X-MS-TrafficTypeDiagnostic: BYAPR15MB3480:
X-Microsoft-Antispam-PRVS: <BYAPR15MB348062DD1AA2711D6AA6FDBDBE6D0@BYAPR15MB3480.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhxqPoZUMjuLQuvC0MMxd6CfOBgiiBrFh9c7OZ2PWGeHrCS78daBnlgsSdxwZ959PoF3xxsMalTpD79Zg59wwGjgKEoxp2O3IR6cC9Zm1/SSzuVIypAjCpVFLUXPW1+WWX1ROrhmxgsNNEgiS2MsqaWRrQkqcffk7yK5YfSBHF5mMarTK5zLZrdGn2mKDDzvmSCI/HXb5IHsIM512Mle6XcmRo5XDn7BjwH0x4M++3VJ7b5pveHPiEqkElG60byzisF30uMcwenAcRM9k+WjL/ebqhIBHf1BCxgNYVnTZz8y25VNHOXK9Gb+Zb8vGPpth+ablwFATAU2mOe1dS0nSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(346002)(396003)(376002)(86362001)(8676002)(7416002)(33656002)(478600001)(66946007)(66476007)(66556008)(6506007)(53546011)(55016002)(5660300002)(9686003)(4326008)(186003)(16526019)(1076003)(83380400001)(316002)(54906003)(8936002)(6916009)(7696005)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: R5K4OhoLMAT+8qyUbsNfgG1r6tXtKpACpFkWOLdv/8pPpOlwiiyZPSTU0RQER/jMQpWw+0zUUhL1vI68ggrDbx3CjJOBHY0H+jgwVGKh6DMglysEF7JgpCWZSctlYYF4n9mWmdMu7m89crjp7pP8jLphKmIFYXe7KJTMi56Z9lN1t4AwhqxaSjYM+gDD5V/+824iUpKIIGsAqvoJVhgtCKHjkIZzQ2JS0B8xGwUsjSRpZDoBbD5uzf9HalKT4eILRftuSbrJQrpr3MlFkp3siOXe1WfAE7Dk1kCGkS6aUIPsbglNyJ8lMyuJW61NK7CZjOuPA9vmiNzLspnqQL5+nxSwJTJ/I0PPfE4F8CEZvCgVU4MjzYsFjz7bsqySDHejHRLN85gLTOpLUa3icaGTJ1LTfnN9YRpqxO/bNtpStYHLYvyn/5bLCUNvpY1PejoNo6PVOOKHz6rXK0gJNQOMe6TaBy0+vWIj/5nSvqbes+DgUMi0QhmDVoSisS1crinkLfOd5QprQJ2U6wOH3wCBHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cc454e-a51e-46ed-9901-08d81eaa5e81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 17:07:15.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYjYOa6K29Q95crfDJ3VX4atTe2CDXKlYmpIrVsLo0T1WvdntJvGMGdayfD7Jjl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3480
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_09:2020-07-02,2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=1
 cotscore=-2147483648 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020117
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 06:35:31PM +0200, Vlastimil Babka wrote:
> On 7/2/20 6:22 PM, Michal Hocko wrote:
> > On Wed 01-07-20 11:45:52, Roman Gushchin wrote:
> > [...]
> >> >From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
> >> From: Roman Gushchin <guro@fb.com>
> >> Date: Wed, 1 Jul 2020 11:05:32 -0700
> >> Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
> >> 
> >> Historically the kernel memory accounting was an opt-in feature, which
> >> could be enabled for individual cgroups. But now it's not true, and
> >> it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> >> user has at least one non-root memory cgroup, the kernel memory
> >> accounting is on. So in most setups it's either always on (if memory
> >> cgroups are in use and kmem accounting is not disabled), either always
> >> off (otherwise).
> >> 
> >> memcg_kmem_enabled() is used in many places to guard the kernel memory
> >> accounting code. If memcg_kmem_enabled() can reverse from returning
> >> true to returning false (as now), we can't rely on it on release paths
> >> and have to check if it was on before.
> >> 
> >> If we'll make memcg_kmem_enabled() irreversible (always returning true
> >> after returning it for the first time), it'll make the general logic
> >> more simple and robust. It also will allow to guard some checks which
> >> otherwise would stay unguarded.
> >> 
> >> Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Fixes: ? or let Andrew squash it to some patch of your series (it's in mmotm I
> think)?

Hm, it's actually complicated. One obvious case was added by
"mm: memcg/slab: save obj_cgroup for non-root slab objects",
which is currently in the mm tree, so no stable hash.

But I suspect that there are more cases where we just silently leaking
a memcg reference. But because the whole setup (going back and forth
between 0 and 1+ memory cgroups) can not be easily found in the real life,
nobody cares. So I don't think we really need a stable backport.

So IMO the best option is to put it as a standalone patch _before_
my series. Does it sound good to you?

> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> 
> But see below:
> 
> >> ---
> >>  mm/memcontrol.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 50ae77f3985e..2d018a51c941 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -3582,7 +3582,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
> >>  	objcg->memcg = memcg;
> >>  	rcu_assign_pointer(memcg->objcg, objcg);
> >>  
> >> -	static_branch_inc(&memcg_kmem_enabled_key);
> >> +	if (!memcg_kmem_enabled())
> >> +		static_branch_inc(&memcg_kmem_enabled_key);
> > 
> > Wouldn't be static_branch_enable() more readable?
> 
> Yes, and drop the if(). It will just do nothing and return if already enabled.
> Maybe slightly less efficient, but this is not a fast path anyway, and it feels
> weird to modify the static key in a branch controlled by the static key itself
> (CC peterz in case he wants to add something).

Ok, will do in v2.

Thanks!
