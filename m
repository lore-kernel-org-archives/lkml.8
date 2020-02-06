Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B055FC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E43206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="W1ogqLyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgBFJSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:18:21 -0500
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:6168
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbgBFJSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:18:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/l8JwFlLFNmte/Of2IxjSkw2rQt+Tg0CVHoHLvpZMKi3NPzK8cACg+GsSprdELuEStnMr3uzgMPSmBKYQCLPRDL/FAbiGCt15Nhi+n8HHFy72UAo3woI6Fr7R1NEZY5Y6sBO42Y30zbcg9yn5G+jQHXJ+HM57R8yL45ztPRtleFZ7xJfSeFJnnOw7rDDH998Su1wBKHjKvvflRk6b1JkFpeperl3Rz5kMzuB5sFldrjBz3Dtyi0UB5FMIDkGawEV3nSAEHd/keZEbeAX1/oWoprC8b+JzRLBBj7ygRbJNri4U8W3viUWd1Ekjynhzny3f1NLQ/UZ/t+QYMMZ42Wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPokd5dsqAZdbIC4rBdpU+CCr8n6Fj+eTJCHppteGxE=;
 b=YYsHG1c6WBFz2+pcmhgTS3CYQEw1uroZOS/XVz0X+070dCJJKLbfZQZ4TEBQChT4ImSVzRnbzn46LwKwtUqrTgAlRTjuQdoG0456wU8Fvmgd2yaEYPUlDgv2XtSxkfVR8B+SyWcodnhq1BmqJA9vg8BrwQDJ4gaeOK9LJuwkYuZfgSleKyDCmWDoCaj7gdR+mU//9tluRPYqrLj6/VX0uxeU7RjKH863xFYAAX2V87aXGAyageAsqAmryWonV9Cwwx/3NJBb9fWBKcByy4dmWFOyjBOHNWCNii1BxN5W0UQroFs3/yf9QBgwjfIQyWXkboLmGWH/zcflIBjcgh9Iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPokd5dsqAZdbIC4rBdpU+CCr8n6Fj+eTJCHppteGxE=;
 b=W1ogqLyt77oiD1qGV25My2Dv7gCuxGDTMJ39hlH/YB5figRfA1RAEYOYEfQBAnsAkw5vy4DALUhjWvtgTm9FpopS9MmtpLWDXlTt2DH72XIZybO3TimUnujqD35anqNN1EkFA7YbJ5ToyZvD0Jj5lOcPUORFnTF7NqLyhW+2B2U=
