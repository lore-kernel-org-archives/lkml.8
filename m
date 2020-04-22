Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62277C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E51120656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SU01xAPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgDVKee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbgDVKYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:24:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343B1C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:24:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so843642pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=xkeWLnteJjG54BboMmCRycKnKz+ymn9qqeCn2SIVyPQ=;
        b=SU01xAPQmFHWruDWFN1SqvstGsdj+QtEI2l+t4wN7c4jgMkL/L/wsL03ySzyuQIxdq
         T0Ioo5gzkx8Vod0lKiA65OS5kWldrL8Q6G5FI9UlLcTmBDqbVhu478J6FU4I8FNL9FGY
         /9DU9UBHZRgdxvLgcfDf2MTd1FBckvpItjbac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=xkeWLnteJjG54BboMmCRycKnKz+ymn9qqeCn2SIVyPQ=;
        b=NOVhG7kscO3mifRV9xr3lZ3BmkVG94mSt9Ea/D33SbJSqeJ4nCmFE2s5YJkbqf1qEi
         ykB4JrYDnf32xwt/FXwLAH+Duy6+LZSSTHyzsV2pzeQ9F8qsBRYC5yijn++YWt6EH0Be
         rFCwAjqmknrgAViSk1wQfZxsasGXlMfHJqJMtTMvH+D96nBOau7dx/5Wc/fUEp0ClBLW
         veaOHnYsqm7rOpavJ+rJO9QsSi+8Cx8zkVp1qzZIB7ArIG0MGhuRUMaKYdnqGiRq+ovO
         qtLfDWjTMyUrJ6VJODm16jaZ/ksgfNhOCa2W4LRkkHeBA64tDY0gWLNlDHxKaWl//5na
         91ZQ==
X-Gm-Message-State: AGi0PubPorL0HdfWI1KG9TxvAw+uzM6lAbONPusCHyxujYZJu5b3qXXD
        MguPdF0toOZeTFNaZ6YdJEN0yg==
X-Google-Smtp-Source: APiQypLBY8yUOpSkusa0a8k0gnufQC44Y4aGlSsuT2v9ocxchD8HZri/OWeKDQvYCLZNlWUEX5ugEA==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr26724966pfh.16.1587551052739;
        Wed, 22 Apr 2020 03:24:12 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a2sm5066746pja.44.2020.04.22.03.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:24:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200420220458.v2.2.I1976736b400a3b30e46efa47782248b86b3bc627@changeid>
References: <20200421050622.8113-1-dianders@chromium.org> <20200420220458.v2.2.I1976736b400a3b30e46efa47782248b86b3bc627@changeid>
Subject: Re: [PATCH v2 2/6] dt-bindings: display: Add hpd-gpios to panel-common bindings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     jonas@kwiboo.se, jeffrey.l.hugo@gmail.com,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        jernej.skrabec@siol.net, bjorn.andersson@linaro.org,
        robdclark@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        airlied@linux.ie, bgolaszewski@baylibre.com, daniel@ffwll.ch,
        linus.walleij@linaro.org, narmstrong@baylibre.com,
        robh+dt@kernel.org, spanda@codeaurora.org
Date:   Wed, 22 Apr 2020 03:24:11 -0700
Message-ID: <158755105124.159702.6095634958147138337@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-20 22:06:18)
> In the cases where there is no connector in a system there's no great
> place to put "hpd-gpios".  As per discussion [1] the best place to put
> it is in the panel.  Add this to the device tree bindings.
>=20
> [1] https://lore.kernel.org/r/20200417180819.GE5861@pendragon.ideasonboar=
d.com
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
