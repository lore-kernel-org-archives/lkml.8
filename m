Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84542C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D84A2137B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="A45vD+jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgD3J7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:59:31 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:6038
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbgD3J7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkMDh/KHI/zVKcQe3v5T8K72KmwdEiTjtsyTjovPnNdDiWzW4v42BvabzzZDjb1NwzTQIbOpfBdzlTmuK9652fSRd/0C2VwOs9DOO0W8dl1q9Qo/hA6sV4p5BfhgUBGr1qsHfl7GTlHCXZgau+CC6ujUHaxZZqv9ObOdYbAik053qogtG9MdbZbTVS6obJYQObWzEfBNBniEL41kA/3UPoK7mKeq1uxzfY0w9b3V3niffCq7om3QIqw/mzdG2QRzV4WJu02SSoNsRAp/f76CFufjAWiyIM1y7EKLTtlu45Qh8Y/9LvyDLOpN6YaNyGRV04juTpaAiEWzo3YVU5tbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuwNckBsREWK/wRm/JNwz4peDmzIsWTpLA7jtPQWozc=;
 b=HCEyASXvbRDmCuZZYQzjEQxUr1Dp1K7wu0XSGujdhpvHeHbjhhLzfX2FEVYz4KjnA446OALwVpglxTdG6XmM4q8GtjE5AY+lEJy8RtWFLFoDmFiCjwk/GTQUePzW9gASMC1MJu1rf7raElMrZE0hPAugCzDmWLflVn+s9kAU80ONdRKCgE2CAqNFvgFFYZ+1nTX/lyp60LMAUKSX8Pm94pvrbufpyG2HoX+rY3C/fduBWNxjHvzS+L3oyu0B53cyvoM3+aJz5SUNL7Hi7TVMzpb6XB6BiorIgpMwoQcCmcnzTcMRM96mUDP98xXRZGTp25+bscTij4RiNpOsU/jo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuwNckBsREWK/wRm/JNwz4peDmzIsWTpLA7jtPQWozc=;
 b=A45vD+jgQEb57/hjknxvF0cThvKZ9bbAErIkg/DEVFJba+vn3WvouE7q3Mh9eEJnjfj16yUZQQuJRXP3OKZE4Ov4h/4naUHV+zSuWuD/n0q+j5JS0kd+wnhG6hxibLMr5xBPF+LlRANWaUN//05pLgiCcLnEnOBuPiOpKhg8uYg=
