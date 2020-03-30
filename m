Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC300C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABE9206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DE4/WSrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgC3JMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:12:39 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:6158
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727648AbgC3JMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BezoWzsBg73UqFr667Sv3gmob8G0uKzUGqtSaXD05pd7yar4Km5mj06boWmR6bqz2f0/KHsiAO1c/4ZMFNumLRrjLhWbbqY2QpKsKzcs/IYW00Nj+L/zq6QBT7vmlLx4ungzJBi7TPP/Y5HGDED4xHMOb/YABJn/wHw6B/gSoCy1WpeHnftWC2lssWfB739D/EuDHmbHs5U+coDa6MOZqn37s/S1DwVoKBD4/SFBafGQb399HbtMaP9CRUgwyhCIJ2+quuy+cLOAZXYgDmbYhOnU9EEqsodaRy6MoeX7EPGUjLl8mzldcEUlN7TETR3WC84U5xrC5aGX7jkYwiO1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti7xYV2AvGX7AdcqylPg0yTfYfxCdq7uAdTye6Q6Ezs=;
 b=b5PqGzcv+uE93mbcxuf2JgULuL8crPvmLUTccrO3543Zm41QWCuvYpDXFEQbSomMmD4IEG4JpA7QSWrrd3y/BZLiM+5WIIAweuOPQ/lnzYYW0D2cz6xRyPoLJxROzNT8Xv5niDcXqh7zHWIjvKk3Gay411Cme8bCMzUoKw4KtTADGbQ6GERkWd1kMS0XinbY9hpzxd7pAZkAOgefzSK6fRR+mj5dOX95hsGri9jTgoYVkv5+Xxchuoiw5yUUDTUrxF6oTjmbwsqKV3J3owMK0Lz6rqrDtw+mDCer+vz4MobioTWrIDkThaCb0wqWpWOU1YhCea2/hmD2rnaOq3UYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti7xYV2AvGX7AdcqylPg0yTfYfxCdq7uAdTye6Q6Ezs=;
 b=DE4/WSrS9MCpqA9L79VjMTw7POerJlBMn6f9qxp6y8EWUL/hgfcpwmb7NfNg09DLnylSnj8f+ecS9kV9yNDLyPOeOZ0AuLcnDmGbuxVhr+CGxrFfElOFWU3OqudnEkhGvTrMdtqNtVN+i3/KZCFXS4Lmuy24GAyyFBTDQgkBJqs=
