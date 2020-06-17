Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8589C20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="FhcSa6gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgFQMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:07:13 -0400
Received: from mail-am6eur05on2041.outbound.protection.outlook.com ([40.107.22.41]:37846
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgFQMHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4Cb7sK8674v++VeQ6E5x/037ryf8mA0SDzO2auKc1lRU+b2jz4iR5EkqIGLm2iodcSdfg6824igipSVRC7kXxKu/FVHleJMZN/hQkq3MxSh7/SJXVL2BJF1+tBrfrRXXy8tUDru994Uvp24cx4fZLg6vt7f3ivMk3yRRzMHLStWdfmkW461pn8zduUgvPUUTbC20NCYbxNPY8y3HvUdQafkFwsONaMgWFrfG/XcnPTY+DDXWbja4r0mjc2mX9lDGQgOqP6N9MlYK26SZkHFT7Wcy0bdwnKtf0n1/rrcroTt84TYzFKESlCBSY5MFONjF+6tFiu+PSLGaFuu8HMGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUpQo2bmXChTBavvmOmz9gNb8HGim8Hsfcstcbf+lEA=;
 b=lhl/nxR5TSl9Z6QUm5d1Hch+y9H5w4BrcloxKIo91/iNQMB460tSJx3tIzu4LcTu2qyOIrDOJXH8eQWy0hqtudLs3A8chVTNnwvEgGbhaB+0EgTUERqaurNfTEUTL4rE/+gjxVZO4CSAySNdJIf5QMHJ3mUEGpIX3LI3Jx1L0iK+jBFJyCZMGuCHiq7PM/+uZg7Ba9ssHZ9bV5tb329U8czMXgI1EG9POMi/h9HtQr7rpvt1sD6FF34tfPDE2aNSIH71aEJz6XjnqK6Usz2sUgUFsxlgJoABGlUoLZYktuT2slty3fadx1SvW+msIH+PIFFO3F6s48MnjMyQg1bQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUpQo2bmXChTBavvmOmz9gNb8HGim8Hsfcstcbf+lEA=;
 b=FhcSa6gu76ncEe3hDtp8ByI0YGitfRK/955PFJfqTxj39DU2a5nfIx0M3UiEaexDsDPr3gY8dqr99zl7A5P3Uu+i28Jo1HmY09eetAsxP310pYQl/67B08IdxSwIqGVWa3v2oyGeiLJpb46lkfG4JlSNL+bGDNJsRV6ntsr8f/I=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5615.eurprd05.prod.outlook.com (2603:10a6:803:95::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 17 Jun
 2020 12:07:08 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 12:07:08 +0000
Date:   Wed, 17 Jun 2020 09:07:03 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: drivers/infiniband/hw/mlx5/qp.c:2904:3: note: in expansion of
 macro 'mlx5_ib_dbg'
Message-ID: <20200617120703.GK65026@mellanox.com>
References: <202006171658.Tch2yIfU%lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006171658.Tch2yIfU%lkp@intel.com>
X-ClientProxiedBy: MN2PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:208:e8::48) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (216.156.69.42) by MN2PR20CA0035.namprd20.prod.outlook.com (2603:10b6:208:e8::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22 via Frontend Transport; Wed, 17 Jun 2020 12:07:07 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jlWqN-009YAm-0W; Wed, 17 Jun 2020 09:07:03 -0300
X-Originating-IP: [216.156.69.42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dddbaab0-be7a-4803-3ded-08d812b6f4ef
X-MS-TrafficTypeDiagnostic: VI1PR05MB5615:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB56151A4E531870CFF85C5A8BCF9A0@VI1PR05MB5615.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJgbywlT2hudk5lU0a/SUHrdWuP3WKpOfINVp+q2WrCXnReNP6LvVqM6mGMplXApv10s3q0ayDstHJb2is4S0PqdCA3U2CnG3FsLXb2+/zGdgMyxt7e0qcZBlX/tF2692tEmRnH41CkPfYyBZDX+1PKPN2LtYJYvFsxikzQOJZ8ScyiQ1KAN5qADTLaHGvhUOVs67v0bLKcbXTlKxvn+hLeyAbgBqfKoO5z5aWOGyN9cgCb8bZXAkk2NrnGBVClyyW+zM45DAyKsqenYft0Qstbh9vO0bnAYMOwYxo/pAeBXS0JOSm9vU0qjzsRdad2/4PUK8TKPngrXQTttUvpWTTymkn0mxZGzY6HxoTmasqjbpkOmcIt5F13jjz3BpQhlzOTR3QDh4njGRGPiF2Eutw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(86362001)(186003)(478600001)(1076003)(26005)(2906002)(9746002)(966005)(5660300002)(107886003)(6916009)(4326008)(9786002)(54906003)(8676002)(316002)(66476007)(2616005)(33656002)(66946007)(66556008)(426003)(36756003)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kHqY8h0R+E63b3FBCEscyY2HuK589QEsWKLOa6ES1eBIiVBMCPI7nxk1EO+FUy8X1ui/wvdGxSh3neOahrlDfyRRnfaJT+h5Du7rlBsPwCXcqEqS1TAdjZxKZO7UJm8iBQTIESKeXE/llma9Kc91KF24oibP8OOX0BqgmpzncuizMzC79v2gB+4s8HsTBUONe0MKbIwehMxefSwB5WrqDhdNS5qyNHgy8gFLRUXPP5GjX7EG2M1NGbG3d4RmDu/KA2jnGUsX3UW170z+yMH+DC0It3L447dxm6h8IAbDeH7KrCIyleD7PfZ2z1cwA+g3zPmHRFFDULNnW8SdlwKxfqntfDbl5VhuIqGA+QUEb2C5OWE6Z3UWZHyiY7KNaPFJ2FkIRyD9BH8OBaWSNsvORgH/byKQFpYbDJ4UgxzGzzCwPMCakStt4LEo9YUneKWYZ7BF+uFzZ1wXkeDdXPE6noOz7GI8dpn3jIxK+xPC+B3heSY5C1XAJlOCWoHovZFl
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddbaab0-be7a-4803-3ded-08d812b6f4ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 12:07:08.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sveldZxm2Tusu9F0b5EjV953xvP7WuSemv3XSRL6OBHjTVcTj1/IEl3pFGaSi3AqN+Q53efyP8iA29ByeiYdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 04:52:02PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   69119673bd50b176ded34032fadd41530fb5af21
> commit: e383085c24255821e79d3c2aa6302d804b6a1c48 RDMA/mlx5: Set ECE options during QP create
> date:   3 weeks ago
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout e383085c24255821e79d3c2aa6302d804b6a1c48
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I think this should be fixed by:

commit 4f5747cf8e5947479a27a3597829e45d6d8d73e0
Author: Tom Seewald <tseewald@gmail.com>
Date:   Thu Jun 4 21:30:12 2020 -0500

    RDMA/mlx5: Fix -Wformat warning in check_ucmd_data()
    
    Variables of type size_t should use %zu rather than %lu [1]. The variables
    "inlen", "ucmd", "last", and "size" are all size_t, so use the correct
    format specifiers.
    
    [1] https://www.kernel.org/doc/html/latest/core-api/printk-formats.html
    
    Fixes: e383085c2425 ("RDMA/mlx5: Set ECE options during QP create")
    Link: https://lore.kernel.org/r/20200605023012.9527-1-tseewald@gmail.com
    Signed-off-by: Tom Seewald <tseewald@gmail.com>
    Acked-by: Leon Romanovsky <leonro@mellanox.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>


Jason
