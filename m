Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE187C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B299220866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597156474;
	bh=dYaKCsW2P5Km83ZvF67TsbncmRamrzb5JY8xrNfDD7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WlSTR/eFTpC1rjKTAbq+h/hyQ5SMepqG9ufhaHREFCSIXdqUc7uCOEjka1P0DJ0lD
	 0UdcwrijU6xXPizRfpZME7qCtj960w2Te5OLla6+/5YC7KS2jmj0JlWvWYp8TNO6er
	 w/6Yjm4vkKdOpjNSY5yhFKApYxNR5gB3QOComSmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgHKOed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgHKOed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:34:33 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD049204FD;
        Tue, 11 Aug 2020 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597156471;
        bh=dYaKCsW2P5Km83ZvF67TsbncmRamrzb5JY8xrNfDD7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I3aRASX7V/KOWWynrSg9K6rztCCsVAINeCwd9UfSoTRkVrVotW+Uy31CLA93aABId
         dsoGp+WIm3Sd/MeTe9jxvMwD5Tvx0GPuQ7c+2sqeohn27j4gUmM6efL4UBu2N8I3KW
         45TSQMF+SM4dThhAFE66DO1mWqRawaAAbAtINMDk=
Date:   Tue, 11 Aug 2020 16:34:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200811163427.6edbf343@coco.lan>
In-Reply-To: <20200810150647.GB8612@linux-8ccs>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
        <20200808101222.5103093e@coco.lan>
        <20200810092523.GA8612@linux-8ccs>
        <20200810150647.GB8612@linux-8ccs>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

Em Mon, 10 Aug 2020 17:06:50 +0200
Jessica Yu <jeyu@kernel.org> escreveu:

