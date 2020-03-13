Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBDBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 06:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7D42072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 06:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oqGm2n8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgCMGyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 02:54:23 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:6126
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbgCMGyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 02:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxKpc9GlyfhiAgaORe5eXegUJihdaS3EQ8ZWXWvpUH4aVVX6fHGhpLwJK2wA9LlJ/X2Mr6pgBIxOjkG78lwuH7jZKZmqxNhx9lgT0HHfhAZGKeDJ36GgOxPUumLi23uJHtVf4eZy9qYdYWtWmpvlvRSK0M9CZLeZXgoqFbgDpcNvjDoi8/dNJJXmbUxaYThX/hq/B+gkr3tIO1wtnCRKB3eMoNxFbCYGETageC1/mUdQcDG6EoeivCaGMWilUloY7ezLi3RDnLFf8cEudyQXe7SBFVqLVFAWdSl7fT+LK5WT9DP8hO0SSUJeD/L21YOCKmrOshpd9n6kAx0lPmEVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKILI7BeKKq2dfIrXgaDYGjKwjABiyLf950tcreGMZQ=;
 b=L3mHi4LgBHDBWLFazTKSPcHxuG1ARYxiFbAeN3G/bwI8bK2E0999vFkdQOORpxiK2ZATv6jbawJyaOBN/JHVVw2cSqFiThT/fef7ITexMJzpORonzsmPfCYOBqUBEeyDMFdXV+uG1sjLWlxUW6fXVp+U/fI+MgpoI7nB6jt2Uml17RF88I/vQI4qS+iwXtlfI3MaWp1tBZGGY8WUstV5s6Z52Fp25JYbrnjylbmLg7Y54TTrnLnSVLtIuQNXMrAVHGHwcA0i/syvM0OLh90BhFIfc9gD+VEXuMP9TzxQcgWFPcyQ9PxrPF9Ye/MZEtRrg9n6ayGt6ejF4haLfvOytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKILI7BeKKq2dfIrXgaDYGjKwjABiyLf950tcreGMZQ=;
 b=oqGm2n8UkrrxcXiQr4IgToGQtZiQvioG0+ItRb5uvnTr3CIla9iO9QaTBXCaHcQtYyp3jFlECAKJepWzU5jfkWam18sPjfrCStP4UmPRWC8Q6EyHpOPrpGCgLg4ZsUfyfrkgMZ3IfulI2vb15T4vZTpfbDEDS5/InHhwAqYUJrg=
Received: from CY4PR21CA0045.namprd21.prod.outlook.com (2603:10b6:903:12b::31)
 by BL0PR02MB4961.namprd02.prod.outlook.com (2603:10b6:208:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 13 Mar
 2020 06:54:19 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:12b:cafe::43) by CY4PR21CA0045.outlook.office365.com
 (2603:10b6:903:12b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.9 via Frontend
 Transport; Fri, 13 Mar 2020 06:54:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Fri, 13 Mar 2020 06:54:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jCeD4-0002Wj-Eh; Thu, 12 Mar 2020 23:54:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jCeCz-0004qK-Bg; Thu, 12 Mar 2020 23:54:13 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02D6s2kk023047;
        Thu, 12 Mar 2020 23:54:02 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jCeCo-0004nN-Gi; Thu, 12 Mar 2020 23:54:02 -0700
Subject: Re: [PATCH v6 3/3] arm64: dts: zynqmp: Add GTR transceivers
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20200311103252.17514-1-laurent.pinchart@ideasonboard.com>
 <20200311103252.17514-4-laurent.pinchart@ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <28092fc2-c226-7ec5-c2ae-31870e94e0c2@xilinx.com>
Date:   Fri, 13 Mar 2020 07:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311103252.17514-4-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(199004)(46966005)(26005)(5660300002)(31686004)(81166006)(356004)(47076004)(31696002)(107886003)(478600001)(2906002)(70586007)(81156014)(8936002)(2616005)(426003)(70206006)(44832011)(8676002)(36756003)(4326008)(336012)(316002)(186003)(54906003)(9786002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4961;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f668c398-b9e0-46e1-c3b8-08d7c71b5a55
X-MS-TrafficTypeDiagnostic: BL0PR02MB4961:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4961AD4D4C051B2043189645C6FA0@BL0PR02MB4961.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 034119E4F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUgsjgyohuBQn79K9dAR6MQGZJizvxZXrgq0fPU7AOvwPyO+LkZhF52pPOM/skePAB1ZwgQXzpOwcmLrR4KEEii2heFcsVTXfuFau+kpoJG2fLAzvfR40ZJz3HY8ztxqmKeOuSL2Pm89HMDSUc29lJlM02tHx/+uRHZV1qk6bIUa/1sAX6Uk0zve77UT3j7+bxrC5NSHwzHQAoZDFs7oSzUMwGrcGSjAd3bY+XI8D+8pCn0iXguxkjGgRXvpNGQ8sMqUObaR37VWiOBiEU6cG42LteJkgOXsP6FMCntLUVVAFxd4ekdmUeRGROoXzJOEnOr8c+RPdedBVgmK6+4n6JFtV+cRgbVMSNDlOizwxOZn28+sDVkSAX9AzLNf3xAiHcskl/HCFC1UoXyDzO/RnMcBpDciQBZ/bBW1QEMHYtyWypkPBEZa/LvKTBOZLm9IYhyJJYO466rHh/h9CmC3d3J5+QrYn4DqswAVJ4EOI5AamevPUKBi6azx0G+YjoJWUMDPx95V338eZCWoVXQ0zw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 06:54:18.8548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f668c398-b9e0-46e1-c3b8-08d7c71b5a55
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 03. 20 11:32, Laurent Pinchart wrote:
> Add a DT node for the PS-GTR transceivers.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 2e284eb8d3c1..5e06e4c19d94 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <dt-bindings/power/xlnx-zynqmp-power.h>
> +#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>  
>  / {
>  	compatible = "xlnx,zynqmp";
> @@ -564,6 +565,15 @@ pcie_intc: legacy-interrupt-controller {
>  			};
>  		};
>  
> +		psgtr: phy@fd400000 {
> +			compatible = "xlnx,zynqmp-psgtr-v1.1";
> +			status = "disabled";
> +			reg = <0x0 0xfd400000 0x0 0x40000>,
> +			      <0x0 0xfd3d0000 0x0 0x1000>;
> +			reg-names = "serdes", "siou";
> +			#phy-cells = <4>;
> +		};
> +
>  		rtc: rtc@ffa60000 {
>  			compatible = "xlnx,zynqmp-rtc";
>  			status = "disabled";
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
