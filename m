Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0286DC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C217520866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D5ZBL0Tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgHaSCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:02:37 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1178 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgHaSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:02:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d3b100000>; Mon, 31 Aug 2020 11:01:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 11:02:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 31 Aug 2020 11:02:05 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 18:02:05 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 18:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awDCStwFRaEFV3zfFL8tQWdrM161pOJXbs6xmWjBATxV+edQiIhiwss+bB7R3J8DUctSbCqMZ0h6HOOdMIJPL0ZmRUNXP/GPSKhFDTQxvUKnTjypUfbrtQPApr8wQicxS42uRETJ2rE6eFcLgIj1i83Wgizz12cpadcXPbmYsS4KAqmWpTtrO/nfQ1nUe0g47rBjyYzCT3NgvJcyVlZlfkF+50yMv8j+AHbou86PYsMPlJFLDXoKM2CAkBgO/1/c8xZMGbeAmdpIOwSnfzIe/9UMw7Ip3JRvJLqKwkBNnKACjuhpbQRRU+DbRzznq9du+QHEcRcy3qKhvdDrHAQPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE86GRDyN4fe1es70D51bGg6jLt1d9ksKLMJxHh2qvg=;
 b=Ev9G2Zh6V7EIHJ/dAXWYnYuGC4PXlir4q39DS+1XSXs3vAmj6a5rBw/QYqy8nhnB3Z0GSI5yELwG3wdVw1PQdE1ze50jFV0X+g5srV1HQxZtM/tqzh0/RAL5eOMGG1Ku8axzXAMEk+ZapXQ84C01Qn9QWDek8w4SPdRKcuhO7Oa5QtbPLEMPvv1RZDe2bwC4SnrJ2x2686VvWu0D3xkwAAr9eeNjAViALCkyhz0T4FuZ2P7nX/82kQIkO/AStsey+xh1E+bWCTl0nAANo7+aSEkKa2RBOcfdgLbsFSnqnCgmiYE97FYhWjBWUaeXVVbpvC9OxOxJD2jEenMSZMJaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 18:02:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:02:04 +0000
Date:   Mon, 31 Aug 2020 15:02:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] nouveau: fix the start/end range for migration
Message-ID: <20200831180202.GF1152540@nvidia.com>
References: <20200827213744.14074-1-rcampbell@nvidia.com>
 <20200831115117.GU1152540@nvidia.com>
 <017b1e81-7e6d-b2cb-785c-aef88e466701@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <017b1e81-7e6d-b2cb-785c-aef88e466701@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:23a::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 18:02:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kCo82-0032bK-LI; Mon, 31 Aug 2020 15:02:02 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f07722-badd-4d9d-38f8-08d84dd7f7a4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485D9FC2A06E0278E7A145AC2510@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7n/8itUNc4pIFL7XsZ97oc5PuiOi7GP+8fJ6aquyJBYkaEE+lY2TP5Eo+J5Zu/3lAmHnY29FV0mz5E3B3bPm5Psb4+UqvvWs80rXlJIgoEP7WgQY1HbktrYVkr6DtCJft3S4uYKGxKTr7ERTKUIp2qTzRDN2y8thmlREkESee3vBZz5Tys2dK7ais8B2nBNbO2c7m06zxsjKzdeYlWzyvCntdXdl9h+dewHoxoP4vXGskvmJsqK7kx522Jbga1PaIdYdYmfuW8AziPuA+GQHzdLyRcJtpEqqfuKkslftqWmcfOEC6lXi7/k7SRFK8KUu4aKhfB9rDGzRg8eTtw1jbnQNlsZfe2bmfj4O+e9x0h3QCeBkQlAD3T9W4qBRhUUCAYWDah0ITz04zpzCSbkOrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(6862004)(26005)(2616005)(966005)(86362001)(186003)(53546011)(478600001)(2906002)(426003)(36756003)(6636002)(9746002)(9786002)(83380400001)(33656002)(316002)(4326008)(54906003)(37006003)(8676002)(66476007)(66556008)(66946007)(8936002)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oq1c57DzVcpu1/SpFjQ2E0rCN84IQWXTa9Ehd8FWqX7YmG7Rp3T9s3ts7fgRCI5zlS5KI8fgAOHVhmlqiyC+jIoM/R/KNhpSwI7zCmJW5wUGgrASKlTSsUQ8JvkvkVGiUB/XNdh+OAIUxyUs6qVxSsLtrpti87f4i3HFGMrZ4ciWRKT6U1IZcd8K1DbNxa58TIEClmBnioVKVE6KjzftxwwzCRM4LU4sIU255lq8qih/yQTlOgjvp8bLq2ohYgLi3FfMg2WIi6oZZd41m3Lmb0SRdgCRNjlL7jmos0zzjsHS3CMduqvB6pPN/LNJIws1WExNIbp41X2xhPets1thsoUS0s4iz15h0zULbTzjR222sc/hJbnH6L4VwjDMtZBa5/MXMYdUPPkyFiN7dKUWhQnFFkL5R8oBwMkfDW3BTa5v+lvQfxDfagGhQntXhFA+M+DYzu6rXReF5DI2du6FwT0MzatDzzGx44iTAK+VUGA0BoydjbeXTIjRJANTaimJFAUc0tjh76lsj3i1/ZjckEmiE3ZHKQi+3KBBnxIcJMpi6yQZr9NG52Bu88ppkrmdE980wYS5tskpWGe3GRXex0rVuZtphnGPbZA/Ou1WFLMjalCPM3BYkHqlxmvCuoDbShohdEo/YKxSMHBxVyQQww==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f07722-badd-4d9d-38f8-08d84dd7f7a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:02:04.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA7QXRG4F9n1uSVmLmhqxEaOXUNbJhwbRncVbiNxY+5QFUtBUwjozTZ4zDLK0Ghi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598896912; bh=qE86GRDyN4fe1es70D51bGg6jLt1d9ksKLMJxHh2qvg=;
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
        b=D5ZBL0TfOy9K3b/0uo4oesgbpUNO4cEjzbOrIAb9gZD4B3uUUzAbg+9PKfD8/8MQf
         V/RIL0p3SnUGoME6v0o1Y1mJ3eDQBK2FSeG5Msbj7/3DWK7i7OGFXXxWvk+GMhVcGp
         OhRwaYgY3VQYjy95buksjL0WvGm5n46VXe21qcwtz3KlTMfJFK42FpSgKFg0Mhwpki
         orrUWcy15PkT857E8XRghNjBjUgBiM6c9IiM6ZNwS2ItNHUUuajJUtWqfTYD1bc+6Z
         FNo6IZo7qEaTQ+ss7jRcMLxByt7t9ncJc6NyLKCmAPJwkzN8jYbKkFCNcdVeqU/pTp
         jF1S4zeRV0AFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:21:41AM -0700, Ralph Campbell wrote:
