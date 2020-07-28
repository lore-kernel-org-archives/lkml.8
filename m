Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CA3C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B009720714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h3LbCeZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgG1JeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:34:09 -0400
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:7395
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728099AbgG1JeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:34:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhiYYzCI1q8AZ3AaqfPf/vOsEYsU9Szd6WDjwFMw7/UsIhwT5x1ck2n/MvA/2EE9WCre/MKLsvnrYUTxXx6ajHukxS/KYqvvXcIGy8H/IM2VrvKByDlQwPm+iVL7UZqUuhwjnI5h7xPlBgTPkUZg8bXeO6rW7TDaPg8Gl+/RBejMAI2jv96Fuv5qB9BAmpnB12GfZyTPKBRJ5zFrA0EAKyxEGFYl2hQUGYa91xxippt2rrz6s1X2dLmI/Q7K0QXttR//ehev6Bp+jjJrapecQGoaPaSwgs74EAHAdze4Lrrty+2xJPo/QxebI2TQM0AhZnoC/W50nY/L0XLzc4fMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfRm6nqee1zmGaYQWM9juc8qUzO05Kv9PEjJTwzzaOI=;
 b=eTA+2HsQRDty3+U/cEH5fhxafmOcMDzCizqeznO0+O3M2zjCrnb93owseEjHM8zPsaH5zpoc/sfLxVcPNum/UWzi1bEH+PgYqvd/NeEjAtwnJeP6/6u1hCUWnpv9dUOLHT2F3D4oTTEJ54r5m1oZ53tJZhC6r51RkS7aVWVpjN/kGDhpLEdVQAWXchwWIAf8NX2EM6EAt5LiHwZxm07VJq+UXNbMzcwtz3MLQT1GA3HyrSUdgKzUolI3taiWwqF1T/mvxM/KZw9hyHBq4YN61wdyu4U2OmwdUb3blKctucnIp6cB8yqqa6T55GBI4gqUSMvsfwa49F3g1J7nSloTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfRm6nqee1zmGaYQWM9juc8qUzO05Kv9PEjJTwzzaOI=;
 b=h3LbCeZigU32klw1NPKlJ4JQxlCj+HhPEDyDht20hr8ccdaDD3fBp2A1LUzD/42tMhKeA5E2Md5rKqbz3uk4yg1bTTRr9Uojtt8aM3KJ/MqkRf3FLg8R2S8353qcxZJWdXTUd82cSVAyWFdBOUKQEqOUpmCnvsH/IHG2H1DN/EU=
Authentication-Results: wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2375.eurprd04.prod.outlook.com (2603:10a6:4:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Tue, 28 Jul
 2020 09:34:04 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:34:04 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] remoteproc: elf: support platform specific memory hook
