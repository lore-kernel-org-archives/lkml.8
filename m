Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ECEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1390E2067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="klXACDAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgHDFel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:34:41 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:29582
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726797AbgHDFel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:34:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wpl52WLgIp4bBHAyR785ieiIKeOd2bjF7TlDMuoo2/ePT9uNZ5It6gsO5x7z8G4/K1BCMxPUh4vRxF+h7ALaTQB1GRFaSBgsmMmy2Rl2Q7D6ivehlWCxG2Mbejaoo7r5yg/PU90IImTDTacjPx3mGHA6yb7LlhDj5X2cKSycToh2nWB3KF8LrJnGQbJSBClWutqc1tAmaV49rxJmVfSqPJvWbNnJ2Hc/FX+J1NU/QF2Xw6ieEsiF+lqtfGsFnRJZEY9XN7aYqN8IHYBrs9J00teD/LiDKBX8kfZDwlPQAoZlSGJLA7PUQce/yU0jvDxDKbuFHVTewse8v5fc2ByINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4tfmsg65Eb7Hv/oMxlnvxmxR6LVfcN+xXFgzidJ3Uc=;
 b=JidcTUfz92ZERzac81szoz6RKjHT30/RQ/wSLmLqCh4aSlrasdk6dYjHCuclqrkxnh78uLuhItwZierss1ASDDblk2PXcaavd2yT/J8imsnELUadax/0MD/c19B0bYxv2J+WT9clHDHKx/Dp05ZR6oNAeeFQMgcQ7ittnlHD+bz3t59i/mjqQB1e4Z4cVcBjRHJkAlJiK/QjJAwPZS2684u2gVO+oEKltGtB5DtZcu0eC1mWpKU/+AYhd98ZluQugLPe3k7UxH2cPAZDT7B5mAUALJzYhp/vpGdnW604cTkRsnP1I9cNuXJri4mLMJuUfY+mM9VnjyMN3zstJ9REeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4tfmsg65Eb7Hv/oMxlnvxmxR6LVfcN+xXFgzidJ3Uc=;
 b=klXACDApk8VVof5qWi1SZX2LMnYytLQEdnm3Ifj1b2qpxbF0pXhyu2OwT9bx0UVMalj7TkkkudqHENt8twtyKaH2Bj8eJH4oPrAZUfduXO1KZCshBL4wZ6uKMKUybASATirk+Gh7RvYDOM1IHt741e/DZZUVHZ70ac0isalBdQg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR0502MB4067.eurprd05.prod.outlook.com (2603:10a6:208:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 05:34:36 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 05:34:36 +0000
Date:   Tue, 4 Aug 2020 08:34:32 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200804053432.GB58580@mtl-vdi-166.wap.labs.mlnx>
References: <20200728060539.4163-1-eli@mellanox.com>
 <20200803164756-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803164756-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM3PR05CA0140.eurprd05.prod.outlook.com
 (2603:10a6:207:3::18) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM3PR05CA0140.eurprd05.prod.outlook.com (2603:10a6:207:3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 05:34:35 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db4ffac6-a2b2-4414-5eb6-08d8383812e1
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4067:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB406727D58D7940CBAE00DEC9C54A0@AM0PR0502MB4067.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rv93WPzDYCGPt652W/Ht1wLSn7Xagvmzv34y333lLh/GieIQLG0P9gfFYK4SqY4meOuDa56pq7z5zVIZqovgAAFlrRcLjwowB0Hrl4fc/29iI7c9H5dR7CiCrwoQe1E53bt3KRahpvQhx5oxV0MmqwKlFho1Ss/cJ01R8WB8fvYJ6mqsD2fmWKKkusnmGQxoq6WfBzG5po7RH9OVmUpwK/4sAVuAx+mPNSJW1My4Zc5qkJYiU0SOTFOMkGcS/exoGWUnhz76VX7fk6B1TDHMg5iRxIsLhR0yzP+gBOVFESRjsNJy+RgCqTvhaglj9u3czUd7jQjBQG3QC6wXd3Zm3sYTI649gW59a4FdQwOkPfy3sS84l7vmrowO/4M5krh+4sQa1jAIr0IRxf5iYpENA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(26005)(83380400001)(316002)(66476007)(66946007)(7696005)(966005)(66556008)(52116002)(6666004)(8676002)(5660300002)(186003)(6506007)(2906002)(16526019)(8936002)(4326008)(55016002)(1076003)(86362001)(107886003)(6916009)(33656002)(9686003)(478600001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: frkqpWcVEoyxR9zDFs55CXLiGvoLP79YcN3+iDonkoATpszsMxcVX24oL0UDbujA1mfWuat7WOlIVx5/t48yIFsE7FY5F2CEon9amjk+BnZrF49ELJPjCM5oN3DPDSqtrZl70KYjmVEXgsEBO7zAuUrPEYGf0h4ZGF89CQdP9DdPIgvrD1ujNcnX8Cdz5SGJ2/SgncOlpePf1Mx/jBd63GYq4rhQSJiLyLs4yR9ZwADcsuRoQWUZlWmsZRl9QMhtGOMAmEejJC3kfKjn5y9T7noyA7r3L4mA35JhgJ9bVXFhZYcNaTBGBQ7uvv+p2ZwFBh3SzA0zl0bfPszTDxx9O4u7XT1LoE/ZntDxetQB8XSDGz68qiALpgYkNHBZ7mLnbUnqxvaJtuIOjalt74266KCFB8Cq3SkVbYcl+L0ko4la/41kCS477L0LukOTI0sG3vLDCpO0Xn37P5azagpckuGy5rdOAr2jk1d2wU/G7H4PcVZ2pLm8LQuvw0XgJCOy5JHaJ/RD10SstQSorbsdcGwkpy67Y7OYuitzzJ/NeZAX5AVZWe8gTQ4T5SPBd8ZXeTzuwTUqKK3KeszJn6tj86AvOB57JjlRHpFpvVegU0AJDE0MLh4Fglztq0uPCAdThffG+ElEIUVG9zWeH4xtGA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4ffac6-a2b2-4414-5eb6-08d8383812e1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 05:34:36.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bObZ2KkJMxSeTyvbkpHzKCc8zmZKoii6C+zWI8Fr+26LdzbAvMtMQEdjGb3Ieo3AhWSP59ZcWk1ma4WEKqKjaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:51:27PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 28, 2020 at 09:05:29AM +0300, Eli Cohen wrote:
> > Hi Michael,
> > please note that this series depends on mlx5 core device driver patches
> > in mlx5-next branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> > git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> > 
> > They also depend Jason Wang's patches submitted a couple of weeks ago.
> > 
> > vdpa_sim: use the batching API
> > vhost-vdpa: support batch updating
> 
> Hmm this makes merging them messy. I can ack merging them through
> the mellanox tree, but
> conflicts between Jason's patches and what's in my tree also exist.
> 

Let me see if this is something I can fix.

> How big is the dependency? Can I pick it up with your ack?
> 
> Also, mips build failures need to be dealt with.
> 
Will look into it.

> > 
> > 
> > The following series of patches provide VDPA support for Mellanox
> > devices. The supported devices are ConnectX6 DX and newer.
> > 
> > Currently, only a network driver is implemented; future patches will
> > introduce a block device driver. iperf performance on a single queue is
> > around 12 Gbps.  Future patches will introduce multi queue support.
> > 
> > The files are organized in such a way that code that can be used by
> > different VDPA implementations will be placed in a common are resides in
> > drivers/vdpa/mlx5/core.
> > 
> > Only virtual functions are currently supported. Also, certain firmware
> > capabilities must be set to enable the driver. Physical functions (PFs)
> > are skipped by the driver.
> > 
> > To make use of the VDPA net driver, one must load mlx5_vdpa. In such
> > case, VFs will be operated by the VDPA driver. Although one can see a
> > regular instance of a network driver on the VF, the VDPA driver takes
> > precedence over the NIC driver, steering-wize.
> > 
> > Currently, the device/interface infrastructure in mlx5_core is used to
> > probe drivers. Future patches will introduce virtbus as a means to
> > register devices and drivers and VDPA will be adapted to it.
> > 
> > The mlx5 mode of operation required to support VDPA is switchdev mode.
> > Once can use Linux or OVS bridge to take care of layer 2 switching.
> > 
> > In order to provide virtio networking to a guest, an updated version of
> > qemu is required. This version has been tested by the following quemu
> > version:
> > 
> > url: https://github.com/jasowang/qemu.git
> > branch: vdpa
> > Commit ID: 6f4e59b807db
> > 
> > 
> > V2->V3
> > Fix makefile to use include path relative to the root of the kernel
> > 
> > Eli Cohen (7):
> >   net/vdpa: Use struct for set/get vq state
> >   vhost: Fix documentation
> >   vdpa: Modify get_vq_state() to return error code
> >   vdpa/mlx5: Add hardware descriptive header file
> >   vdpa/mlx5: Add support library for mlx5 VDPA implementation
> >   vdpa/mlx5: Add shared memory registration code
> >   vdpa/mlx5: Add VDPA driver for supported mlx5 devices
> > 
> > Jason Wang (2):
> >   vhost-vdpa: support batch updating
> >   vdpa_sim: use the batching API
> > 
> > Max Gurtovoy (1):
> >   vdpa: remove hard coded virtq num
> > 
> >  drivers/vdpa/Kconfig                   |   18 +
> >  drivers/vdpa/Makefile                  |    1 +
> >  drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
> >  drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
> >  drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
> >  drivers/vdpa/mlx5/Makefile             |    4 +
> >  drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
> >  drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
> >  drivers/vdpa/mlx5/core/mr.c            |  473 ++++++
> >  drivers/vdpa/mlx5/core/resources.c     |  284 ++++
> >  drivers/vdpa/mlx5/net/main.c           |   76 +
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1950 ++++++++++++++++++++++++
> >  drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
> >  drivers/vdpa/vdpa.c                    |    3 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c       |   35 +-
> >  drivers/vhost/iotlb.c                  |    4 +-
> >  drivers/vhost/vdpa.c                   |   46 +-
> >  include/linux/vdpa.h                   |   24 +-
> >  include/uapi/linux/vhost_types.h       |    2 +
> >  19 files changed, 3165 insertions(+), 59 deletions(-)
> >  create mode 100644 drivers/vdpa/mlx5/Makefile
> >  create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >  create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
> >  create mode 100644 drivers/vdpa/mlx5/core/mr.c
> >  create mode 100644 drivers/vdpa/mlx5/core/resources.c
> >  create mode 100644 drivers/vdpa/mlx5/net/main.c
> >  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
> >  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> > 
> > -- 
> > 2.26.0
> 
