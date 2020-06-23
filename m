Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9110CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5CC20720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbgFWNfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:35:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59580 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732662AbgFWNfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:35:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DDF911C0C0F; Tue, 23 Jun 2020 15:35:30 +0200 (CEST)
Date:   Tue, 23 Jun 2020 15:35:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ond??ej Jirman <megous@megous.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Bhushan Shah <bshah@kde.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/5] drm: panel: Add Xingbangda XBD599 panel (ST7703
 controller)
Message-ID: <20200623133529.GC2783@bug>
References: <20200617003209.670819-1-megous@megous.com>
 <20200617003209.670819-4-megous@megous.com>
 <20200620212529.GB74146@ravnborg.org>
 <20200620223010.fqjwijiixxkewk3p@core.my.home>
 <20200622080802.GA650963@ravnborg.org>
 <20200622111752.jsz37zl7hidvkozw@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622111752.jsz37zl7hidvkozw@core.my.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > > Would it not be better to have one st7703 driver that suipports both
> > > > panels?
> > > >
> > > > The driver would need dedicated init functions depending on the panel.
> > > > But a lot could also be shared.
> > > 
> > > I guess I can move the code there. 
> > In the same process the river should then be renamed to follow other
> > sitronix based drivers.
> > So the next developer will recognize this and use the correct driver.
> 
> Are driver/module names considered kernel ABI? Or is it possible to
> change them?

I believe you can get away with changing them.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
