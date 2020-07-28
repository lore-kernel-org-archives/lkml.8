Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDBF207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="cJ20xZQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgG1GcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:32:19 -0400
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:1925
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbgG1GcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:32:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE+FFyDsraxGP/8FDXqQ/hP/74N6/aWztl5TFqTttThYnpJjDjQ6RlkMCJFdPddslEnapOo1WSCotcBD/mvnclrnoqi022CzkDbddM15Py2VBvLnU/5HIW5hG3GIA9htl4hpOYJ8xLyDQflSKVPPnaXf+wzqeghjTn7LQFpCyX5cgEwSEFWNKLy1eOmoynEwEufX0E6IkV5jLVxCsPZ9iDWCUbEkJvQDAFzXUR0HnvVh0V2dWUUObQwoPJv9HZOi2glqhekk1eStVvDgfL0z+Lh5gtx0j4BzUqvvs7zpZW7TKqMwVbcu9IvyPcYVCjZUz4DmcGDmtdhPmWYgwPVJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U29x2tI8P1W/N5gCJkqxwB9hx/ea0I9Kiv08JDGg2rk=;
 b=BQNEC8KwyyajDkNUnRroz1L/pX5D4m8eLfVXQ5qAc6Xo9XM3Aw41pbEH5wzEo2b7D0uABBp6TYqij1fHTUDyktgIcUQHZOYFYcjKKmYItv/t4VkF9U1RTvEOcQfQQ7nqFT6im9vmZa+QabtlmNf4mXfYaFbwNKdgblDQyMdVbSzu87gRfBGYMnTaP5tM2hz37a97zUW276iudrP88JJgMxq2K3Q2xcCbjQbmZNbyI9UNRO0y7rCvvXN7XFOATk39v3MlBR3I0i8fW3EPUD2TRPXKPqpZ5TLU0dwTidbZK78Fg09v6Lyqfe01zSSrk5XmooQNK7eNaaJMGPhTSucJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U29x2tI8P1W/N5gCJkqxwB9hx/ea0I9Kiv08JDGg2rk=;
 b=cJ20xZQoE10CRKeBb8NkdHtYN+tplGJQPi93ftoH2Hy30F8gsUNwP5RUFdH9jN4+SCvSjtlslkp/4CepdUG0WD6szMIFV4DpE2G3XYqgPV9z+eW+y/I2BeA9P8peU8V8dYijdF8WqOo55R2bhCZuIR2BM+EcRSbyTIn7m1gGa98=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB4897.eurprd05.prod.outlook.com (2603:10a6:208:cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 06:32:16 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 06:32:16 +0000
Date:   Tue, 28 Jul 2020 09:32:11 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
References: <20200728060539.4163-1-eli@mellanox.com>
 <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR01CA0085.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 06:32:15 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dbd7bc9-0a0e-4738-597a-08d832bff836
X-MS-TrafficTypeDiagnostic: AM0PR05MB4897:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB48977BD28116673A8EF92CD3C5730@AM0PR05MB4897.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3ztpCp5AYiJzaGRGFPQ8/KD1XGHH88ISdUaMmVN84AwB0sydg5A/1znx6k9DecjC/GthT/VagtTk3TB7BZzndB7ADEnNwzW8Y0jqZ6Kfy0WR/IjMtWkMou94wZhKQjrNgmlY/s53Gu453FsK1lJvzgHfEn3vh0IydoLH++80nIY6CrlqinoC6Er9ZV+FQTeHNqg7uGlsv5S1PbFWp7NZBPKcJKwmRpf40DN/8PHP14t0q7FuB+EMs9oO+7PfbfgFEGfUMKOidBVvs83Ly8f4ky0pGfjIHoJg4DeVsXP+kH0+SV8/ZABfBP0NhShzk3c8i6bihEjqpyN0vGTiUfdx+kDo5aS+vQmYdQuyOHyC3XbDgWE8vFk99sZes8uxOHv9uK8h1W93u4HaYZcMisARQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(55016002)(316002)(9686003)(83380400001)(6666004)(6506007)(86362001)(956004)(966005)(16526019)(4326008)(8676002)(478600001)(5660300002)(6916009)(52116002)(107886003)(66556008)(8936002)(33656002)(26005)(66946007)(66476007)(2906002)(1076003)(7696005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6I8LoY2Xk9i/WNCBCRIzyBFw+JT1QELVWrvR55FbUzDUS3eieCqa0SoHLuCTZVMIr+wPvjBTl2Xn7sjjKzmTZqAVRlvkqKR7Eqeo/wutqIcOPnLte2Tf/uL6YT9JyfMlPErM5CKlO2oAoIEAKUbD13O/gG58CEhz0IF9YPM2u72IMvSibd3D65pXTnjxr385y4lSsFwfUf73wXxY0MSQvtqEohuDCfSrnoKel+i7MAoNvjcJXjsaedgTzs8mrnAOCYHwacqBlen+eK30Cs7p2rv5VbrsM6Mh2USGENgCZZuZNwgVoXpHP8CmbtAfXXmA/OReFSc+l5wm8HEyOvOvK6D7Ns6HO9ztQmn6/dQDe2JKvFyJHVRWNpSbmfZp01bW+/FfBNGO4Kzn87WqMo85oxdg3grAM6hmoyCUHmxXFoHzpOgNoRL7EECEd0vNtIGg1SUdmloEjNIOMwo9x48NIP4P0mIRd250YknpESaep50=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbd7bc9-0a0e-4738-597a-08d832bff836
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 06:32:15.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRIFN75d02RNGS4KzpJVhgjYl6c/yfTB7igUty5A85L//y5VtxLRRXajh77IbSEhFUkpxq+ff1rWw3gcXXXM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 02:18:16PM +0800, Jason Wang wrote:
> 
> On 2020/7/28 下午2:05, Eli Cohen wrote:
> >Hi Michael,
> >please note that this series depends on mlx5 core device driver patches
> >in mlx5-next branch in
> >git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> >
> >git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next
> >
> >They also depend Jason Wang's patches submitted a couple of weeks ago.
> >
> >vdpa_sim: use the batching API
> >vhost-vdpa: support batch updating
> 
> 
> Just notice that a new version is posted[1] (you were cced). Talked
> with Michael, and it's better for you to merge the new version in
> this series.
> 

OK, will send again. Just to make sure, I should put your series and my
series on Michal's vhost branch, the same tree I have been using so far?

> Sorry for not spotting this before.
> 
> [1] https://lkml.org/lkml/2020/7/1/301
> 
> Thanks
> 
> 
> >
> >
> >The following series of patches provide VDPA support for Mellanox
> >devices. The supported devices are ConnectX6 DX and newer.
> >
> >Currently, only a network driver is implemented; future patches will
> >introduce a block device driver. iperf performance on a single queue is
> >around 12 Gbps.  Future patches will introduce multi queue support.
> >
> >The files are organized in such a way that code that can be used by
> >different VDPA implementations will be placed in a common are resides in
> >drivers/vdpa/mlx5/core.
> >
> >Only virtual functions are currently supported. Also, certain firmware
> >capabilities must be set to enable the driver. Physical functions (PFs)
> >are skipped by the driver.
> >
> >To make use of the VDPA net driver, one must load mlx5_vdpa. In such
> >case, VFs will be operated by the VDPA driver. Although one can see a
> >regular instance of a network driver on the VF, the VDPA driver takes
> >precedence over the NIC driver, steering-wize.
> >
> >Currently, the device/interface infrastructure in mlx5_core is used to
> >probe drivers. Future patches will introduce virtbus as a means to
> >register devices and drivers and VDPA will be adapted to it.
> >
> >The mlx5 mode of operation required to support VDPA is switchdev mode.
> >Once can use Linux or OVS bridge to take care of layer 2 switching.
> >
> >In order to provide virtio networking to a guest, an updated version of
> >qemu is required. This version has been tested by the following quemu
> >version:
> >
> >url: https://github.com/jasowang/qemu.git
> >branch: vdpa
> >Commit ID: 6f4e59b807db
> >
> >
> >V2->V3
> >Fix makefile to use include path relative to the root of the kernel
> >
> >Eli Cohen (7):
> >   net/vdpa: Use struct for set/get vq state
> >   vhost: Fix documentation
> >   vdpa: Modify get_vq_state() to return error code
> >   vdpa/mlx5: Add hardware descriptive header file
> >   vdpa/mlx5: Add support library for mlx5 VDPA implementation
> >   vdpa/mlx5: Add shared memory registration code
> >   vdpa/mlx5: Add VDPA driver for supported mlx5 devices
> >
> >Jason Wang (2):
> >   vhost-vdpa: support batch updating
> >   vdpa_sim: use the batching API
> >
> >Max Gurtovoy (1):
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
> 
