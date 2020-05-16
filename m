Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0138C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B212075F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RsD2EYk7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UHzG0x/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgEPGjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 02:39:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47382 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgEPGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589611180; x=1621147180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Hdq3SJku9dP/cMy8yxRRdBA2TPADmvP9rAYm/QHV8R8=;
  b=RsD2EYk7QyJ6zHNomWOjCBbCFXlw4xYUlgV6mLiesuyk0YqWHj2JlQl3
   DVU/EHEBPaktcKA5TL7Qq+ef3Yq0kF4LnxFBv/ZHwFp6LXVrD0Vy+y926
   +EUBUSlVqsO05ASG/yLb+Sa0pPhlk10UOt9im8DkrFEtHgpWpLd8LCI7M
   0wwNAaExfv+u7A2ylm9vakHdo2XDnmNgY6nf0X+oyZ8NLzCPZH3NQHw3y
   hxHQDjWCWu4msPTyfJHg5zVmctbFNESP4nl60Dm60oQX1OEvTH9QPNiqJ
   W9mBsFiNImQTTS0R3pr7bE8hSjz0igOhj2JmCpvFsVCZCkKLUx88ktwW3
   A==;
IronPort-SDR: kXV1bMZgeKeJyMClRaHfoq7BuUXGs/94uuxYX8gPY57JLZnkpaAv0EQv3o1H/Im1kZRqVdhxv0
 7QltP6OfmuO6LgNdNh4FYwI7//YISpIn2JEnGWxDpRYrAdhKvXHsoT5/8ssQpxSGkF5lUEU6Cq
 GvUNBT5IgCC1RT6eUObBLlGGz8NeoAKXDCem+rZNdhWioKxayXVESbtDB/6mdtBq9oS3l1sM/Y
 evJ3kF9ANcdroP4lOpCjSmQcmP0D5qii1gcW+PqTcxqa/Dn5+L6/tpmUPsNyP0k1qopyuxi15R
 WMM=
X-IronPort-AV: E=Sophos;i="5.73,398,1583164800"; 
   d="scan'208";a="246808227"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 14:39:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci9AX5zGGmlhKmbetYHe+R3Y03uWRgqFnIgRAYTAhupGQrav99S/L/deXT4gXrEfotQevSYPdmjccAGDtoBwJtjcR8khk4KDPLBxHaumVNuVrp3ftTpJrfIvY6C6l+8eQqwgQwIMI3IkhRgj1qDOcB48ehMdsYLzANy3QomVqpFukWqz0mRGpVkcrtuVrdH99yKjTKXRSir2bAcxYpjCGPJ74Zx/qIcLo+ywBTB5VjlzEx6fg0kjJy9jdtCvlQ1uh2+BqHYzFL0QMfsRYVL9PfdgT1ouQ69tR0UkXs8sSw5npfoW+iJMYJIYNVxIbs7Hwsv/HUFvKM2rFUPR7uwKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsMbv6a1cH4Sn1g8V4H9H4bimKhR7++ZHY70/ctou2U=;
 b=FthN0/GM+5M3rnm1sAcTC5lNYFU5Mu6O2NygrlUYpfbrmpuhu/yTe+kg4shXmJUn0dtW5ikmuEkQQ7cNwBCPXyaO1HrDS+2A//09h+tZtXEQfUJ7M9n+VJoxdgNqY2TRaOCX+qIGhoIQPHEf/odUA9SqFmOtk/4vztxttk7ssjhkOxwwPpuuedYLE0spGxJM5TfLEkFDdrpi4D2tsrJaBWXQtdRlf4MpIg9RaUq9tA5fywnwBUi+qkUvyuR8jANm77jo+SftQ2ZQH3VL9NBUtdNdeAXiThZg7Z9Fo32ePDOZ5z/VwskuVGBqPg9qgBnW8/NlCrWu5A5DSvAVtR3z/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsMbv6a1cH4Sn1g8V4H9H4bimKhR7++ZHY70/ctou2U=;
 b=UHzG0x/KkXVqYneR+aWAOBDS9kvWW7Hqu3DAFWbNW/pzgMNMc2QHFrkO2nD86+w3K+tm7r8vz1liJpQGB0teKIUTYiek7gfywW2Z5XPxj9wefyZM6i+MIPatVf49LbFg696ixoRpqB6VQ7W+1UbNQCfsZkgJ4AbeMAoMkG/jaZI=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4539.namprd04.prod.outlook.com (2603:10b6:5:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sat, 16 May
 2020 06:39:38 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2979.033; Sat, 16 May 2020
 06:39:38 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 2/4] irqchip/sifive-plic: Improve boot prints for multiple PLIC instances
