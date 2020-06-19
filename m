Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F55A207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="DG2DLmgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgFSKqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:46:43 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:11786
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732399AbgFSKqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:46:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fuh9fAmeGv2ldP116i1eGsPd9Twq85aBD+mW2zaVLhlvsAXCZ5VUgAt9gSceWZ6LHOO+az/JkwH+/42/VSyKbY67RdjIRQj4S8GvV4PjW65+ageWKMQRFE0UkJGjSfN3S7tEgPvp5Kz12s5F5GGUikgWYu//s37NVXNtc6cTsjlKK4w98nOzT0yaV3roQ/BrmFFE+9dhHCKd+GDaeLUVjrLtfn50LY8AyH40HSkJ+yMCoLH5uZZ3wzaHzCEhh/vWXukoJXfTzJ77mWnL7iq0Suv3v6McXvgwGyNZsyyxSgp7HxEBL6+cfLzpZdAnpxDjuEJ5gaBa1+Waw7uwqid2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvio9uGNHqynxcFJ2goBHmxUqKIULUlGvgXUQtdQTTA=;
 b=B/BWbIZUIA4ffQa2YC1MxZH08pyl9L8Ya1LPf+N2UbS3NETQxh/RBvUO39kh3ESyii/hwtIhY5tDtSSoPklLAHveX9UuZr8sYJxaYUb+d1AUK04Jim+9GxJrxWH2RkFuzdQTgm+Yavn9UrxqZztayymYZzHZ1XaQy1hBdLArQBOiUxaJMIX5TIltZ/h61cWVwldqAAlTEJ+DskOVevZnKH+UJYL+QZLV5cdvmIPU37PSvZHPlyh8scP7aXz2mQdG1PI9mY68DzFa8TW84ZvmuWajXDRrOXjj3hdUQFVTUy/zg2qfDtXfhp+0jvALFqFv3O93T+OFhbeWgjMC+PAx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvio9uGNHqynxcFJ2goBHmxUqKIULUlGvgXUQtdQTTA=;
 b=DG2DLmgpfCJzkiOkfQWA9WjEnP2SL2wuSIERnIrCpD4Yq1OuKgtGkswn42TeQcDREyXD0vPgDTviaUKLtp0To8mjLsUGpbNaiuldN2iJO+GDVgm/d500g6csby/QcA6mMiBAdySrscEi/ioP26eJtJCNBSpCDwRdwgHy1Xe9m4s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB3580.namprd03.prod.outlook.com (2603:10b6:5:b2::14) by
 DM6PR03MB3481.namprd03.prod.outlook.com (2603:10b6:5:af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Fri, 19 Jun 2020 10:46:37 +0000
Received: from DM6PR03MB3580.namprd03.prod.outlook.com
 ([fe80::3122:b605:87fd:339e]) by DM6PR03MB3580.namprd03.prod.outlook.com
 ([fe80::3122:b605:87fd:339e%6]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 10:46:37 +0000
Date:   Fri, 19 Jun 2020 18:45:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: perf: add support for Cortex-A55
Message-ID: <20200619184511.5868cd14@xhacker.debian>
In-Reply-To: <20200619184423.5e61a838@xhacker.debian>
References: <20200619184423.5e61a838@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::28) To DM6PR03MB3580.namprd03.prod.outlook.com
 (2603:10b6:5:b2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYBP286CA0040.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 10:46:35 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dd135bf-993f-4da0-1a20-08d8143e0aed
X-MS-TrafficTypeDiagnostic: DM6PR03MB3481:
X-Microsoft-Antispam-PRVS: <DM6PR03MB348164C1BD0605BD9AACBEA7ED980@DM6PR03MB3481.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hh+dmijiIZdnwqqwQifPXMs+rBa1lkPrGr2jkaWmZedddlcLRUm/OJTcqLd9m/goMduPhWu8r+Nrz2hqHylSrFdaTsnnM3UGbwsm87c6TvLotVuUhsguPtSWBx8YbvBOcHpSdMQ07ScmwxAN0a5zMZzx+JVIJl+WcrrqATm8J3WwV9WQfO6GyaNdRgaykzbL4ok/tHmUWvfa9KNMJgH+bHGhcjuy+TP4fjCw1mdzODRyHvSX6l08sHh/yzjNbbRK/G5PsPnZPKcEuyuL+1jwM0WZOuyAPuL2EQpWOgw1aFPVQOMcIlQN8PeinE3FwoXEoiLzSN5o+vOhvlJksjRw5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3580.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(66476007)(6666004)(66946007)(66556008)(5660300002)(86362001)(52116002)(16526019)(7696005)(186003)(55016002)(9686003)(956004)(8676002)(2906002)(6506007)(1076003)(26005)(83380400001)(110136005)(316002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zDwlQ+ML0C/63oCspSuSmDGES78TfvtvDqZ0FljgitayJexWgxkZTtEx9/rYSCa+aCNt7TDAKW8T27ZGvVqnBfuJvJnBz/b8MOQRTnNO+l7Lv+xKkHagcTWIA9bYa4nsFniHTC4LO42CiD/qNL39UAZx/d83T2u7CYastGuCp+sliNROhOuN/4N6MxAc1e7FCoXWzSjn+/SE3GLvd3OLD1PcYBKK0XOQoA6a06CUVitTQ9mnxxLbxmhqtQBnypkTU4TK4uJgevDhWXcdBxnRYLqF3qDTunrJkRW61cMnTtiOCSwq7k/dB6oKIS2vM115mpEqKVHVJvohtztriiMWPJs+acg5iWCDJgvBG1cQc5lH8fl58I8wmrBxj1QFSSok+Q1c2r7xmRse9v/5lB/ksiQuXlXUqbM5iOxCmEet/PqtUTy4P6Nv210HMuDyGpc9OghwPnDfRdYdaKMrypgjL31RYNKV23nJZA7L0rdJvTr7kwoFgMN8oRIPU4qk0G+Q
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd135bf-993f-4da0-1a20-08d8143e0aed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 10:46:37.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgDfoGI/FdU5ossh2n4idRgelxk59ZMKBIfFT/Z0pG0pNbIfPGuBN85hS7a5/ZiPZqbQ+HvKRIwdCm+TcO9C5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cortex-A55 uses some implementation defined perf events. This
patch sets up the necessary mapping for Cortex-A55.

Mappings are based on Cortex-A55 TRM r2p0, section C2.4 PMU Events
(pages C2-567 to C2-582).

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/kernel/perf_event.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4d7879484cec..743affbe0cca 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -21,7 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/smp.h>
 
-/* ARMv8 Cortex-A53 specific event types. */
+/* ARMv8 Cortex-A53/A55 specific event types. */
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
 
 /* ARMv8 Cavium ThunderX specific event types. */
@@ -81,6 +81,22 @@ static const unsigned armv8_a53_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
 };
 
+static const unsigned armv8_a55_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					      [PERF_COUNT_HW_CACHE_OP_MAX]
+					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_RD,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
+	[C(L1D)][C(OP_PREFETCH)][C(RESULT_MISS)] = ARMV8_A53_PERFCTR_PREF_LINEFILL,
+
+
+	[C(NODE)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
+	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
+};
+
 static const unsigned armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					      [PERF_COUNT_HW_CACHE_OP_MAX]
 					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -909,6 +925,11 @@ static int armv8_a53_map_event(struct perf_event *event)
 	return __armv8_pmuv3_map_event(event, NULL, &armv8_a53_perf_cache_map);
 }
 
+static int armv8_a55_map_event(struct perf_event *event)
+{
+	return __armv8_pmuv3_map_event(event, NULL, &armv8_a55_perf_cache_map);
+}
+
 static int armv8_a57_map_event(struct perf_event *event)
 {
 	return __armv8_pmuv3_map_event(event, NULL, &armv8_a57_perf_cache_map);
@@ -1050,7 +1071,7 @@ static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv8_a55_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a55",
-			      armv8_pmuv3_map_event, NULL, NULL);
+			      armv8_a55_map_event, NULL, NULL);
 }
 
 static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
-- 
2.27.0

