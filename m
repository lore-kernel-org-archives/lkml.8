Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBAEC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07912070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCSTfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:35:53 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:51104 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbgCSTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:35:53 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Mar 2020 12:35:52 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 19 Mar 2020 12:35:52 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 267874BBA; Thu, 19 Mar 2020 12:35:52 -0700 (PDT)
Date:   Thu, 19 Mar 2020 12:35:52 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v9 01/11] drm/i915: Use 64-bit division macro
Message-ID: <20200319193551.GA23396@codeaurora.org>
References: <cover.1584473399.git.gurus@codeaurora.org>
 <19661821c8eb32291e72ec091c267f915c365c52.1584473399.git.gurus@codeaurora.org>
 <87h7yleb0i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7yleb0i.fsf@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 09:08:45PM +0200, Jani Nikula wrote:
> On Tue, 17 Mar 2020, Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> > Since the PWM framework is switching struct pwm_state.duty_cycle's
> > datatype to u64, prepare for this transition by using DIV_ROUND_UP_ULL
> > to handle a 64-bit dividend.
> >
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thanks!

> Also ack for merging this via whichever tree you prefer; please let me
> know if you want me to take this via drm-intel.

I'm not sure if this patch can be taken via drm-intel in isolation as it
is part of a series... Will let you know if I need to make such a
request.

Thank you.

Guru Das.
