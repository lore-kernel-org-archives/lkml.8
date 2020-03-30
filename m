Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AC4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5FC206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="A18wXDkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgC3J2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:28:23 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:35905
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbgC3J2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5GncxzSE+4irt3WCbBhRNgEj//ZzJSz3A+oRGBhpZFSABrD6+AzEf1gDNrmbayRhJBa+khkqlWIXzW3C/zdYTj0OG5l13Jr/TW6qQEIpc0Oj/jC+PJrro8EGO22x67FEw8vs7g6j2tnUi+NBoq2Rdq08rmQLedJlofUr8RunFE5mEh2x9IQ0rfYT77/rNuWw9Wnobdwbf0GTva2zSbHT+jwNL/TNYv9M4/VVEguDSbxQu8CDOAFOELhm3uZLXT2pcLASpU0BvHT7dwTivdNE/lyP8Px/b8ZUjHnWAagu68YRQmbXAmovC8jAd0v6ZNiGLFhuQkR7STI72YaAlmrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haxZLNxBjh9fwyMHEYGJE2MY8jAS8iKp0Gy5K7acvRQ=;
 b=EE3zCvjochTXcISmHi9nJ9uIUc/5GoPaEecpWl2zUw++ghP96F1Ygjsa6LNUAat5RBuAgOt1QVHH9YqYOpS7eKyUyKGePt40qnlVdV11ABv7FA92Mpw8uHdTa/mEulDQT9DhKCoOuKll/hMQT2FSghp4Zu0MFXMmOyn9t/j/MgIePHWiHW4+bjSOTlAABDZeXIbhKXnfZxmOHsTpeqHuPz7p80qtwKocjK5AUUPgqiiV4UtWNQF4PSMGn2xLnVIJAaaZS5mk8AhOk6A+bMde9c9qdT2GXkBk+vdiEZk+hsButLSDSwO2JOu/YyJuUS6HwWQ6le+x+AP5WoSOIvKCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haxZLNxBjh9fwyMHEYGJE2MY8jAS8iKp0Gy5K7acvRQ=;
 b=A18wXDkcdHishzWrMR6Ln+bRYhjMSZE2JVbYu56FMtSH9YheqLhn2HbGeUx9aGpaiSz65sZtqIg1ABNeIb+NXrHryXvD9pUvd34RxmGxBa8HU1ju5YtbvU2XYplgZP0A4bJ3eyuFWJRnsKkQ2XnpMQm6G/ThQFXfSnklm1wVTug=
