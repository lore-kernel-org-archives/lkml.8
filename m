Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EABC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8976720716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="et5dIY6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgICRTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:19:03 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:60120 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgICRTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:19:00 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5125800000>; Fri, 04 Sep 2020 01:18:56 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 10:18:56 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 03 Sep 2020 10:18:56 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 17:18:51 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 17:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ5ObwSNLGMLQ9UlvsnYSDUcD3ijierkswy+ppzp8TqjeMCI8uP3UfH0nsFYm10ZfqPH/jJhWdW0BJl8w+GtEbURGpIyubB42ZuII4TrbDgjy29wVnwGpp5as2t7VfVaNq15i4eEwi+Fpu0Y7mXcaNhQHF1rkSIw1ciPScIJolTegrmr4QbQb7mAkUnDCEhYpS9XYixk7zJeL6c0ISUU7ZCKikXVgopzFCzV/6GwfC9a/8m9VEywwqPPF7RpcZyiyNHQQCMnnLdrMNxBf9wCmjJUYNA38kGkuLl6S0b5NUlWAPlIc7+GPoPQrA+umOsZJF5iXatsWWlbfYV7wIRyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjWc+IIcXziz4xdShvvbh73CGUMpP2NZOkg+EZfLRVQ=;
 b=gIYHtKQkSU3CfyBr4YtH1o9io81dF81gUrb5dnYG3AfJyUe4AQ3B6EbZCcRTKpqtqtvc8MaFDsZaXy5TE/WZNgcRb93GJv7KexYkYlQVAd7GILfMNdqdLvSDhcc/kidQ5eS/VuEosnD8jet+7aGpA4aGZLQTG3NZC0Ctrv5MhTuA/s4gZgdynDazZ00C+5OHbkcep3TlfO3jjkYyJmFO2Y2UtcG75CzzB9XDas7ZiAwbK/95NliH9olc8SujTctAAbtHgsOKSOrQ5dWbueUbUsG27AkkQhM66H/CprGWYOYdUkDyaBO9jjjNTC2B321GcGue6k3+RB3gWUblOuDPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 17:18:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 17:18:49 +0000
Date:   Thu, 3 Sep 2020 14:18:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903171847.GJ1152540@nvidia.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
 <20200903165051.GN24045@ziepe.ca>
 <20200903170157.GE14765@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903170157.GE14765@casper.infradead.org>
