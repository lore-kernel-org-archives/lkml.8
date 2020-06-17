Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2662FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075EE21707
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFQR4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:56:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:41022 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgFQR4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:56:12 -0400
IronPort-SDR: nTgt3IXqgkDZz8mrYcmHT9I8YsKcq/LlK/i4yOb40tS4HhN9VUjmtjWMbzFlfo/8/yOQHaMmLK
 ZO/5EJXic7Yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 10:56:11 -0700
IronPort-SDR: uLjDcLQFXZLsMmZ1k8P/BJrERaOOA0rDTl+4i/2ly7R/mvYGhi/ipnoFdWUxSTj/eXrdLmd8Sc
 gTwkT/RNnBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="262643233"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 17 Jun 2020 10:56:08 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 17 Jun 2020 20:56:07 +0300
Date:   Wed, 17 Jun 2020 20:56:07 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Cyrus Lien <cyrus.lien@canonical.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: add support for min horizontal rate equal to
 max horizontal rate
Message-ID: <20200617175607.GO6112@intel.com>
References: <20200608195704.29841-1-cyrus.lien@canonical.com>
 <20200609145745.GO6112@intel.com>
 <CAC513mV1B1O90RCbiUGN9Z_4jCHRmcTVjH+R0GffYtG=YwjD5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC513mV1B1O90RCbiUGN9Z_4jCHRmcTVjH+R0GffYtG=YwjD5A@mail.gmail.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:58:33AM +0800, Cyrus Lien wrote:
> On Tue, Jun 9, 2020 at 10:58 PM Ville Syrjälä <ville.syrjala@linux.intel.com>
> wrote:
> 
> > On Tue, Jun 09, 2020 at 03:57:04AM +0800, Cyrus Lien wrote:
> > > According to EDID spec, table 3.26, byte #6 and #8, which said "Minimum
> > > rate value shall be less than or equal to maximum rate value". The
> > minimum
> > > horizontal/vertical rate value is able to be equal to maximum horizontal/
> > > veritcal rate value.
> >
> > How does that justifiy ignoring the min value?
> >
> > Indeed, this patch does not make sense.
> Setting minimum horizontal rate equal to maximum horizontal rate is a
> request come from AMD Windows graphic driver for support freesync (I'm not
> sure if linux AMD driver also require it).

AFAICS the DP spec itself doesn't say anything about the
horizontal min/max rates. However DP-EDID-CTS 1.2 / 4.8 seems to
say that hmin==hmax==hsync should hold. Not sure if that should
be the hsync rate of the min/max/nominal refresh rate. I would
have maybe expected the max since that's the actual rate it's
going operate at. Alhtough I even less of an idea what it should
be if the monitor supports multiple resolutions.

In this case it doesn't seem to be any of those exactly. Pretty
close to the min refresh rate though. hmin=hmax=110 kHz vs.
actual hsync rate for 50Hz would be 111.1 kHz (if it was actually
running at 50Hz with the declared vblank length which it won't be
of course). If we calculate in the opposite direction we get a
vrefresh of ~49.5 Hz based on the 110 kHz hsync rate. So if we
round to nearest integer it does match the declared vmin of 50Hz.

I suspect the right answer is to just ignore hmin/hmax when
it comes to adaptive sync.

