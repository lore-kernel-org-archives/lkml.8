Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54019C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F061208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iTWHWXN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCCIVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:21:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33296 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgCCIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:21:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id a20so2188742otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GUKiYpi9FYS09yZZU0VyVoSg4aODr62keM14BQquORs=;
        b=iTWHWXN1cBYaPALi8BmMvDHdDzP0pKeUtHzIMaZWEkPiFOOdEMBDcTNEIqY961Mb8h
         LbLyoMlq1lKaFpSLXNK3VlkxsJ5KXgQhZaXfV5s4O24srTrobcEMWdltxWq0MqlNjLW1
         IgAJ+fkveUQq17XOSt7mVFTzXwRn4y6SiVqHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GUKiYpi9FYS09yZZU0VyVoSg4aODr62keM14BQquORs=;
        b=aa6wxUUU7YfGYgvI89LpbmsxSbAe3KRJuYD3KhX6lPj9G8TIHvfacvxLpDOh46hNvu
         Q9JUl3zVxV6Us1x9d/ekHSDqzPzX15IbgjhDrqMbZdoWcXZaJPwDA/Uv927LA9cT3tOX
         XO/yF7GRTpxbldiMAvwqyT94BTvdQYGoBrtdRn8GV9dHMOsgJCmqQYJYFJvmmKwKiQ0a
         3ke0EbkajnRnEELXCtbTx85RxJWaG8jFn77QC+eHVokUMuTnbkxrzVZBFzVYCBDAl3Lf
         FutjLQDot9CUTrcZ2+1Tm/L8hvt9+2J/EyxPW21Hq2vP47IEBTmi8EPiU4NeGzloVY1w
         dxRg==
X-Gm-Message-State: ANhLgQ345iPQwnKb687Mbn0aG6iserKUJ0+TWC0HKtUQIquZ/mcAL28D
        eNw4fc3Gcita1XeieQTJBqPAE5YJpiKMndjqI3Q2tg==
X-Google-Smtp-Source: ADFU+vsWv/xGzR65hrkCy9io6KB5BpW2YoarmWrhIlXJBLbFY6jxN/402N6iCd/Q1ExpqXqPKFR3bzRtUMOm2cVQ7N8=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr676037otk.106.1583223698573;
 Tue, 03 Mar 2020 00:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20200220062229.68762-1-keescook@chromium.org> <202003022038.07A611E@keescook>
In-Reply-To: <202003022038.07A611E@keescook>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 3 Mar 2020 09:21:26 +0100
Message-ID: <CAKMK7uHRppv==G+Ep4S48dPMKZ9EwZGOt3WwWGXJiv+bXR-0SA@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Distribute switch variables for initialization
To:     Kees Cook <keescook@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alexander Potapenko <glider@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 5:39 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Feb 19, 2020 at 10:22:29PM -0800, Kees Cook wrote:
> > Variables declared in a switch statement before any case statements
> > cannot be automatically initialized with compiler instrumentation (as
> > they are not part of any execution flow). With GCC's proposed automatic
> > stack variable initialization feature, this triggers a warning (and the=
y
> > don't get initialized). Clang's automatic stack variable initialization
> > (via CONFIG_INIT_STACK_ALL=3Dy) doesn't throw a warning, but it also
> > doesn't initialize such variables[1]. Note that these warnings (or sile=
nt
> > skipping) happen before the dead-store elimination optimization phase,
> > so even when the automatic initializations are later elided in favor of
> > direct initializations, the warnings remain.
> >
> > To avoid these problems, move such variables into the "case" where
> > they're used or lift them up into the main function body.
> >
> > drivers/gpu/drm/drm_edid.c: In function =E2=80=98drm_edid_to_eld=E2=80=
=99:
> > drivers/gpu/drm/drm_edid.c:4395:9: warning: statement will never be exe=
cuted [-Wswitch-unreachable]
> >  4395 |     int sad_count;
> >       |         ^~~~~~~~~
> >
> > [1] https://bugs.llvm.org/show_bug.cgi?id=3D44916
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Ping. Can someone pick this up, please?

Whatever the reasons, but your original patch didn't make it through
to dri-devel. Can you pls resubmit?

Thanks, Daniel

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
> > @@ -4392,9 +4392,9 @@ static void drm_edid_to_eld(struct drm_connector =
*connector, struct edid *edid)
> >                       dbl =3D cea_db_payload_len(db);
> >
> >                       switch (cea_db_tag(db)) {
> > -                             int sad_count;
> > +                     case AUDIO_BLOCK: {
> >
> > -                     case AUDIO_BLOCK:
> > +                             int sad_count;
> >                               /* Audio Data Block, contains SADs */
> >                               sad_count =3D min(dbl / 3, 15 - total_sad=
_count);
> >                               if (sad_count >=3D 1)
> > @@ -4402,6 +4402,7 @@ static void drm_edid_to_eld(struct drm_connector =
*connector, struct edid *edid)
> >                                              &db[1], sad_count * 3);
> >                               total_sad_count +=3D sad_count;
> >                               break;
> > +                     }
> >                       case SPEAKER_BLOCK:
> >                               /* Speaker Allocation Data Block */
> >                               if (dbl >=3D 1)
> >
>
> --
> Kees Cook



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
