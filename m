Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D571D2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p0cf9m8g";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XNHCokg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGACZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:25:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726416AbgGACZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:25:11 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0612J63k021825;
        Tue, 30 Jun 2020 19:23:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=dO3ByXh+MCskQ6V5ANTi6xKEtAAajimldCCab53SXgA=;
 b=p0cf9m8gRTMyKyUOMSpx43B37nE4dzx1I5Us8zxwVqhlC5Ql7rVLrZXujFfRuYJ7vIM5
 a1GDGX4q3fTW0M5oEIoxDqIa8dxBB6zR/pczITs3ujmI1TxIVNb19qy2MPnO8V1BXJG3
 EIAxhwjmAhU/7gchxavhcuWQmBiIWMGAdYQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31xp39d8kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jun 2020 19:23:15 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 19:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG+UKfUIMen+4XBJaXTzNzsNSNF7wTwIy+XSRu+Nvcjb8lY9QYSF96yVVuamTki18CBMVaVIGctKpG+BDT0Blp+lktykgigJzemhDsJz16RBFtCJ70J18Pae+wQJzQvgnoWZvMKkJhVUGEHdNX6baBbQA/p7CvIa6D1LqEejg63wsbmRwPWxpHm0lRO7lplApmet2OnAA7MUILlZxf5Z0Vt4oHx1vE/TrEqbuxpMEw8B1QbvVuw1TErmGikxiKDZoGtfpgD0+S14zdUUS2zf81d7dYvV0yMnRq6fNI0SKp9ArDEBEWvRpqx49IMLSi8HJLW9JFGbaWIeejPggxdO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO3ByXh+MCskQ6V5ANTi6xKEtAAajimldCCab53SXgA=;
 b=hyFqVL3CrIRt5aT+TBc7563Lc7l8aojPVkR7rldXNL5sJnTY7ag5O3/ikHadLnplJsmcLJl6ccd/gIA4Hl/DVAzJNP22r4C1vTaEjBHPCUcfblevQRFNVgsjeqaQNzjCPTFN+Ii76RpDAC7QSt6KUzeDWm3ezUlRjAjTTyqDTgjpJOLT0u9k+eb9171E85AIG9+tLND9KIMQ6nstfWUnAjKpM2s0yEjeRoRrDwP26jXgENVzWLvngrdaWpIxKugPObIWCz1d+xoS03MV1d3Kwi2pGDFYG3K5V4mfuazqyeTw3GnYk/pGmVNVuIw5/ke0soERO96CGcnAIYUC2RUomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO3ByXh+MCskQ6V5ANTi6xKEtAAajimldCCab53SXgA=;
 b=XNHCokg4w/2Drh2B1qtlYz8mDbDjNVqZmOPH18Snh/JQZzQmh/d4enD0SvZAukoMmofpdVgbzaCPFEU+BxG8B7yqi+28zoU+LzTkBforigxQ3xbY8+HDsaSSnAdSl17h2hMBfGeSb1TBRouJuISmmLtWr4G6lxFARnPc7kVT078=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2629.namprd15.prod.outlook.com (2603:10b6:a03:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Wed, 1 Jul
 2020 02:23:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 02:23:13 +0000
Date:   Tue, 30 Jun 2020 19:23:09 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Barry Song <song.bao.hua@hisilicon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Aslan Bakirov <aslan@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] mm/cma.c: use exact_nid true to fix possible per-numa
 cma leak
Message-ID: <20200701022309.GA58975@carbon.lan>
References: <20200628074345.27228-1-song.bao.hua@hisilicon.com>
 <20200630190825.GB37586@carbon.dhcp.thefacebook.com>
 <20200630190931.04967b5e8bdf29c33f3c8005@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630190931.04967b5e8bdf29c33f3c8005@linux-foundation.org>
