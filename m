Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E9B20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtsQDREJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGUM75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgGUM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:59:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F2FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:59:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so21128610wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BaY+bOJZPzcrjL03hDvO676LLEy7U4Oxk/5k+DjWQmQ=;
        b=gtsQDREJvZ02RLrtJIooZ9Nk+w2uKvLIsPvI65bckkx9PIZYKSTBQOcikMe9vM9SEJ
         3y5B5fBGJcXO4R0tLdAlTgcm6kLfn16ICl1qcMEmTcVsbUxUlL05FEQHUzGgXdW/6gDU
         2Uv4HJQAwbkQkqsR0ad8btUacjtZ3nWFNETh9U7zkqtMka3wpwEBGAXYdbWOuTC2QlXW
         zjqYZfFjB9nA5cYyp89OHqabKP89XuqbPoUKUVpJB8Ysax/RFkEpPv1wxG4YY/xe9huP
         O2kB4zxGljyyVhO4QbNGGvXnQ36/d+I6TohSQWfcMiv9WjpwG42aY0W7kPpWTgaUgKVq
         La2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BaY+bOJZPzcrjL03hDvO676LLEy7U4Oxk/5k+DjWQmQ=;
        b=LnkHWKSmIssK/CTV0vf4zMS4jK2kxVKTEZ4gvdcCWnvm5AQR993nFwtOcO+xZsLTlL
         lO5J7w4GWLXd79KjPQsHoOYEvSwGLjA79PvP48AJkL5yaEQvMng6SGQ5JdxlBNhWnrAp
         7xCJmQOvVEo5ofoVCmxs7b4c7e1BCTKQSoL83hBgIIoJAlWp1AvGVILLW3n2r3R6+u80
         G+kiwo7HYs8SIUFedDKHtMhcmnV9mgqWbhxP9xKbNguuo3i87YbMaN1f7JmSFlCYK1Z5
         f5so7Z7SFk2gS3kqPql7Bb2DzcEQyuAGek6gvPwfgalCAY94Xg/OJIvmbMe52h+o045i
         vI/w==
X-Gm-Message-State: AOAM5335qGlUHffbKRZoXAyXKOmR7LdVFKeXoFsrenHahVcFAN+/rESJ
        lgC4gRBaxrLJmPXVR3C+Nm8=
X-Google-Smtp-Source: ABdhPJwmxHBLT52cSoniH/zdLDc3boXEeiBPiiAyp/9AwMv9yVllNHcMarnV/QEBWSutgRN/V4LrLA==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr28629204wrs.105.1595336395042;
        Tue, 21 Jul 2020 05:59:55 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id d132sm3314604wmd.35.2020.07.21.05.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 05:59:54 -0700 (PDT)
Date:   Tue, 21 Jul 2020 09:59:47 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: add wait_for_vblanks in atomic_commit_tail
Message-ID: <20200721125947.2gc5du327fwukwrh@smtp.gmail.com>
References: <20200714102009.4qxgdq5bkpwhhhio@smtp.gmail.com>
 <CAJeY4oF9k--dGOYaC9qAXiVbx6aX2a6isXpfOg+JV2s+UskKGA@mail.gmail.com>
 <20200714140904.GF3278063@phenom.ffwll.local>
 <20200714183513.6zah7wqlo2bpalum@smtp.gmail.com>
 <CAKMK7uFF=CuuTQQJ+MSZD-7+gDzcN-jKB3Uojgps+hY0jdz1bg@mail.gmail.com>
 <20200715124337.GA18441@realwakka>
 <20200715155715.73zaveklxrakib37@smtp.gmail.com>
 <CAKMK7uFLwyLgP3tAmw3s-PC0m_1CaNKR1aLvO3ES1PrTAdX-6A@mail.gmail.com>
 <20200721053300.GA2338@realwakka>
 <20200721064422.GZ3278063@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721064422.GZ3278063@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I traced the subtests' execution to figure out what happens (or not) in
a clean run and a blocked run, and this led me to suspect the
vkms_crtc_atomic_flush function. Examining the code and considering the
DRM doc, it seemed to me that a drm_crtc_vblank_get call was missing a
drm_crtc_vblank_put pair. So I checked it that way, and again, the
problem of sequential execution + dpms/suspend failures disappeared.

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index ac85e17428f8..f60bf1495306 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -240,30 +240,31 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
                spin_lock(&crtc->dev->event_lock);

                if (drm_crtc_vblank_get(crtc) != 0)
                        drm_crtc_send_vblank_event(crtc, crtc->state->event);
                else
                        drm_crtc_arm_vblank_event(crtc, crtc->state->event);

                spin_unlock(&crtc->dev->event_lock);

                crtc->state->event = NULL;
        }

        vkms_output->composer_state = to_vkms_crtc_state(crtc->state);

        spin_unlock_irq(&vkms_output->lock);
+       drm_crtc_vblank_put(crtc);
 }

However, I'm not sure if it's just another duck-tape proposal or if it
makes any sense. I'm still investigating better, but I think sharing
with you may be more productive.

Melissa

On 07/21, Daniel Vetter wrote:
> On Tue, Jul 21, 2020 at 05:33:00AM +0000, Sidong Yang wrote:
> > Hi, Daniel and Melissa
> > 
> > I tested some code for this problem trying to find the code that make problem in igt test.
> > kms_cursor_crc test in igt test has 3 steps (preparation, test, cleanup). I check each steps
> > and I found that without cleanup step, the problem solved.
> > In cleanup step, igt test code seems like this.
> > 
> > drmModeSetCrtc(display->drm_fd, crtc_id, 0 /* fb_id */, 0, 
> > 		0 /* x, y */, NULL /* connector */, 0, NULL /* mode */)
> > 
> > I commented out this function call and there is no problem in executing tests repeatedly.
> > I'm trying to find out what's happen in this call. but don't know until now
> > I hope this information help to solve the problem.
> 
> Ah yes that fits the evidence we have from Melissa pretty well: Not
> turning off the CRTC means the next test wont have to turn it back on
> again. And the vblank bug seems to be in the code which turns the crtc
> back on. At least inserting a vblank wait in there is enough to paper over
> all the issues, per Melissa's testing.
> 
> So at least we're now fairly confident where the bug is, that's some solid
> progress.
> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
