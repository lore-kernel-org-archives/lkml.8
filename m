Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86170C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FD924654
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goS5J7Vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCIVD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:03:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42958 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCIVD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:03:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id n18so13660003edw.9;
        Mon, 09 Mar 2020 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=eZb/ccWF/TYgzZwF8bq0wQ21E8YiX1Lv6rhiRU3sLvI=;
        b=goS5J7VmVbkvDvbEQV6GkyBXUPCK0sJnXnfnqgSImAnaB8dX0ZFuteJVGoXK7EdyXj
         rrofxMS+vaSPq24mYxh54ByhZrqo3uuTuxctLh8TikQQKWO8wnNpR/6TM8zHsLthPgQK
         CvR/EumTUYJ93sdRKuRqZk7lJ9UW0q2nvyG5GKm62nDDLh9Gbwc1DuRVbNqlBQDWt16d
         7ZMzlX7yFZPsI3sdOqus0hkdPuM9MUS3WkbDVQHanH960VNhidABw+FM7mIaEeuy2d/f
         +JH4tcAyoiPYnX9iKyUDXQz2GOiiEOuhup0xjxRxb5V0jrMjKVL4OKj5aTYhNBGpYWPT
         m/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=eZb/ccWF/TYgzZwF8bq0wQ21E8YiX1Lv6rhiRU3sLvI=;
        b=DK2OPYGrydVBqx/t6U8gJbc1HKrJopm/eMLSZVQHL46peuY//Z2TpxFO7X/EyAXz73
         aplvgZDEHmMBmZ1U/5namuZme/mBAUg60tJMfV5/amb4Fy2fE8zD/RaiKiOrjKeZd1/B
         4ZLN2ql50tSe6cooVrBU27S03y8Sx1J3jqoALvmkUr2ikhOmtlG3XKcPRaGzz0tge/bg
         dmS7J4A+4EbeeSzOLsZQ6RkO3+vwir42PR9g+WfrI5PC8dSTr8yDRfR6luAa6Wnh4EKa
         y2t+P+Zzuz9a+uKAYYV/zCTj162DXSsoWzwpCvhZy4tXXab6F5GTqapjjFOn1ZXC6y14
         /eTw==
X-Gm-Message-State: ANhLgQ315X44ype7bOSpGliBKJAHVT+H8NAArsG/XDcVnRWx+wNSMe9d
        zS9y4EUau2RI4hX+mXp1Nug=
X-Google-Smtp-Source: ADFU+vtqGrkvVmh1GC+ULjDDZ1JCr9MbKQsSl6NHYia2CcMULubhu1YtnuQwENam4NvycYCwEwhX/A==
X-Received: by 2002:aa7:d6c4:: with SMTP id x4mr17787093edr.135.1583787803950;
        Mon, 09 Mar 2020 14:03:23 -0700 (PDT)
Received: from felia ([2001:16b8:2d7b:9300:1c7c:448d:5c83:1391])
        by smtp.gmail.com with ESMTPSA id ck21sm1059104ejb.51.2020.03.09.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:03:23 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 9 Mar 2020 22:03:14 +0100 (CET)
X-X-Sender: lukas@felia
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Guenter Roeck <groeck@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
In-Reply-To: <20200309070534.GA4093795@kroah.com>
Message-ID: <alpine.DEB.2.21.2003092035300.2953@felia>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com> <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com> <5129f7dbd8506cc9fd5a8f76dc993d789566af6c.camel@perches.com> <alpine.DEB.2.21.2003090702440.3325@felia>
 <20200309070534.GA4093795@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Mar 2020, Greg Kroah-Hartman wrote:

