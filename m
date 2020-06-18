Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B059C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312ED20885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KnKm8C0+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dtuHZmO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgFRAfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:35:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbgFRAfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:35:33 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05I0XTXq007016;
        Wed, 17 Jun 2020 17:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8qKktEKrc9rEQBXbqutKSAJDlF5G6Fyib/Fyh8W/bPA=;
 b=KnKm8C0+B23WISlOXMWF41PvCBVFwfkY0TO+6Nvir34zLhUS9qCBz/mu7MssQwIUVdO0
 Pg+YlppFLK3Dgt8nqviPeBQFqkcwgwtcOJujmI/crO5J2jPtCamXGjIT04QtqDGMThNp
 ZV2BouKGdmjbKVs/stGLoHukcujSl5gzWV0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31q644s73d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Jun 2020 17:35:22 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 17:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ni1u48102ipGe6PMQUd91AND0DOrM4/oIz0dwXeR3S7TcnlaKlmxnXcafIgG2bW72vkA7VqWVkancmhJS+MC2tbDrzhGmzsdir5XYRFrI7fi8hyxxEFImfJ0lzxz/pMFvtbdLjbQezHbB7TZtvpRQed6rj4oU2RbluOu+WpvUCbhkibpE7fu/gloGqg+8N+JARccE8y/RxLa+6rwxsP3xqLcW11Zp5FM1M7yU5uCJO3UXQ13QjkSg2CcnaLM+IBj05Qzb8fDF3tt7/+ZW88YUxu00p9fqmR3YPs+KlREGIxforBoMkDW/o1aQIUGr7j1ZpRxXo/yHAFulpGta8077w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qKktEKrc9rEQBXbqutKSAJDlF5G6Fyib/Fyh8W/bPA=;
 b=WbtCaMZV8T8kLd886e1ooAVBUYzpq7SFUAG9sPLy6Sr249bfLvdNYOcDuyRrFR6166C0FW5emIKRvz+x93pOEuyNL4NiuhWpCBySJ16x/u9ar1j2Yetpks5g5qLxdk96BXB7Cx/78xwKXU+pMCvcTQODoLNfxh7QXgDj0PZdvFSSQZ9DrKf+9g2JrzRSWUNQat8SodZvXKrWsteAfe6zqXz5ZkQslFU6VR09aMH6zn5wDglCABB5URafvMlQ4upTZtCYu++2QibOrCLAxWD6Q67zn01NR15j7T7Bh2RGYi77ZVdoX6u57MEPft8UUWovUzpADU7EhoEoV2rG1yoxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qKktEKrc9rEQBXbqutKSAJDlF5G6Fyib/Fyh8W/bPA=;
 b=dtuHZmO8b8/xXoMXTe2M0IYwarZcj8PoRkkMCTuPOd9qCSAOriaq925cvCJptBg7TsKpvp+I3fFaoXhzE5FH+A2R29W9/P3g7t16sEQy+7wUH9FLE3dsjS6yJjKykQE9317d4OJf1ZY96JZvPXb/Ip4eaeZ8wD+0i22jSjj5vrY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3853.namprd15.prod.outlook.com
 (2603:10b6:806:84::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 00:35:19 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 00:35:19 +0000
Date:   Wed, 17 Jun 2020 17:35:15 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
Message-ID: <20200618003515.GB24694@carbon.DHCP.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-18-guro@fb.com>
 <20200617163528.a4477749b172c387e01c3996@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617163528.a4477749b172c387e01c3996@linux-foundation.org>
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To SN6PR1501MB4141.namprd15.prod.outlook.com (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9687) by BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Thu, 18 Jun 2020 00:35:18 +0000
X-Originating-IP: [2620:10d:c090:400::5:9687]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c467f93b-a985-4168-8168-08d8131f7a89
X-MS-TrafficTypeDiagnostic: SA0PR15MB3853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3853406D2202D159E644C600BE9B0@SA0PR15MB3853.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XZtFxXx+6NopV/cJYD4uVuD8HrLUTdJoOE84M37jml09h8Y/gci3EbURFBous+TDx3OkZemBXHJwanLfb2e5GN/v80hCECiYBKW/HdBOxC3XbLw596TeSigw0QA3C8qhbAyZojR4I0c+MkuoyTWJXe2eGeL1hb3LvN8QD0Fb/rWHyZsMti1lmO12DF4c1X4kqbwO//w2qBnWIeCLnspabu4V1MzkYMLICgAGDv+9DsngDvrXfH9MSMD2PcsT2DI6O/dbjCA146mSnBr/OPTpo86idYJDRHllF2w4UYfEuUIz1p77OwC6QgIeQs0ZZrU48TYNUCj/UuXI3ZV9iT62WspXIapjvnWU2jKP/BzrY6qo+yVMeI0+gmTtr2M9mprEsFUcLWWfYUVBh0sxa6wcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(396003)(376002)(346002)(8676002)(33656002)(9686003)(2906002)(4326008)(478600001)(5660300002)(55016002)(8936002)(6916009)(66946007)(83380400001)(16526019)(186003)(6666004)(66476007)(66556008)(7696005)(6506007)(54906003)(86362001)(52116002)(316002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: D3d6mKs1VkxayE20x68zNw2OAHVKoGn0H2eLXMWNlGzgZqxTiVjVPFvFtP0g+tsv6Bpiair7Jc/YMDIh7f5cTvW8YL0mNPlsJcPLn5qOH6l0rFVjwA8H2+r+RnvC4ylWnHSAkjxGL1LUWGDEoqYvJyQ5kLuHbINYaxZTpfk8ygCA2SZNr7HZeOtRmtuTm/aXJ6vb8Gr5wjgKrot1MDxuVwQBvokS7BQ1gWkSD4EwyZYG6qzsWcZFbfu4FJ6OrIwy36GBHvYQ4/0vDBKhNaS0fSQ/CyarsO6VLTGmomlNvCd+tzNgxW8TBDIGyCgvi5ndKUC2PEgylVWkfRVbTzr0+k7U4z3lTv9peA/N8A8AdI9bfFevQoR4F1VLWYp+/hMNoNAQmnLjn5fJP40O84F28rQnVQOVe/ondrc44bBbCyygRGmWdWFidc6005mRyxmDDk89uo+Qes9UNLvlI2eLiB2rx8xXe4oVXkInI5Vt0as10gz1uBGt6m5fsYjbQ79rAKRdMpbhIOTv3BghQayXhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c467f93b-a985-4168-8168-08d8131f7a89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 00:35:19.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E4Gaap/nD+Qq9sL9i+KQRgO2aTypTRMWrWpA2LVp+lsO4Aw9wkzhgH/iCm5kU4h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3853
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_12:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 suspectscore=2 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=712 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 04:35:28PM -0700, Andrew Morton wrote:
> On Mon, 8 Jun 2020 16:06:52 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > Instead of having two sets of kmem_caches: one for system-wide and
> > non-accounted allocations and the second one shared by all accounted
> > allocations, we can use just one.
> > 
> > The idea is simple: space for obj_cgroup metadata can be allocated
> > on demand and filled only for accounted allocations.
> > 
> > It allows to remove a bunch of code which is required to handle
> > kmem_cache clones for accounted allocations. There is no more need
> > to create them, accumulate statistics, propagate attributes, etc.
> > It's a quite significant simplification.
> > 
> > Also, because the total number of slab_caches is reduced almost twice
> > (not all kmem_caches have a memcg clone), some additional memory
> > savings are expected. On my devvm it additionally saves about 3.5%
> > of slab memory.
> > 
> 
> This ran afoul of Vlastimil's "mm, slab/slub: move and improve
> cache_from_obj()"
> (http://lkml.kernel.org/r/20200610163135.17364-10-vbabka@suse.cz).  I
> resolved things as below.  Not too sure about slab.c's
> cache_from_obj()...

It can actually be as simple as:
static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
{
	return s;
}

But I wonder if we need it at all, or maybe we wanna rename it to
something like obj_check_kmem_cache(void *obj, struct kmem_cache *s),
because it has now only debug purposes.

Let me and Vlastimil figure it out and send a follow-up patch.
Your version is definitely correct.

Thanks!
