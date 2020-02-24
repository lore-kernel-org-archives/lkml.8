Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B72C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3F320828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pmXsLciW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXKg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:36:28 -0500
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:28847
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgBXKg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:36:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laq8JCuWuSKdJtOX9nzSr7ak9dsNgZuf4HO8BGw/8fMdOpeYN0xfT0J2mW5c4GMoGWcKlKy2XrMJjN5y5AtRxPWbRiPbiBRcvuN5+2bBJVAsYSr+IshmboBEXrEri8SeChXCcgEMB3NCdZFIj+MD788e92PAaytMRz/1ddVHW1ZbWpp6em2K/ADgRjboY1b2VukoYoxet+UPaYHKVSugZ1WzUZzGSkeeew0SyKuBMSswJP1pl0P1rGVle1q+kTUIeUagpJhhKKsKkyficlmvEBqDw6d51ewnO38CLOcDGZj0v2i2JPiEARUEWuGpu1cY6+DU0Con4swYgeDi15GZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJUnJD05WfLX1peeQxe+uokUTl0I20TwFlwFA+Y5jE8=;
 b=IMsywlTu/7uWlEk8Cna5WDOtxl+9+f7fdttd7DTs9vJQVI3Ic1f9+5dUOsQmhB8/sD59AXFPKlHTIB451SEwYsh2BzeDbNo3CVtBQWyuT5sTWVeEI6c1+Z1MNaflnU8ljHP64GVfAVoPnoqyHS1DdOFHVbA52DFhUTeU6QnVWU8uzn97rMwAixskdLRhCSnPcBtfOh4SBQEE++xabPXEburmqAFF1tpOwrNC/6LzKr3Pm48rtwwcoMYrN+X8UQFpgZquDQdp8lTHOZFcdE8wP9rmnG8mMVD040nL9Sg/wE52PdtWP9wTE4he+iUYqyQGYzT0lQf3vEUBYCxBVC+wSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJUnJD05WfLX1peeQxe+uokUTl0I20TwFlwFA+Y5jE8=;
 b=pmXsLciWZp676rPaRl6GOVv007/uqSqA99fMJiTKATIIH82mW5vpkGtQxxX/0dhUCYGQpWmncrIdIw0HKnWIYij/vsFU98eMhGKA7SRb9TOTW25VhaCYi8Jr+pZYFbrbnnUZDUZt0gwVmLwRZINoccMWFV1B1TVUwb5sy5I261k=
Received: from DM6PR02CA0115.namprd02.prod.outlook.com (2603:10b6:5:1b4::17)
 by BY5PR02MB6994.namprd02.prod.outlook.com (2603:10b6:a03:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Mon, 24 Feb
 2020 10:36:10 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR02CA0115.outlook.office365.com
 (2603:10b6:5:1b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22 via Frontend
 Transport; Mon, 24 Feb 2020 10:36:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Mon, 24 Feb 2020 10:36:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j6B5t-0004Hi-RR; Mon, 24 Feb 2020 02:36:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j6B5o-0007Ei-OQ; Mon, 24 Feb 2020 02:36:04 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01OAZtac010489;
        Mon, 24 Feb 2020 02:35:55 -0800
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j6B5e-00077y-Uz; Mon, 24 Feb 2020 02:35:55 -0800
Subject: Re: [PATCH 1/2] include: linux: firmware: Correct config dependency
 of zynqmp_eemi_ops
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>
References: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
 <1578596764-29351-2-git-send-email-jolly.shah@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9a243e65-6f38-96c2-39ed-fc8391c997e8@xilinx.com>
Date:   Mon, 24 Feb 2020 11:35:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1578596764-29351-2-git-send-email-jolly.shah@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(9786002)(186003)(70586007)(70206006)(2906002)(6666004)(26005)(356004)(107886003)(36756003)(478600001)(426003)(31696002)(336012)(81166006)(5660300002)(7416002)(81156014)(8676002)(2616005)(44832011)(316002)(8936002)(31686004)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6994;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d86068-c289-4a27-2daf-08d7b9155d17
X-MS-TrafficTypeDiagnostic: BY5PR02MB6994:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6994E05AD0713B73573D2E23C6EC0@BY5PR02MB6994.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0BBVjvOc427VPPTcLPZpgZTfnolrKqDOIBdgCnXPayL7WdylvwRdfZ8LR9ktid0iO+yitruc4973aQmAMRW2pIa+txC0DhJIwMhQT1tPYNX6QeywbYICdhhuJGNhV4PQERf6Za5xuJrsGWCkxVhTmTMOLw7flC4G89JaTf/TJu0lF1L7D9Vah0gaapQkMx/mSYewHmqC4VsxzBUWdXpb2lPcdFG4asCA5JPWn7SAMg63l/hd596MG+omuSMKJuEyjav6aO+V+iopI01RKTKz0wAANv4ZA9J59VKnmnVtyTtMj8YJ1oY1CLTGRiCgNiTWL4hxDzyV14BGrZ2xs/wq/EDXWwR5gXV4vztVUGOmHIJv7u/pxLQ8MjP24kix2L8Yb2MyQkxeBcqlowSUcCZp9mX0UGOi7vWKPZ7d78e/M6yWkXqYfQarDafLJR5AhrOcvt7zdoKMNKTnk4Nd3lflI3H8Hx3AWq1cshj15rM09LxbM1u1XgarXzannDm5Q1j
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 10:36:10.2335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d86068-c289-4a27-2daf-08d7b9155d17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 01. 20 20:06, Jolly Shah wrote:
> From: Tejas Patel <tejas.patel@xilinx.com>
> 
> zynqmp_eemi_ops will be compiled only when CONFIG_ZYNQMP_FIRMWARE is
> enabled. So check for CONFIG_ZYNQMP_FIRMWARE instead of checking for
> CONFIG_ARCH_ZYNQMP.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  include/linux/firmware/xlnx-zynqmp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index e41ad9e..a50a30b 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -311,7 +311,7 @@ struct zynqmp_eemi_ops {
>  int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
>  			u32 arg2, u32 arg3, u32 *ret_payload);
>  
> -#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
> +#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
>  const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
>  #else
>  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
> 

I think that make sense to fix this dependency no matter if 2/2 is
applied. That's why adding it to my queue.

Thanks,
Michal
