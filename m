Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF20C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8642B20814
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rxudhhXL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rhbQnOaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgFKGOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:14:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7315 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591856090; x=1623392090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8rztky3nwF73R86YAi/Y0bnsDBzVkhLIjei/AYBNtCc=;
  b=rxudhhXLvbuVrxTe2og/S8AdvyWsXMCnHmYUmJWYbswfCo0Lcrx5OB4N
   eZ1ZaDC707p//ErBwNb8/Z0A8b6hbs9BPBIpYbMpvnkrM7HtNbwJvzpwI
   dlW6I2gYMPclM8UWgzV+C2lCtEByURIKafSeAVRKuUXQbMaXxnjnt+FvM
   TAO6jmsxdm5gAVtvneNzTYIPy982ORI9DMzNs6nBBrzEMI2Ry/7ZfExKe
   Ly63hYJ8T+1s0rAAxqReocMYERlulUq6ShLorx7pXC4is+cw12vxhqCaR
   8CSfCh4HlcblpIVnjMVG243BHZImoKb9zECrTpQfMcu9xEgeBRD8EbgIQ
   g==;
IronPort-SDR: guctp4f1hWFomhK51kvLwKpAxvFoF5RvneeeZTCYxQoanlnNz/ViTTFHCsLrWOXocft4YIKlQj
 VaEdL9fEWv7RXydqjir+hGRfAMo202fgNW0uNY69gLFhJQxEAcHNY0GUZRaY47TaJyMfB6aS21
 Sd7Ky5awhnPKBT4P1R4uddDMCDekDYXkMW1A7WAoEXTABiSKofcbWf8ny2/X3RCrKz9qPHHRLI
 8TQTEpX6J8gfNrHeDLexzNPF8EgjwMJ0mcx3oJHqRie0DnouE4QXuzK4V7nXa92Dz2gE3s+zJ4
 jFQ=
X-IronPort-AV: E=Sophos;i="5.73,498,1583164800"; 
   d="scan'208";a="248852982"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 14:14:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFKXAnN7KoTw9S+tyeYmcYrx97EC3QITueSJePpmPEfcIlF2gHwxMZ1H+pfxO+OtueQldN/PnW4DYEBJiZMJXiLR+YOkADMZ6VB39DuGjrj8X59mDo5BajTU7M/mkPUdesRVc2XRoiotTUdCep0TkaE7tXR03HGH8GjMNnAu85BwLXbqP61bpmqmiZnzs4GoL45Vfp5TLgUPUjEcini/PEQsy4r9w7d7WXv+oOK4ji8S8UHWwnC1Tf4C2k65rx6rFema/IaxAIJJCv+bJkFjX8qE+VajlQ9LCiyorIp6/tknsAXrhKfVBPjRoZdkYVo4ksD1XVo1nHFC1plzHSb/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CixexRslsnX7njnxUInvY2rSBt2XnpZ6ZYj5CQnYBQ0=;
 b=eupeqThm9N7c1a2a2x+vbfggfVTC+bvrTUYmbCpnGReSoOKHJ9KvE0e6DySGZtGfF6wWLrT6+9NSokrW5glxMaCI3wJ3fpb8Bd6PLoM5cAeygeMxPqssAltNViDMeVJeh7p4hU1nRqjghURbHq9pcFocIRqLUT6f95eUnvBnoFaMoCpTMhUrRAuAZrZRepi3AlLWgw2L7OEs4Yga2GzpvwO5LgaHtQfQwFKCZD3amQqdWD0U6XvAWEwZHy/+w/ZGhSGFlr02/xyoyf6utGm5ti1Z60kwxKSSGUXXla/Cv0V7jkMWlV5hf3mcLcMCLscX6vzCT399yog4qfXZ1TCUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CixexRslsnX7njnxUInvY2rSBt2XnpZ6ZYj5CQnYBQ0=;
 b=rhbQnOaD+NhQwlYo6IeUOAsfISTfKOrQYlgPwcLEjSH8BJyu/77YYxaWjYTLpmmZazbu9BjVM4kfA1LwoPfNX2LmXWqzz2WLSVRyrFuyu/JiKPkpsGmo71Sz9iKKb1YsI7eY8UeodP8FBP5QWBRV5gWAutHbYY697unnHgssh3s=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6332.namprd04.prod.outlook.com (2603:10b6:5:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 11 Jun
 2020 06:14:49 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 06:14:49 +0000
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
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v8 5/6] RISC-V: Remove do_IRQ() function
Date:   Thu, 11 Jun 2020 11:43:49 +0530
Message-Id: <20200611061350.434293-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611061350.434293-1-anup.patel@wdc.com>
References: <20200611061350.434293-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17)
 To DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.182.246.89) by MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:14:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.182.246.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e2dd7a9-8434-41c5-2c97-08d80dcebecd
