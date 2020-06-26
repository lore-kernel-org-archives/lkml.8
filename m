Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D7EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BA1207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="SjlIfH1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgFZRov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:44:51 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:12430
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbgFZRou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:44:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd2vW1v2CeqWRS/sjYHbisep2dsmDD5zvJ9H06O103omsLz/JVTmgA1uZZdyKhRh/0M8Wxt2AXz3srEaJKKSADN3xw8EXUlLjdnoQv3yljSdHNjdjtymxklfqid5tSWI1rE4rYuJMBnVMuWzVgHvppBPTVJoDmvoaWaubtKD+1IMF+aJDzP4ts4zV/moIO3gKMxBhHMuzfHblwx1OCsK3csQ+3Wbo3xpOy9THFCN8Ud5Oh5d923p4BGyajFPc3ifCEE7GodXIRbJonAPNJ08tXGj+QZ4ewEk/fHQkUDtOiq94u3bFG5PHmKGa9osa5V0Nq7iOEubKMTSgfnMk4LiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuWF8a09+r4aAsqWSVkHcJffIDItDtF1j9oUEd4gm3w=;
 b=j4ri6y0j4m77Pl7DnKanUgHTi0tppvZpqdO/9XEDs0cipLjR1HUN0ROjtgjYSeWh/ReZJKgvAmEvocLO7ANImkbGkGJXGajyJgU3mQoAVH+oB3GsoOjQTNOEP/Y8xsierq0NvvTYFFTTR6Xt3HzdqB24TjCXnSr2JDQWgulPSJnbJpUXT5SiuZ6YCNn9dHjZMwG/zIkNIio60nZM7sumhwdwHfAFuwQ9nh0yb7I0LhyV56gjjnRWhHf6NIk3SCDJQR3oKlX81mXWL0uMny8lQNAwJnPsUHQhEwz4LAvPQFgED9PKeLkaR40gNLxG0w5AJGnX9rIJIcN9yYBTtkHm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuWF8a09+r4aAsqWSVkHcJffIDItDtF1j9oUEd4gm3w=;
 b=SjlIfH1D3ki4WK8jNOyJS0SXHFum4ni8X8YOjIpNg3PbK7sYbjv4qi+eKNLh83OhlF2d+xfD8REaeZMlO3kxlqdMgK2whB4R1VYVDP/AYdzz5rXrtpfw73Tewm0Obzn9gsi6S4NzcbDf+AaWuYQx2w2R+IWZXrGi4aqJjvi5ur4=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR0502MB3952.eurprd05.prod.outlook.com (2603:10a6:803:23::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 17:44:46 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3131.020; Fri, 26 Jun 2020
 17:44:46 +0000
Date:   Fri, 26 Jun 2020 14:44:37 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] nouveau: fix page fault on device private memory
Message-ID: <20200626174437.GD23821@mellanox.com>
References: <20200626172626.19207-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626172626.19207-1-rcampbell@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 17:44:46 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1josOz-000CDi-47; Fri, 26 Jun 2020 14:44:37 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc045b89-bd08-49fc-2aca-08d819f89da6
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3952:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB3952F617D08583C8F582CE1ACF930@VI1PR0502MB3952.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbTkcA26ThGsRJQ9327uechon7CeRXEwoB3Hc1QRa36Xu9pHzIEA6tLN6FdD9TvM4QPIh0yfSmVlxUFrV7t+I7Ijdng5MyaMFnJxubKFU5faE0+Aa8/cIl32toGrqWWqLZuPPYeUf5O+Er2/3XVQRcyAcKtlAOzBQ+IIQ2JqW8DVqAP3VRBsDEyqu00YlcwaWaB3iaSyYBBr+/4MjS45OzYyfoGcLVCgvVEWePMq0pt3DVZMWwDf1JgqLDOrK7d06HYnm6TPeUzXnRGitX9u9zjKUvnBCCeTTHlwewdEPBaLD3EugYDMhOoAO1FpMPBnd/bBA2qxtWSP0Fa293z2sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(1076003)(33656002)(5660300002)(186003)(8936002)(316002)(54906003)(426003)(9746002)(9786002)(8676002)(83380400001)(36756003)(2616005)(4326008)(478600001)(2906002)(6916009)(26005)(86362001)(66556008)(66476007)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1IRK14b/81P07ItXzkHWDjvy0M4n9WE2rA0W3BzR9P4dvUJnV6vDdaYNLp/OXtkBaXUmWJr+Ko4w+AFIMjd2TNJc5BCChttBN1oqSLi5dJfE3sSKrYhKnjcR1W5daqvPdiuo32mrv+gREEcX9/xRzxnoyXCkAtSAr2ZzsEtkzMltvqbXCXZ5N4bsLSW+xruP/cAvsFMkedteJLoERhAgQf7hXXIJSojsGhqR1kN4IjXS4UwLuzBRJTfIZYXizRm8DinI9OFltmeNPO9YDlk7oD3jvPoxsxw/gz/3dhBNKzkZRvsYI+sHGm7SfCJAlj7u/u9tsXMNrljo3iYrIDVyv2TdyPTTx/nQOpi7mx0sil/i30DtxpWDBegYE0a/YxLIptNT3Z9satL9BRnez3QuJsQ0duItsD8LEfN/PlEgMh5h2Aq9TJQPl5rUskPyEDeslcolSTPeCozKVvEx8DuWJRrney2/sB0NRk9STPdBBKxGeDC0ePQIU5hKGNs40u0B
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc045b89-bd08-49fc-2aca-08d819f89da6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 17:44:46.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8SSWib8rQjBSX8t3SD2c7YaAgPxLpiVxDrYR2p3EnT37TMMJltiJkomkryi1hDaqQjCFfiJfw5tArQm23igew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 10:26:26AM -0700, Ralph Campbell wrote:
> If system memory is migrated to device private memory and no GPU MMU
> page table entry exists, the GPU will fault and call hmm_range_fault()
> to get the PFN for the page. Since the .dev_private_owner pointer in
> struct hmm_range is not set, hmm_range_fault returns an error which
> results in the GPU program stopping with a fatal fault.
> Fix this by setting .dev_private_owner appropriately.
> 
> Fixes: 08ddddda667b ("mm/hmm: check the device private page owner in hmm_range_fault()")
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
> 
> This is based on Linux-5.8.0-rc2 and is for Ben Skeggs nouveau tree.
> It doesn't depend on any of the other nouveau/HMM changes I have
> recently posted.

Makes sense to me

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
