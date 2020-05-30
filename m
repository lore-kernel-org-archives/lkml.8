Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB04C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D2820776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wzlcpi6v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HAwd0Gnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgE3KIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 06:08:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3443 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgE3KIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 06:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590833304; x=1622369304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rwodEWhO07nN9+WYg7XaEo9/JfXjRNV+hU6q5mSAkec=;
  b=Wzlcpi6v8tQRQS5w1i5ObecaDdd5l+S1ps/lnod/d5j0zH5buHLiTswr
   rF3GuJDXL8ZHo5QzuYlAOsV5d8OZbG/bUjyUj9S279aSjwHFtA1EZQXOn
   E2ehQI2Bc3pnLPUDvafrvoA74lYKKVaATNWckhAQww82SpsX5UKZQfPmq
   RKSPcFl7OS49kHKxqxYy5v6punh5HzwEf2eJGai9a+tZ1XQbSIxYYROk8
   skpTgV5J2dvvGCL8c/7KfKwJFv53JhJk+y977aSzG02lcKKMfeu2Gy+hm
   pWCTOz4+fEZO9k5Fj7PyHua49T6uYwVE19gaJEwMH0uin//YY6MUNHLZW
   A==;
IronPort-SDR: VKnG2j27wUPQ2vTC/cSiGHg76uW2V5ifb8H8Ty7q98wBxHvJ+5xp/ERjun0r00ZFTiR6G0Xd9o
 vUNx0IrG7vds/Myva+bc3MsazaGPwv8fzgLDf1SMMh/T+ODNsX1q5WHftuM3fNPXvVIT+GnTeE
 zfVTsR35TYLT4lkNPaFFbvsOP0tgYsl8z1Y5ADzpgayYDfQDZ6T4ouiFkaMwVcgoLJixzLOuzY
 gp6IbIf+m90WA0+1fNyrqrqWu7I/FNAdOhHdQUsRlTzi3Dc5LpVdyc/Y+06KyzbAywbPF8soYC
 S78=
X-IronPort-AV: E=Sophos;i="5.73,451,1583164800"; 
   d="scan'208";a="138846380"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2020 18:08:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht64lMgaoshqyYpCjSmUmp9UQIUUznprrIpqpuaIbO/qT0Nxa9NWAiJzsOCbXNcCR7LOumKSX8GrBaD5kd4qxJhapnCBZfTeGIrmW2sLi48e4QmrGZhaUIOxjDJsWC5IU1eJVOV6kOZxnql0rEydPwpFEekpsKzTSqAwqqpdvv8pxeUPUGiG32sw4uw9Bdf4KqM/TZeEwBLggaSnCmIbsgwb8oSSep4OyAJ8iV/kecTG6M1/2NiSuBGsk1B1lK596T0ouByU0KwxyFo20DSzCLzamZQnBdeWSmGKmmQHuVmhdlnXM2nTw5+xXpw50BUvRUF0HY+83ibru0rT+GySuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlnEz0/qfGdSSIBe4X+trDq3j196LxWuDxb5JfIl4Wk=;
 b=AQ7hI+P/5zkWWHyz2IuzT4C+cJOoKCq3iKC10hvnCWTFsMQmVb0giOxnjXv8IfYJGREsKS+6dQbT7/ayRTQCyKKxP90rJ02b8NlAVjV2Gc141TyghELM2DJO6xFi28kwJB2czJYVBINKe1KboIldlLsbLrtkVntrYyslBaoC0XF9FLDGaLtFAokVd9iz/YSITbmm8wDt6fMdPpIWNnYbLxPf7t4G6E+nrTC+SGW3dPre0UTJiOgeA2C61lrBZc+LAEM8zGg3B1vcYyuuowgmByXW9CgSpt5mmQc6AmjQpCsFuSUG2vaF5qRbLdzB5JE+p7jsandXm06+CahF7vRs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlnEz0/qfGdSSIBe4X+trDq3j196LxWuDxb5JfIl4Wk=;
 b=HAwd0GnkKjE4rkGkB7y4rBrGSO4nPoMJSuUa7GGbk9W10YwHZ5K9ICZirmXSg9uSsrzyKTs89YE6o4PY6dA+E2dubLZFDphTkTG9pdk6kaMFBFsmvCS+HRn7DDMonzoTASQKZEvrDLzAv1jmCgYMD7LFeAG3FCZ88FixfTCU2uk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4314.namprd04.prod.outlook.com (2603:10b6:5:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Sat, 30 May
 2020 10:08:19 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.022; Sat, 30 May 2020
 10:08:19 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v6 6/6] RISC-V: Force select RISCV_INTC for CONFIG_RISCV
