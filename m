Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D364C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABFA20656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0br/Nlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFRhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:37:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39973 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCFRhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:37:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so1139004plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NeDvLUIAgc3P9ZWfiEiKoaXL/UdWw2NQZoEeQ03LjSg=;
        b=D0br/NlbNxvoL9TXlmxeq92xR9LOySVqWPptgRmI7yZBh9lwwKWTBqYrzAJOiSIT6a
         0W95ydJ1+00kpx5Mzqz5n7INFYoaj80fuF5VUbUwI1G+J1Ta1+ImQWdHUFGQm/jTzQu4
         Y9wLWhHQ56EgWO4PESPp+axZxaAuyctFrpMaaiTcl6WnCgxpomvujEKVxEcYfR8WROz4
         /4whbR9iPH57mNyyILuffYjfU94um5guvxF4f1Ls4W1QBnFh17cSCigZUwzqdzhE4eNb
         iMeCcgsup7m5GmYkVfdJtGXwHvXZDcypm8dbt4kdrojliB2+eRuPMMkqMrzBnaaLRVkf
         BiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NeDvLUIAgc3P9ZWfiEiKoaXL/UdWw2NQZoEeQ03LjSg=;
        b=Z+ymMoRYIwk68qoXPQKbqXFwIdzkxHSPxCrD7xbRpmfFR9Acz/FwrRn5mw5CzT0dxO
         11xCFRv5doNq+h7TyvMhEtu+X1WCPYHuEX4RPdUqAyutBbvjz5yK0xJnTBSYuXpYox7/
         7piZKhPhEsvLl3Ib5kHiqauNaX1HymiJPFamD868ViPK+muUSAhdqOdtNywxqywGyXwu
         puCYmeP75xUNrWH3HV4l3iGlthfpE/xoYj2/nC+sEcLOLv8rYXXgn/CUyajme/PsQhNR
         KiCbAiHrgEaVd3D/T4L+5GVYtWBzbnevBAHwXLLVZtygLD/NYQ8SWz8RQAXVfluELSb3
         HyjA==
X-Gm-Message-State: ANhLgQ2LevSpqKMqr8la7Ej8oC7yzn0GUXJUL5UOuTipT1vhb0jWWCly
        y0+HpAFHEFHRKZz/IOB7lI7+SYElzmR4taSQD0N+dA==
X-Google-Smtp-Source: ADFU+vuGdLGfjs2+M8VG+8CTSB7zTWIkOhrE8A/xfpwCpDb0tA0Jqo6uknUkMn4x81VAgflQhVYh0DOi9pq15zDNRkY=
X-Received: by 2002:a17:90a:ead0:: with SMTP id ev16mr4798094pjb.164.1583516251450;
 Fri, 06 Mar 2020 09:37:31 -0800 (PST)
MIME-Version: 1.0
References: <202003060930.DDCCB6659@keescook> <CAKwvOdn4q4OWzvhAMHFf441DNrmO00ye_H_MnoegP7jw3YAWqA@mail.gmail.com>
In-Reply-To: <CAKwvOdn4q4OWzvhAMHFf441DNrmO00ye_H_MnoegP7jw3YAWqA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Mar 2020 09:37:20 -0800
Message-ID: <CAKwvOd=POMeVJmu4pU78kLqZf=K-1s9kn7MagjGF8_BdztRTNA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/edid: Distribute switch variables for initialization
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:36 AM Nick Desaulniers <ndesaulniers@google.com> w=
rote:
>
> On Fri, Mar 6, 2020 at 9:32 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Variables declared in a switch statement before any case statements
> > cannot be automatically initialized with compiler instrumentation (as
> > they are not part of any execution flow). With GCC's proposed automatic
> > stack variable initialization feature, this triggers a warning (and the=
y
> > don't get initialized). Clang's automatic stack variable initialization
> > (via CONFIG_INIT_STACK_ALL=3Dy) doesn't throw a warning, but it also
> > doesn't initialize such variables[1]. Note that these warnings (or sile=
nt
>
> That's not good, have you filed a bug against Clang yet?  It should at
> least warn when the corresponding stack init flag is set.

D'oh, link is below.

>
> > skipping) happen before the dead-store elimination optimization phase,
> > so even when the automatic initializations are later elided in favor of
> > direct initializations, the warnings remain.
> >
> > To avoid these problems, lift such variables up into the next code
> > block.
> >
> > drivers/gpu/drm/drm_edid.c: In function =E2=80=98drm_edid_to_eld=E2=80=
=99:
> > drivers/gpu/drm/drm_edid.c:4395:9: warning: statement will never be
> > executed [-Wswitch-unreachable]
> >  4395 |     int sad_count;
> >       |         ^~~~~~~~~
> >
> > [1] https://bugs.llvm.org/show_bug.cgi?id=3D44916
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> > v2: move into function block instead being switch-local (Ville Syrj=C3=
=A4l=C3=A4)
> > ---
> >  drivers/gpu/drm/drm_edid.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 805fb004c8eb..46cee78bc175 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -4381,6 +4381,7 @@ static void drm_edid_to_eld(struct drm_connector =
*connector, struct edid *edid)
> >
> >         if (cea_revision(cea) >=3D 3) {
> >                 int i, start, end;
> > +               int sad_count;
> >
> >                 if (cea_db_offsets(cea, &start, &end)) {
> >                         start =3D 0;
> > @@ -4392,8 +4393,6 @@ static void drm_edid_to_eld(struct drm_connector =
*connector, struct edid *edid)
> >                         dbl =3D cea_db_payload_len(db);
> >
> >                         switch (cea_db_tag(db)) {
> > -                               int sad_count;
> > -
> >                         case AUDIO_BLOCK:
> >                                 /* Audio Data Block, contains SADs */
> >                                 sad_count =3D min(dbl / 3, 15 - total_s=
ad_count);
> > --
> > 2.20.1
> >
> >
> > --
> > Kees Cook
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/clang-built-linux/202003060930.DDCCB6659%40keescook.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
