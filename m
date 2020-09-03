Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A5C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DF920716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EG9FdAIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgICQvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:51:09 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:39759 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgICQvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:51:01 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f511ef20000>; Fri, 04 Sep 2020 00:50:58 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 09:50:58 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 03 Sep 2020 09:50:58 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 16:50:55 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 16:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNnxq3yXu9krli7FkarX4JaDjfv36gsk+GnuJXZ/Ap84Sze5lyQxvu952XbyqeFz4ABpiLng4LamxMAWQG67MJR+6NNNR8rjFLi7QAEBebpZMfkdApBLFSlsfXzPpJvArPgYRstWqq/6T6SClvy//na9XT3VjmGjd+8cBKGCgO1bnBeREpjBXI5U8AdffmJe0y16ZuF6S6uhXkOThIgHqbSGrmh3UHNw8Chs8FytaONaPYV/m/zz/pJUz12bxTSSWGDx6OORvAO7Ol4cBBl9LxouEedktqCgTD69TX71zKJbt7+yjCvKNsvXY/qbLh8JwZgaHY2S7q+fFENvAZx2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAqB/F7YFynuW/Opn3oKNGc751GDqu4WIOi0AQX8QDQ=;
 b=cM1lGLjv2+MUS7HBh0MPXF1sDRy2Sjo8rhPrg3GdIIqH+HYbIFXGHh80Z3mkQQ8Ve++lxvcYTxzF3fBFV5wfMsfjrFTyxsEuoQQsTzCGtScBTVMNQYxfAc1rkvp043Z124BxIpTgcdkJwXQ7a58TLlsPbUPGTehU28KKlPF2cuRRVqEMYsFd4pjTiFWYrUfbekDXNITLV89Utp7PFqbCOR1XIQ5Ivs1q+tGrrfSjaz/2xX0hsrYOWSgaMmmiV0Q2zya7Wei16XSvkHJh+fHV5I7DvnS76UjaPbqERLu6KEtLI5c1tJZVNeb8uTOMxWMfca7AjFdbMWxELBeqceBFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Thu, 3 Sep
 2020 16:50:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 16:50:53 +0000
