Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00198C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C931E20663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZF1wbRC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgCRA1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:27:10 -0400
Received: from mail-bn7nam10on2134.outbound.protection.outlook.com ([40.107.92.134]:41056
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbgCRA1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0Drd8JKgsw7B9QoP2hijJTnVo9tWRXRMmGMLsIm0YKFr+FXH37DuHcSx/t9BfTgI8aaNq0yns3C1GZAy2iTaEnYOtKLp0zBiBeCb+QaQcJSnvtZGAhbWBZpqWNXltEzWFUv6Df0d3OJW6tKkAyQ8FGTwF0Nef+9HMC1IWiD5tumpQs7SrcVVgqYIDhPx54SaMRAiaPLu4MtooFSboYX11oZk8CkoeFXtmh22XIhqNM+9bjJ1cGQ7aO67YQK7vUYWfvrvxs1EmE3d7sc6NbroHcGLeAXppZkxEvhzpwMAVEx6s8wKcsnktVD9zhHiVqJOB2J59tjA/YAJECsdmuqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WsIjoykrLE9Q/cz4sELP6Y7dOKs5qTZE23AAvhhKx4=;
 b=GaMGO2S3y1Ymrr8JTKgrGRCzirWZsa5p6nbaKwlUZWg9FvEc279g/OtkJvevoiAwHmyT6cedspmVfs9QmiuCsbmX/byqro1B7qaG5ab6+X//9SEQcZIeL5CsLpaOrd5SEzV8fln1nJcrrQ6Ho+nit0AiIzWHokPiS/pKB3qhBXyp7nPOZtZDcfAbQTjna2dyLT7z6iLOI7usNVNBUlA8cf1273esCazvaCdIzE+bNMaGUoXCkvrLGYQhfS4hDLLVsusvio8+WuHZSQ3ea0c8vZ8T8g5VF/EiwwX0fQsLFapSHxxzEjlgv9N+M6Q1LLUCWHCYOIhYASHumSMJ7vH7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WsIjoykrLE9Q/cz4sELP6Y7dOKs5qTZE23AAvhhKx4=;
 b=ZF1wbRC9pns6YjDDffJlfWGJUuEdYx8kA8R8kC3Z3UaH4zkOlNyggMr3Ps/fwyKGSmu3DC288bpAwlJKk/wSLT+SVjanVPpjhNv4Mv6eD9ledsYk88++fFDo0rQw/KCMhizS0/P1VE7tZdppNFOuLNmTibSzqnjxuLk/VU7fQxY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tuanphan@os.amperecomputing.com; 
Received: from MWHPR01MB2317.prod.exchangelabs.com (2603:10b6:300:28::16) by
 MWHPR01MB3232.prod.exchangelabs.com (2603:10b6:300:fc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Wed, 18 Mar 2020 00:27:05 +0000
Received: from MWHPR01MB2317.prod.exchangelabs.com
 ([fe80::5151:bb2b:8ed2:b53c]) by MWHPR01MB2317.prod.exchangelabs.com
 ([fe80::5151:bb2b:8ed2:b53c%12]) with mapi id 15.20.2814.021; Wed, 18 Mar
 2020 00:27:05 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf: dsu: Allow multiple devices share same IRQ.
Date:   Tue, 17 Mar 2020 17:26:15 -0700
Message-Id: <1584491176-31358-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::30) To MWHPR01MB2317.prod.exchangelabs.com
 (2603:10b6:300:28::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BYAPR07CA0089.namprd07.prod.outlook.com (2603:10b6:a03:12b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.21 via Frontend Transport; Wed, 18 Mar 2020 00:27:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8920fc1e-25f9-44ff-2dc2-08d7cad31554
X-MS-TrafficTypeDiagnostic: MWHPR01MB3232:|MWHPR01MB3232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR01MB32327D82E9F3062B7857E025E0F70@MWHPR01MB3232.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(366004)(396003)(136003)(346002)(376002)(199004)(478600001)(8936002)(316002)(16526019)(52116002)(6666004)(186003)(81156014)(54906003)(81166006)(8676002)(26005)(6506007)(66556008)(66476007)(86362001)(66946007)(956004)(2616005)(4744005)(6486002)(5660300002)(2906002)(6512007)(109986005)(4326008)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB3232;H:MWHPR01MB2317.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PirM2wqn83jBczku1fbRYeGu0QAAcV8I5JM59LiFld+JxfV20G3EkHG26ob0L2eTMYv0hhoGdtH6h9VUHoARCsSC8AHQ+uaPLQPvf0K3+FMPSkIzVcUFkuxT/XPjzpSpEOUJVZTSa+IAPNVFnWiineWi6UPKyogXyJmoEY66Ucw9wWSUfIGUzJfk1rjKwft7seuBz3Ov2N9lNkfuHQs9YvHVqQJlcb6SO2GYyq0IakYY6F1jTKd3PXnN63qtk24i1lCemuRE2DUW2maoFwxvQGCI28sy0zO+y1j77Q/zIAqzHiWNpEzPWf08okS05o69iWwTw/njjdlUSFSwDgggrMuCkx4GdUvXTTenQV+r5OPYPfhbEiFqW7V5LYxWyAn3fElwqTQTKh20moJGCS5mpilkrD2Yic5/ZWTjsEsXCHkp8fr9R21ml8iSIeuHaWhhDZRXiqjwsMzqRLEza9EXE6ZqGsX0midzRjvuUBwOC0=
X-MS-Exchange-AntiSpam-MessageData: jLSd6nK3ynuETQGFn+p2GVnfRkEoq/AlD7xAf2EzaKWf9f8XzQWNFc9vJZJP04SkmdjTD/MrQqiV30s6X8cZxO89segWNUGhMCZt7IiHh/+35hHizC2ckGKVT3USvXe19lXB4fkgp7sa12+IIp2wWw==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8920fc1e-25f9-44ff-2dc2-08d7cad31554
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 00:27:04.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOak2g+KCMsaepcmDdBrAhX9RvYZIrY1p8G/5DmWTBtwHE+06+uYdNkj2V3lsDzaHah9JtS2S0Fkh+PDKn2slceNyRqfaBuZog+YYHL1ggwy3wudufmGQgEypZpw3E2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB3232
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IRQF_SHARED flag when register IRQ such that multiple dsu
devices can share same IRQ.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
 drivers/perf/arm_dsu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 70968c8..2622900 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -700,7 +700,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 	rc = devm_request_irq(&pdev->dev, irq, dsu_pmu_handle_irq,
-			      IRQF_NOBALANCING, name, dsu_pmu);
+			      IRQF_NOBALANCING | IRQF_SHARED, name, dsu_pmu);
 	if (rc) {
 		dev_warn(&pdev->dev, "Failed to request IRQ %d\n", irq);
 		return rc;
-- 
2.7.4