X-MS-TrafficTypeDiagnostic: DM6PR04MB6332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6332204E50035B557DC29D5B8D800@DM6PR04MB6332.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1IT7ErDJrPkA6XlflnTINyrq9kNvqdAM7fLFtZoAVtH6h9GkYaIqdqfoZ0cGPfUSJmG7XoLROPKy/JrvU/cc/dQSc3yxNq0nYimvtpYjBuCjfPckRefr19iMNBTOKCA2vXNDb4cpg3Kz6RQ7Umx20Wfe/k0Sh/7/pDhc5Fk3/H7Hy1SFnI+kZ2q8seCM/ek8Zz0zGhVlnxhaQPKbI9cbkVI5RIpv7n0KeLaaCb13NWZCiQEySQdEJ3VVPlx1iVHRrzeJ+wIfpasV/2IQyGRkE/wA/UxnUHUn/JlHDyWDLZaX06QuwqPV5CfpLHko06V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(36756003)(16526019)(4326008)(186003)(44832011)(2616005)(55016002)(8936002)(1076003)(5660300002)(956004)(7696005)(110136005)(7416002)(83380400001)(478600001)(52116002)(8886007)(86362001)(316002)(54906003)(66556008)(2906002)(8676002)(26005)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: C1E34+hO20Yv9NggErbYH9IAXCIcZm96nGh/LogjXqXT1iYZ4rP0hxm88qZ88tQAg9xPkU5pigeZPwd9w3+EVbr0OXKxetlrZGiPUcl2DEaNgPkXSWWid4NXl6pLweTlx0hupGGobXq8+q04wO1WfghmfZeH0dRggm+9QdvnTti2QNd/oPwD26n5axdZgycI0SHO/1w6BJUFEN1tx7QAS0jd1sRT42tkPgUjISySAQB9OPgLowkWcbEBbmmBC0gskQoXLkS033nxgGdWgoAaOxl7gvjume/qiiLp6bVyvcO3Xtvjfr23ag1NU0hrdg2FoXoAu91DP1YtMwYudj8Wz+zQjQf2t+1aWAEjH8m1cvtp2WanX2ePFGXonduCm2qUj9SV+g8Ws3oIyydXnro8eEdTu7nPeJsX5ALvOsCvxN/C4vRQjxh1pxXsPMrEZEXmD5KWCS9GJz8S6tInZYAPUYgG1L5rIxheHX0QiJ/ZU8I=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2dd7a9-8434-41c5-2c97-08d80dcebecd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 06:14:49.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+3BWMgMBxCiuvZGQrEwUgFqUQDhsV12wa8OTbjbHvEcGBlTVwzK1vYKs6LeGHXEFnuBIeAy1Z9nRTw26Wy8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing do_IRQ() does is call handle_arch_irq function
pointer. We can very well call handle_arch_irq function pointer
directly from assembly and remove do_IRQ() function hence this
patch.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/entry.S | 4 +++-
 arch/riscv/kernel/irq.c   | 6 ------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 56d071b2c0a1..cae7e6d4c7ef 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -106,7 +106,9 @@ _save_context:
 
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
-	tail do_IRQ
+	la a1, handle_arch_irq
+	REG_L a1, (a1)
+	jr a1
 1:
 	/*
 	 * Exceptions run with interrupts enabled or disabled depending on the
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index eb8777642ce6..7207fa08d78f 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -16,12 +16,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
-{
-	if (handle_arch_irq)
-		handle_arch_irq(regs);
-}
-
 void __init init_IRQ(void)
 {
 	irqchip_init();
-- 
2.25.1

