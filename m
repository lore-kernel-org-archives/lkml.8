Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3713EC47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFEB2206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KJV0/Bk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgEEHPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:15:02 -0400
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:3844
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgEEHPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:15:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGunRXVqcCldCAg7E+t/qmfUKV5Uebn0/AOWq+y3+HEXyIxjNqNRQkiBX1/m/wbJ3szyPyop/K+Et3pHTB+UGCwSE9N4kLZ1WlmZbJ6sEB24bRb7CtPGZZjojoCNru7siwJWoUsp0b1+VGmlSLEXp28UB8/KrMFpreL4sblp6vcFaDQCaCY3jmPZ0pxC6i3OMrtxKvpAOO+s/NQfcblZcv9xwCAG9clIT8TitFDRwvzasB0fakutOOud9akHZT9KHPl47cjDyeYUmL9GcSmav6gZP1C/ul4vkhHvcZFV1L5pDaEDivB57RoJeEf2NOBxq7qletVgEDoiNdEzwiZwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDfNJ2srGE5TenUbU3W3uEHwrjBXbC6ENMK5xmyZH8g=;
 b=ZpOpBHn/4cBP7Nw6FPKGSWifja30EejTjmmtLl3Hb36Gcve3dKe+lyzwN7J22VlVZZIOtOTbidFifz3pXLkoR5pBPRajgnqOQqDO7iqASQOGqU0VEWOK/7sntEAKAOe5YDBPCU4zh9GXrvx5XDiiKOAiciCEjJk+zuR+SC2Vk9zg5FrZU0UPxqNZTOPnrkwdZ0kELelbWzYmawsm4YyHb1zD8HmQXaXFEVGZfeY+5JUbQ533/+pihBRQyq9EJAHWoWoakZSENq6pAuvJRPg0sU8yQtjZd32cJwzSciYsgVena4d1NclAz25+RYSRY9y4AknLKMCYbpSemQrFs664jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDfNJ2srGE5TenUbU3W3uEHwrjBXbC6ENMK5xmyZH8g=;
 b=KJV0/Bk/lfk5Fz9e1R/f75N74lQpj1ooBmwqAmpYq//5X7Jwn33ILSa0maOrirJlvp3FTFRDsFbdjF2UR9lUZTdqosm7f+N0C8v669aEjgZWWk0irvG+omEnivi4xOfStZFVfh0U9HohXndIypZLGLRWoIZK6WBIuC0+f9Q281U=
Received: from MN2PR02CA0002.namprd02.prod.outlook.com (2603:10b6:208:fc::15)
 by SN6PR02MB4094.namprd02.prod.outlook.com (2603:10b6:805:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Tue, 5 May
 2020 07:14:53 +0000
Received: from BL2NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:fc:cafe::26) by MN2PR02CA0002.outlook.office365.com
 (2603:10b6:208:fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Tue, 5 May 2020 07:14:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT005.mail.protection.outlook.com (10.152.76.252) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Tue, 5 May 2020 07:14:52
 +0000
Received: from [149.199.38.66] (port=54796 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jVrmv-0007a8-TN; Tue, 05 May 2020 00:14:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jVrn2-0001cI-Gr; Tue, 05 May 2020 00:14:52 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0457EjUK024881;
        Tue, 5 May 2020 00:14:45 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jVrmu-0001bc-QE; Tue, 05 May 2020 00:14:45 -0700
Subject: Re: [PATCH] firmware: xilinx: Export zynqmp_pm_fpga_{get_status,load}
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200502025958.2714249-1-natechancellor@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7233c16b-1b00-b453-3c08-5b5b85432461@xilinx.com>
Date:   Tue, 5 May 2020 09:14:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502025958.2714249-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(39860400002)(46966005)(33430700001)(44832011)(82310400002)(9786002)(2906002)(186003)(478600001)(26005)(356005)(31696002)(5660300002)(81166007)(2616005)(8936002)(110136005)(316002)(8676002)(82740400003)(36756003)(47076004)(31686004)(4326008)(426003)(70586007)(33440700001)(70206006)(336012)(6666004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6c6d1e8-01c4-40ed-9c68-08d7f0c401b7
X-MS-TrafficTypeDiagnostic: SN6PR02MB4094:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4094DAB93D81BB12D5B1E1F0C6A70@SN6PR02MB4094.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnmI2D8wl+uW39RZDOLIBU16xza53JMxHoHafAlfQGIixte85GX6sz5MpKyCqbcBXM8/wFL4groCPGslVirpSO3Wi3NSPmUPO3gQwEeOJ8JqOTTDjRsHvKAPMk/QKT/riJPAw54rMAS2S0311iiUnJPdBGPB0sL7BKwLz99o0ioZwPtVxPkR3CCeoCrGIyVg+BTXfOMl37XP6NM6SDKg/e1D1vVUiDbf/6esCe/Tb39PQBDikI3kTuxm62lpeEUIlcSl6gf+doLgWOq93pce/O224Wu3WihD+0qH2+pRPTgmCjW/ZHqe1ScHiYc7rSlM2GjCfEvsAbx8fPmLm9yqLwqgGBHCyhHOuqNzfj1HHXfUH5Ku3c07SCo4yHx7/7wxECrf1E70CBJMUQIdTv0i+HvDknqTy3JJiWUKUdV4a9a4LKubvFE99P09uOJ+RgkqrLDE4iXxYWEALew/SziO7Q0JecmEhH5tH0+2oncQDpLWtcbbMwXAVuR23nIZKqj47vl2EXJm7udZVEeFalaqPpLNAMBSWhu7VCIlDV0rEsGaqN6kLSv7ncWS8T/CmajeMhncDM7FOtDqUJGeuBL9bg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 07:14:52.9211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c6d1e8-01c4-40ed-9c68-08d7f0c401b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 05. 20 4:59, Nathan Chancellor wrote:
> When building arm64 allmodconfig:
> 
> ERROR: modpost: "zynqmp_pm_fpga_load" [drivers/fpga/zynqmp-fpga.ko] undefined!
> ERROR: modpost: "zynqmp_pm_fpga_get_status" [drivers/fpga/zynqmp-fpga.ko] undefined!
> 
> These functions were added to drivers/fpga/zynqmp-fpga.c but not
> exported so the module build breaks. Export them so that they can be
> used in modules properly.
> 
> Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index bfaf29a58eac..8095fa84d5d7 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -755,6 +755,7 @@ int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
>  	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
>  				   upper_32_bits(address), size, flags, NULL);
>  }
> +EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_load);
>  
>  /**
>   * zynqmp_pm_fpga_get_status - Read value from PCAP status register
> @@ -778,6 +779,7 @@ int zynqmp_pm_fpga_get_status(u32 *value)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
>  
>  /**
>   * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
> 
> base-commit: fb9d670f57e3f6478602328bbbf71138be06ca4f
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
