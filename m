Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF52C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C85820692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCeStENd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbgDMT0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgDMT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:26:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA07C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:26:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a13so4969580pfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdK0zPwtveoXwIU/pJ0It4FhLQkN9xabxjzAbXM7HUg=;
        b=pCeStENdG/6hj1L+u+cxwBd+lxmKze8JFGF8eG5T6Rojz3ubtHvutlqKjh1KPf6A1O
         aVJALpWYIoX41Wh69ZxBMS5ZrlWERrkzwlEgCrDO/r+22JmIYx76G5gf1ZTL97p90L07
         RaKonfqiZWxrjLkWbK3up26Zr9TpJVztjD7fmUypSnBONt4CK8hKMTgKAlUz4vTqWPR9
         m1vmfM8NjyP7tp1Wr6BPswfx8rXp27YDEOmnMAHKaw2g6gy0HL1RmN/M2oftUt8BZq+N
         xfxfpd+p8cC/w61Ukhm/QDEtNS9d35nxOgPWvBQrgI3bs8FgJwfqoHaCQNESYpmQj60s
         LIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdK0zPwtveoXwIU/pJ0It4FhLQkN9xabxjzAbXM7HUg=;
        b=mM3gUyG0aJ4k307CgB47AsJz2pOfb9KT8v1JKIYOT8sAnZaGr4+j34qjqLztTjS/b2
         CE5MdZ2f0nUGJYVA55+daJwajKORqdVAYEMNGC69w40OQNfdrtVI0/40AD7Zvb1wYy7e
         TL/ntuG5fHIo0pni5yri31iZCjRh4CI+XUZ8DoWLPRokvElz4z/XAmEFIpFHuHA4J6xS
         twDjHVUUcpAu2Bp0WRxK+ELv99DOWywYW2xv+Dv1SpZQYEaqngeOXVmMnHAs+aGdFybs
         39Kocx3LPDpIcWiyUeMQZxe9v2guzQvgUjXABfmnNbeN3a7oYRJvYAhFcuj+R0I9bDj8
         4JFg==
X-Gm-Message-State: AGi0PuYKDPa66wfV5S6LvGMwM8dXHEdFQzslB7mK1XTI+LYp/EY7FvaK
        kG5xJLE+t/JDV7BgLy4NJ+cOI7KpAl2Jon+Ml+P7CA==
X-Google-Smtp-Source: APiQypIUhqWcYiDcyMcc+YPUUWgJ1hH3x1WwMExIHnVSN2oF/LeLDnug09prydJRjw+z6TLAVtOg78Y4PPWpvE+OoMg=
X-Received: by 2002:a63:6546:: with SMTP id z67mr6229011pgb.10.1586805988175;
 Mon, 13 Apr 2020 12:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20200410165948.GD448831@lunn.ch>
 <20200410183420.GE25745@shell.armlinux.org.uk>
In-Reply-To: <20200410183420.GE25745@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 12:26:16 -0700
Message-ID: <CAKwvOd=SusRJxzKqq=tBGgjq0tdcgeA1ukK79PyMjadWB8w=Qw@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jian Cai <caij2003@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 11:34 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Apr 10, 2020 at 06:59:48PM +0200, Andrew Lunn wrote:
> > On Thu, Apr 09, 2020 at 04:27:26PM -0700, Jian Cai wrote:
> > > iwmmxt.S contains XScale instructions
> >
> > Dumb question....
> >
> > Are these Xscale instructions? My understanding is that they are an
> > instruction set of their own, implementing something similar to IA-32
> > MMX.
> >
> > Would it be more accurate to say CLANG does not support the iwmmxt
> > instruction set?
>
> Yes, because the XScale core on its own (otherwise known as 80200)
> doesn't support iWMMXT.
>
> It's worth pointing out that the iWMMXT instruction set uses the
> co-processor #1 instruction space as defined by the ARMv5 ARM ARM,
> which is also the FPA (floating point accelerator) instruction
> space - which is the FP instruction set prior to VFP.

Reusing instruction encoding space? :-X  I'll have to look and see how
we define cases like this in LLVM.

>
> The LDFP and similar instructions that binutils decodes the opcodes
> as are FPA instructions, and the LDC2 instructions are their "generic
> co-processor" versions where there's no FPA instruction that matches
> the op-code.
>
> I'll also point out that the reason the iWMMXT code has never been
> ported to Thumb2 is because there are no equivalents for the
> co-processor instructions in the Thumb2 instruction set defined in
> ARMv5.  Hence why the file has a .arm.  So, the fact the file hasn't
> changed for a long time and hasn't been updated with "improvements"
> such as Thumb2 kernels is because that's completely irrelevent to
> the ISA.
>
> It is an example of code that has become stable and mature, and
> requires no maintanence with GNU toolchains.

I agree.  I think this is something we can mark broken for our
toolchain in Kconfig for the time being, and revisit once we have more
resources to implement (leaving the sources as is).

-- 
Thanks,
~Nick Desaulniers
