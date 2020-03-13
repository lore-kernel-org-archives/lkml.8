Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36751C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CE4206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCMIpp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:45:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:28198 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgCMIpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:45:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 01:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="232354775"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2020 01:45:43 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 01:45:41 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Mar 2020 01:45:40 -0700
Received: from bgsmsx153.gar.corp.intel.com (10.224.23.4) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Mar 2020 01:45:39 -0700
Received: from BGSMSX107.gar.corp.intel.com ([169.254.9.15]) by
 BGSMSX153.gar.corp.intel.com ([169.254.2.116]) with mapi id 14.03.0439.000;
 Fri, 13 Mar 2020 14:15:36 +0530
From:   "Laxminarayan Bharadiya, Pankaj" 
        <pankaj.laxminarayan.bharadiya@intel.com>
To:     =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC:     "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "mihail.atanassov@arm.com" <mihail.atanassov@arm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Souza, Jose" <jose.souza@intel.com>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Deak, Imre" <imre.deak@intel.com>,
        "Shankar, Uma" <uma.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
Subject: RE: [RFC][PATCH 5/5] drm/i915/display: Add Nearest-neighbor based
 integer scaling support
Thread-Topic: [RFC][PATCH 5/5] drm/i915/display: Add Nearest-neighbor based
 integer scaling support
Thread-Index: AQHV66uZeA9shQKOjUiF9Sh/Uqx6m6hBuziAgAMGXKD///ZrAIABlqsQ
Date:   Fri, 13 Mar 2020 08:45:35 +0000
Message-ID: <E92BA18FDE0A5B43B7B3DA7FCA031286057B474F@BGSMSX107.gar.corp.intel.com>
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
 <20200225070545.4482-6-pankaj.laxminarayan.bharadiya@intel.com>
 <20200310161723.GK13686@intel.com>
 <E92BA18FDE0A5B43B7B3DA7FCA031286057B2C55@BGSMSX107.gar.corp.intel.com>
 <20200312135438.GF13686@intel.com>
