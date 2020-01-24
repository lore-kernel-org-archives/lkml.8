Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE89C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6770206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9QS/q0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbgAXKS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:18:57 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46784 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbgAXKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:18:56 -0500
Received: by mail-qv1-f66.google.com with SMTP id u1so620560qvk.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0veyCUqrTy58lbkF11Bet/SvIre531kekpYNQJUe2M=;
        b=g9QS/q0utfNTJTVotzHW2LuXRhtmHrDBaZ7INqs9fp0LdVBrqNtJGfG/mw0j78osZk
         6WCR6u7G6HydfuwzEIhK7mHJhRcTj3vTC87VaV5D3fy85bufhdvjOI7mhQ/6fN0Ly0W6
         YK+MpRw6o8mH31CL2cPNRCo+KPxh9YiGw0UMYawRPXidLjRsFXVflE77/nQEYQnalhzr
         iSg2edYXGHopQ8aBLufSs9rEEkAhklydmvpak8JLgGgNwjxo1oX+96L1UwAZPp69W9I0
         X+kgjFWfW3Jl0QYejYB2hEfx7jC9bfWzTdXDcogQ+DWfBfKymw/0HY65t89a8g+199u5
         QkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0veyCUqrTy58lbkF11Bet/SvIre531kekpYNQJUe2M=;
        b=MSHomrIC1eFsXcCk2dxYORG1LbsgoECoxgfAY2sTHv9yr7dybsY1m2PTVKGr4iYN3Z
         amD0TZizv1suJva8vAJDk9qa3Wutyis8jvpdsE1hs741hcfEh/t9jBSX8sVgb7TrQkIC
         Y8U9fO0BPW+Co9Zm9lB9svujASo7/q3+jSSfTHTZDEWrCEtu/GF5RoHBzuKBaDwrrESN
         IDoWLhGUebvOdWQn5eMUgSMaW88aF4Xjk52GP5E1WcHvxDf6NI0dtS7i4GYxu/Y0CM55
         fNmxMRcJRO9hHqcnGOwaCr5XI+ayLT60FHHrbvKUgbfUDjRE8AWBu3XsrooTM48RFnLM
         wduQ==
X-Gm-Message-State: APjAAAW8G4kF+JCVE4qL4s/YWUc7LTGAmA26hzkF2jEHxVTBU0Q+M1A3
        QaKwi1EDpzlTEsOTBc9hunuGbLhcTeSEZvhdghA=
X-Google-Smtp-Source: APXvYqzwGZsd8oZGp5EYk5uHfEPCzrWjui4Vu6C6zY1OuIRUv30YR5wbUI5fw84EeGQSwfsfhW3pHlpT21GZKhi3g0s=
X-Received: by 2002:a05:6214:707:: with SMTP id b7mr1936520qvz.97.1579861135198;
 Fri, 24 Jan 2020 02:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20200104122217.148883-1-dor.askayo@gmail.com> <CAO80jNS795mgHCp3XedZQ1o1QHbwxb8DeuSqPtKHmKbAVYsfmg@mail.gmail.com>
