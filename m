Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A637C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7767320732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Du1CQaH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgHUHVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:21:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:60369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgHUHRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597994235;
        bh=RKUSb1KT1trkVNW36+e3JD1DffRwh/W1OBUG1JuN6uA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Du1CQaH46NlFDLMN9jR6t/blbrxAsycfJD7PVFmhiAvbD7PkD+ALRoHx41tSGfSMP
         LDOAmyzW3owGagiMj5tUoF3S/V+iDjQfgVtIO7eA1o5pQmDFFELCeoLyRmm32PiSJB
         zxvsgnbJCtv1TPT94r1HEf2CoqMwVs2NqnbKCVK0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.76.97.101] ([185.76.97.101]) by web-mail.gmx.net
 (3c-app-gmx-bs37.server.lan [172.19.170.89]) (via HTTP); Fri, 21 Aug 2020
 09:17:15 +0200
MIME-Version: 1.0
Message-ID: <trinity-14a1b182-38ab-4f84-bb72-94d448b05fd5-1597994235320@3c-app-gmx-bs37>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        chunkuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 21 Aug 2020 09:17:15 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20200819081752.4805-4-linux@fw-web.de>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-4-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:G4xmr717AcDMw6ju9c+MTAh1ENstXifUuqwYk2JTQndtKaX+h68KJhQwkJXqNtEhaI343
 d6puxE4NpPUj+poBeraf/qvlP8/zlGCK6Ny4BEOvyctzZ6JW5GK5gYOA2ouK05E3eS6AHof6QCyR
 HijgcCsdNhWCwFIt+hfPGBLFffWcDTSIulRfvsWGY+CqWp0ly5ETHWIjQTDnzwrGYlwUfeRHfoMe
 f2h68lhCDY3XrUEzaxP1W7UIznEzCAiQbhQklhh1HMZwjtEfuIwnkveAyPmmdHcUXfhatuW1pNPz
 ko=
X-UI-Out-Filterresults: notjunk:1;V03:K0:a4waYzz4wCU=:gsH0HcXlOmeTEMQJH6qFnw
 2B5Agpzwt2lMiyybMkfwqV60xc/z77OmHqLxf+eBzcynq9L3eql47J6pq1EvIkdJnQK/2JuOv
 JP8cFeofPY8CRuZK8IU4IrUlm9QdK1niSER2o2FYBf0JK7cnawKqthp8iC08AgRWYin1d0BA+
 GvbScPsMLd0k1cYNzTo/nDYPS6hljc8kA8ZjBiTJbHdzazxc54z/fze5nY44sac6q2rCPhQ7A
 FLWFJ0RGu5BhNjN9tKeB1sMK9sIAOG6T+nVyab+yR2og0c2rFaZbcfNQ+R2u6ns4c6JXfzxwx
 SOe/3Qx1VWxdb8GamJlzfYDwqP4KrGDrLataQsoqE0npBQif1xcumugDVcWbXNx21ofIfT2VJ
 oXn2hTLUokeEH0bcEMAi+9UsJ9G/KcREV1mldENwtZ4fgfzdseceAj992+7YTs99ZfV4Sp/mw
 31XugyOCcadzqiK1hF9Wi/9CqcC7T67VOqAJ2zsHV2BxJb86wropyHWptiaaOUtKAN5KVbgZs
 gdlADlYiySR2HATQ8k00EyBF9I4azYOzL+tlP9/7+S8tqcAXpHTFUEJp/XlNT8x8A9A3rAPkN
 0CQeo/MUasS9iQTL/HxxT4Un7N0wgdTsCs5MiNEfiSgPww02psJp4buhymvc4yUG4QYXeylgG
 3x5df/W92rMCR40vACtcG+y2oRRcyVD/KVb47hgka2aMQt560E4/FkF+9KocyBUJ8AoQ=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/m=
ediatek/mtk_hdmi_phy.c
> index 5223498502c4..edadb7a700f1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -184,6 +184,9 @@ static int mtk_hdmi_phy_probe(struct platform_device=
 *pdev)
>  		return PTR_ERR(phy_provider);
>  	}
>
> +	if (hdmi_phy->conf->pll_default_off)
> +		hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
> +
>  	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
>  				   hdmi_phy->pll);
>  }

tried modifying mtk_hdmi_phy_power_on using the new flag to not enable tmd=
s instead of enabling and later disabling it, but this does not work...

=2D-- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -62,7 +62,8 @@ static int mtk_hdmi_phy_power_on(struct phy *phy)
        if (ret < 0)
                return ret;

-       hdmi_phy->conf->hdmi_phy_enable_tmds(hdmi_phy);
+       if (!hdmi_phy->conf->pll_default_off)
+               hdmi_phy->conf->hdmi_phy_enable_tmds(hdmi_phy);
        return 0;
 }

@@ -184,8 +185,8 @@ static int mtk_hdmi_phy_probe(struct platform_device *=
pdev)
                return PTR_ERR(phy_provider);
        }

-       if (hdmi_phy->conf->pll_default_off)
-               hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
+       //if (hdmi_phy->conf->pll_default_off)
+       //      hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);

        return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
                                   hdmi_phy->pll);


same problem as without this Patch (horizontally distorted image flickerin=
g on 1280x1024)

any idea CK Hu?

regards Frank
