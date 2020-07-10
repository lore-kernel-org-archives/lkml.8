Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2D7206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFx9IzyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGJUze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:55:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1205C08C5DC;
        Fri, 10 Jul 2020 13:55:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so3044043pgk.4;
        Fri, 10 Jul 2020 13:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/IeedtVo9DeN49CtT7pbMYwdvgsRdStvloLi91WmBE0=;
        b=vFx9IzyVFWpakJMGflH4Wb0FxC0gawU+cXW4Tt74bRynlkGa1yZ3TLDOL8xCQgNavX
         DNOuc1Vi1+Y17OBNcfE9v6inXL3YRN59hsyog2IZxEmlKxRAhKaLvgFzMQaodWRVjGpL
         fpL2ZBP7hz6WqDy+C04Vw2JmtWTmsq6Sw1C+XzzZlZR3PEZTBRo4ttfs807Frdi2Rj+l
         5bxxWLB52JjeqtZeD4kSxSqaciC52stwxRmlIKEnYLFNtkDoLln1cN0R+eEaUJJIp22I
         iCo0bi+0ztQ+grQEi/gLyI/XjRUEsJQYV7JtLZRpG71lZcFXTrU4NGoAaiLxaZ+hBmTD
         MgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/IeedtVo9DeN49CtT7pbMYwdvgsRdStvloLi91WmBE0=;
        b=ZTloM+DRM5T+klfJNaU5r5lpu1Fj4a/fh0UDdaxrK037zJJBUBzpfjA/r9h+bH6yqd
         IYkUmt11Oaw1vI0tr4oOGU1oUrTYgy3h2otPC5PrI59DFBihJOgXoqW3WRbtoq7lB9dv
         oyWKngaNaqlXhT6NQqqT63GTmjD7+YkFMvFDJXvrAwEhwkgvOXNPn8zmNJrj5ydVaNQD
         wAwT1v5RSKbi/QJYXdb9jNwBHB6bSv6Dhub3dIGnCCNOiDZXQ3cJPowm6dkzc3LAJjur
         GtUivRbnekR+/dE/axq0J2VMhA7SlGbyvtGnYtnxWHyq63JCzG75y09FE8JUkvq4WB6S
         V6Lw==
X-Gm-Message-State: AOAM532HfM4idInI14cGmOwIwDv21Kut/vorN91ivi8aL7+UXDbdZcU0
        2TzjdXT0dc93I1VPQt7qkU3jGyP1
X-Google-Smtp-Source: ABdhPJwNA8jOJwp6sx82kaUAP/CD0h6o8y5A1LwHFkOYe7OYFX/ZwP04Na9ZREox9l4UpD/6ZQSvbw==
X-Received: by 2002:a62:cfc2:: with SMTP id b185mr29727550pfg.125.1594414533325;
        Fri, 10 Jul 2020 13:55:33 -0700 (PDT)
Received: from localhost (g175.219-103-161.ppp.wakwak.ne.jp. [219.103.161.175])
        by smtp.gmail.com with ESMTPSA id f14sm6488625pjq.36.2020.07.10.13.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 13:55:32 -0700 (PDT)
Date:   Sat, 11 Jul 2020 05:55:30 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: USB MASS STORAGE
 DRIVER
Message-ID: <20200710205530.GC437393@lianli.shorne-pla.net>
References: <20200708095500.13694-1-grandmaster@al2klimov.de>
 <20200708103928.GC585606@kroah.com>
 <6b78a3fd-04b9-fc8e-b5c6-f03372a4cd31@al2klimov.de>
 <20200709061409.GA130260@kroah.com>
 <20200710103621.GA437393@lianli.shorne-pla.net>
 <53342e1a-8430-2557-94c7-1da979a79e68@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53342e1a-8430-2557-94c7-1da979a79e68@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:36:03PM +0200, Alexander A. Klimov wrote:
