Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B2C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC97A20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pa20bAfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgEFQha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729514AbgEFQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:37:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF3C061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:37:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so718129plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ysv40NaU9cEolxDMZqydkRSPfnO+SbJ9aiL7qpGqadk=;
        b=pa20bAfVRZUvdO8iDKo0HP0uESvPxFamQ8qQl2Y+ujvPMYLAdFgicmQu61BZQtSZF5
         Yu0yL61S71Z8xhwSqi35WXiRAfAeEEOUdzLkEHPIOaAHp/YAIYOVg5rhrLSyeU5phZ4+
         XYTl+ImQT73uQLwlOFFh3G+Fnd4CqaWLhhftoQ3lWSKRtJcv1RyBPvS40bpea0X4XGkk
         1VfkYGDMRNqzNVyL87G50HRwF7SRN678+j1Zhgho847nBKXFKx0zeNnQKmDMshWxTRzj
         8JO3gJH1nmgyQnLGGrQ++GaVtXvCtXWULdqf1Yb8msUVutrU2A344XDMZ9H8OQtaDz12
         GmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ysv40NaU9cEolxDMZqydkRSPfnO+SbJ9aiL7qpGqadk=;
        b=BEFVbXhU2eCJZ/PEoUtrzKCpkSYg3diiUckWQIImTbzx/zyeSXqFhW5sSbsicZUixz
         6VRV33cCUXKtGE40DaSGWnTU+oEZl95p73zaBFCAqymwWjoCL15wIJwU0zVHcdagxSuq
         WMblROKJOlwFsZhWrkwY0vOdy3QXzNnYEgvFg6iVzIZYGG0xm9GkIvveuRbhEdootpuM
         XmFYTP8SuN885tJht0sGtMKj0Rj62klgwfWcEMFRhgasEwIb4O1wH+R+CIwkI9SV676u
         qqdJieX686UC2cs2WgshmX/W8wYTc4DNQPXQ46b7tBhMqotzXZL43HCIQOkjBwHlmujR
         AKpA==
X-Gm-Message-State: AGi0PubSixW2Fp1aWWuagvVtjjFueFZZBRR0pFa8reCR57FMM8xI4SiB
        3AaP8DNN75tO3VE6VFTcX1LhvEw6Is3XrelQ83I45A==
X-Google-Smtp-Source: APiQypL+VLGyDbHfWNP94AkI45jpXipxlhQDoleAxIXnmYyDvKmCBhXFalFgr9V24lJblYMKQmHk5zPcydpw/zN6AEA=
X-Received: by 2002:a17:90a:8c85:: with SMTP id b5mr10152416pjo.187.1588783047869;
 Wed, 06 May 2020 09:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200505174423.199985-1-ndesaulniers@google.com> <20200506043028.GA663805@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200506043028.GA663805@ubuntu-s3-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 May 2020 09:37:16 -0700
Message-ID: <CAKwvOd=c6gzpUsRgh-XmKEh0xHkZUWfXNW52EpqfrbH+XhH5fQ@mail.gmail.com>
Subject: Re: [PATCH] x86: bitops: fix build regression
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Ilie Halip <ilie.halip@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 9:30 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, May 05, 2020 at 10:44:22AM -0700, Nick Desaulniers wrote:
> > This is easily reproducible via Clang+CONFIG_STAGING=y+CONFIG_VT6656=m,
> > or Clang+allyesconfig.
>
> For what it's worth, I don't see this with allyesconfig.

Oops, ok, I'll drop that from the commit message in v2.  I was testing
with the former.

>
> > Keep the masking operation to appease sparse (`make C=1`), add back the
> > cast in order to properly select the proper 8b register alias.
> >
> >  [Nick: reworded]
> >
> > Cc: stable@vger.kernel.org
>
> The offending commit was added in 5.7-rc1; we shouldn't need to
> Cc stable since this should be picked up as an -rc fix.

Got it, will drop in v2.

>
> > Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/961
> > Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
> > Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Reported-by: kernelci.org bot <bot@kernelci.org>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Suggested-by: Ilie Halip <ilie.halip@gmail.com>
>
> Not to split hairs but this is Ilie's diff, he should probably be the
> author with Sedat's Reported-by/Tested-by.
>
> https://github.com/ClangBuiltLinux/linux/issues/961#issuecomment-608239458

Ooh, you're right. Sorry about that Ilie.  I'm usually pretty pedantic
about getting that right; my mistake.  I'll fix that in v2.  As Sedat
noted, the issue tracker has been a little quiet on this issue, but
I'll note that there are extraordinary circumstances going on in the
world these days (COVID) so delays should be anticipated.

Ilie, may I put your authorship and signed off by tag on the V2?

>
> But eh, it's all a team effort plus that can only happen with Ilie's
> explicit consent for a Signed-off-by.
-- 
Thanks,
~Nick Desaulniers
