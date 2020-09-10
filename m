Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE39BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746F920672
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NiIn+b5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIJGut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:50:49 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:46945
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbgIJGuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:50:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHPQkjBun79k2llTcPcfdZXQMId5p+e/f5j8vGbjlFDVIqYWEJokZf0dUCjh9fqBn2OEEW2oDh0wGiYv99j1HUu6gKwVmrwHhDLPvdPpMoDo5A3S+HQ4GQLpWdDuR8dajpxQ5Jn106Ryjj672LBJ7rNJHc6/Mco288d9KG0bHGILSUB+D9jQ19zg3gUd5+AJIofkUwh9/14Sap9vEfkA6dDPINwrI8L6ZfLJ/okuYF9bzF0D2XDk+gxEWOzGjQpYXs4f1aXhJx4edT2VjlBFom+5iZLNaYfJg8IkOyeHtJsYg5oNoBCOC+zifKdQS2m5nLD7MWb0KXrBgrvaDMJBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaC+8X5CUk+bC1U9+zJgTCcscrYcjAAteV6+egZmcJ0=;
 b=Orbd73KSfoJPjQGhcvR7SY6KSMCYC8sqj5dS1JGbHlBIoZkliCWmb64AZsLS40Y/EL1p3gi/Lvt5IWLrajI9QB8utttjV66zc8tyFichCk0Fmv5IopbPgqQh+h83X6KLxrAX0gL8qSgVlnI5V1eukhQc16e79c+6ggKhQ51twAfSuxjCIOa+dtWk/SgM2TH5db4rxUtJyxucxOTPV9rukTkuDAdDXj1mQuONCCFhQ1YKHifLNbaBoCRXex4IRzB8Pq09Ezu4YybjVKoGfxIeKvxxMAfSLsPSXfbw80tSfiDRpJiShClX7DNf8rsHxntylKP6tvxqtJ8P3tjgLI1jjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaC+8X5CUk+bC1U9+zJgTCcscrYcjAAteV6+egZmcJ0=;
 b=NiIn+b5Z1bfH0xLkiENzWiw8AHZ9MUy9/z9rZ6SS+WbtCaU9eW9/TZm9qDiELBbyYxvcpENDvqdrhpLZ+sEPDPdG2usKRwR37GwspGErOtxnJ+2LBxWy+kJUGws48cBeQ/T5DNSaLifBMf2AlT+swta6K28UbGtNTyaecxhxLag=
Received: from CY4PR22CA0087.namprd22.prod.outlook.com (2603:10b6:903:ad::25)
 by DM6PR02MB6528.namprd02.prod.outlook.com (2603:10b6:5:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 06:50:10 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::2c) by CY4PR22CA0087.outlook.office365.com
 (2603:10b6:903:ad::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 06:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not
 signed) header.d=none;linaro.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 06:50:09
 +0000
