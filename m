Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E41CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E74F207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lOuHtDAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405628AbgE1RoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:44:19 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:21402
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405581AbgE1RoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSZvAvDGmUasobwsjzeOQ97osDA8PHt1f58HaqUsUcaOmy5b/vIKdxh5Wz+VJLa6m+QjKkvve8+x/oSx2QzFI+6bP2/Cr1tIIaf031NbDCByQIGy9XDJ2daJERDjchaWDMgIPV32k7mGf+MknD3Jnsm5/Ib2zUYCSxkC7w/RNd9FrXPfwnP76PuxUrhemEB2fipNzeDZ345utxMwWkEdCan3FI1u4nEb83/fEP+ZidEWojSPRs8LAWj+FkpBxmwlaJb/gHCYGJCzyQ81ZOnZt1CUOvUp0cYEGUrxc2pDKF1lRs6mrrvSGt7VvCxOauNQeHscK7kSqIOAOiaYUz1V5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARMGmBC7HW1OcgFuP1OVScrr+HlnD9WLXkcM230gwbI=;
 b=fzhafQWMYjcKsYaasqP+NNJpoQHcMab5OMPN7m9MpD/fmbcFYpVnGMs6l0xYsoALwVJ4nvRdn7XifzjHon5bjqteBAEA/00IruLM+UuAsD9h+al+X2rTHkkshN2RnyLkxYvctj88o/butGuL2qUvCd3OApPXkrvyoYMUyfFqCixKcwt1MC1jNmRXuzH/fHt7crh6NGDkG9SmYHlMWSM22R+TGdYaEQdkg+DS86/Rka4s6n3tjL4Uu39hbTQ6jZo30oc33hyzrJi3qijIbiPnF+f+h1bSR+URxooLv3k+5gts+MfdBdMxfVo8AX+xdx+SBwCvqopSKmg8DIM/DbqAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARMGmBC7HW1OcgFuP1OVScrr+HlnD9WLXkcM230gwbI=;
 b=lOuHtDAFnT2ozdC4tXKC+xCuSrPiGPo85xsTbVE5lVZQGSRq1olJCxdmO2CBCW0cgs84tWm6RxO+rxQY7/uvbz8TNm8BnuPCv3a8dobhrwVS/dia/4zQRK6pc15eSRORQTMHuy33znM3xJG1FQpa96y8bWQ7E0olnV0O9+Za0ho=
