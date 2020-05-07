Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88ECC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBCA207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N6rzKr/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgEGFgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 01:36:14 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:61277
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGFgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juzuOS9fBqZGhEUUi10UfBn+TwqFmY2/DL2IrZ9XnDIlimhgH2kcpDgVs+e2/+vmEWHb3CGvJk7BO0GTJkYTLQ280h2tXq0x+sJTLGXIhD2lPS8QyYJeSIRNShpXpfdD2JcS+0GU9rW7CqsONvtROkjiCxR1IUuAQw/8ysfh3eyxzLr4NxQVLTTL4tPpKc3h2bTKMI93UHt5CftyXFEOXMjLznmxwvNry3Wx/hUzaKQ5eF0VskSa9GjhgIl/cXX/JIH+0PR4M+X3o/PiK97plJSseZm7/z+mQYkb6swS4sgAnLHwWzsa8wq2Y9jE61uI9Y9fpDNFuuQYtvq7EX/tLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AqCYS3NmskNEmZxZ4yrMbPSblXiHgMB5ksAGQNtVQM=;
 b=Z1oUy6Ii6YtY3WMCSQbfE3r2ucUDuz4EbhjCqmIZNSenOi0V5pakqqRcnYTUYImExwK9sX99F7N0W9Jt1m19EFxJTgqw7OV0fek1Huce9srseqZ8xqxRDEUDDEFHbonj2Ey1Ml4dIhxg1lltSV4adB2o16j7yV2Mw9XzW4dlFLjEwDmang1dmF17RvFqYed9sQvf9OFme8HrSt7IN/XSxSY5fqyg7UAtJgZz6IbxMPpXJQ3HHbYyOvBa87YO8DfxBxijavPPa1dQzVIy8C9IJihMR2/oISve6azMFqMEqM5VddnZ3VbRpwXiqjdlJwzPPoZ3QKQm+n3xtGi03k+qlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AqCYS3NmskNEmZxZ4yrMbPSblXiHgMB5ksAGQNtVQM=;
 b=N6rzKr/MCBXYHblk5Ar0D+VnGrDUndG3hfpnugFYwrX0Fpd3oJMpD07Q0kJptKmSFNVwLQ7dCXHxQ8lPVVKfs9Wb78YPNu8v64cVMDfJfYxHbiOBXyBxOEJ5qhSrfxs3esf3WupZj/6OsBtnnetSw1VxZ1ge57XYmUMQ2GGxkAs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5636.eurprd04.prod.outlook.com (2603:10a6:208:130::22)
 by AM0PR04MB4196.eurprd04.prod.outlook.com (2603:10a6:208:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 05:36:10 +0000
Received: from AM0PR04MB5636.eurprd04.prod.outlook.com
 ([fe80::c4fe:d4a4:f0e1:a75b]) by AM0PR04MB5636.eurprd04.prod.outlook.com
 ([fe80::c4fe:d4a4:f0e1:a75b%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 05:36:10 +0000
From:   Calvin Johnson <calvin.johnson@oss.nxp.com>
To:     Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux.cj@gmail.com
Cc:     Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: cti: remove incorrect NULL return check
Date:   Thu,  7 May 2020 11:05:47 +0530
Message-Id: <20200507053547.13707-1-calvin.johnson@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To AM0PR04MB5636.eurprd04.prod.outlook.com
 (2603:10a6:208:130::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03152.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0091.apcprd02.prod.outlook.com (2603:1096:4:90::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend Transport; Thu, 7 May 2020 05:36:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81348dc1-e014-4b53-dcbb-08d7f2488c35
X-MS-TrafficTypeDiagnostic: AM0PR04MB4196:|AM0PR04MB4196:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4196B3F438B9194DA42CEE4BD2A50@AM0PR04MB4196.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RD5sRbx3VJrF5OLwBRaf6j2SZ8VZo2WMzqX6YF07y8pIse5amvqabMBV0QclJeZQLSll27fbb/UP2kKu5K4fNCNQow8tpIIkhKsx7PV8nJT6PXG2hz5AHCExfW7V8OfqNzF6K52SUobLNSVwzQASAXbAhjUNbHQ+DpOwa67/oK2l8xUfvuCh2DpuCrcEHg+yLGasm1Ut/VCxatdXv9WB2+h/jfsyfM2YA3Lh4D5TOHGWP2qWS7Iue/fI5htqSNY5G6uWsB+Ax5/JOqc/1FitqmoN06I4zNEZug23q5+yrA6ByRe0BpPUZ87HV6UVQZNqK3VYyxTYvS2Vv273XcbrBsahOiPl/PsuJkDMlowgJ1y82KFama6tk0RJwb5alZfqhoPn8g75KJ3tS4DwnTKavl34vbkXYr9CqTIXCzbsdKEsY0/1Wgl2HCnB4csyPGL0kBx0F7AZnhOAH7HSS9hd/gVRmL024vkO3pfjrVmsnzZ6YRXpU3wzT+h7HXwJ/tHvGhx2JLltPN207Oflryekq9Wnaaoa09/ZvHYfmp4+0klRpYKT9YKdyqFAHzyBqjRT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(33430700001)(110136005)(5660300002)(83280400001)(83320400001)(83290400001)(83310400001)(83300400001)(4326008)(54906003)(6506007)(1076003)(86362001)(316002)(52116002)(2906002)(33440700001)(6666004)(55236004)(8936002)(44832011)(2616005)(8676002)(66556008)(1006002)(6512007)(956004)(478600001)(16526019)(66946007)(6486002)(66476007)(26005)(186003)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ocNCnL1jVsnELSd9LOHmavvMFpKUt5+ZNiitmZVJq6KTb20lydAstHywGch1EoA51/Z7ehPDgBzYsSjYQ9l0w42touMihrbZ+rQLKGTE8yAl1k8PY1dByRiqFVJSClJZnPnPZepsPF7OXOKZc3PtXG5PERE9F6DKyxrr4odhwWK5PQ4V5GXhJCSxdHGSIaqYAllzRDixWaK19lLOriUtOcE2raX4ZsVPk5paD7Ww/I+WQvt8sQcFY/IEXj4IERsx1yjNvya6671QdNiJR/Msu+axp1OtOU5dBPXbtO0FlhDrq7IQEJiGZ1tdaHQCtDIOF0z4DA/2F709KQQGZ9AewfklulMLKH9G32VVudCEROFKQWIoGFdpUrdt4AP6lcVcrGsxJyifjQHph5OxXj2++sy/uq/ZuaW8l9LPPi6tUmxFhF8qCYwIq3RvLAJ1H1AfWP0uZlluo9A9QKhAEgP3YsWN8fADyXq8lVspLeVQZB9xAqMJsap+S0e1/D49jiVyM5jCdn2hzUEmuRE9k4b6/IGTP/F7E0VCI4AvsN2plOa0l4NtftBP++mbd/CnyKbZpINSZiKkkxum80U54t6zwIyz2RAjrH9WULYEgTmfVhWBahsxFFdY2M3NC44Y5AxhEtljNbO90um62ernqqnjrnIrayS7xsyzNrYIsV3N+z5c36dXgzI+e+SBOP9QYX5G1CpcJxIKL30CkgHIFMd0Vdl9Ohdg6S2Ard0QBMu29SemFJRG2v3GoM1fyG2HNQRkrG8GCJk5NCZ10esIZHw7cY2JAwEe6lWke4P8Xokq2bI=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81348dc1-e014-4b53-dcbb-08d7f2488c35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 05:36:10.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XxOXf54RaJ6IBh6JxD+XkVgVUPeUQfhrDknzTKXWXJ6y5nNZwv9gfO0RlJYYPxdj4O6RHnoQtCAzj48CtpQZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode_find_reference() doesn't return NULL and hence that check
should be avoided.

Signed-off-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---

 drivers/hwtracing/coresight/coresight-cti-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index b44d83142b62..2fdaeec80ee5 100644
--- a/drivers/hwtracing/coresight/coresight-cti-platform.c
+++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
@@ -120,7 +120,7 @@ static int cti_plat_create_v8_etm_connection(struct device *dev,
 
 	/* Can optionally have an etm node - return if not  */
 	cs_fwnode = fwnode_find_reference(root_fwnode, CTI_DT_CSDEV_ASSOC, 0);
-	if (IS_ERR_OR_NULL(cs_fwnode))
+	if (IS_ERR(cs_fwnode))
 		return 0;
 
 	/* allocate memory */
@@ -393,7 +393,7 @@ static int cti_plat_create_connection(struct device *dev,
 		/* associated device ? */
 		cs_fwnode = fwnode_find_reference(fwnode,
 						  CTI_DT_CSDEV_ASSOC, 0);
-		if (!IS_ERR_OR_NULL(cs_fwnode)) {
+		if (!IS_ERR(cs_fwnode)) {
 			assoc_name = cti_plat_get_csdev_or_node_name(cs_fwnode,
 								     &csdev);
 			fwnode_handle_put(cs_fwnode);
-- 
2.17.1