Received: from [149.199.38.66] (port=37571 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kGGP2-0000tU-Bf; Wed, 09 Sep 2020 23:49:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kGGPJ-00023f-51; Wed, 09 Sep 2020 23:50:09 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08A6o1gV011913;
        Wed, 9 Sep 2020 23:50:01 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kGGPB-0001kb-6J; Wed, 09 Sep 2020 23:50:01 -0700
Subject: Re: [PATCH v2] drivers: soc: xilinx: Call InitFinalize from
 late_initcall_sync instead of probe
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        Arnd Bergmann <arnd@arndb.de>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tejasp@xilinx.com, jollys@xilinx.com,
        Rajan Vaja <rajan.vaja@xilinx.com>
References: <1599693000-25641-1-git-send-email-amit.sunil.dhamne@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <ac2ab6d1-69c9-34aa-6c25-588bacc78002@xilinx.com>
Date:   Thu, 10 Sep 2020 08:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599693000-25641-1-git-send-email-amit.sunil.dhamne@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec9ad6a-86af-4d4e-9d5e-08d85555c25f
X-MS-TrafficTypeDiagnostic: DM6PR02MB6528:
X-Microsoft-Antispam-PRVS: <DM6PR02MB65287CE687D50815509A805BC6270@DM6PR02MB6528.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ID0mS7UC9oucF3tOgewGopTf/bC0wXq7h0dLKCQ+QDMCYm5Nw1ST+ttZl3iFxrRJI0SeKlXUoiOSP3f4SV7IE6J2cu3FbWyeZAFW7qD/ImpA3LKRg/nartzkhZz4okx9q9QbctJpFj53AMgbgtU3k5QDhhqMKsG5rd7sHUfGZFdGd0XZ2h/um8og4BQs0XGngwxKL4JzutXUtT5zVi3NYTOZh3p3A3DRUn3u5lV8QLAwHtle5Bt8i0XBpMQE/ArM1MmpsA7UR8XOEWKg59i973knpz3MZUXwrGdyS6W/5sz44jedoQ8YLR7UyEbRa8IQhM/PZV9L48nmN32IBF2YCwLbYAj7wDKr19xQeBQ3S9/wFR0+hYpS9DFATWsYm2aUdUts+V9YVsOhXsKhwOvemtoxuVH2yhqcjTeTiMR9C7a5CG434+sTr7lhnwceJ7NOU17PgGe0nfN98mV4PAoIkA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(396003)(46966005)(8936002)(5660300002)(44832011)(186003)(31686004)(9786002)(70206006)(356005)(70586007)(36756003)(63350400001)(336012)(7416002)(2616005)(426003)(83380400001)(478600001)(316002)(82310400003)(82740400003)(47076004)(107886003)(6666004)(110136005)(2906002)(8676002)(31696002)(26005)(4326008)(81166007)(42866002)(921003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 06:50:09.4407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec9ad6a-86af-4d4e-9d5e-08d85555c25f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 10. 09. 20 1:10, Amit Sunil Dhamne wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Initially all devices are in power up state. Firmware expect that
> processor should call InitFinalize API once it have requested devices
> which are required so that it can turn off all unused devices and
> save power. From Linux, PM driver calls InitFinalize to inform the
> firmware that it can power down the unused devices. Upon
> InitFinalize() call firmware power downs all unused devices.
> 
> There are chances that PM driver is probed along with or before other
> device drivers. So in that case some of the devices may not be
> requested from firmware which is done by genpd driver. Due to that
> firmware will consider those devices as unused and firmware will power
> down those devices. Later when any device driver is probed, genpd
> driver will ask firmware to power up that device using request node
> API. So for those devices, power transition will be like on->off->on
> which creates unnecessary power glitch to those devices.
> 
> To avoid such unnecessary power transitions and as ideal behavior
> InitFinalize should be called after all drivers are probed. So call
> InitFinalize from late_initcall_sync.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> ---
> Changes in v2:
>  - Check for compatible string for zynqmp or versal platform before
>    calling init finalize.
> ---
>  drivers/soc/xilinx/zynqmp_power.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 31ff49f..22d2d2e 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -178,7 +178,6 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>  	u32 pm_api_version;
>  	struct mbox_client *client;
>  
> -	zynqmp_pm_init_finalize();
>  	zynqmp_pm_get_api_version(&pm_api_version);
>  
>  	/* Check PM API version number */
> @@ -246,6 +245,23 @@ static int zynqmp_pm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __init do_init_finalize(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> +	if (!np) {
> +		np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
> +		if (!np)
> +			return 0;
> +	}
> +	of_node_put(np);
> +
> +	return zynqmp_pm_init_finalize();
> +}
> +
> +late_initcall_sync(do_init_finalize);
> +
>  static const struct of_device_id pm_of_match[] = {
>  	{ .compatible = "xlnx,zynqmp-power", },
>  	{ /* end of table */ },
> 

Arnd: are you fine with this way how to check that it runs on zynqmp or
versal?

Thanks,
Michal
