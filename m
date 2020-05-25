Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F71CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7648F20888
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404018AbgEYO4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:56:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:13085 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403968AbgEYO4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:56:18 -0400
IronPort-SDR: RXLad5Uf3m4YGogEpgRh+kcE91mwYxvuBICv/esmBpVYWF2iXWt7v1Fv4TOSwMSP3/DLXbDnnR
 W6vtvdF/7GuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:56:17 -0700
IronPort-SDR: B44q6ENq+sjvMZghAEYZYCb1gmzAhhgnKk5yUhY1iwnBYuji80kJ0EylSOFOIiIA5FZ/dCYkla
 HnHpoRegjUPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="310021532"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 25 May 2020 07:56:15 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 25 May 2020 17:56:14 +0300
Date:   Mon, 25 May 2020 17:56:14 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     chenxb_99091@126.com, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: fix setting of plane_mask in pan_display_atomic()
 function for linux-4.4
Message-ID: <20200525145614.GB6112@intel.com>
References: <1590205747-19599-1-git-send-email-chenxb_99091@126.com>
 <20200525143428.GG206103@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525143428.GG206103@phenom.ffwll.local>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 04:34:28PM +0200, Daniel Vetter wrote:
> On Sat, May 23, 2020 at 11:49:07AM +0800, chenxb_99091@126.com wrote:
> > From: Xuebing Chen <chenxb_99091@126.com>
> > 
> > The <include/drm/drm_crtc.h> provides drm_for_each_plane_mask macro and
> > plane_mask is defined as bitmask of plane indices, such as
> > 1<<drm_plane_index(plane). This patch fixes error setting of plane_mask
> > in pan_display_atomic() function.
> > 
> > Signed-off-by: Xuebing Chen <chenxb_99091@126.com>
> 
> What kernel is this patch against? Latest upstream doesn't have any such
> code anymore ... I'm assuming that Ville fixed this in one of his patches,
> but I can't find the right one just now.

Looks to be gone in
commit e00fb8564ee9 ("drm: Stop updating plane->crtc/fb/old_fb on
atomic drivers"), in 2018.

Also seems this 1<< bug was already fixed in
commit 7118fd9bd975 ("drm/fb-helper: Use proper plane mask for fb
cleanup") ... in 2015!

Might be a good idea to invest in an upgrade if you're still using
such old kernel releases.

> -Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_fb_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index e449f22..6a9f7ee 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -1256,7 +1256,7 @@ retry:
> >  			goto fail;
> >  
> >  		plane = mode_set->crtc->primary;
> > -		plane_mask |= drm_plane_index(plane);
> > +		plane_mask |= 1 << drm_plane_index(plane);
> >  		plane->old_fb = plane->fb;
> >  	}
> >  
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
