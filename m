Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A127C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EF82145D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 20:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F2eYoB9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIFU0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgIFU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 16:26:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F266DC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 13:26:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e33so7056634pgm.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2MJI5WKwj4CfxAOfqH4umCqAQZC4WDEy3Ns4ExCsv+c=;
        b=F2eYoB9pZeONNtnqMHWlx6vLsAe2QOgI6RvV85h9FirbAasMRPcy6aJmDIJBUyD+AH
         c90JTKB1C/FOuMh9IwPVq3Zok6prHFv5DzbEMIDZG2I9izL/sCmdzzhOpPaDGo+O93n4
         OWMjD5Rkm40EgZeODRXhsahFnIopX13eMqwNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2MJI5WKwj4CfxAOfqH4umCqAQZC4WDEy3Ns4ExCsv+c=;
        b=n6GeLhHtt8UOccBHuu7S0wZKB60RNjCvpcUprNkT+bqAdLu7xFO0O0dPBQlaH9v5CK
         42tLamgFhImbin3VMNR+P3vh/iHyi66xL+FQ9tQGz5kzczkVr7wlcZX+gUOK3cKd5Vzt
         zUM1epxv6tFsqrlmeDkZnqbBBLpLQ3vDEKy9s5PgDBwihxJHs6JYYwirIbGv9BispHjy
         CwJPbgvlU3jdgYkoPHB7eZSkGCyXj48+KVbIniB5TTIHJnGTwgHrciZM86NqijaoL9Yb
         jIhxjNnXXs73xHZoAN8RDkEav+LbgqD+BfLqlpdkPr34AcjC/Bcou8Nga/DIDNl/to4T
         JPpA==
X-Gm-Message-State: AOAM530HhTtyPiRS+F24YdveN0ED5KIbnb1Ay5pnq6lhnmb1Hw3i5J66
        hOLjks8wDESORKbOjCgNH/8eQQ==
X-Google-Smtp-Source: ABdhPJzDtrENxbvbGn/u71didjTAQx42NpAPRLdSnSVIlrJUWZo3WHsZuEQwIVrHnd7qJUGm5RNp6w==
X-Received: by 2002:a63:e504:: with SMTP id r4mr4076322pgh.431.1599423994391;
        Sun, 06 Sep 2020 13:26:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i8sm5657883pjv.43.2020.09.06.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 13:26:33 -0700 (PDT)
Date:   Sun, 6 Sep 2020 13:26:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string.c: Clarify kerndoc for stpcpy()
Message-ID: <202009061325.8B4A75057@keescook>
References: <202009060302.4574D8D0E0@keescook>
 <20200906160809.GA1620946@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906160809.GA1620946@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 12:08:09PM -0400, Arvind Sankar wrote:
> On Sun, Sep 06, 2020 at 03:06:29AM -0700, Kees Cook wrote:
> > Fix the language around return values to indicate destination instead of
> > source.
> > 
> > Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> > Link: https://lore.kernel.org/lkml/CAK7LNAQvQBhjYgSkvm-dVyNz2Jd2C2qAtfyRk-rngEDfjkc38g
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > This is a fix for lib-stringc-implement-stpcpy.patch in -mm.
> > 
> > Andrew, please note that it would be nice to get this into -rc6
> > to unbreak the clang builds.
> > 
> > Thanks!
> > ---
> >  lib/string.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/string.c b/lib/string.c
> > index 6bd0cf0fb009..32a56436c7eb 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -280,12 +280,12 @@ EXPORT_SYMBOL(strscpy_pad);
> >   * @src: pointer to the beginning of string being copied from. Must not overlap
> >   *       dest.
> >   *
> > - * stpcpy differs from strcpy in a key way: the return value is the new
> > - * %NUL-terminated character. (for strcpy, the return value is a pointer to
> > - * src. This interface is considered unsafe as it doesn't perform bounds
> > - * checking of the inputs. As such it's not recommended for usage. Instead,
> > - * its definition is provided in case the compiler lowers other libcalls to
> > - * stpcpy.
> > + * stpcpy differs from strcpy in a key way: the return value is a pointer
> > + * to the new %NUL-terminated character in @dest. (For strcpy, the return
> > + * value is a pointer to the start of @dest. This interface is considered
> 					      ^ need closing parenthesis
> 
> Thanks.

*face in hands* Yup. Andrew, do you want to poke that yourself or should
I send a fix-fix? :)

-- 
Kees Cook