Date:   Sat, 16 May 2020 12:08:59 +0530
Message-Id: <20200516063901.18365-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200516063901.18365-1-anup.patel@wdc.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::12) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.60.36) by MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Sat, 16 May 2020 06:39:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.60.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12575aca-acdf-451e-615a-08d7f963e7de
X-MS-TrafficTypeDiagnostic: DM6PR04MB4539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4539D47A05037B3B2DB9568E8DBA0@DM6PR04MB4539.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 040513D301
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DF0qtEgm9zF7s/slq9zwvT50AtUV4I98PoCdGRmcvOGDgyXmMcRZiP0O0Ha+/YvRYdrY80EO6hSmy6f+B1p+9fnghtnujoZgQMIy+3gDQ5+2GF51/AGjRgDiILIQdL2GDy4idWzBVK2VnKGDgvT2yOYJw58JWZ0s8YMTZ3bQAQ0m/STQt9N4s0ijM9Iddgv9w3jhhH72Bo6XTieV6rkuIHPs7JAvpd8X0m038K9+BFrYYYY1tggIEB9THxMeO7Cd8fXEUHTsSWd3LVrtL3HWU+NfI4AqA2VYEb8RvqxIlikLtgLBTL4rs2nEAnOlrQB5X84F9bBK1ZWDKFyJse9GaHDaFV8SrjS+e/UxyH6mBhDtLTaA7Ql+WVkEoyAEdkYzvNlNRx88vOogNLcLaT/f9iNUrp7beju7kg6o2BIsiPCCw7BTqtNqGpz+PjDRMIu7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(6666004)(1006002)(2906002)(8676002)(36756003)(8936002)(44832011)(26005)(54906003)(86362001)(7696005)(52116002)(55236004)(110136005)(1076003)(16526019)(186003)(316002)(5660300002)(66946007)(8886007)(55016002)(66476007)(66556008)(478600001)(956004)(4326008)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TrdWCZ/VCn9SWu8TtJXV3fn8XJxvC9Q33z4DKUnw25xVIzPc2E0XOHvw6OLXyGg67O5SPi2JlwxvUNImCkE4kMjqIB9+XW05kAFhec0MAz/9dtJBecRaAabeVLI4CrZEJFDfmLB35yK4Mr25yuuXPCrz6Y1Q9a+hP95jRMgZoPItj8IsdBfQnQHWdWLPPKVH6XgUcJPIat20XvZpHW3fdL1EffQpIRyK7GpbW4QknaZKhmLJGVx3VmWWMSTSGn4qJMM9Os1U3X3D+30ekLPUojMDTrD2ycn1pF7Pcmco/M8t+/LAtP/W04VWQsN3g1+3veJuSbZ4NglQm5RFxMYF5e15k1GUv/a8J7gTTCSyY7X9g2X3lEIWPvAIEGaOxj7N72ekjxK2cU6EgoY4VmoLMYYA94i9R8ODxWy5ct0oGgCqbRii04i7kuSK/xiFzH7/5rI5RgWPqoti5Jtm+01V2bG5Mab+xL5Pgqt8UEaKliA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12575aca-acdf-451e-615a-08d7f963e7de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 06:39:38.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmkFDuGDfLyo5G3tVf27Nl7tqd7cEcW+uj3hzAic1kSG33OT44GOumnNqTZaY5A1BbES67XJR2fBpXU+JdfS5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We improve PLIC banner to help distinguish multiple PLIC instances
in boot time prints.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/irqchip/irq-sifive-plic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 7dc23edb3267..2d3db927a551 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -284,6 +284,11 @@ static int __init plic_init(struct device_node *node,
 	u32 nr_irqs;
 	struct plic_priv *priv;
 	struct plic_handler *handler;
+	struct resource iores;
+
+	error = of_address_to_resource(node, 0, &iores);
+	if (error)
+		return error;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -377,8 +382,10 @@ static int __init plic_init(struct device_node *node,
 		plic_cpuhp_setup_done = true;
 	}
 
-	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
-		nr_irqs, nr_handlers, nr_contexts);
+	pr_info("interrupt-controller at 0x%llx "
+		"(interrupts=%d, contexts=%d, handlers=%d)\n",
+		(unsigned long long)iores.start, nr_irqs,
+		nr_contexts, nr_handlers);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
-- 
2.25.1

