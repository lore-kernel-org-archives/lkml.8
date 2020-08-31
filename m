Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05B2C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8174320719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHaNtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:49:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:26946 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgHaNs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:48:57 -0400
IronPort-SDR: 0l99W3q1Ky5Mz36VpdeTCFo5HleKfJZi+QisZ6ZHoCaAx2rR1ut66vXSIrGSg1oGp43WMoBou7
 CU90oS9HFDPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="241780423"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="241780423"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 06:48:56 -0700
IronPort-SDR: +WXLvQCAMtnWxKSYRmdzn2TzoQF9SyFy9BhcDHXju9pp0rbo7+nRo15G4MjGm87MCJ7AHdfeG+
 9Uw13z7CzEhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="283089622"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 31 Aug 2020 06:48:53 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 31 Aug 2020 16:48:52 +0300
Date:   Mon, 31 Aug 2020 16:48:52 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Simon Ser <contact@emersion.fr>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>
Subject: Re: [PATCH] drm/vkms: add support for gamma_set interface
Message-ID: <20200831134852.GY6112@intel.com>
References: <20200829140647.7626-1-realwakka@gmail.com>
 <UeJwFKvmNgKdZY_icN0-nrFly9R1vbzaMZ-TiyxIIPBcdl278uZsK6YdTTdRl6rFukBAmN-eyCFpnfsIB-El9QpyYiutdcpgJg64n4tsRRc=@emersion.fr>
 <20200831133858.GA9280@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200831133858.GA9280@realwakka>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 01:38:58PM +0000, Sidong Yang wrote:
> On Mon, Aug 31, 2020 at 11:39:10AM +0000, Simon Ser wrote:
> > On Saturday, August 29, 2020 4:06 PM, Sidong Yang <realwakka@gmail.com> wrote:
> > 
> > > Currently vkms module doesn't support gamma function for userspace. so igt
> > > subtests in kms_plane(pixel-format-pipe-A-plan) failed for calling
> > > drmModeCrtcSetGamma().
> > 
> 
> Hi, Simon.
> Thanks for review.
> 
> > It doesn't seem like this IGT test's goal is to exercise support for
> > gamma LUTs. Does the test just tries to reset the gamma LUT to linear?
> > If so, I think the IGT test should be fixed to ignore "I don't support
> > gamma" errors.
> 
> It seems like that IGT test pixel-format is to make gamma lut like below.
> 
> for (i = 0; i < lut_size; i++)
> 	lut[i] = (i * 0xffff / (lut_size - 1)) & mask;
> 
> And set this table to drm driver. and test begins. It's the test about pixel 
> format. I think you're right. It's not about gamma lut.

The point of the gamma LUT stuff in the pixel format test is to throw
away a bunch of the lsbs so that the test passes when the result is
"close enough" to the 8bpc RGB reference image. Without it we would
never get a crc match when testing non-8bpc or YCbCr formats.


> > 
> > > This patch set gamma_set interface in vkms_crtc_funcs for
> > > support gamma function. With initializing crtc, added calls for setting gamma
> > > size. it pass the test after this patch.
> > >
> > > Cc: Daniel Vetter<daniel@ffwll.ch>
> > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > >
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_crtc.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > index ac85e17428f8..643435fb2ee6 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > @@ -160,6 +160,7 @@ static const struct drm_crtc_funcs vkms_crtc_funcs = {
> > >  	.get_crc_sources	= vkms_get_crc_sources,
> > >  	.set_crc_source		= vkms_set_crc_source,
> > >  	.verify_crc_source	= vkms_verify_crc_source,
> > > +	.gamma_set		= drm_atomic_helper_legacy_gamma_set,
> > 
> > Why does VKMS need to use a legacy helper?
> 
> drm_crtc_enable_color_mgmt() enables properties about gamma/degamma lut. And 
> legacy helper just saves lut data from userspace to drm property blob. It seems 
> that it's convenient way to implement .gamma_set.
> 
> > It seems like this patch just advertises support for gamma LUTs, but
> > ignores any value set by user-space. If VKMS advertises support for
> > gamma LUTs, it needs to take the LUT into account when blending planes.
> 
> Yes, This patch doesn't use gamma lut passed by user. lut should be used for 
> calculating pixel value. For vkms, Maybe lut will be used in making crc value?
> If so, I'll try to write next patch for it.
> 
> Thanks,
> -Sidong
> 
> > 
> > >  };
> > >
> > >  static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
> > > @@ -275,6 +276,13 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> > >  		return ret;
> > >  	}
> > >
> > > +	ret = drm_mode_crtc_set_gamma_size(crtc, 256);
> > > +	if (ret) {
> > > +		DRM_ERROR("Failed to set gamma size\n");
> > > +		return ret;
> > > +	}
> > > +	drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
> > > +
> > >  	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
> > >
> > >  	spin_lock_init(&vkms_out->lock);
> > > --
> > > 2.17.1
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