Date:   Sat, 30 May 2020 15:37:25 +0530
Message-Id: <20200530100725.265481-7-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200530100725.265481-1-anup.patel@wdc.com>
References: <20200530100725.265481-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::23) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.61.131) by MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21 via Frontend Transport; Sat, 30 May 2020 10:08:15 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.61.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82c4d406-5203-49c8-41b8-08d80481608a
X-MS-TrafficTypeDiagnostic: DM6PR04MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4314E7CDBE9E1282C4F232C28D8C0@DM6PR04MB4314.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 041963B986
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/vrcB/BB3cKMJKwLx/4E0jMPbmpuNFzAVt6Zp/7FSwFtgGvnMQdHpDEbsaEba6VlhT7x0JcQUYPASI0FBUz9oosJiPrNmgcruFMlJypl5zvJsY8oQf034vlnavuNRV3ufL9dqRyCNgFp0wnpNAlJDpJUY9lsYgg2wnqjIRtu23/VM9LNJFdCzBBzW75JKPrQEBsjoGJy6SSjvNnQcdq/4A+UozoO21UkwGZ6EpYbNOlIHtIt1PSm52smKKUq6JIDvZGQsh78m/7MuWAJY91snsOhFz4EXPoSlM58fX4k/oQGOCEHdXfGXJOYn/aZ3iT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(26005)(4744005)(1006002)(186003)(1076003)(6666004)(55236004)(4326008)(956004)(8886007)(16526019)(5660300002)(2616005)(8676002)(8936002)(478600001)(36756003)(44832011)(2906002)(55016002)(7696005)(52116002)(7416002)(54906003)(110136005)(66476007)(66556008)(66946007)(86362001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: o8pIbFXNiGeMNDOpD+ZHqESb6xDiT/eiedh56pVYmN+1cnvYTi1xWDz3SVr1b7ofnUxPI8O2xc1hjgm3YelgFx4dZ3fBBPv/mL+l1+WAF33k2uLMCVxOBmdZT9nNy3aKimWBrkXX1YN9R42NRIZTj5hqOtzKM2B+yKUQ8EqP4d8Yk20xDg7EaiICGnv0FufD6gU3KoFbzu4yrntqbOovUb0eUvZyWNIfvEdjDvPWCtUCMWEBdzFO8EErZqtQNejS5E0cdgDKmzyx5vN/oS/Hk3X3944zc6p+hYZHYtErRk+0WSRX7pzHUFYNNm/M5gqFRyZVtrR45xHiwje2S6UpfN2R847NWbybD6ZDSvXv5lMz4cyqN5w4PI19PFOvRgh10QHCBdks4cNOj21CN778StOGcR+DauOCaoCNVvg1uQmoGzRgA5Xgczj7VuJUk/gG36BSHgjgnzC5LgOdR893Om9CBHAGWaJeXR3tiPOGnJk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c4d406-5203-49c8-41b8-08d80481608a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2020 10:08:19.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgx7CYmQ+d4pN5un/86K0vBK8Tq2pYlJ6INzO7n+UI2HOEPb65wlLSiBjxZ40fBAqaFdClHuDkQFxi+qkUaveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V per-HART local interrupt controller driver is mandatory
for all RISC-V system (with/without MMU) hence we force select it
for CONFIG_RISCV (just like RISCV_TIMER).

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 822cb0e1a380..2cf0c83c1a47 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -51,6 +51,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
+	select RISCV_INTC
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_ARCH_TOPOLOGY if SMP
-- 
2.25.1