Date:   Thu, 3 Sep 2020 13:50:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Roman Gushchin <guro@fb.com>
CC:     Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903165051.GN24045@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
X-ClientProxiedBy: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR0102CA0007.prod.exchangelabs.com (2603:10b6:207:18::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 16:50:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDsRn-006cqK-F0; Thu, 03 Sep 2020 13:50:51 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae91dc40-94a1-453f-4e7d-08d850298563
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4483FE1B68A4DB97CB9E182DC22C0@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eic8y0lNbklrNx7MzUawSUDvvjlE+fViJbbPWbtaO/FXRP4B3bRZyKD7V3yY/u0cUNlbQhrsLht3sYFHaPrMIanr2/A031O+zYIeDRpTyRsXkP62f6ZzznOpLvbY4wim88o+POM8wGeMDJyFeTg4rq9heNJZey464kshNUtxypPyT0rpdnLH86s1Bu0xf9ZBzrgZbkRz8y1OSyRkyrojoaHaBE8XczQcB9KTikLnqSaivpHi4pbaBUHY073jQzoMKtKonGyv8gIY9AXpmBwlzDhhBJLiime5FwBo/3cdePIRo8MoZNd2M+1951klqnMeaqUY1t01pY2E0GDmOiL/Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(8676002)(66476007)(9686003)(5660300002)(478600001)(9746002)(86362001)(83380400001)(6916009)(8936002)(36756003)(9786002)(316002)(54906003)(426003)(66556008)(26005)(1076003)(2906002)(186003)(4326008)(33656002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: q25V+VviRFs2Sq3EAnOfv4cWq9WFfp9ZQ71IMI22hX8izeF5cNlFGwl+tPOslTC7aXoi+9y394VLodoZ2LCvIzTPK/shwcQ4wCNFBFnB/W7/YcB85LynNK4QnJwFkGeCjPcTU5mYrSAzg2Vm535cUiVZOOSzDDbShFtUE5Gl6VoVifiihH4OovZgiXGmnQKq6eMU36rQQC/eTMJPaT28825hB6IVW2PO6DzgsnVebdRt6g2pbU1yTu4shtxNmLt3SgrgguHUQ6SiJ8UFZXmYBEJ5et41n0Auxu7LZilCqhxqk0913UcvVekXLmfNZJG1XKbP+gYD9WbPr9t7V6kzME9wIwbEzPIKqG4mnAEM93LZVo1B3VKT4/x1BRJhcVEZnl9tioQkEMKjDrEeMhXgFHMSxlivzHc6DYY5KoebmtMZGfPKDoh6gvYu+CID9vwUe0ulS/3JI6K5UGmkMUR/e/txWM4ILka8nnvrMgRuAxqtB5jMxaBaIzHoK/wuzMckwdS5dV46/Zi3yvRHM4AegV49EDIsBWgU0xtJXKI5PMnMQ6ejlv+ZCubdyTZ59TVEH1gTQL/3UQXT+DvLj/Rv7QhnNdFz2ZkNrGgZNZ2lyPFk39mGR2x0QshSoodxGk61aEbliLGm2H3lg3vSPtAouQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae91dc40-94a1-453f-4e7d-08d850298563
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:50:53.6763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbIcmPgetJVZSKy9790CuL0FhpUi+lQu447zYJG3+DtkXm9RSoHXjECy5cafyrZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599151858; bh=VAqB/F7YFynuW/Opn3oKNGc751GDqu4WIOi0AQX8QDQ=;
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
        b=EG9FdAIsQQhHGQGqm0EsHLa4rQAYDH1VJuMdHNXk4RI4ihNmNrtr3hhFbLM1hYINm
         XWSD+QmSky1NMEyHXL1heeRBZHGeWuPt5ZIHTSSMdfAOpam2aRfpsiNX50myAQleVf
         s/EVvp7BWdVCaEgC3T9KgmOsONGLU8X4//qAXinrNaDQVxD/dgvXkMUpgBz3F7koRV
         u9LFkPkagJcI7X+32oVn8kA3A7rmt1eRgm6CtKGoZoC8dIGcNHUI0BC7KeMQIft2UF
         3HriNCySylPu/8erDCHjd2BoFnuswKP1pIDRne2g4hStjzja7YymxJ1owsvB4O8MtT
         c7HvO12/zWTdw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:25:27AM -0700, Roman Gushchin wrote:
> On Thu, Sep 03, 2020 at 09:32:54AM +0200, Michal Hocko wrote:
> > On Wed 02-09-20 14:06:12, Zi Yan wrote:
> > > From: Zi Yan <ziy@nvidia.com>
> > > 
> > > Hi all,
> > > 
> > > This patchset adds support for 1GB THP on x86_64. It is on top of
> > > v5.9-rc2-mmots-2020-08-25-21-13.
> > > 
> > > 1GB THP is more flexible for reducing translation overhead and increasing the
> > > performance of applications with large memory footprint without application
> > > changes compared to hugetlb.
> > 
> > Please be more specific about usecases. This better have some strong
> > ones because THP code is complex enough already to add on top solely
> > based on a generic TLB pressure easing.
> 
> Hello, Michal!
> 
> We at Facebook are using 1 GB hugetlbfs pages and are getting noticeable
> performance wins on some workloads.

At least from a RDMA NIC perspective I've heard from a lot of users
that higher order pages at the DMA level is giving big speed ups too.

It is basically the same dynamic as CPU TLB, except missing a 'TLB'
cache in a PCI-E device is dramatically more expensive to refill. With
200G and soon 400G networking these misses are a growing problem.

With HPC nodes now pushing 1TB of actual physical RAM and single
applications basically using all of it, there is definately some
meaningful return - if pages can be reliably available.

At least for HPC where the node returns to an idle state after each
job and most of the 1TB memory becomes freed up again, it seems more
believable to me that a large cache of 1G pages could be available?

Even triggering some kind of cleaner between jobs to defragment could
be a reasonable approach..

Jason