Received: from CY4PR18CA0050.namprd18.prod.outlook.com (2603:10b6:903:13f::12)
 by BY5PR02MB6738.namprd02.prod.outlook.com (2603:10b6:a03:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 17:44:13 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::ca) by CY4PR18CA0050.outlook.office365.com
 (2603:10b6:903:13f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Thu, 28 May 2020 17:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server id 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 17:44:12
 +0000
Received: from [149.199.38.66] (port=60114 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jeMZ4-0000VU-91; Thu, 28 May 2020 10:43:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jeMZg-0001ZX-6X; Thu, 28 May 2020 10:44:12 -0700
Received: from [10.23.120.73]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1jeMZW-0001Wx-08; Thu, 28 May 2020 10:44:02 -0700
Subject: Re: [PATCH v2 2/2] drivers: clk: zynqmp: Update fraction clock check
 from custom type flags
To:     Stephen Boyd <sboyd@kernel.org>,
        Jolly Shah <jolly.shah@xilinx.com>, arm@kernel.org,
        linux-clk@vger.kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, olof@lixom.net
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
References: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
 <1584048699-24186-3-git-send-email-jolly.shah@xilinx.com>
 <159054169658.88029.371843532116000844@swboyd.mtv.corp.google.com>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <2c8cd31a-46ba-ec6a-67a7-f3d9abe561ff@xilinx.com>
Date:   Thu, 28 May 2020 10:44:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159054169658.88029.371843532116000844@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(396003)(136003)(39860400002)(346002)(46966005)(9786002)(336012)(44832011)(426003)(54906003)(83380400001)(26005)(8676002)(110136005)(31686004)(15650500001)(8936002)(82740400003)(356005)(2906002)(82310400002)(478600001)(186003)(31696002)(53546011)(47076004)(2616005)(107886003)(81166007)(70206006)(36756003)(5660300002)(70586007)(316002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 449b2bf3-329d-4644-f6f0-08d8032ebbab
X-MS-TrafficTypeDiagnostic: BY5PR02MB6738:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6738E358BE668024BB3ED4ECB88E0@BY5PR02MB6738.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUyWsHSu4nAAwSQR+g4f2CRNGF36g/tcf3eZkd2MLg8kBfBMEX38AZo55PkpLL08K8AiNS10V0WcA7yRTFYvP3urMCXljXi51ICVyS9t2sZdTd8sstqwj7Li7fJ1WUMdyKfYUx2tprSTqpXc3XnhLSTAoaCh0ngm6TskNWwrJ8/UylVTSdD/iTM/He23Uyt2w8JyivEhe+ZUI2zwKOe5E41HxYh6ZRpwf8QrUqzAD7zp21g87Ty5lD4jHUR4f3pR3uWUjMeh8PTv/v844z3kHTdYBw8Q4Q0tXzCWH6OVmUMD8TovWI6wFGVtiv58Ud14oRzdQ9Ns614cWDmXheOhY021r4UdSsg+j9t4/rMXVQI6o9KVIQYt5lwGQgLKt89spL0rfuy9NuOwA0LNT1LwOaoje4H7HMtJA3w3lPQtHLrLi/667/C768sQ5J556KJc
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 17:44:12.4793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 449b2bf3-329d-4644-f6f0-08d8032ebbab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

Thanks for the review.

 > ------Original Message------
 > From: Stephen Boyd <sboyd@kernel.org>
 > Sent:  Tuesday, May 26, 2020 6:08PM
 > To: Jolly Shah <jolly.shah@xilinx.com>, Arm <arm@kernel.org>, 
Linux-clk <linux-clk@vger.kernel.org>, Michal Simek 
<michal.simek@xilinx.com>, Mturquette <mturquette@baylibre.com>, Olof 
<olof@lixom.net>
 > Cc: Rajan Vaja <rajanv@xilinx.com>, 
Linux-arm-kernel@lists.infradead.org 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org 
<linux-kernel@vger.kernel.org>, Tejas Patel <tejas.patel@xilinx.com>, 
Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jolly.shah@xilinx.com>
 > Subject: Re: [PATCH v2 2/2] drivers: clk: zynqmp: Update fraction 
clock check from custom type flags
 >
> Quoting Jolly Shah (2020-03-12 14:31:39)
>> From: Tejas Patel <tejas.patel@xilinx.com>
>>
>> Older firmware version sets BIT(13) in clkflag to mark a
>> divider as fractional divider. Updated firmware version sets BIT(4)
>> in type flags to mark a divider as fractional divider since
>> BIT(13) is defined as CLK_DUTY_CYCLE_PARENT in the common clk
>> framework flags.
>>
>> To support both old and new firmware version, consider BIT(13) from
>> clkflag and BIT(4) from type_flag to check if divider is fractional
>> or not.
>>
>> To maintain compatibility BIT(13) of clkflag in firmware will not be
>> used in future for any purpose and will be marked as unused.
> 
> Why are we mixing the firmware flags with the ccf flags? They shouldn't
> be the same. The firmware should have its own 'flag numberspace' that is
> distinct from the common clk framework's 'flag numberspace'. Please fix
> the code.
> 

Yes firmware flags are using separate numberspace now. Firmware 
maintains CCF and firmware specific flags separately but earlier 
CLK_FRAC was mistakenly defined in ccf flagspace and hence handled here 
for backward compatibility. Driver takes care of not registering same 
with CCF. Let me know if I misunderstood.

Thanks,
Jolly Shah


