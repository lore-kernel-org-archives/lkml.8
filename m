Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B8DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D2420757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XsxwUtV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDIKns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:43:48 -0400
Received: from mail-eopbgr700089.outbound.protection.outlook.com ([40.107.70.89]:57569
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIKnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:43:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKEm4ZW4IWWzzKfN9A5UTaX5Y7nNzKF06wqvhWrNvo8Im2uJnVaqm4sb7DM8XtuqkWhiFbKofnc6h+AO1T/jAw853Ce2BnUc7GMTRTIUa76+L7Buxobvq4B3NOZbOAJ0+9yeY44bdGJBoJKBKfdv8qKFm3buLoTYQdXpuUVUkR6zk/gLT8GOmeXP0l7zY+OjJW8IlWLr0pUgrBAIphrbAj7+bRbFXVIo/ZpiJ4+vg2WM6s6ZttPV2eBoLBvSToHCHVpVMpCBTMQrfNHi9u1I9EkHOfaGPPRf7pmYYr7Fm2tYSLkg83UwLs0/3SLJKz4iLdH0wEKr6XPwLCeAcmssag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqNbZjz4NCknaEmwq9FyIGh2yhE2//4y4m+iI9QZEI0=;
 b=W5P+YYV4fOhvW69UV4/oo2aFesUKTd8p+J1pw1NDYe8S93Oi/n1S/emBOUHG4yhG6WFegEqiRbbKQ9/Q8MsZ32ug2ufZ8sHL6tw11xWmwSHq9H3PyX4PYvR2nRloqAzJMSZfzkowy+PJTi1LHRUzoCTkttGExFFjJEzcVG30h18ZVnybBRY0tuxASruR2aROekS1KF9+udc/YwONI5eUMX6mB6TAyMqkNhgUvLCeSYnrnLau5n1pcAAhWIxfdQmBu7eIAKI2xKvTxtSJYtRvWs6JNY7gum5YfAp3MbCWDYqCupPS4j/Etx/u3NQ8vVV/ZXVYet5vzMyYdMGUZbhK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqNbZjz4NCknaEmwq9FyIGh2yhE2//4y4m+iI9QZEI0=;
 b=XsxwUtV+V+/dRs1O8O0HrYPRZ8Tp/vb8xyhK98ALugWJVLxdI6oDUFkiCD35nPPLR0h4pQRxNQqnAt4NxMe8rtb9Xp9w/gDZeHKg2Q7NtaA0PT+Fg+d8IdmgdNGt3Fcvvu7Ad53wEYvWRyJBFLNcMt+hsziUfKYcnCYJrbu6KYY=
Received: from MN2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:208:120::36)
 by MWHPR02MB2269.namprd02.prod.outlook.com (2603:10b6:300:5a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Thu, 9 Apr
 2020 10:43:42 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::ec) by MN2PR10CA0023.outlook.office365.com
 (2603:10b6:208:120::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend
 Transport; Thu, 9 Apr 2020 10:43:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 10:43:42
 +0000
Received: from [149.199.38.66] (port=40231 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jMUeS-0007c3-N3; Thu, 09 Apr 2020 03:43:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jMUes-0004gj-4d; Thu, 09 Apr 2020 03:43:42 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jMUen-0004fx-FI; Thu, 09 Apr 2020 03:43:37 -0700
Subject: Re: [PATCH] drivers: soc: xilinx: fix firmware driver Kconfig
 dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     arm-soc <arm@kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200408155224.2070880-1-arnd@arndb.de>
 <69e8b684-c314-d356-bf3e-e38676d07853@xilinx.com>
 <CAK8P3a3j7BLJZGsNFU2XLsnnBiP0x+qkPVxD0-L9Faq7+m2=BQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <3e1841ff-6116-4cfb-82bb-f1996d6ef514@xilinx.com>
Date:   Thu, 9 Apr 2020 12:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3j7BLJZGsNFU2XLsnnBiP0x+qkPVxD0-L9Faq7+m2=BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(2616005)(81166007)(82740400003)(54906003)(47076004)(53546011)(110136005)(44832011)(36756003)(31696002)(316002)(336012)(70206006)(70586007)(426003)(4326008)(26005)(186003)(356004)(31686004)(5660300002)(9786002)(8676002)(478600001)(8936002)(81156014)(966005)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e33f872d-ddb4-4b69-0414-08d7dc72df2f
X-MS-TrafficTypeDiagnostic: MWHPR02MB2269:
X-Microsoft-Antispam-PRVS: <MWHPR02MB226978C9F662754C0E0ACAAFC6C10@MWHPR02MB2269.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXLVpYqSszDkfPPgEvzvRrJudT/WhCysC3SavoZo2dPDy5fJPuduWat6S7a/z7EEtndQsiCyscgshtIZCbOyKc/k7h+YNtgflLtBZ4LGPOD+rY17cVI/GMbxMeON/k+NYX6n1El58lnn0B/7Hq/UZu748C5d7CsKcE/JUbJ/QXuBXPiBHsAQ0efJJ4EStFNObCLb7rShehmAZXdxKs/MF2HLHtKWorFumwpnzLwxJl0sJO3Q5ZYfVUmqmHkvhHASHKbDZu2A6NYVDirGv7qpjQL2jbkHV7w7Zpsnw4PR/+Us76AwBvCeaRn2G1Ujdke9ehcXFtef/kMnm1Pi/wa3fpOmGDmxuHTnC+PZ6K7AyhTkBg+bFKqzgcf3LbuJI7arUnXYn2HzCdIAdzMDRynnS2KVoLek84mIAfdjnSNa5B/M3iy0pQpGY63jFisI+cSPK0iormNcgdjzo2+yVi9J52L11xjWuOXeZjB6sB5PjIi+l5FbRmQsNM1JO6U46fHzbZ/wFjo2krkZ7CVp3oo3xDfVFN6+bL/GpNod0zDcHuS7zFvPDwTto9YUubqqJvfhwNvl9v5nUsw9vR1dmzKnEQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 10:43:42.4922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33f872d-ddb4-4b69-0414-08d7dc72df2f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 04. 20 11:09, Arnd Bergmann wrote:
> On Thu, Apr 9, 2020 at 8:37 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 08. 04. 20 17:52, Arnd Bergmann wrote:
>>> The firmware driver is optional, but the power driver depends on it,
>>> which needs to be reflected in Kconfig to avoid link errors:
>>>
>>> aarch64-linux-ld: drivers/soc/xilinx/zynqmp_power.o: in function `zynqmp_pm_isr':
>>> zynqmp_power.c:(.text+0x284): undefined reference to `zynqmp_pm_invoke_fn'
>>>
>>> The firmware driver can probably be allowed for compile-testing as
>>> well, so it's best to drop the dependency on the ZYNQ platform
>>> here and allow building as long as the firmware code is built-in.
>>>
>>> Fixes: ab272643d723 ("drivers: soc: xilinx: Add ZynqMP PM driver")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/soc/xilinx/Kconfig | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
>>> index 223f1f9d0922..646512d7276f 100644
>>> --- a/drivers/soc/xilinx/Kconfig
>>> +++ b/drivers/soc/xilinx/Kconfig
>>> @@ -19,7 +19,7 @@ config XILINX_VCU
>>>
>>>  config ZYNQMP_POWER
>>>       bool "Enable Xilinx Zynq MPSoC Power Management driver"
>>> -     depends on PM && ARCH_ZYNQMP
>>> +     depends on PM && ZYNQMP_FIRMWARE
>>>       default y
>>>       select MAILBOX
>>>       select ZYNQMP_IPI_MBOX
>>> @@ -35,7 +35,7 @@ config ZYNQMP_POWER
>>>  config ZYNQMP_PM_DOMAINS
>>>       bool "Enable Zynq MPSoC generic PM domains"
>>>       default y
>>> -     depends on PM && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
>>> +     depends on PM && ZYNQMP_FIRMWARE
>>>       select PM_GENERIC_DOMAINS
>>>       help
>>>         Say yes to enable device power management through PM domains
>>>
>>
>> The same issue is likely with others drivers dependencies too which
>> depends on ARCH_ZYNQMP.
>>
>> It means all drivers which includes "linux/firmware/xlnx-zynqmp.h" and
>> call zynqmp_pm_get_eemi_ops() should depend on ZYNQMP_FIRMWARE instead
>> of ARCH_ZYNQMP.
> 
> The only one I see that has a hard dependency on ARCH_ZYNQMP
> without allowing compile-testing at the moment is drivers/edac/synopsys_edac.c
> but that doesn't use the firmware interface.
> 
> What I see in the header are declarations for exported functions:
> 
> int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
>                         u32 arg2, u32 arg3, u32 *ret_payload);
> #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
> const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
> #else
> static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
> {
>         return ERR_PTR(-ENODEV);
> }
> #endif
> 
> The second one already allows compile-testing by turning into an
> inline stub, but zynqmp_pm_invoke_fn() does not, and this is the
> one causing the problem here.
> 
> I still think my patch is a good fix for that issue, but if you want to
> handle both interfaces the same way, we can also do that, either
> removing the stub and using a proper dependency, or using
> the same stub trick for both.

I have really not a problem with your fix above because the patch which
was applied has started to remove dependencies on ARCH_ZYNQMP. It
shouldn't be there because the same interface is used for new Xilinx
Versal device.

That header has been reworked by patches from here.
(last one) http://lkml.kernel.org/r/20200318115452.GA2491827@kroah.com
that's why changes has to go on the top of it.

Anyway feel free to take it directly or I will take it and send you pull
request. But will also look at other dependencies to make sure that they
are correct.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal


