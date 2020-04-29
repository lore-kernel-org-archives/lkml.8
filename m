Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2753C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D5B2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ctXjV+yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD2BET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD2BET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:04:19 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03188C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 18:04:18 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id c24so264380uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 18:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ug/wQBq+seIv85+u2EtcllFYAZBy4VzDUqZGrZ7xOnU=;
        b=ctXjV+yhq6JeHZvZNcwG18SVfTkYgUdvzrnoQROO9BzA6lP0VohAxOBsAZg8X9lOzi
         0JD5d8V0/fSEioGYUmhk1XwRLkpEWZ0lt/6Z8yWOizAflbOeVrCWIO1/bYYKh+z/Mj6P
         UNBOdJM66TBcRvyJEv51fG26dSdvrWZAnaT3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ug/wQBq+seIv85+u2EtcllFYAZBy4VzDUqZGrZ7xOnU=;
        b=uGSbQti+DuiXalE365Ygf/Yzwg95QtAeJxi2LSd/hoI9QCYGuOBdLyEvs4kEU1B0XC
         PUATQkbvfYA4G836XLdCWpoHT3dwdBTIszhN9IarWCDlGPDE/g/S/mQHnhFRFEa2gTqh
         y9EGJuBUdrVJqJZzGGObVirfbdwya1fNNcp0VnUTj/cAPF5Yfz+46ByUYRkboG4jE2K+
         o/4HFiu1VxsMkHk16iQmI1NDTdJo2En+RBbf2XyZe/Bah4HURhWSWn/1ppOzye3/4mvJ
         BKnE2hNTUzxAkd2/6AMa1IHaKK9NBke+AUAamFeHhp93YKOW2vkBKA1SHxGSTK+WL1YJ
         0nmA==
X-Gm-Message-State: AGi0PuYF+hUzHAwayuJIsJ4xAW+gYNQXKdY4SNmvGT0sYqPsOCOM0NaL
        lnxoIVnGRNohWxyKueLw6uYeIMjbZNI=
X-Google-Smtp-Source: APiQypJ0vhPITSizaCSFAX8sKHWLpnkMsdREJ8G1Jtr635WzPFl1cMW18EyIXNd8TdkCG1sTKkBQCg==
X-Received: by 2002:a9f:20c1:: with SMTP id 59mr23194121uaa.59.1588122257798;
        Tue, 28 Apr 2020 18:04:17 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 66sm4398084vss.16.2020.04.28.18.04.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 18:04:17 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id g184so250409vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 18:04:16 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr23855086vsk.106.1588122256302;
 Tue, 28 Apr 2020 18:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
 <20200428172322.2.Iacb3c8152c3cf9015a91308678155a578b0cc050@changeid>
 <a23b7a97f349e6f74b993a4e127564ad3f7d6929.camel@perches.com>
 <CAD=FV=Us6LyfgeXvxnqq+KhHN1djok1y+W_xzSb-KGFy2wgEMg@mail.gmail.com> <bc5c8165908facbb4781b2f29903dfacdf625e83.camel@perches.com>
In-Reply-To: <bc5c8165908facbb4781b2f29903dfacdf625e83.camel@perches.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Apr 2020 18:04:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VtUEgwwB6C4GhTKx3TP37=i4shtwbG41r=wkELcpNmyQ@mail.gmail.com>
Message-ID: <CAD=FV=VtUEgwwB6C4GhTKx3TP37=i4shtwbG41r=wkELcpNmyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Make "offset" and "unsigned int", not just "unsigned"
To:     Joe Perches <joe@perches.com>
Cc:     LinusW <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 28, 2020 at 5:57 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-04-28 at 17:50 -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Apr 28, 2020 at 5:38 PM Joe Perches <joe@perches.com> wrote:
> > > On Tue, 2020-04-28 at 17:23 -0700, Douglas Anderson wrote:
> > > > When I copied the function prototypes from the GPIO header file into
> > > > my own driver, checkpatch yelled at me saying that I shouldn't use use
> > > > "unsigned" but instead should say "unsigned int".  Let's make the
> > > > header file use "unsigned int" so others who copy like I did won't get
> > > > yelled at.
> > >
> > > There are a few other unsigned declarations in the file.
> >
> > There are?  I swear I looked for them before I sent my patch and I
> > couldn't find them.  Then I looked again upon seeing your reply and I
> > still can't find them.  My eyes are bad, though.  Maybe you can give
> > me specifics?
>
> $ git grep -P -n '\bunsigned\s+(?!int|long)' include/linux/gpio/driver.h
> include/linux/gpio/driver.h:352:                                                unsigned offset);
> include/linux/gpio/driver.h:354:                                                unsigned offset);
> include/linux/gpio/driver.h:356:                                                unsigned offset);
> include/linux/gpio/driver.h:358:                                                unsigned offset);
> include/linux/gpio/driver.h:360:                                                unsigned offset, int value);
> include/linux/gpio/driver.h:362:                                                unsigned offset);
> include/linux/gpio/driver.h:367:                                                unsigned offset, int value);
> include/linux/gpio/driver.h:372:                                              unsigned offset,
> include/linux/gpio/driver.h:375:                                                unsigned offset);
> include/linux/gpio/driver.h:462:                        unsigned offset);
> include/linux/gpio/driver.h:660:int gpiochip_generic_request(struct gpio_chip *gc, unsigned offset);
> include/linux/gpio/driver.h:661:void gpiochip_generic_free(struct gpio_chip *gc, unsigned offset);
> include/linux/gpio/driver.h:662:int gpiochip_generic_config(struct gpio_chip *gc, unsigned offset,

...riiiiiggght.   ...and now I run your sed script _after_ my patch
and I get no hits.  ...so I'm still confused about what you want me to
do that's not already done in my patch.


> > > Maybe do all of them (and remove the unnecessary externs)?
> >
> > You mean just remove the word "extern" everywhere in this file?  Sure,
> > I can if you want.
>
> Up to the actual maintainers I suppose.
> There are only a few extern function declarations.
> Most do not use extern.

OK, maybe I'll wait for Linux W. or Bartosz to weigh in unless there
is some Linux policy against using "extern" in header files?


> > > trivial reformatting of the function pointer block too
> >
> > Wow, I must be totally out of it.  Maybe it's the gin and tonic I just
> > had.  I don't understand this comment either.  Can you clarify?
>
>         int                             (*foo)(...,
>                                                ...);
>
> might be better with fewer tabs between return type and function pointer
>
>         int             (*foo)(..., ...);

I'll wait for Linux W. or Bartosz to weigh in here, since it feels
more like a style decision.  Happy to add a patch for it, though.

-Doug
