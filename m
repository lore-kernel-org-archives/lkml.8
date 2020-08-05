Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03A2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797A2206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="GZWcs1ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHETWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgHERlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:41:44 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E0C00868F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 07:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiDie8iMgDVSZMkypb7jGbuEFzDOHhp5CkgeRLnrucHe7HMTS817+IWdSoesHmCohZ7ICsVNNNj5U5fzCZca0GINdQYWO4v2ZuvOz2G3pW2Q1vSoo2u58J2oPVotfBjnT19uVSz6fv5yZTtmKNBcKRTfErImOtz3bLKSoJSIhrbzL5J0P3F3MX2SwtH1N44752K5v2VX4/JbIcFDW0xWK5ULaE3EhTduZJKVKqkr0CqqO31X4AmBDnGfZU995yvrGOmmwp+TBkcLDWP6Oe/3YD8whDlpN4SkmasYcQ158gtX8xiEuSUjy+WEAhTH7V5IWghiDrVkUZIJkc8+2+M9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38P1+8Wj++ZXd/0l2FcpiXGMBkjIi4kdquP4AO7WzT8=;
 b=By0B3Hvpsojb+PLwUR4NB1QqQaAXjk4RsnKD1pwuFW2t13lSJpBb2RT5ljEtxF9ZveG6tTQaYlB8pMuRh5B2btDyQstJ+8MjxRCxpqXE1kevJ6Vw1GYkwDt55kcE+GvedUK2UBj0rWXSk7h/mbIhewgdo1PaOYFqqM5Y03KChY70KMY3jKhAbI87Ctszrc03M9VH/CSxo8BS05mtWBdaNzGXQvAewLSRt6apP880JXjYr2CGh7gBgFfziy02JMftx2/WPdE0HgZVmIsTUz2UH6BFEOfQL22fz+oIOPFHbucMTsGft6J3JaAWXV041v6RTATKtLM2KR3+W4ejYqMDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38P1+8Wj++ZXd/0l2FcpiXGMBkjIi4kdquP4AO7WzT8=;
 b=GZWcs1ceO+D3CCDWgo0kuLYSZ/yR+p6wxJCKDvJnELwNsEFsLVnFPHIFl8q138oh7sBpmXErY3yBSJqCLKtGKbpC6wJKRAjEp//y3sKKZCPSshQmSb31zfBk3euvrizo5Kwkh7DjAARCawjxtAh/6TYSPs4OnNt38pOSyCspZCU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB5842.eurprd05.prod.outlook.com (2603:10a6:208:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 5 Aug
 2020 12:40:58 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 12:40:58 +0000
