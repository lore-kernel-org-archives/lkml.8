Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47F6C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AECC20848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NQyZty75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgH0WOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0WOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:14:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F394DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:14:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so4585509pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xSHVxplRRPCUgSjEzraSIa857XoWFefBlda6XAXIvdQ=;
        b=NQyZty75W6TDW0DbDmCZoFLE4rwRGo93ocgxSw3l2ktgUfDM3EmeMcChBppYodL1XQ
         bn418nCR3PC0BEtfy5zMYiYPEwaL18pkZHuZ1pGhsn6xyCecKlzEWJCMywDFr46RFzU0
         /PJJbr4+4sQvp5Klx+CQweeDbyomn7hyGSjxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xSHVxplRRPCUgSjEzraSIa857XoWFefBlda6XAXIvdQ=;
        b=kOWX7Au1sWF10+fSRFjvdosk31RSuzX9jU5RoJ7XANJwtmPPmvSBtzqWY61XWnvKYW
         vrmk5eMNXRRT1UZtGFLGy+60pisDLmHZOeGIklhhIKxmH+8zZK3HC6XTZwUS07aLRdgG
         HSjM5XXD/rK6IaDlux6oM1eNvCBU/4jCM5e1SbxUh10BjFi05t3wY8Op6+4Ip40WPm5l
         9SSwV1snasjU/jUtaStSm0OrexAo44h/kXTLADgoUI7kQ5xUeBe6375XMEe7vRbmvBRn
         B5FKJjS7WldGoIy+1xFtdB34xJeJGw/OT6gvDMug7x4eM0CQdIG8sh22zlWgyDjnAEfM
         wpaw==
X-Gm-Message-State: AOAM531oi2YHd+Kd9ai+ZVl6wLGlzEaZ2xQH9FyC97y0pxmbTySmG7LR
        gfDBK4CgMUzxaVuhWRiT2qR5Bg==
X-Google-Smtp-Source: ABdhPJxKt5vNosf+RimpVpwU+Uqe80AOzvPBE9DBZFoA7oGDJDFDPaCiE6RD1ACKh9RCIHKOyg0jhg==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr2494555pgb.40.1598566479099;
        Thu, 27 Aug 2020 15:14:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w5sm3467529pgk.20.2020.08.27.15.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:14:38 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:14:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
Message-ID: <202008271503.181A6A609@keescook>
References: <20200827013636.149307-1-allen.lkml@gmail.com>
 <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
 <1598553133.4237.8.camel@HansenPartnership.com>
 <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
 <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com>
 <202008271150.7231B901@keescook>
 <CAHk-=whDhHWQo_QjZp36=x=GLMGOJ2xnfsUk9xkUuWRz=i9gOg@mail.gmail.com>
 <20200827213636.GF1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827213636.GF1236603@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:36:36PM +0100, Al Viro wrote:
> On Thu, Aug 27, 2020 at 01:46:33PM -0700, Linus Torvalds wrote:
> > You really have to pick some pretty excessive type names (or variable
> > names) to get close to 80 characters. Again, to pick an example:
> > 
> >         struct timer_group_priv *priv = container_of(handle,
> >                         struct timer_group_priv, timer[handle->num]);
> > 
> > ends up being long even if you were to split it, but that funky
> > container_from() wouldn't have helped the real problem - the fact that
> > the above is complex and nasty.

The point about doing the assignment with the declaration certainly makes
the "ugliness" worse, I agree. I'm still not generally convinced about
the redundancy level pros/cons, but I concede that having a common idiom
(rather than a succinct but subsystem-dependent idiom) is better for
people reading the code for the first time.

> > And I had to _search_ for that example. All the normal cases of
> > split-line container-of's were due to doing it with the declaration,
> > or beause the first argument ended up being an expression in itself
> > and the nested expressions made it more complex.
> 
> Speaking of searching, this kind of typeof use is, IMO, actively
> harmful - it makes finding the places where we might get from
> e.g. linked list to containing objects much harder.  container_of
> (unless combined with obfuscating use of typeof()) at least gives
> you a chance to grep - struct foo *not* followed by '*' is a pattern
> that doesn't give too many false positives.  This one, OTOH, is
> essentially impossible to grep for.

And this observation about workflow does strike a chord with me. I do end
up with those kind of searches too. In trying to examine my preferences
here, I think my instincts are to avoid open-coded types (leading me to
want to use typeof()) but I think those instincts were actually developed
from dealing with _sizeof_ and all the way it goes terribly wrong. So,
okay, I'm convinced. container_of() it is.

Doing these conversions becomes a little less mechanical if assignment
needs to be split from declaration, but hey, we've got a 100 character
line "limit" now, so maybe it'll be less needed. :)

-- 
Kees Cook
