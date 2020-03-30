Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F84C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D30A206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="mMNQ2cmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgC3L7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:59:19 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:58953
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729996AbgC3L7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g06D6TrC7BZZbErCwJeuZS8J9BGYeu1HcMN27ux2n+9h517PsMojMJgqJ5SKU7ORB3WdihnMx//sfcxmyC4ZbUawc6IBNNA9+14vsEF21jXsHDDqR279Bq4NSYODpZPUjVoM5kaLURmExS6P9MIoLx6w/GSG2JUQL0XkWUFzx3S9sVWbYVnVc7Ocn6RcWAd7T4/OQYwI6lNucARQ0VzTojYs6JxLXScmLX4t7zv8YelZsk1nSukgoG1T+UE7NeFRTRJqKUcndXs46ngg+jUbxKCcaV5UloKOSJ7X0OpTrhd2tm0vtzRTEfuny4KDH1xJ+cco/QNoDtwhWq/phh4K5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI+RPTYRIvmqmDw1gIozF1av3zgVr86FDO82D4cY3yw=;
 b=ToQeTvBBs5OXwO1603QZsuOXJhpgWhsxWEN7CYNeQR+XIRoo3zPvr9sveDvGn8i7heR1/8SGBPxTAVZkNvc01/QS5RIz2+72iuH7fTrEegqmDfaagPlfgYVocPpsbMVrGkVaNUjDosSMx4UZYp2+sij7lrv1d+fRr7Hodjg8JDyqYmUji7gPGW6eUxyUCWbRfmtSlVFe4/dgyyE1DprtGuwZ9tO8hCNnwVkX/vuGm2sxvrBvgarjUlV9xt1bQRtLr8iTzb+0cv7xPdS3P1Hszj4S+RGxFSq4zi96CDCQlhMY8ogldoZ2JnPRQ4DFTYnaMHo3H1huaf2YIb/ly5heCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI+RPTYRIvmqmDw1gIozF1av3zgVr86FDO82D4cY3yw=;
 b=mMNQ2cmu+o65BO1wbVmbElOOx9Y64QRVK9GN+MVwoAtuI5yG7GI0rUtaEHUsOPJj4DmyhdTY5VVXRaNwlKZY2SkFvo33BJ4ecpoqedAovN1k/JVKA9BABHJpph2nJcgkX53J/RjJdFvIp8bhtgANC1r+gznIzyRhPxgGJ0eDBDs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4395.eurprd08.prod.outlook.com (20.179.43.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 11:59:02 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659%4]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 11:59:02 +0000
Date:   Mon, 30 Mar 2020 12:59:00 +0100
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6656: Use defines in preamble_type
 variables
