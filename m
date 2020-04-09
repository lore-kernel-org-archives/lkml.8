Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FDBC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9601920757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hRuxXiC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDIGhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:37:21 -0400
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:12454
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgDIGhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:37:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKXlRa48HR0ySqzYUfhenj7zaJZXJI6Y+NKpV3yBY3srfBZLJJ0wgzECn82L0GuE796qfdY1fUFVI47J4kNotOokZ72tm8rzd7PJHyciikO96dXyDrGHRwDZpOSs7oC541qK4P5GINO6yD+Nd0Jx9muufpJvWIHwUgh7OCpU6Og1LEN/9YOgS7pKEVM2UW1L4n9xXgWjGAcl6dJD8oX1llhd5QQdn70YZtoQAmUQph9AtZ1r5fl0aotKnwW7FlKTWawqMiToqVsAVdosz1iugXCjI1fgJjC+Ei/HMHaU/YVgCNTh3rIhoBQPFJWqpWEYEC7c2PgYRnVvQVBKUh5rNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oiu8tPGiPIIjanZwyDCGyASoCzRY6d/QhrlbRZEQ/s=;
 b=RpdV3o/7O7W1WbZjusAuHXS4IMCesowq6slnoP82KYoluxn78Z8tkZ6Neqtg9Fx0gNwVdMn0Nhj/+Rn6smCn/CHmo7qFgPhPApGSBMEeiR+hNw/3ztZBPfJIJDNkSSgQIT1RiMEg23qDr1w8z12T0OzWVMWacPipbVwTxDeQKmL2AbNDqZLazEOG8UFUaWDBrn/3VKnXPOSN/l6vWOT57yDgQgXG1pKyHHR3q09O/MbiDFEm7jMBxZAhTXQL8e9dwBbCgBii/muoqS2nn4MsJeIfHsCrBDGiLmnsZnf/eOhfQz++GG+XLVzH4OhI0h4CBPsofu5LC1b/x/vT1jLHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oiu8tPGiPIIjanZwyDCGyASoCzRY6d/QhrlbRZEQ/s=;
 b=hRuxXiC9th3XwbuWUBhO7aVE+PC0bzNulY54ipdoYt2VA1bDUhJzUNW2evBTxXY0J5TTLrIPvuWd8Q7KflveSjuUiK62BDnhfV4Ug9xsSDgHvV1OEM5gXLRseV50R+Dlm80j55BdVBRJp/6ei7GTn1eH7iPC7x2TEYmvbObCSDs=
