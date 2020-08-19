Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C807C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0522078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iFEjSocD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgHSP6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHSP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:58:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4380C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=x24NZppAJHfqPN2MSE73qp+mE0/F0S4tWb1V3F3E2Oo=; b=iFEjSocDW2e6AhNyXzVcaqizOt
        AwwHtAHkBArxJ3KcpJKPUq+1ZMG/CNfRERQkH7X5EL7MOF+336LapTIzaw2FIUw0C1NPZczjHersZ
        KOuWP/g9uFkVlvEn+vbKdDbhb5/VU4Nylh3v71EIB/WBhvcpDOU8Q1hwDUONZ5t5TM5HIkc7HCbIt
        RauuOUaMG/xArIv3HMhy/shMqLZ8D8ldRjcXyo1iY4QYEkAas3sJ8eSK2gykh9xRPsqVq26uA1Y3g
        GnCiLLY2/Cpl9KYxhzjlb0jAluvfcFI73Wq8jdmMBBSFI2962cYNfk+6HBxWi+TBWoN9CTBkKEChI
        p3C+okag==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8QU9-0001XB-6B; Wed, 19 Aug 2020 15:58:45 +0000
Subject: Re: [PATCH v4 2/4] drm/mediatek: Separate mtk_hdmi_phy to an
 independent module
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>
References: <20200819154421.7013-1-chunkuang.hu@kernel.org>
 <20200819154421.7013-3-chunkuang.hu@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eec33300-f921-03d1-5bcf-788e4e2ce342@infradead.org>
Date:   Wed, 19 Aug 2020 08:58:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819154421.7013-3-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 8:44 AM, Chun-Kuang Hu wrote:
> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
> index aa74aac3cbcc..ca3cd871a350 100644
> --- a/drivers/gpu/drm/mediatek/Kconfig
> +++ b/drivers/gpu/drm/mediatek/Kconfig
> @@ -24,6 +24,13 @@ config DRM_MEDIATEK_HDMI
>  	tristate "DRM HDMI Support for Mediatek SoCs"
>  	depends on DRM_MEDIATEK
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> -	select GENERIC_PHY
> +	select PHY_MTK_HDMI
>  	help
>  	  DRM/KMS HDMI driver for Mediatek SoCs
> +
> +config PHY_MTK_HDMI
> +    tristate "MediaTek HDMI-PHY Driver"
> +    depends on ARCH_MEDIATEK && OF
> +    select GENERIC_PHY
> +    help
> +          Enable this to support HDMI-PHY

Please fix all of these newly added lines.

from Documentation/process/coding-style.rst:

Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


-- 
~Randy

