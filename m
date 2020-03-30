Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81135C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2F72073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GU6aP+P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgC3IdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:33:11 -0400
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:58721
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729594AbgC3IdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:33:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTiK8WRSdtdDJLGKHX1v2h0kiYEf60V7IJzeBu214M1By68htoONtq0T9MPpdUnPgAtGw5e2U3wgOK2aSYAU2bTr2byeO2ZwF7ADNSrhlChQLKcUclZxJ8P7E/Hskr9L4OKOOCDulk1l/epYz7OVQoVNZ8hauxpmhHBRbGpZsPtTrYOKl3V3DFkf9gFyMbjL/QjhBno5egdsiywig158A2gLgxy4BZb3qopsB0IpeQivJVUDDyOz2EzQyPyVq71h9QitEFcoeqGfuwCW84Do9UJYCJIw8qybnFgOwE18++pr7cfT5xoU1GVCaNRBV1eiOHSZxcKXf4CPvntQZlsETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rsIcWJZdkE8g4X3aXZWihiX1bYcoMHoNVqwD6SO+1Q=;
 b=Ta3Ba7DWyeB8bar9NM+Vn9R3Vkl3BZaC/iPivV4KnlnmH5nIo2RwRbv+3SCV1d5koVSrObUHgZNsZPbkAWUbZX1JBySRipshcifygZSyV9JHj9Vzu/isxRu+O8iwKDfllww4F9g0fKrEi/pB8w2MMD7BD86MAGqXVndQ3KV444S21c38Wao/BKwfPWwVsnCHGzqnTXMMTGVCHaESFqp0oC9S9rtKoPaPkRjrp0heLqjKD4j1QjKXIu9kDXC2/GwwK0uqv7e3sgHHXKvbNc96WX6txTRaRrF7APxhW1ySQXW+LezWspvVICRhbjx//Z4zpUovF3Uq5cfgw//Y66f6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=canb.auug.org.au smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rsIcWJZdkE8g4X3aXZWihiX1bYcoMHoNVqwD6SO+1Q=;
 b=GU6aP+P8lwRgJ/UC4qq3GTjxu17pTuCAvsHP/21+BRw/CUQwIC3jT2QGFxUg/ZufjJP8hJzb9qK3Km0RNaCgimP0sHOt2vWZ5Jt939boWg4IMf56P6ZzrkddAnW3PN03QYg4uW/acaD2BUupRvd87AeznVTokVfIzLUDWIP0M9w=
