Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28137C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC82D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9R5z16C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgH0Tck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Tcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:32:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BEAC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:32:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so4094467pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3KgI+Ffy60Jb52i0GltPaTDawIx8lqqOtn/Zi/rBptI=;
        b=A9R5z16CN6WvlZm0tunq0JyZp51UZctogq1aC+iggqI6rMvKuDhecLIz34tloLnCWz
         zKxbBeeqD6qeCP12ipK5Wc+UA9tbg4bc2rEGGT/wMqj1/sidRgIES6XlTTAeJbZOxpMo
         qlb6ofY/jYuevaT6o9wjJHm/x40RLesghfyJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3KgI+Ffy60Jb52i0GltPaTDawIx8lqqOtn/Zi/rBptI=;
        b=trR+elIoTyLRTF1CBbEzh2ThBlZeZycprll3mYvL9NqSkCFHI6v6NhDrl134kTZOIK
         TZE3b5zNh35D1DF2r5XpaFLkBGgRWSZv7xS/0qTnCXOThXd/qXTUlSJSc6ACas6Fnk/k
         h5zFz/9e6dg3+USSbOt+6DNQVI4IcZbTQ8jPR4xmfWhEYqwItzYfWQzI9sG8cVZ7N18q
         uIa+w5nXgCGHdHzxiEjam+zxRHIqF41gpClLvhJCUZcWsQihkv4aN/VOG4G4mVVAVHzu
         zuHs7KXjOKbeuEWyJY+SkEctwSc7//rRP5zOEvrTOfELZdUzIsYu3rX2Cbj4TUR4JmBe
         tslg==
X-Gm-Message-State: AOAM531m0yn1/iD8VvvxIZtlhBs1ru60VuVsG3bFkNA9AkjrJU+Aw407
        POe2IzcMzq+vwnowdA73MoZJjUZ0F0aohQ==
X-Google-Smtp-Source: ABdhPJz/2QT15RMxrrIFH8qZbDy3wDzuO9xMRypgZp6J/3iA167gjtK5MjnylJFI7ktMsAYhOdA/ZQ==
X-Received: by 2002:a63:8f41:: with SMTP id r1mr15124500pgn.375.1598556758330;
        Thu, 27 Aug 2020 12:32:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d81sm3644696pfd.174.2020.08.27.12.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:32:37 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:32:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
Message-ID: <202008271229.C1E65D3565@keescook>
References: <202008271145.xE8qIAjp%lkp@intel.com>
 <20200827080558.GA3024@gondor.apana.org.au>
 <CAMj1kXHJrLtnJWYBKBYRtNHVS6rv51+crMsjLEnSqkud0BBaWw@mail.gmail.com>
 <20200827082447.GA3185@gondor.apana.org.au>
 <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
 <CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com>
 <202008271138.0FA7400@keescook>
 <CAHk-=wjPasyJrDuwDnpHJS2TuQfExwe=px-SzLeN8GFMAQJPmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjPasyJrDuwDnpHJS2TuQfExwe=px-SzLeN8GFMAQJPmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:02:12PM -0700, Linus Torvalds wrote:
> On Thu, Aug 27, 2020 at 11:42 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Do you mean you checked both gcc and clang and it was only a problem with gcc?
> 
> I didn't check with clang, but Arnd claimed it was fine.
> 
> > (If so, I can tweak the "depends" below...)
> 
> Ugh.
> 
> Instead of making the Makefile even uglier, why don't you just make
> this all be done in the Kconfig.
> 
> Also, I'm not seeing the point of your patch. You didn't actually
> change anything, you just made a new config variable with the same
> semantics as the old one.

Hmm? Yeah it did: it disallowed CONFIG_COMPILE_TEST, which you said was
the missing piece, I thought? (It's hardly the first time COMPILE_TEST
has collided unhappily with *SAN-ish things.)

> All of this should be thrown out, and this code should use the proper
> patterns for configuration entries in the Makefile, ie just
> 
>   ubsan-cflags-$(CONFIG_UBSAN_OBJECT_SIZE) += -fsanitize=object-size

Yeah, that would be a better pattern for sure.

> and the Kconfig file is the thing that should check if that CC option
> exists with
> 
>   config UBSAN_OBJECT_SIZE
>         bool "Check for accesses beyond known object sizes"
>         default UBSAN
>         depends on CLANG  # gcc makes a mess of it
>         depends on $(cc-option,-fsanitize-coverage=trace-pc)

Yup, for sure. I've only recently started poking at the ubsan stuff. I
can clean it up better.

> Doesn't that all look much cleaner?

Yup!

-- 
Kees Cook