In-Reply-To: <20200312135438.GF13686@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Sent: 12 March 2020 19:25
> To: Laxminarayan Bharadiya, Pankaj
> <pankaj.laxminarayan.bharadiya@intel.com>
> Cc: jani.nikula@linux.intel.com; daniel@ffwll.ch; intel-
> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; airlied@linux.ie;
> maarten.lankhorst@linux.intel.com; tzimmermann@suse.de;
> mripard@kernel.org; mihail.atanassov@arm.com; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
> Chris Wilson <chris@chris-wilson.co.uk>; Souza, Jose <jose.souza@intel.com>;
> De Marchi, Lucas <lucas.demarchi@intel.com>; Roper, Matthew D
> <matthew.d.roper@intel.com>; Deak, Imre <imre.deak@intel.com>; Shankar,
> Uma <uma.shankar@intel.com>; linux-kernel@vger.kernel.org; Nautiyal, Ankit K
> <ankit.k.nautiyal@intel.com>
> Subject: Re: [RFC][PATCH 5/5] drm/i915/display: Add Nearest-neighbor based
> integer scaling support
> 
> On Thu, Mar 12, 2020 at 09:13:24AM +0000, Laxminarayan Bharadiya, Pankaj
> wrote:
> >
> >
> > > -----Original Message-----
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Sent: 10 March 2020 21:47
> > > To: Laxminarayan Bharadiya, Pankaj
> > > <pankaj.laxminarayan.bharadiya@intel.com>
> > > Cc: jani.nikula@linux.intel.com; daniel@ffwll.ch; intel-
> > > gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org;
> > > airlied@linux.ie; maarten.lankhorst@linux.intel.com;
> > > tzimmermann@suse.de; mripard@kernel.org; mihail.atanassov@arm.com;
> > > Joonas Lahtinen <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo
> > > <rodrigo.vivi@intel.com>; Chris Wilson <chris@chris-wilson.co.uk>;
> > > Souza, Jose <jose.souza@intel.com>; De Marchi, Lucas
> > > <lucas.demarchi@intel.com>; Roper, Matthew D
> > > <matthew.d.roper@intel.com>; Deak, Imre <imre.deak@intel.com>;
> > > Shankar, Uma <uma.shankar@intel.com>; linux- kernel@vger.kernel.org;
> > > Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>
> > > Subject: Re: [RFC][PATCH 5/5] drm/i915/display: Add Nearest-neighbor
> > > based integer scaling support
> > >
> > > On Tue, Feb 25, 2020 at 12:35:45PM +0530, Pankaj Bharadiya wrote:
> > > > Integer scaling (IS) is a nearest-neighbor upscaling technique
> > > > that simply scales up the existing pixels by an integer (i.e.,
> > > > whole
> > > > number) multiplier.Nearest-neighbor (NN) interpolation works by
> > > > filling in the missing color values in the upscaled image with
> > > > that of the coordinate-mapped nearest source pixel value.
> > > >
> > > > Both IS and NN preserve the clarity of the original image. Integer
> > > > scaling is particularly useful for pixel art games that rely on
> > > > sharp, blocky images to deliver their distinctive look.
> > > >
> > > > Program the scaler filter coefficients to enable the NN filter if
> > > > scaling filter property is set to
> > > > DRM_SCALING_FILTER_NEAREST_NEIGHBOR
> > > > and enable integer scaling.
> > > >
> > > > Bspec: 49247
> > > >
> > > > Signed-off-by: Pankaj Bharadiya
> > > > <pankaj.laxminarayan.bharadiya@intel.com>
> > > > Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> > > > ---
> > > >  drivers/gpu/drm/i915/display/intel_display.c | 83
> > > > +++++++++++++++++++-  drivers/gpu/drm/i915/display/intel_display.h
> > > > +++++++++++++++++++|
> > > > 2 +  drivers/gpu/drm/i915/display/intel_sprite.c  | 20 +++--
> > > >  3 files changed, 97 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/i915/display/intel_display.c
> > > > b/drivers/gpu/drm/i915/display/intel_display.c
> > > > index b5903ef3c5a0..6d5f59203258 100644
> > > > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > > > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > > > @@ -6237,6 +6237,73 @@ void skl_scaler_disable(const struct
> > > intel_crtc_state *old_crtc_state)
> > > >  		skl_detach_scaler(crtc, i);
> > > >  }
> > > >
> > > > +/**
> > > > + *  Theory behind setting nearest-neighbor integer scaling:
> > > > + *
> > > > + *  17 phase of 7 taps requires 119 coefficients in 60 dwords per set.
> > > > + *  The letter represents the filter tap (D is the center tap)
> > > > +and the number
> > > > + *  represents the coefficient set for a phase (0-16).
> > > > + *
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |Index value | Data value coeffient 1 | Data value coeffient 2 |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   00h      |          B0            |          A0            |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   01h      |          D0            |          C0            |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   02h      |          F0            |          E0            |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   03h      |          A1            |          G0            |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   04h      |          C1            |          B1            |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   ...      |          ...           |          ...           |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   38h      |          B16           |          A16           |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   39h      |          D16           |          C16           |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   3Ah      |          F16           |          C16           |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *         |   3Bh      |        Reserved        |          G16           |
> > > > + *         +------------+------------------------+------------------------+
> > > > + *
> > > > + *  To enable nearest-neighbor scaling:  program scaler
> > > > +coefficents with
> > > > + *  the center tap (Dxx) values set to 1 and all other values set
> > > > +to
> > > > +0 as per
> > > > + *  SCALER_COEFFICIENT_FORMAT
> > > > + *
> > > > + */
> > > > +void skl_setup_nearest_neighbor_filter(struct drm_i915_private
> > > *dev_priv,
> > > > +				  enum pipe pipe, int scaler_id)
> > >
> > > skl_scaler_...
> > >
> > > > +{
> > > > +
> > > > +	int coeff = 0;
> > > > +	int phase = 0;
> > > > +	int tap;
> > > > +	int val = 0;
> > >
> > > Needlessly wide scope for most of these.
> > >
> > > > +
> > > > +	/*enable the index auto increment.*/
> > > > +	intel_de_write_fw(dev_priv, SKL_PS_COEF_INDEX_SET0(pipe,
> > > scaler_id),
> > > > +			  _PS_COEE_INDEX_AUTO_INC);
> > > > +
> > > > +	for (phase = 0; phase < 17; phase++) {
> > > > +		for (tap = 0; tap < 7; tap++) {
> > > > +			coeff++;
> > >
> > > Can be part of the % check.
> >
> > OK.
> >
> > >
> > > > +			if (tap == 3)
> > > > +				val = (phase % 2) ? (0x800) : (0x800 << 16);
> > >
> > > Parens overload.
> >
> > OK. Will remove.
> > >
> > > > +
> > > > +			if (coeff % 2 == 0) {
> > > > +				intel_de_write_fw(dev_priv,
> > > SKL_PS_COEF_DATA_SET0(pipe, scaler_id), val);
> > > > +				val = 0;
> > >
> > > Can drop this val=0 if you move the variable into tight scope and
> > > initialize there.
> >
> > Moving val=0 initialization to the tight scope will not work here as
> > we need to retain "val" and write only when 2 coefficients are ready
> > (since 2 coefficients are packed in 1 dword).
> >
> > e.g. for (12th , 11th)  coefficients, coefficient reg value should be ( (0 << 16) |
> 0x800).
> > If we initialize val = 0 in tight loop, 0 will be written to  coefficient register.
> 
> Hmm, right. I guess I'd try to rearrange this to iterate the registers directly
> instead of the phases and taps. Something like this perhaps:
> 
> static int cnl_coef_tap(int i)
> {
> 	return i % 7;
> }
> 
> static u16 cnl_coef(int t)

cnl_coef -> cnl_nearest_filter_coef.  Right?

> {
> 	return t == 3 ? 0x0800 : 0x3000;
> }
> 
> static void cnl_program_nearest_filter_coefs(void)
> {
> 	int i;
> 
> 	for (i = 0; i < 17 * 7; i += 2) {
> 		uint32_t tmp;
> 		int t;
> 
> 		t = cnl_coef_tap(i);
> 		tmp = cnl_nearest_filter_coef(t);
> 
> 		t = cnl_coef_tap(i + 1);
> 		tmp |= cnl_nearest_filter_coef(t) << 16;
> 
> 		intel_de_write_fw(tmp);
> 	}
> }
> 
> More readable I think. The downside being all those modulo operations but
> hopefully that's all in the noise when it comes to performance.

Looks better, thanks for spending time on this.
I will try this out.

Thanks,
Pankaj 
> 
> --
> Ville Syrjälä
> Intel
