Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F061BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AFF206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="M99Fn/91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634766AbgDOGRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:17:19 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:32167
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393521AbgDOGRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6iQANVetPNKUKr+4X8ewdldDwI4+CVIaUBVfJvi9lvxZWYbvjITVtGzhlykPGPK8o2XlhE/k14XHd9KfT5l49YoY+IhYsafoBbJzktxFwjgOBNoYMHk5/g5Ng+ZMzHbE3BJ4tVguFw8yLstJfZd39EpZroFzeyB5rMds1wv9C6N2rig+QyuPmqCVGBrNybKYuUw3Zi+AsFI6b4e8ogNNw/7yKZxS4FX+vvTco1fTcnbDRsoJP5sR/mczxfO365jJQi7s32PpSk0N5/qkUqlCoDvxf/wsua7fnDG1YEdro1p/EDppjYBG/tVasw73DSkdz72YDlLrSCDGtLrUMjg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRJ7Qkztwup3wXuSOwsl8VfmzNqngJuOvSPQVv3jP9I=;
 b=EJNwKRLyekeKLk9wkfOVL9nyk6tPGMndl/iT9YlwiJFIcIXIstbj26pSQAPcEFuP7ZwST44I/HWzWgaTRoP+DxHtKb+Wf/yNja6V0BhPOnOaAJRzhNcDbgQy9hR6HPqJ9quQ9jrA+CwsrBptmMN6lhIJGv/CRaXJGO1Qu4Msxdx7BmS6m64U11tq/g2l11WPxim4aJbi+p/PXaM05YhH58+31b1H+BxJH4HXvhYlGcLfzRYIE+eP30Um9RpjXk98/RCfwRoZ3PgU/u/1YvQtqPgs93J6I4KN4kPBGUn1mGFznM8qS2qKN7X0jvqi6FmUfMZY2znODD88zxYpBbzu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRJ7Qkztwup3wXuSOwsl8VfmzNqngJuOvSPQVv3jP9I=;
 b=M99Fn/91mnRntEN7A3qsTHp/yKpSg210fpFphrwtm2gdvtRCJq5LMHrkL9sqhTsZZ036NhKZ/nyE95wRAPuVuZTlPTzTEvQAyWX6uMQDX3DXSU6DmU65FsxRr4jGnQQNh+jGqEFkXr9C+KDeLQ3WcVzudZqrtB88GrNYefj7bWE=