Received: from MN2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:208:23c::24)
 by MWHPR02MB2814.namprd02.prod.outlook.com (2603:10b6:300:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 08:33:05 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23c:cafe::cf) by MN2PR18CA0019.outlook.office365.com
 (2603:10b6:208:23c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 08:33:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; canb.auug.org.au; dkim=none (message not signed)
 header.d=none;canb.auug.org.au; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2856.17
 via Frontend Transport; Mon, 30 Mar 2020 08:33:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIpqy-0006jr-5d; Mon, 30 Mar 2020 01:33:04 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIpqt-00008X-2g; Mon, 30 Mar 2020 01:32:59 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jIpqo-0008O4-8k; Mon, 30 Mar 2020 01:32:54 -0700
Subject: Re: [tip: irq/core] irqchip/xilinx: Enable generic irq multi handler
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200317125600.15913-4-mubin.usman.sayyed@xilinx.com>
 <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <083ad708-ea4d-ed53-598e-84d911ca4177@xilinx.com>
Date:   Mon, 30 Mar 2020 10:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39850400004)(376002)(346002)(136003)(396003)(46966005)(5660300002)(426003)(70586007)(70206006)(336012)(2616005)(44832011)(2906002)(26005)(316002)(8936002)(186003)(54906003)(9786002)(110136005)(31686004)(8676002)(478600001)(36756003)(6666004)(356004)(966005)(81156014)(81166006)(82740400003)(47076004)(4326008)(31696002)(41533002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e1c583c-bb26-4a0a-c6fc-08d7d484f790
X-MS-TrafficTypeDiagnostic: MWHPR02MB2814:
X-Microsoft-Antispam-PRVS: <MWHPR02MB281425CB27ACB5522BB32A5AC6CB0@MWHPR02MB2814.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haKnq1jHMM2ZGgW8nXMmGg7yjiwHfcA+7O4kfSAL+HcMD2FeITH+7c/eIA92g/mjdIuk9l1FO5uVw0erCq+wwbtSKI/JeoHWkkArLFSnof5RmjZD0lm1Hw+We/nQLKge1skK3Hchsicw7vguDUfNUN4UtMEOYrDkfrqBWeNRSp5DugkTX2uNRyXjA3eqC4SIG+SYEXfH84vCYtRK9WvR3Y1aMbl7pULhMlmof2RIh0n0hZUypywOizT8NfK+kgrDKRzpi8hymy9sXpoz3sZYzba5PJr5z8eB65BSd/lIsz/8a4iKoCS+C/nTVYrNDqyS5/Jmc+wv88GoDOgwRrLnHAljMAXJwJ5oPZFzg3l+wLYut0XDrx+iBRphxurctFYMW+RG2ASbZ4fPNRv/MM5XV9onhhel+bIdvtARam9w1tHKTAJ6mczdvGc65q5RJ0Fb9FfDXaZXOPJvj4EfZBYp6UCtIi4PoPOhHWPo3K6xHQjdNZNiTJclBoU0pXbeRd8aqYqv5C7vsaqo/k95xITMLOs1QO9VbwoZUh/BbE4FFepDYjjfj+wjk9Skr/T4t4524tFn1P4okjCecM3U7/1kBvjWkYn/SpiDLD6d2Dd6Lhk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 08:33:04.8037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1c583c-bb26-4a0a-c6fc-08d7d484f790
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Marc,

On 29. 03. 20 22:26, tip-bot2 for Michal Simek wrote:
> The following commit has been merged into the irq/core branch of tip:
> 
> Commit-ID:     a0789993bf8266e62fea6b4613945ba081c71e7d
> Gitweb:        https://git.kernel.org/tip/a0789993bf8266e62fea6b4613945ba081c71e7d
> Author:        Michal Simek <michal.simek@xilinx.com>
> AuthorDate:    Tue, 17 Mar 2020 18:25:59 +05:30
> Committer:     Marc Zyngier <maz@kernel.org>
> CommitterDate: Sun, 22 Mar 2020 11:52:53 
> 
> irqchip/xilinx: Enable generic irq multi handler
> 
> Register default arch handler via driver instead of directly pointing to
> xilinx intc controller. This patch makes architecture code more generic.
> 
> Driver calls generic domain specific irq handler which does the most of
> things self. Also get rid of concurrent_irq counting which hasn't been
> exported anywhere.
> Based on this loop was also optimized by using do/while loop instead of
> goto loop.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> Link: https://lore.kernel.org/r/20200317125600.15913-4-mubin.usman.sayyed@xilinx.com
> ---
>  arch/microblaze/Kconfig           |  2 ++-
>  arch/microblaze/include/asm/irq.h |  3 +---
>  arch/microblaze/kernel/irq.c      | 21 +-------------------
>  drivers/irqchip/irq-xilinx-intc.c | 34 +++++++++++++++++-------------
>  4 files changed, 23 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 6a331bd..242f58e 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -47,6 +47,8 @@ config MICROBLAZE
>  	select CPU_NO_EFFICIENT_FFS
>  	select MMU_GATHER_NO_RANGE if MMU
>  	select SPARSE_IRQ
> +	select GENERIC_IRQ_MULTI_HANDLER
> +	select HANDLE_DOMAIN_IRQ
>  
>  # Endianness selection
>  choice
> diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
> index eac2fb4..5166f08 100644
> --- a/arch/microblaze/include/asm/irq.h
> +++ b/arch/microblaze/include/asm/irq.h
> @@ -14,7 +14,4 @@
>  struct pt_regs;
>  extern void do_IRQ(struct pt_regs *regs);
>  
> -/* should be defined in each interrupt controller driver */
> -extern unsigned int xintc_get_irq(void);
> -
>  #endif /* _ASM_MICROBLAZE_IRQ_H */
> diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
> index 903dad8..0b37dde 100644
> --- a/arch/microblaze/kernel/irq.c
> +++ b/arch/microblaze/kernel/irq.c
> @@ -20,29 +20,10 @@
>  #include <linux/irqchip.h>
>  #include <linux/of_irq.h>
>  
> -static u32 concurrent_irq;
> -
>  void __irq_entry do_IRQ(struct pt_regs *regs)
>  {
> -	unsigned int irq;
> -	struct pt_regs *old_regs = set_irq_regs(regs);
>  	trace_hardirqs_off();
> -
> -	irq_enter();
> -	irq = xintc_get_irq();
> -next_irq:
> -	BUG_ON(!irq);
> -	generic_handle_irq(irq);
> -
> -	irq = xintc_get_irq();
> -	if (irq != -1U) {
> -		pr_debug("next irq: %d\n", irq);
> -		++concurrent_irq;
> -		goto next_irq;
> -	}
> -
> -	irq_exit();
> -	set_irq_regs(old_regs);
> +	handle_arch_irq(regs);
>  	trace_hardirqs_on();
>  }
>  
> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
> index 1d3d273..ea74181 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -124,20 +124,6 @@ static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
>  	return irq;
>  }
>  
> -unsigned int xintc_get_irq(void)
> -{
> -	unsigned int irq = -1;
> -	u32 hwirq;
> -
> -	hwirq = xintc_read(primary_intc, IVR);
> -	if (hwirq != -1U)
> -		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
> -
> -	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
> -
> -	return irq;
> -}
> -
>  static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
>  {
>  	struct xintc_irq_chip *irqc = d->host_data;
> @@ -177,6 +163,25 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static void xil_intc_handle_irq(struct pt_regs *regs)
> +{
> +	u32 hwirq;
> +	struct xintc_irq_chip *irqc = primary_intc;
> +
> +	do {
> +		hwirq = xintc_read(irqc, IVR);
> +		if (likely(hwirq != -1U)) {
> +			int ret;
> +
> +			ret = handle_domain_irq(irqc->root_domain, hwirq, regs);
> +			WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
> +			continue;
> +		}
> +
> +		break;
> +	} while (1);
> +}
> +
>  static int __init xilinx_intc_of_init(struct device_node *intc,
>  					     struct device_node *parent)
>  {
> @@ -246,6 +251,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
>  	} else {
>  		primary_intc = irqc;
>  		irq_set_default_host(primary_intc->root_domain);
> +		set_handle_irq(xil_intc_handle_irq);
>  	}
>  
>  	return 0;
> 

Stephen reported compilation issue when this patch is applied because of
removal of xintc_get_irq() which is also used by ancient ppc405/ppc440
xilinx platforms. I have reported this twice to Marc already last week.

On Friday I have also send v1 of removal of that platforms (need to send v2)
https://lore.kernel.org/alsa-devel/cover.1585311091.git.michal.simek@xilinx.com/

That's why please really consider next steps and let us know.

Thanks,
Michal


