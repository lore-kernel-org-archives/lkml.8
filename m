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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD43C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9290208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0bjSd+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgHZMh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgHZMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:37:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E728EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:37:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so1365452wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVKirMIQloZm771iTq462uuSZP5L4as332r/HWvG44Y=;
        b=B0bjSd+H1bctu2OqrFwNyNDVUpiZ+Dy7brhxL0C0WAwqFlccUX7jyG0X3sAp90dPTp
         qqKcwJAF2jYymxK0YspNf6LC+9LY0jBdthniu9U22NsyFXYmfScMnS5gaocDYefCCYa2
         1LXLdmb3Nmqi3UFRHXqdtsWrF0WAmCvPeKNARejVcs/kdMt5n37mcZ00EgcqN39EaNyI
         DNMCG5w5wgoxDcgAS4yTdtwjtZ+NphYMt7MyoXjON52fiuR3XnxNbCNqEqjuHvvYnY/T
         tzIedfggpH1fQDlJW0o9EwMKrfx1IYMIIlKWam+y/KTcF4/uFziYDYAXT9juhDMVU5RP
         Gqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVKirMIQloZm771iTq462uuSZP5L4as332r/HWvG44Y=;
        b=nBuIonDs8a3BUg2n759rmcKJ/eWbA50hap/bdsa7YuYvVX/6knGxtTjAc/UNDybUY2
         6I6BAyR6lWttoZAgzriK1gwZdpcncjANUh6CHBEqlbX0dlc95ApeuRnD1Lnr5FLcOkl9
         gEdcP6Ff6dyRmCxFZSIqz9NWp5NAoW6L9SnHwahiwqZ0mxfneU3/5BD78dfx4Svwkr/n
         5SJQ/n5UmhqGWKmny+SU7GbyKnSW4OYvSK9qff5pfV5mUSMly5v9nxA/jR3GeG9U1nSq
         cg2YU9WoDhPxXqUtbnhLJVAW/SPEuErk/X0XdEhJZoKHmHBRTS6WyFV9orAAcgjZewN9
         Wzjg==
X-Gm-Message-State: AOAM530Fe9PwEfkb7LsdxRRiO1D4NQec2cnt6pfeThhMpclSQFs0OM/k
        Yj7ix6Hk6J0bxd/n/WzjIvw=
X-Google-Smtp-Source: ABdhPJwb9JY5cBVtCdqrbxvVaNL9Z1AZ2EiRNW1YlXoQO2ifhrY0webfkfJn9j7Cj6TaZALKHNTMlg==
X-Received: by 2002:a1c:f704:: with SMTP id v4mr3337030wmh.4.1598445471532;
        Wed, 26 Aug 2020 05:37:51 -0700 (PDT)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id p2sm6714395wrf.78.2020.08.26.05.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 05:37:51 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:37:46 +0500
From:   Bilal Wasim <bwasim.lkml@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/5] drm/bridge_connector: Set default status
 connected for eDP connectors
Message-ID: <20200826173746.622c2af9@a-VirtualBox>
In-Reply-To: <20200826081526.674866-2-enric.balletbo@collabora.com>
References: <20200826081526.674866-1-enric.balletbo@collabora.com>
        <20200826081526.674866-2-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 10:15:22 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> In an eDP application, HPD is not required and on most bridge chips
> useless. If HPD is not used, we need to set initial status as
> connected, otherwise the connector created by the
> drm_bridge_connector API remains in an unknown state.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Included the patch `drm/bridge_connector: Set default status
> connected for eDP connectors`
> 
>  drivers/gpu/drm/drm_bridge_connector.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge_connector.c
> b/drivers/gpu/drm/drm_bridge_connector.c index
> c6994fe673f3..a58cbde59c34 100644 ---
> a/drivers/gpu/drm/drm_bridge_connector.c +++
> b/drivers/gpu/drm/drm_bridge_connector.c @@ -187,6 +187,7 @@
> drm_bridge_connector_detect(struct drm_connector *connector, bool
> force) case DRM_MODE_CONNECTOR_DPI: case DRM_MODE_CONNECTOR_LVDS:
>  		case DRM_MODE_CONNECTOR_DSI:
> +		case DRM_MODE_CONNECTOR_eDP:
>  			status = connector_status_connected;
>  			break;
>  		default:

Reviewed-by: Bilal Wasim <bwasim.lkml@gmail.com>
Tested-by: Bilal Wasim <bwasim.lkml@gmail.com>

-Bilal