Message-ID: <20200330115900.GA60146@jiffies>
References: <20200328141738.23810-1-oscar.carter@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328141738.23810-1-oscar.carter@gmx.com>
X-ClientProxiedBy: LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::26) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jiffies (5.151.93.48) by LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 11:59:02 +0000
X-Originating-IP: [5.151.93.48]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c16998da-1ca9-4ad2-67ac-08d7d4a1bd29
X-MS-TrafficTypeDiagnostic: DBBPR08MB4395:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4395597A12476F8BC8FB1C16B3CB0@DBBPR08MB4395.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4491.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(39830400003)(346002)(396003)(366004)(136003)(376002)(81166006)(44832011)(81156014)(33716001)(8936002)(33656002)(1076003)(8676002)(2906002)(9576002)(26005)(6916009)(53546011)(5660300002)(52116002)(6496006)(16526019)(956004)(186003)(66946007)(66556008)(86362001)(66476007)(55016002)(4326008)(316002)(508600001)(54906003)(9686003)(518174003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVika2czmhQnze47bOHOAwm8pxltNrJHxdqlExPgt5fvM3hWDqwKAy5XXnNvvlPs6CJG1kmhrvOvxUwqPYPIRTWeldY46RYzEUjtAtMgoYsOjYk5+FybPMOmVjQOiXtTuL+crccqiL8ygtdlFfnEdaeh+wk9XmmRUK/5+LUvxjU8iGIN3B6DXsffYsgHERKCP0e0OQv/GpMq4RjOIXMCVf5ILpdPWY6ew9UKB/nYg1YWSGc7Wb+JQA5PQtzST+5F6nr4b3JeA8K1jN58lycrhOOHZ/kng3Te+2FxV1/bQp/PjxeRTLjnzZ8psFfxoljeEQeRCOwKRKPFZYnoZAZTz01/tCn2D7w1kCJ2IXD0YkG8rlBoPtfpWehCiaVkBVSMhcJpZnHyAtFEDHp6VXA2UxbN3lMG27RrJvmSW7jahkKreSsix4gg2Zlx3/0D2DKFH4R0Y2dUIuP7ZfS6Cpwag/EvyQkn0r96ExuYlLhHLzcB266yKbVXnsCesXotTToT
X-MS-Exchange-AntiSpam-MessageData: 5ncxgJmQi3rB9/qE300aVtmPpaiaLkKqIQyNHo/qlhwii8r7zAdpADckegsJ/fce6O7Re9pTzSSiP19COTiBUF340uuL9ghOzpPR0vN78NHas+xQ3oShtwBCW2uvzFXueNXJjjQUuWHbQQBq1pPnNw==
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: c16998da-1ca9-4ad2-67ac-08d7d4a1bd29
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 11:59:02.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmSvzEfnjggt9yii4/XNX6VmNiOttP7i4FLnUFKabp3O65qMSioV+XU6lrisP41WbLl53P6Eb6IpLhe1wsaRgWynfLcuR/+wfVC4rBMWSvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/20 15:17:38, Oscar Carter wrote:
> Use the PREAMBLE_SHORT and PREAMBLE_LONG defines present in the file
> "baseband.h" to assign values to preamble_type variables. Also, use the
> same defines to make comparisons against these variables.
> 
> In this way, avoid the use of numerical literals or boolean values and
> make the code more clear.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
> Changelog v1 -> v2
> - Spell checking correction in the changelog.
> 
>  drivers/staging/vt6656/baseband.c | 8 ++++----
>  drivers/staging/vt6656/main_usb.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
> index a19a563d8bcc..9bbafa7fff61 100644
> --- a/drivers/staging/vt6656/baseband.c
> +++ b/drivers/staging/vt6656/baseband.c
> @@ -142,7 +142,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 pkt_type,
>  	rate = (unsigned int)vnt_frame_time[tx_rate];
> 
>  	if (tx_rate <= 3) {
> -		if (preamble_type == 1)
> +		if (preamble_type == PREAMBLE_SHORT)
>  			preamble = 96;
>  		else
>  			preamble = 192;
> @@ -198,7 +198,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
>  	case RATE_2M:
>  		count = bit_count / 2;
> 
> -		if (preamble_type == 1)
> +		if (preamble_type == PREAMBLE_SHORT)
>  			phy->signal = 0x09;
>  		else
>  			phy->signal = 0x01;
> @@ -207,7 +207,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
>  	case RATE_5M:
>  		count = DIV_ROUND_UP(bit_count * 10, 55);
> 
> -		if (preamble_type == 1)
> +		if (preamble_type == PREAMBLE_SHORT)
>  			phy->signal = 0x0a;
>  		else
>  			phy->signal = 0x02;
> @@ -224,7 +224,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
>  				ext_bit = true;
>  		}
> 
> -		if (preamble_type == 1)
> +		if (preamble_type == PREAMBLE_SHORT)
>  			phy->signal = 0x0b;
>  		else
>  			phy->signal = 0x03;
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index 8e7269c87ea9..dd89f98cc18c 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -99,7 +99,7 @@ static void vnt_set_options(struct vnt_private *priv)
>  	priv->op_mode = NL80211_IFTYPE_UNSPECIFIED;
>  	priv->bb_type = BBP_TYPE_DEF;
>  	priv->packet_type = priv->bb_type;
> -	priv->preamble_type = 0;
> +	priv->preamble_type = PREAMBLE_LONG;
>  	priv->exist_sw_net_addr = false;
>  }
> 
> @@ -721,10 +721,10 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
>  	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
>  		if (conf->use_short_preamble) {
>  			vnt_mac_enable_barker_preamble_mode(priv);
> -			priv->preamble_type = true;
> +			priv->preamble_type = PREAMBLE_SHORT;
>  		} else {
>  			vnt_mac_disable_barker_preamble_mode(priv);
> -			priv->preamble_type = false;
> +			priv->preamble_type = PREAMBLE_LONG;
>  		}
>  	}
> 
> --
> 2.20.1
> 

Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

Thanks,
Quentin