Date:   Wed, 5 Aug 2020 15:40:54 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200805075856-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR04CA0078.eurprd04.prod.outlook.com
 (2603:10a6:208:be::19) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR04CA0078.eurprd04.prod.outlook.com (2603:10a6:208:be::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Wed, 5 Aug 2020 12:40:57 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6977c333-679f-42f1-bd1e-08d8393ccd60
X-MS-TrafficTypeDiagnostic: AM0PR05MB5842:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5842E71BCD2D5F97AA25455FC54B0@AM0PR05MB5842.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TK66kkMtUwKNPXZY0WiwUvUSrbSfBNGolKHvxqOnzxQ6x9g8Mye+sToa7e54K9gPP8nPrWzb/R2n3kE1HOMVIJ0awivs96HpTkL4f8jmMPnxlIX0HRbD2TNlBcX/8gQ+/es0IUQjgYncVlaTAnyRrXtnkwqiSxTMC3Cq2eXL/i5SXvgr7Ij+Uv31wUnKVgVUTA8r5muDdnsNHrGfDK/0FaA2826kIu7O2yiP3OFRqZfN1YAOP6dAj9LeEYkcz32pOwQWtRaDPKF9FCWYOPr5flO6tO9wnnb51GGmnJhtjme587/lIsXxjNsND8Z6yfxJD0jUiBFP8yef4PjcOEANiEG2sSvTDEVbB1eQa3ZTlo0uPeKVUDEXBRzcVLxSqzVn+TX+hbezs9sIf0bykVWy8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(5660300002)(83380400001)(66476007)(956004)(9686003)(6666004)(66556008)(1076003)(66946007)(30864003)(55016002)(86362001)(186003)(8936002)(52116002)(966005)(2906002)(8676002)(316002)(33656002)(26005)(7696005)(478600001)(6916009)(107886003)(6506007)(16526019)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yO8vFvQFkFyCLILrQiI7GG7fXSTA7khyxLhub2Lu8nJJ9MBW8I2BfC/GJA3su/MTfiN8MXzZCHSc1ymA0F9XYJhaFmyetZ0i3wwQUNyPY14GTIIwzejP4TBXjteSrU8c76KWuwDiSBjgcHZHMc8G22phgZ827ruHtVQAEfTEp6nKrQpiL+7B49njlL6v07ezSmtcDELnbJkBRM7v0+UaAlO1CvpFlogXrU9hgkZ3w8mRIlwKl35RkFOdpWPVbuDM3dTbWHGcMvxz7iohW/a1tdjQF+uGBDKOygqueUVO3L75SsTktWH0i1Cd+nzSfRKryirG0xlTW6IjX0yvgRN0COmusj+GAPZahPe2xPp/wBuGsR8LoQB59+X2a2TNe+y6lMIiVkAlPGw2T4GbxQRBXuxriYR1hR+6zqTzy6CuFirsbcsOmpfFTex5wBYSXH4Z5+b277gGWTyN6Ob8G+if3t0b4FU6q9nvW537NowvQjL8W+w0OVC2+OJXE12JI8mj9ucn9Or8WjAC77DIuY4Osm/KvQGbMyDx2itgBdHoduh+mvwdYLiXgrHtaUfJ52pqe85f6qKURdKlrQEM2f7g7jco2dHl7lCtFNmi5Qdn0CTXUtAXVteTq0AL8M/vs8u7UrNCcrCmPq6h1KTdh8Dr/w==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6977c333-679f-42f1-bd1e-08d8393ccd60
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 12:40:58.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLDTAZoKwfiT977xl3RvdxlEvMpwbQxNrkxyWbddua5BAnQ2fZwhSqb2kVUxiVlpFa9PHv5Zk/q+wXCvyCsnVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 08:00:55AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 04, 2020 at 07:20:36PM +0300, Eli Cohen wrote:
> > Hi Michael,
> > please note that this series depends on mlx5 core device driver patches
> > in mlx5-next branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> > 
> > git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> > 
> > They also depend Jason Wang's patches: https://lkml.org/lkml/2020/7/1/301
> 
> So if I apply this to linux-next branch of my tree, I get:
> 

Did you merge this?:
git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

> 
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   CC [M]  drivers/vdpa/mlx5/net/main.o
> In file included from ./include/linux/swab.h:5,
>                  from ./include/uapi/linux/byteorder/little_endian.h:13,
>                  from ./include/linux/byteorder/little_endian.h:5,
>                  from ./arch/x86/include/uapi/asm/byteorder.h:5,
>                  from ./include/asm-generic/bitops/le.h:6,
>                  from ./arch/x86/include/asm/bitops.h:395,
>                  from ./include/linux/bitops.h:29,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/module.h:12,
>                  from drivers/vdpa/mlx5/net/main.c:4:
> drivers/vdpa/mlx5/net/main.c: In function ‘required_caps_supported’:
> ././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
>   129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>       |                                   ^~~~~~~~~~~~~~~~~~
> ./include/uapi/linux/swab.h:115:54: note: in definition of macro ‘__swab32’
>   115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>       |                                                      ^
> ./include/linux/byteorder/generic.h:95:21: note: in expansion of macro ‘__be32_to_cpu’
>    95 | #define be32_to_cpu __be32_to_cpu
>       |                     ^~~~~~~~~~~~~
> ./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
>    17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
>       |                                ^~~~~~~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
>    51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
>       |                                   ^~~~~~~~
> ./include/linux/mlx5/device.h:53:34: note: in expansion of macro ‘__mlx5_bit_off’
>    53 | #define __mlx5_dw_off(typ, fld) (__mlx5_bit_off(typ, fld) / 32)
>       |                                  ^~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:96:1: note: in expansion of macro ‘__mlx5_dw_off’
>    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
>       | ^~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
>  1355 |  MLX5_GET(device_virtio_emulation_cap, \
>       |  ^~~~~~~~
> drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
>    24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/mlx5/driver.h:52,
>                  from drivers/vdpa/mlx5/net/main.c:5:
> ./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
>    50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
>       |                                                         ^~
> ./include/linux/mlx5/device.h:56:43: note: in expansion of macro ‘__mlx5_bit_sz’
>    56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
>       |                                           ^~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
>    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
>       |                              ^~~~~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
>  1355 |  MLX5_GET(device_virtio_emulation_cap, \
>       |  ^~~~~~~~
> drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
>    24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from <command-line>:
> ././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
>   129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>       |                                   ^~~~~~~~~~~~~~~~~~
> ./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
>    17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
>       |                                ^~~~~~~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
>    51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
>       |                                   ^~~~~~~~
> ./include/linux/mlx5/device.h:56:70: note: in expansion of macro ‘__mlx5_bit_off’
>    56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
>       |                                                                      ^~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
>    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
>       |                              ^~~~~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
>  1355 |  MLX5_GET(device_virtio_emulation_cap, \
>       |  ^~~~~~~~
> drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
>    24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/mlx5/driver.h:52,
>                  from drivers/vdpa/mlx5/net/main.c:5:
> ./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
>    50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
>       |                                                         ^~
> ./include/linux/mlx5/device.h:57:47: note: in expansion of macro ‘__mlx5_bit_sz’
>    57 | #define __mlx5_mask(typ, fld) ((u32)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
>       |                                               ^~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:97:1: note: in expansion of macro ‘__mlx5_mask’
>    97 | __mlx5_mask(typ, fld))
>       | ^~~~~~~~~~~
> ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
>  1355 |  MLX5_GET(device_virtio_emulation_cap, \
>       |  ^~~~~~~~
> drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
>    24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/swab.h:5,
>                  from ./include/uapi/linux/byteorder/little_endian.h:13,
>                  from ./include/linux/byteorder/little_endian.h:5,
>                  from ./arch/x86/include/uapi/asm/byteorder.h:5,
>                  from ./include/asm-generic/bitops/le.h:6,
>                  from ./arch/x86/include/asm/bitops.h:395,
>                  from ./include/linux/bitops.h:29,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/module.h:12,
>                  from drivers/vdpa/mlx5/net/main.c:4:
> ././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
>   129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>       |                                   ^~~~~~~~~~~~~~~~~~
> ./include/uapi/linux/swab.h:115:54: note: in definition of macro ‘__swab32’
>   115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>       |                                                      ^
> ./include/linux/byteorder/generic.h:95:21: note: in expansion of macro ‘__be32_to_cpu’
>    95 | #define be32_to_cpu __be32_to_cpu
>       |                     ^~~~~~~~~~~~~
> ./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
>    17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
>       |                                ^~~~~~~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
>    51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
>       |                                   ^~~~~~~~
> ./include/linux/mlx5/device.h:53:34: note: in expansion of macro ‘__mlx5_bit_off’
>    53 | #define __mlx5_dw_off(typ, fld) (__mlx5_bit_off(typ, fld) / 32)
>       |                                  ^~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:96:1: note: in expansion of macro ‘__mlx5_dw_off’
>    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
>       | ^~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
>  1355 |  MLX5_GET(device_virtio_emulation_cap, \
>       |  ^~~~~~~~
> drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
>    28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/mlx5/driver.h:52,
>                  from drivers/vdpa/mlx5/net/main.c:5:
> ./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
>    50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
>       |                                                         ^~
> ./include/linux/mlx5/device.h:56:43: note: in expansion of macro ‘__mlx5_bit_sz’
>    56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
>       |                                           ^~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
>    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
>       |                              ^~~~~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
>  1355 |  MLX5_GET(device_virtio_emulation_cap, \
>       |  ^~~~~~~~
> drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
>    28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from <command-line>:
> ././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
>   129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>       |                                   ^~~~~~~~~~~~~~~~~~
> ./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
>    17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
>       |                                ^~~~~~~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
>    51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
>       |                                   ^~~~~~~~
> ./include/linux/mlx5/device.h:56:70: note: in expansion of macro ‘__mlx5_bit_off’
>    56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
>       |                                                                      ^~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
>    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
>       |                              ^~~~~~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
>  1355 |  MLX5_GET(device_virtio_emulation_cap, \
>       |  ^~~~~~~~
> drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
>    28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/mlx5/driver.h:52,
>                  from drivers/vdpa/mlx5/net/main.c:5:
> ./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
>    50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
>       |                                                         ^~
> ./include/linux/mlx5/device.h:57:47: note: in expansion of macro ‘__mlx5_bit_sz’
>    57 | #define __mlx5_mask(typ, fld) ((u32)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
>       |                                               ^~~~~~~~~~~~~
> ./include/linux/mlx5/device.h:97:1: note: in expansion of macro ‘__mlx5_mask’
>    97 | __mlx5_mask(typ, fld))
>       | ^~~~~~~~~~~
> ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
>  1355 |  MLX5_GET(device_virtio_emulation_cap, \
>       |  ^~~~~~~~
> drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
>    28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/vdpa/mlx5/net/main.c: At top level:
> drivers/vdpa/mlx5/net/main.c:62:14: error: ‘MLX5_INTERFACE_PROTOCOL_VDPA’ undeclared here (not in a function); did you mean ‘MLX5_INTERFACE_PROTOCOL_ETH’?
>    62 |  .protocol = MLX5_INTERFACE_PROTOCOL_VDPA,
>       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |              MLX5_INTERFACE_PROTOCOL_ETH
> make[3]: *** [scripts/Makefile.build:281: drivers/vdpa/mlx5/net/main.o] Error 1
> make[2]: *** [scripts/Makefile.build:497: drivers/vdpa/mlx5] Error 2
> make[1]: *** [scripts/Makefile.build:497: drivers/vdpa] Error 2
> make: *** [Makefile:1756: drivers] Error 2
> 
> 
> I am guessing this is because of the missing dependency, right?
> So what's the plan for merging this?
> 
> 
> -- 
> MST
> 
