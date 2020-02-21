Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A89C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEECE222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sQRinuQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBULuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:50:03 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:6139
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbgBULuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:50:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4Y46LV0svY680H0oTEsS/pFetk/ZxW1Vr4cNWuFeGg+i12KyGZk4hGX/8/60GnHxtrGd9PjtSbeoYzEIkNL/huO2W7g3hWl2HEmLe89jCKgaI/NHyw55IW/RTVyP/Cyu47QK4Ch0nLkd90aRiVCawPAOfZInxa+rJHbJW2fIxpUZqWbO+JlM1A8+3VH43zofXZuphlAFjFBDK8qY5ZqeO+dHtcyAgHlRpE2AmbZrsawjm7fLkA3DcD0+bSXuq2EG73wC8VPiJxlydhAGVnqvkirRKT4iQjxlwPjPjPR8nzJYbV8MJhI3aVfimr/TKeOJAaiGn3TndPDTd/QID1mMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAinLKdeuTbXDLur8W6cCD6Hzl49cfF7F0CwPnMJTi0=;
 b=LvV8vwchlaRc+Srk/f3/tEs1MGHGC0qtm4iNbTEhZHRsvrJyOtjpVvCrGg/0DlzYJCOK3g2Q8xA2njNPhA6RrpM/6zxJCXP0ydkXOuUBg/0ZMvs/uqmdtSICWi9p6JtrwiKHnZtJt9xxRDxBHkB7/cQ1ZswuJCiK8NaYBmAwt2kDqubSVutxq+euPctd2c3KLV+bK6TiPJx/ctMJ70n4T3mTNtjK8UUy/wzusKqiaLx/n0GVUQjzz+XTcKFPcTzYe+b9tZ1DyMP6ADzbY7P2ckL42CR16lxLL08+G/Bln6TlRe0oh15dwTg04tamskQeuJEojJ7Fk7636bbj83nV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAinLKdeuTbXDLur8W6cCD6Hzl49cfF7F0CwPnMJTi0=;
 b=sQRinuQQvvjOtL29K3V4JIKOaX3KYy/ZbZLUO7iE6fyxs9pjtyhcGT4b4Ubl6iasBaBzjGookM5EWR/ZIcOMwIsooEdmZ9enoAwZIzI/voVdv8k04cqWZhEBGc7WB+2VToAGc/X1KBY0mvCsYus8jdvI0SsUdlYZQYtxIVQtKXA=
