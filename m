Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95203C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6418A2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="D5Nyudou";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B80VE28n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404425AbgDCRua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:50:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54214 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404179AbgDCRu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:50:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033HnXDq015136;
        Fri, 3 Apr 2020 10:50:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=j79JjdmxjvREK2lYqpNZlB8B6jMzlfTe1QL9P1uXNJU=;
 b=D5NyudouSC7ZDcYEKZ1rDqsT8FhbYE5TqYz7qnQDwMDmFB3UrQp00LXd0RkN26gMnZvV
 fqLhZGIxaj+OQvwOLmGFesb3Dl9jUB0axG+LT0oKFQLRWWZmEcn/qluIN89ZIttGOdqV
 Y85gVTN0BOiCqkmdY9uc1RDFcL8cBtSY9Jk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30697e87j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Apr 2020 10:50:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 3 Apr 2020 10:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkrS+5gdDQvT10n5/U0IUVSqc/iQi85NKWHjqw8EuVQDcYQc4OMMhtRR+dbEuc0C+k+qlUDgQcOcFMgGPaIM9ZqWVDmz22itn2J0RGBgE1YnRA0T9MWfzcVw19OlmSppKNog5RA+agnsjOCFAA8PojlZweLCDXRlp3kvx1TW6C3jFsIhPGOUrh+fAUoXrN3sV/kd1U69P6LzdT8U/RcUWQJPlAjV0CEyysWBB35dn1RB9ye8O8cKQtXYaZPek0y37SXkMKCcs34ILQirKHrOkhRuxyoPi7L7YnxciNHvpoz5jaTkvOBB7tQRzc9DGrF4Vev9BwHvgEWnVzoQpRuSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j79JjdmxjvREK2lYqpNZlB8B6jMzlfTe1QL9P1uXNJU=;
 b=P1hS31JobQeb/ya+KDiLQ+artiW0muizG6FfzQvn5kp3LiTdNo1dzrfDZpUcxG2eXDfbRfbfH2zs/bD3sNBL3jwhDUAHuSX7SET445CUI8lF7wkWSdMTGUfdDigdzFtCW7oqJ+zmLeygFoKxStcgSIBIEaK+MmRtIivS9Lufb3pQJTSysWg8EPtrDAIhT2ef3xtdkJXg4mV6ivQFPFlUZumBja/K9aHcVhtQQBhpBo9lXYPn2PQgtneNKXP87amhQ0REJNJeTNjMPZxxAIDGjOM2xMrDHK92rb4YjTZ4Q1FKzI8y+AnQCBd5ebXT10fmIjYX+EspfF9B+8k/TXgqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j79JjdmxjvREK2lYqpNZlB8B6jMzlfTe1QL9P1uXNJU=;
 b=B80VE28nWFmpaQFpyVlPw0WRYkchw2xPWQhCMEmfgXKZXjwinn0VUca0jjCNrEiZuqjYCSI6rcGoclZY62fUrJW81A6dj3ad60HeKdOqg7kqVeAz8XOhrCNofunCBRE7WtQsxO/trByxJAiwWNdjFEsa+PTH+JDXuoH941aGhMg=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2584.namprd15.prod.outlook.com (2603:10b6:a03:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 17:50:12 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 17:50:12 +0000
Date:   Fri, 3 Apr 2020 10:50:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Joonsoo Kim <js1304@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200403174559.GC220160@carbon.lan>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
 <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org>
 <20200402025335.GB69473@carbon.DHCP.thefacebook.com>
 <CAAmzW4PF1AXcZnQpWmqWgTShu+5v7B=nv8waRv+vk-0Bd78cZw@mail.gmail.com>
 <20200402194233.GA171919@carbon.DHCP.thefacebook.com>
 <CAAmzW4M7cGmvssfmT5kmeZNOiQfbZP6N71TRHBq0BDtWqi78=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4M7cGmvssfmT5kmeZNOiQfbZP6N71TRHBq0BDtWqi78=g@mail.gmail.com>
X-ClientProxiedBy: MWHPR10CA0021.namprd10.prod.outlook.com (2603:10b6:301::31)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:4d9b) by MWHPR10CA0021.namprd10.prod.outlook.com (2603:10b6:301::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17 via Frontend Transport; Fri, 3 Apr 2020 17:50:11 +0000
X-Originating-IP: [2620:10d:c090:400::5:4d9b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7eaddb5-ae4b-4c98-eac2-08d7d7f77594
X-MS-TrafficTypeDiagnostic: BYAPR15MB2584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2584F993FF9E5C64D3B71793BEC70@BYAPR15MB2584.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(366004)(39860400002)(346002)(376002)(55016002)(9686003)(7696005)(81156014)(4326008)(6506007)(54906003)(33656002)(6666004)(8676002)(81166006)(36756003)(52116002)(186003)(6916009)(16526019)(316002)(66476007)(66946007)(2906002)(66556008)(8936002)(7416002)(478600001)(1076003)(86362001)(8886007)(5660300002)(27376004)(142933001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTQPPzcoSBEMDmV46vUbaN/Qlfri9wyrGJYPcGERbzm82Sbuq+vg6/IYTeXNVPeY0De1NjRgaO+Gm/jH/w3ADQ3njLwXLyNCeXNlqkhpl5cM8PtJXixG0sKvvoFrZ4QcQJ61SkmhOiSUOk3VQPRary4Cf9XlwDoMAZvIZycSSEkIZBVJJ8w6wed2H0y/I7qilE5TQFXcWRLMr+BZA6VO2B3/gJju0PrmlTcOJtZwCzf1mXPtUmmysUCTRtjmKMW4cgbGcjshVWzs4cqspY2viYsZzI1VTUf5JGGZ2lER+rXSvnfK9Kdw+jR3qd5pI0/vGF+0cpOTxWayG9KS1uvLUdVy3DolFSvgqmp+ok5LntqPNF1qi+9uTLCbEltTjjw7fiezuF5wGgVMdLDNxOP7ZLKL2Rq9pf2izULSGurfRlbMNzR8MzP40NrZ4wVboIrsC2lIgkuXnYVb5goS8otDWMn5LOZ9pAKlUsthDH1UMMAS5oL8Ec5nW2TSCcQbuuNfIUmveFmrOOXNgXXhkK6mkQ==
X-MS-Exchange-AntiSpam-MessageData: iMUa3fArICphfFYPQ0iG2Sa4SRn637PM8sZiH5Mq9RHOofwTVHI75UzcwlDqwVPXqLaCg6PBsrO19SKdu1l5VkjMNJFNszZG0eSDcqXZk+QpxjH4UZ9kF4dJ0nTHOdhfUnvhRhFtlx2c/UCf3NvtyvATS41uYc0JwBWhhuCOZcARmcNkW92AgEJhmnC6igav
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eaddb5-ae4b-4c98-eac2-08d7d7f77594
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 17:50:12.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ/fKXDB5Hvg4ZZvujtNGVgUuSRq0JaPc77W3xc0VtdOxCjUo8CubI1MqiO39QYb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2584
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_14:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 suspectscore=1 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030148
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 01:34:45PM +0900, Joonsoo Kim wrote:
> 2020년 4월 3일 (금) 오전 4:42, Roman Gushchin <guro@fb.com>님이 작성:
> > > In fact, I've tested this patch and your fixes for migration problem
> > > and found that there is
> > > still migration problem and failure rate is increased by this patch.
> >
> > Do you mind sharing any details? What kind of pages are those?
> 
> I don't investigate more since I had not enough time to do. If I
> remember correctly,
> it's the page used by journaling. I attach my test script below to
> help you reproduce it.
> My test setup is:
> - virtual machine, 8 cpus and 1024 MB mem (256 MB cma mem)
> - ubuntu 16.04 with custom kernel
> - filesystem is ext4
> 
> > I'm using the following patch to dump failed pages:

Thank you! I'll take a look.

> >
> > @@ -1455,6 +1455,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
> >                                                 private, page, pass > 2, mode,
> >                                                 reason);
> >
> > +                       if (rc && reason == MR_CONTIG_RANGE)
> > +                               dump_page(page, "unmap_and_move");
> > +
> >                         switch(rc) {
> >                         case -ENOMEM:
> >                                 /*
> >
> >
> > > However, given that
> > > there is no progress on this area for a long time, I think that
> > > applying the change aggressively
> > > is required to break the current situation.
> >
> > I totally agree!
> >
> > Btw, I've found that cma_release() grabs the cma->lock mutex,
> > so it can't be called from the atomic context (I've got a lockdep warning).
> >
> > Of course, I can change the calling side, but I think it's better to change
> > the cma code to make cma_release() more accepting. What do you think
> > about the following patch?
> 
> For 2GB CMA area, we need to check 8192(?) bytes in worst case scenario and
> I don't think it's small enough for spinlock. Even, there is no limit
> on the size of
> the cma area. If cma area is bigger, it takes more. So, I think that
> spinlock() isn't
> good here.

Ok, I'll try to implement the other approach.


Thanks!

Roman
