Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B062C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B0620720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGNMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:12:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:14474 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGNMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:12:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 05:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,413,1574150400"; 
   d="scan'208";a="225551123"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 07 Feb 2020 05:12:01 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 07 Feb 2020 15:12:01 +0200
Date:   Fri, 7 Feb 2020 15:12:01 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Tom Anderson <thomasanderson@google.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Error building v5.5-git on PowerPC32 - bisected to commit
 7befe621ff81
Message-ID: <20200207131201.GX13686@intel.com>
References: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 04:46:52PM -0600, Larry Finger wrote:
> When building post V5.5 on my PowerBook G4 Aluminum, the build failed with the 
> following error:

It shouldn't be in 5.5

There's a fix queued
https://cgit.freedesktop.org/drm-misc/commit/?h=drm-misc-next-fixes&id=e1cf35b94c5fd122a8780587559fc6da9fc2dd12

Does that work for you?

> 
> drivers/gpu/drm/drm_edid.c: In function ‘cea_mode_alternate_timings’:
> drivers/gpu/drm/drm_edid.c:3275:2: error: call to ‘__compiletime_assert_3282’ 
> declared with attribute error: BUILD_BUG_ON failed: cea_mode_for_vic(8)->vtotal 
> != 262 || cea_mode_for_vic(9)->vtotal != 262 || cea_mode_for_vic(12)->vtotal != 
> 262 || cea_mode_for_vic(13)->vtotal != 262 || cea_mode_for_vic(23)->vtotal != 
> 312 || cea_mode_for_vic(24)->vtotal != 312 || cea_mode_for_vic(27)->vtotal != 
> 312 || cea_mode_for_vic(28)->vtotal != 312
> 
> This error was bisected to commit 7befe621ff81 ("drm/edid: Abstract away 
> cea_edid_modes[]").
> 
> This problem is clearly a problem with the gcc compiler on the box, namely gcc 
> (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3. I had no success finding why the 
> attributes were wrong, and finally settled on the following hack:
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 99769d6c9f84..062bbe2b254a 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -3272,6 +3272,7 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode 
> *mode)
>           * get the other variants by simply increasing the
>           * vertical front porch length.
>           */
> +#ifndef CONFIG_PPC32
>          BUILD_BUG_ON(cea_mode_for_vic(8)->vtotal != 262 ||
>                       cea_mode_for_vic(9)->vtotal != 262 ||
>                       cea_mode_for_vic(12)->vtotal != 262 ||
> @@ -3280,6 +3281,7 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode 
> *mode)
>                       cea_mode_for_vic(24)->vtotal != 312 ||
>                       cea_mode_for_vic(27)->vtotal != 312 ||
>                       cea_mode_for_vic(28)->vtotal != 312);
> +#endif
> 
>          if (((vic == 8 || vic == 9 ||
>                vic == 12 || vic == 13) && mode->vtotal < 263) ||
> 
> Disabling the build check allows me to build and test the post v5.5 versions.
> 
> Larry

-- 
Ville Syrjälä
Intel
