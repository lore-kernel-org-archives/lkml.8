Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F04C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094A520716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bQ255Hdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgCLHe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:34:28 -0400
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:47232
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388021AbgCLHe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:34:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJbYxDXzqo0kc4ntrT4Hl1eB0QHURMie359BvUFV23X0a2+LM1TLPU15N4UIUTS12XLZBdarIUfViood76Kqt0Q7gN3PLJ6EXXHgbg7tBTbar0+43Sysk9ZIaHuxojt9Zv580w9PQlJEivQfebt/FQs6bNpJuO9OrW8z/vhy2g2uyiYmNALvaluiYhA+DGMZJp2I9pAz1f2s89QCoX+26wmLq6yEwpUG+rp8NNUOfyo4pyYshNMSK5MNjYlrxwy2hzhsaVZom/OfqGIxuZX8towsbEz75Kjb6XlJsBr8jqCtxEQyXWJn3D1iTW1PpCedF/+9oWEIsAyCcOZDRhdDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJUk7Qz/oD1C69ae8iSGcUcIzaiN8uNllzYrMV2aGkk=;
 b=B27ltE1eFQfulew6n2gIBXOfLJoCSTZBsrytyV7vKO3WV7Vadv3B3YSHQuUt5z2ufW3kwpO6E6nNzIXjrfAISLdGDlhJ2ei8vON0Ucpok3q9d29DDvWTwzEpmHGEKEhLRF6fMY9MJpF5as9HoDO9mTWt1IXdeB9omc3yZODH/INmn7wHxFJWSNBBNTcqX208xDNxMpr7SquDHolEtBGU59K+pOeccG/jl1W23TASKODMaNakcH/iI64yI7V0ibqjtB2owdvDsriILcueRBRsKUVqUMeRE0GngQEDxb8pdzt7rK5VCEcB3hMt0rPcA6MrgEvKzbDL7sFFLws0+JIHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJUk7Qz/oD1C69ae8iSGcUcIzaiN8uNllzYrMV2aGkk=;
 b=bQ255HdwwrKGbpoEh8hP4xnInGf3R7Rhe2b1XtMyMSceVxPG0tWe3UDJJuWnI/VYoMt7VOQeD5IpbCNvtCGIeFkEKsTWzJnapmKD9davAXt7Mema/I4RAkGToEmIzKXKoYd0xjuwooLyRmx9xfJFHv63BGoMgXuI3T2oVKuRvtI=
