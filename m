Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A47C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C297F207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mIFqnwQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHEFBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:01:15 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:19994
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgHEFBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFhNdjioP+ZLcr7JH6eJDv1D55Tbx/xnvdjQihju/8d6nGUZds5oqhD5SwRYmWOaA5tHHQuHvb10gj0HFWQ0QUONrlMeVYdIQeROTWNx6wVDsf9fthKEHwngMbGYUwC0fFFBAqM6CXn5ujGYz4B0H4ydQfsNjPcR2GfblmWcLLbl9ixG1cvezuD+VWx1aBNAL6o9McxaJYe0vx8xlbCJp3PFoYh+SK9Wf4OX8juo9Hegs0w1Zbte7Y/vMfX7QQU9NFaqf/WYUkfqHaMTNUNDvCCVBmftas+WVWhCctZKQskUGUDhzDmCcClArNJ1Z4S+1qjM/n1cE1rv9DF+St1z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8KK4eODDzpXcKc9J6J0rAxn0iEk7FgJWvfCbI7mIu4=;
 b=i8KPaNfUbwC6+laJ9EjqXJtc49kjfHZUq90AUqA5k221HHPewGWxDEcjSuHZZn1B7Xg72mxHfV3uT51atyGWr6U4J1m739Vfo01/xqpyxA1CmCszWPNKLFlGxJRmjqxkR3IsunhR4oVSrB6und8WudTQkDohx22gE97FOQopSB/XNVWTUpH0pBofvLodOKCPnFi/Au9BTQCR/FVG4YArhvQqlL0ZgO9rC55tAP5uC6Nl1EV2ZBNp7pMI2eFbWpeYwcfkFBN8/iiG1VnJA7zEi4dbKDg+9QElG8T3UhM5rR8wXp28E4sh78a8n2jExyMm4A1jJee1yG9Nknjt94czww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8KK4eODDzpXcKc9J6J0rAxn0iEk7FgJWvfCbI7mIu4=;
 b=mIFqnwQhxpb9YOy81LoFKedIaw5JxdEc6ExRbRTLjabK6ddWOgrUkO1a0YYoYGudVvye2DLKcETq588NxajiC5yw/R63RgSeVuuAI9LZgk481+IfCbPaFy17fYmdWUptq9DghTi16H/60xKjvbur71O0YitCoY0px1E4XkWLQt0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB5842.eurprd05.prod.outlook.com (2603:10a6:208:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 5 Aug
 2020 05:01:10 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 05:01:09 +0000
Date:   Wed, 5 Aug 2020 08:01:06 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805050105.GA5442@nps-server-21.mtl.labs.mlnx>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200804172726-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804172726-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR04CA0100.eurprd04.prod.outlook.com
 (2603:10a6:208:be::41) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nps-server-21.mtl.labs.mlnx (94.188.199.18) by AM0PR04CA0100.eurprd04.prod.outlook.com (2603:10a6:208:be::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Wed, 5 Aug 2020 05:01:08 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d86993b8-3c74-40d9-9d26-08d838fc9166
X-MS-TrafficTypeDiagnostic: AM0PR05MB5842:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5842F3668673B38A76AA84BBC54B0@AM0PR05MB5842.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufh4JB/ZK2lUIV8sJqrISt1v3xa/5PSCwayltxUNdDWJTkvkujjdFuOdpHuRdyeonvgPrDGlSikZ939382NTRi7LPzr7xiCU/NBCS7rtXf/2AXc3yypdJCD++6Xpcy59I1w9kG8Nk25TmCQa3lLSnUKzHEN00YtQyyrWyfyBMUw/SqC9LoCnl3wT8KEPUinc+6XiY2e0zYrloWxv8FQwgs6D/uZ8WBP84jnsAy60WRpEMgGfoo0G/do1h5lqIxIVwIuPRWtASjBXJeppS5NueE/YJV2ekr5iSQEvs6q12K39DqdFA0unog0/WCnH9JQPoopLp6Nssta1gz+xhzG2CPiSWfBpl/zQ2Ow/95xY82Erdab2I3Q1u6blppjmPlZBORqMIY1y8041L1D9mHOO3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(66476007)(83380400001)(956004)(86362001)(9686003)(5660300002)(1076003)(66556008)(66946007)(55016002)(8676002)(52116002)(2906002)(316002)(186003)(33656002)(8936002)(966005)(7696005)(26005)(478600001)(107886003)(16526019)(4326008)(6506007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dvqkNsmwH+KwK26qPVZifujfv8mrv6kutZUBEoYkh+4C70C/vysioSl2ZRHMUdCwcgrf+amMpSfOONLR5HJKj2EoKLJ84ifLqWzlvfuvJDCUjuL2lL96nQ8pLhz5iia3oWhl+F/yT3JJDTl0QROqu7yQSPhxx8I4a8sik4ZMGSf1FXaV1zPshU7xTtr3FD258TG1NtSOL73L/O57RJszv+S63r7IX6yp/O8gVRZTA51DtX4xiANfTRqP8IBuHliu2OnaIWpjS6Ekk1a9s2nxVIOtGdeVKsgLCX0fL7V4kDdrjcboG9N4pgxC2UU7m+86bfCN1c4zAmaPKpefxconQh7pBCI3kcP0s7qi8AlFiF80WcCBSIXpsuaLqNtnqxdu7FegFCauOJIBuTPqZpKRhadsMXLTbYatr46OKIBWMq9XUq2GiR3y6moMItOrroMRSLdb4WB73SNQSQXWXuqoM4/GznESCklHOIBjkFu0MXh9pMFjGc1r0uSSd/MJh9NRZ7mfp98pnYXQv4ZaqM5HaXK40F6YOHLX2/+uAsJnQkK6uAHScRwPXh42IzRI9P8DLN54bbqcV1JRfC1x3oaakJvBxvj8wh3USJgnAaMJLBN9+wGrdrF00YTLPCrR7IzBkdvOoN754W0YIK6cguPTWQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86993b8-3c74-40d9-9d26-08d838fc9166
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 05:01:09.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alXpOFRkW7TLyUXZVuyxJ1vKYJy5mRT/6tfdZBZigjZSMu6nVm0BCwlWZhZ9uW5xi0PVgjW4RoCqRHx27GKxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 05:29:09PM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 04, 2020 at 07:20:36PM +0300, Eli Cohen wrote:
> > Hi Michael,
> > please note that this series depends on mlx5 core device driver patches
> > in mlx5-next branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> 
> Thanks! OK so what's the plan for merging this?
> Do patches at least build well enough that I can push them
> upstream? Or do they have to go on top of the mellanox tree?
> 

The patches are built on your linux-next branch which I updated
yesterday.

I am based on this commit:
776b7b25f10b (origin/linux-next) vhost: add an RPMsg API

On top of that I merged
git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git

and after that I have Jason's patches (five patches), than one patch
from Max and then my patches (seven).

It builds fine on x84_64.
I fixed some conflicts on Jason's patches.

I also tested it to verify it's working.

BTW, for some reason I did not get all the patches into my mailbox and I
suspect they were not all sent. Did you get all the series 0-13?

Please let me know, and if needed I'll resend.

> 
> > git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> > 
> > They also depend Jason Wang's patches: https://lkml.org/lkml/2020/7/1/301
> 
> The ones you included, right?
>

Right.
 
> > Jason, I had to resolve some conflicts so I would appreciate of you can verify
> > that it is ok.
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
> > V3-V4
> > Rebase Jason's patches on linux-next branch
> > Fix krobot error on mips arch
> > Make use of the free callback to destroy resoruces on unload
> > Use VIRTIO_F_ACCESS_PLATFORM instead of legacy VIRTIO_F_IOMMU_PLATFORM
> > Add empty implementations for get_vq_notification() and get_vq_irq()
> > 
> > 
> > Eli Cohen (6):
> >   net/vdpa: Use struct for set/get vq state
> >   vdpa: Modify get_vq_state() to return error code
> >   vdpa/mlx5: Add hardware descriptive header file
> >   vdpa/mlx5: Add support library for mlx5 VDPA implementation
> >   vdpa/mlx5: Add shared memory registration code
> >   vdpa/mlx5: Add VDPA driver for supported mlx5 devices
> > 
> > Jason Wang (5):
> >   vhost-vdpa: refine ioctl pre-processing
> >   vhost: generialize backend features setting/getting
> >   vhost-vdpa: support get/set backend features
> >   vhost-vdpa: support IOTLB batching hints
> >   vdpasim: support batch updating
> > 
> > Max Gurtovoy (1):
> >   vdpa: remove hard coded virtq num
> > 
> >  drivers/vdpa/Kconfig                   |   19 +
> >  drivers/vdpa/Makefile                  |    1 +
> >  drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
> >  drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
> >  drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
> >  drivers/vdpa/mlx5/Makefile             |    4 +
> >  drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
> >  drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
> >  drivers/vdpa/mlx5/core/mr.c            |  484 ++++++
> >  drivers/vdpa/mlx5/core/resources.c     |  284 ++++
> >  drivers/vdpa/mlx5/net/main.c           |   76 +
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1965 ++++++++++++++++++++++++
> >  drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
> >  drivers/vdpa/vdpa.c                    |    3 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c       |   53 +-
> >  drivers/vhost/net.c                    |   18 +-
> >  drivers/vhost/vdpa.c                   |   76 +-
> >  drivers/vhost/vhost.c                  |   15 +
> >  drivers/vhost/vhost.h                  |    2 +
> >  include/linux/vdpa.h                   |   24 +-
> >  include/uapi/linux/vhost.h             |    2 +
> >  include/uapi/linux/vhost_types.h       |   11 +
> >  22 files changed, 3284 insertions(+), 57 deletions(-)
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
