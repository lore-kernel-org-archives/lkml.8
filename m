Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD97C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FF5205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgD1PpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:45:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:23143 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgD1PpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:45:11 -0400
IronPort-SDR: FlK3USzNRZyzqpItFtpJNaSES7fWhuopKM6whHov3hHb/YX9AeTWwB/b0UNCH1vlG29RvwSe8y
 pAhpvbBT4yJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 08:45:10 -0700
IronPort-SDR: Y2jjpeQRyMamyyeeqnfCuhoebJpgL2SUnnbusXiXSvRFa4VFWEOKkf6mvdtj8n9SuU5rKO1IT3
 kYAuCADvdMlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="302740823"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 28 Apr 2020 08:45:05 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 28 Apr 2020 18:45:05 +0300
Date:   Tue, 28 Apr 2020 18:45:05 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Michal Orzel <michalorzel.eng@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        chris@chris-wilson.co.uk, jose.souza@intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Remove drm_display_mode.hsync
Message-ID: <20200428154505.GK6112@intel.com>
References: <1587974717-14599-1-git-send-email-michalorzel.eng@gmail.com>
 <20200428151813.GW3456981@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428151813.GW3456981@phenom.ffwll.local>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 05:18:13PM +0200, Daniel Vetter wrote:
> On Mon, Apr 27, 2020 at 10:05:17AM +0200, Michal Orzel wrote:
> > As suggested by the TODO list of DRM subsystem:
> > -remove the member hsync of drm_display_mode
> > -convert code using hsync member to use drm_mode_hsync()
> > 
> > Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> 
> I think Ville has a bunch of patches doing this, we might have some
> overlap :-/ Adding Ville.
> 
> Please sync with him and get either of these patches reviewed.

Yeah, I have the same thing (+ making the function static). I think
my series is sufficiently reviewed to get most of it pushed. Just need
to get it past the ci... which apparently means I get to do another
rebase.

> 
> Thanks, Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_modes.c                  |  6 +-----
> >  drivers/gpu/drm/i915/display/intel_display.c |  1 -
> >  include/drm/drm_modes.h                      | 10 ----------
> >  3 files changed, 1 insertion(+), 16 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index d4d6451..0340079 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -752,16 +752,12 @@ EXPORT_SYMBOL(drm_mode_set_name);
> >   * @mode: mode
> >   *
> >   * Returns:
> > - * @modes's hsync rate in kHz, rounded to the nearest integer. Calculates the
> > - * value first if it is not yet set.
> > + * @modes's hsync rate in kHz, rounded to the nearest integer.
> >   */
> >  int drm_mode_hsync(const struct drm_display_mode *mode)
> >  {
> >  	unsigned int calc_val;
> >  
> > -	if (mode->hsync)
> > -		return mode->hsync;
> > -
> >  	if (mode->htotal <= 0)
> >  		return 0;
> >  
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index 3468466..ec7e943 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -8891,7 +8891,6 @@ void intel_mode_from_pipe_config(struct drm_display_mode *mode,
> >  
> >  	mode->clock = pipe_config->hw.adjusted_mode.crtc_clock;
> >  
> > -	mode->hsync = drm_mode_hsync(mode);
> >  	mode->vrefresh = drm_mode_vrefresh(mode);
> >  	drm_mode_set_name(mode);
> >  }
> > diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
> > index 99134d4..7dab7f1 100644
> > --- a/include/drm/drm_modes.h
> > +++ b/include/drm/drm_modes.h
> > @@ -391,16 +391,6 @@ struct drm_display_mode {
> >  	int vrefresh;
> >  
> >  	/**
> > -	 * @hsync:
> > -	 *
> > -	 * Horizontal refresh rate, for debug output in human readable form. Not
> > -	 * used in a functional way.
> > -	 *
> > -	 * This value is in kHz.
> > -	 */
> > -	int hsync;
> > -
> > -	/**
> >  	 * @picture_aspect_ratio:
> >  	 *
> >  	 * Field for setting the HDMI picture aspect ratio of a mode.
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Ville Syrjälä
Intel
