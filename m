Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20675C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFD82082E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a1sskCj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFPWAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgFPWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:00:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2506C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:00:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d27so44995lfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7xhVPkwnxJg5/grWzYicvl9zNVZx8aMv3rcdNY6Nes=;
        b=a1sskCj5aKsXEJ7T52MtEBv+n4aAii54lM2/4W+Hvv4BibRDrGT1UwsJqa+z5BUGch
         Ogwj4dPaMCXr5O4s2B6oW2nND+GFMLSKeIE2rpoBG+qpV4rtdfiUxY+DnJLzSQdHYwHh
         dd7yu4bmdc8O4PEXh869FMVibyK2mCK2wUlfOqdMY7JVRtAvrAZBG0rkzmGThVDOQB+s
         KWYx5mXB5aBHDm0me+8KdegdORKdBsgLcYhfBWNNH6GrHw+zrSYeMXJLWQhEdNx/Un31
         cZMUfaPpVygSb0C2A7DQMsosZR16+Ef4Ocp5IFQnCdDKDK6vQxuqhe4bsWrug+EG00s8
         5pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7xhVPkwnxJg5/grWzYicvl9zNVZx8aMv3rcdNY6Nes=;
        b=PUD9nuFBimyAi+rIDAIQZgxaGZGZaMUCXnP6uz09ZD0EgYj1W0FuykpvjUNWGsFYIQ
         ASXO0a/Mg3jlY5dWXrAsNLs/E+9GnPwUAt+8DbBemn6grEPP6CLNHgh6qvxVD+QGtYOf
         4vdz9y8uivmipb6gLbou5bIhj2CIUeXrqaZJycQNEH3Yai/UICOu0+FxhZddaTtZgaCU
         Is9Jfb2GOaksH6ljK8IZqjG2+8zRjew4mLGFyD2QmeuQZAiX8J//ivfQnG7f3MNlkhhk
         lSPIOLFUSkbPAO2RBPVJIfhkmAeoydIEsg9u7ZsN9LRNXR871di715pvTBTWgzwTKnva
         K15A==
X-Gm-Message-State: AOAM533Rz9WxTY7qBEo1oi+oH19eXXdd2IALmNlv6g/IqnqOtrnjRk7E
        XYAh5KGhkTUV3u5EopkOMZC0Ww6FC2s7M3wL9g==
X-Google-Smtp-Source: ABdhPJyTxAvKop5JCC+69DHvF+pvurpHp1yzzc/90BVeqFHgo7QEIs+4YeE6Uw4k66Qcz56SWpTKWC9X6QctxSSJIiQ=
X-Received: by 2002:a05:6512:7b:: with SMTP id i27mr2795613lfo.30.1592344840255;
 Tue, 16 Jun 2020 15:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
 <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
 <20200616203352.GA1815527@rani.riverdale.lan> <CAEJqkghzD_6F2N=M65uYHzpOOJ8bvMw18JCfwsiQoH-kToPKLQ@mail.gmail.com>
 <20200616212536.GA1934393@rani.riverdale.lan>
In-Reply-To: <20200616212536.GA1934393@rani.riverdale.lan>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Wed, 17 Jun 2020 00:00:14 +0200
Message-ID: <CAEJqkgij-_Z1S-F=ooHr=OYcE8biHr1Z-RGgOzHpC7Y0wm7BhA@mail.gmail.com>
Subject: Re: Linux 5.8-rc1
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 16. Juni 2020 um 23:25 Uhr schrieb Arvind Sankar
<nivedita@alum.mit.edu>:
>
> On Tue, Jun 16, 2020 at 11:17:08PM +0200, Gabriel C wrote:
> > Am Di., 16. Juni 2020 um 22:33 Uhr schrieb Arvind Sankar
> > <nivedita@alum.mit.edu>:
> > >
> > > Can you attach the output of gcc -dumpspecs and gcc -v? I suspect your
> > > compiler enables stack protector by default. My distro compiler does
> > > that too, but not if -ffreestanding is enabled (which it is for the
> > > purgatory).
> > >
> >
> > Files including config uploaded to there:
> >
> > http://crazy.dev.frugalware.org/kernel/
> >
>
> Yeah, your gcc doesn't have the -ffreestanding handling. Mine (from
> gentoo) has this in the -dumpspecs output:
>
> *cc1_options:
> ... %{nostdlib|nodefaultlibs|ffreestanding:-fno-stack-protector} ...
>
> to switch off the default ssp when the standard libraries aren't available.

I wondered what they enable to do that. it turns out it is a custom patch.
While I think having that is not bad, such patches lead to bugs like this one.
