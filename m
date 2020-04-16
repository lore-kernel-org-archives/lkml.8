Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6C6C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ED92064A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="BIA7OQsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgDPBpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgDPBpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:45:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00123C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:45:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id n10so19366996iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6cDJ9/jxc7iWgnjOZRxOI5nNKzNheaz7rQ3Dx98dlo=;
        b=BIA7OQsRl1ROJNQ1YvmltTTLBm+XKtsyULQj/bnfCx+MwjCnhqs4UgXDyIpe18RtN0
         xJbDEY8he8SaslRGlOVBNZrRQXwJqnHEQmp7z0bG1mwwFPreLEOzxmdH8ykozZ7G2VTp
         nBuHp+txb8V/7fq9OEWipEVRiBC/F8YuBVYKozGdfNremYW3lOM4QyVKK3ij9CgQPHAF
         UrKu9iLqgmtLrANGhRVdIq3HERcBDQBMHurShfxmKZAnFo24BpcvwjZct8CBP6x1Q+uB
         ydsxDCtFcHXzlMAGT6uflDBOzDhnx72fkyMAGhT8mEk4FSonrZQVSScEIs41w4S93NPW
         o1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6cDJ9/jxc7iWgnjOZRxOI5nNKzNheaz7rQ3Dx98dlo=;
        b=fzCJs69ECIj0LpcEXXmCfeBDbK9T1WL6BpxMfGVpmJNi9RPLfHtwoQEGl2LUEwUH5n
         uuN+HzC5w7QQuCt7RPpTNm6YoC2FRiL8zauCyUFvin/5OBuZjV69fkamnRhK2K6DUHv+
         TSL0Di8dT2o7YvtND6mDW8agGtsOj6GsW8wjXq0dUB3NsbjZAl4G+8m22GYVNM6D8kAx
         UiXkypYYQp1W2WAZkRTRTFOIelyHvNv/hgtEsbb7Btc/lTseXki5hbpfrSUmSb3wu655
         ozTDo7lxScsE1qvp/EZRh3Rq4n39nfL/labVLZDuxc5LGfTHF0KTDmUC8QLa187FnIzV
         uNfw==
X-Gm-Message-State: AGi0PuaC7aLXOEkD+D6hQI2FIKx0tvz5JCIXsBCM0SnL1Z++jvPwpbkA
        +SgODziA8rlKbQM4ckPVWtL5SjPeJSxtX7su+PiYXw==
X-Google-Smtp-Source: APiQypIZ8aw2BkFEI+uktQ5J/eBDiyByluk9OxNU0vFx2+RT36b49rAsrvrBVCo21epUnhqnV05MZQGuAUKXZsuq2MM=
X-Received: by 2002:a02:5249:: with SMTP id d70mr29141487jab.121.1587001510217;
 Wed, 15 Apr 2020 18:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200409195200.5483-1-mail@aurabindo.in> <87o8rumiqu.fsf@intel.com>
In-Reply-To: <87o8rumiqu.fsf@intel.com>
From:   Aurabindo Pillai <mail@aurabindo.in>
Date:   Wed, 15 Apr 2020 21:44:58 -0400
Message-ID: <CAMu4TMtb9f_zusEkUkDWzJMJ-uu8yciUUWxGybv2f4a+ER7B+Q@mail.gmail.com>
Subject: Re: [PATCH] drm: dpcd: Print more useful information during error
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DPCD access errors occur, knowing the register and request
associated with the error helps debugging, so print the
details in the debug message.

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/drm_dp_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index c6fbe6e6b..8aafc01f5 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -257,7 +257,9 @@ static int drm_dp_dpcd_access(struct drm_dp_aux
*aux, u8 request,
                        err = ret;
        }

-       DRM_DEBUG_KMS("Too many retries, giving up. First error: %d\n", err);
+       DRM_DEBUG_KMS("dpcd: Too many retries, giving up. First error: %d,"
+                     " address: 0x%x, request: 0x%x, size:%zu\n",
+                     err, msg.address, msg.request, msg.size);
        ret = err;

 unlock:
--
2.26.0

On Tue, Apr 14, 2020 at 7:04 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Thu, 09 Apr 2020, Aurabindo Pillai <mail@aurabindo.in> wrote:
> > When DPCD access errors occur, knowing the register and request
> > associated with the error helps debugging, so print the
> > details in the debug message.
> >
> > Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
> > ---
> >  drivers/gpu/drm/drm_dp_helper.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> > index a5364b519..545606aac 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -257,7 +257,9 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
> >                       err = ret;
> >       }
> >
> > -     DRM_DEBUG_KMS("Too many retries, giving up. First error: %d\n", err);
> > +     DRM_DEBUG_KMS("dpcd: Too many retries, giving up. First error: %d\t"
> > +                   "address: %x\trequest: %x\t size:%zu\n",
> > +                   err, msg.address, msg.request, msg.size);
>
> Nitpicks, please don't add tabs, maybe use commas instead, and please
> add 0x in front of hex.
>
> BR,
> Jani.
>
>
> >       ret = err;
> >
> >  unlock:
>
> --
> Jani Nikula, Intel Open Source Graphics Center



-- 

Thanks and Regards,

Aurabindo J Pillai
https://aurabindo.in
