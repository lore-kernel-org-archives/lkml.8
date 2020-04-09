Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7E320730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Dv1eS3uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDIUov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:44:51 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:42161
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbgDIUov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:44:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtJuzJ+BdDj+Sv3w3kiFkw3FqLGx1C22COvJ0kPdfk8dEzchTmAOcDglvLw27jbXBG+JFs4rBj8WiPucjDzeGkjWUAexHMDUMJzpVHlFNYBKg0AxFl4L1GNRRFaY/oGMz5MfI9kUBN6gd5txPQ19zGAcupsNIABiz80q/hrAdTN2QSZ3/19D0AOj7aerLAWlYVc5SfXAm4ZJdkvtb1DTEtHBiSqLEnZMqVIRPEysjK0LwWkcywSLv0Hue5U6RqOIRChMJH8sseslKj0RlwDn4GKt2gFG3gZP24ktnTnvcmVfyMWatVBLLpyUNuYZef9e02mhJqgxZ0U9a9TP3g0PRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OYNXdj5IXASKifnuR0YD14RW+IaZCP4Ugu+VP1NSe4=;
 b=nAdl0vMOTsPWYwkZQgvpWiUaho00eHNsdfDtvwQjhXLMzSyx6otAMhQt2yPSHfneXMTm5natjzWE4OpL/sLho8tkzzyAwfF87j672duMXY+tKDTGvUI5yVvFq0xSW+kvxWi38hLB5Gsr+z8uCcuXqv02kAVi8wtV5t2Nz2xpdjckq/EVnr5CnbCNoU8NwZxbbKCy/yjr93OyeDtH5hfb2D2+HWaDPTljuXsKM8SK6GnD0jceg3dW3Wj7EXOKugTyJbEvTUMmm1AkjYuAPQc+CqTfMWcRvQN/9Pxd9cFPnNWPckddzrrpe1QKemEh0FLnhfDWI81QqOz8BHgwTMJ7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OYNXdj5IXASKifnuR0YD14RW+IaZCP4Ugu+VP1NSe4=;
 b=Dv1eS3uZIz57u6S9mTwPHCSkvyiRwSQ6tf5gXIxHuxjzgitgJ5qqcD3iYSSdnHWOFex9Qn7Uz0Klp88Kqfa+9dnP1CT+xMEsTbdYffoAu6qpzCY/BEBwrJGC9a+dR+7n5rRdroXlM8Pf7tTXEZ2xDpJgK6r+e7D1I5NYUiETG30=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by MWHPR02MB2445.namprd02.prod.outlook.com (2603:10b6:300:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Thu, 9 Apr
 2020 20:44:48 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::1d) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Thu, 9 Apr 2020 20:44:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 20:44:48
 +0000
Received: from [149.199.38.66] (port=36957 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMe29-0000oY-6T; Thu, 09 Apr 2020 13:44:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMe2Z-0007Tk-Qs; Thu, 09 Apr 2020 13:44:47 -0700
Received: from [10.23.122.17]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1jMe2Q-0007Po-1l; Thu, 09 Apr 2020 13:44:39 -0700
Subject: Re: [PATCH v2 0/4] drivers: clk: zynqmp: minor bux fixes for zynqmp
 clock driver
To:     Jolly Shah <jolly.shah@xilinx.com>, olof@lixom.net,
        mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <d4346186-5948-5348-2c92-e1ef435294e9@xilinx.com>
Date:   Thu, 9 Apr 2020 13:44:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(5660300002)(4326008)(9786002)(70586007)(70206006)(8936002)(81156014)(31686004)(81166007)(47076004)(8676002)(82740400003)(2906002)(186003)(26005)(36756003)(478600001)(6666004)(356004)(316002)(53546011)(44832011)(426003)(2616005)(31696002)(336012);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27a31cb-1cd7-42d2-dd6e-08d7dcc6d806
X-MS-TrafficTypeDiagnostic: MWHPR02MB2445:
X-Microsoft-Antispam-PRVS: <MWHPR02MB24452B64732BD15850CBFA67B8C10@MWHPR02MB2445.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nmxs8dCmD6PcEkH+TddkGFEm/B9Rkc7vDhPIrbiQJudfjB6UWK+68NVtEtKtZI0kbWOf4vDDgrTbKY0Su2OBlMfghL7Fbx8Bvjugw8UaVxXwMSWnetmDqAOqAkjRFGU1gW5sETHdU0jVmXJLFVTsK0Ode2UD5DsXDX/VLzyG2Todd7dr8u/ygjEfB5ywNCnld1RXQN992uO1QgYbRsIhqhuE4LuXiA3tqnTuKQSM5he71Fx0irpMckeNOpLn+vWjokWPBs9fEG9vnAmRHAIwT+V1OdKuhx9QReG2gS9goONSoEqEhXp9xZQYQrDoeRRlO+kp4XuL+VIMhdBpgCETgx0Dxk3VTGDOV9x+uJBKCVDALPEFZJ82DsGYUEfWl+8sxIKK/lmWgJKb3Atvz1vsYw+Ns04VI47SPkzE6ctqcJwW3nlZHkDurcaqkwEGOROSOWtyqB+yofyW9E4P2gDCwkzZGlwWBO4pkWZV7pvrKOD0sbuwV/iylNXW1gecKOasegfUpy15qV2eHpPhAlmqGQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 20:44:48.1998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f27a31cb-1cd7-42d2-dd6e-08d7dcc6d806
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2445
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
 > Sent:  Monday, March 02, 2020 1:50PM
 > To: Olof <olof@lixom.net>, Mturquette <mturquette@baylibre.com>, 
Sboyd <sboyd@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Arm 
<arm@kernel.org>, Linux-clk <linux-clk@vger.kernel.org>
 > Cc: Rajan Vaja <rajanv@xilinx.com>, 
Linux-arm-kernel@lists.infradead.org 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org 
<linux-kernel@vger.kernel.org>, Jolly Shah <jolly.shah@xilinx.com>
 > Subject: [PATCH v2 0/4] drivers: clk: zynqmp: minor bux fixes for 
zynqmp clock driver
 >
> This patchset includes below fixes for clock driver
> 1> Fix Divider2 calculation
> 2> Memory leak in clock registration
> 3> Fix invalid name queries
> 4> Limit bestdiv with maxdiv
> 
> v2:
>   - Updated subject for cover letter and patches
>     to add prefix
> 
> Quanyang Wang (1):
>    drivers: clk: zynqmp: fix memory leak in zynqmp_register_clocks
> 
> Rajan Vaja (2):
>    drivers: clk: zynqmp: Limit bestdiv with maxdiv
>    drivers: clk: zynqmp: Fix invalid clock name queries
> 
> Tejas Patel (1):
>    drivers: clk: zynqmp: Fix divider2 calculation
> 
>   drivers/clk/zynqmp/clkc.c    | 20 ++++++++++++++------
>   drivers/clk/zynqmp/divider.c | 19 ++++++++++++++-----
>   2 files changed, 28 insertions(+), 11 deletions(-)
> 