In-Reply-To: <CAO80jNS795mgHCp3XedZQ1o1QHbwxb8DeuSqPtKHmKbAVYsfmg@mail.gmail.com>
From:   Dor Askayo <dor.askayo@gmail.com>
Date:   Fri, 24 Jan 2020 12:18:43 +0200
Message-ID: <CAO80jNS6fV+8s1R5CH9swbkDB+-RmZADFvA0UkBmWG2bEQioPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: do not allocate display_mode_lib unnecessarily
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:59 PM Dor Askayo <dor.askayo@gmail.com> wrote:
>
> On Sat, Jan 4, 2020 at 2:23 PM Dor Askayo <dor.askayo@gmail.com> wrote:
> >
> > This allocation isn't required and can fail when resuming from suspend.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/issues/1009
> > Signed-off-by: Dor Askayo <dor.askayo@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index dd4731ab935c..83ebb716166b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -2179,12 +2179,7 @@ void dc_set_power_state(
> >         enum dc_acpi_cm_power_state power_state)
> >  {
> >         struct kref refcount;
> > -       struct display_mode_lib *dml = kzalloc(sizeof(struct display_mode_lib),
> > -                                               GFP_KERNEL);
> > -
> > -       ASSERT(dml);
> > -       if (!dml)
> > -               return;
> > +       struct display_mode_lib *dml;
> >
> >         switch (power_state) {
> >         case DC_ACPI_CM_POWER_STATE_D0:
> > @@ -2206,6 +2201,12 @@ void dc_set_power_state(
> >                  * clean state, and dc hw programming optimizations will not
> >                  * cause any trouble.
> >                  */
> > +               dml = kzalloc(sizeof(struct display_mode_lib),
> > +                               GFP_KERNEL);
> > +
> > +               ASSERT(dml);
> > +               if (!dml)
> > +                       return;
> >
> >                 /* Preserve refcount */
> >                 refcount = dc->current_state->refcount;
> > @@ -2219,10 +2220,10 @@ void dc_set_power_state(
> >                 dc->current_state->refcount = refcount;
> >                 dc->current_state->bw_ctx.dml = *dml;
> >
> > +               kfree(dml);
> > +
> >                 break;
> >         }
> > -
> > -       kfree(dml);
> >  }
> >
> >  void dc_resume(struct dc *dc)
> > --
> > 2.24.1
> >
>
> I've been running with this fix applied on top of Fedora's
> 5.3.16-300.fc31.x86_64 kernel for the past two weeks, suspending
> and resuming often. This the first time since I bought my RX 580 8GB
> more than a year ago that I can suspend and resume reliably.
>
> I'd appreciate a quick review for the above, it really is a trivial change.
>
> Thanks,
> Dor

Bumping this up again. I've been running with this change for the past
20 days without issues.

Thanks,
Dor

On Fri, Jan 17, 2020 at 12:59 PM Dor Askayo <dor.askayo@gmail.com> wrote:
>
> On Sat, Jan 4, 2020 at 2:23 PM Dor Askayo <dor.askayo@gmail.com> wrote:
> >
> > This allocation isn't required and can fail when resuming from suspend.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/issues/1009
> > Signed-off-by: Dor Askayo <dor.askayo@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index dd4731ab935c..83ebb716166b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -2179,12 +2179,7 @@ void dc_set_power_state(
> >         enum dc_acpi_cm_power_state power_state)
> >  {
> >         struct kref refcount;
> > -       struct display_mode_lib *dml = kzalloc(sizeof(struct display_mode_lib),
> > -                                               GFP_KERNEL);
> > -
> > -       ASSERT(dml);
> > -       if (!dml)
> > -               return;
> > +       struct display_mode_lib *dml;
> >
> >         switch (power_state) {
> >         case DC_ACPI_CM_POWER_STATE_D0:
> > @@ -2206,6 +2201,12 @@ void dc_set_power_state(
> >                  * clean state, and dc hw programming optimizations will not
> >                  * cause any trouble.
> >                  */
> > +               dml = kzalloc(sizeof(struct display_mode_lib),
> > +                               GFP_KERNEL);
> > +
> > +               ASSERT(dml);
> > +               if (!dml)
> > +                       return;
> >
> >                 /* Preserve refcount */
> >                 refcount = dc->current_state->refcount;
> > @@ -2219,10 +2220,10 @@ void dc_set_power_state(
> >                 dc->current_state->refcount = refcount;
> >                 dc->current_state->bw_ctx.dml = *dml;
> >
> > +               kfree(dml);
> > +
> >                 break;
> >         }
> > -
> > -       kfree(dml);
> >  }
> >
> >  void dc_resume(struct dc *dc)
> > --
> > 2.24.1
> >
>
> I've been running with this fix applied on top of Fedora's
> 5.3.16-300.fc31.x86_64 kernel for
> the past two weeks, suspending and resuming often. This the first time
> since I bought my
> RX 580 8GB more than a year ago that I can suspend and resume reliably.
>
> I'd appreciate a quick review for the above, it really is a trivial change.
>
> Thanks,
> Dor