X-ClientProxiedBy: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:94e1) by BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 02:23:12 +0000
X-Originating-IP: [2620:10d:c090:400::5:94e1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 561b65b2-cf09-4c05-7f0f-08d81d65b460
X-MS-TrafficTypeDiagnostic: BYAPR15MB2629:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2629D659A45B64FA3BEAC66FBE6C0@BYAPR15MB2629.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tq/4UEgAreL4hvk9eIAIYCQDle1l8p1xKdO+IdqT4/j0hh331cFQtHExXUCrjbLjbOKI3+EghEtQkUvw8aarlT98W61NBs6XUqmBM8JfqUiyswLDdIo+5xyNryJC+CeiEuyocyYAzklszN1sY9NtF+BGV39N9+baOGBTOvrOu5Ne4A6C5oDy+duj6/zuW6QSQgbvlVcVKxEWM0P4gJpPhR7eh1qQkIDvEh/nJcFdKjlg4FuJOSDwlgHC2lPY2tusraIQpGEXo4UdvfwfkHQ0M8Az6+DY6r3/Kammgt6No5jzKTXyMPq2fyo1qrWxWl9CJOjrGD3L3tMqZAVG89tttw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(136003)(346002)(396003)(366004)(316002)(2906002)(186003)(16526019)(66476007)(66556008)(66946007)(8886007)(1076003)(6506007)(7416002)(9686003)(5660300002)(8676002)(55016002)(6916009)(6666004)(7696005)(52116002)(36756003)(8936002)(33656002)(54906003)(83380400001)(478600001)(86362001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: t4WSvFoPuwDMsPbQBv041JKGCSPk3NYuMSbIqmocqAvNdyApyj2QW5tv3YomsjhPbI5QstOw/rRrYypbpkqsQ8ylqYgGcHvF/MGqt+VfO7LL7rVpiKFi6Eq5lrrAc1pwS4ezCgI6GNL16EXGNVriu0wMTrFh0sdwB8Niwxk62WSEqk6eVYIoTtzI0fenhb+bIssPbfyuIj4TaC5ehyqgFpg6sLDzU+tl+k4OvaqFeNc8Rg6iFk/7i5NV/rwqxu5fhQMJibjIYdeajZtqaPMSu3diS8KxU/Pkqz1nk4jp37gl7kFrMwgOfvaVOevUzazkHQpLrP9Yt+fmEV7lOnw4gcPO8daxS3QtwV/0FMBiFvlPaw/EUq6em6RDfFfDCpQzNm2N6KD4G6RcTY+6JVopVld03KS4nK+xjvl43f5zpLPhnpWjzk557N0ZZCfFKVV8JkR9JnQs0KXvFPSIkY3gmcAKy2YF8zJir1166fho4RtKpUo8CsZy/Q0VK2Pm3T+A8nWaiEjunkwcJPivz5gcAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 561b65b2-cf09-4c05-7f0f-08d81d65b460
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 02:23:13.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC8yratvtyOhBGsFGEaFX/qDIzYrTEwDsqIXBLWCaxw5jLVMHFDLeh3nmAib1zak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2629
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_01:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 phishscore=0 cotscore=-2147483648 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=5 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010013
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 07:09:31PM -0700, Andrew Morton wrote:
> On Tue, 30 Jun 2020 12:08:25 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > On Sun, Jun 28, 2020 at 07:43:45PM +1200, Barry Song wrote:
> > > Calling cma_declare_contiguous_nid() with false exact_nid for per-numa
> > > reservation can easily cause cma leak and various confusion.
> > > For example, mm/hugetlb.c is trying to reserve per-numa cma for gigantic
> > > pages. But it can easily leak cma and make users confused when system has
> > > memoryless nodes.
> > > 
> > > In case the system has 4 numa nodes, and only numa node0 has memory.
> > > if we set hugetlb_cma=4G in bootargs, mm/hugetlb.c will get 4 cma areas
> > > for 4 different numa nodes. since exact_nid=false in current code, all
> > > 4 numa nodes will get cma successfully from node0, but hugetlb_cma[1 to 3]
> > > will never be available to hugepage will only allocate memory from
> > > hugetlb_cma[0].
> > > 
> > > In case the system has 4 numa nodes, both numa node0&2 has memory, other
> > > nodes have no memory.
> > > if we set hugetlb_cma=4G in bootargs, mm/hugetlb.c will get 4 cma areas
> > > for 4 different numa nodes. since exact_nid=false in current code, all
> > > 4 numa nodes will get cma successfully from node0 or 2, but hugetlb_cma[1]
> > > and [3] will never be available to hugepage as mm/hugetlb.c will only
> > > allocate memory from hugetlb_cma[0] and hugetlb_cma[2].
> > > This causes permanent leak of the cma areas which are supposed to be
> > > used by memoryless node.
> > > 
> > > Of cource we can workaround the issue by letting mm/hugetlb.c scan all
> > > cma areas in alloc_gigantic_page() even node_mask includes node0 only.
> > > that means when node_mask includes node0 only, we can get page from
> > > hugetlb_cma[1] to hugetlb_cma[3]. But this will cause kernel crash in
> > > free_gigantic_page() while it wants to free page by:
> > > cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order)
> > > 
> > > On the other hand, exact_nid=false won't consider numa distance, it
> > > might be not that useful to leverage cma areas on remote nodes.
> > > I feel it is much simpler to make exact_nid true to make everything
> > > clear. After that, memoryless nodes won't be able to reserve per-numa
> > > CMA from other nodes which have memory.
> > 
> > Totally agree.
> > 
> > Acked-by: Roman Gushchin <guro@fb.com>
> > 
> 
> Do we feel this merits a cc:stable?

It would be nice.

Thanks!
