Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23810C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DCC2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="d761aF6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgENLvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:51:45 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:6114
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbgENLvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:51:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfBqXeqYn+X58gBB0n5LvLh0NnWmRx40OzKRHcfaIApXNhtdRpBdeEyYy3OXhDSWlVgB5RBaVU9e50EHBZ4uKwvL29u3zN9vG16LXCAFSVjdJbt8A+No0t0lau4BEO6/i3KvcqHp6p2MGK4DCxtgAMkPTF4Wug/qgNIA544KX6dCGKWeLZVkTJKwrJNyRAhh2R7rkyIM44kK2L2VpDOrtoaUM2qiv6MCNJy1QeO2YjcPWS35Q5aWgzr+DDsBo/8j0qjhbT3GhhCGZAdmKNHsiTXKbF1+3O33GXRjeDWNo7ltv5+tfBlm0cwfI99757pvsNGacfYNozPIQo/ZnOSViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuwNckBsREWK/wRm/JNwz4peDmzIsWTpLA7jtPQWozc=;
 b=Dq58agJh6Yc60MsgLC7HA//h5hJuFabdPEiCnRxDtNY2/9sFkRPmCe1npc+QYyLSKHeQOeAOy97mZsmphF2UZjs6+rwu76LZiRkrRVSBVAvrku6e7pksGo+GIVHjiwoAydlVQFrHchw+6/CWTdcuiGNTDcAZG0Yq6fSTZ39jMlSVsXaF15qEACN95ooItuDNT4yECcx/zLezLn79mRvpzhLrrxyl0kmWCkJc+F8nt7ralCshT2yXXp+UGjMbWe/6oQcQgcJnPbyk7OV4n9LkwRFl/H6CddJ+NMrkA7jkEAEFUnvgkPYEgKQSY30Z8LqUc3yIZ/NXTFj/Bp9spk4nxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuwNckBsREWK/wRm/JNwz4peDmzIsWTpLA7jtPQWozc=;
 b=d761aF6NzRAiqao5PNTGdWR3DHL548ny5bvYzMrUqcs0MWLY/WfBmJt9naavEODyWJ0+K0G887cNR8WSg2XNLffbuJIEoI8DbtlVXFmE6/5dDMF3q8OmKa7YbGkRqE8m/pr4WbwF0vWbOR98H1/d7fMWna+oFeqrbkj0uHjPflg=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=sifive.com;
Received: from BYAPR13MB2614.namprd13.prod.outlook.com (2603:10b6:a03:b4::12)
 by BYAPR13MB2469.namprd13.prod.outlook.com (2603:10b6:a02:ca::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Thu, 14 May
 2020 11:51:28 +0000
Received: from BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6]) by BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6%7]) with mapi id 15.20.3000.013; Thu, 14 May 2020
 11:51:28 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, anup.patel@wdc.com,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 2/2] spi: nor: update page program settings for is25wp256 using post bfpt fixup
Date:   Thu, 14 May 2020 04:50:51 -0700
Message-Id: <1589457051-5410-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589457051-5410-1-git-send-email-sagar.kadam@sifive.com>
References: <1589457051-5410-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To BYAPR13MB2614.namprd13.prod.outlook.com
 (2603:10b6:a03:b4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR08CA0053.namprd08.prod.outlook.com (2603:10b6:a03:117::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 11:51:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec432bd-7271-4dc4-ef23-08d7f7fd2324
X-MS-TrafficTypeDiagnostic: BYAPR13MB2469:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB24692E8D33BE1BA384BF772499BC0@BYAPR13MB2469.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGHrCmi2SKIJBp8FybCzGXOuWFeMbBULex3iU3oBbCy6yLEDMbqIBOAqTVaYY/84WccGSx9Hw57FdHH7vlN4mm5WhUze9guHvITfJy5eu83AIPnnZYY+Yhf2AgYZli3OR4PDG3XZboUXxLx0l+Z7xzNsgb39/meMTuyzL9m74rfD+xGtlW0X9gNdcuI3tVQnR+0840y1BusYi7EuOW3x6dcYV9tQtG3Y5xjiI0/ohL5HQCiqdAaCGV6yFQ0De6SQU9qN3Z2m1QL+6bNAUspR1py3Re+/tw2068Z53XWmbpSgN7OEBl6GuTGc91OIF9/XfIQopT1PhRjCo/Bw80m6qek+DWv5Nv6ETc6o26gFVzci3xcseXmUnUUfwVCMRr6iTVEqkFVMhJ036vYiam8jhQLYvsORKYXejjy8OkEMiBr8y3RxvL2Y6P0rOwFvTMWa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2614.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39850400004)(376002)(346002)(136003)(8936002)(186003)(4326008)(16526019)(2906002)(5660300002)(15650500001)(107886003)(26005)(66946007)(8676002)(7416002)(6666004)(478600001)(2616005)(956004)(66476007)(52116002)(7696005)(86362001)(36756003)(66556008)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aMPpT3zStYBL+aL4e/tHVglJByIuBDDMXxdxh6s/fuaUG20pnztlcEpsasf6KRJe/ugGQgrUpcgxhcLmhclI0D11vTU7PSG3W1RQRPExinCWfRRB7zDdLN84IU9qjwU9PVlverdxc9qsQmT8tJnEzPKhY0IZHlqWIveqwPCHjsJnY9/JVK6Q0odl8iNN5feWojDh78g4NUVW7kjVzdzRRrqFanLILDCr7ZjWYKtBOsmgIX6PhKeC4/ztK8XkAy01+38y3zkbqjz5Vr6nIQB776VS2KB3RKdLTTTLMI0fmchV4vHB4QQHA/a15GZK0s4clKxrRvxsiwYvrs6MfxrZ/zGjtfiZ6WzTh7AqC5mM5ZK4RRkKcytb14HKLqPC83XlI8g8Vtg4sGVwRjufY8IBszU5Rz4R5LIisdRwjokE14aazQlF4eqkBBk7fqwbL7gNy5JMpOa7TEu+RXJlp8ZbL4FGi3RXuouFz2iLt9vvEEw=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec432bd-7271-4dc4-ef23-08d7f7fd2324
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 11:51:28.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVKPJmtl8r2oinKhCS8scHqM6/tkFz7Eowxr5pZuzgGMXsXYLndzGUYk0OeoUKcnDtUf4B1H9fuUfeB2I9j/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2469
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

