Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C9CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E52B205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RAeLCaiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389979AbgEMRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:43:14 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:52801
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732892AbgEMRnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:43:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTPKDMiCEy6GL2JjQMGwZVPc14LEZy4ZjGVFKNAXCGaB7iU02GwjxPVtBMHkAe86zDIkh8+14LH+It/H1jZ2KR1X63ptVF4l9XKIWpU3WDEPK4SpOBb3SPH3yM5d7r0D5K3JHQMNq0hW8QUdcECaLawo9jhyuahIx+2ead4BNHsiGwBtTRVNVpSne1rDYuA2jhtSXZTlp3bp8CKK2R/sjGRSxQXkRNGgIWnolxxC7EnZsM+S+baQSNc9K9yBUEUZh3w03r+ETQhUtaM/5ubQnFN3NLTJFdewKEaj+qUFXbPz2sFjzRnfwvswXH71mzJAR5w9zmp9eBNcxco9aBel7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1DfoWz7F4vbMNNDsJudkCNRhSxtdthZCkwzpo3379g=;
 b=eWbWQdRL2bn/EwjD1Kvrgp3vCrHo0DDQJWbeHmddjxO+NCNWAzhswdTdkqFnbQFyeWvgW6vaCZFhcYNxOp6jNDIGjYWCAws40wXVOPEm5T3eMc1XB0mcXJvGEynB4z0ZEmTLf3yDo4nirJoQXT94s7x4o8vZtckRloD74K/dTJM+hLBgPwfMnvsWlvPD9R731HMWjY+RO2Zyt9YlXpl2tnFqM9Ip5uJeYTYvFE9tznVBW4iUAM15DGzPU+EK/j25O7G3zYC5juFtiZHxemDdt+KL/NOmPo8oIQH1TWYX0m+h3lruJMkVuUU10yteYTR883mZFlRVeqLj+kfXb1huAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1DfoWz7F4vbMNNDsJudkCNRhSxtdthZCkwzpo3379g=;
 b=RAeLCaiUz9P57oWeqhlY+7mRAbrCEPyy+Kl8mX798h39f57yygJ7aguNsn/E9i4xbNHQX+geMiq7LzzGGrqb7oIGvGZCcR7agznC+L6updYDZ3d6ymAjDMI2ELQKzoC8dnPUIRsBXXQCukdpq+9yKtkckKAf2iGZX5Z7Bb3Rlrk=
