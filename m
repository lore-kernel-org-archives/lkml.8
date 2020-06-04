Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10537C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE79A207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/314ajD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgFDOYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgFDOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:24:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E883CC08C5C0;
        Thu,  4 Jun 2020 07:24:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 23so2435989pfw.10;
        Thu, 04 Jun 2020 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tikL8yENOKHZetOLqlmK26C5ZQNfwDiIOqRsGq5c9xg=;
        b=E/314ajD8gCiJZeJyEITBFXIO35E54py/XzK60qbEDJ0I0DBclHWaFpRUridCiL2dQ
         AnAYM8rU8J8wryhJ8nakvRxdIUYLJNjlTu6gTCHS/SFdPK8sXOpNewwMwQ8+thgFL5pE
         nXEVSKJkarTxg8KU/LITzpph89T46gfgXF5K7Ch97UZgCi4U4p/TVFGMGWLJe+CfmybM
         3+q/1MbK3r2pCQweM3ttSOx15SVXEB2TiB7jL+sd0ujQ2880xecR5WwFy+GlwyVdIeM4
         eY1iul0HTFE9Jm5nzjVHsjkkdjD5apcOaTg8MTa8sVXVmdxi2PWA6QLmq9cuCYmVtUAU
         Pj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tikL8yENOKHZetOLqlmK26C5ZQNfwDiIOqRsGq5c9xg=;
        b=QXQe2NcyW2mj2NHIqzCxo9dJIE0gkpatZgMf3XUyhBqSTDqWah3Lg4ixZFm1i2ZJZN
         ikBvN4n6r76lBR7i11g6SU+t2PY8R4QN35d6gZLluFa/vrMjWWut/JDfOIHn76XPBejC
         uRu1DwvM56oXrp/yA5Yau9umkIeX1e5XaeaXqBAwCC6lgkijx3JsqEzDim6qEoaH2+dY
         hcW/neI6tCQ4WhwVDiopH5r5UKLUsgbn0CZrZTmlp8k7YyunGQHS7CIkWDWxE86JpoyQ
         w4s2Ou8DlJwHu9BBOHe7/fqQoZfgBtYDt7X269gjkI6XtKOC5zbYjWJqOubbOQBSB1cq
         Ncww==
X-Gm-Message-State: AOAM533mwcGyI9mi1WPB1Xd3oQmNqe2z4livLVGoTB5DYlE03noFFOmy
        mU+qLNJAVFJ1m6V4WsEd+/4=
X-Google-Smtp-Source: ABdhPJxJVM+7E0xxGatwPwqD0ssUJbi54spaQ8JUQyOvHnPVgvj3d1zrEkKnk02MsccyLXWflyAhiA==
X-Received: by 2002:a65:614b:: with SMTP id o11mr4637507pgv.443.1591280643441;
        Thu, 04 Jun 2020 07:24:03 -0700 (PDT)
Received: from sol (220-235-66-207.dyn.iinet.net.au. [220.235.66.207])
        by smtp.gmail.com with ESMTPSA id 1sm2445986pfx.210.2020.06.04.07.24.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 07:24:02 -0700 (PDT)
Date:   Thu, 4 Jun 2020 22:23:57 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC PATCH] gpio: uapi: v2 proposal
Message-ID: <20200604142357.GB5050@sol>
References: <20200516064507.19058-1-warthog618@gmail.com>
 <CACRpkdbputuoHFWL_FhUNR-ZywvJt=qYdaa+i2cLt-Odmgxe2w@mail.gmail.com>
 <20200525141902.GA27938@sol>
 <CACRpkda4PEYd5UGbLkq9w1RBbtOdZxuMQ75k-nu5YfoKTZ_azA@mail.gmail.com>
 <CAMpxmJVzMJkPSrL4uhfCgjXb7CkLSOH3kW=aeb68LRNJenKRiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJVzMJkPSrL4uhfCgjXb7CkLSOH3kW=aeb68LRNJenKRiQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 02:06:31PM +0200, Bartosz Golaszewski wrote:
> śr., 27 maj 2020 o 07:58 Linus Walleij <linus.walleij@linaro.org> napisał(a):
> >
> > On Mon, May 25, 2020 at 4:19 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > > > > +struct gpioline_config {
> > > > > +       __u8 default_values[GPIOLINES_MAX];
> > > >
> > > > So 32 bytes
> > > >
> > >
> > > Actually that one is 64 bytes, which is the same as v1, i.e. GPIOLINES_MAX
> > > is the same as GPIOHANDLES_MAX - just renamed.
> > >
> > > On the subject of values, is there any reason to use a byte for each line
> > > rather value than a bit?
> >
> > Not really, other than making things simple for userspace.
> >
> 
> I'm in favor of using bits here. I think we can rely on libgpiod to
> make things simple for user-space, the kernel interface can be as
> brief as possible.
> 

OK, I'll take another look at it.  If changed to a bitmap it will have
to be sized as a multiple of 64bits to maintain alignment.  Other than
that it should be pretty straight forward.

Cheers,
Kent.
