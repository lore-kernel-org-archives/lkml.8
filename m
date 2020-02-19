Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7825C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD972176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZwCseZM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBSHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:33:43 -0500
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:43140
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgBSHdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:33:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjje7bJTrHPZjpY4BVtHqAatJeEwHoAlVctMkA6Shk1PfYfGBH+hHGetfNR2QOBYGvaWQgOi0leRdY42PeuTNfveFWQ2pssUVFx0jJruJkedf9SjhnwH8iPvTZMMfEsbGK5LvYjlEW8wJSVGtdDEBYnsdYmHZ5LYGtsMs1I+BMI37wuNdXJ87kUdQ1ESofhAprHdRbVt+9uQcLt6QzbRcXF/Qmz0L6RiDie5Id/53FzxILUnTUJXki9WV1wxt80/8utbfAx0KVIlHT6vhHn+peaaMgYR6OxJuDCiGv+m7e3ZnAZ05rn1a/bTRYHNwaafQa8N+7pyrTegEbPT2/m9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoD5Jl6VWwfzmGzqcrWGE6KRJZueYr76YPSmvFnIB4k=;
 b=KxG02GqRdFOmt1XN/wyKK7uCqkOUtMXCoGNNJJE5C0eSJuCAUbh7LxF5rmW2enpFmSYQ7qeVJ6ft4wvSi1WhdxmG9WvdNlluMFbjBrYGmgkd0/Mg1OYE1Ot+CcwGdivGtrZSb1YaFe2MRkAM1oSDRJMWcr4jIbZibUFxOSolZ2uSlLXMerxXa5+Bnh9oVRM6ZWGdg+bLZxpusf7S3ACxdQ42IA5Iu0Y7jkwo24uU1NM2KIixDYvL7ANghb0AHMBCdrhbdRg6X6Tl+JZ9KU8M7zS9YIqdb7+2ZxHBQJUPGrY7tILILteTbfH/8uo8Vtpfnnh1tbIfuxvJgFoYfa0ABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoD5Jl6VWwfzmGzqcrWGE6KRJZueYr76YPSmvFnIB4k=;
 b=ZwCseZM4EbfAv9YTh18Gwq40DYlRysWBujp4Kq3n/VDNHDWWloHSGYgVGji+oyrT8o08n0I9QFgMUgXBsLW5XOHfH0IWUsrd3VYVJ1HJEXi2EkxOtJhdF0jl5YlKTnnGWrfaTwIateeITwUgKlz4MXlaHRDMc+lumYNy9U0CnAg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3969.eurprd04.prod.outlook.com (52.134.95.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 07:33:38 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 07:33:38 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
Date:   Wed, 19 Feb 2020 15:27:36 +0800
Message-Id: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 07:33:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77aead43-183b-4b0f-774c-08d7b50e0903
X-MS-TrafficTypeDiagnostic: AM0PR04MB3969:|AM0PR04MB3969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB3969E455359D0CFF76FDF57488100@AM0PR04MB3969.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(66556008)(66476007)(8676002)(478600001)(186003)(52116002)(956004)(81166006)(81156014)(7416002)(5660300002)(4326008)(2616005)(66946007)(8936002)(16526019)(316002)(966005)(69590400006)(9686003)(36756003)(2906002)(86362001)(6506007)(6512007)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3969;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1KnZ4svoIdhdnsVL/8BAcGJETb4DupazM3KbAUTzqN/e3L1TGLKKKQFsge0m53wPm3EDuDsEI4eidv2CBpgq5z9vcK0yVk8Pawt1iqQiwFjwghI+xxkTNicJHKj62UHa7Rr5n9dsXkx7dVN0RszxeaXvGHhVuNaqJoxIu65GK6BKB0PQiOyAExOHaY7aMD9E29/TDbF3hN7/iUdeRSSRcZlePeHxhlBl1+s6Z3c3rrlkcqT7I49jwlO6oupjRefy3xWueT/C3Xox7H63ThDgbC3dsWaiQTIORSU5dZDZHC+GmGOGm3t78mp0NEkGyKK5sI0GkFaWVWq6m6iije5sdAue4dfHzlX4pq89ipwpwCSgE1SQxa1FGCW7el2ueOeIuPADQPSPb911lKfaa6zoZeAtp9XydIvTOtE7/w4jpnqPdqoZLVZvIewHYEkNWTr6/R4BedCllQAUWQZ++jcNIu5RO3oRULlj2/MiPzAWvB/yXySBmiBuc3xLqXcysbxiP9xjvyTkq4YWqmBuxPy4A2y5qRDektgGoDum//qHrX4W3RJqvRgSSFsZ7x33vI53u6SxmkXyHf8wyG9sQ9wIUcSCzx5/0kJBU/jgQb7nfNK4Y+WqOnDfViRmrc4lc4N
X-MS-Exchange-AntiSpam-MessageData: xxw5pecQue6Y3gc5JrEOLQix0xpsDkq/28jA3Rs1KzamXUhjUpygZkIJXSDs0dZkr7vbYKVF8bT9jj0hIa4fpBi/L4xry9Cz90FbJtDK4pA9vRLgIWM0GEhWKugHUyGH4XNzxC0SxrssZlkwIoQ3lg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aead43-183b-4b0f-774c-08d7b50e0903
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 07:33:38.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcKDb9OK9EluHSgijsRJzyyydinTVtK5zB3iL48+LDY2XV5u+1Qe4r7Y+FT2XzVcHThFE7hZbXZwkqqu9LrPbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset aim to replace NXP vendor imx_rpmsg.c driver.

This patchset is tested with Loic PALLARDY's patch
"remoteproc: add support for co-processor loaded and booted before kernel"
https://patchwork.kernel.org/patch/11265869/,
and inspried from st's remoteproc early boot support.
Since Loic's patch is still under review, just expect your comments :)

Patch [1,2]/9: dt-bindings convert to json and new SoC support
Patch 3/9: skip firmware load when recovery. To i.MX8, firmware is not
           handled by Linux.

Patch [4-9]/9: i.MX specific part to support rpmsg/virtio with mbox.
      because NXP release image not have resoure table, so add resource
      table in dts

My test dts diff for i.MX8QXP MEK, but I have tested this patchset
for i.MX8QXP MEK, i.MX8MM EVK, i.MX7ULP EVK:

+
+	imx8x-cm4 {
+		compatible = "fsl,imx8qxp-cm4";
+		rsrc-table = <
+			0x1 0x2 0x0 0x0 0x18 0x5c
+			3
+			/*fw_rsc_vdev*/
+			7 0 1 0 0 0x200
+			/*fw_rsc_vdev_vring*/
+			0x90000000 4096 256 1 0
+			0x90008000 4096 256 2 0
+			3
+			/*fw_rsc_vdev*/
+			7 1 1 0 0 0x200
+			/*fw_rsc_vdev_vring*/
+			0x90010000 4096 256 1 0
+			0x90018000 4096 256 2 0
+		>;
+		early-booted;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1
+			  &lsio_mu5 1 1
+			  &lsio_mu5 3 1>;
+		mub-partition = <3>;
+		memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdev0buffer>,
+				<&vdev1vring0>, <&vdev1vring1>, <&vdev0buffer>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		vdev0vring0: vdev0vring0@90000000 {
+                       compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@90008000 {
+                       compatible = "shared-dma-pool";
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@90010000 {
+                       compatible = "shared-dma-pool";
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@90018000 {
+                       compatible = "shared-dma-pool";
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0buffer: vdev0buffer {
+                       compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+	};
+

Peng Fan (9):
  dt-bindings: remoteproc: Convert imx-rproc to json-schema
  dt-bindings: remoteproc: imx-rproc: support i.MX[8,8M,7ULP]
  remoteproc: add support to skip firmware load when recovery
  remoteproc: imx_rproc: surport early booted remote processor
  remoteproc: imx_rproc: parse early-booted property
  remoteproc: imx_proc: enable virtio/mailbox
  remoteproc: imx_rproc: add i.MX8QM/QXP
  remoteproc: imx_rproc: support i.MX7ULP
  remoteproc: imx_rproc: add i.MX8MM support

 .../devicetree/bindings/remoteproc/imx-rproc.txt   |  33 --
 .../devicetree/bindings/remoteproc/imx-rproc.yaml  |  95 +++++
 drivers/remoteproc/imx_rproc.c                     | 455 +++++++++++++++++++--
 drivers/remoteproc/remoteproc_core.c               |  19 +-
 include/linux/remoteproc.h                         |   1 +
 5 files changed, 531 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml

-- 
2.16.4

