Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEEAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EEC2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gK6UcSR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGTJG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:06:27 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:30692
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbgGTJGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:06:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXU+A88MGUnBsNxUtKNFjKCZciBhPvVqymPna9lhIdFZxYokENMmE0b55x211Hoa7iah5ujscx4kas7nWIBQwivND1AoE1umrAIQqIq0tBNvoHhtqz3ARWP/1Exxd4MPL0u6zEKQZHu/TiXKK+bt9m6JmhZOHUNWsIoAajPS7zxf3LAfuhfCm25gTL9d1HacwFsQqUT8vcTznYaFonavJXCNXG/PStGFr9rybvGBJLjTYizbjfwgJH88ZXDWfT9Xxr2oMs0g1m0+DgnC9COF4gzf4/+N5LkphitA+gc+V3jDZormcyfBcGn4tavXnjFmiXxCh0pCmV+F1CN3Do6NLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sTL4e494V1QvSQiJoYNmQB3UtUzHuuJKU/0gefoInI=;
 b=F9GLwshOZH3/Dnt4q8QK3kfQ5LFwQ9sveQVZHBh3MADp8RaBpwROPggiPN1cQLpGDU08buYS/h7Jd7IpzHHaZH15ZZ0cJOfw99882UcEcqKC5NlVjfta82D5Sy+q5E4AZFpOCDqLgUySlbKHAZQHA2AGSKaBezyr2hGJOYXRE5cbl8gBCfbjIV2NQXfgLWOR/Ukbd7DIpAQsU6x2QIOdZG9A3JfMFtFrJNoN4HDNGDBgVqGZ2GnEtp6YOo7pRvMzyoA8ljVWhAIG7PiC4FVN26QZda++/XwLEVcTkNR58AgymvNUj8Ssz8Id1ThrZZs0ncdW54FjdKdD95ff1/mihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sTL4e494V1QvSQiJoYNmQB3UtUzHuuJKU/0gefoInI=;
 b=gK6UcSR/GSIPtO1TMmtYaAv4XLNkrTIemQ6D3G2o8vbVTrzXc5mqxg4iUp6srxhSqSnR10BgM3TBCbnLVOmx06ydqX96hEgSt0hxNC2rDR9s0VxDyaltQFgn5rC3cU9UEP6Urj3anvgC5cjUZnd6St4rx0S/UHd9pjkjAHSu75k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR0402MB3762.eurprd04.prod.outlook.com
 (2603:10a6:208:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 09:06:19 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:06:19 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH 0/7] Add support of SECVIO from SNVS on iMX8q/x
Date:   Mon, 20 Jul 2020 11:06:10 +0200
Message-Id: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 09:06:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36e39c94-15af-4a95-0881-08d82c8c2a51
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB37625F2E7366986C041ED0B4D37B0@AM0PR0402MB3762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkQ3YFTX31Cik71wiZ+OGhcGD7lNXrxviJ714H27z3wuMguwGcbcziNenIxb45yHkPW5pw3nUQjSluQyOpSzSdbJPtEexC98k3KcCQnIEEOwtBiYxnxe9ktSI/k9kt1jmM47/Ca/K/Mhovv28YCziMN1kzojg9qSTJHDTIUY/aQLzbHqMIFwof/GuPkYPk6u0BGYv55RLKPLZ9oT5zOhiRpjzpb8gT/gXd4E3BGsHLrdW/wTnB7VV+oRltb46tIAqKAcCIaS12MXAj0H4P1kKjHuvfn8E+8Y8+YTPa9f0FsLHlakT8u5uoR07EGc9kPKGjfkdsIudWjhcLm7oC8N+Dsor9eN6vy7HpWdvEIZ+L+mTw3diiAx7pikzwNmjqZu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(6512007)(316002)(66476007)(66946007)(66556008)(2906002)(6666004)(9686003)(8676002)(8936002)(86362001)(83380400001)(5660300002)(26005)(186003)(16526019)(2616005)(6506007)(956004)(6486002)(478600001)(52116002)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LkXQE8mVU8hv4vcQbKFoM4pgdRj3Q3mBCzoznLZ1ih/h1JwqJOQXUXZ0I+40TJQev4WPB7cFitnuBpeeB5rkRp/CVh0xCy/EwmTfOozTe35CYV77ZGsjFrxvS9H/J54w6uKjw11joLz900EGF94IIhHD/JVfIWZ1bR7Fab+odFB3PFobgUSPuH1/KKZ2/uYcaQJW+8gAb/eD52N5i0mMw1oZoB7EUR1dupUXM8bWEBPE8H6lLqLxoCquJpdFtwx3iEJEFYnQ9YCyT34no22XepJorSPvpOuNFmtCA4JD2hJgF/CDWTbJUQlgoPxdUpKdHM8S7gAYI1QQsn7eROJfUufaq5HSe6qQZ7HyIHZRZbDmAyZLgbMtyXHk3mdGnsXQYurx/RHXfAnBKh+t0h8OcTZeFVKeMji3AtxTWMvxUI1ax/gIS/TVNh2ZP9ReKDzWM+35UWGta7Gg6Dk+Kgix02RCNxauDY+jDfGLd+Z+D8Y=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e39c94-15af-4a95-0881-08d82c8c2a51
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:06:19.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kk/t/VbT7pz4rQZax+ar8ARbcL3S4qsM01vxOlbG/eU9xKNYE8iEGd/8odTyEXEZS2SMAVoMQKlr4iUQHVgbvMwtNVR6cmCssyqKuG7SXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@nxp.com>

