Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E19AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3872E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgHQI2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:28:24 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:60242 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgHQI2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:28:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7AF44FB04;
        Mon, 17 Aug 2020 10:28:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8TlX4fRmALQd; Mon, 17 Aug 2020 10:28:17 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A9DEE4576F; Mon, 17 Aug 2020 10:28:16 +0200 (CEST)
Date:   Mon, 17 Aug 2020 10:28:16 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
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
Message-ID: <20200817082816.GA33443@bogon.m.sigxcpu.org>
References: <cover.1597526107.git.agx@sigxcpu.org>
 <d4e3f881e3d53166eea0be31a885e08679813558.1597526107.git.agx@sigxcpu.org>
 <20200815212727.GA1244923@ravnborg.org>
 <20200816175521.GC2838@bogon.m.sigxcpu.org>
 <20200816190417.GA1421437@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200816190417.GA1421437@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
On Sun, Aug 16, 2020 at 09:04:17PM +0200, Sam Ravnborg wrote:
> On Sun, Aug 16, 2020 at 07:55:21PM +0200, Guido Günther wrote:
> > Hi Sam,
> > thanks for having a look!
> > 
> > On Sat, Aug 15, 2020 at 11:27:27PM +0200, Sam Ravnborg wrote:
> > > Hi Guido.
> > > 
> > > On Sat, Aug 15, 2020 at 11:16:22PM +0200, Guido Günther wrote:
> > > > The panel uses a Focaltech FT8006p, the touch part is handled by the
> > > > already existing edt-ft5x06.
> > > > 
> > > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > > 
> > > Two small nits - otherwise looks good.
> > > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > > 
> > > I can fix while applying or you can send a new revision,
> > > but I cannot apply until drm-misc-next have seen a backmerge
> > > due to dev_err_probe() usage.
> > 
> > I'll send out a v3 with this fixed.
> > 
> > > Did you have commit rights yet?
> > > If yes, then please apply yourself.
> > 
> > No commit rights here. So it would be great if you could apply the
> > patches. Should I look for commit rights? I assume that means following
> > 
> >     https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm-misc    
> I recall we discussed this before for some other driver.
> For a single panel it is not needed, but if you continue to be active
> on other parts it makes sense.

I think st7703, mantix and nwl all go in via drm-misc so it might make
sense. Thanks for the suggestion!

> I will apply v3 when drm-misc-next is backmeged unless you tell me
> otherwise. And ping me if I forgets.

Thanks!
 -- Guido
