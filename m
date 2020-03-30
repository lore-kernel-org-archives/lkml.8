Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C983C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F732072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="RaEo5aI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgC3LqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:46:11 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:55387
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728764AbgC3LqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgg0FKwTadNBqDNLFZVC7jQPBhVTWaVWRhMxbRQlaFl84VGGpK0XX1KMEI0Bj6VN1s9AFFCYvIOeYE1FBP9ItDBVj9/Se47c2sjcIz4on8o2181SOmNsi1vtBYL7i2XJ+Wn5XMNJUlfTvWOLN0IwNCA9mE8tt5DJAf2K+FwFsPMJibfW7SIkdPKDpGUFgEFz9Wowd7Iz8rLBnavRfdLf3drZz8EhPdDJBcR0bMPB1uSSglWtRsumAn7F0NBr0QVBmsJhJNrV/XnDjR1wV99R4FBtNxGDETDHQTsqWCOZXmbg9aSvQJvMtVdtjBmvWty9bHlaEc1MbQSrqzwquuxQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1M9OIXFMvno7+qcD2ZC5RToymn/NcIiDGpLNH/06JA=;
 b=QhewnuipxHsTPQvIEB0nRT5cFjBiDiOnWLP4XQMfsIFtHCE+2zrlObwXXidENOKqvD59vaOB/ZINMFLWaZV81DoqTdCM3RnV9zo0ju9erDqnrxmYH+Qc8/G1XxgMcarXRGJ9gPtWF3FLNTmS9OJFa4a+OhOPdFTtJKzCqnIw8d1s3Gkn3kXeS6QYddFRdKmKj3wPK0G540/NkpdWGDBZ+4q5nRHSjWJY2Tg206UtoYIOiWNYDsGmS9L3YAcMU9F9W1Sjx+7e3FcC2zKUk8CRJyBzez2WzjaTrwYfybZs3N9RAcV7l8fr0Fzizw5oHjR0B5ucJLwjNSlKcvOl4AwRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1M9OIXFMvno7+qcD2ZC5RToymn/NcIiDGpLNH/06JA=;
 b=RaEo5aI9U9r6V/jWV6rODxqRDgsnXNiQqGbRgTY1w3Dd2bZC7Vtr0N1Jme7TYnvcFkwKtx0qUxETsPD8yMc0g4VDcKKwlidSQuluGVDvMG/2tw4urPYh6GC7xrNNuMfABhJAhLkflCBkpyO+eOrm/TopP94wy2KL2AUrchFXxHg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4789.eurprd08.prod.outlook.com (10.255.79.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 11:46:07 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659%4]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 11:46:06 +0000
Date:   Mon, 30 Mar 2020 12:46:04 +0100
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Define EnCFG_BBType_MASK as OR between
 previous defines
Message-ID: <20200330114604.GA52025@jiffies>
References: <20200327165802.8445-1-oscar.carter@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165802.8445-1-oscar.carter@gmx.com>
X-ClientProxiedBy: LO2P265CA0342.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::18) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jiffies (5.151.93.48) by LO2P265CA0342.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 11:46:06 +0000
X-Originating-IP: [5.151.93.48]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe282265-44d6-445d-86db-08d7d49feec2
X-MS-TrafficTypeDiagnostic: DBBPR08MB4789:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4789BFFA0F9A572C11F32B50B3CB0@DBBPR08MB4789.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4491.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(366004)(376002)(346002)(39830400003)(396003)(53546011)(33656002)(81166006)(9686003)(508600001)(6916009)(8676002)(55016002)(81156014)(33716001)(2906002)(86362001)(316002)(52116002)(66946007)(6496006)(54906003)(5660300002)(66476007)(8936002)(4326008)(186003)(1076003)(956004)(9576002)(16526019)(26005)(66556008)(44832011)(518174003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7293nycefwjs83W9fd0+ucNFCZ5xBbzwGhpBt8xvKzzfpJ407Pyh0JIcnXUo+0t3QMhJtYBKYYE+8y3cTYMBoFJ7jcghzkhpdZoVk1Zz/Qj4e+goFWO531DcKJRhhLxQSJgnvl8+GmpJrSYqOsCYaIUY7Xva7oFITKF21HsRuFNPDTr78HXZNc7hjHdrX8bXl0cAvxy7lOjzHgjvj7ochtFuscUe1UTwfE8aBQVeMFBveFGzvKDOQbXpFctEGnwUyTtw6XNBEKCHru6OYW3lrvoOItuYr1r1n1DFNvJtBaG4dK79nUdIiMRqpp2oGpEXUeKwf2Tyhpo3wTMnSgbzwRjLT0nTyLq5OviZevBsOSOQBzez1Lwqfy1yxL+J2Zra4aSgLzQg47ZAR3m8HfJN9Oe7byXiU3JBQl1sz9dEKGBHX8kgRsh40J5tuIDKyAltlH3BFuArIz1Ue+NRWOx7O+waX0V1WP7Kf9kDU1JT5URSlGNhUb3GGwa8hQkZa4V
X-MS-Exchange-AntiSpam-MessageData: zQJ6Z8rXJ2Lu/Drtc/iorheXtjMp1Oq8aSGaNaz0YZQEijpBIzgVx8zlOGtotyMShJUKy4MseLLKKh90iGnV4OgKVIjG9/ViC2R2OZUNRzkw0Z+UU54TlywfenIQyyH8YbJcj5C3ZrWs1VlnYig8og==
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: fe282265-44d6-445d-86db-08d7d49feec2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 11:46:06.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qsR7SR+f7k0noula9GyUxbkUS5h5i77UmXXviu+BS7OrUghoGCwG/1IM3ypeZN9xmQ4R0pei1DfPykTJ/Itw++1ublywNnI9Zrl3UuPdRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/20 17:58:02, Oscar Carter wrote:
> Define the EnCFG_BBType_MASK bit as an OR operation between two previous
> defines instead of using the OR between two new BIT macros. Thus, the
> code is more clear.
> 
> Fixes: a74081b44291 ("staging: vt6656: Use BIT() macro instead of hex value")
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/staging/vt6656/mac.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
> index c532b27de37f..b01d9ee8677e 100644
> --- a/drivers/staging/vt6656/mac.h
> +++ b/drivers/staging/vt6656/mac.h
> @@ -177,7 +177,7 @@
>  #define EnCFG_BBType_a		0x00
>  #define EnCFG_BBType_b		BIT(0)
>  #define EnCFG_BBType_g		BIT(1)
> -#define EnCFG_BBType_MASK	(BIT(0) | BIT(1))
> +#define EnCFG_BBType_MASK	(EnCFG_BBType_b | EnCFG_BBType_g)
>  #define EnCFG_ProtectMd		BIT(5)
> 
>  /* Bits in the EnhanceCFG_1 register */
> --
> 2.20.1
> 

Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

Thanks,
Quentin
