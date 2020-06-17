Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A010C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21BC20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NMdVqA4+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="boQWmzOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgFQDcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:32:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15922 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbgFQDcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:32:35 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05H3FFIn030721;
        Tue, 16 Jun 2020 20:32:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UmTBwLmgvXLHIH0e6/WtZrf92kRjg7Qw3nTDOZZOU2I=;
 b=NMdVqA4+7Nf9zoU+LS05KecoUQnEVf/814s5ZfPqohA8lBOGlurP+bMNhSqcAUNgTFcH
 j2mVd0xJqLyrF3nK31YDBahDbvW2hToYnlivx9Vwk8xyLbflxJC3h58jISsjFFqtCjB8
 csDR8AvYDXuLSNV8PwB6mc+KNuDYduReUV0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q65sh62v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 20:32:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 20:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm16LlggeJBmIETaohi49IVf2nlLE9bnJN3U4A6aYLeDFG5ceZB8HgWMnNnDHETRrpw+j+fSPdpUT/ntrluaxl0HMCklHw+AUre37AaUsJg73icxPPp/iPvbDsNBs2fLbFh/0dVNnGpJ0pHhF6KEEEuni7TC+W/QaG46WeD9ltGdBL0NH+wboAUocA4ULRXWdJGCCHr1b1qrTRc31JFKLf9ixAC768F2pOj8pjIVhosvkAc/Sy8R0ajYIVI6ux6/k6TiUtKg/XZFWCHu+nzNC83EVKSyA6WbWLjI+j+hyOrYZOKxL9z4qaXswj8yVZrKOdXOruB7rEkL9qY8aOi+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmTBwLmgvXLHIH0e6/WtZrf92kRjg7Qw3nTDOZZOU2I=;
 b=P5QJqIPS9FOojpyKGEKkiMYx6XgCqW04fPSrumBcudp3oBQG5Skb63BGdJASRl8xfHQFi6Pj9lv1BogK2R/BRwK+PwonPtXif5AmV9711GWj9Oj/k2a/UdQq3VdNHwKGJFaZo3KfiR9NAybQH3KzBDIT+0Kj/k4JN2tz0iO1W8LuL1RwEVbEH7bR+ZldGty8RobBbbovXTrh8cRp5SIoMVJE7gqEdP3F273czUJh+a2k1GGQEkLHcp0sKP2RhIeEZhXxo3zHwgxF17yw2k27+A6TwzwQW5b25lffYkgxBpYvwBTVF5jODRxZHcONXRh8DhXJoFoGFYIk+3txZ0/otA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmTBwLmgvXLHIH0e6/WtZrf92kRjg7Qw3nTDOZZOU2I=;
 b=boQWmzOH0ylnyNsKd+PxDASiWaDmIfHPf/uEF72LxR5+PxVmeJ/3Y9CKxXXkeyowkaCsgiDQDX2ZRqA6sghFzxrCPVKrEnKKRpXc01uFLAzgDCNhEstyw1+BunHP3bQt/IfWrn6VdvP69poEU+hhyDBoktKbsTEfvW0H3F3BBu8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2662.namprd15.prod.outlook.com (2603:10b6:a03:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.28; Wed, 17 Jun
 2020 03:32:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 03:32:20 +0000
Date:   Tue, 16 Jun 2020 20:32:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200617033217.GE10812@carbon.lan>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
 <20200617024147.GA10812@carbon.lan>
 <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:d0dc) by BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 03:32:19 +0000
