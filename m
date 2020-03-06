Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AEFC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB41120848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Ebyou1CK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCFRrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:47:49 -0500
Received: from mail-db8eur05on2096.outbound.protection.outlook.com ([40.107.20.96]:41025
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgCFRrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:47:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov/jSL4jDZlOYek4F45FF9sInpuC4c4n8u7l46ZyzhpYvQJUq74qHBdjYeledxQODiZsyhjb6zK8uNAHxu2nGeNE7cXMtXfNZvNpC3OTw6OuoGFkFdEzzfEQU+QE1rI+2YjS2viytcKgsGOVRz3iI//jIq6uJfPiBpw0skxcZ6EZ5uoNH4/YCBOYHLhQM1TPHBvNKozeIReEG/i72cT0QheBPo7wObtK+A+vt40pw6rDvvSRTyOWCuuKRsYsgD52O+cxlrvy+jmycgg2DKtHbdlPbiwEFsAQAjE4ZQHNr3PgF0eheF8vTJJsXjq7ATU9u2KfRBZOqfT6xS5IjbIZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqJJMGuK6O+Nj+xsjF6xbTQzD4uhU/EwifS3A1i7xR0=;
 b=aDf+pj+kw20ojjGYk8B0PxgZsaWtCqbqEnqAyUIrcR28lCL0MEz8op7cUxKhNPWF6wUhSlx1tVU9J7ZsHLuRqdgXsfL6J0KHICE09NyJv1ySCOF8bY8BBL8EtW1GcNNRS43HZE1xgMx3DdJkow3BvzEApQTgJJ1+1M7DNxbkc9hwlysMNUttGYgQjS+S1/EOVeqy+PJKeFksvlS+e4/Rh5DJZPrZvyCUR+oUMPWy+C3bUGD59Rq1Go4dhEfOA/+bfNqM14Ae3Z/iQ+FVewIITSw4IBpMu5orketn9Wc1mU7v7umWDfOYF6ucGRIdgyY9jg3HHYb2TpXlxjlLNuBHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqJJMGuK6O+Nj+xsjF6xbTQzD4uhU/EwifS3A1i7xR0=;
 b=Ebyou1CKhW2/ItrWvaMyBK0ELQ2XIC2RyichLdv/Vc4CQD5eJVM8dkBkvOkJkfCkN7mI08OpzPb0WYpqLmx1W1gPYF0tK/XOmqlhscv3GNsOtfDz0pbf5huaj6UqQlyELFOeMaNCGYPMsIY/2DWpGUvtgDyoS13x38ihuycN55I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from DB7PR07MB5031.eurprd07.prod.outlook.com (20.177.192.205) by
 DB7PR07MB4715.eurprd07.prod.outlook.com (52.135.137.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.9; Fri, 6 Mar 2020 17:47:45 +0000
Received: from DB7PR07MB5031.eurprd07.prod.outlook.com
 ([fe80::b4b6:ab8a:bdf9:6579]) by DB7PR07MB5031.eurprd07.prod.outlook.com
 ([fe80::b4b6:ab8a:bdf9:6579%4]) with mapi id 15.20.2793.011; Fri, 6 Mar 2020
 17:47:45 +0000
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] genirq/irqdomain: Check for NULL in irq_domain_alloc_irqs_hierarchy()
Date:   Fri,  6 Mar 2020 18:47:20 +0100
Message-Id: <20200306174720.82604-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0026.eurprd09.prod.outlook.com
 (2603:10a6:7:15::15) To DB7PR07MB5031.eurprd07.prod.outlook.com
 (2603:10a6:10:5b::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.32.181) by HE1PR0902CA0026.eurprd09.prod.outlook.com (2603:10a6:7:15::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Fri, 6 Mar 2020 17:47:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [131.228.32.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65805008-d1b0-4f4a-1003-08d7c1f67a13
X-MS-TrafficTypeDiagnostic: DB7PR07MB4715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR07MB4715147C862CD6F06BC7524488E30@DB7PR07MB4715.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(26005)(5660300002)(36756003)(52116002)(186003)(6486002)(6666004)(16526019)(956004)(2616005)(1076003)(6506007)(4326008)(2906002)(6512007)(316002)(66476007)(8936002)(66946007)(6916009)(66556008)(54906003)(81156014)(81166006)(8676002)(478600001)(86362001)(45080400002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR07MB4715;H:DB7PR07MB5031.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzmldmpBgVgIhZwotMYxPzexUr6Me+EgEZeQZPsWJyUT5l5NlZ9U2mmg+MiflaLa48hWaYGYODXhNgEZWDwyIqfMn9WN5xe147L8hvIt2qK2S2vGZivAR/Aa8sl6IhqsMYEAFe+X/js1X+e86EhQPN7ju0zrxJp9ADjclM8RrNLS41ssf4fUAvgFFxTqyJ6LeC0Md+OrlMceaYzoCNCHR4ob1hD48RgaCOMQ8ql47xHUM/YAi43UykHdQMOYtbeClkhjvhigto667qC4IdFf4yrFRW0wcQvHozmNm1J0UFVmW7dXsa4U1NCiLA8zGDyV8mOqJJxV26GcNqdexsbCNYOF2oF6PiqzBTX14cOGod5VchE4cRz+DzksHHYotXoUyehCq6dMKeiuerg8sGhNtLHtOEGSLnmkHVDo7vm58GEic0AlSstX0JeHYneSXGab
X-MS-Exchange-AntiSpam-MessageData: G5ekQ8uDo2qBytiYhrsUEtG1xdinE9tiO8iZUn/o9eSt45bvls1m0Y6R+W5nqZnHLdFSwjkiBZ5N4HRo/lZ2/V321L/xB+XQfASa6MCgD2S9FEaQ7UOcSVdQ5Nwj9NdZ2FzKaParUL5GP4zbiuIyRg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65805008-d1b0-4f4a-1003-08d7c1f67a13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 17:47:45.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ9c0ZuMmeS6wCGb7KYWvPtEkM2FaLFkMWMkindL1j0AVrEka25GrOAAmcwsxBx00eyMrHGJ/faVRGmuZVygcmyaASMFFbm2BC+L2O3KyT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB4715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

irq_domain_alloc_irqs_hierarchy() has 3 call sites in the compilation unit
but only one of them checks for the pointer which is being dereferenced
inside the called function. Move the check into the function. This allows
for catching the error instead of the following crash:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 1845a981
[00000000] *pgd=0669c003, *pmd=1f83ff003
Internal error: Oops: 80000207 [#1] PREEMPT SMP THUMB2
Modules linked in: ...
CPU: 4 PID: 3665 Comm: modprobe Tainted: G        W  O      5.4.15-... #1
Hardware name: LSI Axxia AXM55XX
PC is at 0x0
LR is at gpiochip_hierarchy_irq_domain_alloc+0x11f/0x140
pc : [<00000000>]    lr : [<c06c23ff>]    psr: 200e0013
sp : c68d5c10  ip : 00000000  fp : d5589900
r10: 00000001  r9 : c68d5c34  r8 : 000002f8
r7 : d60dfe48  r6 : d60a8880  r5 : c06c1899  r4 : c0e04cc8
r3 : c68d5c34  r2 : 00000001  r1 : 000002f8  r0 : e0818800
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 70c5387d  Table: 077d4b00  DAC: 55555555
Process modprobe (pid: 3665, stack limit = 0xd2112104)
Stack: (0xc68d5c10 to 0xc68d6000)
...
[<c06c23ff>] (gpiochip_hierarchy_irq_domain_alloc) from [<c0462a89>] (__irq_domain_alloc_irqs+0xe1/0x24c)
[<c0462a89>] (__irq_domain_alloc_irqs) from [<c0462dad>] (irq_create_fwspec_mapping+0x75/0x194)
[<c0462dad>] (irq_create_fwspec_mapping) from [<c06c2251>] (gpiochip_to_irq+0x5d/0x68)
[<c06c2251>] (gpiochip_to_irq) from [<c06c1c9b>] (gpiod_to_irq+0x2b/0x3c)
[<c06c1c9b>] (gpiod_to_irq) from [<bf973073>] (gpio_irqs_init+0x67/0x170 [gpio_irqs])
[<bf973073>] (gpio_irqs_init [gpio_irqs]) from [<bf974048>] (gpio_irqs_exit+0xecc/0xe84 [gpio_irqs])
Code: bad PC value

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 kernel/irq/irqdomain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c1f8fa4..7496eb1 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1326,6 +1326,11 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
 				    unsigned int irq_base,
 				    unsigned int nr_irqs, void *arg)
 {
+	if (!domain->ops->alloc) {
+		pr_debug("domain->ops->alloc() is NULL\n");
+		return -ENOSYS;
+	}
+
 	return domain->ops->alloc(domain, irq_base, nr_irqs, arg);
 }
 
@@ -1363,11 +1368,6 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			return -EINVAL;
 	}
 
-	if (!domain->ops->alloc) {
-		pr_debug("domain->ops->alloc() is NULL\n");
-		return -ENOSYS;
-	}
-
 	if (realloc && irq_base >= 0) {
 		virq = irq_base;
 	} else {
-- 
2.4.6

