Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21163C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E5420829
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHPTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:04:29 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:59706 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:04:28 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 51A548050E;
        Sun, 16 Aug 2020 21:04:19 +0200 (CEST)
Date:   Sun, 16 Aug 2020 21:04:17 +0200
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
Subject: Re: [PATCH v2 3/3] drm/panel: Add panel driver for the Mantix
 MLAF057WE51-X DSI panel
Message-ID: <20200816190417.GA1421437@ravnborg.org>
References: <cover.1597526107.git.agx@sigxcpu.org>
 <d4e3f881e3d53166eea0be31a885e08679813558.1597526107.git.agx@sigxcpu.org>
 <20200815212727.GA1244923@ravnborg.org>
 <20200816175521.GC2838@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200816175521.GC2838@bogon.m.sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=19sgfWsJWGHdIB95J8cA:9 a=wPNLvfGTeEIA:10 a=tk1IvOmOJPsA:10
        a=iBZjaW-pnkserzjvUTHh:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 07:55:21PM +0200, Guido Günther wrote:
> Hi Sam,
> thanks for having a look!
> 
> On Sat, Aug 15, 2020 at 11:27:27PM +0200, Sam Ravnborg wrote:
> > Hi Guido.
> > 
> > On Sat, Aug 15, 2020 at 11:16:22PM +0200, Guido Günther wrote:
> > > The panel uses a Focaltech FT8006p, the touch part is handled by the
> > > already existing edt-ft5x06.
> > > 
> > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > 
> > Two small nits - otherwise looks good.
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > 
> > I can fix while applying or you can send a new revision,
> > but I cannot apply until drm-misc-next have seen a backmerge
> > due to dev_err_probe() usage.
> 
> I'll send out a v3 with this fixed.
> 
> > Did you have commit rights yet?
> > If yes, then please apply yourself.
> 
> No commit rights here. So it would be great if you could apply the
> patches. Should I look for commit rights? I assume that means following
> 
>     https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm-misc    
I recall we discussed this before for some other driver.
For a single panel it is not needed, but if you continue to be active
on other parts it makes sense.


I will apply v3 when drm-misc-next is backmeged unless you tell me
otherwise. And ping me if I forgets.

	Sam
