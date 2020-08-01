Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF65EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38E5208A9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgHALER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 07:04:17 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58512 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgHALEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 07:04:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 8A07EFB03;
        Sat,  1 Aug 2020 13:04:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v8GME70E-d7a; Sat,  1 Aug 2020 13:04:09 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8636D4537D; Sat,  1 Aug 2020 13:04:09 +0200 (CEST)
Date:   Sat, 1 Aug 2020 13:04:09 +0200
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
Message-ID: <20200801110409.GA6351@bogon.m.sigxcpu.org>
References: <20200716123753.3552425-1-megous@megous.com>
 <20200716140843.GA359122@bogon.m.sigxcpu.org>
 <20200716143209.ud6ote4q545bo2c7@core.my.home>
 <20200718173124.GA88021@bogon.m.sigxcpu.org>
 <20200718174215.mgjl3klytfa3nf3t@core.my.home>
 <20200729154809.GA435075@bogon.m.sigxcpu.org>
 <20200730134111.nayvgw4kcxeg6kft@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200730134111.nayvgw4kcxeg6kft@core.my.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondřej,
On Thu, Jul 30, 2020 at 03:41:11PM +0200, Ondřej Jirman wrote:
> Hello,
> 
> On Wed, Jul 29, 2020 at 05:48:09PM +0200, Guido Günther wrote:
> > Hi,
> > On Sat, Jul 18, 2020 at 07:42:15PM +0200, Ondřej Jirman wrote:
> > > Hello,
> > > 
> > > On Sat, Jul 18, 2020 at 07:31:24PM +0200, Guido Günther wrote:
> > > > Hi,
> > > > On Thu, Jul 16, 2020 at 04:32:09PM +0200, Ondřej Jirman wrote:
> > > > > Hi Guido,
> > > > > 
> > > > > On Thu, Jul 16, 2020 at 04:08:43PM +0200, Guido Günther wrote:
> > > > > > Hi Ondrej,
> > > > > > On Thu, Jul 16, 2020 at 02:37:51PM +0200, Ondrej Jirman wrote:
> > > > > > > When extending the driver for xbd599 panel support I tried to do minimal
> > > > > > > changes and keep the existing initialization timing.
> > > > > > > 
> > > > > > > It turned out that it's not good enough and the existing init sequence
> > > > > > > is too aggressive and doesn't follow the specification. On PinePhone
> > > > > > > panel is being powered down/up during suspend/resume and with current
> > > > > > > timings this frequently leads to corrupted display.
> > > > > > 
> > > > > > Given the amount of ST7703 look alikes i don't think you can go by the
> > > > > > datasheet and hope not to break other panels. The current sleeps cater
> > > > > > for the rocktech panel (which suffered from similar issues you describe
> > > > > > when we took other parameters) so you need to make those panel specific.
> > > > > 
> > > > > It should work on rocktech too. The patch mostly increases/reorders the delays
> > > > > slightly, to match the controller documentation. I don't see a reason to
> > > > > complicate the driver with per panel special delays, unless these patches don't
> > > > > work on your panel.
> > > > 
> > > > That's why i brought it up. It breaks the rocktech panel on
> > > > blank/unblank loops where it just stays blank and then starts hitting
> > > > DSI command timeouts.
> > > 
> > > Good to know. Does keeping the msleep(20); after init sequence and before sleep
> > > exit make it work?
> > 
> > We need both sleeps to make this work reliably so basically
> > reverting your 'drm/panel: st7703: Make the sleep exit timing match the
> > spec' makes things stable again.
> > 
> > We don't need to sleep 120ms after sleep out though since our panel only
> > requires 15ms as per data sheet there so it really makes sense to make
> > these configurable.
> 
> Thank you for checking it.
> 
> I'd be happy with just the other patch being applied. That would be enough
> to fix issues with xingbangda panel too.

That's fine since that case works here too. The commit message
should be adjusted though since the ST7703 data sheet i'm looking at says
there's no restriction about applying IOVCC and VCI (tRPW= +/- no
limit). You're basically also switching to another reset pattern (the
data sheet describes two). So instead of saying:

"Fix the power up sequence of the panel"

i'd rather say

"Pick a reset sequence that works for ingbangda,xbd599 panel too"

and then describe the changes since that helps us to identify later
on why we made that change. With that and 1/2 dropped that looks good to
me.

Cheers,
 -- Guido

>

> In my tests xbd panel doesn't need 120ms either, despite the datasheet.
> What breaks xbd panel is the lack of post-powerup delay before deasserting
> reset line.
> 
> regards,
> 	o.
> 
> > Cheers,
> >  -- Guido
> > 
> > > 
> > > thank you and regards,
> > > 	o.
> > > 
> > > > Cheers,
> > > >  -- Guido
> > > > 
> > > > > 
> > > > > The init sequence is still suboptimal, and doesn't follow the kernel docs
> > > > > completely, even after these patches. Controller spec also talks about adding
> > > > > some delay before enabling the backlight to avoid visual glitches.
> > > > > 
> > > > > Which is what enable callback is documented to be for. Currently part of the
> > > > > initialization that belongs to prepare callback is also done in enable callback.
> > > > > 
> > > > > I see the glitch (small vertical shift of the image on powerup), but personally
> > > > > don't care much to introduce even more delays to the driver, just for the
> > > > > cosmetic issue.
> > > > > 
> > > > > regards,
> > > > > 	o.
> > > > > 
> > > > > > Cheers,
> > > > > >  -- Guido
> > > > > > 
> > > > > > > 
> > > > > > > This patch series fixes the problems.
> > > > > > > 
> > > > > > > The issue was reported by Samuel Holland.
> > > > > > > 
> > > > > > > Relevant screenshots from the datasheet:
> > > > > > > 
> > > > > > >   Power on timing: https://megous.com/dl/tmp/35b72e674ce0ca27.png
> > > > > > >   Power off timing: https://megous.com/dl/tmp/dea195517106ff17.png
> > > > > > >   More optimal reset on poweron: https://megous.com/dl/tmp/a9e5caf14e1b0dc6.png
> > > > > > >   Less optimal reset on poweron: https://megous.com/dl/tmp/246761039283c4cf.png
> > > > > > >   Datasheet: https://megous.com/dl/tmp/ST7703_DS_v01_20160128.pdf
> > > > > > > 
> > > > > > > Please take a look.
> > > > > > > 
> > > > > > > thank you and regards,
> > > > > > >   Ondrej Jirman
> > > > > > > 
> > > > > > > Ondrej Jirman (2):
> > > > > > >   drm/panel: st7703: Make the sleep exit timing match the spec
> > > > > > >   drm/panel: st7703: Fix the power up sequence of the panel
> > > > > > > 
> > > > > > >  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 29 ++++++++++---------
> > > > > > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > > > > > > 
> > > > > > > -- 
> > > > > > > 2.27.0
> > > > > > > 
> > > > > 
> > > 
> 
