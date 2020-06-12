Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD94C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE13B2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="PKazNnre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFLTmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:42:13 -0400
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:50070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbgFLTmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:42:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYQgeM1rYJEDpLVNRcdbcufhvA487k5Lb7PDRGyMhj/kqscqiJyn6+E7yP9uBnFv8DTdootkbgV9rZS9HkyqofJ+eNzTriwMv2MNcnM6cHF4fsiCZLMtgzVWhg8alEEL4CYE9nijF3pEMOSNmsfu5LGuFaYbLExolNNyJwxhiUTvQAn0ljzcA2h/15Y/JGx9XiaLVzEvV+s38hpe4gu+a7IIMVefvOMAQetLHaS+eBcsLZyJ80sbWxteW2qufWiXvbyArM4+ymxK7Pxmmuofp+2IpzdcrgQaa9bHKOKCsMMt9QsFGWh8JdNvHW8vI+TKNXYyVriwAj/yDz6BR+r8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxnfKGk2mLU+hg+gZW4GRIXObNuTdVcfuRM4I9Rd4C0=;
 b=grykfotrxNoNRizQ4/MCRMAtSVKPwsJPhYeEl6VIRQHZ8dRw2VUWJeGTZaH80bjIemC6ncf/DGFnmo3gbRGlvpUaViJZqUFRW8CbVxC+Aph7+gZ883mAEtDHS0DGvdJeBynJZYV2srDB6bX3Zoe8EzDmYTYOw2QvCgPvAEMwMKsr8ZialYzpSmcH4mm8HFCoBUhlf6SHy7H5meuqcRz3ollRGkQ6yEhJW9aqayiByzdFvG8FwYhl8qHiMHtuKmB93i7LSgcvUuSzRZFzIf5+zbFd2/5xjpvSaxesjNlQh27rZpoGudfpA05nnyY4Uav/XbAXXxjRQqxmV2netp0uBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxnfKGk2mLU+hg+gZW4GRIXObNuTdVcfuRM4I9Rd4C0=;
 b=PKazNnredjuuCrQeBnKGMLxso976FvVGjJhy2ZegdhbX2i8O9LUkVa7uk6R11zxEVBkGstsQ8Bphb+z64ws/S4R1D96dYSC2BnXNbOnngW7YirfshiUH5SbUD7rZFBF9btxL/IjVeL3bzKa7Gky6M0jMhkhpSWqE867Cntv8nkY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6143.eurprd05.prod.outlook.com (2603:10a6:803:ed::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Fri, 12 Jun
 2020 19:42:08 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3088.023; Fri, 12 Jun 2020
 19:42:07 +0000
Date:   Fri, 12 Jun 2020 16:42:04 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/hmm: remove redundant check non_swap_entry()
Message-ID: <20200612194204.GM65026@mellanox.com>
References: <20200612192618.32579-1-rcampbell@nvidia.com>
 <20200612193524.GL8681@bombadil.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612193524.GL8681@bombadil.infradead.org>
X-ClientProxiedBy: MN2PR20CA0057.namprd20.prod.outlook.com
 (2603:10b6:208:235::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0057.namprd20.prod.outlook.com (2603:10b6:208:235::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Fri, 12 Jun 2020 19:42:07 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jjpYy-006luk-2m; Fri, 12 Jun 2020 16:42:04 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe65fb2a-96e3-4fc6-9113-08d80f08b0fa
X-MS-TrafficTypeDiagnostic: VI1PR05MB6143:
X-Microsoft-Antispam-PRVS: <VI1PR05MB614367A592570F2D36ECB232CF810@VI1PR05MB6143.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHYNpxl9tilXIWS7E+BW3qeLG9KcpNQcx2gQBqK4RrGuwaRsZsiVFcflUTdG2zObXiDmQ4ubg5/TNW8QK/9QijTozpp8rceGCdtg+LUl+XQjXFE4w7Em3u8WbPhPSAhvJAdvocUVPOtpRQPXBlsvORp80J0fVP81cfHkVbqJz8y6SLwI1EAUUAd0wI5Sd6DOyHZJlp9XsWZYN+kjbkr28zskDVLrD7Q4X6qGJGYzoHu/RzA4YCyroMIb8TSvOzY3SvpntY+T2JeLa/rg+5Ks8nTqDKdixC8yUz8QJxYKShLANyEMajY/+/ao0N1MuSSaDETzEkPjFKNT1CfDdqmr/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(4744005)(4326008)(1076003)(8936002)(33656002)(86362001)(8676002)(9746002)(9786002)(2906002)(6916009)(186003)(26005)(2616005)(478600001)(316002)(36756003)(66476007)(66556008)(54906003)(5660300002)(426003)(83380400001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1ecxqNkDqCW0FVS16nBRfn2rdjluUatgakOkLcAG5Iwo6QP22Gn5BxFrwBr/NWDHSgV2xJN6xrGBqhSqnKWOW4fWJxSnp/wJ0vRGPkAUK2D6YHvfqUEYKzT6YX7tJAf0dJxhIgXznGKF/cNvKG4odweAQJW2a0r7RD5ja5nRvlhKzuL5MvppUAAvI3lfNKpRayf+n+gJL2+lb/dtRaxweejvnT28QbporrVncObLVr6hZtI7662XcswpEVGm6TE8nwqZbjgdzjoxSjIEaskhLNh26i67yUq+WfcxqJKwZMP/PSnf2dq7aUo8bEMyfy+aANYPjYjYqSg6gzL1xAxxJfnRSVWfZQZe9PQaqKK0p27WDNCeOy8C0vb2QBH45/DJ4r4L3gm1TVI2Fq2yQoFu1lwbvqMksf5m6hihfZcfIw57yizO8s0n3N7phPQL+2vdaWqYfiD+WGyfP+PZSiTUm5+De07OsBncViVL37EPMdo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe65fb2a-96e3-4fc6-9113-08d80f08b0fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 19:42:07.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGwGovo3aU2OAa+r0ivvuz1q4oxnQCkGbbr8TLUkgcjP0fZbqx9/dmUvOMlIAgUBs03QKM5R+a9IHmLJZl267Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:35:24PM -0700, Matthew Wilcox wrote:
> On Fri, Jun 12, 2020 at 12:26:18PM -0700, Ralph Campbell wrote:
> > In zap_pte_range(), the check for non_swap_entry() and
> > is_device_private_entry() is redundant since the latter is a subset of the
> > former. Remove the redundant check to simplify the code and for clarity.
> 
> That is highly configuration dependent.
> 
> #else /* CONFIG_DEVICE_PRIVATE */
> ...
> static inline bool is_device_private_entry(swp_entry_t entry)
> {
>         return false;
> }

The commit message might be a bit confusing, as it is not a subset, I
would say that device_private_entry alone is sufficient to tell if the
entry is private or not.

For the !CONFIG_DEVICE_PRIVATE case having it wired to false is
right.

Jason
