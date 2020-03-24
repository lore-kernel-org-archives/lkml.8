Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17999C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEF22070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="bu18lbSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCXJzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:55:44 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:8970
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbgCXJzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:55:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMFZxlvaWirhDGrZ0kppFm/oAaCK+pK4H22HEQPLA/PL1cbhRpcsGQchHW7EkOnQQfcoZQHY4UnpsebOQROfXtfgpxFN2lBboTIPl+WaJJwVEgl2kiNbYSarFw/6YZaKk+vW4lzqPa3rYv7Y2eum2LQh7kzM76YyhnafE4HbYFV+didX1MnQ24X9THOark0JTUlw2MaTdFVJtEcJ6CudqdrFBIhUbDVq8SWJugtjMPDuvpfyQTQpS4LuhQLX1YFFjNOJwUxYvEnrCHAksdS4jFFFluCO5zkI8jxRIpM/HoRpYCbBoy3xUkVg4du5fjpfL58JzYeBT3DdPIecnWX0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2DlwpMY2c7koYLFYCwW7uIT3Rzv9xYqqT80+CZZCtQ=;
 b=gxXY6UbSvoT5GHEQFWNCZciMnKMBXeKmESYWxklMPaqfLB7cXzJVq80EkSZJOGdVPWcMo44lzWy09xVqtCC03CNqHaCG6KlVTjMpsRVsepWAGrRVeYxGvPBn2+uoLFhewr0fAtwoMgxHr5TBeqNLspUACwd326RqiSaJOmmxD8ZbN348GJOAvTvzBexutRtnKAdRyrzqF/NeFXDUruyTqIx7j3aVf7SOYMx4fndamvpYaCmavzBZksIlT7CZwYDSgVtRgcNwW3kPm2+3c8ky0RNwcl2wqs+62isLSMh+ayylUbDirMtloZRkRtTSebYRJsQxw8Sl05qR6RPQAdclXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2DlwpMY2c7koYLFYCwW7uIT3Rzv9xYqqT80+CZZCtQ=;
 b=bu18lbSmFIs60Rx3F4PQk+z3zYk0VgkXDKTTczwmeAW6/c7R6zVmAL+AtKjxdPV4v2RxTS7/1g36iCXePbEFt7KtwDjevNFX+PQimlLkgAaF/tRpkk0nrLX+KYVtnOgwmK0u0IpDe3g2eU9qcBGCCN/7xqX57zp0Pc82I/NdHdk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4332.eurprd08.prod.outlook.com (20.179.44.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Tue, 24 Mar 2020 09:54:58 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659%4]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 09:54:58 +0000
Date:   Tue, 24 Mar 2020 09:54:56 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6656: Use ARRAY_SIZE instead of hardcoded
 size
