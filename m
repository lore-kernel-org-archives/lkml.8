Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C71EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D910B217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AinhnYuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgBFJLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:11:46 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:20853
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727848AbgBFJLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5J7Ok0whV+08aBc4WC0l/cpI0EG1ib2ZdGmEYf3PKIL17qSoy6hhJtk6tGRiykYU8oXnQdRZllzWvlMWrtfTkM3XPH+iF5j3sJueCAyFIP7oTest/5FIfTK/RAo5rblUaAQWDJI5wRBqB1qcMp4CjnjgH+sx7yEjI90a62ykO7qAZwYI7qhJM2Nz2JpYm8B1Ozy9bQMUKARj4QpYbpSQn3zUrjVuzGBPEGEptP7wiF5WezwCrU8lfGufW2A2LJ7VpaE7P9hqgWaLfY9OF0punNqxUYY3X2OPKgQNgSBS9x5GS34z7Bg2qjqLiumjBFLoT2hZYnAZbZhqKwK0JXrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuNGITOrAnDqzF3iFEprbrV2RXUArio7lBKdelGtOsM=;
 b=dnr/5J/wjpCIzAzCVX1GDBo7FBNIhgt+KlF6QX/1vYSuldsc4kNFVshW0knXwge+WoR+Z1Srlhd7tmFrvaf9WKVlaIh/VpOvUBATYbf/xeeRdSvZXryHb23ivp1tr4lHE6KYlvZZj+gWCX6EinLj7/Q0NqtcnGUmAni0diFyhaLlK0/jLZLyNDHpMXZQlqlU1FCZ+Qhr+YGiSqYV6ScOQw/BXjuJgpV8kRaKYQVtlP5qLJDLo+H/a+8cvWCqTxACp5AHSl6GhqRRALWPIeJZOmtoRf+HJZ5qyF2XVu0q6OyDbD+KMrSOj5dIY6Teg+Xx3BACSCnG69vc3QF3EKi9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuNGITOrAnDqzF3iFEprbrV2RXUArio7lBKdelGtOsM=;
 b=AinhnYuTnl9evYaqLJ64nxZ5RbKuKDRMPi+O4JxGrtxr4tsilRqNFD7WSghvYwlQbRJGlms/aaVEM7VwptxxpNcfjRqr86t3MtfTvXu9K0lQ25GYldTU3K6cMzf6cGQv5ZFyAMeohJ97AxEXHKhc7kwt6tfhnB+CBKxzDHrTijc=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by BY5PR02MB6470.namprd02.prod.outlook.com (2603:10b6:a03:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Thu, 6 Feb
 2020 09:11:43 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 09:11:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2707.21
 via Frontend Transport; Thu, 6 Feb 2020 09:11:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1izdCI-0007Dm-1v; Thu, 06 Feb 2020 01:11:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1izdCC-0006F2-UQ; Thu, 06 Feb 2020 01:11:36 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1izdC8-0006DN-9G; Thu, 06 Feb 2020 01:11:32 -0800
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
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <575c6350-139b-65b9-f9e2-2633656baa85@xilinx.com>
Date:   Thu, 6 Feb 2020 10:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8b5c5b5d601856ddc3f4388e267c4cd0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(36756003)(2906002)(356004)(31686004)(478600001)(6666004)(81156014)(8676002)(8936002)(107886003)(5660300002)(81166006)(31696002)(336012)(186003)(426003)(26005)(2616005)(44832011)(4326008)(70206006)(9786002)(53546011)(70586007)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6470;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05478bff-8aae-475f-5c0f-08d7aae49535
X-MS-TrafficTypeDiagnostic: BY5PR02MB6470:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6470CE7B9321C50D1053B224C61D0@BY5PR02MB6470.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is0n11EU6BJpvr2wd6luzAEvnT7Nm6n2TAlrG1HAGVwpi7Tl6HakGOpTxUfPmcip9Jp63XkEtMXK8iQkS1mEKX396p4AHykd/y58A7NpeLWe3mCSxDO0LyS+Iud4DSQaNsuhsIilUlYV3M6oN4H4dPYKJnSb4akBsTq7qn88IkGiQgczLd/bBdNIhOi0tzuuhKixKzVRpwPqu9yDpbT907VAkTQGFTHrkFnOehuNJsoo3dQvpKOn5TSFWtoJiUIn1YWpZ7lEBndw25rULSE8nPmSrPrCpXtqti5lN16QvJx+W032hSWXSruw1WJj9/C7rcJEpI5W+aJu2xlkUV19maYG+EeDDjXMoNbtxUjLyzQrsBB5XTlyVSdK3D/uAPLCAmWPLWoZ0UiWaJMVQcQrBydzzfZziwmAAd5LfmhSD4jIyYYvm9KCOKbz+MJwUc6J
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 09:11:42.7310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05478bff-8aae-475f-5c0f-08d7aae49535
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 02. 20 10:09, Marc Zyngier wrote:
> On 2020-02-06 07:06, Michal Simek wrote:
>> On 05. 02. 20 17:53, Marc Zyngier wrote:
>>> On 2020-02-05 14:05, Mubin Usman Sayyed wrote:
> 
> [...]
> 
>>>>  unsigned int xintc_get_irq(void)
>>>>  {
>>>> -       unsigned int hwirq, irq = -1;
>>>> +       int hwirq, irq = -1;
>>>>
>>>> -       hwirq = xintc_read(IVR);
>>>> +       hwirq = xintc_read(primary_intc->base + IVR);
>>>>         if (hwirq != -1U)
>>>> -               irq = irq_find_mapping(xintc_irqc->root_domain, hwirq);
>>>> +               irq = irq_find_mapping(primary_intc->root_domain,
>>>> hwirq);
>>>>
>>>>         pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>>>
>>> I have the ugly feeling I'm reading the same code twice... Surely you
>>> can
>>> make these two functions common code.
>>
>> I have some questions regarding this.
>> I have updated one patchset which is adding support for Microblaze SMP.
>> And when I was looking at current wiring of this driver I have decided
>> to change it.
>>
>> I have enabled  GENERIC_IRQ_MULTI_HANDLER and HANDLE_DOMAIN_IRQ.
>> This driver calls set_handle_irq(xil_intc_handle_irq)
>> and MB do_IRQ() call handle_arch_irq()
>> and IRQ routine here is using handle_domain_irq().
>>
>> I would expect that this chained IRQ handler can also use
>> handle_domain_irq().
>>
>> Is that correct understanding?
> 
> handle_domain_irq() implies that you have a set of pt_regs, representing
> the context you interrupted. You can't fake that up, so I can't see how
> you use it in a chained context.

ok. What's your recommendation for chained controller? Just go with
irq_find_mapping?

> 
> [...]
> 
>>>> +       intc_dev->name = intc->full_name;
>>>
>>> No. The world doesn't need to see the OF path of your interrupt
>>> controller in /proc/cpuinfo.
>>> The name that was there before was perfectly descriptive, please stick
>>> to it.
>>
>> It should be showing name like interrupt-controller@41800000.
>> Do you think that we really should stick with just fixed name?
>> There could be multiple instances in the system and you will have no
>> idea how they are connected.
> 
> What is that used for? Debugging. We have a whole infrastructure for that
> (GENERIC_IRQ_DEBUGFS), which is the right tool for the job. If it needs
> improvement, please let me know what is missing.

Let me take a look.

> Also, anything in /proc is ABI, so we don't change it randomly.

ok.

Thanks,
Michal

