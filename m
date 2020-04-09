Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369AEC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0484620730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="o741Zv86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgDIUse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:48:34 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:61782
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbgDIUsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:48:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcw1bCkXE6HCjPhyNSVRnDwE6Jv9/daWsIjnuAHq2K4HhKZqbnX3p5M8cI1jIUAZqS/Y7eS1Fk/c8haRbOZlpI0Az7bBxEJgyo4eAIyCcUb3e/8mLN0D554Y+4hQk9FznzsBIU4GH4LTWROl4xreKAFlBXNmuxG48Ro8NqvIl/kfyvNRPR3vgsn+Ak0HQCWOIDGKkoBLYYIQm+LopgNrqFUHxdu26dfU57Z5aolHhfRm/p1I+ekV754lG5+tsCB76B8+Dj7CZUMHwSmCVfoH2oHh4WgkJIa9wJglGWSAcJRYM98EGiHqZXvBF6wNfGrIDBC0owRdM2sv8sIqr3gUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XsqQYcGZmxaBqGAZamo7n/bd7sRmpBNPCua8oCGoFc=;
 b=Bx9eLGfJrBOPz9AwoZRxNVPe19v7KuDcIQ9R6ktL0B5HK/dxzbMR1RADBfOor8vIZ1RLtqbXUCS8WgbUSs06oLoJzby7ide0AdAJMT8JJSypFuWH3I0zezYCbkYDjQYQp4k0Lf7CvPov94IzADiqGp6CxS7uZy98swi04gkWxD9Rn+/Mmt8732WoPUwmvjHjq9ncIcg2Gpe9wf5Yz5VHq88Sra8jB3vzeIUUkcOHS0cQSYprBwncfH3VsLue8yFGylty5RblyRFiXqgNnpzgomsP5nagdVqUK7TNkxAmO5ZBMyEbCKMbbJKoKsB2Q+OYpftgQ6iPiGjBMCS5Mn2+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lixom.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XsqQYcGZmxaBqGAZamo7n/bd7sRmpBNPCua8oCGoFc=;
 b=o741Zv86INArJ27uggeICwCVmdXcESU2HNDFL2pXIF3584Abko9+sGjeL4ahrO1p9CgtKEczkTrm9ezNtzYPEQjJaM6OvIlVl6SpGaCveNnAaCtm0rtdr953oEO7nGBZNjqkDHXX9CtPRVOXyxCuoaQphFZ5lqMOxBv0/eys/NQ=
Received: from SN6PR05CA0033.namprd05.prod.outlook.com (2603:10b6:805:de::46)
 by DM6PR02MB6425.namprd02.prod.outlook.com (2603:10b6:5:1fc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Thu, 9 Apr
 2020 20:48:29 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::23) by SN6PR05CA0033.outlook.office365.com
 (2603:10b6:805:de::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.6 via Frontend
 Transport; Thu, 9 Apr 2020 20:48:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lixom.net; dkim=none (message not signed)
 header.d=none;lixom.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 20:48:28
 +0000
Received: from [149.199.38.66] (port=41476 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMe5h-0000yK-Ug; Thu, 09 Apr 2020 13:48:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMe68-0008MZ-JY; Thu, 09 Apr 2020 13:48:28 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 039KmOhv023227;
        Thu, 9 Apr 2020 13:48:24 -0700
Received: from [10.23.122.17]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1jMe63-0008Il-7m; Thu, 09 Apr 2020 13:48:24 -0700
Subject: Re: [PATCH v2 0/2] drivers: clk: zynqmp: Update fraction clock check
 from custom type flags
To:     Jolly Shah <jolly.shah@xilinx.com>, olof@lixom.net,
        mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <793fb28e-1292-320b-2f03-6c529bba38d8@xilinx.com>
Date:   Thu, 9 Apr 2020 13:48:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(316002)(2616005)(9786002)(186003)(426003)(53546011)(26005)(478600001)(336012)(15650500001)(31686004)(81156014)(8676002)(36756003)(4326008)(70586007)(70206006)(82740400003)(2906002)(44832011)(81166007)(31696002)(6666004)(356004)(5660300002)(8936002)(47076004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe2a4ba0-6f96-43fb-7def-08d7dcc75b8e
X-MS-TrafficTypeDiagnostic: DM6PR02MB6425:
X-Microsoft-Antispam-PRVS: <DM6PR02MB64254E4218B0D8E109D4945FB8C10@DM6PR02MB6425.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5du9zNfB0cDfUrrUBZ4gJDDucEqnstVDTHuUs/QIdEH77mNiwa0dm2ZkyXw06WaGKCnXHagQtaPAuPYLXAWHVUs7ch9IuZ7Kjvy/Acf2N1wl42eaG5oeTSlUebaqvMTRzHAW1dkrn2UfTWwrs7TooA4r11Q3wlwsEY4J47wcBUDZrsWMraFQYG8PIwx5EzUicb16vuAqZvu78c+CjH6i3oBW5lQryjwPdU+1K5qDEcr9XeXDiPj8vj7ZhMEwHnUqUHvu50hhV9p02CT/gw94eCJRCJRk6tAWG3boEduzrxoM7MP6a0ne9OjBDXMExHiZcXgo8+3ikiZTQhwqpQZehpeWpt2SF5om7nedmv4T1EhH8w7/2dTlrhDBeexpAez7kJ2d3assT88EFBfczld9TUFDOJR0jBLo33Hg1Ysa2CX/Nya+lmKMV/GAJn/nK6Nsl+7qwBDWzwXpy7whX9kpk0zso3PotAcUd3S7kpz2mx9DSxHo7JauPphqQdti1/uLmJM7JeZop2g9ZQpe6jtPQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 20:48:28.8762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2a4ba0-6f96-43fb-7def-08d7dcc75b8e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6425
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

Ping. Please review.

Thanks,
Jolly Shah

 > ------Original Message------
 > From: Jolly Shah <jolly.shah@xilinx.com>
 > Sent:  Thursday, March 12, 2020 2:31PM
 > To: Olof <olof@lixom.net>, Mturquette <mturquette@baylibre.com>, 
Sboyd <sboyd@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Arm 
<arm@kernel.org>, Linux-clk <linux-clk@vger.kernel.org>
 > Cc: Rajan Vaja <rajanv@xilinx.com>, 
Linux-arm-kernel@lists.infradead.org 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org 
<linux-kernel@vger.kernel.org>, Jolly Shah <jolly.shah@xilinx.com>
 > Subject: [PATCH v2 0/2] drivers: clk: zynqmp: Update fraction clock 
check from custom type flags
 >
> This patch series adds support for custom type flags passed from
> firmware. It also update  fraction clock check from custom type
> flags since new firmware pass CLK_FRAC flag as a part of custom flags
> instead of clkflags as CLK_FRAC is not common clock framework flag.
> 
> This patch series maintains backward compatibility with older version
> of firmware.
> v2:
>   -PATCH[2/2] Correct BIT index of CLK_FRAC in custom_type_flag
> 
> Rajan Vaja (1):
>    drivers: clk: zynqmp: Add support for custom type flags
> 
> Tejas Patel (1):
>    drivers: clk: zynqmp: Update fraction clock check from custom type
>      flags
> 
>   drivers/clk/zynqmp/clk-zynqmp.h | 1 +
>   drivers/clk/zynqmp/clkc.c       | 4 ++++
>   drivers/clk/zynqmp/divider.c    | 6 ++++--
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 
