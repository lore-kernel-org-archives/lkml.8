Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1174C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908BB206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QTjf25se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgCaInZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:43:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39161 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaInZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:43:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id x11so21230832otp.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhjGFpVb89HwIODM64QA3thRtuQAnzTVaT5loV4riVk=;
        b=QTjf25seCttencnQvo+PixAAJ0nogbqdPicz8zjLP+HsTFetaLD0s5kkcZAyZZFlSl
         0ohsirzgdu2NNtBmP+5Su+hQnnTHoLDjrG4od5f4pVRAeONcvnIcBPIyuu1qXNW2Cvu2
         RH94VhWTQaWzLvd8OelOR/1tTjSHi1rfrB1cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhjGFpVb89HwIODM64QA3thRtuQAnzTVaT5loV4riVk=;
        b=BALuQvvPuAgLO+QotbjE8GwQqp6tbfbPbOl7ZfVJqhRc0p48PpDYmrK+a1HmUEGthr
         WGc08rPVaW2iqeSC+GMqZIfAdq0z31DPQ0US1Gzgrb5o3zuDk27sNZWsP9oMmY5hYeL3
         phXMwGZgcgR9IUsi6EMCb4X9Y3GOGtc/Q/Acg9QaaZbfivnoW/gogp9XZR883LcyaZpl
         5rrEtcOCvc/INWKoq+xzWS14I0LWnNBy0uRzhA4dzbFvaMS8two+4g9cFhAEHfBanpwz
         69Z2vsSW2i5kRVGXkP2ELFVM6wa5+vTm8fafyGI7qaMYFOlVdAC033tN6yHZIHHQy3Tb
         bSbw==
X-Gm-Message-State: ANhLgQ3Z3vDPAFYEXzJ+Bnso6DFF+Dmm4mMbWMH6pDjo+Oq39M15aKp/
        Zm2oddQo5VA2tFmpYSpwBHvfbf/zNoAv8flkXl6TTA==
X-Google-Smtp-Source: ADFU+vtbv3gjyTAwziNuX0n5gBPhdQoSSARPMcIfo1h1T85SOOMOqTyIv7xK627wK+IuDljCGm7rhl4TmryDvbPN65w=
X-Received: by 2002:a9d:554d:: with SMTP id h13mr12119479oti.303.1585644202736;
 Tue, 31 Mar 2020 01:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YSQ.7.76.2003281745280.2671@knanqh.ubzr>
 <nycvar.YSQ.7.76.2003282214210.2671@knanqh.ubzr> <20200330190759.GE7594@ravnborg.org>
In-Reply-To: <20200330190759.GE7594@ravnborg.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 31 Mar 2020 10:43:11 +0200
Message-ID: <CAKMK7uF_mZ3yJouqAOO9v7jaso2aL6GSwRK13uOEuUsOevdUBg@mail.gmail.com>
Subject: Re: [PATCH v2] vt: don't use kmalloc() for the unicode screen buffer
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chen Wandun <chenwandun@huawei.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Jiri Slaby <jslaby@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukas Wunner <lukas@wunner.de>, ghalat@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 9:08 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Nicolas
>
> On Sat, Mar 28, 2020 at 10:25:11PM -0400, Nicolas Pitre wrote:
> > Even if the actual screen size is bounded in vc_do_resize(), the unicode
> > buffer is still a little more than twice the size of the glyph buffer
> > and may exceed MAX_ORDER down the kmalloc() path. This can be triggered
> > from user space.
> >
> > Since there is no point having a physically contiguous buffer here,
> > let's avoid the above issue as well as reducing pressure on high order
> > allocations by using vmalloc() instead.
> >
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > Cc: <stable@vger.kernel.org>
> >
> > ---
> >
> > Changes since v1:
> >
> > - Added missing include, found by kbuild test robot.
> >   Strange that my own build doesn't complain.
>
> When I did the drmP.h removal vmalloc was one of the header files
> that turned up missing in many cases - but only for some architectures.
> I learned to include alpha in the build.
> If it survived building for alpha then I had fixed the majority
> of the issues related to random inherited includes.
>
> The patch itself looks good.
>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Greg, I'm assuming you'll pick this up through the tty tree? I kinda
want to stop the habit of merging vt patches, maybe then
get_maintainers will stop thinking I'm responsible somehow :-)
-Daniel

>
> >
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 15d2769805..d9eb5661e9 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -81,6 +81,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/kd.h>
> >  #include <linux/slab.h>
> > +#include <linux/vmalloc.h>
> >  #include <linux/major.h>
> >  #include <linux/mm.h>
> >  #include <linux/console.h>
> > @@ -350,7 +351,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
> >       /* allocate everything in one go */
> >       memsize = cols * rows * sizeof(char32_t);
> >       memsize += rows * sizeof(char32_t *);
> > -     p = kmalloc(memsize, GFP_KERNEL);
> > +     p = vmalloc(memsize);
> >       if (!p)
> >               return NULL;
> >
> > @@ -366,7 +367,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
> >
> >  static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
> >  {
> > -     kfree(vc->vc_uni_screen);
> > +     vfree(vc->vc_uni_screen);
> >       vc->vc_uni_screen = new_uniscr;
> >  }
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
