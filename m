Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6755AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4253F208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="VnpL7lKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgHDL61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:58:27 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:62212
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730339AbgHDLy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:54:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob6nkjZ4hAV6Y8dliexXdXfGPZpFlSZnygWZ5V/bclJkAxVW8K2GW1NYE0ILrHh7WeVAOEAfl7HiL4cqRukcCWrPgLOe4rSAqCjFqUnzlDu+ehe3vQFqqaLzNhIBnO1o37zxMDuzHu+0U9kOCv+TOAjk2SYTmNY1yjTxeu9s36TLmt4P6zxM8nfUzlawbfHHHnXA+00y/wKvRrh6ptyIVBC5RuYdspdlqZ2hlPkrbEPhgFe6gNqRhw6G0ImXF5QX85AvSShYNmLJDY9cuQSCeUWlTVeoKDZAUWt6xtefHjpeg9d9VrnCv7u5rTDeHXu+SyuavKeT3h7YeGhgnAcGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJFmNXZ4wTh4HNkYS90JFxTdTJUlaOBIKdNLCQsUH84=;
 b=iwTyOcG1YXL5ZZ4i5DA2ChSUmUr6G/xO4eWEecUV3dtltSwD/7lEPPZSG3MHneobRG/rWzsND+IzRvVo2k7YmyJH0si4oXj2kW4uLxuFmqtMKKleWU2l6LlHJ2ZUcbRM/4aUG1F9fFY6d4lYyr/iF0T3DKmMTg/gevbR1T284OosXXhMJceZ/qI1jPJJHQzQ1qKhlWVebb1uMduoK/WkCJfZ8Rdcz8plE2C+ijgBdvnZN7jgszqL/eCChn6TWlCqfeIj1v7DnRKe6ls2w98ISy9xbXk0zyxMvs6uhadose53v9wPmDhnJ6+jtYNlWEVjtfVXqxpqdAMMuxS95lQgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJFmNXZ4wTh4HNkYS90JFxTdTJUlaOBIKdNLCQsUH84=;
 b=VnpL7lKqUStqfeUURspI92rXmmTlDAK/+Jj7i2cYNtQt9cL+rnLHoWCTSUqFm9vf2Dk+E5XAzM27V8CFHE4BiJcr7kmlFZjzSbdscGjzlevvWfIApZDhp+X6rKXGd0RoI2NAH0hZXogmidtn745kUsPpXjP0ZCRBlUzSntg2LIM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB6561.eurprd05.prod.outlook.com (2603:10a6:208:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 11:54:24 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 11:54:23 +0000
Date:   Tue, 4 Aug 2020 14:54:19 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Shahaf Shuler <shahafs@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH V3 vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Message-ID: <20200804115419.GA6326@nps-server-21.mtl.labs.mlnx>
References: <20200728060539.4163-11-eli@mellanox.com>
 <202007282108.S8MkTrap%lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007282108.S8MkTrap%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nps-server-21.mtl.labs.mlnx (94.188.199.18) by AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Tue, 4 Aug 2020 11:54:22 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7070405-59df-411e-d7ef-08d8386d217a
X-MS-TrafficTypeDiagnostic: AM0PR05MB6561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB65619FB7305EFED20FE079B9C54A0@AM0PR05MB6561.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJsQkiMng2OH9qacQ1oprxxBEZ63O147EjQcoprVMriWyAn5N/KB3gk1jcf1bQad96i1WM/CrYTaMT1FoC84+KUoTUrbOAqQDdwvRTk6x/1oZzFtgONnMnLBPizK5HutUmkrAm39WeJpiv6z369qaRZRho8jcHOdmqfiytSAkEVNbZO+Yo7N/DwiWtApgeY+54am2MHNl58r9506H/OQTRMOYkUooleQEg63fqBceomSpD0G0R8JmiuazT3+xxnGdtJelBp/pkjwi/f8AxJ8xm/jpERNPK2RZoKpnPOYLVirMCSBPlXstMPQydLven0yNl7gveovQp0FAhT/acq8IQO03oZa1w70Vf0hu7OU8ZVYu5aSHK1OEBFknkSiTOdVHs+dN/Aqiysofu2PaDoalA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(6506007)(7696005)(52116002)(83080400001)(66556008)(66946007)(33656002)(16526019)(107886003)(66476007)(186003)(26005)(8676002)(956004)(1076003)(966005)(498600001)(86362001)(6916009)(8936002)(5660300002)(55016002)(9686003)(6666004)(54906003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: n21IrIewEnsmi0WRRXTldXejUlnrbYjLtopRXziAdNkt1b6ZMrym94WULY/JTRx4wFXjf/75zJ7YYHHbEECJEpsiy2FfWR+lEejfcx8K8vTIrmL2big5iT581uAndwtf6WWDmtL5vHeCM5gG3gcqttl/TEP3s9s1SBJzSUg63043BRyZvtUJm72bmj7R6n12X4Wd0JJT/bK8z4tvhhi0OloEclm+SxnOGyX0qxovDMYi2oXh8fT5wkli9WUROI8TjbNU0W7beCAs+2BV5q3F74J4qJb2ymWX9fvmdhSVD6eLZtKIuuA9QAUAcn1r3HixoAAxxpm63NqbXtwveOQQSjN9C9FOgvnarrAnkBquQw7yrKKUWFqzP5lDfnwUfBXDRJXrdM2rRoLW27VeN8jFX+9263baAfPvGkslVmtuET4pjYUAJkQ10ffkUacE/lDIFL46rY0wtNSFsoD5dTSBfJAzazijF1J+iuwfaSGpBzy5eXSF+IJuWkT8VopJDShb7es8FQhZdt3xwdu5FZqumn9/NSd17LTgZAIRr15Y9RkaNNLmc+dw6O2MIsFINHh2NALruJhx+giocbN4Atg2j+eHW0vVl6f/furnlh0apboBgpcCXnhYTvfsnONV77TkeopDBz1YUWBIf4biR9YJvw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7070405-59df-411e-d7ef-08d8386d217a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 11:54:23.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ4aJWl4k97g+mYzJPf2FLOEMCSfSdsKy1k1D1PLNp9Uz6t2o3cKxxU+lNAtzQouaCLcEVPD6rrF5HV60MzCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6561
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:43:00PM +0300, kernel test robot wrote:
> Hi Eli,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20200727]
> 
> url:    https://github.com/0day-ci/linux/commits/Eli-Cohen/VDPA-support-for-Mellanox-ConnectX-devices/20200728-140938
> base:    e9a523ff8f76de0768857f02ea76437d3b39d151
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!
> >> ERROR: modpost: "__udivdi3" [drivers/vdpa/mlx5/mlx5_vdpa.ko] undefined!

I don't know where this complaint comes from. When I follow the steps
above to reproduce, I find myself failing on code unrelated to my patch
set so I can get my code compiled:

drivers/rpmsg/virtio_rpmsg_bus.c:88:8: error: redefinition of 'struct rpmsg_hdr'
   88 | struct rpmsg_hdr {
      |        ^~~~~~~~~
In file included from drivers/rpmsg/virtio_rpmsg_bus.c:28:
./include/linux/virtio_rpmsg.h:21:8: note: originally defined here
   21 | struct rpmsg_hdr {
      |        ^~~~~~~~~
drivers/rpmsg/virtio_rpmsg_bus.c:109:8: error: redefinition of 'struct
rpmsg_ns_msg'
  109 | struct rpmsg_ns_msg {
      |        ^~~~~~~~~~~~
In file included from drivers/rpmsg/virtio_rpmsg_bus.c:28:
./include/linux/virtio_rpmsg.h:42:8: note: originally defined here
   42 | struct rpmsg_ns_msg {
      |        ^~~~~~~~~~~~


I think the reason for the complaint comes from usage of DIV_ROUND_UP()
which somehow does not work on mips.

I can try to avoid using this macro and implement something of my own,
unless someone has a better idea what's going on here.

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


