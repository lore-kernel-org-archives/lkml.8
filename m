Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012FAC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A7C2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbgCPPOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:14:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:61876 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbgCPPOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:14:17 -0400
IronPort-SDR: bWdQ6Dfk4JEYn31xf3c5Xwp29evPuMvyXky3178m7/2Pq0oRDFGSRQK+u0sExH/tcGHI7HDViY
 tcaRby6mYBmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 08:14:16 -0700
IronPort-SDR: SMrdSI+w47upSYJuzeWVXhH/NRV+HgwXOk6Ud/Sh2F8w0MinBcB7rAYKoAxxq9j0TzGHZ6Hr+B
 TSJzpG6GYyYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="262705244"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 16 Mar 2020 08:14:12 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 16 Mar 2020 17:14:12 +0200
Date:   Mon, 16 Mar 2020 17:14:12 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        jani.nikula@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        mripard@kernel.org, mihail.atanassov@arm.com,
        linux-kernel@vger.kernel.org, ankit.k.nautiyal@intel.com
Subject: Re: [RFC][PATCH 1/5] drm: Introduce scaling filter property
Message-ID: <20200316151412.GS13686@intel.com>
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
 <20200225070545.4482-2-pankaj.laxminarayan.bharadiya@intel.com>
 <20200310160106.GH13686@intel.com>
 <20200316083132.GC2363188@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316083132.GC2363188@phenom.ffwll.local>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 09:31:32AM +0100, Daniel Vetter wrote:
> On Tue, Mar 10, 2020 at 06:01:06PM +0200, Ville Syrjälä wrote:
> > On Tue, Feb 25, 2020 at 12:35:41PM +0530, Pankaj Bharadiya wrote:
> > > Introduce new scaling filter property to allow userspace to select
> > > the driver's default scaling filter or Nearest-neighbor(NN) filter
> > > for upscaling operations on crtc/plane.
> > > 
> > > Drivers can set up this property for a plane by calling
> > > drm_plane_enable_scaling_filter() and for a CRTC by calling
> > > drm_crtc_enable_scaling_filter().
> > > 
> > > NN filter works by filling in the missing color values in the upscaled
> > > image with that of the coordinate-mapped nearest source pixel value.
> > > 
> > > NN filter for integer multiple scaling can be particularly useful for
> > > for pixel art games that rely on sharp, blocky images to deliver their
> > > distinctive look.
> > > 
> > > Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> > > Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
> > > Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_uapi.c |  8 +++++++
> > >  drivers/gpu/drm/drm_crtc.c        | 16 ++++++++++++++
> > >  drivers/gpu/drm/drm_mode_config.c | 13 ++++++++++++
> > >  drivers/gpu/drm/drm_plane.c       | 35 +++++++++++++++++++++++++++++++
> > >  include/drm/drm_crtc.h            | 10 +++++++++
> > >  include/drm/drm_mode_config.h     |  6 ++++++
> > >  include/drm/drm_plane.h           | 14 +++++++++++++
> > >  7 files changed, 102 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> > > index a1e5e262bae2..4e3c1f3176e4 100644
> > > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > > @@ -435,6 +435,8 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
> > >  		return ret;
> > >  	} else if (property == config->prop_vrr_enabled) {
> > >  		state->vrr_enabled = val;
> > > +	} else if (property == config->scaling_filter_property) {
> > > +		state->scaling_filter = val;
> > 
> > I think we want a per-plane/per-crtc prop for this. If we start adding
> > more filters we are surely going to need different sets for different hw
> > blocks.
> 
> In the past we've only done that once we have a demonstrated need. Usually
> the patch to move the property to a per-object location isn't a lot of
> churn.

Seems silly to not do it from the start when we already know there is
hardware out there that has different capabilities per hw block.

-- 
Ville Syrjälä
Intel
