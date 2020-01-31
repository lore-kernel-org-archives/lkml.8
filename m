Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BFCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C77206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PAh2phsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgAaPfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:35:51 -0500
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:48709
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728922AbgAaPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:35:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAyyS8PfHBM06OldkNOA/b4rRMht+JIxWPK8Z0rAzNC6xDdwgbxryek553ns7m4jH6HYMsMLJHnbCu3Ks5kKOgRFJp5ooQyw9YI0Y4OA1DZJgjbn3toEDvOW0CZKiFspAPK6K2wp6W922olE4S85EB5sm8tU5BZE07Q/E5lkGoP2BIgBDvs9VW5oldIn9nSw9+Yjt+GRy45Jh+7nMIRfLWqWS8YcjGg80XqMfGqNohui41EIS3LAiGDCQB19HSpsCHzIyFsHU4NMULIy+pVUli7lK76nqN/CPwVkoldyfQ/kS0qHVRo55K8gBIGe6WYaPM4dXBpbefBXi9KYasTyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re6a6RR+cw7cCgi01mPnO80wlQ7+YuLOYVtWXBc+khk=;
 b=E48D7hiXHGoCp9qID7gJPlZe6rB3yWvkeDTc4lAIcqvEoUXvNJH68SPrK/H2zrC7y2e4hOtpLIDumtiqqnUxzZp20kBCIDBbJpUYu/9B5wZzEOegcDoSuA7Be8KZt97bMjYX4zC13nuZn3B7vtWxTWdD42n0XL+3YfSnTFZc6XrpjmF/nz4yXxTKvONwnBVXhzjl+E+L7qWN1Ng9hZuBxdsHT2wwrxxisQeu6/xWQiJjXzQ0q/H2MfLdrthZRzI0lQLLSPPakS0yQi3ahbVbRgg7gpIjIrscaO39gv7OujXNGK4QDe1YlLvwIQ9u9jTo04KgWZKtA0c77DjZLHlgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re6a6RR+cw7cCgi01mPnO80wlQ7+YuLOYVtWXBc+khk=;
 b=PAh2phsBGGh3HGsXBbzVeN3tf3FBFPbulGiM/htG4dfMebOj9GFLYTRubla0nCHxhiXh103DTUEo1nQI8nli6b7zbQUr6C429aqkweTfNz+Wd6NdMedbi4OSS8R0bIXXPuUPRiMISfuuWUCuLmHGYxALTUMWd7yfGI9fNwRYi+A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=calvin.johnson@nxp.com; 
Received: from DB8PR04MB5643.eurprd04.prod.outlook.com (20.179.10.153) by
 DB8PR04MB6730.eurprd04.prod.outlook.com (20.179.249.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 31 Jan 2020 15:35:47 +0000
Received: from DB8PR04MB5643.eurprd04.prod.outlook.com
 ([fe80::e1be:98ef:d81c:1eef]) by DB8PR04MB5643.eurprd04.prod.outlook.com
 ([fe80::e1be:98ef:d81c:1eef%2]) with mapi id 15.20.2686.025; Fri, 31 Jan 2020
 15:35:47 +0000
From:   Calvin Johnson <calvin.johnson@nxp.com>
To:     linux.cj@gmail.com, Jon Nettleton <jon@solid-run.com>,
        linux@armlinux.org.uk, Makarand Pawagi <makarand.pawagi@nxp.com>,
        cristian.sovaiala@nxp.com, laurentiu.tudor@nxp.com,
        ioana.ciornei@nxp.com, V.Sethi@nxp.com, pankaj.bansal@nxp.com,
        "Rajesh V . Bikkina" <rajesh.bikkina@nxp.com>
Cc:     Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] device property: Introduce fwnode_phy_is_fixed_link()
Date:   Fri, 31 Jan 2020 21:04:38 +0530
Message-Id: <20200131153440.20870-6-calvin.johnson@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131153440.20870-1-calvin.johnson@nxp.com>
References: <20200131153440.20870-1-calvin.johnson@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To DB8PR04MB5643.eurprd04.prod.outlook.com
 (2603:10a6:10:aa::25)