> +++ Jessica Yu [10/08/20 11:25 +0200]:
> >+++ Mauro Carvalho Chehab [08/08/20 10:12 +0200]:
> >[snip]  
> >>Right now, what happens is:
> >>
> >>	# modprobe wlcore
> >>	modprobe: ERROR: could not insert 'wlcore': Exec format error
> >>
> >>This seems to be failing for all modules, as doesn't show anything
> >>probed.
> >>
> >>Btw, IMO, it would be useful to have some pr_debug() infra in order to
> >>explain why insmod is failing, or to have more error codes used there,
> >>as nothing was printed at dmesg. That makes harder to debug issues
> >>there. I ended losing a lot of time yesterday rebuilding the Kernel
> >>and checking the FS, before deciding to add some printks inside the
> >>Kernel ;-)
> >>
> >>In order for modprobe to start working again, I had to apply this
> >>dirty hack:
> >>
> >><hack>
> >>diff --git a/kernel/module.c b/kernel/module.c
> >>index 910a57640818..10d590dc48ad 100644
> >>--- a/kernel/module.c
> >>+++ b/kernel/module.c
> >>@@ -2051,11 +2051,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> >>	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
> >>	int i;
> >>
> >>+#if 0
> >>	for (i = 0; i < hdr->e_shnum; i++) {
> >>		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
> >>			return -ENOEXEC;
> >>	}
> >>-
> >>+#endif
> >>	return 0;
> >>}
> >></hack>  
> 
> [ I somehow munged the To: header in the last mail. Sorry about that,
> it's fixed now. ]
> 
> >All this hunk does it reject loading modules that have any sections
> >that have both the writable and executable flags. You're saying it's
> >happening for all modules on your setup - I am curious as to which
> >sections have both these flags 

Yes, without the hack, all modules are rejected.

> what does readelf -S tell you?  

<snip>
$ readelf -S ./drivers/net/wireless/ti/wlcore/wlcore.ko
There are 54 section headers, starting at offset 0x8acd08:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .text             PROGBITS         0000000000000000  00000040
       000000000001ddb8  0000000000000000  AX       0     0     8
  [ 2] .rela.text        RELA             0000000000000000  004c3db8
       000000000001b648  0000000000000018   I      51     1     8
  [ 3] .text.unlikely    PROGBITS         0000000000000000  0001ddf8
       0000000000000388  0000000000000000  AX       0     0     4
  [ 4] .rela.text.u[...] RELA             0000000000000000  004df400
       00000000000003f0  0000000000000018   I      51     3     8
  [ 5] __ksymtab         PROGBITS         0000000000000000  0001e180
       0000000000000030  0000000000000000   A       0     0     4
  [ 6] .rela__ksymtab    RELA             0000000000000000  004df7f0
       0000000000000120  0000000000000018   I      51     5     8
  [ 7] __ksymtab_gpl     PROGBITS         0000000000000000  0001e1b0
       0000000000000228  0000000000000000   A       0     0     4
  [ 8] .rela__ksymt[...] RELA             0000000000000000  004df910
       0000000000000cf0  0000000000000018   I      51     7     8
  [ 9] .rodata           PROGBITS         0000000000000000  0001e3d8
       000000000000309d  0000000000000000   A       0     0     8
  [10] .rela.rodata      RELA             0000000000000000  004e0600
       0000000000000d08  0000000000000018   I      51     9     8
  [11] __ksymtab_strings PROGBITS         0000000000000000  00021475
       00000000000004eb  0000000000000001 AMS       0     0     1
  [12] .rodata.str       PROGBITS         0000000000000000  00021960
       000000000000160d  0000000000000001 AMS       0     0     1
  [13] .rodata.str1.8    PROGBITS         0000000000000000  00022f70
       0000000000006724  0000000000000001 AMS       0     0     8
  [14] .modinfo          PROGBITS         0000000000000000  00029694
       0000000000000238  0000000000000000   A       0     0     1
  [15] __param           PROGBITS         0000000000000000  000298d0
       00000000000000c8  0000000000000000   A       0     0     8
  [16] .rela__param      RELA             0000000000000000  004e1308
       00000000000001e0  0000000000000018   I      51    15     8
  [17] .altinstructions  PROGBITS         0000000000000000  00029998
       0000000000000018  0000000000000000   A       0     0     1
  [18] .rela.altins[...] RELA             0000000000000000  004e14e8
       0000000000000060  0000000000000018   I      51    17     8
  [19] .eh_frame         PROGBITS         0000000000000000  000299b0
       000000000000542c  0000000000000000   A       0     0     8
  [20] .rela.eh_frame    RELA             0000000000000000  004e1548
       0000000000002040  0000000000000018   I      51    19     8
  [21] .note.gnu.pr[...] NOTE             0000000000000000  0002ede0
       0000000000000020  0000000000000000   A       0     0     8
  [22] .note.gnu.bu[...] NOTE             0000000000000000  0002ee00
       0000000000000024  0000000000000000   A       0     0     4
  [23] .note.Linux       NOTE             0000000000000000  0002ee24
       0000000000000018  0000000000000000   A       0     0     4
  [24] __jump_table      PROGBITS         0000000000000000  0002ee40
       0000000000002370  0000000000000000  WA       0     0     8
  [25] .rela__jump_table RELA             0000000000000000  004e3588
       0000000000009f78  0000000000000018   I      51    24     8
  [26] .data             PROGBITS         0000000000000000  000311b0
       0000000000000d30  0000000000000000  WA       0     0     8
  [27] .rela.data        RELA             0000000000000000  004ed500
       00000000000000d8  0000000000000018   I      51    26     8
  [28] __bug_table       PROGBITS         0000000000000000  00031ee0
       0000000000000708  0000000000000000  WA       0     0     4
  [29] .rela__bug_table  RELA             0000000000000000  004ed5d8
       0000000000001c20  0000000000000018   I      51    28     8
  [30] __verbose         PROGBITS         0000000000000000  000325e8
       0000000000003330  0000000000000000  WA       0     0     8
  [31] .rela__verbose    RELA             0000000000000000  004ef1f8
       00000000000057c0  0000000000000018   I      51    30     8
  [32] .gnu.linkonc[...] PROGBITS         0000000000000000  00035940
       0000000000000340  0000000000000000  WA       0     0     64
  [33] .plt              PROGBITS         0000000000000340  00035c80
       0000000000000001  0000000000000000 WAX       0     0     1
  [34] .init.plt         NOBITS           0000000000000341  00035c81
       0000000000000001  0000000000000000  WA       0     0     1
  [35] .text.ftrace[...] PROGBITS         0000000000000342  00035c81
       0000000000000001  0000000000000000 WAX       0     0     1
  [36] .bss              NOBITS           0000000000000000  00035c88
       0000000000000010  0000000000000000  WA       0     0     8
  [37] .comment          PROGBITS         0000000000000000  00035c88
       00000000000001c2  0000000000000001  MS       0     0     1
  [38] .note.GNU-stack   PROGBITS         0000000000000000  00035e4a
       0000000000000000  0000000000000000           0     0     1
  [39] .debug_aranges    PROGBITS         0000000000000000  00035e4a
       0000000000000310  0000000000000000           0     0     1
  [40] .rela.debug_[...] RELA             0000000000000000  004f49b8
       0000000000000330  0000000000000018   I      51    39     8
  [41] .debug_info       PROGBITS         0000000000000000  0003615a
       000000000026ceba  0000000000000000           0     0     1
  [42] .rela.debug_info  RELA             0000000000000000  004f4ce8
       00000000003695b8  0000000000000018   I      51    41     8
  [43] .debug_abbrev     PROGBITS         0000000000000000  002a3014
       000000000000cd2c  0000000000000000           0     0     1
  [44] .debug_line       PROGBITS         0000000000000000  002afd40
       000000000003790b  0000000000000000           0     0     1
  [45] .rela.debug_line  RELA             0000000000000000  0085e2a0
       00000000000001f8  0000000000000018   I      51    44     8
  [46] .debug_str        PROGBITS         0000000000000000  002e764b
       000000000017b06a  0000000000000001  MS       0     0     1
  [47] .debug_loc        PROGBITS         0000000000000000  004626b5
       000000000002af32  0000000000000000           0     0     1
  [48] .rela.debug_loc   RELA             0000000000000000  0085e498
       0000000000022050  0000000000000018   I      51    47     8
  [49] .debug_ranges     PROGBITS         0000000000000000  0048d5e7
       0000000000027270  0000000000000000           0     0     1
  [50] .rela.debug_[...] RELA             0000000000000000  008804e8
       000000000002c610  0000000000000018   I      51    49     8
  [51] .symtab           SYMTAB           0000000000000000  004b4858
       0000000000008ce8  0000000000000018          52   1144     8
  [52] .strtab           STRTAB           0000000000000000  004bd540
       0000000000006872  0000000000000000           0     0     1
  [53] .shstrtab         STRTAB           0000000000000000  008acaf8
       000000000000020c  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  p (processor specific)
</snip>

Let me know if the above output of readelf helps. On a quick look,
it sounded that only text and plt sections have exec flag.

> Hmm, I was not able to reproduce this with a cross-compiled kernel
> using the attached config (gcc 9.3.0 with vanilla v5.8 kernel).

That started to happen after an upgrade on Debian Bullseye, although
about the same time I also re-based my series on the top of v5.8.

So, it might be related to the upgrade or due to some differences at
the toolchain.

Btw, I'm building it natively on an arm64 machine.

Gcc is:

	$ gcc --version
	gcc (Debian 9.3.0-15) 9.3.0
	Copyright (C) 2019 Free Software Foundation, Inc.
	This is free software; see the source for copying conditions.  There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

ld is:

	$ ld --version
	GNU ld (GNU Binutils for Debian) 2.35
	Copyright (C) 2020 Free Software Foundation, Inc.
	This program is free software; you may redistribute it under the terms of
	the GNU General Public License version 3 or (at your option) a later version.
	This program has absolutely no warranty.

The relevant Debian packages that I'm using are:

	ii  gcc-9                                         9.3.0-15                        arm64        GNU C compiler
	ii  gcc-9-base:arm64                              9.3.0-15                        arm64        GCC, the GNU Compiler Collection (base package)
	ii  libgcc-9-dev:arm64                            9.3.0-15                        arm64        GCC support library (development files)
	ii  binutils                                      2.35-1                          arm64        GNU assembler, linker and binary utilities
	ii  binutils-aarch64-linux-gnu                    2.35-1                          arm64        GNU binary utilities, for aarch64-linux-gnu target
	ii  binutils-common:arm64                         2.35-1                          arm64        Common files for the GNU assembler, linker and binary utilities
	ii  libbinutils:arm64                             2.35-1                          arm64        GNU binary utilities (private shared library)

> I am
> curious if the failing sections are also SHF_ALLOC - in that case, the
> code is doing what it is intended to do, which is rejecting loading
> any modules with writable and executable sections. If the problematic
> sections are *not* SHF_ALLOC, then we might be able to work around
> that by ignoring non-SHF_ALLOC sections as they are not copied to the
> final module location anyway.

Please let me know if you need any other tests from my side.

Thanks,
Mauro
