Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C135A221ED
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JBnGPrx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgIKGo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:44:28 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:42306
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgIKGoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmbUvHJXfTr6YBaiVQtrZ79i+Nhujdn/T3wRNRBFE30zlRklbIUfY2gm/0SeGo7UMSXXz2mBVrgNBmwIKYP2YI+d88HoH7CKqJmTqs5hkNHgZlpNnZlqMu09cn6QBqykG6KtlJDd0qS+Z0+drmPA6IkzY6TLAg3VW/ZDQOf8oXDm28C2VywGhiAhSXSWBo2BSwqZ0gqnVPWIWCprRwGa5SRcJQrv6Juqppuq3hJbe+A/5/yHrSLMIOGtabh3d+g+Cd6vqEfKWfahFU/i4noMc4IjLJvZOvuTlrRVEkNrGWT712ptY4ugfjrG4wMb8RjxXyoPx4DufgaVNeoveYyyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJzZ/9YbL0O3uKaemp75O9OAmIIvD7yeO812/nVN3Fk=;
 b=g+1iluJPfrPx7bKb5iOZzEmJ8559yxOYOkwXxFLBrfNgfIxmkoXbcFs3yEd0asiCetGEui5E5AbgJgdz0/4/6Q1QEtVCwf5sSw+JVs4Ft2FWFHRidtpyLFj5KavqqtrmGaLTL4f9ek48EQk9lXqtKwunJjt1kYqHCirXtK+7osRarEdjQaiE/zuDVrzCRTojTxuqk8d+At6J3rF0vMeTGNvrzpGAECOLXDtx0YdvnzFI6+162yQxA3K5HIl/yASGoOYEm7jYM49CKuShLW2Fq37TYlWDUl+bdZSfVUttkjs2qwWi8Xq8cT+3T3AthD9RStG4xWVR6WVoRp7j5csfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJzZ/9YbL0O3uKaemp75O9OAmIIvD7yeO812/nVN3Fk=;
 b=JBnGPrx5gHq6aic9Qk4j5Rku9ighRIXEeNZNvKFO2aQNb3GZowC6Y/6X61hAfwOeVBEq577uD9ronmJh3Gyc9Nso5a/I8SC+K6v339Vuxpo50H8h6MzGAUYfqxWC4i24XWQhAfSpPxDKBxZHn8CWnPfobiVaipZmzTJG7L5y30Y=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB5263.eurprd04.prod.outlook.com
 (2603:10a6:803:5f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 06:44:13 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5d66:84a7:26de:67c3]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5d66:84a7:26de:67c3%6]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 06:44:13 +0000
Date:   Fri, 11 Sep 2020 09:44:09 +0300
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com, agx@sigxcpu.org,
        l.stach@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] drm/imx: fix unused but set variable warnings
