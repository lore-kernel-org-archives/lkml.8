Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21893C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F399120773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263774;
	bh=wARGLmsIIkpvt6aSKySm1biiABvunEzdMsgj/zsg90o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AZgadfyLPEqbAsJfup09WIHN4BXmnip+NIIy6ysBbLmFZcHD84avzNcULSFRUhZnX
	 BggFm0pS3wRqjUas7cY3nFIE3BDtpB/7ptcQ6ZVPIROOY+qU544TMd1G4OLdsMWIFb
	 BYTx7/wFQ6BNCBFVJAzG/g6UP3j6yXXeCVFLiPrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbgGTQtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:49:32 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37589 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgGTQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:49:31 -0400
Received: by mail-il1-f195.google.com with SMTP id r12so13887841ilh.4;
        Mon, 20 Jul 2020 09:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XgKAKo+S7gA8PeWe+CXW+WfGrv348894snfv+irZlfo=;
        b=mO3ZXfhJMtjZJatTVr6R5vxs6rXm6it3E8GjiW/z5eUby+kaZnWSCr/NFkX/or+JzK
         mLu42YB/PjBY4Gkk/azofJmeXWIMNcw6oWDoR/6nMQaxuanbF1bn5Vxom+rolx3GrbMh
         pm9W7f+yQpJBD4FkCUPuCxSn+/vVgvC3Hp3jEic86g1FLIJPsLGQoMCH+hVhv3ExVNGd
         IsvqwfomtRzhpzWPDXaC7ZNikWVKTQTOra5IecySNGttduVMlVByYvCj84Z/jTl+0OUh
         rhp8I8h2rLVvweQU6CarRrqANPuCWv6ENROWCXajFuV27CKxRgr8cTf99UzmqPhVQq/8
         9+Kw==
X-Gm-Message-State: AOAM531TSj/ZC5bMnaKX1x9ve3+CZrcoQCBJ3mNcd/+3/g1m3b2xAaeo
        VfG9VNcym9s+VDsUzSy0EQ==
X-Google-Smtp-Source: ABdhPJyTRCVRoTuZGnQpzCTUrFO9tb3c0NKREz91tnGjrAlsvG4TZNieeaTudRx6yJwvSiggn1u7Iw==
X-Received: by 2002:a05:6e02:1043:: with SMTP id p3mr22878021ilj.245.1595263770294;
        Mon, 20 Jul 2020 09:49:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a13sm9049380ilk.19.2020.07.20.09.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 09:49:29 -0700 (PDT)
Received: (nullmailer pid 2651900 invoked by uid 1000);
        Mon, 20 Jul 2020 16:49:27 -0000
Date:   Mon, 20 Jul 2020 10:49:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, lukas@mntmn.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>, agx@sigxcpu.org
Subject: Re: [PATCH v6 4/4] dt-bindings: display: imx: add bindings for DCSS
Message-ID: <20200720164927.GA2650420@bogus>
References: <20200717144132.2206-1-laurentiu.palcu@oss.nxp.com>
 <20200717144132.2206-5-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717144132.2206-5-laurentiu.palcu@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 17:41:29 +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> Add bindings for iMX8MQ Display Controller Subsystem.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx8mq-dcss.yaml | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

