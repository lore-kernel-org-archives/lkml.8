Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3517C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B1B20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="LOrFnqKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgE2O5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:57:48 -0400
Received: from mail-eopbgr00112.outbound.protection.outlook.com ([40.107.0.112]:34085
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbgE2O5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:57:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bykUg8umGHj5NXJHqbJL6YQjpItdxvVZyxX7z4XgiUAWyw82MI6WJNAagPLZeEWo07/GjprmGQ5fYpdMILclLSbaMSVrYmdvZ/HTmLPUxad+rYi3asfL8dRDGQctcnth/wMh4WOQ2bq8Ai463xu0O1QUI5xM3/NGCogzkpOitV+bkyhlkTd6PZRRDARkL5kUtMe484vsEzgZodjrxQiVSZY2Xud3T711vh7qHeA7jtPHj0EqLgoIV/i1ngKrH6fm2pqYzGAUqVXy4BUPQ3WX2yxQBRn1pIIbEBWyqcBH0GXMG9IJnQWiu/e9vC/D/iYDQL45i/qAxVbJLh0W+2D8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCMnP0nyM331HyJElnRBfI3QS616Ny3EcKlSG2uoTco=;
 b=L/NPWXdu0/T0p+MJg1aHO4LwzeIJQTSW4eeOIRNbdscCrf2HpAzJLeBryWVY7Gd+YaHBUVn84NxFcGc01gBOmAfN7E8ZlfzFlv40wanY12a1yg4Gr/UccyfLtzA8TZvyGk7PCjXBG6pkj+f0c88dejZ6+CLO2Dgo9+fSyX4O0OPzHJJjYaPt7k+V6M2gSz0/DrSwzhH9Gc4UrFhUpgFfmHC5z1Crj8tthVjqtED1UGucmkdEPzV8WBeA9SteS+3lkt4ZzFXj6E76Ja+CVQ+BbUUS34B0tE6kly3NaLrrBrxcCddw1uUH+fPYjJy3fsQxIFkpgMZt/D16fRT8y1at7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCMnP0nyM331HyJElnRBfI3QS616Ny3EcKlSG2uoTco=;
 b=LOrFnqKkN7oJ8i56JsMOwkFXmu3nMo/vKepTq1b5+LLXD1k9Xi2v2BpJFgm4dgJpU3+owxajRM4WwgwwXu6ZYk1RAhGWP0PcNBGcu9SDAfLhlh6rI2EK8Zm4J1SPNkkVKTrxocy8kuxEjQMb8zqbiWfVN/cK4qCyGWtTrxxL+MI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5625.eurprd02.prod.outlook.com (2603:10a6:10:ee::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 14:57:43 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::ccd1:96b3:48dc:c5d1]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::ccd1:96b3:48dc:c5d1%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 14:57:42 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Peter Rosin <peda@axentia.se>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] mux: adgs1408: Add mod_devicetable.h and remove of_match_ptr