> On Mon, Mar 09, 2020 at 07:32:10AM +0100, Lukas Bulwahn wrote:
> > 
> > 
> > On Sun, 8 Mar 2020, Joe Perches wrote:
> > 
> > > On Sun, 2020-03-08 at 15:32 -0700, Guenter Roeck wrote:
> > > > On Sun, Mar 8, 2020 at 12:51 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > > > All files in drivers/firmware/google/ are identified as part of THE REST
> > > > > according to MAINTAINERS, but they are really maintained by others.
> > > []
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > []
> > > > > @@ -7111,6 +7111,14 @@ S:       Supported
> > > > >  F:     Documentation/networking/device_drivers/google/gve.rst
> > > > >  F:     drivers/net/ethernet/google
> > > > > 
> > > > > +GOOGLE FIRMWARE
> > > > > +M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > +M:     Stephen Boyd <swboyd@chromium.org>
> > > > > +R:     Guenter Roeck <groeck@chromium.org>
> > > > > +R:     Julius Werner <jwerner@chromium.org>
> > > > > +S:     Maintained
> > > > > +F:     drivers/firmware/google/
> > > > > +
> > > > 
> > > > FWIW, I would not mind stepping up as maintainer if needed, but I
> > > > think we should strongly discourage this kind of auto-assignment of
> > > > maintainers and/or reviewers.
> > > 
> > > Auto assignment should definitely _not_ be done.
> > > 
> > > This is an RFC proposal though.
> > > 
> > > Sometimes it's better to not produce an RFC as
> > > a patch, but maybe just show a proposed section
> > > and ask if is appropriate may be a better style
> > > going forward.
> > >
> > 
> > Please interpret the RFC patch similar to an email as Joe wrote below, 
> > simply reaching out to you.
> > 
> > There is no auto-assignment intended, nor did I expect the patch to be 
> > picked up on the first attempt of uneducated guessing.
> > 
> > There are currently around 3,000 files identified being part of THE REST;
> > so they are all assigned to Linus and LKML.
> > 
> > To confirm that they actually are maintained by someone else and reflect 
> > that in MAINTAINERS, a bit of educated guessing who to contact and to 
> > which entry to add the files to is required.
> > 
> > I am starting with the "bigger" clustered files in drivers, and then try 
> > to look at files in include and Documentation/ABI/.
> > 
> > Here is a rough statistics on how many files from each directory are in
> > THE REST:
> > 
> >    1368 include
> >     566 tools
> >     327 lib
> >     321 Documentation
> >     100 drivers
> >      91 kernel
> >      84 scripts
> >      75 samples
> >      13 ipc
> >      13 init
> >       8 usr
> >       2 arch
> >       1 virt
> 
> When you use the get_maintainer.pl script, it should find reasonable
> people/lists for those files, so why not just stick with that?  Trying
> to classify all of the kernel files to have MAINTAINERS entries seems
> like a loosing proposition as there are file that no one has touched in
> years.

I would at least hope that there are some quick wins with some cases that 
are pretty obvious to be added to existing entries. A first scan suggested 
that it should not take too much detective work to figure it out for some 
of those files.

For files that have not been touched in years---which I hope are not the 
majority of the cases---it would be nice to see if I can find out that 
these files are part of a entry/subsystem that actually maintains them, 
but did not need to touch them in years, or if these files are orphaned 
(or even meaningless left-overs) but nobody noticed because it was never 
made explicit in the MAINTAINERS file.

After those quick wins, getting this done for ALL files could turn out to 
be impossible, and just checking for future changes and reacting to those 
is the better approach to ensure that new files have an entry in  
MAINTAINERS, but I guess I will find out how much is quickly and easily 
allocated to a MAINTAINERS entry and what cannot be determined as outsider 
and relying on get_maintainer.pl is more reliable than getting a 
confirmation for a dedicated entry in MAINTAINERS.

If the feedback is consistently discouraging to update existing entries 
with additions for currently non-assigned files, I will stop figuring out 
the changes and relying on get_maintainers.pl without making use of any 
data from the MAINTAINERS file for those cases remains the best option, 
just as it is today.

I am willing to investigate if this point can be improved in the 
MAINTAINERS file. If it is all good, as it is right now, or it simply 
cannot be improved without a lot of attention from many developers, 
everything can stay as-is and I will look into other topics.

Lukas