Message-ID: <20200911064409.7dyuda6f6uxglmwa@fsr-ub1864-141>
References: <20200911014414.4663-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200911014414.4663-1-bobo.shaobowang@huawei.com>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AM3PR05CA0152.eurprd05.prod.outlook.com
 (2603:10a6:207:3::30) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141 (83.217.231.2) by AM3PR05CA0152.eurprd05.prod.outlook.com (2603:10a6:207:3::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 06:44:12 +0000
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7cd9684c-2cee-4c26-3790-08d8561e1822
X-MS-TrafficTypeDiagnostic: VI1PR04MB5263:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5263C43B5F2042CA539B82F0BE240@VI1PR04MB5263.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iecPtqOpYP3ygfBp+1E1qkYoWBaQR0xnYUevBg1gaTjG7/cowy8pbNha+mTRJypHoAmq8jTW5A3021/PY6Nv/UsGewaF+rSCIV2HkrLw53j/6zflM5RVrys6fBDT4R+e/aiQpLWKt6DDRvuAqJrxSCfD9xbZbmeXZzPG9ZNwWUw8lzTny2WOVR8wEEPCgrudHmqJvv2hsY8mrF8I4v7m/ePmHv7Sfn7BzT3UqbGouXSB9E62Ggn+VBuYql/yDX7OsckWDPRywqPQc5MKUQIgyc9NPjp48u9qfHXBzYPzZRy8mDEft4B0RF+eNsRd1BFzNZ+0tZuNZe97jbEC5MbEYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(86362001)(33716001)(4326008)(6666004)(52116002)(6496006)(8676002)(66556008)(6916009)(66946007)(66476007)(2906002)(8936002)(316002)(26005)(186003)(16526019)(5660300002)(83380400001)(1076003)(44832011)(956004)(9686003)(55016002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eSGNXIXRfn27q7+qjctEBMH1OhZlf6T/r0SN+kiWTgujoEyMFjQ3W0rZYNziY/3qN2YF94llc5U/WDV7/5fWI/Cs6mgYLevzGWps11/bDOYHfszYRvrAZJHscYt5BtI6fdNPtGzrhFxmkvEGFtM3XGnFof0SKDkOKfNH5lsMyVaE/lIEvn0f01gdp0h/EZqS866Fxz5j9ekodNT3FjSs1RrzCT1H5IyaInJeTi5dlNP+9BavOowsYl5ImvL9uMFnSdIHFvhYaeP9r148koEFDsvMy9rAhFpGg4kKmoBZDd5o/VWS0utqyTaGDJeW+3JGZx3eGhXjwxB/+4/Bp/C3uC8c3grx1ofT2cH81ew53u2XyldZL/agxTL2X2nNKsxEdx7BNoGAYV4IyrWrlZTk252HWqHclZjlj5QWjxKQh345NnR7kC3hjCX0Kj38//FN+3mB+g24lBikm+20TT0JQjuaw+LUGTTWQdIOrNl6SzjS/ip3k0pE2juP+venGYXJeFkc2Z9dazPI7X4ZW8l+qOLcxvh/M0DiT+sJmQotvCICLkumxmqq4qUOkv1kDwnrwGQKym5DFEIK6ZjQmcf8fmJz+rDNURWpl5VTYrrq3Iz9De+EIum+F5w6SO8U3QchbwK4x62870CjqEihPpzjUQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd9684c-2cee-4c26-3790-08d8561e1822
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 06:44:13.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm61WIrkb5Gr+Q+rZQia1ZPDS2VYpC0sIhm8IRHT1JaGkWH6Dt7bohjGjxX34inYGkJMUBa1M+a7M5+drH3IKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 09:44:14AM +0800, Wang ShaoBo wrote:
> Fix unused but set variable warning building with `make W=1`:
> 
> drivers/gpu/drm/imx/dcss/dcss-plane.c:270:6: warning:
>  variable ‘pixel_format’ set but not used [-Wunused-but-set-variable]
>   u32 pixel_format;
>       ^~~~~~~~~~~~
> 
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

pixel_format will be used in the next patches that will follow the
initial one and I probably forgot to remove it when I split the patches.
But, I guess, we could remove it for now to make the bots happy.

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

> ---
>  drivers/gpu/drm/imx/dcss/dcss-plane.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-plane.c b/drivers/gpu/drm/imx/dcss/dcss-plane.c
> index 961d671f171b..e13652e3a115 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-plane.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-plane.c
> @@ -267,7 +267,6 @@ static void dcss_plane_atomic_update(struct drm_plane *plane,
>  	struct dcss_plane *dcss_plane = to_dcss_plane(plane);
>  	struct dcss_dev *dcss = plane->dev->dev_private;
>  	struct drm_framebuffer *fb = state->fb;
> -	u32 pixel_format;
>  	struct drm_crtc_state *crtc_state;
>  	bool modifiers_present;
>  	u32 src_w, src_h, dst_w, dst_h;
> @@ -277,7 +276,6 @@ static void dcss_plane_atomic_update(struct drm_plane *plane,
>  	if (!fb || !state->crtc || !state->visible)
>  		return;
>  
> -	pixel_format = state->fb->format->format;
>  	crtc_state = state->crtc->state;
>  	modifiers_present = !!(fb->flags & DRM_MODE_FB_MODIFIERS);
>  
> -- 
> 2.17.1
> 
