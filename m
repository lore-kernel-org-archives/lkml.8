Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD21C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C54E21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596234261;
	bh=CFCLX/xODFrhtkzvYcYSNO27dODJFFuiaQpl62SKKfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aXJyWwM/KDPdk6BTZHD6z9aZcUVJ+Xol2seZGkKmcJIcWBSfg3JiZu7BXqKLOBgj0
	 x9ZBKjha6SYdSv/Slk7hGkhadEqY6ViC3ibMnAFT7vRpXdERPtb9wg45S/9ikqLo13
	 HvczBqjB5hvdthj16XLqAuQ0YFwJaTLFVjBEbPaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGaWYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:24:20 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40395 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaWYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:24:19 -0400
Received: by mail-il1-f195.google.com with SMTP id x1so6281763ilp.7;
        Fri, 31 Jul 2020 15:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VAnICWWmHSZyQ/n2FRhx+9FJGWpFXq+PYL2a2PlHGUI=;
        b=jycLPAkCDbNJ4nUkNKxW89bYzPa06CamYvOZ9+V/xqgesPMVkAYnWnyV4H123CAk7L
         hSidyLLM911Kj2WDj12tHtdvID9GcL+rN2tfUrw2yjgLcwfyxQ5eownYTU2Y3VGwNeBD
         z65EvnMeJUxGJ5yExaPKUdN2tFqQ4byF8Env0vwZi48ewtCWl+aKo5lgJBAVKouiz8Fw
         Se2TfFf4u/o/rUFB1/q9BycKnHAp/G/aZcIHDAUiGwhSZaN0UT9gdxlP+rFgczVdGoqL
         gEVummtsoyioOIxhcxQh2qbmWAN3gksi9rkiFbc70l8iNc70npVm3vF0REZW7RqFLKEN
         KMRg==
X-Gm-Message-State: AOAM532rImezdVZdYVoxDkaNwH8qwz+eg5nHJct+Q5U1XUDxkIAm0sG7
        GtyhbZbjLvD1Xf+CYKUzDhjjPPFInQ==
X-Google-Smtp-Source: ABdhPJzNNKwOyFQ6RSiwe5OSJfrjJmwW/9c5cKyL5rJw4Hyu75ZQcI5qmCEHkE7DS7cCCOIQtFoRgQ==
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr5914173ilq.41.1596234258633;
        Fri, 31 Jul 2020 15:24:18 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f19sm5813243ilf.15.2020.07.31.15.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:24:18 -0700 (PDT)
Received: (nullmailer pid 912829 invoked by uid 1000);
        Fri, 31 Jul 2020 22:24:16 -0000
Date:   Fri, 31 Jul 2020 16:24:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 07/17] dt-bindings: reset: imx8mp: Add hdmi blk_ctrl
 reset IDs
Message-ID: <20200731222416.GA912729@bogus>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-8-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596024483-21482-8-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 15:07:53 +0300, Abel Vesa wrote:
> These will be used imx8mp for blk-ctrl driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/reset/imx8mp-reset.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
