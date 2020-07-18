Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE58E2073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGRRba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:31:30 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:45592 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgGRRb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:31:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B9C92FB03;
        Sat, 18 Jul 2020 19:31:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N14d5shIaMI1; Sat, 18 Jul 2020 19:31:25 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B4BC842576; Sat, 18 Jul 2020 19:31:24 +0200 (CEST)
Date:   Sat, 18 Jul 2020 19:31:24 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix st7703 panel initialization failures
Message-ID: <20200718173124.GA88021@bogon.m.sigxcpu.org>
References: <20200716123753.3552425-1-megous@megous.com>
 <20200716140843.GA359122@bogon.m.sigxcpu.org>
 <20200716143209.ud6ote4q545bo2c7@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200716143209.ud6ote4q545bo2c7@core.my.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Jul 16, 2020 at 04:32:09PM +0200, Ondřej Jirman wrote:
> Hi Guido,
> 
> On Thu, Jul 16, 2020 at 04:08:43PM +0200, Guido Günther wrote:
> > Hi Ondrej,
> > On Thu, Jul 16, 2020 at 02:37:51PM +0200, Ondrej Jirman wrote:
> > > When extending the driver for xbd599 panel support I tried to do minimal
> > > changes and keep the existing initialization timing.
> > > 
> > > It turned out that it's not good enough and the existing init sequence
> > > is too aggressive and doesn't follow the specification. On PinePhone
> > > panel is being powered down/up during suspend/resume and with current
> > > timings this frequently leads to corrupted display.
> > 
> > Given the amount of ST7703 look alikes i don't think you can go by the
> > datasheet and hope not to break other panels. The current sleeps cater
> > for the rocktech panel (which suffered from similar issues you describe
> > when we took other parameters) so you need to make those panel specific.
> 
> It should work on rocktech too. The patch mostly increases/reorders the delays
> slightly, to match the controller documentation. I don't see a reason to
> complicate the driver with per panel special delays, unless these patches don't
> work on your panel.

That's why i brought it up. It breaks the rocktech panel on
blank/unblank loops where it just stays blank and then starts hitting
DSI command timeouts.
Cheers,
 -- Guido

> 
> The init sequence is still suboptimal, and doesn't follow the kernel docs
> completely, even after these patches. Controller spec also talks about adding
> some delay before enabling the backlight to avoid visual glitches.
> 
> Which is what enable callback is documented to be for. Currently part of the
> initialization that belongs to prepare callback is also done in enable callback.
> 
> I see the glitch (small vertical shift of the image on powerup), but personally
> don't care much to introduce even more delays to the driver, just for the
> cosmetic issue.
> 
> regards,
> 	o.
> 
> > Cheers,
> >  -- Guido
> > 
> > > 
> > > This patch series fixes the problems.
> > > 
> > > The issue was reported by Samuel Holland.
> > > 
> > > Relevant screenshots from the datasheet:
> > > 
> > >   Power on timing: https://megous.com/dl/tmp/35b72e674ce0ca27.png
> > >   Power off timing: https://megous.com/dl/tmp/dea195517106ff17.png
> > >   More optimal reset on poweron: https://megous.com/dl/tmp/a9e5caf14e1b0dc6.png
> > >   Less optimal reset on poweron: https://megous.com/dl/tmp/246761039283c4cf.png
> > >   Datasheet: https://megous.com/dl/tmp/ST7703_DS_v01_20160128.pdf
> > > 
> > > Please take a look.
> > > 
> > > thank you and regards,
> > >   Ondrej Jirman
> > > 
> > > Ondrej Jirman (2):
> > >   drm/panel: st7703: Make the sleep exit timing match the spec
> > >   drm/panel: st7703: Fix the power up sequence of the panel
> > > 
> > >  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 29 ++++++++++---------
> > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > > 
> > > -- 
> > > 2.27.0
> > > 
> 