MIME-Version: 1.0
Received: from lsv03152.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0061.apcprd02.prod.outlook.com (2603:1096:4:54::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Fri, 31 Jan 2020 15:35:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 414395cf-fb5c-4645-e3cc-08d7a6633e0d
X-MS-TrafficTypeDiagnostic: DB8PR04MB6730:|DB8PR04MB6730:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB673024F09106CA44DDA8168A93070@DB8PR04MB6730.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-Forefront-PRVS: 029976C540
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(52116002)(7696005)(1006002)(66556008)(66476007)(2906002)(66946007)(8676002)(110136005)(55236004)(8936002)(26005)(81156014)(81166006)(316002)(6666004)(478600001)(54906003)(7416002)(1076003)(36756003)(6636002)(6486002)(186003)(16526019)(5660300002)(956004)(86362001)(44832011)(2616005)(4326008)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6730;H:DB8PR04MB5643.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmvI3ze++uKVQ5gAQu7Gdy2AgISX17bSa9Pjy/jynREEje3Dd0uNWqbnOxgYiWf66OYrW7AkCfEX3Su7sXPAgnps4wHHfWtpBxVFVDOx9r3W9vgxmJyzl+D2/lKa10mQar57uWYACaPuXsJ6S/T2nz7aJhzuZxiUtCuCCchFLA6AhPycCEFO4ffIcje4bsRpSfVYNzuU65UNHH/rQZHbJTKYLLSHBoE5iHyOsH0AyCyOZvDyPTyPK/BBpdKCLKQdu66a1dhTptmXQn3Peqpb9bVbRLOlv4em0ucB1XBxn8kpd43Ug36KNerND0h0k5ZTHnuCdIShNNJ7ZMUM+8khcVvn2BRp5hD1OuNa5gfIhB9fAZwEmbfrR70BebiHL38fr0dq948tNq16WBDWLKjS0ngeSnc1Anolb1paBzEc/WxeQTZx+S8eQ+SJV0xdXYNxYLlmACtMQdm37HEm8XLMiW2QjARp+synf2d+ASdbVlBHceXsk2T7hA8Ac1Kj4VoA04mOAEhNX59AvtNbitRxNpGWVSmPCUwjC+z/9ZyTFxs=
X-MS-Exchange-AntiSpam-MessageData: iv7mJrQbz6/fZguqU0pYwthY1cpAcWze3cp5NrUpoGMVLx/Zxa+nTawXSiG/cJkVLMDgM9SFceO5M6yBf2EDZK5EoDFshqF4hshzUZLvtBpIUhz5xIf+TD+aOCaieyuI/fp6EbbciLCR9MRfM+LKIQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414395cf-fb5c-4645-e3cc-08d7a6633e0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 15:35:47.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5yqWqdPAeh8eFbgzsZMnnhGRhl7xiJX2C85ecsygfXClAcAq/o2Xfx/eh4jnMo/IB9DpYqPDQDAJ8fXp5qlSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6730
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Calvin Johnson <calvin.johnson@oss.nxp.com>

Introduce fwnode_phy_is_fixed_link() function that an Ethernet driver
can call on its PHY phandle to find out whether it's a fixed link PHY
or not.

Signed-off-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
---

 drivers/base/property.c  | 21 +++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index fdb79033d58f..a0f69fae82cd 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -827,6 +827,27 @@ enum dev_dma_attr device_get_dma_attr(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_dma_attr);
 
+/*
+ * fwnode_phy_is_fixed_link()
+ */
+bool fwnode_phy_is_fixed_link(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *fixed_node;
+	int len, err;
+	const char *managed;
+
+	fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
+	if (fixed_node)
+		return fixed_node;
+
+	err = fwnode_property_read_string(fixed_node, "managed", &managed);
+	if (err == 0 && strcmp(managed, "auto") != 0)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL(fwnode_phy_is_fixed_link);
+
 /**
  * fwnode_get_phy_mode - Get phy mode for given firmware node
  * @fwnode:	Pointer to the given node
diff --git a/include/linux/property.h b/include/linux/property.h
index 1998f502d2ed..ba89fcf091c8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -333,6 +333,7 @@ int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
 
+bool fwnode_phy_is_fixed_link(struct fwnode_handle *fwnode);
 int fwnode_get_phy_mode(struct fwnode_handle *fwnode,
 			phy_interface_t *interface);
 void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
-- 
2.17.1

