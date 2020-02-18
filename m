Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8254FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7EC2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dd9R74vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBRQwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:52:47 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35937 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgBRQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:52:46 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so17915098iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0fkl9Uzjvd3+WRgDhEFvb5mku/9M7bl3Tq60YNDT/A=;
        b=Dd9R74vFY8XS/S+w0Y6unMczYIsI66Q07QH2IgANqOiXC0pEUPyBNl+kG52Av/fUSz
         CdrR69dTJ44steJ4WnF8tX2hA5d8+I6ewvazMQllAJY8kSzOKtnKExR5GxWUElqp16G5
         OT/RxIdkO4pKiAlC0G2kUsI4LKGwfsdgp89HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0fkl9Uzjvd3+WRgDhEFvb5mku/9M7bl3Tq60YNDT/A=;
        b=LMiNtwCJavkFSxYDuHdzmVO2RlJP08xDY+SyZjgQQalsJwo6/Pp1GX0/fY9N3nwH62
         k5tDvlLZ344xLuf8nuZHbO7sTR6fk7YZTmeir/H5XtUapjoyhpK/8tEN0xSJNhgL0b1J
         6c6pXDl2A5VFb769RsftXfdTECHAoStQTaPHHC/ssA5r92guSJHjvSltut4Q62Kuma90
         TZTZwoJ+waZP2lUe3mR3zz/JfoDEh0phTgxeNfBq4X0hd/IP1hnD0U5kDKynqKfOuWNk
         61kn/Bz+sTYZmB+4+ZdeAACvuH9OKm9KV1WdRXTCk0UinxE5uqnmBY3c05nuCMNrsrm3
         TfLA==
X-Gm-Message-State: APjAAAWPDWcQW5J5K2IYJ1GU2E2f6i6JNl7rPoWx8UdJ6Kdr4D8z+/44
        Igg7t3Y/+/y8nt1JgXnBYdXjPPxsj0XtyKJILH7n8w==
X-Google-Smtp-Source: APXvYqwweWZEL08yiHntB60lwMDPipKRE4zbu6p4on2cRYdzLYfnMWh8srysRNrqrHm3fle6Do0l5tq3x8H+qOlYX7o=
X-Received: by 2002:a92:5d88:: with SMTP id e8mr20676161ilg.106.1582044765519;
 Tue, 18 Feb 2020 08:52:45 -0800 (PST)
MIME-Version: 1.0
References: <158166060044.9887.549561499483343724.stgit@devnote2>
 <158166062748.9887.15284887096084339722.stgit@devnote2> <CAL_Jsq+BDfWgGTVtppD-JEFHZRqpc00WaV2N7c6qsPBSaxOEPw@mail.gmail.com>
 <20200214224744.GC439135@mit.edu> <f15511bf-b840-0633-3354-506b7b0607fe@android.com>
 <20200215005336.GD439135@mit.edu> <243ab5a8-2ce1-1465-0175-3f5d483cbde1@android.com>
In-Reply-To: <243ab5a8-2ce1-1465-0175-3f5d483cbde1@android.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 19 Feb 2020 00:52:19 +0800
Message-ID: <CAJMQK-j8w5++R-CCAVVupba96JRVJ+O91J=O-MT3nep+rx1Yzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] random: rng-seed source is utf-8
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Rob Herring <robh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:01 AM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 2/14/20 4:53 PM, Theodore Y. Ts'o wrote:
> > On Fri, Feb 14, 2020 at 02:55:36PM -0800, Mark Salyzyn wrote:
> >>> This is why I really think what gets specified via the boot command
> >>> line, or bootconfig, should specify the bits of entropy and the
> >>> entropy seed *separately*, so it can be specified explicitly, instead
> >>> of assuming that *everyone knows* that rng-seed is either (a) a binary
> >>> string, or (b) utf-8, or (c) a hex string.  The fact is, everyone does
> >>> *not* know, or everyone will have a different implementation, which
> >>> everyone will say is *obviously* the only way to go....
> >>>
> >> Given that the valid option are between 4 (hex), 6 (utf-8) or 8 (binary), we
> >> can either split the difference and accept 6; or take a pass at the values
> >> and determine which of the set they belong to [0-9a-fA-F], [!-~] or
> >> [\000-\377]  nor need to separately specify.
> > So let's split this up into separate issues.  First of all, from an
> > architectural issue, I really think we need to change
> > add_bootloader_randomness() in drivers/char/random.c so it looks like this:
> >
> > void add_bootloader_randomness(const void *buf, unsigned int size, unsigned int entropy_bits)
> >
> > That's because this is a general function that could be used by any
> > number of bootloaders.  For example, for the UEFI bootloader, it can
> > use the UEFI call that will return binary bits.  Some other bootloader
> > might use utf-8, etc.  So it would be an abstraction violation to have
> > code in drivers/char/random.c make assumption about how a particular
> > bootloader might be behaving.
> >
> > The second question is we are going to be parsing an rng_seed
> > parameter it shows up in bootconfig or in the boot command line, how
> > do we decide how many bits of entropy it actually has.  The advantage
> > of using the boot command line is we don't need to change the rest of
> > the bootloader ecosystem.  But that's also a massive weakness, since
> > apparently some people are already using it, and perhaps not in the
> > same way.
> >
> > So what I'd really prefer is if we use something new, and we define it
> > in a way that makes as close as possible to "impossible to misuse".
> > (See Rusty Russell's API design manifesto[1]).  So I'm going to
> > propose something different.  Let's use something new, say
> > entropy_seed_hex, and let's say that it *must* be a hex string:
> >
> >      entropy_seed_hex=7337db91a4824e3480ba6d2dfaa60bec
> >
> > If it is not a valid hex string, it gets zero entropy credit.
> >
> > I don't think we really need to worry about efficient encoding of the
> > seed, since 256 bits is only 64 characters using a hex string.  An
> > whether it's 32 characters or 64 characters, the max command line
> > string is 32k, so it's probably not worth it to try to do something
> > more complex.  (And only 128 bits is needed to declare the CRNG to be
> > fully initialized, in which case we're talking about 16 characters
> > versus 32 charaters.)
> >
> > [1] http://sweng.the-davies.net/Home/rustys-api-design-manifesto
> >
> >                                               - Ted
> >
> I am additionally concerned about add_bootloader_randomness() because it
> is possible for it to sleep because of add_hwgenerator_randomness() as
> once it hits the entropy threshold. As-is it can not be used inside
> start_kernel() because the sleep would result in a kernel panic, and I
> suspect its use inside early_init_dt_scan_chosen() for the commit "fdt:
> add support for rng-seed" might also be problematic since it is
> effectively called underneath start_kernel() is it not?
>
> If add_bootloader_randomness was rewritten to call
> add_device_randomness() always, and when trusted also called the
> functionality of the new credit_trusted_entropy_bits (no longer needing
> to be exported if so), then the function could be used in both
> start_kernel() and early_init_dt_scan_chosen().
>
I tested 64 bytes rng-seed previously so didn't hit the threshold that
makes it suspend. Thanks for pointing this out.
+1 for changing the add_bootloader_randomness() function as you
suggested to avoid this issue. But besides credit_entropy_bits(), they
are also different on crng_init (crng_fast_load/crng_slow_load).
