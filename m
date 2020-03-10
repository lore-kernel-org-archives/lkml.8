Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A165C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E7F20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCJTKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:10:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:27673 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgCJTKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:10:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 12:10:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="353691156"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 10 Mar 2020 12:10:25 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 10 Mar 2020 21:10:24 +0200
Date:   Tue, 10 Mar 2020 21:10:24 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Pascal Roeleven <dev@pascalroeleven.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/panel: Add Starry KR070PE2T
Message-ID: <20200310191024.GQ13686@intel.com>
References: <20200310102725.14591-1-dev@pascalroeleven.nl>
 <20200310102725.14591-2-dev@pascalroeleven.nl>
 <20200310185422.GA22095@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310185422.GA22095@ravnborg.org>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 07:54:23PM +0100, Sam Ravnborg wrote:
> Hi Pascal.
> 
> Thanks for submitting.
> 
> On Tue, Mar 10, 2020 at 11:27:23AM +0100, Pascal Roeleven wrote:
> > The KR070PE2T is a 7" panel with a resolution of 800x480.
> > 
> > KR070PE2T is the marking present on the ribbon cable. As this panel is
> > probably available under different brands, this marking will catch
> > most devices.
> > 
> > Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> 
> A few things to improve.
> 
> The binding should be a separate patch.
> subject - shall start with dt-bindings:
> Shall be sent to deveicetree mailing list.
> 
> For panel we no longer accept .txt bindings.
> But the good news is that since the panel is simple,
> you only need to list your compatible in the file
> bindings/display/panel/panel-simple.yaml
> - must be en alphabetical order
> - vendor prefix must be present in vendor-prefixes
> 
> 
> 
> > ---
> >  .../display/panel/starry,kr070pe2t.txt        |  7 +++++
> >  drivers/gpu/drm/panel/panel-simple.c          | 26 +++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt b/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt
> > new file mode 100644
> > index 000000000..699ad5eb2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt
> > @@ -0,0 +1,7 @@
> > +Starry 7" (800x480 pixels) LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "starry,kr070pe2t"
> > +
> > +This binding is compatible with the simple-panel binding, which is specified
> > +in simple-panel.txt in this directory.
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index e14c14ac6..027a2612b 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -2842,6 +2842,29 @@ static const struct panel_desc shelly_sca07010_bfn_lnn = {
> >  	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> >  };
> >  
> > +static const struct drm_display_mode starry_kr070pe2t_mode = {
> > +	.clock = 33000,
> > +	.hdisplay = 800,
> > +	.hsync_start = 800 + 209,
> > +	.hsync_end = 800 + 209 + 1,
> > +	.htotal = 800 + 209 + 1 + 45,
> > +	.vdisplay = 480,
> > +	.vsync_start = 480 + 22,
> > +	.vsync_end = 480 + 22 + 1,
> > +	.vtotal = 480 + 22 + 1 + 22,
> > +	.vrefresh = 60,
> > +};
> 
> Please adjust so:
> vrefresh * htotal * vtotal == clock.
> I cannot say what needs to be adjusted.
> But we are moving away from specifying vrefresh and want the
> data to be OK.

This one actually looks OK to me. Unless I typoed the numbers
the timings give us a vrefresh of 59.58 which gets rounded to 60.
So no change once .vrefresh disappears AFAICS.

-- 
Ville Syrjälä
Intel
