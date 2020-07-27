Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4453C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30E12072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haorPcN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgG0LAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgG0LAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:00:15 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F5DC061794;
        Mon, 27 Jul 2020 04:00:15 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so4083571oiv.7;
        Mon, 27 Jul 2020 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PdAl22kYVVHyy+DC47FmxXZY5dbomVe4vqaxI2xzsQ=;
        b=haorPcN/q/kHQHvFoDiDMfAPWlhOMyhnap37UU7V5VKr6LC1Cyk6A6ksDmii4OairR
         fIFhKvoWv+c0AoBwph4202ezXcTa67D3grHIhdId5Hu5Ur/59PzblIQ/u9k5B4QyP7kM
         hU353MU0Dg44P5IZfxIQvyjdhdyW4wK+6LfHiYPb6IXALUfKH1tzc9PsSZRvCGkC6oG9
         GyjnyxjyEXuGIFFgz4vsySwsSuCjXk31y03/k+Rjc37uJD508Uhkbn1Cs1XmBpQ9o7lZ
         XdhAKlx9Xl+732X+VPRrWegGgR0FkUeEs4qbbEwSPX+6r/8hgEPlYLWqaVER9JfXx32b
         b7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PdAl22kYVVHyy+DC47FmxXZY5dbomVe4vqaxI2xzsQ=;
        b=T4TvzI1vo9p2jA4kjLpKXqX2ZzV2X463v/MK/YKijh4phfu9Zr0yIz2ncqa9rF2avs
         RG90aRAO9ZPM0nzjb5l0SlyWPJPqtPxrDI+iKVxu179F5oTy7RgLYsU6eBMezTz7Y2Lq
         oD/B5KAr0DbTZ8EU6zT/n8eHM0urvWJXZjDBjxPam49XRJXYuIOj3jmdVuOI5vz6phrP
         8QJCmNJuPsTFEXMRSgv3eayvYnCjWMURfBI6XIFEuAC23csZpr2/lMGwBtGYnMF8Jy/S
         Bj8+ooNm9RQyvnaqqCQBg4dCv7439dIIuUNthwEo9/YbgRCRp7F4hsPbOdY0HM7+leNQ
         QACw==
X-Gm-Message-State: AOAM531gglZSrxBOS2do94Ivxjt8xOiFN01HIVV7WCsLrMOpmKHkkEmN
        9aW1HGuS6pAIrPJWDBoGM+WzJYqaX1iaixK6cFyxkxJC3LA=
X-Google-Smtp-Source: ABdhPJwB0fhvgfez3aT41nXznftzgbVGj0p5rk6LaOIkWS+q9JnjvjhSSTcwNy3ryKYSuqE9klE6B5nQ9bklJKrD6+c=
X-Received: by 2002:aca:a990:: with SMTP id s138mr1243980oie.154.1595847615017;
 Mon, 27 Jul 2020 04:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200727180831.6c356fc1@canb.auug.org.au> <20200727092448.GB1764157@kroah.com>
 <CAFCwf13o6A_88xBZdTk+XamAULckKB3Wk8A-V8NmmvkXDwB60w@mail.gmail.com> <20200727100529.GA1922918@kroah.com>
In-Reply-To: <20200727100529.GA1922918@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 27 Jul 2020 13:59:46 +0300
Message-ID: <CAFCwf11+xFm8LkV4uuK8iRM4cVARQV+8+XqgEm8dhSMBRcaDhQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the char-misc tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 1:05 PM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jul 27, 2020 at 12:28:14PM +0300, Oded Gabbay wrote:
> > On Mon, Jul 27, 2020 at 12:24 PM Greg KH <greg@kroah.com> wrote:
> > >
> > > On Mon, Jul 27, 2020 at 06:08:31PM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > After merging the char-misc tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >
> > > > In file included from drivers/misc/habanalabs/goya/goya.c:8:
> > > > drivers/misc/habanalabs/goya/goyaP.h:12:10: fatal error: habanalabs.h: No such file or directory
> > > >    12 | #include "habanalabs.h"
> > > >       |          ^~~~~~~~~~~~~~
> > > > In file included from drivers/misc/habanalabs/goya/goya_security.c:8:
> > > > drivers/misc/habanalabs/goya/goyaP.h:12:10: fatal error: habanalabs.h: No such file or directory
> > > >    12 | #include "habanalabs.h"
> > > >       |          ^~~~~~~~~~~~~~
> > > >
> > > > Presumably caused by commit
> > > >
> > > >   70b2f993ea4a ("habanalabs: create common folder")
> > > >
> > > > I have used the char-misc tree from next-20200724 for today.
> > >
> > > Ugh, this is a mess of a merge with this driver.
> > >
> > > Oded, I'll take Stephen's merge resolutions here and push out a new
> > > version, and try to resolve this error, but if you could verify I got it
> > > correct, that would be great.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Sure, np. Just point me where to look.
>
> I didn't see the above build issue, but maybe I didn't have the right
> configuration options enabled for my build.
>
> Oded, I've done the merge and pushed it out to my char-misc-next branch,
> let me know if I've messed anything up there.
>
> thanks,
>
> greg k-h

Looks good, thanks!
Oded