X-Originating-IP: [2620:10d:c090:400::5:d0dc]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 563c9ac1-4958-4626-963b-08d8126f0ab8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB26626068FA63B5E184FCD334BE9A0@BYAPR15MB2662.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEfKxZSO+RuBctUZssYzxKpyeoO5EsWlPgDrZbwFKj080MCzHvvx3+i6EsFoK/wpJqSS11x/QhfmkECvT4HyTVJnpMOzy7t/RF8D+3rxsBzYnTw96jXUCPfVkk28ZfMhCTNSNV3y+LxtLa1ce3ncfIl28zpanDuvykiN0NWaLdyiXJU9QU8qZ0+NC1eNnhTueUIXIAIn9EwnGmy0hwf4GFWKL1mHSmuwV/vLlmquim0IAdRvU3RlPOuh4yuPi6+P2E3oGK4FyvZmifmr9Hu50Ke1zFZr1lTQDUCltyZ6RgoOJHVUZUqMQKee2Vl3e2CLwKvrNf+nIuTFlFD73CNQQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(36756003)(8676002)(66476007)(66946007)(66556008)(5660300002)(54906003)(2906002)(316002)(478600001)(52116002)(83380400001)(6916009)(1076003)(7696005)(16526019)(33656002)(6506007)(186003)(8936002)(55016002)(4326008)(86362001)(53546011)(8886007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3+YPNBZJ/nUjW9RTi3Zel701x9yC549j6ul1MvmNS5Q5S/G43SJ7E/35SGDFTxiDYtW8UWMuDEzC6+yi9JCR9wFvdeL6NjBNNAE0HhcFmGqFr8fdV1okTl0/4D3AB18RkOTpm0ZT1Ytfm2N2FIh2ZtU1otryNwRlb7Ivpz/JNx/6k4owscM/oy0vnBTiSAChsULdcXv0lk8U0xrxDRTghqOPvRpj3NmpfMO5f3vRXk3m6o8Um3NTxuzjQHCSUCwYiqqe+nMnS1xsoO3fKx10rLB2i4pBTn9B+k35FLL2qNk9yUG5x8MDg48Q/rTJG4kBjj/Og59zRTYhRfbWe3MEsJDa4emt5dKBg0kNykEpiQQlhxKh0dvSoQku8WLXHDRlB8wP1hmw6uqTf/n+nkccZMPaqD64ijsL+mtkgOvRQdkV335h2E5Hy6VMovA+kGwoUZnA7ybdkOl09D5GGN7vpT6QAtV7mPJlEgrvynQy+2Op58RwRxnKljqetXtnzisvId9ctiNn5V3A02smrjYvbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 563c9ac1-4958-4626-963b-08d8126f0ab8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 03:32:20.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSlh2hQdcIg36rSkfz/k/N7mSwkJlilpzfYg4Q0BUcoC9eqjNuvs7dN7dqmpMlO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2662
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170026
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:05:39PM -0700, Shakeel Butt wrote:
> On Tue, Jun 16, 2020 at 7:41 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:
> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> [...]
> > >
> > > Have you performed any [perf] testing on SLAB with this patchset?
> >
> > The accounting part is the same for SLAB and SLUB, so there should be no
> > significant difference. I've checked that it compiles, boots and passes
> > kselftests. And that memory savings are there.
> >
> 
> What about performance? Also you mentioned that sharing kmem-cache
> between accounted and non-accounted can have additional overhead. Any
> difference between SLAB and SLUB for such a case?

Not really.

Sharing a single set of caches adds some overhead to root- and non-accounted
allocations, which is something I've tried hard to avoid in my original version.
But I have to admit, it allows to simplify and remove a lot of code, and here
it's hard to argue with Johanness, who pushed on this design.

With performance testing it's not that easy, because it's not obvious what
we wanna test. Obviously, per-object accounting is more expensive, and
measuring something like 1000000 allocations and deallocations in a line from
a single kmem_cache will show a regression. But in the real world the relative
cost of allocations is usually low, and we can get some benefits from a smaller
working set and from having shared kmem_cache objects cache hot.
Not speaking about some extra memory and the fragmentation reduction.

We've done an extensive testing of the original version in Facebook production,
and we haven't noticed any regressions so far. But I have to admit, we were
using an original version with two sets of kmem_caches.

If you have any specific tests in mind, I can definitely run them. Or if you
can help with the performance evaluation, I'll appreciate it a lot.

Thanks!