Received: from CY4PR13CA0029.namprd13.prod.outlook.com (2603:10b6:903:99::15)
 by BN6PR02MB2178.namprd02.prod.outlook.com (2603:10b6:404:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Thu, 9 Apr
 2020 06:37:16 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::c3) by CY4PR13CA0029.outlook.office365.com
 (2603:10b6:903:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.6 via Frontend
 Transport; Thu, 9 Apr 2020 06:37:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 06:37:15
 +0000
Received: from [149.199.38.66] (port=34509 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jMQny-0008Oy-Bb; Wed, 08 Apr 2020 23:36:50 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jMQoN-0007qv-9M; Wed, 08 Apr 2020 23:37:15 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0396b8FU014886;
        Wed, 8 Apr 2020 23:37:08 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jMQoG-0007pb-6P; Wed, 08 Apr 2020 23:37:08 -0700
Subject: Re: [PATCH] drivers: soc: xilinx: fix firmware driver Kconfig
 dependency
To:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Cc:     Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200408155224.2070880-1-arnd@arndb.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <69e8b684-c314-d356-bf3e-e38676d07853@xilinx.com>
Date:   Thu, 9 Apr 2020 08:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408155224.2070880-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966005)(8936002)(426003)(356004)(6666004)(44832011)(2616005)(31686004)(31696002)(5660300002)(8676002)(6636002)(2906002)(336012)(81166007)(47076004)(36756003)(4326008)(186003)(70206006)(478600001)(70586007)(81156014)(9786002)(316002)(82740400003)(110136005)(26005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dac79d2-ef2b-43b1-7aeb-08d7dc50717d
X-MS-TrafficTypeDiagnostic: BN6PR02MB2178:
X-Microsoft-Antispam-PRVS: <BN6PR02MB21788EF381C64CF865189927C6C10@BN6PR02MB2178.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3UXnlEBAltRGTP4uh+CY6+H9ZHHrnpRBs7gqvvM1gjfKX9qcteTG1MU2hMBuFkccGfrKuJJVJ4g1qEVk5J2Q6WVhNRBekGoxiwkWtGJUoZZeyWh07cpWUube01oE9p12y4mmz/6t+vbDTbM2siiDAIvw5wtogsxV8LGmDtWWPxg0ArkEogIdbXh36uqykgeiSYh4BU10FbmmMJu0SIH5EWnOZN+OKgtc/2borT10oRQ8N3zI/CErFPLS9SwJgQuzNR/c7WWHQKNA83dFYTvRJtqtp1Yc9owbPhCUPbBf5Dgk9vvgGjgDxMDJ4abEUQCtBlRnFGnnCQR3D+VjgBHjA9fME8xSLxVVffsdOlFVkTu9FM1SGuiyVkEZ2BzvxLCeLls8Ziv6ZSdF6ndRR95J8mDL4nx3DzbkPwPWnBZZSi6f9z0EJRvYdKdp4NjKmE+lFdZ5yVY3nuUKZbNLzXSbMxzKdgu74Yqc2ahpI0hpSdUDwPskg4VKe1EF+xOPCRjcRVQTVQ1D0vunubg5viLAg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 06:37:15.5687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dac79d2-ef2b-43b1-7aeb-08d7dc50717d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 04. 20 17:52, Arnd Bergmann wrote:
> The firmware driver is optional, but the power driver depends on it,
> which needs to be reflected in Kconfig to avoid link errors:
> 
> aarch64-linux-ld: drivers/soc/xilinx/zynqmp_power.o: in function `zynqmp_pm_isr':
> zynqmp_power.c:(.text+0x284): undefined reference to `zynqmp_pm_invoke_fn'
> 
> The firmware driver can probably be allowed for compile-testing as
> well, so it's best to drop the dependency on the ZYNQ platform
> here and allow building as long as the firmware code is built-in.
> 
> Fixes: ab272643d723 ("drivers: soc: xilinx: Add ZynqMP PM driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/xilinx/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
> index 223f1f9d0922..646512d7276f 100644
> --- a/drivers/soc/xilinx/Kconfig
> +++ b/drivers/soc/xilinx/Kconfig
> @@ -19,7 +19,7 @@ config XILINX_VCU
>  
>  config ZYNQMP_POWER
>  	bool "Enable Xilinx Zynq MPSoC Power Management driver"
> -	depends on PM && ARCH_ZYNQMP
> +	depends on PM && ZYNQMP_FIRMWARE
>  	default y
>  	select MAILBOX
>  	select ZYNQMP_IPI_MBOX
> @@ -35,7 +35,7 @@ config ZYNQMP_POWER
>  config ZYNQMP_PM_DOMAINS
>  	bool "Enable Zynq MPSoC generic PM domains"
>  	default y
> -	depends on PM && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
> +	depends on PM && ZYNQMP_FIRMWARE
>  	select PM_GENERIC_DOMAINS
>  	help
>  	  Say yes to enable device power management through PM domains
> 

The same issue is likely with others drivers dependencies too which
depends on ARCH_ZYNQMP.

It means all drivers which includes "linux/firmware/xlnx-zynqmp.h" and
call zynqmp_pm_get_eemi_ops() should depend on ZYNQMP_FIRMWARE instead
of ARCH_ZYNQMP.

Thanks,
Michal
