Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F19FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E521E20768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDFWcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:32:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDFWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:32:01 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MJmbB-1jalcf0KWv-00K6XO for <linux-kernel@vger.kernel.org>; Tue, 07 Apr
 2020 00:32:00 +0200
Received: by mail-qv1-f49.google.com with SMTP id n1so914739qvz.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:31:59 -0700 (PDT)
X-Gm-Message-State: AGi0PuYcIBqpw0Wp3v/rSVV/meLIynPt0Ng7SYhyoK5yen+o4422wU/X
        5XZK80/HilxMPMwuKcaFtJz5TELQTXy70h+yNXo=
X-Google-Smtp-Source: APiQypKFVAckWbfMAfzkVve4y9m6HV2zvNISFkpe8ilPlsIDw6/BPW9MJTckFquY7fd9BAw5f2eh9E/w5FUkT1d9r8k=
X-Received: by 2002:a0c:9e2f:: with SMTP id p47mr1905601qve.211.1586212318645;
 Mon, 06 Apr 2020 15:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190205133821.1a243836@gandalf.local.home> <20190206021611.2nsqomt6a7wuaket@treble>
 <20190206121638.3d2230c1@gandalf.local.home> <CAK8P3a1hsca02=jPQmBG68RTUAt-jDR-qo=UFwf13nZ0k-nDgA@mail.gmail.com>
 <20200406221614.ac2kl3vlagiaj5jf@treble>
In-Reply-To: <20200406221614.ac2kl3vlagiaj5jf@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Apr 2020 00:31:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3QntCOJUeUfNmqogO51yh29i4NQCu=NBF4H1+h_m_Pug@mail.gmail.com>
Message-ID: <CAK8P3a3QntCOJUeUfNmqogO51yh29i4NQCu=NBF4H1+h_m_Pug@mail.gmail.com>
Subject: Re: libelf-0.175 breaks objtool
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NiJ53roV/fGSIrE0SWgxLmow+nTPbgCgyKWk6AWxMPZNoFfS/lj
 SpzqQ7xrYTPyjIOH8crSUof0rgsGKJUCGbUXQmxtfY8oygD+zkkhthUofKu8Cwo4DYepqge
 8opSg70Xj/d36e3xuWqag+hnDdqqvo/obHDZbXLEZ+StpDVs9hWgzVuo38RziP94CJYvQYL
 JPGb2BZw0CHCoaajjgjLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m8Mb50qnuD0=:6Sniqynpgac+CoMN79AX3W
 LQ2OdsciKc+xBmJ3ViDFBSuNsyXs4Pbx3xb1u+p2zcuUYAzAWQpSTC5xrFKvEPiLJZPcOvoky
 HPuQGdBmYtLaTDw14+cpqJsL/cb1q5UHERDlYFa27XePHQqN6553cnNNKqrEPUvTnlEMFYydi
 66Ce5Q4yrz/gfgiujjO9RSleeOHJWEJZYjQm6f4fD6ZKg1NI8DmhYsUM9zxXx/D/guAOqyq/a
 JaP1DRF4mj3LbBjY0tzPYYCWTS4lc4iF6qXNoDrf+TYBCTBvaAKBWYcOQhfPty3hq7SulJu72
 9ilvsJBY33R+/frdHwZxBHSMwqTqE78KVEHxsfpmISTEwjGjtnBUTaTOmm/jOd2DJeYaZ7gvC
 nDbSBCpwXWE3GRgxCmWtPMHjoq/Ce6mTyNLBhG3BWLndwVgKkDmb0yBeeh1j4Fz81v7KVHr0c
 9TDDfGuZGZgb7c0wABbQdD9RSCSxM0yQnRjaqmpT4BFMKXUX7jUoL+7Rn4eI4xisDXNysHz65
 8yjUalM6oB/GkP5X1Kyxe88TEBTmHCosGrl48wn/zEddCTNevPHqDaFYjqSY36JJrCcs5MfiJ
 wVp1MUnUSp0Ue6fD4mDrCKOXuKjJ9ojgJm1JfonXxw4dcMpf81xMxd0mCF/TN6KDFPRWB6b8Q
 nk2qYY/rZACpbC4RpJUIoMM9qH3+S0YVyBE0KBt9yt4lClIwbtfIbIbERYpVlhtdebR4nz7vH
 Pbjxvm09g/dQ4R1QQ00O9m0k3oIbP5BgurkHI/JNuP4+55NU+9MDSKluicz5nyFbsqPfW9Qah
 FTCi3xo2vAJex2jjZ/Tv8nVIZCBYZ26X2n7p2wuACT1JgZWrnk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:16 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Apr 06, 2020 at 11:07:15PM +0200, Arnd Bergmann wrote:
> > On Wed, Feb 6, 2019 at 7:32 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > On Tue, 5 Feb 2019 20:16:11 -0600 Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > > On Tue, Feb 05, 2019 at 01:38:21PM -0500, Steven Rostedt wrote:
> > > > > Just a FYI.
> > > > >
> > > > > After a recent upgrade in debian testing, I was not able to build the
> > > > > kernel. I have a custom build of gcc, so I thought it was strange that
> > > > > I was getting something like this (took this from the web, as I don't
> > > > > have the error anymore with the work around, and currently doing a full
> > > > > build):
> > > > >
> > > > > objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info
> > > > > objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info
> > > > > objdump: kernel/.tmp_signal.o: file format not recognized
> > > > >   CC      arch/x86/kernel/platform-quirks.o
> > > > > objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info
> > > > > objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info
> > > > > objdump: arch/x86/kernel/.tmp_ebda.o: file format not recognized
> > > > > objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info
> > > > > objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info
> > > > > objdump: mm/.tmp_swap_slots.o: file format not recognized
> > > >
> > > > I installed debian testing on a VM, which has libelf 0.175-2, but I
> > >
> > > Hmm, I only have libelf-0.175 (no -2)
> > >
> > > > can't recreate.  Can you share your config?
> > > >
> > >
> > > It's just a distro config. Ah, I think it's because I'm compiling my
> > > own home built gcc. There seems to be an incompatibility with the
> > > binutils that I used and with libelf-0.175. If I build with just the
> > > distro gcc, it works.
> > >
> > > Bah, this means I need to recreate my gcc that I use to build my
> > > kernels with :-p As I like to control which gcc I use.
> >
> > I now see the same problem that you reported using the gcc-9
> > toolchain I provide on https://kernel.org/pub/tools/crosstool/.
> >
> > Do you have any other information that might help me fix it?
>
> This sounds like an issue I saw before where the toolchain wants to
> compress debuginfo (DWARF debug_info sections).  The "fix" was to add
> '-gz=none' to KCFLAGS.
>
> But if it's a desired feature then we could probably teach objtool to
> deal with it.  It ignores DWARF anyway.

This sounds odd, as I have CONFIG_DEBUG_INFO disabled in all
my randconfig builds.

It's also odd that I only see the problem in two specific files:
arch/x86/realmode/rm/trampoline_64.o (in half of the randconfig builds)
and fs/xfs/xfs_trace.o  (in only one configuration so far).

With this patch I can avoid the first one, which is unconditionally
built with -g (why?):

--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -69,7 +69,7 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
 # ---------------------------------------------------------------------------

 KBUILD_CFLAGS  := $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
-                  -I$(srctree)/arch/x86/boot
+                  -I$(srctree)/arch/x86/boot -gz=none
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
 GCOV_PROFILE := n

I'll look at the other one tomorrow.

        Arnd