Received: from CY4PR19CA0033.namprd19.prod.outlook.com (2603:10b6:903:103::19)
 by CY4PR0201MB3442.namprd02.prod.outlook.com (2603:10b6:910:90::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 07:34:20 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:103:cafe::2c) by CY4PR19CA0033.outlook.office365.com
 (2603:10b6:903:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 12 Mar 2020 07:34:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Thu, 12 Mar 2020 07:34:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jCIMG-0008MH-4h; Thu, 12 Mar 2020 00:34:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jCIMB-0003vO-19; Thu, 12 Mar 2020 00:34:15 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jCIM3-0003tn-Vy; Thu, 12 Mar 2020 00:34:08 -0700
Subject: Re: [PATCH 2/5] firmware: xilinx: Add shutdown/wakeup APIs
To:     Ben Levinsky <ben.levinsky@xilinx.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, michal.simek@xilinx.com,
        jollys@xilinx.com, rajan.vaja@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1582566751-13118-1-git-send-email-ben.levinsky@xilinx.com>
 <1582566751-13118-3-git-send-email-ben.levinsky@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <1a88df22-b4f3-215a-1232-4e94cf4a8929@xilinx.com>
Date:   Thu, 12 Mar 2020 08:34:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582566751-13118-3-git-send-email-ben.levinsky@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(199004)(31686004)(426003)(9786002)(5660300002)(316002)(186003)(478600001)(8936002)(2616005)(31696002)(8676002)(2906002)(44832011)(70206006)(966005)(26005)(70586007)(4326008)(6666004)(81166006)(356004)(81156014)(336012)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3442;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6469fd73-9e93-4477-a35c-08d7c657c778
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3442:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3442ABA96068D5F86BAFC0EFC6FD0@CY4PR0201MB3442.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0340850FCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DevcRJSgv54RvOMYauZTkBZocq1cLJAKJbnrJq3gqrS68EQCvh5G6NptV8S4CCLY5n80q8Kc4d3aG46lkEgsmjGvctFAwSIJail5/9Aj1+Y/UcEZ1EAq3vISk4jCvpo9gTLayY8jkOr60rIXoeTW3BiBvwwS0vSrCfuZiv/H8EKrAtPrvhFduyLmKEkow21iwPsnRzFaNT4l8zDVWNRtHFHOSu1lJFu9k0OisHGen70cW1jtQFrQhzyzdYq7JISKIEhGC8ZqQS6UGbxaoCiY+sI0DS2kwynsqOOzEpfkIZpGct5US4TYKPD9OFcw8myd3Ff1BCKJoXZAEHlXgMh4H+5+oqHwQogAorlMAV0g1wUryMrdfXlIP/48kBqnHMVG8MMWDROMYSOjbDr4MX9J0ozjVj1AcSC1ci/JH8Sxvq7AjWi+4o+SGlt11dIQL0L78DjdFJQStvSkHD+6Vb4U3CoT5uA+ZHBxSAO7l4nc4Xusl3ne3I2S8/iG6Go1EfL3Tqo8Hf/BzHZhmDCJdjgV+g==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 07:34:20.5489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6469fd73-9e93-4477-a35c-08d7c657c778
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3442
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 02. 20 18:52, Ben Levinsky wrote:
> Add shutdown/wakeup a resource eemi operations to shutdown
> or bringup a resource.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 20e4574..486dcb1 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -692,6 +692,39 @@ static int zynqmp_pm_release_node(const u32 node)
>  }
>  
>  /**
> + * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
> + *             be powered down forcefully
> + * @target:    Node ID of the targeted PU or subsystem
> + * @ack:   Flag to specify whether acknowledge is requested
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_force_powerdown(const u32 target,
> +				   const enum zynqmp_pm_request_ack ack)
> +{
> +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
> + * @node:  Node ID of the master or subsystem
> + * @set_addr:  Specifies whether the address argument is relevant
> + * @address:   Address from which to resume when woken up
> + * @ack:   Flag to specify whether acknowledge requested
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_request_wakeup(const u32 node,
> +				   const bool set_addr,
> +				   const u64 address,
> +				   const enum zynqmp_pm_request_ack ack)
> +{
> +	/* set_addr flag is encoded into 1st bit of address */
> +	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
> +					address >> 32, ack, NULL);
> +}
> +
> +/**
>   * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
>   * @node:		Node ID of the slave
>   * @capabilities:	Requested capabilities of the slave
> @@ -731,6 +764,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>  	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
>  	.request_node = zynqmp_pm_request_node,
>  	.release_node = zynqmp_pm_release_node,
> +	.force_powerdown = zynqmp_pm_force_powerdown,
> +	.request_wakeup = zynqmp_pm_request_wakeup,
>  	.set_requirement = zynqmp_pm_set_requirement,
>  	.fpga_load = zynqmp_pm_fpga_load,
>  	.fpga_get_status = zynqmp_pm_fpga_get_status,
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index b8ca118..0a68849 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -82,6 +82,8 @@ enum pm_api_id {
>  	PM_CLOCK_GETRATE,
>  	PM_CLOCK_SETPARENT,
>  	PM_CLOCK_GETPARENT,
> +	PM_FORCE_POWERDOWN = 8,
> +	PM_REQUEST_WAKEUP = 10,
>  	PM_FEATURE_CHECK = 63,
>  	PM_API_MAX,
>  };
> @@ -330,6 +332,12 @@ struct zynqmp_eemi_ops {
>  			    const u32 qos,
>  			    const enum zynqmp_pm_request_ack ack);
>  	int (*release_node)(const u32 node);
> +	int (*force_powerdown)(const u32 target,
> +				const enum zynqmp_pm_request_ack ack);
> +	int (*request_wakeup)(const u32 node,
> +				const bool set_addr,
> +				const u64 address,
> +				const enum zynqmp_pm_request_ack ack);
>  	int (*set_requirement)(const u32 node,
>  			       const u32 capabilities,
>  			       const u32 qos,
> 

Please work with Jolly on this one. Based on her discussion with Greg we
should stop to call eemi ops from drivers. Take a look at
https://lkml.org/lkml/2020/3/6/1128

This will affect at least patch 5/5.

Thanks,
Michal