Received: from CY4PR22CA0093.namprd22.prod.outlook.com (2603:10b6:903:ad::31)
 by SN6PR02MB4671.namprd02.prod.outlook.com (2603:10b6:805:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 09:28:07 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::b8) by CY4PR22CA0093.outlook.office365.com
 (2603:10b6:903:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Mon, 30 Mar 2020 09:28:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2856.17
 via Frontend Transport; Mon, 30 Mar 2020 09:28:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIqiF-00074F-0t; Mon, 30 Mar 2020 02:28:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIqi9-0005Sl-Tw; Mon, 30 Mar 2020 02:28:01 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02U9Rwxj031623;
        Mon, 30 Mar 2020 02:27:58 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jIqi5-0005Pf-VE; Mon, 30 Mar 2020 02:27:58 -0700
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
 <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
 <ca0f62da-1e89-4fe8-5cb4-b7a86f97c5a3@xilinx.com>
 <21f1157d885071dcfdb1de0847c19e24@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
Date:   Mon, 30 Mar 2020 11:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <21f1157d885071dcfdb1de0847c19e24@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966005)(966005)(2906002)(110136005)(8676002)(6666004)(356004)(316002)(82740400003)(47076004)(478600001)(426003)(44832011)(36756003)(70586007)(70206006)(81166006)(81156014)(2616005)(336012)(4326008)(5660300002)(54906003)(31686004)(9786002)(31696002)(53546011)(186003)(26005)(8936002)(41533002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 296330e6-ea50-4e3a-e9a7-08d7d48ca812
X-MS-TrafficTypeDiagnostic: SN6PR02MB4671:
X-Microsoft-Antispam-PRVS: <SN6PR02MB467122A67A0AC84F14611BB2C6CB0@SN6PR02MB4671.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeSm/zQZGIpaLlN/MawW6tTkExGBVngeYRSZxNQBJOC4QIB2UTPvefFZP0rBq2u8JTtl3Kot2a1VFl4T9q7k7prK77UiiOPtQkvo9DAsnv/79QwXntew4F7DJoTeACtHj6TRWo1ioxao9PycQeyWHxGo6PZk0BAZaYJn+ClPPsoKDdIPHvGTGx4AKuMgatxPz1SNPMbIULjPWRwzLszjFGoXfWhbs8lAEYy03L2XJAwRujIkXsnOPoQ4y2r//cfVLfhNvW1NrcqHH2jP9C0X3SGBlrmfnNSVg2t9lXhlyw1pHxEteh66WjAlOxdx5Yj/PSrSh/WrL4kHISOx4UYLIT2zqz4io90YxIvz/JLqQxPiJFcKCAQ3Tkx9VyP7t85V+ZEjZOG1iLmDZiN1SlgvKQerK8MRyHz0p60E9U3Fj9P1+vKYCMaumVsbTWKmOn0wwSUXu4jwvW7YsA7qWUVlYojX1fS4XaS+q7YQtEnzuPshmthKsaXuDfYrpnpqJwYgMvtkYIk1B5HH1N3xxaCL0pR7G4Ws/TcHW3jjmv7EvddEwekDMFBH7M44BX3uqQOqGSzzAIf9edlRDN8xNMCUaVLteJauBuCWoMZSqjHgh2Q=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 09:28:07.4796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 296330e6-ea50-4e3a-e9a7-08d7d48ca812
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 03. 20 11:19, Marc Zyngier wrote:
> On 2020-03-30 10:12, Michal Simek wrote:
>> On 30. 03. 20 11:03, Michal Simek wrote:
>>> On 30. 03. 20 10:45, Marc Zyngier wrote:
>>>> On 2020-03-30 09:32, Michal Simek wrote:
>>>>> Hi Thomas and Marc,
>>>>>
>>>>> On 29. 03. 20 22:26, tip-bot2 for Michal Simek wrote:
>>>>>> The following commit has been merged into the irq/core branch of tip:
>>>>>>
>>>>>> Commit-ID:     a0789993bf8266e62fea6b4613945ba081c71e7d
>>>>>> Gitweb:       
>>>>>> https://git.kernel.org/tip/a0789993bf8266e62fea6b4613945ba081c71e7d
>>>>>> Author:        Michal Simek <michal.simek@xilinx.com>
>>>>>> AuthorDate:    Tue, 17 Mar 2020 18:25:59 +05:30
>>>>>> Committer:     Marc Zyngier <maz@kernel.org>
>>>>>> CommitterDate: Sun, 22 Mar 2020 11:52:53
>>>>>>
>>>>>> irqchip/xilinx: Enable generic irq multi handler
>>>>>>
>>>>>> Register default arch handler via driver instead of directly
>>>>>> pointing to
>>>>>> xilinx intc controller. This patch makes architecture code more
>>>>>> generic.
>>>>>>
>>>>>> Driver calls generic domain specific irq handler which does the
>>>>>> most of
>>>>>> things self. Also get rid of concurrent_irq counting which hasn't
>>>>>> been
>>>>>> exported anywhere.
>>>>>> Based on this loop was also optimized by using do/while loop
>>>>>> instead of
>>>>>> goto loop.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>>>>> Link:
>>>>>> https://lore.kernel.org/r/20200317125600.15913-4-mubin.usman.sayyed@xilinx.com
>>>>>>
>>>>>>
>>>>>> ---
>>>>>>  arch/microblaze/Kconfig           |  2 ++-
>>>>>>  arch/microblaze/include/asm/irq.h |  3 +---
>>>>>>  arch/microblaze/kernel/irq.c      | 21 +-------------------
>>>>>>  drivers/irqchip/irq-xilinx-intc.c | 34
>>>>>> +++++++++++++++++-------------
>>>>>>  4 files changed, 23 insertions(+), 37 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>>>>> index 6a331bd..242f58e 100644
>>>>>> --- a/arch/microblaze/Kconfig
>>>>>> +++ b/arch/microblaze/Kconfig
>>>>>> @@ -47,6 +47,8 @@ config MICROBLAZE
>>>>>>      select CPU_NO_EFFICIENT_FFS
>>>>>>      select MMU_GATHER_NO_RANGE if MMU
>>>>>>      select SPARSE_IRQ
>>>>>> +    select GENERIC_IRQ_MULTI_HANDLER
>>>>>> +    select HANDLE_DOMAIN_IRQ
>>>>>>
>>>>>>  # Endianness selection
>>>>>>  choice
>>>>>> diff --git a/arch/microblaze/include/asm/irq.h
>>>>>> b/arch/microblaze/include/asm/irq.h
>>>>>> index eac2fb4..5166f08 100644
>>>>>> --- a/arch/microblaze/include/asm/irq.h
>>>>>> +++ b/arch/microblaze/include/asm/irq.h
>>>>>> @@ -14,7 +14,4 @@
>>>>>>  struct pt_regs;
>>>>>>  extern void do_IRQ(struct pt_regs *regs);
>>>>>>
>>>>>> -/* should be defined in each interrupt controller driver */
>>>>>> -extern unsigned int xintc_get_irq(void);
>>>>>> -
>>>>>>  #endif /* _ASM_MICROBLAZE_IRQ_H */
>>>>>> diff --git a/arch/microblaze/kernel/irq.c
>>>>>> b/arch/microblaze/kernel/irq.c
>>>>>> index 903dad8..0b37dde 100644
>>>>>> --- a/arch/microblaze/kernel/irq.c
>>>>>> +++ b/arch/microblaze/kernel/irq.c
>>>>>> @@ -20,29 +20,10 @@
>>>>>>  #include <linux/irqchip.h>
>>>>>>  #include <linux/of_irq.h>
>>>>>>
>>>>>> -static u32 concurrent_irq;
>>>>>> -
>>>>>>  void __irq_entry do_IRQ(struct pt_regs *regs)
>>>>>>  {
>>>>>> -    unsigned int irq;
>>>>>> -    struct pt_regs *old_regs = set_irq_regs(regs);
>>>>>>      trace_hardirqs_off();
>>>>>> -
>>>>>> -    irq_enter();
>>>>>> -    irq = xintc_get_irq();
>>>>>> -next_irq:
>>>>>> -    BUG_ON(!irq);
>>>>>> -    generic_handle_irq(irq);
>>>>>> -
>>>>>> -    irq = xintc_get_irq();
>>>>>> -    if (irq != -1U) {
>>>>>> -        pr_debug("next irq: %d\n", irq);
>>>>>> -        ++concurrent_irq;
>>>>>> -        goto next_irq;
>>>>>> -    }
>>>>>> -
>>>>>> -    irq_exit();
>>>>>> -    set_irq_regs(old_regs);
>>>>>> +    handle_arch_irq(regs);
>>>>>>      trace_hardirqs_on();
>>>>>>  }
>>>>>>
>>>>>> diff --git a/drivers/irqchip/irq-xilinx-intc.c
>>>>>> b/drivers/irqchip/irq-xilinx-intc.c
>>>>>> index 1d3d273..ea74181 100644
>>>>>> --- a/drivers/irqchip/irq-xilinx-intc.c
>>>>>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>>>>>> @@ -124,20 +124,6 @@ static unsigned int xintc_get_irq_local(struct
>>>>>> xintc_irq_chip *irqc)
>>>>>>      return irq;
>>>>>>  }
>>>>>>
>>>>>> -unsigned int xintc_get_irq(void)
>>>>>> -{
>>>>>> -    unsigned int irq = -1;
>>>>>> -    u32 hwirq;
>>>>>> -
>>>>>> -    hwirq = xintc_read(primary_intc, IVR);
>>>>>> -    if (hwirq != -1U)
>>>>>> -        irq = irq_find_mapping(primary_intc->root_domain, hwirq);
>>>>>> -
>>>>>> -    pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>>>>>> -
>>>>>> -    return irq;
>>>>>> -}
>>>>>> -
>>
>> One more thing. We could also get this function back and it will be fine
>> too. But up2you.
> 
> If you leave it up to me, I'll revert the whole series right now.
> 
> What I'd expect from you is to tell me exactly what is the minimal
> change that keeps it working on both ARM, microblaze and PPC.
> If it is a revert, tell me which patches to revert. if it is a patch
> on top, send me the fix so that I can queue it now.

It won't be that simple. Please revert patches

9c2d4f525c00 ("irqchip/xilinx: Do not call irq_set_default_host()")
a0789993bf82 ("irqchip/xilinx: Enable generic irq multi handler")

And we should be fine.

Thanks,
Michal


