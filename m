Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A37C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DAE20738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPrxCDXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgHBUSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 16:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgHBUSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 16:18:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC32C06174A;
        Sun,  2 Aug 2020 13:18:53 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e5so12828423qth.5;
        Sun, 02 Aug 2020 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4el0gauSUjNsfXwiz026OMHpfpwY+zK0Rf376j3X2E=;
        b=oPrxCDXxF8+UTKdjo8Y2pj1vrKNPbd5hJt1iSjfSWt0wpQT8id+oSTMszbk3iMH0xl
         rZT4+zC8UqDUzG1GOqEiYdp8zhfu9XxXN9Ou694NKA9Mi76LaJv/0o7xtUu0jwEGxTAM
         oUyuG36o/YF9NZTsaOwP2GaoynLI86ecYS/1mxskLP04dG48w7C/xVver+P43vzK/cK8
         d/bTCsI/aajwsjiD6hJspFSPQg4CEeNs6x23jPKplIEva2tHQWJnNuFBW2I8v+ATAfEx
         yx/VWe5xNffckYOVzpVBlGI+H0/HNP/RotwjwTUpPzD/t301IjvMgk3aQHr1cjEEdBpA
         N+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4el0gauSUjNsfXwiz026OMHpfpwY+zK0Rf376j3X2E=;
        b=Fz6nuz9Xp56rhe+TnERCNjzvt6CTNKR4S0e7GoMOiwIKxEieNA4hm7DfrmM0J+qsdT
         pa5H/+EdKpBfMDGFtgPvsLbWoXEwh7iovO+vEVRiw/l7Rytn5S1R3m+5IvdDqxF0NzAL
         /HuSfRnjKPSLnLJZDHMdhbvGuxRYhSInmffIAvndexXg9yvLwDLWqFZvbpscV6YXoZvN
         d/UojTzurL07xCK4D56QRy6qr9j6zN3alMkNyPnsMWg4CRW2Rv9RyaX7g9cx5v/Q0xxY
         5E7XQ1bGmPkIFXvuJ+sob8V0TSjpkuqmHlmlhpQsvANdrAWgyHO1+Ara62dsYB8gxg5z
         kPyg==
X-Gm-Message-State: AOAM5320qgOQXA4xul3w+zaBpB9tIRbpaF6mGHQD3TXKJM+5+PpVliBm
        yDWRslvGKYTjuUgspdZCAfhaCXUB0+lUcaD/D6drZg==
X-Google-Smtp-Source: ABdhPJxLswAM2iqijoI6Y6gAsJmFssQq5vci53Ywbt2DOYFE2LWn010VC6DRW5Z8P8CKREVmppFrGjsNMfkPrTJI7Ec=
X-Received: by 2002:ac8:72cb:: with SMTP id o11mr14123745qtp.13.1596399533145;
 Sun, 02 Aug 2020 13:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200713165408.36229-1-grandmaster@al2klimov.de> <20200721015258.GA3362089@bogus>
In-Reply-To: <20200721015258.GA3362089@bogus>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 2 Aug 2020 22:18:42 +0200
Message-ID: <CAFLxGvyxFjy2cSWgokb8=d_FoGCX4QVbnoLYdLqybKCypoBWLA@mail.gmail.com>
Subject: Re: [PATCH] mtd: Replace HTTP links with HTTPS ones
To:     Rob Herring <robh@kernel.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 3:54 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 13 Jul 2020 18:54:08 +0200, Alexander A. Klimov wrote:
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
> >
> > Deterministic algorithm:
> > For each file:
> >   If not .svg:
> >     For each line:
> >       If doesn't contain `\bxmlns\b`:
> >         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> >         If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> >             If both the HTTP and HTTPS versions
> >             return 200 OK and serve the same content:
> >               Replace HTTP with HTTPS.
> >
> > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > ---
> >  Continuing my work started at 93431e0607e5.
> >  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> >  (Actually letting a shell for loop submit all this stuff for me.)
> >
> >  If there are any URLs to be removed completely or at least not just HTTPSified:
> >  Just clearly say so and I'll *undo my change*.
> >  See also: https://lkml.org/lkml/2020/6/27/64
> >
> >  If there are any valid, but yet not changed URLs:
> >  See: https://lkml.org/lkml/2020/6/26/837
> >
> >  If you apply the patch, please let me know.
> >
> >  Sorry again to all maintainers who complained about subject lines.
> >  Now I realized that you want an actually perfect prefixes,
> >  not just subsystem ones.
> >  I tried my best...
> >  And yes, *I could* (at least half-)automate it.
> >  Impossible is nothing! :)
> >
> >
> >  Documentation/devicetree/bindings/mtd/davinci-nand.txt | 4 ++--
> >  drivers/mtd/chips/Kconfig                              | 2 +-
> >  drivers/mtd/maps/Kconfig                               | 2 +-
> >  drivers/mtd/maps/sc520cdp.c                            | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

All three mtd related patches applied to mtd/next, thanks!

-- 
Thanks,
//richard