Date:   Tue, 28 Jul 2020 17:29:39 +0800
Message-Id: <1595928580-26199-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 09:34:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41692379-ad01-4311-642e-08d832d95e3a
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2375338DAF30E2CA69D00D4D88730@DB6PR0401MB2375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UW6xaqhRDkfoLePyF372+Kxxr3yImEtwnjAWdYLJIlpNvqBW0uCYK411tDdEdEHI321RFWGBvjcW5QPx9RHF+4+qWPwckKq89xFj6EewyLYr/KhSKTnQjq0VcyBDZ1S/Yz2pBQXZ/sy7Hq9DT3kSt0RluajavdtHQJ1Nz0tQvvA80YNr2ctFR3DbHVlT0fK/PNLrt3XXsmT8FvRoGtZjJ/yne3V79UGXFynVnheu27P8OB0qJFdZkjQg6Y52i9bXDMOTTSLefzMhx+8Vu4xx6ha9N5/Inyd2EDivVRAJv+wY2h8Dsz/wlTwoFHKAL91B1aIBCAeyVJnLTVYFlzE9Dp9BaeVx112+sXIdO0q9Ngh1fc+zrZNB2N3qjfm5PvSD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(2906002)(6486002)(8936002)(186003)(6506007)(2616005)(16526019)(956004)(6512007)(9686003)(66946007)(7416002)(66476007)(66556008)(316002)(6666004)(26005)(36756003)(478600001)(69590400007)(52116002)(8676002)(4326008)(5660300002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0tHxOCi+iYWWb+MuZrVcWIfDPwWVVPlpOeHnzyCXQGkzCWdO776iKlfLY/zm2K7Pim/rYJaMtu3fo5S/4eRF6LTu8EMiYWVlrDk/p/E3Ya6wanjrqr0jwIard+fJzl7XCx0nvHgxgvDNZy5J1vadioSGZhaILMbICjFbkpXVwKdNuXNbOPNTVKrucA4f4MPQtRAfu+chIjEzn+SDScRckdRfRTTF++i4NCg8w/Tn2pOR1DBvdnmdNRRWslesdJ2c9+f/ep9yM6ohV39wTpVcQLj0r4ugWWW6HWMrRQrZB4XogLhOCkCWfRLOkCIV37J4ifJBIabwgWdh8FvKuYKSe/rDP961CdqnK/ZFC2yz3DJgDyq24F+BzCP6kGOdDmdnbTziI9/+ckPqd/wSazXBuEEO8kKymZIhvyT29JSgk230CrvzO1flsedP+buRZ1VEMX0O2iSw3ZXEO08M/gjrTIBJJVVnpeCPQgR9wsgJDOa15vNOQsIfaDUiSVOper0Y
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41692379-ad01-4311-642e-08d832d95e3a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:34:04.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W7IoptmX5aKMWZcwmjKvoEKBM0xjrZqI2t0suKaWxdmlcMzUrCBcFY+v2S3daEXYrFnXcHPw07kXroy7VlTjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To arm64, "dc      zva, dst" is used in memset.
Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,

"If the memory region being zeroed is any type of Device memory,
this instruction can give an alignment fault which is prioritized
in the same way as other alignment faults that are determined
by the memory type."

On i.MX platforms, when elf is loaded to onchip TCM area, the region
is ioremapped, so "dc zva, dst" will trigger abort. And ioremap_wc()
on i.MX not able to write correct data to TCM area.

So we need to use io helpers, and extend the elf loader to support
platform specific memory functions.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 20 ++++++++++++++++++--
 include/linux/remoteproc.h                 |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index df68d87752e4..f442bac64432 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -129,6 +129,22 @@ u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
 }
 EXPORT_SYMBOL(rproc_elf_get_boot_addr);
 
+static void *rproc_elf_memcpy(struct rproc *rproc, void *dest, const void *src, size_t count)
+{
+	if (!rproc->ops->memcpy)
+		return memcpy(dest, src, count);
+
+	return rproc->ops->memcpy(rproc, dest, src, count);
+}
+
+static void *rproc_elf_memset(struct rproc *rproc, void *s, int c, size_t count)
+{
+	if (!rproc->ops->memset)
+		return memset(s, c, count);
+
+	return rproc->ops->memset(rproc, s, c, count);
+}
+
 /**
  * rproc_elf_load_segments() - load firmware segments to memory
  * @rproc: remote processor which will be booted using these fw segments
@@ -214,7 +230,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 
 		/* put the segment where the remote processor expects it */
 		if (filesz)
-			memcpy(ptr, elf_data + offset, filesz);
+			rproc_elf_memcpy(rproc, ptr, elf_data + offset, filesz);
 
 		/*
 		 * Zero out remaining memory for this segment.
@@ -224,7 +240,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		 * this.
 		 */
 		if (memsz > filesz)
-			memset(ptr + filesz, 0, memsz - filesz);
+			rproc_elf_memset(rproc, ptr + filesz, 0, memsz - filesz);
 	}
 
 	return ret;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0e8d2ff575b4..88fc9643c1a8 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -391,6 +391,8 @@ struct rproc_ops {
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
+	void *(*memcpy)(struct rproc *rproc, void *dest, const void *src, size_t count);
+	void *(*memset)(struct rproc *rproc, void *s, int c, size_t count);
 	unsigned long (*panic)(struct rproc *rproc);
 };
 
-- 
2.16.4

