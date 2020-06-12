Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D01207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CP8z1KxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFLV2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLV23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:28:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2BDC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:28:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s88so4379148pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=q50EF1oi6iVj0g/hX2lXZBGzTAbXnNZchr5c5rsTc8U=;
        b=CP8z1KxPyKGd6QZi4PnOdQpR8ev8eekuKH/CynZh0Exe5JIjxFvJUaJvmjOBXdjTM4
         GXzKPX21EqBTryBElczC/QqQ1+VpQqkM/DZKOaAIT8tgiBlJjAlWlKRXQRXNk7SyZNMn
         Bxa+KmFCqY56wgY2Pfb0R5JtUhx4g1t6PpKLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=q50EF1oi6iVj0g/hX2lXZBGzTAbXnNZchr5c5rsTc8U=;
        b=mnhgz+4veTSsaih6TAYF+D3fWWakacXGnSHJzgLQO7TKeQmCbDgj+dXeDbQ0Was2MA
         NKS70CLcl+X0217+hKCI2h2uB69rdgocnxhrr6oSQUrdUG/FiD2uPRXaoxxTNoiWrbZy
         69oUy9a5+QnqEbFRTDRWoe0Tc/VG759QZgSn2P4d7Ml72NTsYva/HkojkEiDl1GJbVrR
         F5CkcPMdjagnm2ruz/+sslHcIaoCNQMPy1ukNfq5L9L3fGye+FfZOxqLhTeu3vbjFet7
         JuNHLOasLYRnf4Z0qc+dA40o1h9dsoDtY+1G0OKd++RZ9uK3OdvFOeBTTVCraxbd9CSc
         pNoA==
X-Gm-Message-State: AOAM533RS6qmTCYgRbTzgU06X3vSyXtmtkxs2eq5EEJh+QSDEHYn33wi
        l/xiNA3HCF9QQP04+mUMnvW07g==
X-Google-Smtp-Source: ABdhPJzNsJkluvv0T/kJePCV/uW7PiR/CaUosJPHKH78onXcX0T8ami55T1bac/+kv0z7GN7hv7Qsg==
X-Received: by 2002:a17:90a:f87:: with SMTP id 7mr817869pjz.3.1591997307711;
        Fri, 12 Jun 2020 14:28:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z11sm7194528pfk.141.2020.06.12.14.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:28:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200612123003.v2.4.Ia4376fd88cdc6e8f8b43c65548458305f82f1d61@changeid>
References: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid> <20200612123003.v2.4.Ia4376fd88cdc6e8f8b43c65548458305f82f1d61@changeid>
Subject: Re: [PATCH v2 4/4] drm/bridge: ti-sn65dsi86: Check the regmap return value when setting a GPIO
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     spanda@codeaurora.org, bjorn.andersson@linaro.org,
        robdclark@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>, a.hajda@samsung.com,
        narmstrong@baylibre.com, sam@ravnborg.org
Date:   Fri, 12 Jun 2020 14:28:26 -0700
Message-ID: <159199730620.62212.13255273805624622339@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-06-12 12:30:50)
> The ti_sn_bridge_gpio_set() got the return value of
> regmap_update_bits() but didn't check it.  The function can't return
> an error value, but we should at least print a warning if it didn't
> work.
>=20
> This fixes a compiler warning about setting "ret" but not using it.
>=20
> Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Li=
nux")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
