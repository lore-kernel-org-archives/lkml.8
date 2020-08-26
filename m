Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468BCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE992071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eaaico8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgHZMpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgHZMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:45:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4CDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:45:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r15so1638565wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+kzzXEOc0SKCEMyYbz32N97qq/kdnqi11MwwZYW+8A=;
        b=Eaaico8YLL0rqVWjj9g6C+EZwEJug3H7gLaaOoyO7gbEBptgnoTLAETEQcpA+bkGtH
         gqoi2pkRVFWFtV4ooHuSiKrdysd7sbHPtq1fr55uxzmvkBOuRfpqp4FZ/H+03fvgJqji
         sWiUVZMSSl6E7DpP8g9SU0azG2zVOcp+ZgxhBi1yN9Jn1KjoxcpEJw5sQv5JISKeQJKI
         FqKeyHs4YyCt43Eg0VZ9URCKuzwqbLFN3BL+SEWjSC4jf4OYyu18HkjXQzq4fu0PdfVt
         VYL82PcVRCY1HuotUr/xeGfnEvbEwd67UVQbqFlf8gqGKzPYLptFdpWCq4TedfJJXzO4
         ouvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+kzzXEOc0SKCEMyYbz32N97qq/kdnqi11MwwZYW+8A=;
        b=NoxvUh+0bVYPXioJ5bpdpickhG3tIftkm5HJsil04hQo67v/udtcYIyRJ1p54a7VJL
         anNBvu2SBh85vI8kNTxQNxai5uyQZqq4gLPqFeh+DCScqvxmf1vLsfe9cpEwLTMNMWbL
         BgLfWaqIS4kjaVRMLHq+MPvBu6fhV0y4CQUTbs19vWxPeFwu0UKXCfR4RHa/6sPhaqzs
         Rx6rv9yLHPMLG7qC9nKSAQM9SaarAG/ACnvxi8B6GyHAaAMRNzIQ/4oBOfwm5OD0khTr
         TQNBgtA9LI6vEqOEsBsM5JtRLL9ANfTRwc3CGfbqivfItM2cuAeiv0tX9h2CfokTDlf3
         AcRA==
X-Gm-Message-State: AOAM531odKBu3aX7hgrvG70NeyvCsn7UmVY3xR3xro/zUoSJM0cbOkgO
        36ZBlWpFJgj9K1jVZI0bTXk=
X-Google-Smtp-Source: ABdhPJzz3psrSXNKKZ8i9/G6RaSCelZjPxvn52X1JMOmitt6XeOC5Mo9TfCruKPO2Y/opEds3GKrMg==
X-Received: by 2002:adf:9591:: with SMTP id p17mr15996721wrp.237.1598445916171;
        Wed, 26 Aug 2020 05:45:16 -0700 (PDT)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id a11sm6139369wrq.0.2020.08.26.05.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 05:45:15 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:45:10 +0500
From:   Bilal Wasim <bwasim.lkml@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/5] drm/bridge: ps8640: Return an error for
 incorrect attach flags
Message-ID: <20200826174510.0207854f@a-VirtualBox>
In-Reply-To: <20200826081526.674866-4-enric.balletbo@collabora.com>
References: <20200826081526.674866-1-enric.balletbo@collabora.com>
        <20200826081526.674866-4-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 10:15:24 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Bridge drivers that implement the new model only shall return an error
> from their attach() handler when the DRM_BRIDGE_ATTACH_NO_CONNECTOR
> flag is not set. So make sure we return an error because only the new
> drm_bridge model is supported.
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/bridge/parade-ps8640.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c
> b/drivers/gpu/drm/bridge/parade-ps8640.c index
> 13755d278db6..ce3e8b2da8c9 100644 ---
> a/drivers/gpu/drm/bridge/parade-ps8640.c +++
> b/drivers/gpu/drm/bridge/parade-ps8640.c @@ -200,6 +200,10 @@ static
> int ps8640_bridge_attach(struct drm_bridge *bridge, .channel = 0,
>  						   .node = NULL,
>  						 };
> +
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> +		return -EINVAL;
> +
>  	/* port@0 is ps8640 dsi input port */
>  	in_ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
>  	if (!in_ep)

Reviewed-by: Bilal Wasim <bwasim.lkml@gmail.com>
Tested-by: Bilal Wasim <bwasim.lkml@gmail.com>

-Bilal
