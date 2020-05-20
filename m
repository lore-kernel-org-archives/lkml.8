Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0324FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CEE20842
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZxaJmg9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgETC7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:59:31 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:39045
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728287AbgETC73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCQZXWiAC2encWoW6kEE3SSP7gXDApDczZLX16LeLLQGxTH+ktNR+NJl9Nio/EIbC2VY5wQcoiJMuph10LC01S8k9QtzhFCRmvt5qj7egBA9oL1n/xv8h/csnKDWst6tB1Tsl9kxKHTRgLLQu5tJWatO+Gn8/aQwBFSCkvY08lko3H62ccKzknC4qcBsorgMaGzBTspTWt6I1nXTc0gymg+JnbgMTOc59k8JgR72edB/0nLzgYxVAuyR+PLepD7MYzlX7bpTHpP82lmJN2Cbj0IpaBq8nNmFpREikYPQEz0RwlgslU63AnsLS5dRd+Mp24n7HTaMYhMWbYa7zGhpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl4S+04bc6DbOXLWVetB/25GFzyJXGpsiMIx/PI21XM=;
 b=T8VCIgQZIwcRWofV+cq8is5PWtqvbvWheMRn0d0IXdxDCEPYk++pL+cbhE24KQLOyH/FEkUP/a/grXUPRj6sAxhYx1PKelx1cgJkDnD/HqIQbbKz9EfofPOduwx+ODD//xqn/1xRPmSUj+gFSReyJLyXysdZGmrkOvbyP7GGJfr9CPQhz97ND8Ug5bEWLsDTyQn8K1z6j6OtQjli4p86Y7Ll7+C/rD9OIDMEz7WlAo0lJiNQF26r4Q+nJO26lhDMKybQo2FaQUuL0fuUXS9fY3CzZ1/crJMLYxPIcB6O7c68wF3jZbV3logllI4QBDMFhhEfbjYGFaoxU5eSTwWSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl4S+04bc6DbOXLWVetB/25GFzyJXGpsiMIx/PI21XM=;
 b=ZxaJmg9W/qFfLLTwA5ANbao1gGp8f2MCv/E/Dy4356k5tdy7o1LQaSyA4OhFTr603VA7Hv0LxIoFdaIuYxENG3eVJmBiEElPD5+A0X+1ydWWNxs8/YGWN2xYNlZyLV2GLWK1iuuJKEIFdkH7orjQ2+kqNeffNN2nkclQtYJlqCY=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6634.eurprd04.prod.outlook.com (2603:10a6:10:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 02:59:24 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 02:59:24 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] bindings: perf: imx8_ddr: add identifier property
Date:   Wed, 20 May 2020 10:56:17 +0800
Message-Id: <20200520025619.687-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520025619.687-1-qiangqing.zhang@nxp.com>
References: <20200520025619.687-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 02:59:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e58eb3c-2529-4ac4-64d8-08d7fc69cd50
X-MS-TrafficTypeDiagnostic: DB8PR04MB6634:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6634AFDB76EC7651A5EE1BBFE6B60@DB8PR04MB6634.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnolzcD8rYeAh480wBF+Nb/FLvRc/5vprIIQVAtww3qPpJc5d8yUBJnGIcI4YJQ4ViLl4hR81Lv1jH2fTRWoZIZ2WlA4KEUMHd1UGG6RZiwrxbQI6jiZf6dxM2v/85ZHotorwu7xsj9GiUT+Ev5EV9Ew68ViCjrWRFTbtXGf9MTf1ISpg3lnAFbeosBMDWr7VBikWhAv3d/BtvcDHhEuy+fwj40Aq0uboCOvccOB72xJKiKIvhhD8dLYTqXDbX5KU0TqJ0AeYpvq1pBKTCRSAFQvS9QsIOckA+UQEH91nX6q7PueSYWb0xVytZ00S5A2ykJZO2KXJuf3luRVIuwsyguoOSP5WeMve/SQfBbtGCltHRTvD+D0/DLNMUGzVqbmu4vsWtiAMX0GCS5UZi9XSMbxnhTqceLqWV/YQEih17SCJmTKWk4L5XTEnvxchAwJcaAnzoU24eXdQSgxf7MvVbQvcZ+Z0BWa6h4BhKXRxxILn9hI87rO1EzViEKcsXRJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(8676002)(478600001)(2906002)(6486002)(956004)(4744005)(8936002)(6666004)(2616005)(36756003)(6506007)(16526019)(5660300002)(66556008)(66476007)(4326008)(26005)(66946007)(1076003)(6512007)(316002)(86362001)(69590400007)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TOKpmF6pVbRqEgJelulXtGjXfHTYuRGK7JOniCEVR5aDCC0VHYXBwA4hWlnrldld7leDRXQTPPsMxLZbfomtN5Oz44FZlhO9qnH+fuTuE6gPTyW1c+jvzd6Zj0WD+7xO/bIAtI5lzDxjGj34FIQ1KG5YuYMIfA/mYe9VM/jAlLALjCYVFf25o4btP26BzoSywcwx7tLkLLUcFZz57Di1APxKFkEdVAimdfb3HtaKX1k8+4VJnj+X85CmaSmIU3U94GPwZZaFIbD6JnaohFpDDVfrmcQ4Vo2QApkh/ltzBxb9paXbPqDKQTzsHuPQrjJcWuQpEIYWHFNBJkjvfjeEVW0Tl/jtG92Smh1tSO/f3F3cG9xlqNcxFnDr6W0ZioeDCEMdU/C0qKjSgqH99Rfr1j5PPQGooEZ905tHHknKIL7989HL0OH/M52Qzep4HGrTlRJXwCx3e23WwAP6kV4ZfWLt8s3DhvUwsXbO6gaEVOQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e58eb3c-2529-4ac4-64d8-08d7fc69cd50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:59:24.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0DArtWeeOnI/M3bRpO0iRQHA+pQFnngKid0Vcv26MD24aeeko5DhGj1o9D9i83GflOmEfNZDAA8msG3hMiVyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "identifier" property for DDR Perf which used to identity system pmu.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
index 7822a806ea0a..ebb9a40094c5 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
@@ -12,6 +12,8 @@ Required properties:
 - interrupts: single interrupt
 	generated by the control block
 
+- identifier: identify system pmu
+
 Example:
 
 	ddr-pmu@5c020000 {
@@ -19,4 +21,5 @@ Example:
 		reg = <0x5c020000 0x10000>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		identifier = "i.mx8mm";
 	};
-- 
2.17.1