> The problem is mode_in_hsync_range always return false except the mode's
> hsync exactly equal to hmax and hmin.
> 
> Add print in mode_in_hsync_range():
> [drm] mode_in_hsync_range 1920x1200: hsync: 94, hmax: 110, hmix:110
> [drm] mode_in_hsync_range 1920x1200: hsync: 107, hmax: 110, hmix:110
> [drm] mode_in_hsync_range 1920x1200: hsync: 152, hmax: 110, hmix:110
> [drm] mode_in_hsync_range 1920x1440: hsync: 90, hmax: 110, hmix:110
> [drm] mode_in_hsync_range 1920x1440: hsync: 113, hmax: 110, hmix:110
> [drm] mode_in_hsync_range 1920x1440: hsync: 183, hmax: 110, hmix:110
> 
> Is it available to get or calculate the hmax, hmix value from other fields
> in EDID ?
> Would you please provide some advice or directions to solve this problem ?
> Thank you and appreciated the help.
> 
> edid-decode (hex):
> 
> 00 ff ff ff ff ff ff 00 06 af 9b 32 00 00 00 00
> 00 1e 01 04 b5 26 15 78 03 1f 95 a5 53 35 b5 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 70 d0 00 a0 f0 70 3e 80 30 20
> 35 00 7d d6 10 00 00 1a 00 00 00 fd 00 32 5a 6e
> 6e 17 01 11 01 e0 60 20 50 3c 00 00 00 fe 00 34
> 34 54 52 4e 15 42 31 37 33 5a 41 4e 00 00 00 00
> 00 05 81 01 28 00 12 00 00 0b 01 0a 20 20 01 af
> 
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> ----------------
> 
> EDID version: 1.4
> Manufacturer: AUO Model 12955 Serial Number 0
> Made in year 2020
> Digital display
> 10 bits per primary color channel
> DisplayPort interface
> Maximum image size: 38 cm x 21 cm
> Gamma: 2.20
> Supported color formats: RGB 4:4:4
> First detailed timing includes the native pixel format and preferred
> refresh rate
> Display is continuous frequency
> Color Characteristics
>   Red:   0.6445, 0.3251
>   Green: 0.2099, 0.7099
>   Blue:  0.1503, 0.0595
>   White: 0.3134, 0.3291
> Established Timings I & II: none
> Standard Timings: none
> Detailed mode: Clock 533.600 MHz, 381 mm x 214 mm
>                3840 3888 3920 4000 ( 48  32  80)
>                2160 2163 2168 2222 (  3   5  54)
>                +hsync -vsync
>                VertFreq: 60.036 Hz, HorFreq: 133.400 kHz
> Display Range Limits
>   Monitor ranges (Bare Limits): 50-90 Hz V, 110-110 kHz H, max dotclock 230
> MHz
> Alphanumeric Data String: 44TRN
> Manufacturer-Specified Display Descriptor (0x00): 00 00 00 05 81 01 28 00
> 12 00 00 0b 01 0a 20 20  ......(.......
> Has 1 extension block
> Checksum: 0xaf
> 
> ----------------
> 
> >
> > > This change check if h/v-sync excess maximum horizontal/vertical rate if
> > > hmin equal to hmax or vmin equal to vmax.
> > >
> > > Signed-off-by: Cyrus Lien <cyrus.lien@canonical.com>
> > > ---
> > >  drivers/gpu/drm/drm_edid.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > > index fed653f13c26..23878320eabd 100644
> > > --- a/drivers/gpu/drm/drm_edid.c
> > > +++ b/drivers/gpu/drm/drm_edid.c
> > > @@ -2674,6 +2674,9 @@ mode_in_hsync_range(const struct drm_display_mode
> > *mode,
> > >           hmax += ((t[4] & 0x08) ? 255 : 0);
> > >       hsync = drm_mode_hsync(mode);
> > >
> > > +     if (hmax == hmin)
> > > +             return (hsync <= hmax);
> > > +
> > >       return (hsync <= hmax && hsync >= hmin);
> > >  }
> > >
> > > @@ -2691,6 +2694,9 @@ mode_in_vsync_range(const struct drm_display_mode
> > *mode,
> > >           vmax += ((t[4] & 0x02) ? 255 : 0);
> > >       vsync = drm_mode_vrefresh(mode);
> > >
> > > +     if (vmax == vmin)
> > > +             return (vsync <= vmax);
> > > +
> > >       return (vsync <= vmax && vsync >= vmin);
> > >  }
> > >
> > > --
> > > 2.25.1
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Ville Syrjälä
> > Intel
> >

-- 
Ville Syrjälä
Intel