Received: from MN2PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:160::15)
 by BN6PR02MB2275.namprd02.prod.outlook.com (2603:10b6:404:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 15 Apr
 2020 06:17:01 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:160:cafe::2a) by MN2PR13CA0002.outlook.office365.com
 (2603:10b6:208:160::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.5 via Frontend
 Transport; Wed, 15 Apr 2020 06:17:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 06:17:01
 +0000
Received: from [149.199.38.66] (port=51536 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jObLO-00045R-LA; Tue, 14 Apr 2020 23:16:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jObM4-0001D0-VC; Tue, 14 Apr 2020 23:17:01 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03F6GwE8005842;
        Tue, 14 Apr 2020 23:16:58 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jObM2-0001Ay-CY; Tue, 14 Apr 2020 23:16:58 -0700
Subject: Re: [PATCH] drivers: soc: xilinx: fix firmware driver Kconfig
 dependency
To:     Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200408155224.2070880-1-arnd@arndb.de>
 <69e8b684-c314-d356-bf3e-e38676d07853@xilinx.com>
 <CAK8P3a3j7BLJZGsNFU2XLsnnBiP0x+qkPVxD0-L9Faq7+m2=BQ@mail.gmail.com>
 <3e1841ff-6116-4cfb-82bb-f1996d6ef514@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f3511f5a-f402-5253-1f52-735a0bd0b812@xilinx.com>
Date:   Wed, 15 Apr 2020 08:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3e1841ff-6116-4cfb-82bb-f1996d6ef514@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966005)(70206006)(8676002)(36756003)(2616005)(31686004)(336012)(356005)(966005)(6666004)(186003)(81166007)(4326008)(5660300002)(44832011)(426003)(8936002)(2906002)(26005)(82740400003)(70586007)(81156014)(31696002)(53546011)(54906003)(110136005)(47076004)(478600001)(9786002)(316002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875266cb-700a-4729-cf4e-08d7e1049c3c
X-MS-TrafficTypeDiagnostic: BN6PR02MB2275:
X-Microsoft-Antispam-PRVS: <BN6PR02MB227513A67113103408FFD543C6DB0@BN6PR02MB2275.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0374433C81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsVHB32ASKNGkiXOar0X7++8jxRoQ2hZUucTGmLVJKQjGgHtywYVr5md2st9G2jaDUi5GqjmB83Up3Y9HgxUfKdyuzDkRMO9Sf+h63MCzywYPrdpdT4ZnzNJfA0vmlO7AQ448W7GpSAibdlFE9OTWszOc4ilM4ToKlPOkCrxTN16vMzWbx4M1Rjd6NyIjoBlk1aE9VucfwT+n06V+PJgKwuyhJIQVnZC4gcTtWv+SxcdJV54mbJ70pjCOor/zbDqWt5WuEzNjXqI0RoPgVe8PpAvpM9Kk55mLnR4GOsWw+kWjEmxd/x9NEXML9tqBVyCGodFWmE8KvBRBu+XUShG+K+Mi6kwI2p14MbFu5l+jQsA1xExj06jkT6aRFiq57e+Q0cPp/zGCasDQ7Bms41VBaq1+A5G1f1D/hmDJf15oBb2PUBu2WTGl7vqUryod/w4tREiLIv9jegk7ba0fAh7lbbBmoUPdIL44L/NeXYqrB0IoxrBjmsE5Oisb/YbS5DTiqiZUT5kXRNo7usQXedkCkeEH+8lp/9fTyzitt+DOIgtKiQCF6UfBo4V+qf9273JeaWnjstNLxVbuXJEzxsWeg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 06:17:01.3494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875266cb-700a-4729-cf4e-08d7e1049c3c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 04. 20 12:43, Michal Simek wrote:
> On 09. 04. 20 11:09, Arnd Bergmann wrote:
>> On Thu, Apr 9, 2020 at 8:37 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>
>>> On 08. 04. 20 17:52, Arnd Bergmann wrote:
>>>> The firmware driver is optional, but the power driver depends on it,
>>>> which needs to be reflected in Kconfig to avoid link errors:
>>>>
>>>> aarch64-linux-ld: drivers/soc/xilinx/zynqmp_power.o: in function `zynqmp_pm_isr':
>>>> zynqmp_power.c:(.text+0x284): undefined reference to `zynqmp_pm_invoke_fn'
>>>>
>>>> The firmware driver can probably be allowed for compile-testing as
>>>> well, so it's best to drop the dependency on the ZYNQ platform
>>>> here and allow building as long as the firmware code is built-in.
>>>>
>>>> Fixes: ab272643d723 ("drivers: soc: xilinx: Add ZynqMP PM driver")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> ---
>>>>  drivers/soc/xilinx/Kconfig | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
>>>> index 223f1f9d0922..646512d7276f 100644
>>>> --- a/drivers/soc/xilinx/Kconfig
>>>> +++ b/drivers/soc/xilinx/Kconfig
>>>> @@ -19,7 +19,7 @@ config XILINX_VCU
>>>>
>>>>  config ZYNQMP_POWER
>>>>       bool "Enable Xilinx Zynq MPSoC Power Management driver"
>>>> -     depends on PM && ARCH_ZYNQMP
>>>> +     depends on PM && ZYNQMP_FIRMWARE
>>>>       default y
>>>>       select MAILBOX
>>>>       select ZYNQMP_IPI_MBOX
>>>> @@ -35,7 +35,7 @@ config ZYNQMP_POWER
>>>>  config ZYNQMP_PM_DOMAINS
>>>>       bool "Enable Zynq MPSoC generic PM domains"
>>>>       default y
>>>> -     depends on PM && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
>>>> +     depends on PM && ZYNQMP_FIRMWARE
>>>>       select PM_GENERIC_DOMAINS
>>>>       help
>>>>         Say yes to enable device power management through PM domains
>>>>
>>>
>>> The same issue is likely with others drivers dependencies too which
>>> depends on ARCH_ZYNQMP.
>>>
>>> It means all drivers which includes "linux/firmware/xlnx-zynqmp.h" and
>>> call zynqmp_pm_get_eemi_ops() should depend on ZYNQMP_FIRMWARE instead
>>> of ARCH_ZYNQMP.
>>
>> The only one I see that has a hard dependency on ARCH_ZYNQMP
>> without allowing compile-testing at the moment is drivers/edac/synopsys_edac.c
>> but that doesn't use the firmware interface.
>>
>> What I see in the header are declarations for exported functions:
>>
>> int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
>>                         u32 arg2, u32 arg3, u32 *ret_payload);
>> #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
>> const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
>> #else
>> static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
>> {
>>         return ERR_PTR(-ENODEV);
>> }
>> #endif
>>
>> The second one already allows compile-testing by turning into an
>> inline stub, but zynqmp_pm_invoke_fn() does not, and this is the
>> one causing the problem here.
>>
>> I still think my patch is a good fix for that issue, but if you want to
>> handle both interfaces the same way, we can also do that, either
>> removing the stub and using a proper dependency, or using
>> the same stub trick for both.
> 
> I have really not a problem with your fix above because the patch which
> was applied has started to remove dependencies on ARCH_ZYNQMP. It
> shouldn't be there because the same interface is used for new Xilinx
> Versal device.
> 
> That header has been reworked by patches from here.
> (last one) http://lkml.kernel.org/r/20200318115452.GA2491827@kroah.com
> that's why changes has to go on the top of it.
> 
> Anyway feel free to take it directly or I will take it and send you pull
> request. But will also look at other dependencies to make sure that they
> are correct.
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>

Applied to zynqmp/soc.

Thanks,
Michal
