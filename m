Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58895C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927C2072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbgCCSCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:02:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:25490 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388130AbgCCSCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:02:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 10:02:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233714477"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 03 Mar 2020 10:02:00 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 03 Mar 2020 20:01:59 +0200
Date:   Tue, 3 Mar 2020 20:01:59 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: Distribute switch variables for initialization
Message-ID: <20200303180159.GA13686@intel.com>
References: <20200220062229.68762-1-keescook@chromium.org>
 <202003022038.07A611E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003022038.07A611E@keescook>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 08:39:37PM -0800, Kees Cook wrote:
> On Wed, Feb 19, 2020 at 10:22:29PM -0800, Kees Cook wrote:
> > Variables declared in a switch statement before any case statements
> > cannot be automatically initialized with compiler instrumentation (as
> > they are not part of any execution flow). With GCC's proposed automatic
> > stack variable initialization feature, this triggers a warning (and they
> > don't get initialized). Clang's automatic stack variable initialization
> > (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> > doesn't initialize such variables[1]. Note that these warnings (or silent
> > skipping) happen before the dead-store elimination optimization phase,
> > so even when the automatic initializations are later elided in favor of
> > direct initializations, the warnings remain.
> > 
> > To avoid these problems, move such variables into the "case" where
> > they're used or lift them up into the main function body.
> > 
> > drivers/gpu/drm/drm_edid.c: In function ‘drm_edid_to_eld’:
> > drivers/gpu/drm/drm_edid.c:4395:9: warning: statement will never be executed [-Wswitch-unreachable]
> >  4395 |     int sad_count;
> >       |         ^~~~~~~~~
> > 
> > [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Ping. Can someone pick this up, please?
> 
> Thanks!
> 
> -Kees
> 
> > ---
> >  drivers/gpu/drm/drm_edid.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 805fb004c8eb..2941b65b427f 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -4392,9 +4392,9 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
> >  			dbl = cea_db_payload_len(db);
> >  
> >  			switch (cea_db_tag(db)) {
> > -				int sad_count;
> > +			case AUDIO_BLOCK: {

I've never been a fan of {} inside switch statements. I'd just
move this one level up.

> >  
> > -			case AUDIO_BLOCK:
> > +				int sad_count;
> >  				/* Audio Data Block, contains SADs */
> >  				sad_count = min(dbl / 3, 15 - total_sad_count);
> >  				if (sad_count >= 1)
> > @@ -4402,6 +4402,7 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
> >  					       &db[1], sad_count * 3);
> >  				total_sad_count += sad_count;
> >  				break;
> > +			}
> >  			case SPEAKER_BLOCK:
> >  				/* Speaker Allocation Data Block */
> >  				if (dbl >= 1)
> > 
> 
> -- 
> Kees Cook
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
