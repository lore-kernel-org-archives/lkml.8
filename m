Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF55206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pPwN7IJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgC3JEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:04:06 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:6178
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729841AbgC3JEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv7LLhsbJSS/bO6Alv7F4uJchMDMmrglilNqbADxi+L0sKFcFLJyww6PcvZcYKQ4DZh9HEorB5vCIPzXnPGisoliJWZSrga9SxUHXWg5NPvJnf1Z2OZrojI9kOprZi48S/3AIKt5GRlJT3S+4QwLMN2WCIs8Yas0haY+QwBy3SLRG1DhRmOXmr8IsjWKLAwBU5o7MT71Oc4BFIPJ/q1m+wMM80Ci0+BXtFHmdiQQb0FlfEdN5jTK0gk7dNBFuYfPXqcFNn0bJaSZPcXxDRspAIr9H5Vxg4BtZjF/mhUqGElFDd1+SRGCyT8eF5A0biehnD1Gw4M5o0hosfks6TgJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7upvjeE053iTaTdFN+Y3Ct2oswbAfEwsCGgxJic8nAY=;
 b=CVW8RgT42UyUUYoCmIaP/mS+VJyy+xekpH1lY+7zt8MsOMF7w9ca6RNVlCSVGdQcIlrElY0osrjgSJepwOHL8qQ9xP5xHyVmS9AVan491DUWORV5w2rU2niL5JnRAsi0OQYsswWkGgULGfqCU52y8siNSuL7zDWsvZ1D2/6YnxZqyS+YSpEzXMOC377D63G3suiRF891QIYbCDBTwYe/dxDoIq0N7iIc1pp7+tGnIjBGNvO0XisslblTh4QnPi2V4a4VmBfBLI0UpMxDZP9YsatqfjbHqQNHwKo1wvG7T6VcdneiWrvH9dSXV2Ib4XCoOE6MnsTC5u7PspR8JlIa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7upvjeE053iTaTdFN+Y3Ct2oswbAfEwsCGgxJic8nAY=;
 b=pPwN7IJKl/sLs5JdQl/XuPJacYUNQhp77tBWDyd8FNPgzzyibs39AbIc5pQnPiBCBPjIqIUjMkGgBw1l6TdHktvtuU+VM+7Lk5z72sfpwlvvbuf74ZpMmdC2Qxviv2i/aSa3aqJxBI2DgcmkzqlGzcUxCOHN8qSMp3m2mKLGMVg=