> 
> 
> Am 10.07.20 um 12:36 schrieb Stafford Horne:
> > On Thu, Jul 09, 2020 at 08:14:09AM +0200, Greg KH wrote:
> > > On Wed, Jul 08, 2020 at 08:41:54PM +0200, Alexander A. Klimov wrote:
> > > > 
> > > > 
> > > > Am 08.07.20 um 12:39 schrieb Greg KH:
> > > > > On Wed, Jul 08, 2020 at 11:55:00AM +0200, Alexander A. Klimov wrote:
> > > > > > Rationale:
> > > > > > Reduces attack surface on kernel devs opening the links for MITM
> > > > > > as HTTPS traffic is much harder to manipulate.
> > > > > > 
> > > > > > Deterministic algorithm:
> > > > > > For each file:
> > > > > >     If not .svg:
> > > > > >       For each line:
> > > > > >         If doesn't contain `\bxmlns\b`:
> > > > > >           For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > > > > > 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> > > > > >               If both the HTTP and HTTPS versions
> > > > > >               return 200 OK and serve the same content:
> > > > > >                 Replace HTTP with HTTPS.
> > > > > > 
> > > > > > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > > > > 
> > > > > Your subject lines are very odd compared to all patches for this
> > > > > subsystem, as well as all other kernel subsystems.  Any reason you are
> > > > > doing it this way and not the normal and standard method of:
> > > > > 	USB: storage: replace http links with https
> > > > > 
> > > > > That would look more uniform as well as not shout at anyone.
> > 
> > I would agree.  The OpenRISC patch for this series says:
> >    "OPENRISC ARCHITECTURE:..."
> > 
> > Here it would just be "openrisc:..." I think fixing the whole series is needed.
> > Greg is not the only on complaining.
> > 
> > Ideally, I think, it would be good to have this sent out as a series i.e [PATCH 3/55]
> > rather than individual patches so this could be discussed as a whole.
> 1) To who? As right now? As right now plus Torvalds, KH, Miller, etc.?
>    As right now, but all-to-all?

Make sure you have a cover letter explaining what you expect.

You can ask maintainers to pick up individual patches by mentioning that in the
cover letter.

You can use `git send-email --cc-cmd` so each patch goes only to the
maintainers, for example:

  send-email --to linux-kernel@vger.kernel.org --cc-cmd scripts/get_maintainers.pl`

> 2) Apropos "series" and "as whole"... I stumbled over

I stumble over "apropos". :)

>    `git log --oneline |grep -Fwe treewide`
>    and am wondering:
>    *Shouldn't all of these patches even begin with "treewide: "?*
>    E.g.: "treewide: Replace HTTP links with HTTPS ones: GCC PLUGINS"

As Greg said that is not what patch subjects loo like.

  - GCC PLUGINS: is not correct, remove it.
  - treewide: may work, but as you want individual maintainers to pick up the patches put
    a subsystem in the subject as maintainers like.
  - The rest of the text should be lowercase "replace http links with https"

Have a look at other patch subject lines based on the file you are editing.  For example:

  $ git log --oneline -- Documentation/kbuild/gcc-plugins.rst
  2020-03-10 2b4cbd5c9505 Jonathan Corbet  docs: move gcc-plugins to the kbuild manual

  $ git log --oneline -- scripts/Makefile.gcc-plugins
  2019-03-04 81a56f6dcd20 Kees Cook        gcc-plugins: structleak: Generalize to all variable types
  2018-12-29 668c35f69cc7 Linus Torvalds   Merge tag 'kbuild-v4.21' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
  2018-12-12 189af4657186 Ard Biesheuvel   ARM: smp: add support for per-task stack canaries
  2018-12-01 ce2fd53a10c7 Masahiro Yamada  kbuild: descend into scripts/gcc-plugins/ via scripts/Makefile
  2018-09-04 10e9ae9fabaf Alexander Popov  gcc-plugins: Add STACKLEAK plugin for tracking the kernel stack
  2018-07-24 7ccb95e8fe91 Kees Cook        gcc-plugins: Regularize Makefile.gcc-plugins
  2018-07-02 c17d6179ad5a Masahiro Yamada  gcc-plugins: remove unused GCC_PLUGIN_SUBDIR
  2018-06-11 59f53855babf Masahiro Yamada  gcc-plugins: test plugin support in Kconfig and clean up Makefile
  2018-06-11 8034c2fb1225 Masahiro Yamada  gcc-plugins: move GCC version check for PowerPC to Kconfig
  2018-06-11 5aadfdeb8de0 Masahiro Yamada  kcov: test compiler capability in Kconfig and correct dependency


So you will have:

  docs: replace http links with https
  gcc-plugins: replace http links with https

-Stafford

> > 
> > -Stafford
> > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > > 
> > > > Hi,
> > > > 
> > > > I'm very sorry.
> > > > 
> > > > As Torvalds has merged 93431e0607e5 and many of you devs (including big
> > > > maintainers like David Miller) just applied this stuff, I assumed that's OK.
> > > > 
> > > > And now I've rolled out tens of patches via shell loop... *sigh*
> > > > 
> > > > As this is the third (I think) change request like this, I assume this rule
> > > > applies to all subsystems – right?
> > > 
> > > Yes, you should try to emulate what the subsystem does, look at other
> > > patches for the same files, but the format I suggested is almost always
> > > the correct one.  If not, I'm sure maintainers will be glad to tell you
> > > otherwise :)
> > 
> > 
