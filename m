Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69FC2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HNk2ulvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCJMHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:07:35 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:41831
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgCJMHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWZ+5OEygBLhJBWFDGzzaSAKpYCNrM0+pW7e0au2S+ssjf44KSVL17E6NZeX7DV8caWMBfe9WBi9Q7wU9DbzovW//nNvKvYav69PNGV6dyLeQrXkADxCm1U/IEzGxWEd3SMn8rbUpdr57c18dA0LQ9/7P1ar/5CCjCn6R/amA08PfBVNAYvW0LoccaJlK8x/QF9KPDEXgmHicvWGWmcxE4E0qJkuTAvbsoT9rKJzwITv1H94x/QvF+fO1XRJ6yajsFzxwc7DvhfZJJd7PA9o4iWdeaWPmnu69MYBRkvUiJJfz9Cb/BcMB4LmSiRQL9xGdx6geaIgFFu/YgwJJJzB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RDWI/oJNWnF//Eq1yMxcx4w2cMYY66IgaePxmJEQ5U=;
 b=nOXZLWXpiRJqTH7UnjApkBZk9yJjco21G+A/bk5VXIVdpD8Vw6bTYN+vdfKr384Xb1CkkXQFDcnb9/FWcOSSExZkW959x3bTQNRhRzDKp89ukqaZdSNYe6/rh18puW/3Qsd8WIte0pukxMLaqex6iA9kOnAp+WoUkRdxOoYnQtMHLHHCtsAuncLi5GvlIieFmMuVXt+n1+5qqX1UrU8ilPYw7SlxtrxA62aGVAFfctdQlt5FIPoHMlp40BLdEkwDYS98Q8NZ8ggqOp8Qxod/uyxrGD10afmUTyHGOb1OzBxhEg4p6pDWnqxsdu0CbQIF2FKdeEU+3jMh3dBG85uv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RDWI/oJNWnF//Eq1yMxcx4w2cMYY66IgaePxmJEQ5U=;
 b=HNk2ulvzcIUeEkBsgcsbksFqsE62HDpiI30R4MAYkgLleTGeejQrOJGbQpw7PKPNdkoi1neLiUn5CMf2sV8MaWIU23nMyCQfTCD7mze0BYfbsE0rnsM60tg03S7sFwUNigQiVpLAXEgkWqkzueE9PGdxzX4zV/vUpU6GeXOyE/M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (20.179.2.147) by
 AM6PR04MB4901.eurprd04.prod.outlook.com (20.177.32.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Tue, 10 Mar 2020 12:07:30 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::fdd6:55d:c03e:5818]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::fdd6:55d:c03e:5818%4]) with mapi id 15.20.2793.018; Tue, 10 Mar 2020
 12:07:30 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Roy.Pledge@nxp.com, leoyang.li@nxp.com, youri.querry_1@nxp.com