Message-ID: <20200324095456.GA7693@jiffies>
References: <20200318174015.7515-1-oscar.carter@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318174015.7515-1-oscar.carter@gmx.com>
X-ClientProxiedBy: CWLP123CA0157.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:88::25) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jiffies (54.37.17.75) by CWLP123CA0157.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:88::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 09:54:57 +0000
X-Originating-IP: [54.37.17.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1496e24f-4837-433e-e752-08d7cfd9699b
X-MS-TrafficTypeDiagnostic: DBBPR08MB4332:
X-Microsoft-Antispam-PRVS: <DBBPR08MB43321002EC45BDF6CCF0B334B3F10@DBBPR08MB4332.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39830400003)(366004)(396003)(6496006)(81166006)(2906002)(8676002)(5660300002)(6916009)(4326008)(33716001)(54906003)(81156014)(55016002)(508600001)(86362001)(44832011)(9686003)(52116002)(8936002)(55236004)(53546011)(316002)(956004)(33656002)(66946007)(16526019)(1076003)(26005)(9576002)(66556008)(66476007)(186003)(518174003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4332;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMMrpGi8VRpulHSLqmhnXfTTEC3vJJ9PAAhB0Gyd1jzHuiecWJI4XFFHAz9mew4eAP8w1bIwPqCiXy4Plu5BZjDpG8poQlS3kZWS1an4aIA5m1hkkW8l5eh99T8/aRDyt3C6+pj5fsW23EhJMYcIMRDdq+pEBAbKc50wpwqBwLuFQdvthgectLtwJFdkM2Hx1F8KqTILAFVCH9fXJXtS20cp1Vzz+sXAlmjdqh/X3zgFvXxeyUMF4D38+IX9g0npEDFIidBm6gAO6FWZU32KJsTiH0jusLMIy7kiJvdEdZlmxX8zEy79MZCLXn9x2GL7gj4HFWYpfjpFAJQIwfqQIH9PO/hgvxC6Wg5CH/Ks3Pwi1Jjly2AAnIeQizlJH6jbxnW3zYBtVHg0drrVAqDQI+iLxGgLGTwkZ7Qd5Hb6yTB36kWqUS0DNCjL0igtcEDem+74+L6F5AEAoPWmf6pnAxxs0bWHqFU4mGQ3Cl72dLqyndrqyQ4SrdxH2cDZ4Y4k
X-MS-Exchange-AntiSpam-MessageData: BbKWByMdk4h6NrDaLdc7TAbXvJT5DVVNB7IdzEC2JKbxvWHA/9qKrHXLCft8VNL5qT3LuUFcO/w3A451AZJ+DHsJC73BecZPGTUGg5W0lN7vcf9NtC/zYaEfVmpXyx0A3turFKUfd5Af3Fw15DM4Vw==
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1496e24f-4837-433e-e752-08d7cfd9699b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 09:54:58.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gB2Z2AFpFyHiwXsinPGWoo6zReYQfiVNzWWU0ogZZxJe+uiReS6kH0lI1qT04sFInKih7Vi63Ae1KqX41v6Mn90r0Pk40/fwlVanKqadwSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18/20 18:40:15, Oscar Carter wrote:
> Use ARRAY_SIZE to replace the hardcoded size so we will never have a
> mismatch.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
> Changelog v1 -> v2
> - Use ARRAY_SIZE(priv->cck_pwr_tbl) everywhere instead of introducing a new
>   variable to hold its value.
> 
>  drivers/staging/vt6656/main_usb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index 5e48b3ddb94c..acfcc11c3b61 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -23,6 +23,7 @@
> 
>  #include <linux/etherdevice.h>
>  #include <linux/file.h>
> +#include <linux/kernel.h>
>  #include "device.h"
>  #include "card.h"
>  #include "baseband.h"
> @@ -145,7 +146,7 @@ static int vnt_init_registers(struct vnt_private *priv)
> 
>  	init_cmd->init_class = DEVICE_INIT_COLD;
>  	init_cmd->exist_sw_net_addr = priv->exist_sw_net_addr;
> -	for (ii = 0; ii < 6; ii++)
> +	for (ii = 0; ii < ARRAY_SIZE(init_cmd->sw_net_addr); ii++)
>  		init_cmd->sw_net_addr[ii] = priv->current_net_addr[ii];
>  	init_cmd->short_retry_limit = priv->short_retry_limit;
>  	init_cmd->long_retry_limit = priv->long_retry_limit;
> @@ -184,7 +185,7 @@ static int vnt_init_registers(struct vnt_private *priv)
>  	priv->cck_pwr = priv->eeprom[EEP_OFS_PWR_CCK];
>  	priv->ofdm_pwr_g = priv->eeprom[EEP_OFS_PWR_OFDMG];
>  	/* load power table */
> -	for (ii = 0; ii < 14; ii++) {
> +	for (ii = 0; ii < ARRAY_SIZE(priv->cck_pwr_tbl); ii++) {
>  		priv->cck_pwr_tbl[ii] =
>  			priv->eeprom[ii + EEP_OFS_CCK_PWR_TBL];
>  		if (priv->cck_pwr_tbl[ii] == 0)
> @@ -200,7 +201,7 @@ static int vnt_init_registers(struct vnt_private *priv)
>  	 * original zonetype is USA, but custom zonetype is Europe,
>  	 * then need to recover 12, 13, 14 channels with 11 channel
>  	 */
> -	for (ii = 11; ii < 14; ii++) {
> +	for (ii = 11; ii < ARRAY_SIZE(priv->cck_pwr_tbl); ii++) {
>  		priv->cck_pwr_tbl[ii] = priv->cck_pwr_tbl[10];
>  		priv->ofdm_pwr_tbl[ii] = priv->ofdm_pwr_tbl[10];
>  	}
> --
> 2.20.1
> 

Looks good, however are we certain priv->cck_pwr_tbl and
priv->ofdm_pwr_tbl are always the same size?

What about using a macro for cck_pwr_tbl and ofdm_pwr_tbl size in
device.h? Or a BUILD_BUG() if array's sizes are different? It could be
helpful for future developers to say these arrays must be the same size.

Thanks,
Quentin
