Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C667C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494F72076E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585504641;
	bh=LNoFRMXvE/eScSYAV2nR05QDnmu4+TcBkbLbjFcPj2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JVOVb20k4aUTh/P7EKI9qaei+UOHIfAbnJA/Q+uQ9ctjRNfN5V5p7FmP/IjrsUw8F
	 qEFDp1g4dx5+ZZsP/FrduPH+QFfDGELYpj/1xGORTpOOzQ/+/Kfg0E1jXsVCZRCpg3
	 pFob2uba+lgGIJ/0m8vYnYJjGytCKWOv+H5h4pH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgC2R5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 13:57:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44363 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2R5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 13:57:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so15500209lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwt0QSmZtigbUQKCjTKiHUFhUuC8imw/4DtdMUwf2eU=;
        b=R5j1FllZf3GoUAKeFl463vnk8JJz4Bi+OEAAg2teGJbCbPKPLSRPwIJ0B3DcMLMAJR
         Ma2K6bJ1CWJhVomHXzi8dTdhgrowuHdUUGBkkAG47qYrIsVig9mSH/uJLEKEZ5x8Ok9C
         UwA6QlekDFxL2y334ry9Ky2uMQl3kWjC8KUc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwt0QSmZtigbUQKCjTKiHUFhUuC8imw/4DtdMUwf2eU=;
        b=frprwyD+dvFttpEwANs/Hnbh+i9i10vq9siS+lrL8Y59YoV9/GbWbMm/25Shx1PlPC
         42mSV6gNFuRYHecZH9f5tbI8ZR2kJc67tA0+m0Cd4LyIFvUxvHfHK04UAGman7gb1H4w
         y5p5Kttnhu/EuD2cNyYTHsbjCQCf8l3xeYWfSWl4fpnc9kgYVnWikBk/ea1vZiumdwuU
         zitZTQFwSVET/aaqzxvF+mG147NQJSMMvxcH4lX7eKynf+i2uXdCq5PAU2Vt6B8nZjYA
         tzFF2un98T5uOO+UTwGHxw+Lp+xR9shGpoStm+JXNpaM3hFEmcoNglSWrI5GzVMfwbds
         RLcg==
X-Gm-Message-State: AGi0PubCuKo8Gz1tdG4PXkGD4VZlJuedlcV0CI+aZUsO2bSlsC2i3Zo2
        aMV2gHQwlFsbdJ9kxQigXc6wod30lm4=
X-Google-Smtp-Source: APiQypL5HFvgOGY1ViNf3KaHq97zHBZCNGxQWVb1oY1ZwQvDB8nmhlDUJtyZdLDnzVHZ9ZcI/60dEg==
X-Received: by 2002:a05:651c:1203:: with SMTP id i3mr5090311lja.175.1585504636449;
        Sun, 29 Mar 2020 10:57:16 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p18sm2930877lfc.6.2020.03.29.10.57.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 10:57:15 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id e7so12114071lfq.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:57:15 -0700 (PDT)
X-Received: by 2002:ac2:4a72:: with SMTP id q18mr5884697lfp.10.1585504634779;
 Sun, 29 Mar 2020 10:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com> <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com>
In-Reply-To: <489c9af889954649b3453e350bab6464@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 10:56:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
Message-ID: <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:41 AM David Laight <David.Laight@aculab.com> wrote:
>
> It may be worth implementing get_user() as an inline
> function that writes the result of access_ok() to a
> 'by reference' parameter and then returns the value
> from an 'real' __get_user() function.

That's how get_user() already works.

It is a polymorphic function (done using macros, sizeof() and ugly
compiler tricks) that generates a call, yes. But it's not a normal C
call. On x86-64, it returns the error code in %rax, and the value in
%rdx

So "get_user()" is already basically optimal. It's likely *faster*
than __get_user(), because it has a smaller I$ footprint if you do
multiple ones.

But, if you have lots of performance-critical get_user() calls, just use

     if (user_access_begin(..))
        goto efault;

     .. multiple "unsafe_get_user(x,ptr,efault);" ..

     user_access_end();
     ...

  efault:
     user_access_end();
     return -EFAULT;

and be done with it.

Yes, the above sequence looks cumbersome, but it's designed for doing
multiple accesses together efficiently. It's basically the "I actually
had a good reason to use __get_user(), but it sucks now, so this is
the new interface"

It's designed for multiple accesses, because as mentioned, if you only
have one, then "get_user()" is already optimal.

And yes, the interface (with that "label for error cases") is
optimized for a (future) world where the compiler can do "asm goto"
together with outputs. Any exception on the access doesn't actually
generate a test at all, the exception will branch directly to the
error label instead.

That already works for "unsafe_put_user()", but for
"unsafe_get_user()" you need a compiler that can do that kind of "asm
goto".

If you use a modern clang version (ie build clang from git), I can
send you a patch for the kernel to try (and a patch for clang to fix a
bug, unless it's been already merged, I didn't check).

The above will generate basically _optimal_ code with my patch and
that modern clang version.

            Linus
