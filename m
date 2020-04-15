Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA74C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28F3206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ty8y39eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894497AbgDOI0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:26:34 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:38625
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894469AbgDOI0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:26:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgU12FfMQEwRsFGNefBoDYBm3/WLakUxe++LhO60YNSjZ1p1PVleuphzbPprhumRdmJpVSV4gUeJ+m4YQQ5NafmDyee27TQhvKYxhFwRtTGKZW46HAeCgj0XSCx5mSSgIQAVJcTT5Ks18s90ZysnJ7hP6HLR6P1Euvj1YVl/6V4UH/asTPBYavyIxfm3e7fL5QoWusrvLkkpD6e8TA7ox7hGjygPAT/jyQu/1Ez3MeehQj9wzwqpDJwoVgCZlAajLulHFLOHoXpBAC/Hia84SXzxKgK+OpRuNEDkl7O0p27bcIm/f0EhK0Tz7k4SluxkOSbNnpAGplbbDDsaoPFtZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQrIOIZJUde/6EXgH/pN95x1ILWvoaPzO3dLx839zPg=;
 b=QS1mZY62/vtpNt86pBqXqkpl7y5+uRiFB2lMAPySVMf3wSOpkdzUZzpr+wAJ201Rtu6cjJXG3tOB9X88BJaN2lYO5HKQJZSnBh95zX4SGsOOnZfvdKNtyYg6/71k0euRvoEf4PhqoB+tTVsvULFwpPU/EJ1bLS/DZ3Sk2KBXn0pvLQfk4fW9LRvS7SWkQfonlHkjWk3001uLa4qKDnR2Kfv3mLgxWwlBTpU6Xl917vB5GRxFAgKXF2oaZPOxc5u3zB6hcAwBg4AC6EyqRreA1QV+//u9Ccoj/A6lmzq2Ye45bnNTSO8WGmJ2eMNs/B68BCsDKWlCcZq0k2K+7uEM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=huawei.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQrIOIZJUde/6EXgH/pN95x1ILWvoaPzO3dLx839zPg=;
 b=Ty8y39eF1wFMwZW8j7rMfH3/Rxa5+m9s0MIxvws9zqFtrtQpv00GtslNKLevbqgZBAWanrv5UoHzDrmnw7ddyQpcd2npEjb+G6ZLMxS7UzBf/01wabgIZoXHTtR2n1rnBN0GtoL7OKP77DRFHn9flf2vCc41bO4qbtjjc1MKLmE=
Received: from MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15)
 by BY5PR02MB7044.namprd02.prod.outlook.com (2603:10b6:a03:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 15 Apr
 2020 08:25:22 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::54) by MN2PR16CA0046.outlook.office365.com
 (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend
 Transport; Wed, 15 Apr 2020 08:25:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 08:25:21
 +0000
Received: from [149.199.38.66] (port=36005 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jOdLa-0006EP-Le; Wed, 15 Apr 2020 01:24:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jOdMH-0008T9-7J; Wed, 15 Apr 2020 01:25:21 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03F8PHPB007582;
        Wed, 15 Apr 2020 01:25:17 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jOdMC-0008RX-SX; Wed, 15 Apr 2020 01:25:17 -0700
Subject: Re: [PATCH] firmware: xilinx: make firmware_debugfs_root static
To:     Jason Yan <yanaijie@huawei.com>, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200415084311.24857-1-yanaijie@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d17ad4d4-43a7-8cab-bbdd-f63d425a0abc@xilinx.com>
Date:   Wed, 15 Apr 2020 10:25:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200415084311.24857-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966005)(4326008)(81166007)(70586007)(336012)(426003)(31686004)(26005)(316002)(36756003)(70206006)(2616005)(186003)(9786002)(5660300002)(356005)(82740400003)(31696002)(47076004)(8676002)(478600001)(81156014)(4744005)(8936002)(2906002)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e73f183-496e-4922-09bf-08d7e11689fe
X-MS-TrafficTypeDiagnostic: BY5PR02MB7044:
X-Microsoft-Antispam-PRVS: <BY5PR02MB70448CBBEA77FA7232C8DDA6C6DB0@BY5PR02MB7044.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0374433C81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zd8HV+99yrAzfON2TVou4kzhNGX2763QGt42h6LWvFg3G0pph0B7fFsY3nHK0ulF3gsWrj1kArIigV2S/jZuMn8zpkSSikStU9CHde/GWCPyP0EfOBqfwW7qT6A7phe8gEYk/BGUAuRUg5JFjAGt/z4rqfAW+d2y/u8U1zop72XoSxJQbWEcr5PfU6NTuSKuwITALX1zFHwh93u8PV9nXONQIgyPMXi1cBUScNG1Q67qnUkebxu8bBnEgtTEH86Q+c7rdmVc0If/1nDTpk5hgpdaAhvFLbKaoVSou7mVaaxPHw/wBnzCiEBd9oGSI1K35YRAVNj9Z2xDkb0TXBRJ+SggGzgdfxrheKvRIcU9RRIVXiXtyZObq1jcjDSkkprfWtfS3TdfUrZ78gMWdhOb+T0mvuWczBp97rO+pZni01UOPUKNZ7BGQsZXIMnzH8TQS8U7LvZisR6FM9P1c41vQb1W9eeSnRf64/V2RD/JWXCPsYXisxM+6ga+oN5Q9h5wuos9SDTWAqCmRN9Qxih6Aw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 08:25:21.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e73f183-496e-4922-09bf-08d7e11689fe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 04. 20 10:43, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/firmware/xilinx/zynqmp-debug.c:38:15: warning: symbol
> 'firmware_debugfs_root' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/firmware/xilinx/zynqmp-debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
> index c6d0724da4db..43bc6cfdab45 100644
> --- a/drivers/firmware/xilinx/zynqmp-debug.c
> +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> @@ -35,7 +35,7 @@ static struct pm_api_info pm_api_list[] = {
>  	PM_API(PM_QUERY_DATA),
>  };
>  
> -struct dentry *firmware_debugfs_root;
> +static struct dentry *firmware_debugfs_root;
>  
>  /**
>   * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
> 

Applied.

Thanks,
Michal
