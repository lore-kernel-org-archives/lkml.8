Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161832067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgHRRGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:06:55 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:34000 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgHRRGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:06:07 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8F58C2001F;
        Tue, 18 Aug 2020 19:05:57 +0200 (CEST)
Date:   Tue, 18 Aug 2020 19:05:56 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drm/panel: Add panel driver for the Mantix
 MLAF057WE51-X DSI panel
Message-ID: <20200818170556.GA2291850@ravnborg.org>
References: <cover.1597652012.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1597652012.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8
        a=eCTDOZTGqrxRdbbr8LwA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Mon, Aug 17, 2020 at 10:14:33AM +0200, Guido Günther wrote:
> 
> The panel uses a Focaltech FT8006p, the touch part is handled by the already
> existing edt-ft5x06. It can be found in e.g. the Librem 5.
> 
> Changes from v2:
> - Due to review comments by Sam Ravnborg, thanks!
>   https://lore.kernel.org/lkml/20200815212727.GA1244923@ravnborg.org/
>   - Drop unused header
>   - Use newline before comment
> - Add Reviewed/Acked-by by Sam Ravnborg, thanks!
>   https://lore.kernel.org/lkml/20200815212727.GA1244923@ravnborg.org/
>   https://lore.kernel.org/lkml/20200815212750.GB1244923@ravnborg.org/
>   https://lore.kernel.org/lkml/20200815212840.GC1244923@ravnborg.org/
> 
> Changes from v1:
> - Due to review comments by Sam Ravnborg, thanks!
>   https://lore.kernel.org/dri-devel/20200815083917.GA993113@ravnborg.org/
>   - Don't preserve newlines with '|' in description
>   - Use reset-gpios and backlight from panel-common.yaml
>   - Reindent example
>   https://lore.kernel.org/dri-devel/20200815093226.GB993113@ravnborg.org/
>   - Drop unused includes
>   - Use dev_* instead of DRM_* for printing
>   - Turn off regulators in reverse order from enable
>   - Silence errors in mantix_{shutdown,remove}
>   - Drop duplicate mipi_dsi_dcs_enter_sleep_mode()
>   https://lore.kernel.org/dri-devel/20200815100230.GA1002374@ravnborg.org/
>   - Use dev_err_probe()
> - Add delays when turning off panel as suggested by the data sheet
> 
> This series is against next-20200814.
> 
> Guido Günther (3):
>   dt-bindings: vendor-prefixes: Add mantix vendor prefix
>   dt-bindings: Add Mantix MLAF057WE51-X panel bindings
>   drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel

Maxime Ripard backmerged -rc1 to drm-misc-next so I went ahead and applied
this series to drm-misc-next, forgetting you got commit rights. As they are
already pushed out too late for you to do push them - sorry!

	Sam

> 
>  .../display/panel/mantix,mlaf057we51-x.yaml   |  70 ++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   7 +
>  drivers/gpu/drm/panel/Kconfig                 |  11 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 328 ++++++++++++++++++
>  6 files changed, 419 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
>  create mode 100644 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> 
> -- 
> 2.26.2