Received: from MN2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:208:23e::31)
 by SN6PR02MB5039.namprd02.prod.outlook.com (2603:10b6:805:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 09:12:34 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23e:cafe::c6) by MN2PR14CA0026.outlook.office365.com
 (2603:10b6:208:23e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Mon, 30 Mar 2020 09:12:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2856.17
 via Frontend Transport; Mon, 30 Mar 2020 09:12:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIqTB-0006wP-Fi; Mon, 30 Mar 2020 02:12:33 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIqT6-0007Jy-Cg; Mon, 30 Mar 2020 02:12:28 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02U9CPZ1014413;
        Mon, 30 Mar 2020 02:12:25 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jIqT2-0007I2-QA; Mon, 30 Mar 2020 02:12:25 -0700
Subject: Re: [tip: irq/core] irqchip/xilinx: Enable generic irq multi handler
To:     Michal Simek <michal.simek@xilinx.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200317125600.15913-4-mubin.usman.sayyed@xilinx.com>
 <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
 <083ad708-ea4d-ed53-598e-84d911ca4177@xilinx.com>
 <085188fea81d5ddc88b488124596a4a3@kernel.org>
 <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <ca0f62da-1e89-4fe8-5cb4-b7a86f97c5a3@xilinx.com>
Date:   Mon, 30 Mar 2020 11:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(2616005)(82740400003)(44832011)(336012)(426003)(31686004)(36756003)(5660300002)(186003)(26005)(8676002)(31696002)(81156014)(81166006)(478600001)(110136005)(54906003)(966005)(53546011)(2906002)(9786002)(47076004)(8936002)(316002)(70586007)(4326008)(70206006)(6666004)(356004)(41533002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b1a9e7c-4739-4b30-46de-08d7d48a7bbe
X-MS-TrafficTypeDiagnostic: SN6PR02MB5039:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50395B6E857C4A58C015F75EC6CB0@SN6PR02MB5039.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1edQRfEFpQHJUV2SZChCX8ASKK/D9yKpskZXZTLyKOHi8EKB9TthvfWUXPzaYcUrn5TrfYc0p1VF/69j2We4sU7tp1lqlqd+P4pYObq9E1wjwJA/NV+IVjMydpG+CB7jZ1AFZ4IeTmoQpDAg1J5i+aKLWSjnfeJaGM7YSwC2hf6TPtBmx2ZrVTkMlrNlbW2ewCzOI//LAsupmnenchq4C5vhU5BatNwfsVVei1FC2tY67ZiotBEwsI3zdo973Fgv6ro8ChWIpRaGNsskSrK+CkppBQcDQhRnBEkzjn8xKMH+Z8onz+xJ0DJNGX9x82vq3V+I4fYCkwF6qJj4+d69UPKILwbR/mHgB26snRmeQMIf7OqTftFVgSzIjY5tJBN1To6VZM03g1PfK7/T2QcufUT74khbIObyLt/gdLKVQQnTTbC+X6pcj2Bfj5WWbhLe+rCrvxNCh08b4NVxOvujPNo+3y1SDKcwNm0AyMqpvItix0Fid+TYDIVYLniZhZMjipi3GI0Ye6Zcdxmh2R68yxvgQypk0ipnZ4iAwObrrxXxBvjOQ7vZeCh8pYhYl5icSurgR8e1IkhBiIY43oeizT81feZLNOe9in8OcJopCk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 09:12:34.0468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1a9e7c-4739-4b30-46de-08d7d48a7bbe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 03. 20 11:03, Michal Simek wrote:
> On 30. 03. 20 10:45, Marc Zyngier wrote:
>> On 2020-03-30 09:32, Michal Simek wrote:
>>> Hi Thomas and Marc,
>>>
>>> On 29. 03. 20 22:26, tip-bot2 for Michal Simek wrote:
>>>> The following commit has been merged into the irq/core branch of tip:
>>>>
>>>> Commit-ID:     a0789993bf8266e62fea6b4613945ba081c71e7d
>>>> Gitweb:       
>>>> https://git.kernel.org/tip/a0789993bf8266e62fea6b4613945ba081c71e7d
>>>> Author:        Michal Simek <michal.simek@xilinx.com>
>>>> AuthorDate:    Tue, 17 Mar 2020 18:25:59 +05:30
>>>> Committer:     Marc Zyngier <maz@kernel.org>
>>>> CommitterDate: Sun, 22 Mar 2020 11:52:53
>>>>
>>>> irqchip/xilinx: Enable generic irq multi handler
>>>>
>>>> Register default arch handler via driver instead of directly pointing to
>>>> xilinx intc controller. This patch makes architecture code more generic.
>>>>
>>>> Driver calls generic domain specific irq handler which does the most of
>>>> things self. Also get rid of concurrent_irq counting which hasn't been
>>>> exported anywhere.
>>>> Based on this loop was also optimized by using do/while loop instead of
>>>> goto loop.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>>> Link:
>>>> https://lore.kernel.org/r/20200317125600.15913-4-mubin.usman.sayyed@xilinx.com
>>>>
>>>> ---
>>>>  arch/microblaze/Kconfig           |  2 ++-
>>>>  arch/microblaze/include/asm/irq.h |  3 +---
>>>>  arch/microblaze/kernel/irq.c      | 21 +-------------------
>>>>  drivers/irqchip/irq-xilinx-intc.c | 34 +++++++++++++++++-------------
>>>>  4 files changed, 23 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>>> index 6a331bd..242f58e 100644
>>>> --- a/arch/microblaze/Kconfig
>>>> +++ b/arch/microblaze/Kconfig
>>>> @@ -47,6 +47,8 @@ config MICROBLAZE
>>>>      select CPU_NO_EFFICIENT_FFS
>>>>      select MMU_GATHER_NO_RANGE if MMU
>>>>      select SPARSE_IRQ
>>>> +    select GENERIC_IRQ_MULTI_HANDLER
>>>> +    select HANDLE_DOMAIN_IRQ
>>>>
>>>>  # Endianness selection
>>>>  choice
>>>> diff --git a/arch/microblaze/include/asm/irq.h
>>>> b/arch/microblaze/include/asm/irq.h
>>>> index eac2fb4..5166f08 100644
>>>> --- a/arch/microblaze/include/asm/irq.h
>>>> +++ b/arch/microblaze/include/asm/irq.h
>>>> @@ -14,7 +14,4 @@
>>>>  struct pt_regs;
>>>>  extern void do_IRQ(struct pt_regs *regs);
>>>>
>>>> -/* should be defined in each interrupt controller driver */
>>>> -extern unsigned int xintc_get_irq(void);
>>>> -
>>>>  #endif /* _ASM_MICROBLAZE_IRQ_H */
>>>> diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
>>>> index 903dad8..0b37dde 100644
>>>> --- a/arch/microblaze/kernel/irq.c
>>>> +++ b/arch/microblaze/kernel/irq.c
>>>> @@ -20,29 +20,10 @@
>>>>  #include <linux/irqchip.h>
>>>>  #include <linux/of_irq.h>
>>>>
>>>> -static u32 concurrent_irq;
>>>> -
>>>>  void __irq_entry do_IRQ(struct pt_regs *regs)
>>>>  {
>>>> -    unsigned int irq;
>>>> -    struct pt_regs *old_regs = set_irq_regs(regs);
>>>>      trace_hardirqs_off();
>>>> -
>>>> -    irq_enter();
>>>> -    irq = xintc_get_irq();
>>>> -next_irq:
>>>> -    BUG_ON(!irq);
>>>> -    generic_handle_irq(irq);
>>>> -
>>>> -    irq = xintc_get_irq();
>>>> -    if (irq != -1U) {
>>>> -        pr_debug("next irq: %d\n", irq);
>>>> -        ++concurrent_irq;
>>>> -        goto next_irq;
>>>> -    }
>>>> -
>>>> -    irq_exit();
>>>> -    set_irq_regs(old_regs);
>>>> +    handle_arch_irq(regs);
>>>>      trace_hardirqs_on();
>>>>  }
>>>>
>>>> diff --git a/drivers/irqchip/irq-xilinx-intc.c
>>>> b/drivers/irqchip/irq-xilinx-intc.c
>>>> index 1d3d273..ea74181 100644
>>>> --- a/drivers/irqchip/irq-xilinx-intc.c
>>>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>>>> @@ -124,20 +124,6 @@ static unsigned int xintc_get_irq_local(struct
>>>> xintc_irq_chip *irqc)
>>>>      return irq;
>>>>  }
>>>>
>>>> -unsigned int xintc_get_irq(void)
>>>> -{
>>>> -    unsigned int irq = -1;
>>>> -    u32 hwirq;
>>>> -
>>>> -    hwirq = xintc_read(primary_intc, IVR);
>>>> -    if (hwirq != -1U)
>>>> -        irq = irq_find_mapping(primary_intc->root_domain, hwirq);
>>>> -
>>>> -    pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>>>> -
>>>> -    return irq;
>>>> -}
>>>> -

One more thing. We could also get this function back and it will be fine
too. But up2you.

Thanks,
Michal



