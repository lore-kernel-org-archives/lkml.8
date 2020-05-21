Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40306C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDE520738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590084942;
	bh=WMjbDRNdVLh9EuIT820Gb3F1u8/KMdREPQBYiWZl+pk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aUQ1b8pEexIX5ahlwoenKScTknLB+v3H+1oMzAzqMPsWfYQOEOlPEqPEAiwKkPZ25
	 l0ofxmUs/wkOcoob9xb5KHPcM5FLOGrvojaX7SPBnkfbVcHrFcrXOqr54MRE622tGK
	 Xaqqz3tjZK3YDZ5T2PHl4+sUlpImiyOrIf6J8Jek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgEUSPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgEUSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:15:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F92C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:15:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id o14so9501152ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54W3OV++I2yQ/I7iW3hxLFdkiWppKNPo6faoyw5Mf9Y=;
        b=UQPD/PT2EW5TVwSaVIjRfipituyHmtA1mBHH4953yfr3LzZinoUha6UIRpkmQUDz4Z
         sDAviIP5vN1t2wjk01lP4o7PjjKNXmrpkVYHrJlvxFKw9GfnB5uha8WcnjiW0KyJM7Ti
         9brnyP/zUBG+C2QVoFPdMGDA0IzkPTJ/97s4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54W3OV++I2yQ/I7iW3hxLFdkiWppKNPo6faoyw5Mf9Y=;
        b=OOvw2vZfJow+rTnNJlWM41xGArESPlDZ0iUPw8Htb1j173mAmRIWDEo94nL1m2Tl1w
         mWO5aWgaGtmaFijNSuV6UOWFf2c0sIFkeNh8CFQqPSNh/opPqADJJ/9r51qMtow8hK2B
         yhMMjDbOQ3DID/waj8Vpaa6xRYd95UprkECHybQW0FUP33ogzqP4r7zuK9WPIpW7fyyB
         kOvFWDWtaMIi/px8oNiBJNOMY0Mzq87symGeTrPulh9yrOrmCuj8j9vHobMkBDrc/Nl6
         yICsZCS3ydi9pZBmyQhBPBap+SCSTIfI6DISVtvz5WsdnL54c9aRVuq05VReh85F6wh2
         Gp+A==
X-Gm-Message-State: AOAM532LJSrHGwvlw4FRwxKEis3CmsdhbJIT6JNGzLYftoZ+rTaJc8fA
        IHcGwMbYsU1+CROd5dhyk+3Iu+2XEVE=
X-Google-Smtp-Source: ABdhPJz/UEMqWoCaPvu5dkqzSfsncd7FD7tbALPd9BOCBavRvncO+JZ8BAwpr0R0OGzMjH+Ji0T/iw==
X-Received: by 2002:a05:651c:1043:: with SMTP id x3mr3340406ljm.391.1590084938374;
        Thu, 21 May 2020 11:15:38 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id o23sm2201573lfg.0.2020.05.21.11.15.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 11:15:37 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id w10so9508895ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:15:37 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr3469825ljc.314.1590084936777;
 Thu, 21 May 2020 11:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200521140502.2409-1-linkinjeon@kernel.org> <eb8858fb-c3bc-3f8d-96c1-3b4082c14373@sandeen.net>
In-Reply-To: <eb8858fb-c3bc-3f8d-96c1-3b4082c14373@sandeen.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 11:15:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com>
Message-ID: <CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 8:44 AM Eric Sandeen <sandeen@sandeen.net> wrote:
>
> Wow, it seems wild that we'd need to maintain compatibility with options
> which only ever existed in a different codebase in a staging driver
> (what's the point of staging if every interface that makes it that far has
> to be maintained in perpetuity?)

The rules about regressions have never been about any kind of
documented behavior, or where the code lives.

The rules about regressions are always about "breaks user workflow".

Users are literally the _only_ thing that matters.

No amount of "you shouldn't have used this" or "that behavior was
undefined, it's your own fault your app broke" or "that used to work
simply because of a kernel bug" is at all relevant.

Now, reality is never entirely black-and-white. So we've had things
like "serious security issue" etc that just forces us to make changes
that may break user space. But even then the rule is that we don't
really have other options that would allow things to continue.

And obviously, if users take years to even notice that something
broke, or if we have sane ways to work around the breakage that
doesn't make for too much trouble for users (ie "ok, there are a
handful of users, and they can use a kernel command line to work
around it" kind of things) we've also been a bit less strict.

But no, "that was documented to be broken" (whether it's because the
code was in staging or because the man-page said something else) is
irrelevant. If staging code is so useful that people end up using it,
that means that it's basically regular kernel code with a flag saying
"please clean this up".

The other side of the coin is that people who talk about "API
stability" are entirely wrong. API's don't matter either. You can make
any changes to an API you like - as long as nobody notices.

Again, the regression rule is not about documentation, not about
API's, and not about the phase of the moon.

It's entirely about "we caused problems for user space that used to work".

                   Linus

PS. Obviously "API stability" is important in the sense that if you
_don't_ change any user-visible API's, that's a much safer change that
needs much less care than a change that _does_ change a user-visible
API.

So "API stability" isn't a meaningless concept, but it's not the"First
rule of kernel programming" that "no regressions" is. It's just that
there tends to be a correlation between "I made subtle API changes"
and "uhhuh, I broke user space".
