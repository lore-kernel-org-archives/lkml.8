Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50227C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C610207DA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ctkqnrn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgFCHnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:43:23 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BF3C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:43:23 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x202so973884oix.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vY4y0JhXv/D29rjsVD+kS4QfopuULHMmvhUHPgT7K/Y=;
        b=ctkqnrn9huKuehDcyS1rw+N1T+nGQivzy3aseSSjf3Q/z44MJenzC9MdrLVrtPMI3L
         vtt+M7DcGGUIk6YuhV9NYsQ4FE9UkoDgUYvN1jEgxrDqW55kj70makupwI3s5LGhDbDM
         IHUD++GPvKUGLvbVb7pNoyvRQLJpNm3Sj2bpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vY4y0JhXv/D29rjsVD+kS4QfopuULHMmvhUHPgT7K/Y=;
        b=dGirSNf37H6y2KMoYlkdQvU3dDtWC1pNfKGN/BL4p697m3HJzN3y/vSbyqvoodakBU
         Zdm9Tx7NanV/CkcEgOGjexnOapRejnpHeD2FZ+O2OquFmXX+yV/SjPn0WJjkX1nWLqT0
         LW1vq9BvgmLXxQRkxU0delou8XKj9OjVoYzJwsTe+yVfxpNZuDrYhIZ5EF12/jjfCzs3
         vgB3tdhrtlZiN2bVjyuqSTaoa1GiM4ONmIYB8MaKIJfLR0/neWE4B2PpaEwYx65ZqNTt
         BHZQvhA2C1Buwoq5l2XJ39CtU81IheFbAav+qrUlWO5OLhP/tHqVZyuBeMBRECy8iVCO
         ikxw==
X-Gm-Message-State: AOAM531WY20fLqal5dsCq6PkbpnuX9IzqefCRf9TKrpUnPTnYLsIc/UU
        /xQ3XxkDXcMXiEcRp1D8pEUNujuv6n9mOQ5eftdMrwRQ
X-Google-Smtp-Source: ABdhPJymYFBB4qTO2iV3fKajN0kRnUfnpqF2m8adj5PkYKr/CCvXSuR4yN5GXbv2TV/lXEz6BonxwqCrFy1m4alvzs4=
X-Received: by 2002:aca:4b91:: with SMTP id y139mr5374242oia.128.1591170202838;
 Wed, 03 Jun 2020 00:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <CAHk-=wjvVjei5d45D=GQMsFMssD8knSFWqxMbd4bH8qSgXk-Lg@mail.gmail.com>
 <CAHk-=wiug3vS=J7obQsyCLp+6qQvT5v6ctOddHRXbVgsLFTLwQ@mail.gmail.com> <e75218b1-985a-0ec8-483d-9780f668d8c3@suse.de>
In-Reply-To: <e75218b1-985a-0ec8-483d-9780f668d8c3@suse.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 3 Jun 2020 09:43:11 +0200
Message-ID: <CAKMK7uHfS-R+03u=kXfCUjcqVRohKYtNLxaSZ98KoYRbeTNOvw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 9:18 AM Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 02.06.20 um 23:56 schrieb Linus Torvalds:
> > On Tue, Jun 2, 2020 at 2:21 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> I'm still working through the rest of the merge, so far that was the
> >> only one that made me go "Whaa?".
> >
> > Hmm. I'm also ending up effectively reverting the drm commit
> > b28ad7deb2f2 ("drm/tidss: Use simple encoder") because commit
> > 9da67433f64e ("drm/tidss: fix crash related to accessing freed
> > memory") made the premise of that simply encoder commit no longer be
> > true.
>
> That's OK. The simple encoder is just for consolidating these
> almost-empty encoders at a single place.
>
> > If there is a better way to sort that out (ie something like "use
> > simple encoder but make it free things at destroy time"), I don't know
> > of it.
>
> There's now drmm_kmalloc() to auto-free the memory when DRM releases a
> device.

Yeah I think we discussed that tidss patch on dri-devel when it showed
up, right fix is to essentially undo it, replace with a
s/devm_kzalloc/drmm_kmalloc/ and then re-apply the simple encoder
conversion. We had (and I think still have) some details to sort out
in all this, so some back&forth is entirely expected here. Also it's
just driver unload, which at least for integrated gpu no user ever
cares about, only developers.
-Daniel

>
> Best regards
> Thomas
>
> >
> > I'll let you guys fight it out (added people involved with those
> > commits to the participants,
> >
> >                     Linus
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