Received: from MN2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:208:120::14)
 by BY5PR02MB6177.namprd02.prod.outlook.com (2603:10b6:a03:1b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Wed, 13 May
 2020 17:43:09 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::15) by MN2PR10CA0001.outlook.office365.com
 (2603:10b6:208:120::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Wed, 13 May 2020 17:43:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 17:43:09
 +0000
Received: from [149.199.38.66] (port=60787 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jYvP9-0007Yn-0n; Wed, 13 May 2020 10:42:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jYvPQ-0000dM-RP; Wed, 13 May 2020 10:43:08 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04DHh0GP012428;
        Wed, 13 May 2020 10:43:00 -0700
Received: from [10.23.124.238]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1jYvPI-0000bN-BF; Wed, 13 May 2020 10:43:00 -0700
Subject: Re: [PATCH] firmware: xilinx: Fix an error handling path in
 'zynqmp_firmware_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, gregkh@linuxfoundation.org,
        tejas.patel@xilinx.com, manish.narani@xilinx.com,
        ravi.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200510130357.233364-1-christophe.jaillet@wanadoo.fr>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <248faa4d-4f85-343b-16ab-fac3f4761dc7@xilinx.com>
Date:   Wed, 13 May 2020 10:42:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200510130357.233364-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(396003)(376002)(346002)(46966005)(33430700001)(47076004)(36756003)(33440700001)(478600001)(426003)(336012)(70586007)(70206006)(356005)(81166007)(2906002)(4326008)(82310400002)(82740400003)(9786002)(8676002)(316002)(8936002)(31696002)(6636002)(186003)(26005)(44832011)(53546011)(31686004)(5660300002)(2616005)(42866002)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd8f83e6-49c3-4490-3b22-08d7f76519c9
X-MS-TrafficTypeDiagnostic: BY5PR02MB6177:
X-Microsoft-Antispam-PRVS: <BY5PR02MB617714659A5990B5B84D92E4B8BF0@BY5PR02MB6177.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fO+zwL7Y/odOKyKzymdC0jBm5uxSUpkKqfmL8YxRiDLdJDuK3P/tk97DMTVsD3ZXVnujzOXDg4MROKZXoyaFqbCcUp1rwV35fWK/+thyHUi1EtcuMC7aHOcKCnIySBUI7MybnsWcuLWDysef/pXAaxQBbbUc5vufsyMhlu5gyz/2A7KGKNTl2FTEhHuNtef5s00vbVsHWSqF/+Av8lQ+v14rAGIhxVDd5A696ATIuHCGqE9nKd5Po+HEdvxEGiV7Mk1/gY4F0WwrYFBmD1gO2TKl0MvQIlQgC76ac6P7AbnW5jSTB80bCdNKg+PQlpsFlQjjvq9eN3rpR5iSdYlTK0x35SBs8GNWNK3LO7vga6+WXiid6He2LHruUXPpLPiDXX+7rpGN9vkDm2q5GofFpNjjfVSvCpUy3IpTMpOGUVDr9F9FOj8S9I0W9vZdh24PruPWUCN2CAKjT6FczzXbh1QXQVCkpGTBB/d0E5DUcn6nnKmHKsynbTdIlRmKjkq5XvyJoZHbwRz2eJpLLhRm9SgFhA3+xI2fGFqKjxerc4lkiWzIm/cBXLBFVw6vQsmqOaM7wY3KHVy2KilCf2Ir4m/xXbOPzZ7CGs/QUUb5nMx9DalP2k44QKL8PK9AZqiU
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 17:43:09.2510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8f83e6-49c3-4490-3b22-08d7f76519c9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Jolly Shah <jolly.shah@xilinx.com>

 > ------Original Message------
 > From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
 > Sent:  Sunday, May 10, 2020 6:03AM
 > To: Michal Simek <michal.simek@xilinx.com>, Rajan Vaja 
<rajan.vaja@xilinx.com>, Jolly Shah <jolly.shah@xilinx.com>, 'Greg Kh' 
<gregkh@linuxfoundation.org>, Tejas Patel <tejas.patel@xilinx.com>, 
Manish Narani <manish.narani@xilinx.com>, Ravi Patel <ravi.patel@xilinx.com>
 > Cc: Linux-arm-kernel@lists.infradead.org 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org 
<linux-kernel@vger.kernel.org>, Kernel-janitors 
<kernel-janitors@vger.kernel.org>, Christophe Jaillet 
<christophe.jaillet@wanadoo.fr>
 > Subject: [PATCH] firmware: xilinx: Fix an error handling path in 
'zynqmp_firmware_probe()'
 >
> If 'mfd_add_devices()' fails, we must undo 'zynqmp_pm_api_debugfs_init()'
> otherwise some debugfs directory and files will be left.
> 
> Just move the call to 'zynqmp_pm_api_debugfs_init()' a few lines below to
> fix the issue.
> 
> Fixes: e23d9c6d0d49 ("drivers: soc: xilinx: Add ZynqMP power domain driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not related to this fix, but I think that:
>     - a call to 'of_platform_depopulate()' is missing in the remove function
>     - we shouldn't return of_platform_populate(); directly because we
>       don't have the opportunity to call 'mfd_remove_devices()' as done in
>       the remove function, and 'of_platform_depopulate()' for what have
>       been populated yet
> 
> I'm not familiar with this API, so I just point it out to get feedback.

Agree. This needs to be fixed.

Thanks,
Jolly Shah


> ---
>   drivers/firmware/xilinx/zynqmp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 8095fa84d5d7..8d1ff2454e2e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1235,8 +1235,6 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   	pr_info("%s Trustzone version v%d.%d\n", __func__,
>   		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
>   
> -	zynqmp_pm_api_debugfs_init();
> -
>   	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
>   			      ARRAY_SIZE(firmware_devs), NULL, 0, NULL);
>   	if (ret) {
> @@ -1244,6 +1242,8 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	zynqmp_pm_api_debugfs_init();
> +
>   	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>   }
>   
> 