Cc:     ioana.ciornei@nxp.com, Grigore Popescu <grigore.popescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] soc: fsl: dpio: register dpio irq handlers after dpio create
Date:   Tue, 10 Mar 2020 14:07:19 +0200
Message-Id: <20200310120719.2480-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR05CA0065.eurprd05.prod.outlook.com
 (2603:10a6:208:be::42) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by AM0PR05CA0065.eurprd05.prod.outlook.com (2603:10a6:208:be::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Tue, 10 Mar 2020 12:07:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a95c629c-b029-4bf8-686a-08d7c4eb9b7b
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:|AM6PR04MB4901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4901015540D1E52A297AAC74ECFF0@AM6PR04MB4901.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(81156014)(6512007)(186003)(26005)(66476007)(6486002)(86362001)(2906002)(81166006)(36756003)(8676002)(6636002)(5660300002)(6666004)(66946007)(52116002)(8936002)(66556008)(1076003)(316002)(478600001)(4326008)(956004)(44832011)(54906003)(45080400002)(16526019)(6506007)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4901;H:AM6PR04MB5925.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+K9+jtV1Bn69MZDFxe11+V99aPawE3pLJGTxF7VW60hzokJF28SxWXWG6bliViTPuyYUz6pqilATLJAeRz8h4ppfMz3Cb3t0q1WuNPb5ps7dAx9pD9sTY5gcso+yWXezC0v4JsuAPGgs/55qnEEDHmE9WXiuXoAzyfhWvQ0P7W1u0u5uGS4f1oe4lurRnR6gaZkNGsKc9LbZQHN4Bs40ulDHDp0myfXvAFo7WiYDYBYozB2cMSEEZwy7MyP9LcGW9NPh+xbPUH5tEN/t+KIaRmSsY4imSOdltiSGaUXVJ+glzR5ldCBIHPStaULcjPM21BGzbbPtbL4n5mbaWmtR0Lvd+cFwHZxZ4laoDnWXwDzx02k2GjMQr8rcQrLbOyY3ySUr+VQI7Vt4wRM3kzzVTd+MO/83qhqBRikryV4A/TxCCHOG5xM3l2dhTQ15mGa
X-MS-Exchange-AntiSpam-MessageData: pjzbPqVKKTrDoGXz01C5F1N4E3/zRb5riSDDdfKViZit02BgzWv2MnHJ6TaEvzN5PVwWUX7siq7A+9eKJmsv22lBp7MwvzWeNuLaXN55qtCF4zjqnb9Y/iSr5SzdegmrEfJiBGl33vkZsSD2uocyIg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95c629c-b029-4bf8-686a-08d7c4eb9b7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 12:07:30.2778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSmFIJu/ATAPvlhTgB3lv82uLIt6JBnzes+cyUpB7jWHbXUZ+54MTH8gnrM/uzMgAW58vnVmcB4J7PeVS4EidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grigore Popescu <grigore.popescu@nxp.com>

The dpio irqs must be registered when you can actually
receive interrupts, ie when the dpios are created.
Kernel goes through NULL pointer dereference errors
followed by kernel panic [1] because the dpio irqs are
enabled before the dpio is created.

[1]
Unable to handle kernel NULL pointer dereference at virtual address 0040
fsl_mc_dpio dpio.14: probed
fsl_mc_dpio dpio.13: Adding to iommu group 11
  ISV = 0, ISS = 0x00000004
Unable to handle kernel NULL pointer dereference at virtual address 0040
Mem abort info:
  ESR = 0x96000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[0000000000000040] user address but active_mm is swapper
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 151 Comm: kworker/2:1 Not tainted 5.6.0-rc4-next-20200304 #1
Hardware name: NXP Layerscape LX2160ARDB (DT)
Workqueue: events deferred_probe_work_func
pstate: 00000085 (nzcv daIf -PAN -UAO)
pc : dpaa2_io_irq+0x18/0xe0
lr : dpio_irq_handler+0x1c/0x28
sp : ffff800010013e20
x29: ffff800010013e20 x28: ffff0026d9b4c140
x27: ffffa1d38a142018 x26: ffff0026d2953400
x25: ffffa1d38a142018 x24: ffffa1d38a7ba1d8
x23: ffff800010013f24 x22: 0000000000000000
x21: 0000000000000072 x20: ffff0026d2953400
x19: ffff0026d2a68b80 x18: 0000000000000001
x17: 000000002fb37f3d x16: 0000000035eafadd
x15: ffff0026d9b4c5b8 x14: ffffffffffffffff
x13: ff00000000000000 x12: 0000000000000038
x11: 0101010101010101 x10: 0000000000000040
x9 : ffffa1d388db11e4 x8 : ffffa1d38a7e40f0
x7 : ffff0026da414f38 x6 : 0000000000000000
x5 : ffff0026da414d80 x4 : ffff5e5353d0c000
x3 : ffff800010013f60 x2 : ffffa1d388db11c8
x1 : ffff0026d2a67c00 x0 : 0000000000000000
Call trace:
 dpaa2_io_irq+0x18/0xe0
 dpio_irq_handler+0x1c/0x28
 __handle_irq_event_percpu+0x78/0x2c0
 handle_irq_event_percpu+0x38/0x90
 handle_irq_event+0x4c/0xd0
 handle_fasteoi_irq+0xbc/0x168
 generic_handle_irq+0x2c/0x40
 __handle_domain_irq+0x68/0xc0
 gic_handle_irq+0x64/0x150
 el1_irq+0xb8/0x180
 _raw_spin_unlock_irqrestore+0x14/0x48
 irq_set_affinity_hint+0x6c/0xa0
 dpaa2_dpio_probe+0x2a4/0x518
 fsl_mc_driver_probe+0x28/0x70
 really_probe+0xdc/0x320
 driver_probe_device+0x5c/0xf0
 __device_attach_driver+0x88/0xc0
 bus_for_each_drv+0x7c/0xc8
 __device_attach+0xe4/0x140
 device_initial_probe+0x18/0x20
 bus_probe_device+0x98/0xa0
 device_add+0x41c/0x758
 fsl_mc_device_add+0x184/0x530
 dprc_scan_objects+0x280/0x370
 dprc_probe+0x124/0x3b0
 fsl_mc_driver_probe+0x28/0x70
 really_probe+0xdc/0x320
 driver_probe_device+0x5c/0xf0
 __device_attach_driver+0x88/0xc0
 bus_for_each_drv+0x7c/0xc8
 __device_attach+0xe4/0x140
 device_initial_probe+0x18/0x20
 bus_probe_device+0x98/0xa0
 deferred_probe_work_func+0x74/0xa8
 process_one_work+0x1c8/0x470
 worker_thread+0x1f8/0x428
 kthread+0x124/0x128
 ret_from_fork+0x10/0x18
Code: a9bc7bfd 910003fd a9025bf5 a90363f7 (f9402015)
---[ end trace 38298e1a29e7a570 ]---
Kernel panic - not syncing: Fatal exception in interrupt
SMP: stopping secondary CPUs
Mem abort info:
  ESR = 0x96000004
  CM = 0, WnR = 0
  EC = 0x25: DABT (current EL), IL = 32 bits
[0000000000000040] user address but active_mm is swapper
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[0000000000000040] user address but active_mm is swapper
SMP: failed to stop secondary CPUs 0-2
Kernel Offset: 0x21d378600000 from 0xffff800010000000
PHYS_OFFSET: 0xffffe92180000000
CPU features: 0x10002,21806008
Memory Limit: none
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Grigore Popescu <grigore.popescu@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 70014ecce2a7..7b642c330977 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -233,10 +233,6 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 		goto err_allocate_irqs;
 	}
 
-	err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
-	if (err)
-		goto err_register_dpio_irq;
-
 	priv->io = dpaa2_io_create(&desc, dev);
 	if (!priv->io) {
 		dev_err(dev, "dpaa2_io_create failed\n");
@@ -244,6 +240,10 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 		goto err_dpaa2_io_create;
 	}
 
+	err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
+	if (err)
+		goto err_register_dpio_irq;
+
 	dev_info(dev, "probed\n");
 	dev_dbg(dev, "   receives_notifications = %d\n",
 		desc.receives_notifications);
-- 
2.17.1

