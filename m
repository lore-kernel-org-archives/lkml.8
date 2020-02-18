Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F6BC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10A921D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuPXMTek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgBRShN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:37:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34643 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:37:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so8426588plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ccXZcPHgblgsQ7szhI146C2Fb020S8Uq8EN9Auab0l4=;
        b=WuPXMTeklZQs1oW0RE5IlOhPNzD6lbppOClBV6i0Ns8aeFerqCD3HXxAL6SQmOZv5L
         T1Eztw2uppZlUEDdP+rbVrNRHxUhjrKsSs3AYg+rGVsfuBrs/+X5YDGxx4LHJQzsRqEU
         FBb/sBVAkLgg1I8GCSI03WSVMahh9xEo0IikKesZX34MbFAvkVxQel80aQeoKFjuo339
         hbVA3VFfaCseBdGYbE8pwDZZFc09cCdr7DmcEKrbGhCYfEnjZtWDNRPGSoZ193bniHrY
         Y81NQnOo5edZ5MgDyG67f51BmuzxhIYka3sK4u0x/GkWRGLkrePBhKz8RLGRvUon9yC9
         Yg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ccXZcPHgblgsQ7szhI146C2Fb020S8Uq8EN9Auab0l4=;
        b=WsdX+xvQeCzh2t9wg1l8JwKanIOWb/+ie/3Z9iNXo3maK45roxfkETwnw4S0D5Cumx
         pfMynT47h48g2E2Vydt7eYldDYJ89vNxbBu237mEkwgkY9iC/QZztgWiyaU+VEc8fPGn
         LLqCCRy89ZccnFHhtvQszHMpXiWk8V3ZyTEIfsOc8+WoHGzC9yutiW0NIzQoPaw3LS1+
         yFFHBe0NkwpeoB28YqTqm3f6WfsF2sWsueJXAKF54wUI6W3M1DuyS/+Afe6asikKZMiN
         2LubLRBq3ka06n6W78DxleVwTgjgEUngbUB0JAr7cN5z2A0Dqqj2vmdGsAcq/R/VrI9I
         tB+w==
X-Gm-Message-State: APjAAAXa8znb8oPRgoLTVRifr4Y869g8wpn1hB0dVfKTj2OqenQEWqXk
        zSPsAh9WbLah2uopsmOKUWV9oKqxIWFE5WoWtgXcvfve2Jk=
X-Google-Smtp-Source: APXvYqzZgsU+a3pD+9mNeeHD5Yzed7d/Zb2r/b92wg4B+RpYyN4zpLjcE6hVEt6mGDkskCHevectGcMJtuyrWa0g6tU=
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr20968051pll.119.1582051031642;
 Tue, 18 Feb 2020 10:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20200211212455.3307-1-mark.tomlinson@alliedtelesis.co.nz>
 <CAAdtpL5Tf-8O=xMKO33DWDs=2_Hsdk=FQSNO5Gsrx=9hWvENdg@mail.gmail.com>
 <8e852d84c8b0c6b35faa3b3f2a1034d93a6e8967.camel@alliedtelesis.co.nz> <8cb14684e2f774d9573c062f2d82ad5348c5fee7.camel@alliedtelesis.co.nz>
In-Reply-To: <8cb14684e2f774d9573c062f2d82ad5348c5fee7.camel@alliedtelesis.co.nz>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Feb 2020 10:37:00 -0800
Message-ID: <CAKwvOdkaLRE0Ek3PnmqE2P3Urn4+pwfAp-qQdsLurwERcqNXfQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: cavium_octeon: Fix syncw generation.
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>,
        "f4bug@amsat.org" <f4bug@amsat.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 12:01 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> On Mon, 2020-02-17 at 17:58 +1300, Mark Tomlinson wrote:
> > Hi Phil,
> >
> > On Mon, 2020-02-17 at 01:22 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Hi Mark,
> > >
> > > On Tue, Feb 11, 2020 at 10:42 PM Mark Tomlinson
> > > <mark.tomlinson@alliedtelesis.co.nz> wrote:
> > > >
> > > > The Cavium Octeon CPU uses a special sync instruction for implement=
ing
> > > > wmb, and due to a CPU bug, the instruction must appear twice. A mac=
ro
> > > > had been defined to hide this:
> > > >
> > > >  #define __SYNC_rpt(type)     (1 + (type =3D=3D __SYNC_wmb))
> > > >
> > > > which was intended to evaluate to 2 for __SYNC_wmb, and 1 for any o=
ther
> > > > type of sync. However, this expression is evaluated by the assemble=
r,
> > > > and not the compiler, and the result of '=3D=3D' in the assembler i=
s 0 or
> > > > -1, not 0 or 1 as it is in C. The net result was wmb() producing no=
 code
> > > > at all. The simple fix in this patch is to change the '+' to '-'.
> > >
> > > Isn't this particular to the assembler implementation?
> > > Can you explicit the assembler you are using in the commit descriptio=
n?
> > > Assuming we have to look at your commit in 3 years from now, we'll
> > > wonder what assembler you were using.
> > >
> > > Thanks,
> > >
> > > Phil.
> >
> > Yes, it is tied to the assembler. But the Linux kernel is tied to GCC,
> > and GCC (I believe) is tied to GNU as. I can't see the specification of
> > GNU as changing, since that could break anything written for it.
> >
>
> There is an effort underway to build the kernel with clang[1]. I'm not
> sure what that ends up using for an assembler or if it'll even be able
> to target mips64 anytime soon.
>
> For reference the relevant section from the GNU as manual[2] says "A
> true results has a value of -1 whereas a false result has a value of
> 0".
>
> [1] - https://clangbuiltlinux.github.io/
> [2] - https://sourceware.org/binutils/docs/as/Infix-Ops.html#Infix-Ops

Chris, thanks for CC'ing us.

Mark, we're building 32 bit MIPS kernels with Clang under CI (just
added big endian builds this morning).  We're actively looking into
supporting 64b MIPS.

The kernel uses GCC by default, but supports using any compiler via
`make CC=3D<foo>`.  There is extensive support in the kernel for
building with Clang.

GCC and Clang (when doing kernel builds, for clang we set
`-no-integrated-as`) will invoke GAS for inline assembly, but you can
set `AS=3Dclang` for example for the out of line assembly files.  If the
C source files don't contain inline assembly (or `-no-integrated-as`
wasn't set) then Clang will skip invoking the assembler and stream out
an object file.

If you're actively supporting 64b mips, and want to give a Clang build
a try, we'd appreciate the bug reports:
https://github.com/ClangBuiltLinux/linux/issues
--=20
Thanks,
~Nick Desaulniers