Date:   Fri, 29 May 2020 16:57:26 +0200
Message-Id: <20200529145726.5708-1-peda@axentia.se>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0401CA0080.eurprd04.prod.outlook.com
 (2603:10a6:3:19::48) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orc.pedanet (213.112.138.116) by HE1PR0401CA0080.eurprd04.prod.outlook.com (2603:10a6:3:19::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Fri, 29 May 2020 14:57:41 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [213.112.138.116]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e4fb6e-d54e-43b9-33d2-08d803e0a383
X-MS-TrafficTypeDiagnostic: DB8PR02MB5625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR02MB5625B495C4EDD93C59CE6BD3BC8F0@DB8PR02MB5625.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTPJzMTqxAQa0p2HugtY3IFZPMKkFfHdV/oPyMSUAXrk/hDwo1tgYawkQaDQid1aGritGIex+6onOPCHrmJdDmtgOlx3yQaVNSpudyZlPseMGATdY1kvIOn7+oQXIhs+RdlrWjzrzA6mGux5qhj6OKOCuzpcK83P6GNOnbdiTrNM1Uvk3OPqczldTCM+4np/0S8voOetxJUKp5dEGwvQCw4/IFn6e8Io9HljCY6I5d67gB3HTU2muajnLYRGizxfLi7paceJKBWvnj7DP+MgTpfh5Xn3lA+nihnuXcbo1ikCH7SZtKQOFgvJccxVQECO3xmS9/e93wfjmYQB9YhYNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(396003)(39830400003)(136003)(6486002)(26005)(5660300002)(4326008)(16526019)(186003)(6512007)(1076003)(8676002)(36756003)(52116002)(6506007)(8936002)(508600001)(83380400001)(6666004)(6916009)(86362001)(54906003)(316002)(66946007)(956004)(66476007)(2906002)(2616005)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8DCEUiBdzLlJt9r9xWtxBfInLf3wckRn/kqihpbSsGFrS5VrXSux/XQxoPWogK1eHMHd0ciT6OPByyIQF2YISKIQzLMslGdoeZ9cQZCLC47CahM90ULxiQEDS9fFfd9ew8X1UZpQw6JBlsaIRWjkPhigz7pU2o41QpwoQAwoy1sUHagmiW8OPF0WMDhlZdJhOepIrRRcF+BL7BDVFLm11KG/s2VGTSPRkmwzYf+rKWUaA8Tz/1BdFwtVPLtCSsaoKzQTpJKojzNA9fvmWZMeSievK7Vc2agsD5Ra6Bljg22P0tPQztPnHFanMRuP4WpxS0wT3Ymdzf7GSV9ibZJany+tozTedmDPitfztTCdLoqEC9uxsRqtQqTpLCR0lY8BoLmy0K33VS8DHa8y1SKXaPk7SsWiAOYopOU5mfzFdoFQoCmVrz0EXLK8Qj4uqsxbj1owt1nRTlkQgaZq2cCeKt9cOT1q4wmVaowSOVG8G6I=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e4fb6e-d54e-43b9-33d2-08d803e0a383
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 14:57:42.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXa5bVGqmeoAbmNOgmUN8/zKSP8xCnTK961y3VORzPoy9L/oegDFeqqIysmxYd2V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Enables probing via the ACPI PRP0001 route but more is mostly about
removing examples of this that might get copied into new drivers.

Also fixes
  drivers/mux/adgs1408.c:112:34: warning: unused variable 'adgs1408_of_match
as has been reported recently.

Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/adgs1408.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Hi Greg,

Here's a single mux patch. It's been in -next for a couple of days, and
it all looks straight-forward to me. Please pass on to Linus whenever
convenient.

Cheers,
Peter

diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
index 89096f10f4c4..12466b06692c 100644
--- a/drivers/mux/adgs1408.c
+++ b/drivers/mux/adgs1408.c
@@ -6,9 +6,9 @@
  */
 
 #include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mux/driver.h>
-#include <linux/of_platform.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 
@@ -59,7 +59,7 @@ static int adgs1408_probe(struct spi_device *spi)
 	s32 idle_state;
 	int ret;
 
-	chip_id = (enum adgs1408_chip_id)of_device_get_match_data(dev);
+	chip_id = (enum adgs1408_chip_id)device_get_match_data(dev);
 	if (!chip_id)
 		chip_id = spi_get_device_id(spi)->driver_data;
 
@@ -119,7 +119,7 @@ MODULE_DEVICE_TABLE(of, adgs1408_of_match);
 static struct spi_driver adgs1408_driver = {
 	.driver = {
 		.name = "adgs1408",
-		.of_match_table = of_match_ptr(adgs1408_of_match),
+		.of_match_table = adgs1408_of_match,
 	},
 	.probe = adgs1408_probe,
 	.id_table = adgs1408_spi_id,
-- 
2.20.1

