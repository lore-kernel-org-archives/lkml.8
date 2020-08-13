Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0FEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B80920715
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+gd0VU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHMRUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgHMRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:20:37 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983C0C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:20:37 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so2979515qvk.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kye36mnZDsF2A6OcubUre0+uzmNqlOm7WRuMdcfkesA=;
        b=Y+gd0VU0+PNGE4nZn2za4afrKim2/I9YdwL/sPzGIkTEc2MUGIysOzgGy7feckj5VD
         K3+BrTDIulRa0gOl/ziHZk+qND59+M5dpO9PdFzukFBw+Nm9Z0ygrAD0+m5ap1B0FulS
         3ExiXNKzorVusfAawuC/btv7N6LJwQbnj6zSHKsulAdRxUx8DVtsXP/gccnU9gAhzdiL
         VnvIadBFug2DJVlJpbjcLKU6oCAAGXBi2O+CBKVewy103XsNkRbTqCL0KTXgbSK+QD/Y
         ynuaw19m3tClRjrn+T7PI+sfBK7i+cUbV2707Qj4c0eyJ3hH2yI94/KmGAv/r4oPGc3k
         7z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Kye36mnZDsF2A6OcubUre0+uzmNqlOm7WRuMdcfkesA=;
        b=JfaAnOnHeHRHQ2AC703Dv+LItE0B66hw5VAiHTWZ+6cuCM9BDP1LnHzHB1/DUQABTQ
         MWy1piIYQHe8V1sH1AIWys/oDHkNsoHkuIClbNhld34VINNgX77sFyrZbnmg2UBju9Yz
         HkS9ENWbtYJD1aHsGUMXHo3lglTwf2A2sl1w3FZtkuePQqVOZ1sOyLUD1HOW2cnmCJrY
         WdXqzjFJbmQ2W1Jc/iSa+SrvK1YPCha2DMzEB2jo5dKmby6OdKbvRPVs/JY/Y/ZGlMd+
         jiwnbplJLhg0Ssa5b4J1vla2/8DkN08huxVP14VMYCd3MbWOq9zt0yuSPcWHboKZygeZ
         gRKA==
X-Gm-Message-State: AOAM532s6rPfEY66zqLnWhJUAt6RxqgqQ6wqLqaf8HYOXP3jS1UGhkvs
        gyiTpjgY8Js7Q8N/bXQSHIQ=
X-Google-Smtp-Source: ABdhPJxeh3ZaEzqucQk5lEYPyrMrgD2UlodqXbchhxvVnwhApLDjU/898cmQTGidwq/cA4eDrtXnfg==
X-Received: by 2002:ad4:438f:: with SMTP id s15mr5884726qvr.164.1597339236714;
        Thu, 13 Aug 2020 10:20:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k5sm6197671qke.18.2020.08.13.10.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 10:20:36 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 13 Aug 2020 13:20:34 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
Message-ID: <20200813172034.GA500410@rani.riverdale.lan>
References: <20200527135329.1172644-1-arnd@arndb.de>
 <878serh1b9.fsf@nanos.tec.linutronix.de>
 <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 05:12:34PM -0700, Nick Desaulniers wrote:
> On Thu, Aug 6, 2020 at 3:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Arnd Bergmann <arnd@arndb.de> writes:
> > > When using the clang integrated assembler, we get a reference
> > > to __force_order that should normally get ignored in a few
> > > rare cases:
> > >
> > > ERROR: modpost: "__force_order" [drivers/cpufreq/powernow-k6.ko] undefined!
> > >
> > > Add a 'static' definition so any file in which this happens can
> > > have a local copy.
> >
> > That's a horrible hack.
> 
> Agreed.  And static means everyone gets their own copy, rather than
> sharing one memory address.  I guess no one actually writes to it, so
> it doesn't really matter, but __force_order just seems so strange to
> me.
> 
> > And the only reason why it does not trigger -Wunused-variable warnings
> > all over the place is because it's "referenced" in unused inline
> > functions and then optimized out along with the unused inlines.
> >
> > >   * It is not referenced from the code, but GCC < 5 with -fPIE would fail
> > >   * due to an undefined symbol. Define it to make these ancient GCCs
> > >   work.
> >
> > Bah, we really should have moved straight to GCC5 instead of upping it
> > just to 4.9
> >
> > > + *
> > > + * Clang sometimes fails to kill the reference to the dummy variable, so
> > > + * provide an actual copy.
> >
> > Can that compiler be fixed instead?
> 
> I don't think so. The logic in the compiler whether to emit an
> "address is significant" assembler directive is based on whether the
> variable is "used."  The "use" of `__force_order` is as output of all
> of these control register read/write functions' inline asm, even
> though the inline asm doesn't actually write to them.  We'd have to
> peek inside of the inline asm and build "use/def chains" for the
> inline asm, to see that you don't actually use the output variable.
> Best we can do is see it listed as an output to the inline asm
> statement.  And if you reference an `extern` variable, it should be no
> wonder that you can get undefined symbol linkage failures.
> 
> I'd much rather remove all of __force_order.
> 
> >
> > Aside of that is there a reason to make this 'static' thing wrapped in
> > #ifdeffery? A quick check with GCC8.3 just works. But maybe 4.9 gets
> > unhappy. Can't say due to: -ENOANCIENTCOMPILER :)
> 
> >From the comment in arch/x86/boot/compressed/pgtable_64.c, there's a
> hint that maybe gcc < 5 and -pie (CONFIG_RANDOMIZE_BASE?) would fail
> due to undefined symbol, though I'm not sure which symbol the comment
> is referring to.  If it's __force_order, then removing outright likely
> fixes that issue.

Yes, it's __force_order. Compressed kernel is always -fPIE, and gcc <5
and clang will generate mov instructions with GOTPCREL relocations to
load the address of __force_order into a register for use by the inline
asm. gcc-5+ works because it doesn't use GOTPCREL for global variables,
instead relying on the linker inserting copy relocations if necessary.

> 
> Not sure about the comment in arch/x86/include/asm/special_insns.h
> either; smells fishy like a bug with a compiler from a long time ago.
> It looks like it was introduced in:
> commit d3ca901f94b32 ("x86: unify paravirt parts of system.h")
> Lore has this thread:
> https://lore.kernel.org/lkml/4755A809.4050305@qumranet.com/
> Patch 4: https://lore.kernel.org/lkml/11967844071346-git-send-email-gcosta@redhat.com/
> It seems like there was a discussion about %cr8, but no one asked
> "what's going on here with __force_order, is that right?"
> Latest GCC release on December 4 2007 would have been GCC 4.2.2 according to:
> https://gcc.gnu.org/releases.html
> 
> Quick boot test of the below works for me, though I should probably
> test hosting a virtualized guest since d3ca901f94b32 refers to
> paravirt.  Thoughts?

It's unclear if there was a real problem this fixes, but if there was
I'd expect it on native, not paravirt, given it's native that has this
__force_order hack?

gcc's documentation of volatile extended asm includes a caveat.

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile

Near the end of 6.47.2.1:
"Note that the compiler can move even volatile asm instructions relative
to other code, including across jump instructions."

and it provides an example of unexpected code motion, with the fix being
adding an artificial dependency to the asm.

So it might do something silly like reversing the order of two
%crn writes, maybe?
