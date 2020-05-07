Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCEC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1071F20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVUtOgJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgEGW3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGW3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:29:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D2C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 15:29:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so2669011plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBVohqdeB+6SWxRGmmFJuyeMSq6V5Fxg2K5EHMfRPbg=;
        b=SVUtOgJ/cbUQqk9bkdROMWL4W5JPsDsiMZDZf8AsZ1frUJ8JhyuudTUE8rWn529fjt
         zBBBhj1sr+5Ac5H+SEfGbO6TcoE3arpFO1nWFhp/k5r9b0JIc3JY5ADF0/roHkioIe8w
         5kiQJQkIUWgxXIQADgZFJyqwB4E/hAKXXyBYpT8twbgfwkNGMUnAV3pChZC9RXia55oa
         biM+bv7h3CAtQj81S3lvq6TpHuMIIqGfdYCkWhpm7CDU9idd7SWS6Jp2DqPT2v1C6PMx
         o8FjWzNlv6hP4GhvRpSu5UD3x1e6dQlLc2qO4LBvMIqUGS+AV5eapsn2T9JAr9hgmaDS
         yN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBVohqdeB+6SWxRGmmFJuyeMSq6V5Fxg2K5EHMfRPbg=;
        b=BA64SEOGSnZ/mAtX2qC072YwcEjsPiEYSCxIkqXaZSKx9FD+fUcf+Gudhx6k50lgOT
         ATlSi1FGqm6+kzQ2nqv59rH+Jf/uYp9qXT6py8NQ0AZTyMl9jrpZVaO39s90ytcRN1/6
         SHyiwxA58os/wKQzZpBZWk/g9GoIsZpz42jw1Fp0tEbIWKzyfShBHb8zL5lK7WmHcS91
         ir+mgDCwEgUMNN4aGR82Fx2ISyQ/ESKXztuEdC80Cyod5OdV9XfKwBacIbaH9TrDGDHg
         KyvM5FfqdArD8PjyXMrvqgyrx1hvF22kOqBJ0hiPqTtX2NqPa6CwZB/3JhOvf3TV59aZ
         XnVA==
X-Gm-Message-State: AGi0Puaw8XBXWtxeJ31YGw8DVKC8WaTzB0irVxiL3zjWBeWg0Qv6Fuv6
        l+8RExy8W4T0noW/INQEgiL1ZPDsu113A7NHd0oSxg==
X-Google-Smtp-Source: APiQypKkkPDq8z2qnwoJ0+Jzr4hD+NCrW6kDegAy6Pbin9Bdru3LFkaT4ibhl5aa9Qv/zb+4Fu+Kcej8KUECq9VfwFU=
X-Received: by 2002:a17:90a:6d03:: with SMTP id z3mr2573417pjj.32.1588890587535;
 Thu, 07 May 2020 15:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200505174423.199985-1-ndesaulniers@google.com>
 <8A776DBC-03AF-485B-9AA6-5920E3C4ACB2@zytor.com> <20200507113422.GA3762@hirez.programming.kicks-ass.net>
 <CAMzpN2hXUYvLuTA63N56ef4DEzyWXt_uVVq6PV0r8YQT-YN42g@mail.gmail.com> <CAKwvOd=a3MR7osKBpbq=d41ieo7G9FtOp5Kok5por1P5ZS9s4g@mail.gmail.com>
In-Reply-To: <CAKwvOd=a3MR7osKBpbq=d41ieo7G9FtOp5Kok5por1P5ZS9s4g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 May 2020 15:29:35 -0700
Message-ID: <CAKwvOd=Ogbp0oVgmF2B9cePjyWnvLLFRSp2EnaonA-ZFN3K7Dg@mail.gmail.com>
Subject: Re: [PATCH] x86: bitops: fix build regression
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        stable <stable@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 12:19 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, May 7, 2020 at 7:00 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > This change will make sparse happy and allow these cleanups:
> > #define CONST_MASK(nr)                 ((u8)1 << ((nr) & 7))
>
> yep, this is more elegant, IMO.  Will send a v3 later with this
> change.  Looking at the uses of CONST_MASK, I noticed
> arch_change_bit() currently has the (u8) cast from commit
> 838e8bb71dc0c ("x86: Implement change_bit with immediate operand as
> "lock xorb""), so that instance can get cleaned up with the above
> suggestion.

Oh, we need the cast to be the final operation.  The binary AND and
XOR in 2 of the 3 uses of CONST_MASK implicitly promote the operands
of the binary operand to int, so the type of the evaluated
subexpression is int.
https://wiki.sei.cmu.edu/confluence/display/c/EXP14-C.+Beware+of+integer+promotion+when+performing+bitwise+operations+on+integer+types+smaller+than+int
So I think this version (v2) is most precise fix, and would be better
than defining more macros or (worse) using metaprogramming.
-- 
Thanks,
~Nick Desaulniers