This patchset aims to add support for the SECurity VIOlation (SECVIO) of the
SNVS. A secvio is a signal emitted by the SNVS when a hardware attack
is detected. On imx8x and imx8q SoC, the SNVS is controlled by the
SECO and it is possible to interact with it using the SCU using the SC APIs.

For the driver to communicate with the SNVS via the SCU and the SECO, I had to:
 - Add support for exchange of big message with the SCU (needed for
imx_scu_irq_get_status)
 - Add API to check linux can control the SECVIO (imx_sc_rm_is_resource_owned)
 - Add APIs for the driver to read the state of the SECVIO registers of the
SNVS and DGO (imx_sc_seco_secvio_enable and imx_sc_seco_secvio_enable).

To check the state of the SECVIO IRQ in the SCU, I added the
imx_scu_irq_get_status API.

The secvio driver is designed to receive the IRQ produced by the
SNVS in case of hardware attack and notify the status to the
audit framework which can be used by the user.

The goal of the driver is to be self suficient but can be extended by the
user to perform custom operations on values read (imx_sc_seco_secvio_enable)

Franck LENORMAND (7):
  firmware: imx: scu-rm: Add Resource Management APIs
  firmware: imx: scu: Support reception of messages of any size
  firmware: imx: scu-seco: Add SEcure Controller APIS
  firmware: imx: scu-irq: Add API to retrieve status of IRQ
  dt-bindings: firmware: imx-scu: Add SECVIO resource
  dt-bindings: arm: imx: Documentation of the SC secvio driver
  soc: imx8: Add the SC SECVIO driver

 .../bindings/arm/freescale/fsl,imx-sc-secvio.yaml  |  34 +
 drivers/firmware/imx/Makefile                      |   2 +-
 drivers/firmware/imx/imx-scu-irq.c                 |  37 +-
 drivers/firmware/imx/imx-scu.c                     |  24 +-
 drivers/firmware/imx/rm.c                          |  44 ++
 drivers/firmware/imx/seco.c                        | 275 +++++++
 drivers/soc/imx/Kconfig                            |  10 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/secvio/Kconfig                     |  10 +
 drivers/soc/imx/secvio/Makefile                    |   3 +
 drivers/soc/imx/secvio/imx-secvio-audit.c          |  39 +
 drivers/soc/imx/secvio/imx-secvio-debugfs.c        | 379 +++++++++
 drivers/soc/imx/secvio/imx-secvio-sc-int.h         |  83 ++
 drivers/soc/imx/secvio/imx-secvio-sc.c             | 873 +++++++++++++++++++++
 include/dt-bindings/firmware/imx/rsrc.h            |   3 +-
 include/linux/firmware/imx/ipc.h                   |   1 +
 include/linux/firmware/imx/sci.h                   |   6 +
 include/linux/firmware/imx/svc/rm.h                |  69 ++
 include/linux/firmware/imx/svc/seco.h              |  73 ++
 include/soc/imx/imx-secvio-sc.h                    | 177 +++++
 20 files changed, 2134 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml
 create mode 100644 drivers/firmware/imx/rm.c
 create mode 100644 drivers/firmware/imx/seco.c
 create mode 100644 drivers/soc/imx/secvio/Kconfig
 create mode 100644 drivers/soc/imx/secvio/Makefile
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-audit.c
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc-int.h
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
 create mode 100644 include/linux/firmware/imx/svc/rm.h
 create mode 100644 include/linux/firmware/imx/svc/seco.h
 create mode 100644 include/soc/imx/imx-secvio-sc.h

-- 
2.7.4

