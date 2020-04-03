Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B35C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F192073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sUtaWR8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbgDCIiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:38:12 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:11407
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727774AbgDCIiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:38:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEceZJLUkZfF7gIDoQsF8XGW6BbYW4MNoglGTwRLhKAzjsZzd1oGXNhHaokaJ9cOr/Fw+Pvmwpzgl4Z6Bm2Rl21rpTIeKdZV7XYI/39bIJsTBJT1VtCUritpPGi1Ijs6zwZfn+sIcShgXzh1zqEbWGmv2UF34+NcuA9w3wDjK/Be8CCJSJ7L0zPTv+HPkUq5GCZrGfzBNMOQ9ZJ5jV4ivqixif6k3T65nJVuC+mhuO2YU8mvcPy01OCv7EzJeMwU46avqRSWe3QS/lbBPVDYPLrY8gej86P4s7r2vwsdGitHlkb+aGNxjibag3F1uPILFGZK8k/wxmxsWJQ4GYq/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMI4f5p9Fg2FvGeGJ5AjpE1HNfKfZ5C35XgG80gsxWA=;
 b=CTPWGYBvwglmPjShtynRMIlWRg1gPzSuF7a2WH6lukQ5KA6yT/oslL8IrFjVGaYIq40epLFMdZFVlHCTcQKXG0SxjzkAlzN1wM0t1QMskj47KZX+3WeBcNyThrNcrBfWNZGSGf+yeoNuB4e+Ohi4TcClPeqhPILmaURl3899t6OZtsndHP+q1ktvC45rcER2BMStpSTELmJWvvSKTX7itHPA6VxP9GkUCccMaYsRJ+J+SEqdop0bVH0obTtidlzMdAS9HqIlNWW7cZ8C1P7Teg70vx9qNpw/7y6P+F3uYFgmevpj9zx7/TiDPwC+khvcetM2eiNOInD9cx0pkkxhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=huawei.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMI4f5p9Fg2FvGeGJ5AjpE1HNfKfZ5C35XgG80gsxWA=;
 b=sUtaWR8mM604L/41wFfjW55MWtDLagOvHtyf/7Dg+bbTh2FDZrFNpk+L2vzVS/jXZ5BD3P4f4ZlqmkDlzURKRuRj60sC56LONdkUSB+lUm/gDXKg9BB+vyczLQYLQfLhLSj13yer1LhYlZHEaSw9bZtaLzd8kvSui8MCWcUAI3Y=
Received: from SN6PR08CA0018.namprd08.prod.outlook.com (2603:10b6:805:66::31)
 by SN1PR02MB3824.namprd02.prod.outlook.com (2603:10b6:802:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 08:38:06 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::ba) by SN6PR08CA0018.outlook.office365.com
 (2603:10b6:805:66::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17 via Frontend
 Transport; Fri, 3 Apr 2020 08:38:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 08:38:06
 +0000
Received: from [149.199.38.66] (port=40903 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jKHpt-0003XS-Uq; Fri, 03 Apr 2020 01:37:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jKHq1-0006CY-Pt; Fri, 03 Apr 2020 01:38:05 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0338c0t8003496;
        Fri, 3 Apr 2020 01:38:00 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jKHpw-00069N-Aa; Fri, 03 Apr 2020 01:38:00 -0700
Subject: Re: [PATCH -next] clk: zynqmp: Make zynqmp_clk_get_max_divisor static
To:     YueHaibing <yuehaibing@huawei.com>, mturquette@baylibre.com,
        sboyd@kernel.org, michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        tejas.patel@xilinx.com, m.tretter@pengutronix.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200403083040.37748-1-yuehaibing@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <713789e9-c947-44d4-cd66-06373537da31@xilinx.com>
Date:   Fri, 3 Apr 2020 10:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403083040.37748-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966005)(9786002)(478600001)(2906002)(8676002)(426003)(36756003)(81156014)(336012)(8936002)(5660300002)(81166006)(2616005)(4326008)(70206006)(186003)(70586007)(26005)(356004)(316002)(82740400003)(44832011)(31686004)(6666004)(31696002)(47076004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a08502f4-06bc-48ce-2062-08d7d7aa54b5
X-MS-TrafficTypeDiagnostic: SN1PR02MB3824:
X-Microsoft-Antispam-PRVS: <SN1PR02MB382488974E27F00709180F88C6C70@SN1PR02MB3824.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0362BF9FDB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhTT/jLawP53B3IIBGurXmD91NG1GH6HAQavuWUzEfTpHqnDm5NJmMVnMrcRu6P0Ix5w8PGCz6l+C3gZl7iZeJaT9g32LpO9Z6hUZzleepJPqJdotH+ZmBcemj1vYHeOdvp7JQ3xG2UNYWERvxo5HGZ0YPlFssjlx9qZAT/E1hfnrknXUDAzi0OTZAHxTA25uCg8J5V9KjCKgQiluFO0UK47hRIwvsSyjxNQcBkk972UCALMdtbRs4CIO4vH6fVyTW/orHgxzuPjwj84V1ryoy7Bq5Gzc5UmKqYZng5/uFs414HZYjdExh93EApO8cBqxNvewgGezMYRsP8Z7ZfHPzDMC8JOFbAFnz8Y+Mg2yK8RWsdNkH5vOCYw6jDsSSRxlolIkDAO4yw71cE+EqAIAiYNckg4OLOIQoMpHNbNlwMZ/o65GaOcZveWMgluOs7RKukv1rbgNPvXGmShmFBNmC8Srn06ZX5OC38lVPkVQ075Be0FSnCgldMjwpGRPYDD99LblYp392ud6zkjHBZjqQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 08:38:06.1653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a08502f4-06bc-48ce-2062-08d7d7aa54b5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 04. 20 10:30, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/clk/zynqmp/divider.c:259:5: warning:
>  symbol 'zynqmp_clk_get_max_divisor' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/clk/zynqmp/divider.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index 4be2cc76aa2e..1e93a4d32fa9 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -256,7 +256,7 @@ static const struct clk_ops zynqmp_clk_divider_ops = {
>   * Return: Maximum divisor of a clock if query data is successful
>   *	   U16_MAX in case of query data is not success
>   */
> -u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
> +static u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
>  {
>  	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>  	struct zynqmp_pm_query_data qdata = {0};
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
