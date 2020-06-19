Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36FDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C795D207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="NamRngyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbgFSKq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:46:57 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:3552
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732399AbgFSKqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:46:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbZW0mbYg6fQECtlOgN2gJp32U5imqTfPjZTzK/P/83sN/h5k6v1fvws2wg0YXoVd3SOuakHEG8r+yDygK4KrgoT6P5HZTt/6SHiKszW8xrbe3LKfGMzlO3g9dSgPlMxAKc0fjVqxwKbmYJmd3acPHy93HnIGRgMfieo4EJlAcZ0wXWn0Z9nQWbmzg0J0DnEbl7PZqC1WnM/pTVO4REnkhnTpkx+diNChJ0tVpDj5MKO5255Krxm7r1JTkFO3cVpwuqkBq8zPo3NhJvgDaIRZXNdhNhuIVq5qGkCYJL13qFmjuy6VxbYmURjl9/ZZERLJr24wO3oliOyYwlCjsi1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eenDrgmTWSh7Kp6zW81NtmLtvVOOsYMfiiu0rYTtWdI=;
 b=bxcWHnxoP4ZX6eKOX0wvmvKTd2RzcjYH6LOYQmLSDM5F5d5AehbWgmkutAmnWdGGLNM3RX6ymSCHJxGCMaM1Rs0GjPRKhzoYZ+hBJ/NEsPjXMUxzrcfBXJ82OHOWgizZ2QfZmGcFUHrM7AUiQwAlXlQjNhoFOL3sCNXTSSsWLD0UbgFToNCSymlX1MLgpqFt8EUOGfUPaZPyCHusCMm6DC88GWv8rsjH3NsKswxNbocRvdXo0pUVXxwN3M5fpDXkDEkZRbQ9OQDEeBE7lW88VMCZYRtw5lT/6Zp/vB381lVH0XgtmXSKislkrfFF/qZeOfUpHmN9NuNynNTNTd79Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eenDrgmTWSh7Kp6zW81NtmLtvVOOsYMfiiu0rYTtWdI=;
 b=NamRngyqIl1OdhTKOwdqzE4+DNNM85DGAdZEocdT42bf/RtDcJOwBzg3xqV5R9Dv346W0qTkBRYjAvgQOxFA2kZ00Mu9znQuH3yX0MLQflQdpAkaaHf+zYKU3P4JLFf17yvpa7OJYBtNyrWmfAhLXW2HGsqLVsfsBpBxwfh2WFI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB3580.namprd03.prod.outlook.com (2603:10b6:5:b2::14) by
 DM6PR03MB3481.namprd03.prod.outlook.com (2603:10b6:5:af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Fri, 19 Jun 2020 10:46:43 +0000
Received: from DM6PR03MB3580.namprd03.prod.outlook.com
 ([fe80::3122:b605:87fd:339e]) by DM6PR03MB3580.namprd03.prod.outlook.com
 ([fe80::3122:b605:87fd:339e%6]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 10:46:43 +0000
Date:   Fri, 19 Jun 2020 18:45:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: perf: add support for Cortex-A75
Message-ID: <20200619184535.44835b99@xhacker.debian>
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
Received: from xhacker.debian (124.74.246.114) by TYBP286CA0040.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 10:46:40 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2871fc6c-c7d9-4473-e809-08d8143e0e58
X-MS-TrafficTypeDiagnostic: DM6PR03MB3481:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3481A87C339B732B4FEC9637ED980@DM6PR03MB3481.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njjuhUn1/zZ2tXuGZg8ToOX63ZDGDJ3UuAiUKB9i3Ky8eA36fGscm0Oq798NCAAoIMQDKK5gpVm90YN6c9+Rkw0G8A2gxnCMjMY6K7HWVn0NDzqaZYaf4j7frzpR0MCHAh4Jhhnjl3xq63MpVJMmhP/4yWeuHLHXn8X2JFahShslGU9P+XU/u3JuVe5GBcp5mOh9ZWG8er/hEwIC1kiSMo2rmPV9dBtLMWEz7ImzVEI2vQOENw7U75NFfUa+Kl8ZcH4OYdy4p6WRBjcT1t56/2ZZjMUfrV7mp7bt9ov4aFolSZb9/tTjHhgMsJQXtIEqK+8fBDUfLTQennC38axHAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3580.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(66476007)(6666004)(66946007)(66556008)(5660300002)(86362001)(52116002)(16526019)(7696005)(186003)(55016002)(9686003)(956004)(8676002)(2906002)(6506007)(1076003)(26005)(83380400001)(110136005)(316002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4JKUWlsoOUOMglmFNkuRoe7YAAU60EnMAFgX5fBV2FhTOxPPxv+ulhtr6K98nbqawHg1NF140VWhgJYL6F+lN212b/RtSVe3kaCjaQODG24oOPNdVjtcOnYqAqJio35nPzhrWYGRGiFNRWa5fPLn5K9ummkCnHlXTUTCNoKl36G7ar0ov1K2B0UCn2nda7eG2QdhMvN349P+1V7WOAUqJI5tje0reyvXgTQ0btiW0dGDrXFf3+QeJ/52RF8IWkHaP6xsn+pAjv9Tcq2Yx+hfXVuwStV6LO+vbbacRuYe6PDMiHTNnd58fWa64XhPeTIuEEkFqTssvLE2LPW6+68vmk8zLQLDfPA/PM+XYpJIK8ivJ2ZZIQogEgI/UL3tRGjicAr6JWfrhrGYg+AOtZN4TbzEh618GMQ+lOGnm2vBuJpSS1yO3cnk7H870E2l4DunQKTywD8Bca9b50v66AQDWpw/E7zFWPBireBGnqyCeqKojld1BpAF1lmPKT86a+e7
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2871fc6c-c7d9-4473-e809-08d8143e0e58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 10:46:43.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+fQp+zkrvxf4AKqo/se3zfCRg22phKSA5CJQZvWfPQlTLBtmNVvqIrRmI5DWMha/PXK2cfd3a4VUSmu7g/q/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cortex-A75 uses some implementation defined perf events. This
patch sets up the necessary mapping for Cortex-A75.

Mappings are based on Cortex-A75 TRM r3p1, section C2.3 PMU Events
(pages C2-578 to C2-586).

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/kernel/perf_event.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 743affbe0cca..55e1d75af708 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -123,6 +123,21 @@ static const unsigned armv8_a73_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
 };
 
+static const unsigned armv8_a75_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					      [PERF_COUNT_HW_CACHE_OP_MAX]
+					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_RD,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
+
+
+	[C(NODE)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
+	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
+};
+
 static const unsigned armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 						   [PERF_COUNT_HW_CACHE_OP_MAX]
 						   [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -940,6 +955,11 @@ static int armv8_a73_map_event(struct perf_event *event)
 	return __armv8_pmuv3_map_event(event, NULL, &armv8_a73_perf_cache_map);
 }
 
+static int armv8_a75_map_event(struct perf_event *event)
+{
+	return __armv8_pmuv3_map_event(event, NULL, &armv8_a75_perf_cache_map);
+}
+
 static int armv8_thunder_map_event(struct perf_event *event)
 {
 	return __armv8_pmuv3_map_event(event, NULL,
@@ -1101,7 +1121,7 @@ static int armv8_a73_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv8_a75_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a75",
-			      armv8_pmuv3_map_event, NULL, NULL);
+			      armv8_a75_map_event, NULL, NULL);
 }
 
 static int armv8_a76_pmu_init(struct arm_pmu *cpu_pmu)
-- 
2.27.0

