Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BC9C55194
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659DF20714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587843162;
	bh=0ulDBW0A0FGxgWHUR/UjwRr2lxLvSlNEMvQY0s82ih0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=O9H9Idu5fwp5CDLq+bwA2h7KYK6a2nsbB9yYJHHXeLY+l+SOvbQ65qJs/ognoopUe
	 723IEWYDG2NzvAJsP3CBTGmt5VzZcBfE/3TYWTSxsqq2UtD4WJYWtPx2ruuVIeHE1m
	 ILmLQrEWUCbLjjLEBe+FOXjZrWK3i0CwM8Hv1wyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDYTcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgDYTcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:32:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07103206D4;
        Sat, 25 Apr 2020 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843161;
        bh=0ulDBW0A0FGxgWHUR/UjwRr2lxLvSlNEMvQY0s82ih0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=k7ONbr0w7Jb+HlBd31qwXsYO3DZIys100UIfn0BRsqGXyNJdXqIwGytt4ayvH5YNL
         BdX6BxjUJOXZqhZN57B4PxtMsiLcEJNV+lPksZGI9YpvPlyIFxUrjpVDu6ovu97qOM
         BDxHH5QYVE2Tz6tc4+6JAkRrw34MKIwDOtoyArDo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200423092431.v3.4.Ifcdc4ecb12742a27862744ee1e8753cb95a38a7f@changeid>
References: <20200423162548.129661-1-dianders@chromium.org> <20200423092431.v3.4.Ifcdc4ecb12742a27862744ee1e8753cb95a38a7f@changeid>
Subject: Re: [PATCH v3 4/6] dt-bindings: drm/bridge: ti-sn65dsi86: Convert to yaml
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@chromium.org, jernej.skrabec@siol.net, jonas@kwiboo.se,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        airlied@linux.ie, bgolaszewski@baylibre.com, daniel@ffwll.ch,
        linus.walleij@linaro.org, narmstrong@baylibre.com,
        robh+dt@kernel.org, spanda@codeaurora.org
Date:   Sat, 25 Apr 2020 12:32:40 -0700
Message-ID: <158784316023.117437.12833780288081575852@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-23 09:25:46)
> This moves the bindings over, based a lot on toshiba,tc358768.yaml.
> Unless there's someone known to be better, I've set the maintainer in
> the yaml as the first person to submit bindings.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
