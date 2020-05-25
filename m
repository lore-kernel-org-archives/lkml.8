Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8361C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A9C2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="eYXoJG2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389932AbgEYKvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:51:22 -0400
Received: from mail-eopbgr60115.outbound.protection.outlook.com ([40.107.6.115]:57990
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389484AbgEYKvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MserOo5mpJAGwkprPijWscKSId1DVdy06RXgZjEHGw1OD6aEOqSicndqkAKonZgyFatPN0MPb02N6j+kVugMurvz1FjwCW25SaWojVHegLUQqoAxIk6gWkCKim5bajTv2DJmXJ6z43m7oviO5lFOpxth/5LqBqG56RAAsc876/+kgthzSHdEpIUbsSDbhCGRgzQs/peCsCbuzk3caiT8RTHsDruMxzD52Q3lbezyw8RDIu539JZtjKYmswMjXeC4xTsDIs/IutF10BNsYafnexL3WMs3+nL2mYeKkk1kzJ5arde5KvDmpfvlUwri0E9RUpw/yL+N8YyF/npZ4F59Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uLLibSbdeJl7aLPki4L0hAEgH76HHgjQqjSA9lrkfM=;
 b=NhAjD0Z+qcRmoR0D8YJlMYF1QC/UfX659TPV7IZSG5yaeWhTf3jxGgwwVhS0k9erXXvmofWX4829AQSjY8Ie1eRIJFD4wPWTwFyVn9FpYYtKoKHuUPiSRnFPmTUYuObZ7tcJualIpMBZ0ypzIvDWZYDS40nDhnO0phyr2RtBCA/WhUUdDTxsMVaVY4d+38WMuYIFYoz/9P42mubUk+TAqkKSK09V8T8nV8eIvEWQ2cBVHiyw4kOBp3eHp4IInwfJQa9fM+bN47ejs/X8ZZ9erR60mSLBHSDxBCB8sjBSQ0wpnnwiK+IecSQDtRK10uvsknjWZYK2DMQVfISdX2dHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uLLibSbdeJl7aLPki4L0hAEgH76HHgjQqjSA9lrkfM=;
 b=eYXoJG2vsJdi5mUNDpXAsmCYm+dSWjkenqHuRcbtKxjLM0K9m6xBWgxIZZ3e2EGjnt+rW2rfWdGLEoXK5jdU5lUrn/P+X3EuFX6qEWDicmrxDaSvC7Q6JBEvDl9+ttUbhwsgVkQzXNDW8ukvIxszbQ+YCE3ShdlvGOtf5YaT4WQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5658.eurprd02.prod.outlook.com (2603:10a6:10:e2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 10:51:15 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::ccd1:96b3:48dc:c5d1]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::ccd1:96b3:48dc:c5d1%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:51:15 +0000
Subject: Re: [PATCH v1] mux: adgs1408: Add mod_devicetable.h and remove
 of_match_ptr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>
References: <20200520120122.67528-1-andriy.shevchenko@linux.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9ffd3d0d-46a0-ae1f-4884-76ed9b60124a@axentia.se>
Date:   Mon, 25 May 2020 12:51:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200520120122.67528-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:7:67::21) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (213.112.138.116) by HE1PR07CA0011.eurprd07.prod.outlook.com (2603:10a6:7:67::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.8 via Frontend Transport; Mon, 25 May 2020 10:51:14 +0000
X-Originating-IP: [213.112.138.116]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c2434b-2ff8-4acf-6ae1-08d800998c19
X-MS-TrafficTypeDiagnostic: DB8PR02MB5658:
X-Microsoft-Antispam-PRVS: <DB8PR02MB5658DDC3ABC97ACC71C89719BCB30@DB8PR02MB5658.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vejg4UbilWsALbvDAtCliq3Dbg/ixCnfn2lkBVKNejyqz3nNpFYjWa5+mlVNBuAQH2b0D5XMJl7mCxY4qYSGuCyT23gmie6/zyZ6OOpB2lqho6rKqb6F6sqYKC9F2f43lsG2Y/pnaTCS4uNzF4doQyAqCIwMqcaoQt3+hfMoXj4PXITwB5D1HWa1KXlSg/KDesJY132+uwe9G6wsJqYR5+3yAnATbkGeeUgocBM0VBU3V8MF7/RD5UILvceQHF00qNON8DZgqn7MNl7DeeHmAZgPWtTkhandIieOdpVfClXLddgOpSd9lDCKLizckj1pxizfyz9rao7j/77Ojw/qO2g0pfKfSmMxITtz/WcTNQLDlHcsbF2v3VQCI7uUDUmO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(396003)(39830400003)(508600001)(6486002)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(316002)(31686004)(16576012)(110136005)(36916002)(2616005)(2906002)(86362001)(16526019)(53546011)(31696002)(6666004)(956004)(26005)(36756003)(186003)(52116002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Cz7dLe5vuQdgiHRpC18bjce/gN7QDuLXWm0a7i7MIHzW2R4y39X/u+KJ/hdX7gs82SC0boLZCENbBG1TP9OPh1GdF9/682wf5iEOasfiZGv4lYouMN82zDMbqg7qqBi/cm2SHLlzsA6yKtQZU7mOYz0TFkfN3UB1W7XR0sBVV7O5UllJnvNEOs+oxVolwqdjDOeNh7Z6UOd5n9J4iQfWUKaBo++lesDdGGBDgCrLjuQ8VhqaKmRf5HkD+1wKWcXF9M2bNmPJO5c3W4HVpcM5rb8BdwB6Rk9PiPHuZco/fuk1YheemEvxXI+a5V5sV75iU+ANGSyvpdnfmOVp/U7FhrDnSn7F7Q3/50a78MZ3rwLMq1OflUBmuyMGH6vK3z8A22itAmicDk6dpQ3ZQjcJ2DQ5cQuo+Nl8cLgftFK9kWPFK8fYNnPHrCCTJuENcdz6PUu637ogCC21Hprjm+RSIfLH+3XV0Xj6jmWkOyLSN/Ojz5ou9GfMzlrX9CISYoVR
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c2434b-2ff8-4acf-6ae1-08d800998c19
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 10:51:15.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIo33YQZxeFW4xUU97ouD8k5jvTDxAiAxs3fIdG6lasr4y6TOyf65T4msLh1yJy8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-20 14:01, Andy Shevchenko wrote:
> Enables probing via the ACPI PRP0001 route but more is mostly about
> removing examples of this that might get copied into new drivers.
> 
> Also fixes
>   drivers/mux/adgs1408.c:112:34: warning: unused variable 'adgs1408_of_match
> as has been reported recently.
> 
> Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks ok to me, so it is added to linux-next. I'll let it soak there for
a couple of days and then intend to pass it on to Greg.

Cheers,
Peter

> ---
>  drivers/mux/adgs1408.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
> index 89096f10f4c4..12466b06692c 100644
> --- a/drivers/mux/adgs1408.c
> +++ b/drivers/mux/adgs1408.c
> @@ -6,9 +6,9 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mux/driver.h>
> -#include <linux/of_platform.h>
>  #include <linux/property.h>
>  #include <linux/spi/spi.h>
>  
> @@ -59,7 +59,7 @@ static int adgs1408_probe(struct spi_device *spi)
>  	s32 idle_state;
>  	int ret;
>  
> -	chip_id = (enum adgs1408_chip_id)of_device_get_match_data(dev);
> +	chip_id = (enum adgs1408_chip_id)device_get_match_data(dev);
>  	if (!chip_id)
>  		chip_id = spi_get_device_id(spi)->driver_data;
>  
> @@ -119,7 +119,7 @@ MODULE_DEVICE_TABLE(of, adgs1408_of_match);
>  static struct spi_driver adgs1408_driver = {
>  	.driver = {
>  		.name = "adgs1408",
> -		.of_match_table = of_match_ptr(adgs1408_of_match),
> +		.of_match_table = adgs1408_of_match,
>  	},
>  	.probe = adgs1408_probe,
>  	.id_table = adgs1408_spi_id,

