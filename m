Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A942070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxseotXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392370AbgFWU6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403922AbgFWU61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:58:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:58:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so9636993plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5A6ggZJSYhmKqxXi023++ALz1/yxx4OWOUKivzMyp6s=;
        b=DxseotXcNXTsPoLCoiUOchZ8vWlYjgGlc5pJin8Funwm38e58S6Vs6ThS0VnHsLy3Y
         G0+5J+bDcwdJalGvujwkKECF8YwFaH/FF7FhtDjsOxRFZHQQ7a41EdMkoLkY3Q/D1yMF
         7R28udbe5Dmic+dlNUyg5g4kf7ON9BKKw2sag4zZAK8GzzcK/muIUpTEpZEKr3NAqVTi
         SLpDICS+0pte5QbdVXgDNuZhB7dW+ReGJfUDg0Jw1w1mMwLbOlRbTCcq07F2rtqXLtko
         4FwF5xJqsJgpaSs0VDlgA65QSo2M1Tk1RVRgylpEpJIy2KezrwhmMN8lfsdpQqRn0+4X
         hv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5A6ggZJSYhmKqxXi023++ALz1/yxx4OWOUKivzMyp6s=;
        b=YAXyoAsB1s9r3RXOp4uIxqQmNnfYurXE1ka3zX6ZyroE23BJeyYeiFzMmP8Ehy+Op1
         D/S/l3rWlujO+mzCfT7Ja9AID4aj4gQBvXbE1gWa0bzhvlP3YKXbXQyhV9DHxa5fvaBD
         4NRYrFQ7luKqmiIAAvrDA65Gq2dRt4oeTpDbGxivbl4H8jRp3yEo7CIknIUzx4pdyeh3
         Mwo09FG5m5Lx/VQ/vKSXo4QK4HTFIPKR/zumH82yx6PvVuj9wZrZvGvDltySO+7sMKRC
         e7i5dIxF47wuw9x8MDZFoyEoq7TxBFsRkMCVvut1KIoyigIM7UJoafrT3eV+U6xolhnT
         MK+w==
X-Gm-Message-State: AOAM530+YD3sLtGmkXROzKohLm6Ecu8RHlr14sVH2ky8p+tlICHwDpYn
        inZP72W+G/94b1nrgyAbo0VvdZHqJa1x5tkhNmH5Sg==
X-Google-Smtp-Source: ABdhPJwgNQt/BzJGgIgW1Z6IWYFFQo4/opMM9ra7kx2PUquYyLheC2bO97mcDzSHs3i/leVIx9Lzg4MfUrXy2lkHeRw=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr3895pjc.101.1592945906532;
 Tue, 23 Jun 2020 13:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200622190149.GL32200@zn.tnic> <B4D00859-000A-4F8C-8CFB-45B9BBCCA16D@amacapital.net>
 <20200623102831.GB32590@zn.tnic> <CALCETrXfaEr9OGc5EDpxnhRZxFk5YZBBNVH-N32Eg8V8diwqXg@mail.gmail.com>
 <20200623184726.GI32590@zn.tnic> <CAKwvOdnt+8RR=1JPjDNaVY8T1K7wmqFjSGM7XNUUGRb=t1hiWQ@mail.gmail.com>
 <20200623191336.GK32590@zn.tnic>
In-Reply-To: <20200623191336.GK32590@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jun 2020 13:58:15 -0700
Message-ID: <CAKwvOdkTYqpphqr2cvL2pDuK33aYzxXsLDQ6+_PSUk6qxUuQ7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:13 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jun 23, 2020 at 12:07:13PM -0700, Nick Desaulniers wrote:
> > You already have a conditional below for CC_IS_GCC; just add an else
> > and unconditionally add -msse2.  You *should* use -msse2 for GCC 7.1+
> > IMO.
>
> Why if one can write it more compact with cc-option?
>
> FPU_CFLAGS += $(call cc-option,-msse2,)

This will always be true though, right? For both compilers.  So why
test for it via cc-option when you can just do:

FPU_CFLAGS += -msse2

Though we might only want -msse2 if CC_IS_CLAG...I don't remember now
if GCC will select SSE instructions that require 16B operands at
-msse2, which will be problematic for the -mpreferred-stack-boundary=4
case.

My point was more so about avoiding needless cc-option checks when
they're tautological.

> > I recommend a version check for GCC < 7.1, or simply disabling the
> > self test if the version of GCC used is older than 7.1.
>
> See Andy's suggestion upthread.

Thread for other travelers:
https://lore.kernel.org/lkml/CALCETrXXzt8WZMs3dsReCJ5wdF3zhxFmUtGnmdCgV7_exFUKKQ@mail.gmail.com/

When Andy says "consider dropping the problematic GCC version" I
wonder if it was meant *just for this selftest* as I suggested, or
outright (which is untenable IMO, as it's a large jump to GCC 7.1+).

> And I agree too that using cc-option is better than simply tying it to a
> compiler version.

I agree that will differentiate better than a version check; but it's
still dangerous IMO to mix and match stack alignments.

> Who knows what compiler has what backported. In such
> cases a version number means nothing.

I'm not sure I agree, but I'll take feature detection any day over
version detection.

>
> > ^ looks familiar ;)
>
> It has been pasted around the kernel, I came to realize today. :-)

Guilty, your honor. :P

Maybe the feature test should be copy+pasta'd to those other places in
the kernel, rather than the version check?
-- 
Thanks,
~Nick Desaulniers