Received: from SN4PR0701CA0032.namprd07.prod.outlook.com
 (2603:10b6:803:2d::12) by BL0PR02MB4419.namprd02.prod.outlook.com
 (2603:10b6:208:44::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 09:04:02 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::9f) by SN4PR0701CA0032.outlook.office365.com
 (2603:10b6:803:2d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 09:04:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2856.17
 via Frontend Transport; Mon, 30 Mar 2020 09:04:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIqKv-0006ri-PG; Mon, 30 Mar 2020 02:04:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIqKq-00038w-MF; Mon, 30 Mar 2020 02:03:56 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02U93lX5007025;
        Mon, 30 Mar 2020 02:03:47 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jIqKg-00037I-RM; Mon, 30 Mar 2020 02:03:47 -0700
Subject: Re: [tip: irq/core] irqchip/xilinx: Enable generic irq multi handler
To:     Marc Zyngier <maz@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200317125600.15913-4-mubin.usman.sayyed@xilinx.com>
 <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
 <083ad708-ea4d-ed53-598e-84d911ca4177@xilinx.com>
 <085188fea81d5ddc88b488124596a4a3@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
Date:   Mon, 30 Mar 2020 11:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <085188fea81d5ddc88b488124596a4a3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(31696002)(70586007)(186003)(70206006)(54906003)(82740400003)(110136005)(316002)(47076004)(4326008)(26005)(2616005)(356004)(6666004)(44832011)(31686004)(336012)(426003)(9786002)(8936002)(478600001)(53546011)(2906002)(966005)(36756003)(81166006)(5660300002)(8676002)(81156014)(41533002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48a7946e-e9b3-493d-160d-08d7d4894a9a
X-MS-TrafficTypeDiagnostic: BL0PR02MB4419:
X-Microsoft-Antispam-PRVS: <BL0PR02MB441959C44F41EEEB4AD9A20BC6CB0@BL0PR02MB4419.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLXVLR21H4ShlWRx6KVxqYet46DNm/TzM/1bdlzNRmQcosPfaBdPngiPSrFz0+45Et52fufqtvAIxK5XzC61SrWmt2OtE3VNX0aKq1uJM+B/IqoEF/Y7P9jqgyIuKVbXb7KeBdJ00eO92yBuWxvEs4ygy60pVNGwGyvGcdab7jWZLObPRBFo1513lRPtlWEU6zuTr9JZkK5JJmbWTqqbaEQW9+O90AbwDNpQfbrMhSAQWp9gBLbf/SRxW8hkP6mAYA8pIbLgy+dcBLraSDS2ad3+mZ3zCXqp/jnyjXCG3Ldzo3Ja5JgoDOVm+wvxwlHisnrCdLwGbrsx6OWnt1dSWctguG7Ze6N9cZ3wiL55diZjSiA2plMCN7Otuq0zzO7JV421L3HgQHlaNe8nlFF2/HCJ6CZjrLN016k64Un9KCz+5C6P02Ok/9siduYooNasBuxN504O3IOWjmsXem+T2IV0KHNyq336oREGV+aXkIl2xY2zm+tGOiW01MgfzCQcsuOmvA+CFxftAR/0UelvRK6BEcQYifY3prbWfTJTgNknu72pI9E0qzA9p4ldJZWr7jVoY41cNyi9wal0bD70b4TZDz760/xDpBG6E4GliqM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 09:04:02.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a7946e-e9b3-493d-160d-08d7d4894a9a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 03. 20 10:45, Marc Zyngier wrote:
> On 2020-03-30 09:32, Michal Simek wrote:
>> Hi Thomas and Marc,
>>
>> On 29. 03. 20 22:26, tip-bot2 for Michal Simek wrote:
>>> The following commit has been merged into the irq/core branch of tip:
>>>
>>> Commit-ID:     a0789993bf8266e62fea6b4613945ba081c71e7d
>>> Gitweb:       
>>> https://git.kernel.org/tip/a0789993bf8266e62fea6b4613945ba081c71e7d
>>> Author:        Michal Simek <michal.simek@xilinx.com>
>>> AuthorDate:    Tue, 17 Mar 2020 18:25:59 +05:30
>>> Committer:     Marc Zyngier <maz@kernel.org>
>>> CommitterDate: Sun, 22 Mar 2020 11:52:53
>>>
>>> irqchip/xilinx: Enable generic irq multi handler
>>>
>>> Register default arch handler via driver instead of directly pointing to
>>> xilinx intc controller. This patch makes architecture code more generic.
>>>
>>> Driver calls generic domain specific irq handler which does the most of
>>> things self. Also get rid of concurrent_irq counting which hasn't been
>>> exported anywhere.
>>> Based on this loop was also optimized by using do/while loop instead of
>>> goto loop.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>> Link:
>>> https://lore.kernel.org/r/20200317125600.15913-4-mubin.usman.sayyed@xilinx.com
>>>
>>> ---
>>>  arch/microblaze/Kconfig           |  2 ++-
>>>  arch/microblaze/include/asm/irq.h |  3 +---
>>>  arch/microblaze/kernel/irq.c      | 21 +-------------------
>>>  drivers/irqchip/irq-xilinx-intc.c | 34 +++++++++++++++++-------------
>>>  4 files changed, 23 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>> index 6a331bd..242f58e 100644
>>> --- a/arch/microblaze/Kconfig
>>> +++ b/arch/microblaze/Kconfig
>>> @@ -47,6 +47,8 @@ config MICROBLAZE
>>>      select CPU_NO_EFFICIENT_FFS
>>>      select MMU_GATHER_NO_RANGE if MMU
>>>      select SPARSE_IRQ
>>> +    select GENERIC_IRQ_MULTI_HANDLER
>>> +    select HANDLE_DOMAIN_IRQ
>>>
>>>  # Endianness selection
>>>  choice
>>> diff --git a/arch/microblaze/include/asm/irq.h
>>> b/arch/microblaze/include/asm/irq.h
>>> index eac2fb4..5166f08 100644
>>> --- a/arch/microblaze/include/asm/irq.h
>>> +++ b/arch/microblaze/include/asm/irq.h
>>> @@ -14,7 +14,4 @@
>>>  struct pt_regs;
>>>  extern void do_IRQ(struct pt_regs *regs);
>>>
>>> -/* should be defined in each interrupt controller driver */
>>> -extern unsigned int xintc_get_irq(void);
>>> -
>>>  #endif /* _ASM_MICROBLAZE_IRQ_H */
>>> diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
>>> index 903dad8..0b37dde 100644
>>> --- a/arch/microblaze/kernel/irq.c
>>> +++ b/arch/microblaze/kernel/irq.c
>>> @@ -20,29 +20,10 @@
>>>  #include <linux/irqchip.h>
>>>  #include <linux/of_irq.h>
>>>
>>> -static u32 concurrent_irq;
>>> -
>>>  void __irq_entry do_IRQ(struct pt_regs *regs)
>>>  {
>>> -    unsigned int irq;
>>> -    struct pt_regs *old_regs = set_irq_regs(regs);
>>>      trace_hardirqs_off();
>>> -
>>> -    irq_enter();
>>> -    irq = xintc_get_irq();
>>> -next_irq:
>>> -    BUG_ON(!irq);
>>> -    generic_handle_irq(irq);
>>> -
>>> -    irq = xintc_get_irq();
>>> -    if (irq != -1U) {
>>> -        pr_debug("next irq: %d\n", irq);
>>> -        ++concurrent_irq;
>>> -        goto next_irq;
>>> -    }
>>> -
>>> -    irq_exit();
>>> -    set_irq_regs(old_regs);
>>> +    handle_arch_irq(regs);
>>>      trace_hardirqs_on();
>>>  }
>>>
>>> diff --git a/drivers/irqchip/irq-xilinx-intc.c
>>> b/drivers/irqchip/irq-xilinx-intc.c
>>> index 1d3d273..ea74181 100644
>>> --- a/drivers/irqchip/irq-xilinx-intc.c
>>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>>> @@ -124,20 +124,6 @@ static unsigned int xintc_get_irq_local(struct
>>> xintc_irq_chip *irqc)
>>>      return irq;
>>>  }
>>>
>>> -unsigned int xintc_get_irq(void)
>>> -{
>>> -    unsigned int irq = -1;
>>> -    u32 hwirq;
>>> -
>>> -    hwirq = xintc_read(primary_intc, IVR);
>>> -    if (hwirq != -1U)
>>> -        irq = irq_find_mapping(primary_intc->root_domain, hwirq);
>>> -
>>> -    pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>>> -
>>> -    return irq;
>>> -}
>>> -
>>>  static int xintc_map(struct irq_domain *d, unsigned int irq,
>>> irq_hw_number_t hw)
>>>  {
>>>      struct xintc_irq_chip *irqc = d->host_data;
>>> @@ -177,6 +163,25 @@ static void xil_intc_irq_handler(struct irq_desc
>>> *desc)
>>>      chained_irq_exit(chip, desc);
>>>  }
>>>
>>> +static void xil_intc_handle_irq(struct pt_regs *regs)
>>> +{
>>> +    u32 hwirq;
>>> +    struct xintc_irq_chip *irqc = primary_intc;
>>> +
>>> +    do {
>>> +        hwirq = xintc_read(irqc, IVR);
>>> +        if (likely(hwirq != -1U)) {
>>> +            int ret;
>>> +
>>> +            ret = handle_domain_irq(irqc->root_domain, hwirq, regs);
>>> +            WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
>>> +            continue;
>>> +        }
>>> +
>>> +        break;
>>> +    } while (1);
>>> +}
>>> +
>>>  static int __init xilinx_intc_of_init(struct device_node *intc,
>>>                           struct device_node *parent)
>>>  {
>>> @@ -246,6 +251,7 @@ static int __init xilinx_intc_of_init(struct
>>> device_node *intc,
>>>      } else {
>>>          primary_intc = irqc;
>>>          irq_set_default_host(primary_intc->root_domain);
>>> +        set_handle_irq(xil_intc_handle_irq);
>>>      }
>>>
>>>      return 0;
>>>
>>
>> Stephen reported compilation issue when this patch is applied because of
>> removal of xintc_get_irq() which is also used by ancient ppc405/ppc440
>> xilinx platforms. I have reported this twice to Marc already last week.
> 
> Did you? I can't possibly find these emails.

Stephen was using your arm.com email.

https://lore.kernel.org/linux-next/48d3232d-0f1d-42ea-3109-f44bbabfa2e8@xilinx.com/

> 
>> On Friday I have also send v1 of removal of that platforms (need to
>> send v2)
>> https://lore.kernel.org/alsa-devel/cover.1585311091.git.michal.simek@xilinx.com/
>>
> 
> You want to remove exising platforms two days before the start of the
> merge window?
> I don't think this is acceptable with such short notice.

I also don't think that will go through.

> 
>> That's why please really consider next steps and let us know.
> 
> I think the only option is to revert (at least partially) the Xilinx
> series.

Unfortunately.

Thanks,
Michal

