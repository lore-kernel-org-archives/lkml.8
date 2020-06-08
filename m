Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3188BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C0A206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591643601;
	bh=8beQ4Dqje8TdnA3I1uWeguIKfKQN/kDjEhpBO1ArFh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Iz4VmMYIdfaxlR55bV6QwQpBT5Csww7XqjnYpg4IrLdNRvxi/o6WGAcgpTL6LeWzE
	 AgULVyArjXhjh3NP+wX3b0mEhfsw2xKuITLdFOpnq4TlFCebAP1/OpuJ+037fmlROq
	 xRnRlpu+BDuXGYxzUKQFXpTBD2gI9pKJIofmh5Ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgFHTNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgFHTNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:13:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7EC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:13:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r125so10890104lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEQWSktvr2M5fWsid2cuBAtiEuoArYd9g7ZXSsSNo98=;
        b=d3Reon7jPtra73UYNDVATmEABtsz9kmMH4WHHgreNqOfYsJ3S7HPF54P8q6CONbUXa
         Oa/+f46oc/R+kHTGTM0ic0aFLVfRV6hk3j1Zb3AbXIlYx5JH7joEGP5GzeY1egacazeG
         03riFE4/645obLNzRFcww8QqdM3A8v5zVJJuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEQWSktvr2M5fWsid2cuBAtiEuoArYd9g7ZXSsSNo98=;
        b=EtzhM0zBNESpVPXxaOWeDr+IIBXcsDjp4MLs9i0IHY6Yk+5H33TV6tvcfgkfy1enAS
         T0WD+dncGnfQy5SCx/m2rEyZC1PPxOO0z/KDj0gtpJQma55GgpVTtZyp0D21ZVkQK7N1
         +7U2QtcWM2jEaM0cVowVyN9VaRjkvWO12xU6GGl4O+JdK4Wsrtryyx0iSZMhoWHRg8CJ
         8X6tymva4l4i2nIfEus+hCPUl/B5N0Yp9asQsrCkx9ziEv0M7BrRa63wFxiLwajToF8o
         fops2RUh5FJR9s6kqOLrb2kgHPVQHLkkmPX79qRU4CdB9VOS3OqjiuLZbPln47eDdH1R
         uVCg==
X-Gm-Message-State: AOAM532gyv07yb5prc1/i43/Q4Rc3lsDF9Og633vh2ZSnW0/fV5lA4t9
        DeYzaEOwp51YhQtUD1ZVTblb9w5A59w=
X-Google-Smtp-Source: ABdhPJwagmRZN3v7LWR/zae+FPmWQePUFtpZ+Su4xpJ9ogAKPaGs991jg7YOk/4e/JQJZjlJ1fa60Q==
X-Received: by 2002:ac2:4910:: with SMTP id n16mr6102852lfi.202.1591643595094;
        Mon, 08 Jun 2020 12:13:15 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v126sm4558308lfa.50.2020.06.08.12.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:13:14 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id j18so8868787lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:13:14 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr11106342ljn.70.1591643593917;
 Mon, 08 Jun 2020 12:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01591630479-ext-3636@work.hours> <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jun 2020 12:12:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnntptk9j7KgtPQY5yNEkL5J64mAsqZgdV_4FLtiFboQ@mail.gmail.com>
Message-ID: <CAHk-=whnntptk9j7KgtPQY5yNEkL5J64mAsqZgdV_4FLtiFboQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 12:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jun 8, 2020 at 8:35 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> >
> > Please note 2 minor merge conflict resolutions below:
>
> There was a third because of the iommu tree I merged today.

Oh, and please don't post the whole patch in your pull request.

That's ok for small "fixes" pulls, but it's absolutely the wrong thing
to do with thousands of lines, nobody is going to review that anyway
when the review is supposed to happen on the individual patches.

I'm surprised it even made it to lkml at almost 200k in size.

              Linus
