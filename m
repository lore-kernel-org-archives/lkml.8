Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13C0C2D0F2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B309A206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eQUeZjq4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aurNiCd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgDBDGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 23:06:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52450 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732537AbgDBDGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 23:06:09 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03234o82030224;
        Wed, 1 Apr 2020 20:05:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=EeTCKoh10OVAaAAlR/2wKO70EDlaW+hMpW+obeZBOS4=;
 b=eQUeZjq4a8RIj+x+FC/M9GYZKIfW+m4U1heA0wWJZqTx9i0HHuOAQh00xGe/pfC8m2I4
 l8Rd5tzLuInr5HKkUzl2nCtnkVhTvQGJ9OlxDUGHQhGHPBF7AMYPGEp0Yfr7KY34+m1r
 jnbZRLifYaPUDU9tyK5hxz5MAk3ezlhrJK4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 304cxbq5mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Apr 2020 20:05:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 1 Apr 2020 20:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2HRvly5B3wjq2dH++wuPCujevUN0hVK9xpW7Jhk6OM2uKtkzfNb839bdn37ha2fdG0PZbskCWwQrFc9EJRM9evt7PqL04czL8QP4GkfuczwlmNRiC4K3zrYLtEEf2GR+711eyAJnmgdliQpGVVxWy8F2EzoEBSdrdv5Tvgq9Fy35DIxKop73suSBgaKaH9W19+GlFyE76U/y8tKQBd+pe+xvcsgdZINC2yI43wipW/T1hpfWQ4+qddQ19TqkER2Acrku4SnlM9qNB149m/3JgBga8/Q/4htyBdIyW1bk2s0jskcHRznTsjFCmnbvw1jcCn85M3VCxgk362h0NIdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeTCKoh10OVAaAAlR/2wKO70EDlaW+hMpW+obeZBOS4=;
 b=dHiZhvbOKpjoVngzC2yptzxRQ0SOMP+nqWN4qhQ7WF+kIj9H6F6ytA8ETxHcofcp1ZTQnlHco+vH9JuYSwgBml4cWQt2ccQ34FkgkZmzQEwQAMnLVEirwYz41OFxpMCNDN8nG0RahL13EPnNgDPkj3MtLUzxhe12WzJw+9KbEvS4nV7l+DNy0FWNV475Nv8rOffKss2onwHpg4bl2k1cyuA000lKJZSWyVIbIYbq+27BHL0Jo+Tqh0Hwe70KVQx/j6aMi0ZrmORT/UaDNKvp9u3AvEkzkJrmS+4/wgQBPEin8fTGWJAG8s4PGvJ42Qqy3bZiSYqNeckhlVBMcd7qPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeTCKoh10OVAaAAlR/2wKO70EDlaW+hMpW+obeZBOS4=;
 b=aurNiCd9UkHyI1F02XtHexMjWZyxTrjBv0qDk/7J5FqX4IM6wfpeGBfI4hdySKRj3pCJG+oV+SsT19jKyZ+8cAhZAdomypGMURccxLG780+MYpOXxGZa3a8JH5sKSwiUczS54x0s/F8Tq2XDoP36s5G/7o6VGxFVcE7HEeA0vgw=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2790.namprd15.prod.outlook.com (2603:10b6:a03:15a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 2 Apr
 2020 03:05:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 03:05:48 +0000
Date:   Wed, 1 Apr 2020 20:05:43 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Joonsoo Kim <js1304@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200402030543.GA73575@carbon.dhcp.thefacebook.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
 <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org>
X-ClientProxiedBy: MWHPR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:300:93::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3b6b) by MWHPR17CA0056.namprd17.prod.outlook.com (2603:10b6:300:93::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 03:05:46 +0000
X-Originating-IP: [2620:10d:c090:400::5:3b6b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27f9843-3ed7-40d8-9fd2-08d7d6b2be21
X-MS-TrafficTypeDiagnostic: BYAPR15MB2790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2790E9EBC71935AF4AE6E278BEC60@BYAPR15MB2790.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39860400002)(5660300002)(66556008)(6666004)(33656002)(4326008)(66946007)(316002)(186003)(2906002)(7416002)(8936002)(6916009)(81166006)(66476007)(966005)(86362001)(54906003)(16526019)(6506007)(53546011)(55016002)(52116002)(81156014)(1076003)(478600001)(9686003)(8676002)(7696005)(142933001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxI7xLJLVzwAHW0tXdornf29D4jw1SQHz1nL2FPG9i5l9ZWZkotfO3FdZ4WjHgOoJ/FjE0zaAYLWM/UizZjDGZGLeU6ovnHoH5wDs7hpvY2SEqLVAKfEPsxuqpq3lM5+0Gl8+rf+Zp5+bvhKHXYUYwgTrPSRhfE12DCWKsGJjzTp7HKh8CzGReTdVXXq3SX2DNlDHsrhn+1bW72u9LBcH7L1vVMH1wbRhNOfg1v97HdsqxjzJpTQwRfulB1e4ii+u+RRyeG0wKXM1mSMdBJ0Uer4L4CtjixYBdNkVSwELplc/MVkS62S5HPc044WeHdKRumlL9h/uQy6vv9gGNoTJ9ajvdo0CcLgmDPAvIM95kaCwz9AGDCG2i3qar9SsQjXzrSdpmfmItv35jjbVXPvLre/6/HIWDGL5k+DJw/Y7Y0knxEF3UNnV6FT9mJuMcAHv5hdPKCSsC7qumZ92UApoR+cSu5Xz9sqZIZE141zV9HeD1qaAIOIc0dPbP0yiBMBCdEDMrokiwL/47jq5lVZeRZaMYVTI8jENNJb2b9gbvwUAsEjb+DtfdYJZ42ffpfO
X-MS-Exchange-AntiSpam-MessageData: gQNPb3TmHg6howI8UY1W/Tf3Wl4j/ezexKSJtluWgMKTvxOJ+0bFEJZ5XMmnXT2SDVZJjiDwL2eIb5GZIKHJXjebYjBOXrQRiFC+8OyBQZnbHdDGa71vDyg2lYHnYcFTqeo+K3rxp/ZZtwt0kN0bX4iR6N/i0mG+HNyeToMjCLCIGhHJvjjlPttScCVxpjZ2
X-MS-Exchange-CrossTenant-Network-Message-Id: a27f9843-3ed7-40d8-9fd2-08d7d6b2be21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 03:05:47.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zz8eNLTg5zmzC7vP2ILHnIAHojTj2US8YWYpB1YNby6LLrdBzr/kN4Q4zOpqi1tw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2790
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020026
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 07:13:22PM -0700, Andrew Morton wrote:
> On Thu, 12 Mar 2020 10:41:28 +0900 Joonsoo Kim <js1304@gmail.com> wrote:
> 
> > Hello, Roman.
> > 
> > 2020년 3월 12일 (목) 오전 2:35, Roman Gushchin <guro@fb.com>님이 작성:
> > >
> > > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > > Posting this one for Roman so I can deal with any upstream feedback and
> > > > > create a v2 if needed, while scratching my head over the next piece of
> > > > > this puzzle :)
> > > > >
> > > > > ---8<---
> > > > >
> > > > > From: Roman Gushchin <guro@fb.com>
> > > > >
> > > > > Currently a cma area is barely used by the page allocator because
> > > > > it's used only as a fallback from movable, however kswapd tries
> > > > > hard to make sure that the fallback path isn't used.
> > > >
> > > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
> > > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
> > > > unresolved bugs. Perhaps the idea could be resurrected now?
> > >
> > > Hi Vlastimil!
> > >
> > > Thank you for this reminder! I actually looked at it and also asked Joonsoo in private
> > > about the state of this patch(set). As I understand, Joonsoo plans to resubmit
> > > it later this year.
> > >
> > > What Rik and I are suggesting seems to be much simpler, however it's perfectly
> > > possible that Joonsoo's solution is preferable long-term.
> > >
> > > So if the proposed patch looks ok for now, I'd suggest to go with it and return
> > > to this question once we'll have a new version of ZONE_MOVABLE solution.
> > 
> > Hmm... utilization is not the only matter for CMA user. The more
> > important one is
> > success guarantee of cma_alloc() and this patch would have a bad impact on it.
> > 
> > A few years ago, I have tested this kind of approach and found that increasing
> > utilization increases cma_alloc() failure. Reason is that the page
> > allocated with
> > __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by someone.
> > 
> > Until now, cma memory isn't used much so this problem doesn't occur easily.
> > However, with this patch, it would happen.
> 
> So I guess we keep Roman's patch on hold pending clarification of this
> risk?

The only thing which we're probably want to wait for is the ext4 sb readahead
fix. It looks very similar to what Joonsoo described and it was the first
error I've encountered in our setup.

Fix: https://lore.kernel.org/patchwork/patch/1202868/
It has been reviewed, but looks like nobody picked it up, idk why.

Thanks!
