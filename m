Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D1AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A8120700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDXGSG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:18:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:24165 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgDXGSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:18:05 -0400
IronPort-SDR: XsfrEoUXBWMjuIa+yga4mJn1c+hKQE3rrK6ZUTN/E+oQifx6BCa8r1tRIIRrzbiTD3/ZOOyIAX
 LRHv4MUsehSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 23:18:05 -0700
IronPort-SDR: CMMh7MOlW2PHOf69i2rCxZUoGQjBYXzGWUKRrghXshWnbMa4J890SrsF0POzKmQwBnpobtHclZ
 6P4wnWvYB6hA==
X-IronPort-AV: E=Sophos;i="5.73,310,1583222400"; 
   d="scan'208";a="430652200"
Received: from khelzel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.65])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 23:18:00 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org
Cc:     Guru Das Srinagesh <gurus@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6ni?= =?utf-8?Q?g?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v13 01/11] drm/i915: Use 64-bit division macro
In-Reply-To: <4a3acf8673c08308848fb7ae73d992b6feb758d3.1587523702.git.gurus@codeaurora.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1587523702.git.gurus@codeaurora.org> <4a3acf8673c08308848fb7ae73d992b6feb758d3.1587523702.git.gurus@codeaurora.org>
Date:   Fri, 24 Apr 2020 09:17:58 +0300
Message-ID: <87ftctbe5l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020, Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> Since the PWM framework is switching struct pwm_state.duty_cycle's
> datatype to u64, prepare for this transition by using DIV_ROUND_UP_ULL
> to handle a 64-bit dividend.
>
> To: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
>

Superfluous blank line.

Anyway, please preserve the existing acks and reviews [1] so people
don't have to do it again.

BR,
Jani.

[1] http://lore.kernel.org/r/87h7yleb0i.fsf@intel.com

> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/gpu/drm/i915/display/intel_panel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
> index 276f438..81547a0 100644
> --- a/drivers/gpu/drm/i915/display/intel_panel.c
> +++ b/drivers/gpu/drm/i915/display/intel_panel.c
> @@ -1920,7 +1920,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>  		return retval;
>  	}
>  
> -	level = DIV_ROUND_UP(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
> +	level = DIV_ROUND_UP_ULL(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
>  			     CRC_PMIC_PWM_PERIOD_NS);
>  	panel->backlight.level =
>  		intel_panel_compute_brightness(connector, level);

-- 
Jani Nikula, Intel Open Source Graphics Center
