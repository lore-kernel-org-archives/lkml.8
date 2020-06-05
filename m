Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C20C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DDDE206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pplRLbuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFELHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:07:54 -0400
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:6134
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbgFELHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ0FcBYZBBRoK0w4futHpKkx6TzPBD5DO84+Q67f8QLkxOP/8YM6qbNBBYy0s6yEQXjGWjdfhZ8TuqTmKw2eAbjygqjps+3QvTOOa59bHcQ1E388HxcRCYOjKo+16jADZbTjmDMHTRQwKExnFQL522kN4u9ZEgTipRPOsVbPGPj0H9Vvk7jlaUlB8ibLviw1yWmKKAB3XZs+el048FAh9s5mV2HVPSdoDuZ51DVA9VlN0gnoGKpFFk1mF2Wq0PLnMowXWUkgvFc6Y5eBPaRFkthjEq4Rf/KjG+I9rzWR9Pg7qF9/nwUoUoeSplK0k/4iZHdHQsu2i02wwu111UUXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik0XCRDqVwwOuciP5ij4Sy+ot28ozVbQ7LZbXtfU+Lg=;
 b=FICFou71lDM2xRwHNCsFe//LKUMiCjq0XP/QWMlAzZfqShXv1P6dOhkbNshTpRlexawkqszakDIF/D5D+wMkzPtIxckhkQ9QH9hAYt+4F4yK0Uks7NmkpiUzxMZuk+NesRfz15K9F9bS5kZ43bZ83vQF06CCwFBxI34ieWVDR0JqAn0heV4pwySHAcrIkdSar/rZ7mcNCGQKPAN86lNav7uh0/j3CR2zfCn7JI9mqEZVstrXuYFzLRRQdbcgmpURLpoYJebAcfHHKtImgfR6vDXHMwmw/y9xh5a/cbc9djmxcF0rszFDJpHljBuNXb/WOseCNVHmGJiljYr7V0YxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik0XCRDqVwwOuciP5ij4Sy+ot28ozVbQ7LZbXtfU+Lg=;
 b=pplRLbuMxw6LagaibqlPsv9OlqBJ+etddK8cWuoVggeCdOmXC6flSLLF0jnCbTMXWe7HKvjFl/mmbkQIth9+2ZazzPK03t61fnZMjUZujtRTz30YLk/QYPx3S4DGNU56cdZqu9WAxWthZtsUjPaCxdgZZDcwaFuIlP13uf1wQ9U=
Received: from SN6PR01CA0024.prod.exchangelabs.com (2603:10b6:805:b6::37) by
 BY5PR02MB6258.namprd02.prod.outlook.com (2603:10b6:a03:1b1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 11:07:51 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::82) by SN6PR01CA0024.outlook.office365.com
 (2603:10b6:805:b6::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Fri, 5 Jun 2020 11:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 11:07:51
 +0000
Received: from [149.199.38.66] (port=45043 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jhABi-0000ej-RU; Fri, 05 Jun 2020 04:07:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jhACV-0007tP-5u; Fri, 05 Jun 2020 04:07:51 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jhACR-0007t2-Fz; Fri, 05 Jun 2020 04:07:47 -0700
Subject: Re: [PATCH] soc: xilinx: Fix error code in zynqmp_pm_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Cc:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200605110020.GA978434@mwanda>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <951de328-3647-ea49-ecec-1f0f98ceb4b1@xilinx.com>
Date:   Fri, 5 Jun 2020 13:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605110020.GA978434@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(39860400002)(396003)(46966005)(36756003)(8936002)(336012)(83380400001)(31686004)(426003)(186003)(81166007)(26005)(9786002)(47076004)(31696002)(356005)(2616005)(82310400002)(82740400003)(54906003)(478600001)(44832011)(110136005)(70206006)(2906002)(316002)(4326008)(8676002)(6636002)(6666004)(70586007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6d2e917-f5c5-4d28-2f0b-08d80940b069
X-MS-TrafficTypeDiagnostic: BY5PR02MB6258:
X-Microsoft-Antispam-PRVS: <BY5PR02MB62587C5F12AD9158C1173602C6860@BY5PR02MB6258.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYfliUgxGG6e7BW/A6Yg7frorBlDM2j8FUj/7aXR1PaMJBINYB+h+SSn65ikDOxcPLvizJbnzJiNSEbefA5v5q7aXwipafBways4hgy17WEvaJdqxJUUsM7fn013euGtD+3+T6LO86J0VpRPoP1DjegbuIX3EAkCxl4PjObGxtNb5y9wE9vYUjRiF4a3WuEbQLHPoXG+F+vdY5kePATYGrRlMRS6RVKNQfQxJuKmDaWD0VI1+sGXdYXW8FoRlfzV14L93pvxUuRkDQvw9j9XdSEwUfg11Yo+zeLfwg+Oba1jonYMp4/owVnNqrtWuBYKD6tVPGm9mIgf17DnyC4sg4/w0PKCN0pVgcM08ZJEPDTpJ6ECtN/lfQUs2ZVcr84Nr6WQFbuZRpNTc4OrbNT80soEJaQUyWyoeyL3k1MMlbvhr1j4Tj6BWgpKX4HdlO7d
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 11:07:51.5085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d2e917-f5c5-4d28-2f0b-08d80940b069
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 06. 20 13:00, Dan Carpenter wrote:
> This should be returning PTR_ERR() but it returns IS_ERR() instead.
> 
> Fixes: ffdbae28d9d1 ("drivers: soc: xilinx: Use mailbox IPI callback")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/soc/xilinx/zynqmp_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 31ff49fcd078b..c556623dae024 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -205,7 +205,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>  		rx_chan = mbox_request_channel_byname(client, "rx");
>  		if (IS_ERR(rx_chan)) {
>  			dev_err(&pdev->dev, "Failed to request rx channel\n");
> -			return IS_ERR(rx_chan);
> +			return PTR_ERR(rx_chan);
>  		}
>  	} else if (of_find_property(pdev->dev.of_node, "interrupts", NULL)) {
>  		irq = platform_get_irq(pdev, 0);
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