Received: from SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) by BN6PR02MB2835.namprd02.prod.outlook.com
 (2603:10b6:404:fc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Thu, 6 Feb
 2020 09:18:05 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by SN4PR0201CA0056.outlook.office365.com
 (2603:10b6:803:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend
 Transport; Thu, 6 Feb 2020 09:18:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2707.21
 via Frontend Transport; Thu, 6 Feb 2020 09:18:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1izdIR-0007QB-FY; Thu, 06 Feb 2020 01:18:03 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1izdIM-0007fg-Bm; Thu, 06 Feb 2020 01:17:58 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0169HrBO006596;
        Thu, 6 Feb 2020 01:17:54 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1izdIH-0007ex-N5; Thu, 06 Feb 2020 01:17:53 -0800
Subject: Re: [PATCH v2] irqchip: xilinx: Add support for multiple instances
To:     Marc Zyngier <maz@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        siva.durga.paladugu@xilinx.com, anirudha.sarangi@xilinx.com
References: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
 <b8e7b9120bc6cd306bda3347cde117ff@kernel.org>
 <3d6077c1-2b13-acc6-e8f4-3d1ab23dc159@xilinx.com>
 <8b5c5b5d601856ddc3f4388e267c4cd0@kernel.org>
 <575c6350-139b-65b9-f9e2-2633656baa85@xilinx.com>
 <a3008824af22411034a6172cf09b450f@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <37ff3e76-a188-753e-182c-5c30069b8607@xilinx.com>
Date:   Thu, 6 Feb 2020 10:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a3008824af22411034a6172cf09b450f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(8936002)(31686004)(53546011)(70206006)(2616005)(4326008)(478600001)(70586007)(44832011)(5660300002)(426003)(107886003)(36756003)(31696002)(2906002)(9786002)(8676002)(336012)(316002)(110136005)(26005)(186003)(81156014)(356004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2835;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 804e7aa1-f80b-4417-ff5d-08d7aae578c4
X-MS-TrafficTypeDiagnostic: BN6PR02MB2835:
X-Microsoft-Antispam-PRVS: <BN6PR02MB283502D4AF7444A6461852CFC61D0@BN6PR02MB2835.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKe/Glzlhyt3mapPA5E3GX4zAYfuMXHQ+Lsrddaw8r5Z+1M90139sKfbU4d+HsthHiDWHD9QscmTnvo1ERltVHd7vaJaqumkjVrON/EMryIDerve5hRL2U7t7GeCj3kLD8gQQbSa+cB2XoMW3dK21NfXUKuLtSFlmntxyYFcQMrBOOqyYa3qpNKWknALKt4tLyrc8egEkkGcrAPyGf8M1vSueQjmlb1FMi0GEEfoBzLPrtvQ+JhERWaaOIaJOC22haV0JxRARlVEMej/wby2mrrh7K58DluneNAtSIBOgyk9TigrLwecNu0Pn1BiMlLrmLmvIji0M9+H7pAB505NycppoK1qwdD6jFhJkIEa6geYNn4k5qwbrXrDRw2ZXFx4+3KSg4jNCHJtPO/+SyT70NUB6nKqEP5YNcX7tfl0fIMNSpX0HN4UIG3+OtyoLcG8
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 09:18:04.4842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 804e7aa1-f80b-4417-ff5d-08d7aae578c4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 02. 20 10:15, Marc Zyngier wrote:
> On 2020-02-06 09:11, Michal Simek wrote:
>> On 06. 02. 20 10:09, Marc Zyngier wrote:
>>> On 2020-02-06 07:06, Michal Simek wrote:
>>>> On 05. 02. 20 17:53, Marc Zyngier wrote:
>>>>> On 2020-02-05 14:05, Mubin Usman Sayyed wrote:
>>>
>>> [...]
>>>
>>>>>>  unsigned int xintc_get_irq(void)
>>>>>>  {
>>>>>> -       unsigned int hwirq, irq = -1;
>>>>>> +       int hwirq, irq = -1;
>>>>>>
>>>>>> -       hwirq = xintc_read(IVR);
>>>>>> +       hwirq = xintc_read(primary_intc->base + IVR);
>>>>>>         if (hwirq != -1U)
>>>>>> -               irq = irq_find_mapping(xintc_irqc->root_domain,
>>>>>> hwirq);
>>>>>> +               irq = irq_find_mapping(primary_intc->root_domain,
>>>>>> hwirq);
>>>>>>
>>>>>>         pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>>>>>
>>>>> I have the ugly feeling I'm reading the same code twice... Surely you
>>>>> can
>>>>> make these two functions common code.
>>>>
>>>> I have some questions regarding this.
>>>> I have updated one patchset which is adding support for Microblaze SMP.
>>>> And when I was looking at current wiring of this driver I have decided
>>>> to change it.
>>>>
>>>> I have enabled  GENERIC_IRQ_MULTI_HANDLER and HANDLE_DOMAIN_IRQ.
>>>> This driver calls set_handle_irq(xil_intc_handle_irq)
>>>> and MB do_IRQ() call handle_arch_irq()
>>>> and IRQ routine here is using handle_domain_irq().
>>>>
>>>> I would expect that this chained IRQ handler can also use
>>>> handle_domain_irq().
>>>>
>>>> Is that correct understanding?
>>>
>>> handle_domain_irq() implies that you have a set of pt_regs, representing
>>> the context you interrupted. You can't fake that up, so I can't see how
>>> you use it in a chained context.
>>
>> ok. What's your recommendation for chained controller? Just go with
>> irq_find_mapping?
> 
> For now, yes. I have (distant) plans to improve this.

Thanks.
Michal

