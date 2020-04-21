Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B2C55183
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1BF206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="G2DPsQ4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgDUNnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:43:37 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47376 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729001AbgDUNnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:43:37 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LDcBsM008116;
        Tue, 21 Apr 2020 08:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=TZjpA3nIt/1mHsv2pXhLRfQVIe+XpCMnDYtF9bvx6i8=;
 b=G2DPsQ4uSC0gpo2S3l8tE5pIwLiLJT7Zurbsbbxmg6gDxcIq+1wRcPGN1jiMUMcBIlZb
 IwQazrZlgODidktJwlu2SIBZkl6L77QkDpRCm1WrCJ7lG0pCGEa/Wz0eztwg+xsF2bJd
 UtiCbI6IVDSjtG+3ZafE3hk2b77K6ZMLRubvAjIYiXcR1Rdemfpcp9pw74TkkYbXP/je
 qZdDU4YQ9KyGg9bpWY0ylWtLTflYYTueJHgvmQTprxxykOq97JfBEM0Ctst2a7No3Sm/
 GaXTb1bnGJSPNIE77AxG7eg3o1ahoziw1H22jvslKg9bWM8w8MdtP/3TintUxIaH6l1n 7g== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30fxy4cyhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Apr 2020 08:42:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 21 Apr
 2020 14:42:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 21 Apr 2020 14:42:36 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6EE152C5;
        Tue, 21 Apr 2020 13:42:36 +0000 (UTC)
Date:   Tue, 21 Apr 2020 13:42:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <tglx@linutronix.de>, <allison@lohutok.net>,
        <info@metux.net>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: restore the CLOCKING2 register in resume
Message-ID: <20200421134236.GH44490@ediswmail.ad.cirrus.com>
References: <1587470535-20469-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1587470535-20469-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 08:02:15PM +0800, Shengjiu Wang wrote:
> The CLOCKING2 is a volatile register, but some bits should
> be restored when resume, for example SYSCLK_SRC. otherwise
> the output clock is wrong
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8962.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index d9d59f45833f..6e96c0c5ad2a 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -82,6 +82,7 @@ struct wm8962_priv {
>  #endif
>  
>  	int irq;
> +	u32 regcache_clocking2;
>  };
>  
>  /* We can't use the same notifier block for more than one supply and
> @@ -3813,6 +3814,10 @@ static int wm8962_runtime_resume(struct device *dev)
>  
>  	regcache_sync(wm8962->regmap);
>  
> +	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
> +			   WM8962_SYSCLK_SRC_MASK,
> +			   wm8962->regcache_clocking2);
> +

I wonder if it might just be better to make the register
non-volatile? From looking through the datasheet I am guessing
this is volatile for the CLASSD_CLK_DIV bits, which are
controlled by the chip itself. But the datasheet claims these are
read only and protected by the security key, and they are not
read by the driver at all.

Thanks,
Charles

>  	regmap_update_bits(wm8962->regmap, WM8962_ANTI_POP,
>  			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA,
>  			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA);
> @@ -3842,6 +3847,9 @@ static int wm8962_runtime_suspend(struct device *dev)
>  			   WM8962_STARTUP_BIAS_ENA |
>  			   WM8962_VMID_BUF_ENA, 0);
>  
> +	regmap_read(wm8962->regmap, WM8962_CLOCKING2,
> +		    &wm8962->regcache_clocking2);
> +
>  	regcache_cache_only(wm8962->regmap, true);
>  
>  	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies),
> -- 
> 2.21.0
> 