> 
> On 8/31/20 4:51 AM, Jason Gunthorpe wrote:
> > On Thu, Aug 27, 2020 at 02:37:44PM -0700, Ralph Campbell wrote:
> > > The user level OpenCL code shouldn't have to align start and end
> > > addresses to a page boundary. That is better handled in the nouveau
> > > driver. The npages field is also redundant since it can be computed
> > > from the start and end addresses.
> > > 
> > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > 
> > > This is for Ben Skegg's nouveau tree.
> > > 
> > > I have been working with Karol Herbst on the OpenCL mesa changes for
> > > nouveau which will be merged upstream soon.
> > > With or without those changes, the user visible effect of this patch
> > > only extends the range by one page (round up vs. round down to page
> > > boundary).
> > > 
> > >   drivers/gpu/drm/nouveau/nouveau_svm.c | 17 ++++++-----------
> > >   1 file changed, 6 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > > index 2df1c0460559..888aa0908c5a 100644
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > > @@ -105,11 +105,14 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
> > >   	struct nouveau_cli *cli = nouveau_cli(file_priv);
> > >   	struct drm_nouveau_svm_bind *args = data;
> > >   	unsigned target, cmd, priority;
> > > -	unsigned long addr, end, size;
> > > +	unsigned long addr, end;
> > >   	struct mm_struct *mm;
> > >   	args->va_start &= PAGE_MASK;
> > > -	args->va_end &= PAGE_MASK;
> > > +	args->va_end = ALIGN(args->va_end, PAGE_SIZE);
> > > +	/* If no end address is given, assume a single page. */
> > > +	if (args->va_end == 0)
> > > +		args->va_end = args->va_start + PAGE_SIZE;
> > 
> > That is really weird, how is it useful for the kernel to map a region
> > of unknown size and alignment to the GPU?
> > 
> > Jason
> 
> I agree it is somewhat weird. The OpenCL 2.2 specification says that
> clEnqueueSVMMigrateMem() takes an array of pointers and sizes (in bytes)
> but the size is optional. There is no alignment required.
> This "works" because the pointers have to be allocated with clSVMAlloc()
> and presumably, the implementation for clSVMAlloc()
> keeps track of the length allocated and can fill that in if size is zero.
> However, requiring all allocations to be made with clSVMAlloc() defeats the
> goal of being able to use regular malloc() and mmap() allocations for OpenCL
> implementations that support fine-grained system allocations.
> (See https://github.com/KhronosGroup/OpenCL-Docs/issues/392)
> 
> So if the size isn't specified, the most logical choices are do nothing and
> return OK, return an error, or assume that at least one byte is being migrated
> and try migrate it.

So if the app migrates the wrong memory then nothing bad happens, it
just might not get the performance from migration? Seems find but
really weird.

Jason
