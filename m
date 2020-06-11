Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FD3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4797820656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T1zuyaDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgFKJ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgFKJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:57:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19982C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:57:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a45so3015189pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=CzkQpCcoRC0sJMa0pR1sKpPdtKMP/PyiTFgiJafcnYY=;
        b=T1zuyaDTfoAv+to8FZCdUiFLlcjnOFk6V3IaNNgO+XGZmN1ehhha22D9yK6A4xzD13
         NamAU3IyaEZhQxLQQCtEcuGdXDp9EFgSyS11KLORVlt7RVplueLPudJ/LlFd/YiDlwP1
         DUneDn4otiEC2gPcNUJzdNDBpsoJK1SA149kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=CzkQpCcoRC0sJMa0pR1sKpPdtKMP/PyiTFgiJafcnYY=;
        b=YpUsNGAyNHP4aEEidxecOdVdJVSJljsiXbbCHjHYLxVaRZmaAaa7QXqUuoR5E4+J8C
         OkO3mQRod8Pviv3QmpSM0iNuYmAdzcJwrhDDCWHhHLnTTbu8WPThr5r74TijjTuA2sOf
         +dFXqHbbSbBJcCoYHmKUhK/U0x010rve2ERc1PjjGSDsAbmATT0J4YOAd5Nvw2K4KTpt
         CqBB85w5F/AGhgMueMQ2r1ZjT+7Ht5QzoTmDO4bGaUWMhx70Kyb6iPYLQMVrJMQ8griQ
         KsRgAyTqEv2OnpDYyNvqCUjzg06luaOxhSb5iyxtHiF5idRROMIBzcBRUE5zSwjj/ska
         Z4KQ==
X-Gm-Message-State: AOAM532PdWS6PPysZUSOu6wuSQk9DtLaCf9t4zJDGja85Q8DlwY6n0sm
        cOJyjzYAZNguaAgYXrjsHW7OVQ==
X-Google-Smtp-Source: ABdhPJxLjw0gaPc4oCJfx5+8kuZMUUtob14rBwCjjokf0iEIJHPLqK98EAnH8w2jeRriDItthQR/vw==
X-Received: by 2002:a17:902:b7c9:: with SMTP id v9mr6598219plz.34.1591869422531;
        Thu, 11 Jun 2020 02:57:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id cu9sm2160918pjb.28.2020.06.11.02.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:57:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200608104832.2.If3807e4ebf7f0440f64c3069edcfac9a70171940@changeid>
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid> <20200608104832.2.If3807e4ebf7f0440f64c3069edcfac9a70171940@changeid>
Subject: Re: [PATCH 2/4] drm/bridge: ti-sn65dsi86: Don't use kernel-doc comment for local array
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@chromium.org, bjorn.andersson@linaro.org,
        spanda@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>, a.hajda@samsung.com,
        narmstrong@baylibre.com, sam@ravnborg.org
Date:   Thu, 11 Jun 2020 02:57:01 -0700
Message-ID: <159186942131.242598.6194861800377753563@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-06-08 10:48:33)
> When building we were getting an error:
>=20
>   warning: cannot understand function prototype:
>     'const unsigned int ti_sn_bridge_dp_rate_lut[] =3D '
>=20
> Arrays aren't supposed to be marked with "/**" kerneldoc comments.  Fix.
>=20
> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver=
")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
