Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D48C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934D52089D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="dMwz+HNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgGBOFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:05:54 -0400
Received: from mail-am6eur05on2100.outbound.protection.outlook.com ([40.107.22.100]:43201
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbgGBOFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MunJuAj5ksgVJRQcnJaVFtxmwmfsWhdJ1goCFPv7Jsz61j2ZiSNY9Dt55rCXhLzDiQpGYoMSfFGnnUvQotJ451F6p9IhvRJRmlydGDqvL0NOwAaWw8rLH83cUYFiC7HgIFWYWhoYXQ7nk2S1XYrk2wPJF8WssDoBJnc6oyPf4aYT8Z4W6Wrv2zSdPA09fuYKz2BpSXNGCO/5mTMc+VHk6oHbW6NpUOEmalfTqVnZTmTD5iw9eiDxjN6+SjCSCuUmgz7j3EGyRGGTBP61riiwbQlO+lAxJUo23OU/xeTIpIOywlOLhDOuPTjUER6dX/zIIKGVLv8tG8bW592vlvrw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wLCWd5bmqmtpUSt2p9Fg+Zu1/TY1FGbB9fTYcGSaBY=;
 b=SAdU8Ef55+XpF6WAZjDHaP2wMtfSvhEnSDQYMvRrws6lLQGk9pCMShk4FDfp4Hram3qJo3DSCNWyiS6NZaMwlC5ZBtu5MVgYu+LwhzpQjng7w5m62anUZAOfE4EMrj1hte0oLvmUK70ltdJqYpfgc5q/crleNdLPIsSdEi1DDTXOSVnknnXcQNNRLp2EOUGQSJ2bzGROF88orHuYEuo1C/EAiP0Fg5gWGOTKft3BBuJmzIjOB+86dMbXBiTu9BoceXoMP12ue5KjRGxcxjTtn1Lpi7IALFBiIAK6yPIz9dvBaOyjF/aozDsQsp5E/2+2rg+5O3DLAMTxvJ/nWbmfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wLCWd5bmqmtpUSt2p9Fg+Zu1/TY1FGbB9fTYcGSaBY=;
 b=dMwz+HNgN4wcVa7JJVt66mlLcmRvWZk0i9gKrcyE/DlXWzgbYojoo94q7x8ZxO2uIfX+pVpdzCIsWrPPAcw0Kgo8Fcbx5xMYF1wK4cCSZV/zVjNcYem79ii2RjJOjNJhEQocJ7awIUM4eFBr3dItKc+jrxT34Cxg73bnPlS29dI=
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 14:05:50 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:05:50 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd: spi-nor: Add support for Macronix MX25R1635F
Thread-Topic: [PATCH] mtd: spi-nor: Add support for Macronix MX25R1635F
Thread-Index: AQHWUHnkhm0KGucB80SMpr/0kNl38w==
Date:   Thu, 2 Jul 2020 14:05:50 +0000
Message-ID: <20200702140523.6811-1-frieder.schrempf@kontron.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none header.from=kontron.de;
x-originating-ip: [46.142.79.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a2e70ef-7e11-4073-ccac-08d81e9106bc
x-ms-traffictypediagnostic: DB8PR10MB3211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB321170F7A62848A0D8FCA2F7E96D0@DB8PR10MB3211.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PguM3HAS7oo8aZUXS2L6aTDjMcE/V0DY6QMzMvKxYlf8qI/XX4ITCiicQA47GDYVTQlYXg6Ta42RpJURwrZSGQUrKiPaPCT3gYb6PPNAlpQPXY9DCP+c8xpbQiobHYsaTIOrEltB8i0Ot4a4pyVEA5n6w9qTZ8HjAAf7PsXM2jYWwReQaM8kw/hm3D832b5hSTws5n18VTiDc3xfy6T5ttMhvwM+LJMISwSYQgfmkuywFFVMhO69hgndUuQ5BFO4rAgt1VsMSnsBNfyRmzYS5e36sLJ9slwkT6u7ML6CQqBTm8ZrVDo252vwd0/naZT6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(8936002)(1076003)(8676002)(26005)(5660300002)(186003)(66946007)(64756008)(66556008)(66476007)(66446008)(86362001)(2616005)(36756003)(71200400001)(76116006)(91956017)(4326008)(2906002)(54906003)(6486002)(316002)(6506007)(6916009)(6512007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BRz4XYNqB2LhetPntB7GlpeyiA4cwIWF0yENH0pzZrtx2Z3rxOeYA5/JdLVw78Y2jrgW+B6+YbWkLBZfuy06w0oqJH6aAmve6CIT1sNR1Lo9MhR5Ld2pP807I0KlxdEIkEcO9OMf+WQfNVX+gJUe3PxThjP5ER61RVs5VM/llKkVn8uLzj9Pt1Xgg3gPFH/8P2tDAKukXcR65nnneYWIPtALZ1VG+F++Wvbd8WBR/lGo3qWHUFPxEoUGtbzI3eT/MXcRPaER07c3MG6DQ8CrzigwEWHlHhncYpKM2FqVLKoQP/UYJkZw02UzRw5iwKVCLCJJRsML1pUn1P7VdkBg2+2rY1aJIf4V8hkmuhuO15Uqezt2m1nONeynOhsQYzgrMk32CYeqpQ50fUVdgXLRU0U3QxCP+SlLmHvgMWGRCb5eh3y/o7s9dyEOboZG1a6JU3Uv7aNAn576gk85dQVJ/iz4dET2crZMtar7KhQXK8k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2e70ef-7e11-4073-ccac-08d81e9106bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 14:05:50.3733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0U7//6McMAzo0/R/16KiaRNNvmYpSjN6KKxgaPXlf0/duRG7XDJiTqLspfQBSElljRtqrXuOpbrFpwDmkyNDDS0lygb8fi3CVWkdbsghToA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The MX25R1635F is the smaller sibling of the MX25R3235F that is
already supported. It's only half the size (16Mb).

It was tested on the Kontron Electronics i.MX8MM SoM (N8010)
using raw read and write from and to the mtd device and
the 'flash_erase' command.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/spi-nor/macronix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.=
c
index 96735d83c77c..0ae0815a3633 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -52,6 +52,9 @@ static const struct flash_info macronix_parts[] =3D {
 	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
 	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
 	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
+	{ "mx25r1635f",  INFO(0xc22815, 0, 64 * 1024,  32,
+			      SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 	{ "mx25r3235f",  INFO(0xc22816, 0, 64 * 1024,  64,
 			      SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
--=20
2.17.1
