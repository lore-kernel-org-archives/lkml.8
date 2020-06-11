Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C76C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4877620656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QG4OosPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgFKJ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgFKJ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:56:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C220C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:56:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so2454293pfx.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ondMPxf4uc2ph0pt0HgNHkcg5ynpnvHAdpE5eze5hYk=;
        b=QG4OosPTuQ7XSPnl3uAYPgAopJcCv0BggHQxnSP19seCkrDgxFVy4hU0ua0Z3FC9Av
         2Vkn3X+kkzq1YqJzseiIDbwZLazYZyYTreNneCf7QzsK80vw2E6EXCzBUZiC9rlI7NmA
         KpFDfaDoJ2VQAbnj4HygVOT9ewMmqSHONrSvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ondMPxf4uc2ph0pt0HgNHkcg5ynpnvHAdpE5eze5hYk=;
        b=KrOvZPwRyjICfjU1nnVXTwIH1YPD9jr16/IF8xEeiQ2hmSv6xN/1cUHyhjLrirKxNi
         94G9lvNXw+833i5N20X39w29GDHNe3lvtCOz0wBTtbRj6HlQ+g9ISSYOElaIFSLHQjyV
         QhoAc/qeGqMdEGqDQ+XNyt3J6+BxoSO68V0wgyM3AVjTC4+XUUk8VCZW9w/jaPl+pnHc
         yxKTZdvTAUoZ3/SBoivDJhc4uGA7m9EHwvsadONDQvkaV8J92MKHN5qlanBBfJuzYBvA
         FL5Om8apl47MRDFFF4LXxi4SAwqXF/Ede0exoeHt2VocW4h9VuOuzH3KfnVdq7YRkqP+
         DX3Q==
X-Gm-Message-State: AOAM533abP13sIKcz0KwuQ343WOUvE6a6fRLNjF4SNIVjFj5yCRtI4S7
        uUdbMfIeSeM7lcS+AmYVrgTYJA==
X-Google-Smtp-Source: ABdhPJzhSivEozbKncqU6JHQ+1w1z70+0W7uymFdngeQnJGZhEo6dmuQMhLDSnbesWa3fDCqke3Arw==
X-Received: by 2002:a65:6550:: with SMTP id a16mr6018320pgw.183.1591869413347;
        Thu, 11 Jun 2020 02:56:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c8sm2154436pjn.16.2020.06.11.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:56:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
Subject: Re: [PATCH 1/4] drm/bridge: ti-sn65dsi86: Don't compile GPIO bits if not CONFIG_OF_GPIO
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@chromium.org, bjorn.andersson@linaro.org,
        spanda@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>, a.hajda@samsung.com,
        narmstrong@baylibre.com, sam@ravnborg.org
Date:   Thu, 11 Jun 2020 02:56:51 -0700
Message-ID: <159186941181.242598.7668810499408351238@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-06-08 10:48:32)
> The kernel test robot noted that if "OF" is defined (which is needed
> to select DRM_TI_SN65DSI86 at all) but not OF_GPIO that we'd get
> compile failures because some of the members that we access in "struct
> gpio_chip" are only defined "#if defined(CONFIG_OF_GPIO)".
>=20
> All the GPIO bits in the driver are all nicely separated out.  We'll
> guard them with the same "#if defined" that the header has and add a
> little stub function if OF_GPIO is not defined.
>=20
> Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Li=
nux")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
