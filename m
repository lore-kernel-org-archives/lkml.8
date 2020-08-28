Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C01C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9363F20838
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 21:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598650862;
	bh=rWVmQwhZQeje6Df3eQ00N7Jlh4F/ZOtxnxcC/BqcCo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NXWM4y1uRtHf1NOzz4CYXTPDra+Jd+euDOmKwa3QzYCyVj7lGTpDXql9xZY17FrE4
	 Xo2cvlRhFCxRIQmdfoP9pUSFJ/GHV/F6AIv+shHpwRLFp+tsIKmNHQI3Ly4FvliL8c
	 /5yhS5pUQ0GGEf9HkUdDoKX8lpPoAmWAjA2/5LEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgH1VlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:41:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37048 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgH1VlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 17:41:00 -0400
Received: by mail-io1-f67.google.com with SMTP id b16so528133ioj.4;
        Fri, 28 Aug 2020 14:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mS4Zu08qQZpZXMImrRzIfdT+5oFEqMPjqg/4ZwW6vpw=;
        b=Lwihk+ACG9zc5OfgMIzrXs7Ifb/iRbulTlYsUldcJz0ir6y3pRhuAzMIbnFNfTukAx
         tCNGDEUz1RdsxPKNH+3djjB3n2P8WLkQFKhCExrHdAGgc0kOXcIeabG4kcmZmf8wQ/b9
         x1mzNl0z86N3F1nQwmHrYxuzvRJlihpaodM9iFDByuUHM9fZEwffqa6YiJUH2d5IWyVA
         DPYODIHdbWiGCKkWCUrYcjOPr7/47pJJ5VXhb+e3NuX2s2mIqdAgy3bTK4jI/ZH+fGqy
         2sVNqzR2RvjFvbQ6hPyidne28dVj8srJWmBUiUP14urPQ91jDY2O8PYBnzi320/MYPvL
         i8Pw==
X-Gm-Message-State: AOAM530Ql+RlR5mLlD7VbV4nesAQI2g6ntAXbVpYC2/FgErnsaKec6FG
        53YluWzay/wBL3PTQPm5sw==
X-Google-Smtp-Source: ABdhPJwOj6BZZBaf0EDaLZohN5F7o1+QFYl6wqAXpILr7Io/VbZMByRExEnFwRSZL8c77C+W1L2ScA==
X-Received: by 2002:a6b:c997:: with SMTP id z145mr613456iof.136.1598650859348;
        Fri, 28 Aug 2020 14:40:59 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id i10sm198351ioo.49.2020.08.28.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:40:58 -0700 (PDT)
Received: (nullmailer pid 3448918 invoked by uid 1000);
        Fri, 28 Aug 2020 21:40:56 -0000
Date:   Fri, 28 Aug 2020 15:40:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Robert Chiras (OSS)" <robert.chiras@oss.nxp.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Ondrej Jirman <megous@megous.com>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/5] dt-bindings: display/bridge: nwl-dsi: Document
 video_pll clock
Message-ID: <20200828214056.GA3448236@bogus>
References: <1598613212-1113-1-git-send-email-robert.chiras@oss.nxp.com>
 <1598613212-1113-3-git-send-email-robert.chiras@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598613212-1113-3-git-send-email-robert.chiras@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 14:13:29 +0300, Robert Chiras (OSS) wrote:
> From: Robert Chiras <robert.chiras@nxp.com>
> 
> Add documentation for a new clock 'video_pll'.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: mipi_dsi@30a00000: clocks: [[4294967295, 163], [4294967295, 244], [4294967295, 245], [4294967295, 164], [4294967295, 128]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: mipi_dsi@30a00000: clock-names: ['core', 'rx_esc', 'tx_esc', 'phy_ref', 'lcdif'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml


See https://patchwork.ozlabs.org/patch/1353197

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

