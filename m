Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F3FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24990208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="MXzcP/iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbgFSKrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:47:14 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:6231
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732399AbgFSKrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:47:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFPh0EJgO9UETCYNBeKKVpl0f+I74ScXYDWzTEPl5yVVAYMFaIYRqM7h2MIKpC301Y60P5/f5bcYMSeuNSD+hwsrChdRoDzUuNvmZK5qIqjGoKon9hSLGosqDnXvSQE5x8MyhB1xdZgDYEZ7owwaUK8LLKS7xoOlegfiCTwHB8bRnWqJFryZIr4XHzRyQqPQTcaVo/DQQ+OATvrn81TwSmRYUDLxDsCzyn86uqq5lVil86YbI6ZzRrWDgNhJNXB1HUM6iQnalUYB3kY4/fqZ7Ki2wAsl2zH4/TrtlRnku6CQ+oXldEfuXZa4ZzqNLinRCN7YW3AlgtjOpX8MO+6bJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnTOMGwBRcg3XeWGhSay8kwfSx66Jlpjos2FQHxXp1E=;
 b=OCDIW/mPEClgQEYGHSwUvP5C1/zVmFsWCTSree0/N9fEp3Ff9j1HkL1zNLbyO5Pr0Mkp4/vWes0k0LZ1e1iEhFc6x6R56tAmAKv1ThpvZTtDc4a8Yjvg7Wu0L08SvztW6EM5bvn1LvLAXJSOkQP4hDE5Qzz7FGa359/OgAl5fZAvJfEPQrHVSf0hk79dlNqlUQUyL2bowUmxVm9N5cNq2jtuD8VKEA1TD3/zWOo6nEcQCeHEBKATSX8+H6zdw+nBi3+JRRHM75F26mSkyi46K4A0zDYvYd5LuJY6HWpmrS1SxYnLy0y9uYyJ4VXjiPj/mRZXhPz+knuUAn10FHbVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnTOMGwBRcg3XeWGhSay8kwfSx66Jlpjos2FQHxXp1E=;
 b=MXzcP/iUUnrOIB6I6bLGWPkplmW17vrFvhFIyehn5LmmnOKqUB7Pg4gDUAaLCwrSazbJyc7XekCVWU7i+KRpKzMBxnTVDEdxXnSxhlsltxOufh9V2BoN75waHNO7laNYA+t0KhAQyp272LsrvJe152m1n0eOI0cozbFVCvwarc4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB3580.namprd03.prod.outlook.com (2603:10b6:5:b2::14) by
 DM6PR03MB3481.namprd03.prod.outlook.com (2603:10b6:5:af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Fri, 19 Jun 2020 10:47:10 +0000
Received: from DM6PR03MB3580.namprd03.prod.outlook.com
 ([fe80::3122:b605:87fd:339e]) by DM6PR03MB3580.namprd03.prod.outlook.com
 ([fe80::3122:b605:87fd:339e%6]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 10:47:10 +0000
Date:   Fri, 19 Jun 2020 18:45:59 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: perf: add support for Cortex-A76
Message-ID: <20200619184559.0a8716ec@xhacker.debian>
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
Received: from xhacker.debian (124.74.246.114) by TYBP286CA0040.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 10:47:07 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 438e7a7e-c41f-4242-5cdc-08d8143e1e69
X-MS-TrafficTypeDiagnostic: DM6PR03MB3481:
X-Microsoft-Antispam-PRVS: <DM6PR03MB34811C27DA2FEEA6DB308EB0ED980@DM6PR03MB3481.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YP6JhsqSE+q8ExlEqkqYKpMtEcm1PX8WTLwZv1J3YQ9yclfoJm5mkEQtgiRqL7DXNwLvwruK30rPh9v5yocxKVoEx8sRKgTUeJaRIFtuGNyKhL/S4YL322katzKmFxCamuEYOaApRKLfVa/oPJVYS4ImRco9jdUGyce3+JTK2kHuqC1ToGYqreCql9eGdlobIyP+LkJuB47vfclM1gCKDWkct/BjxhJeQsFaUhtqtdoiGHUiXfVy4c0qMecN9xMOxHjzqbYQjFUk+v9rAextyWthUgvATP1LW7v8LfTtn9vkq2QW3zub8RHpw+mWn8WB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3580.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(66476007)(6666004)(66946007)(66556008)(5660300002)(86362001)(52116002)(16526019)(7696005)(186003)(55016002)(9686003)(4744005)(956004)(8676002)(2906002)(6506007)(1076003)(26005)(83380400001)(110136005)(316002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j3dFSseKrBJbZl3dwNYHbdsPcYwn0/mUL3aR1eC8QvR5tM/acAHFxqcACwerQUQ2zWjbgfm2jgnU4DgT+VYqPdQPnMekpwSvomGAKnBq/vBOtzopznW5QzNr0HV0zKh8iUbsOL1Gg/TftQOXABIRpX/NVBXWdGQCha5Lgq/XLTgEMXNSrzVNFSb+b4ZqKMTDgZTx+V5HaOhD712kzWoxfPwfTQieaR3A5zeUbjzTqr9npwkHDR85ykqf7L3C7j/CkUsxfDKlNLcf2eXL9wGYPXdrJfTOEcplVRHPYeEPAgfq2MT0Nzm4FlcvLRX/96k2EPwMSvNvJyhRiMorpB+klr3AV2G6G5KZrnIM2242ajVS5qqIcidYRlKfD4L4kNQkg9cbfSyhsfeS/tEf9irLHRP4yf8KZr4qfe5vMcbGiyZVzHG3AwS+J9q5k9WBYJPZjTrWhHCu052JjNWaQTv/ZlpGd9ukzhx1eT3qD+yp35M4rtdgu983UImRQCmfbpEh
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438e7a7e-c41f-4242-5cdc-08d8143e1e69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 10:47:10.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6szFAOk9hnsCha/FJAJ/f5n/vuia3NeaP7t4bxJWA7NSlLHjWO2hi8NYshBS/zpkIFIzpnX6/JO8G6n761qmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cortex-A76 uses some implementation defined perf events. Per
Cortex-A76 TRM r4p0, section C2.3 PMU Events (pages C2-386 to C2-394),
we can reuse Cortex-A57's perf events mapping currently.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 55e1d75af708..4fb13fbdc2df 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1127,7 +1127,7 @@ static int armv8_a75_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv8_a76_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a76",
-			      armv8_pmuv3_map_event, NULL, NULL);
+			      armv8_a57_map_event, NULL, NULL);
 }
 
 static int armv8_a77_pmu_init(struct arm_pmu *cpu_pmu)
-- 
2.27.0