Authentication-Results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none header.from=sifive.com;
Received: from BN8PR13MB2611.namprd13.prod.outlook.com (2603:10b6:408:81::17)
 by BN8PR13MB2884.namprd13.prod.outlook.com (2603:10b6:408:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14; Thu, 30 Apr
 2020 09:59:21 +0000
Received: from BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929]) by BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929%6]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 09:59:21 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH 2/2] spi: nor: update page program settings for is25wp256 using post bfpt fixup
Date:   Thu, 30 Apr 2020 02:58:52 -0700
Message-Id: <1588240732-13905-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588240732-13905-1-git-send-email-sagar.kadam@sifive.com>
References: <1588240732-13905-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BN8PR13MB2611.namprd13.prod.outlook.com
 (2603:10b6:408:81::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 09:59:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cfacc88-ae92-4046-6b0e-08d7eced2782
X-MS-TrafficTypeDiagnostic: BN8PR13MB2884:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR13MB2884332FA4DDD5A640EFA43299AA0@BN8PR13MB2884.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Uz4U0VX63iZOcmwNEfpkQHtbCmDIexKsK7lhUWgJZw4SfqpGSZuv1IV75Hdux6otjS2H0DLwnBd5FplDKz4Xe/ZC5Gcq6UGbresp+jsTY4Ppj4SrGwas32ryCZxSnX+LkaDbVtGVjUhDS5/Gwt7DZGRo1UQZsBw9ycOmgCfnIrs7NVNNnUA72CuRnwSyhIuUmLMj9Y0QRZn3d8gsVMaxU+SsU5+q3/kRJDcCOg3+DHD3eUsKoR6n3Ks9KB1SNUF9Rjvr6TS5T/YrCcwcLgVG/nSdfU6tWGIOv8KRUFgcHAURsWRetUOKdYUjRtIOSFY2jDrAejIErtVH7J9mbfcZgVQ2qFHVlrpaYGf9ppJYEFp2TxhR9ULML6GoJZiSyw8Y89xQhhMVKd35JAbudb9B6Uz0KzbF47wY7Ssge3Hm+OfM5jXMdMISqnGEPTiY+Ot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2611.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(39850400004)(396003)(366004)(7696005)(52116002)(8676002)(8936002)(16526019)(186003)(26005)(5660300002)(956004)(478600001)(2906002)(2616005)(316002)(6666004)(66476007)(66556008)(66946007)(86362001)(15650500001)(36756003)(107886003)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MgeCjNPMxNVPp4vjAQfJe9uK8TtX0KSHJJxcI21dPrkFcpp+IJEL+Hj3YVkfvQAF3CxEzL/Hpj/HoEmKBN/legrGQRAM1Z2ob087UjkREhAEbEypt/AxD0a/a8FyItIeSYB9FRko4YWd7EZ8ZAgxzZ7wgLWyU3tw0xxQMN6cMW8a03VdVyc97Pi4qMU3rzr7e9NYr4EoSG5YtfWG8Our+D1uBlLNNC/liFcJ0cOeKwrjarsls0F3pq3wMMOEhr36CSy+P0s+y6PdMLkjVhe4d5t+4RWDSZji1Ad5I7QSgC1BYkngGtnTD1SuIf5Twn4CQXq4TYIiUww/stgebXFr+x7+yOSmxgLQ4d8QUFxdUxP/mU+LuK7WLaqy/M0F6COqPqvxsCj7zSwyfaaUhAiuYvjwqrETKeJFIhhlrfa9P3yoSCZyrdofYByeQoz+VDWbsIyeKw/d1BzA/0k0zkXGtP3F3aAOHbp+HUBqtU2de+YWeGroiYodDdf1hACxO3Wj/baTwAT/nJSx1m3MuwFvhYzA6A7/oT4Vq8R2uduQzM/9NZwYXXiQeWReOLjYOJMTdgXj48JAMcncwtzkWP5zjp4zDutwSOlQA1OWQ3KrTIMCnsypuw0uF/V17brKIiAIeW3GS1ygAEUzOnqFGokOyaUHrSZoRF0rhmzwL25cGrQVOfKGk8Tv3eRoaFar1LduZLaC6lLDYcdQHtiadtGvJi49FE70vOTGUygaGzmM8ieCNJPCOwgriBqVAiD4WESNvirmFMbiPGRhljV/WCbXuk/2NBWZPQlT289O8mDz3I8=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfacc88-ae92-4046-6b0e-08d7eced2782
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 09:59:21.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqTe1ObbgXWmuwEDM4quTXlvnhomtKTFVF23Zx1vdN1Mc6mllkoE5DlwpPo4j8WgjevLOE74VF2uoR/XuiUp4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During SFDP parsing it is seen that the IS25WP256d device is missing 4BAIT
(4-Byte address instruction table), due to which it's page program
capacity doesn't get correctly populated and the device gets configured
with 4-byte Address Serial Input Page Program i.e. SNOR_PROTO_1_1_1
even though it can work with SNOR_PROTO_1_1_4.

Here using the post bfpt fixup hooks we update the page program
settings to 4-byte QUAD Input Page program operations.

The patch is tested on HiFive Unleashed A00 board and it benefits
few seconds of average write time for entire flash write.

QUAD Input Page Program operations:
> time mtd_debug write /dev/mtd0 0 33554432 rd32M
Copied 33554432 bytes from rd32M to address 0x00000000 in flash
real    0m 32.85s
user    0m 0.00s
sys     0m 31.79s

Serial Input Page Program operations:
> time mtd_debug write /dev/mtd0 0 33554432 rd32M
Copied 33554432 bytes from rd32M to address 0x00000000 in flash
real    0m 35.87s
user    0m 0.00s
sys     0m 35.42s

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/issi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index ffcb60e..9eb6e82 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -23,6 +23,22 @@ is25lp256_post_bfpt_fixups(struct spi_nor *nor,
 		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
 		nor->addr_width = 4;
 
+	/*
+	 * On IS25WP256d device 4-Byte address instruction table doesn't
+	 * get populated and so the device get's configured with 4-byte
+	 * Address Serial Input Page Program i.e. SNOR_PROTO_1_1_1 even
+	 * though it supports SNOR_PROTO_1_1_4, so priorotize QUAD write
+	 * over SINGLE write if device id table holds SPI_NOR_QUAD_READ.
+	 */
+	if (strcmp(nor->info->name, "is25wp256") == 0) {
+		if (nor->info->flags & SPI_NOR_QUAD_READ) {
+			params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
+			spi_nor_set_pp_settings
+				(&params->page_programs[SNOR_CMD_PP_1_1_4],
+				 SPINOR_OP_PP_1_1_4,
+				 SNOR_PROTO_1_1_4);
+		}
+	}
 	return 0;
 }
 
-- 
2.7.4

