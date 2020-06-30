Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3653C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847C7206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgF3Egq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgF3Egq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:36:46 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03D2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:36:45 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq80f-002ZwH-Nj; Tue, 30 Jun 2020 04:36:42 +0000
Date:   Tue, 30 Jun 2020 05:36:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [RFC][PATCHES] converting FDPIC coredumps to regsets
Message-ID: <20200630043641.GD2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Conversion of ELF coredumps to regsets has not touched
ELF_FDPIC.  Right now all architectures that support FDPIC have
regsets sufficient for switching it to regset-based coredumps.  A bit
of backstory: original ELF (and ELF_FDPIC) coredumps reused the old
helpers used by a.out coredumps.  These days a.out coredumps are gone;
we could remove the dead code, if not for several obstacles.  And one
of those obstacles is ELF_FDPIC.

	This series more or less reproduces the conversion done
by Roland for ELF coredumps.  The branch is in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.fdpic
and it's based on top of #regset.base there (just the introduction of
regset_get() wrapper for ->get(); nothing else from the regset series
is needed).  Killing the old aout helpers is _not_ in this branch;
followup cleanups live separately.

	First we need to sort out the mess with struct elf_prstatus,
though.  It's used both for ELF and ELF_FDPIC coredumps, and it
contains a couple of fields under ifdef on CONFIG_BINFMT_ELF_FDPIC.
ELF is MMU-dependent and most, but not all configs that allow ELF_FDPIC
are non-MMU.  ARM is an exception - there ELF_FDPIC is allowed both for
MMU and non-MMU configs.  That's a problem - struct elf_prstatus is a
part of coredump layout, so ELF coredumps produced by arm kernels that
have ELF_FDPIC enabled are incompatible with those that have it disabled.

	The obvious solution is to introduce struct elf_prstatus_fdpic
and use that in binfmt_elf_fdpic.c, taking these fields out of the
normal struct elf_prstatus.  Unfortunately, the damn thing is defined in
include/uapi/linux/elfcore.h, so nominally it's a part of userland ABI.
However, not a single userland program actually includes linux/elfcore.h.
The reason is that the definition in there uses elf_gregset_t as a member,
and _that_ is not defined anywhere in the exported headers.  It is defined
in (libc) sys/procfs.h, but the same file defines struct elf_prstatus
as well.  So if you try to include linux/elfcore.h without having already
pulled sys/procfs.h, it'll break on incomplete type of a member.  And if
you have pulled sys/procfs.h, it'll break on redefining a structure.
IOW, it's not usable and it never had been; as the matter of fact,
that's the reason sys/procfs.h had been introduced back in 1996.

1/7) unexport linux/elfcore.h
	Takes it out of include/uapi/linux and moves the stuff that used
to live there into include/linux/elfcore.h

2/7) take fdpic-related parts of elf_prstatus out
	Now we can take that ifdef out of the definition of elf_prstatus
(as well as compat_elf_prstatus) and put the variant with those extra
fields into binfmt_elf_fdpic.c, calling it elf_prstatus_fdpic there.

3/7) kill elf_fpxregs_t
	All code dealing with it (both in elf_fdpic and non-regset side
of elf) is conditional upon ELF_CORE_COPY_XFPREGS.  And no architectures
define that anymore.  Take the dead code out.

4/7) [elf-fdpic] coredump: don't bother with cyclic list for per-thread
objects
5/7) [elf-fdpic] move allocation of elf_thread_status into
elf_dump_thread_status()
6/7) [elf-fdpic] use elf_dump_thread_status() for the dumper thread as well
	Massaging fdpic coredump logics towards the regset side of
elf coredump.

7/7) [elf-fdpic] switch coredump to regsets
	... and now we can switch from elf_core_copy_task_{,fp}regs()
to regset_get().


Diffstat:
 arch/ia64/include/asm/elf.h    |   2 -
 arch/powerpc/include/asm/elf.h |   2 -
 arch/x86/include/asm/elf.h     |   2 -
 fs/binfmt_elf.c                |  30 ------
 fs/binfmt_elf_fdpic.c          | 205 ++++++++++++++++++-----------------------
 include/linux/elfcore-compat.h |   4 -
 include/linux/elfcore.h        |  66 +++++++++++--
 include/uapi/linux/elfcore.h   | 101 --------------------
 scripts/headers_install.sh     |   1 -
 usr/include/Makefile           |   1 -
 10 files changed, 146 insertions(+), 268 deletions(-)