X-ClientProxiedBy: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0131.namprd02.prod.outlook.com (2603:10b6:208:35::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 17:18:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDssp-006dPh-Fy; Thu, 03 Sep 2020 14:18:47 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1086d530-b876-4ec3-2df9-08d8502d6c10
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1547BC1807C5BD078196D415C22C0@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxHMlZ28dUD6yVihd8lADbKNBph4pWofqG3CTH8+cDfEmuz8TE3yH92GKUsUfxP3O+s/HL9BXWRCkky7AUXrBCJMaAk7iC2mOpy0gFzsiY0Fejk7zErtxoomy/NdSjQiq1zgO0NJcgALzax48zDoe7QXA+Y7pzsEf4ojRW3cmCaU4jNuyEvXiHi68YIKqEk4Ex7UNn/SBCMwU744+iEurAs2+sUXVOJRCxg6ak1WVRuIafe2+RIbAY8Rv/dXuHGXscQZowAjO8XA4AsObM1evaSgdVvarFZaruwH3WXyMn6oMzIp5ZL4OcL62hXhS4autjRhpjKYP2n5ZTXyHy9/tcgufppFIFKOPZsK7qQm1JrsmTLZtNr0mCp6iCAo2E731bP461irIefol9Mzdq50e3Ax9gfbqg+FkDKbUDEWuZJFNrLJqM64PEsPcc59mRW1acmkA54CjXLcsfmPIMkmLUE25J4ZXb/TaC48+DT8CYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(426003)(8936002)(36756003)(2616005)(9786002)(316002)(9746002)(26005)(33656002)(2906002)(966005)(186003)(66476007)(66556008)(6916009)(8676002)(1076003)(54906003)(4326008)(83380400001)(86362001)(478600001)(19273905006)(66946007)(5660300002)(562404015)(563064011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8PpAtcjxjQ+bDuinFvfstHkr/tuLzVv8A95fcOKoll3zWGHNvKznjfeRkp6tSSDmM+aoi0suRulHVcdloL/Ac8uYriz44JTaLj6RkcOg1xDfjBtpph9xQLa4rjkG+WwaAQNL1ypvtkkp//aOO1QoHp3h2Chmh9/z3F771l0T9z4bxIxCF15DuEW03t64IaNnWVMf6JjQFPFvVT8pZUKl3S3zxNdV+Wh050j0+rsiQjd2HsGluwOQVl5gOaKwA4GnmYDSTHL8iBPkI7CUFep45jgq2QGZC6ZJrBO/9wwRSw0ln+qgo5Om+2zOLGahi8pPktH8yN+I+92+40V77PYCOw5WytHgqG0wnmv2kgjuPrWdfK+tx2ZFMjbYTflB1oIASraHV/0pqn84f3qQ6PXhC6gUS4zgdMi9E9wv26uW9BOsUlMNQ+5nhjv4/Oj8vZqEFKYGTx7PIKTjy7GEcifFgXlYx3FMTq2l0OEq+h/3yDZ0LJRMmJIyfSX/sYgHCWTlIC4epF0x9aThZQmlf+7o+v7u8X6uVpmxFX4bXCmAaszPmJ5Zutp6y8ZITjtVcC3KGK/zbld1035RqId9kG0Mi7XpLT/6zGszOtGnxcLH905enluzbiV4emGK/YZjEdtZlhdQZDT7f8QAaj4T1wBNnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1086d530-b876-4ec3-2df9-08d8502d6c10
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 17:18:49.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJig0b5a5UKeZqDUxepCyeESXBXxTfNQyIC5a82F5mMdL7nvAz8gKcOREUCwD6NA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599153536; bh=wjWc+IIcXziz4xdShvvbh73CGUMpP2NZOkg+EZfLRVQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=et5dIY6aIjKB5vfn9eeG1BrPG0aYJtVuqreTt64bPz1Qm16/9Fd5wOP0NZtcWaQKg
         5pY51ALPHzxbWjMCkPa/l+JlsvGE+lY/5swQ9vPbPkmysuD6Mqz7yl/tapLOYehfbz
         SNE6gt/DRnTBKB79u9v+Lc2gCVcv+JIE72DtfXIy9TmVvzeX2fmb4qj2F+LIKBhScL
         wCnlLGxNFuUBuQG9QN0mvZxCQxW8GXcK9JD3+ZNXrEDBaUS226xX0GXmfawOOVT5AT
         OCQkbJpelRH3+nD04wzXeMswIC5WTFjnUy4W2+2fz2vlEFq77QETCGsjH3s3qLWcod
         /XM4LcNAM0pzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 06:01:57PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 03, 2020 at 01:50:51PM -0300, Jason Gunthorpe wrote:
> > At least from a RDMA NIC perspective I've heard from a lot of users
> > that higher order pages at the DMA level is giving big speed ups too.
> > 
> > It is basically the same dynamic as CPU TLB, except missing a 'TLB'
> > cache in a PCI-E device is dramatically more expensive to refill. With
> > 200G and soon 400G networking these misses are a growing problem.
> > 
> > With HPC nodes now pushing 1TB of actual physical RAM and single
> > applications basically using all of it, there is definately some
> > meaningful return - if pages can be reliably available.
> > 
> > At least for HPC where the node returns to an idle state after each
> > job and most of the 1TB memory becomes freed up again, it seems more
> > believable to me that a large cache of 1G pages could be available?
> 
> You may be interested in trying out my current THP patchset:
> 
> http://git.infradead.org/users/willy/pagecache.git
> 
> It doesn't allocate pages larger than PMD size, but it does allocate pages
> *up to* PMD size for the page cache which means that larger pages are
> easier to create as larger pages aren't fragmented all over the system.

Yeah, I saw that, it looks like a great direction.

> If someone wants to opportunistically allocate pages larger than PMD
> size, I've put some preliminary support in for that, but I've never
> tested any of it.  That's not my goal at the moment.
> 
> I'm not clear whether these HPC users primarily use page cache or
> anonymous memory (with O_DIRECT).  Probably a mixture.

There are defiantly HPC systems now that are filesystem-less - they
import data for computation from the network using things like blob
storage or some other kind of non-POSIX userspace based data storage
scheme.

Jason
