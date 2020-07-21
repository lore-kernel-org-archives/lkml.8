Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D2C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF64420714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AUc/avhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgGUKUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:20:51 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:44134
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbgGUKUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8ZGNpAtBlqwZAnWqtDA47P69h6jp1TcxL9izBLsLIzLkLOPoumjW7qSIIkDcKUvK+l5cqrbQB0peGbaQqS6Sl/0wBi0kPHQMXldjY+iLN56M++WWsZObBaQYZ16bq2w8oycYOxAYL3N+NAPYc7RSY+2uQtlxchAHo7Zqr/U/NVuH8J659TiWvr1HlqYEnKqspJYOOiJz4sYypCzSKrdupKlKunSqAB3VGXysvWc2fwDaFmEb6t2JlNrJpPd9camoxkl9OSxjrqVO+UYicjfWys8TPIj4d5zERxVJuE03iC9OZbge0JDTrGdanNE6IrnbtUXyUmvjb5GIc4OGDjqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OICAasYKs6tuuQnCuX5vQQGpShDzk9ot04EXMf2CSc4=;
 b=MDZkLYAXVtDLBQveQVnWKpAWbehn0Q1tpNySjKk4+BobgXzvQJdIq7C5Ltxw6MAj8HwnKmHAK/pULc+XZiBrpvCexWpaTbKzB13Al0RrWO+21KOvrQ6G7tADvt+1FuTTzerCYp2R+W0ykPL1LFECIc/yjyS/1UdEvXdgcOeF9gAA3RVAR/ZIoAcUxYzJw+Y5eRVvjfiBzSwgNSw+Xl0MhTAO1IqHlEHjkBSKBuoxy/9RxUpXKObPhnleHeNSnlmdub0AIglvx15OU8yP0A/UNakyjGvMk24sGzMG8LAUWG7aZIADOzrJz7Xiy2yMC5XyEZMTwUmaJOyBsop1iPpb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OICAasYKs6tuuQnCuX5vQQGpShDzk9ot04EXMf2CSc4=;
 b=AUc/avhbYeJ6JfmRInLqVebwhhxCw+scS3LY15PIVC8P4lqnWzupWZ6QNYWzRRPoWdzmUSEJLM5VDS+LQWKG/vZuL6DVZYSV0DXW4ZQU+SmPDms6QZy0SZeb2MXkxihL5tpZtzpjVBNKK5OX+gKj+CMPh6/+4GGU1d9HfNEn5KM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR0402MB2735.eurprd04.prod.outlook.com
 (2603:10a6:800:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 10:20:42 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7%5]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 10:20:42 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     l.stach@pengutronix.de, lukas@mntmn.com, agx@sigxcpu.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        laurentiu.palcu@oss.nxp.com
Subject: [PATCH v7 4/5] MAINTAINERS: Add entry for i.MX 8MQ DCSS driver
Date:   Tue, 21 Jul 2020 13:20:03 +0300
Message-Id: <20200721102007.18368-5-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721102007.18368-1-laurentiu.palcu@oss.nxp.com>
References: <20200721102007.18368-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM3PR07CA0138.eurprd07.prod.outlook.com
 (2603:10a6:207:8::24) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by AM3PR07CA0138.eurprd07.prod.outlook.com (2603:10a6:207:8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.15 via Frontend Transport; Tue, 21 Jul 2020 10:20:41 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8929ae7-539d-4ed4-dce3-08d82d5fb919
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2735:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB273563FB575201B8C8EC24E0BE780@VI1PR0402MB2735.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qraJYgzKl+IpEHm3wjGj4J8UcDD3v+IJ9KvJPT4MdbLQq8az6XFW/Lb93evhyVOXaj36cE5V5U4ojYcnELJcLHqt//L+Mm8z7GPcrxZjlNUMxFZwYJjNYvURpNyGsC9eaXJ4uB4KPBkQddIrMgYpEPBEZ4OUaxet9Knhfy0L7DNyRte9PpskX39SxxlQE3+sA21j0J74+TwPixGM2ToYK2uJgCXkKRq5ayrVVMwUhkgCMbLBIztHhx7EBRcODcLHcI6TbmzKAgg82YplL4+wutpmTfLMUMl0pCWuRNsRAXjupPzV0oNMd1A/UCKV1Dr+6+cC3rtD8P8gx3lhC2RRig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(26005)(4326008)(66476007)(66946007)(66556008)(6512007)(2906002)(5660300002)(478600001)(1076003)(4744005)(8936002)(6506007)(8676002)(52116002)(316002)(956004)(6666004)(86362001)(44832011)(2616005)(6916009)(16526019)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tH3DxLzSNjbLeVMkiQXQLOtk+KWWz/NOPBjSy7ceHkkQc1frLBeYfzxKZViTpfBTCoUu4hcDH8GuSB+6ZBaGeDRW9KDbXqhLVPVSfHcapwbk5OcqkrhlEdY30XSwi/rKoNBrcpZtIcIua3eSMbFfcEwWDLNkM4Z0gAdWYGe8BswzA6pbT3OS11IakJpapTOY0+Hn2Qq5lTsltvb/diRzvU6seAF+2H7c5/WDuWr0/8t3xGvh3ztAT2qPjpYKj2F/E9g0X3EwHUYCtsy/qgCG5vajdOvABcJjCoFEWk03zSjTk797u6RjvpquDDRHJ0p6/Y8T4TCbOMh79G8OV3VJ81dpo1zqyIQBczLu27Y77+PzYrHgCVfWMDfjKuXxGZydbbmuRBPh2CxvQPV/XAyQ0uJuWAEYPEhtVvnTi0zHtiWrvNmef55R0HqShcEKkTtm1iC2qE6oJ/w9PSsx/7zPewE6UHnjpeoALyEBku1w364=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8929ae7-539d-4ed4-dce3-08d82d5fb919
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:20:42.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63FhGNsNPdiFXWJvhLwujNL4khZrHX10tCKthWB9tWeMvhoDpoJhN2gHs3U8ZlrxxGgnmK4kpP6XFkjAQBHwnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Palcu <laurentiu.palcu@nxp.com>

The driver is part of DRM subsystem and is located in drivers/gpu/drm/imx/dcss.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dad5a62d21a7..200c5985b41f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12276,6 +12276,14 @@ F:	drivers/iio/gyro/fxas21002c_core.c
 F:	drivers/iio/gyro/fxas21002c_i2c.c
 F:	drivers/iio/gyro/fxas21002c_spi.c
 
+NXP i.MX 8MQ DCSS DRIVER
+M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
+R:	Lucas Stach <l.stach@pengutronix.de>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
+F:	drivers/gpu/drm/imx/dcss/
+
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.23.0

