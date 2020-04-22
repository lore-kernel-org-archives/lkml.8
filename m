Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFBDC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920182077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2qv8zer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDVVMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgDVVMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:12:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D107C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:12:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so1522521pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=XDPcP3tbzlYKPYQTKxlpDEEO5QOa9GV0Amha8h89AsA=;
        b=e2qv8zerN73zMA5kW/Ta2fN1O8dVIK6jdFNxVtrJdjtMXUttRjJYvnccM0b/J1yciZ
         lzbNuem24E3qhUXCCDGrhc2xgjM6SrUupLu6OxsIqZDgHOnnSZ5flr/7F/DAhDRki5P4
         qLllKpWEIlToWVvAZA0E5oKaNXV4MQmK5onWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=XDPcP3tbzlYKPYQTKxlpDEEO5QOa9GV0Amha8h89AsA=;
        b=WR29baF6y2npys45n/BiBKOrOWkdFivysb5wlpFrwTGofL6pgaTh2qVfyWIqf1bXtM
         lblrnSUBkuus49C2EwzLiCPGvFxe9LhBfEMhD51plga5cgYSbOY4HVk3FuUKKcFFA/YK
         or2yI8sxJMln+oNG5aI681mzXnfetZoTEhRdhgUrZfJ/G3eeYCt41sp1WS4O3ZtrAaAi
         QOr+nVy0myjUSplmS+yVaO91rb2HWjbPNWJvXqhOm/ssWL8rTJurLRgTf5pF2Q1zsS2Y
         F/HZQM7jGmQomQTUSJR3CFe5kO2kiVpq1fURWh2RVz51RwHBXj5SORabki3oJ9X65eR8
         dkwg==
X-Gm-Message-State: AGi0Pubd6S1MzqhfQLV7YaIf32XHaKTCEmj9JwhdTF/JaRE3+pjqGuFe
        fKN+1iDtuIskXmZLP3hFQcOLxQ==
X-Google-Smtp-Source: APiQypL5oBKdc6NVB1E/uXQs9airhXye2LtpOV4841Lu7hi+EjVHEnGsUW8WDXrjg92l2+Vpp882FA==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr639876plk.150.1587589942545;
        Wed, 22 Apr 2020 14:12:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o40sm164208pjb.18.2020.04.22.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 14:12:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200420220458.v2.3.I53fed5b501a31e7a7fa13268ebcdd6b77bd0cadd@changeid>
References: <20200421050622.8113-1-dianders@chromium.org> <20200420220458.v2.3.I53fed5b501a31e7a7fa13268ebcdd6b77bd0cadd@changeid>
Subject: Re: [PATCH v2 3/6] drm/panel-simple: Support hpd-gpios for delaying prepare()
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
Date:   Wed, 22 Apr 2020 14:12:20 -0700
Message-ID: <158758994028.230545.10042873479857418029@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-20 22:06:19)
> People use panel-simple when they have panels that are builtin to
> their device.  In these cases the HPD (Hot Plug Detect) signal isn't
> really used for hotplugging devices but instead is used for power
> sequencing.  Panel timing diagrams (especially for eDP panels) usually
> have the HPD signal in them and it acts as an indicator that the panel
> is ready for us to talk to it.
>=20
> Sometimes the HPD signal is hooked up to a normal GPIO on a system.
> In this case we need to poll it in the correct place to know that the
> panel is ready for us.  In some system designs the right place for
> this is panel-simple.
>=20
> When adding this support, we'll account for the case that there might
> be a circular dependency between panel-simple and the provider of the
> GPIO.  The case this was designed for was for the "ti-sn65dsi86"
> bridge chip.  If HPD is hooked up to one of the GPIOs provided by the
> bridge chip then in our probe function we'll always get back
> -EPROBE_DEFER.  Let's handle this by allowing this GPIO to show up
> late if we saw -EPROBE_DEFER during probe.

May be worth mentioning that if there isn't an hpd-gpios property then
we only try once during probe and then after that the prepare callback
doesn't try again because the gpio_get_optional() APIs are used. I had
to think about that for a minute.

>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