Received: from SN4PR0201CA0027.namprd02.prod.outlook.com
 (2603:10b6:803:2e::13) by CH2PR02MB6615.namprd02.prod.outlook.com
 (2603:10b6:610:7b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Fri, 21 Feb
 2020 11:49:59 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by SN4PR0201CA0027.outlook.office365.com
 (2603:10b6:803:2e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 11:49:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Fri, 21 Feb 2020 11:49:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j56og-0002Yo-SW; Fri, 21 Feb 2020 03:49:58 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j56ob-0007e5-PQ; Fri, 21 Feb 2020 03:49:53 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01LBnjJx011605;
        Fri, 21 Feb 2020 03:49:45 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j56oT-0007dH-76; Fri, 21 Feb 2020 03:49:45 -0800
Subject: Re: [PATCH 3/3] irqchip: xilinx: Use handle_domain_irq()
To:     Marc Zyngier <maz@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1581496793.git.michal.simek@xilinx.com>
 <49c5a093d7ba1f20930c7433ed632e7c9bc7a2cb.1581496793.git.michal.simek@xilinx.com>
 <f028666cf1b1af428ad0564c4f93688b@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2333cecb-06f5-cd9e-8c11-bb2d16ebbfa2@xilinx.com>
Date:   Fri, 21 Feb 2020 12:49:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f028666cf1b1af428ad0564c4f93688b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39850400004)(199004)(189003)(81156014)(2616005)(81166006)(70206006)(2906002)(8936002)(356004)(70586007)(186003)(336012)(316002)(53546011)(426003)(8676002)(6666004)(9786002)(5660300002)(26005)(54906003)(44832011)(31696002)(478600001)(4326008)(31686004)(110136005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6615;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef999206-d444-4ae7-7556-08d7b6c42dd1
X-MS-TrafficTypeDiagnostic: CH2PR02MB6615:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR02MB661511D64F09B1ABB23540D6C6120@CH2PR02MB6615.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0320B28BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JeD44nGu4kx7qV65VWGlJsV2+snTXN2SdoE3EIuAJwJrXddRT+fTp0pQOrFdYNuVnzz6+8SQBFKnhSUJpKXNS7kuKWK3kaggZ+tzcw27dAAdpNc0oYVZU/7nPGEtfg70bcR4EfiLb6qIW2EgSjYXljYphnF+KZK9FXH1z2oIu7mgLpTEFJG+E5rd1ib+0XuG4QJjJ/lgdc7XxX1psAHwRENOf1iYmc+/ZhrsGe+2v24++KZsMApuVUAWsVMQMGITUI1/JzwyS7u85o4aUkT80+zQNtPdPXfPkiDHllMQKbM1zRrhQOELBgkyyvQxtQFyE71XW4wAMp7ddExHUb4A+lGL7OM/TERjUaHGuED2LLX7jtd+TKxGW6SxMvY+ddbaO5TEU2pacjrAVvoHQshWhXCejzNGGIBDrd+JxXI5ZBih24MqWLGfyOfjXGGKHuEt
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 11:49:59.3030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef999206-d444-4ae7-7556-08d7b6c42dd1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 02. 20 12:46, Marc Zyngier wrote:
> On 2020-02-12 08:39, Michal Simek wrote:
>> Call generic domain specific irq handler which does the most of things
>> self. Also get rid of concurrent_irq counting which hasn't been exported
>> anywhere.
>> Based on this loop was also optimized by using do/while loop instead of
>> goto loop.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>> ---
>>
>>  arch/microblaze/Kconfig           |  1 +
>>  arch/microblaze/kernel/irq.c      |  5 ----
>>  drivers/irqchip/irq-xilinx-intc.c | 44 +++++++++++--------------------
>>  3 files changed, 16 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>> index 3a314aa2efa1..242f58ec086b 100644
>> --- a/arch/microblaze/Kconfig
>> +++ b/arch/microblaze/Kconfig
>> @@ -48,6 +48,7 @@ config MICROBLAZE
>>      select MMU_GATHER_NO_RANGE if MMU
>>      select SPARSE_IRQ
>>      select GENERIC_IRQ_MULTI_HANDLER
>> +    select HANDLE_DOMAIN_IRQ
>>
>>  # Endianness selection
>>  choice
>> diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
>> index 1f8cb4c4f74f..0b37dde60a1e 100644
>> --- a/arch/microblaze/kernel/irq.c
>> +++ b/arch/microblaze/kernel/irq.c
>> @@ -22,13 +22,8 @@
>>
>>  void __irq_entry do_IRQ(struct pt_regs *regs)
>>  {
>> -    struct pt_regs *old_regs = set_irq_regs(regs);
>>      trace_hardirqs_off();
>> -
>> -    irq_enter();
>>      handle_arch_irq(regs);
>> -    irq_exit();
>> -    set_irq_regs(old_regs);
>>      trace_hardirqs_on();
>>  }
>>
>> diff --git a/drivers/irqchip/irq-xilinx-intc.c
>> b/drivers/irqchip/irq-xilinx-intc.c
>> index ad9e678c24ac..fa468e618762 100644
>> --- a/drivers/irqchip/irq-xilinx-intc.c
>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>> @@ -125,20 +125,6 @@ static unsigned int xintc_get_irq_local(struct
>> xintc_irq_chip *irqc)
>>      return irq;
>>  }
>>
>> -static unsigned int xintc_get_irq(void)
>> -{
>> -    u32 hwirq;
>> -    unsigned int irq = -1;
>> -
>> -    hwirq = xintc_read(primary_intc, IVR);
>> -    if (hwirq != -1U)
>> -        irq = irq_find_mapping(primary_intc->root_domain, hwirq);
>> -
>> -    pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>> -
>> -    return irq;
>> -}
>> -
>>  static int xintc_map(struct irq_domain *d, unsigned int irq,
>> irq_hw_number_t hw)
>>  {
>>      struct xintc_irq_chip *irqc = d->host_data;
>> @@ -178,23 +164,23 @@ static void xil_intc_irq_handler(struct irq_desc
>> *desc)
>>      chained_irq_exit(chip, desc);
>>  }
>>
>> -static u32 concurrent_irq;
>> -
>>  static void xil_intc_handle_irq(struct pt_regs *regs)
>>  {
>> -    unsigned int irq;
>> -
>> -    irq = xintc_get_irq();
>> -next_irq:
>> -    BUG_ON(!irq);
>> -    generic_handle_irq(irq);
>> -
>> -    irq = xintc_get_irq();
>> -    if (irq != -1U) {
>> -        pr_debug("next irq: %d\n", irq);
>> -        ++concurrent_irq;
>> -        goto next_irq;
>> -    }
>> +    u32 hwirq;
>> +    struct xintc_irq_chip *irqc = primary_intc;
>> +
>> +    do {
>> +        hwirq = xintc_read(irqc, IVR);
>> +        if (hwirq != -1U) {
>> +            int ret;
>> +
>> +            ret = handle_domain_irq(irqc->root_domain, hwirq, regs);
>> +            WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
>> +            continue;
>> +        }
>> +
>> +        break;
>> +    } while (1);
> 
> OK, so this what I suggested already. Just squash the two patches
> in one, there is no point in keeping them separate.

I sent it exactly how I have done it originally. Not a problem with
squashing that stuff together.

Thanks,
Michal


