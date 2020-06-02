Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D083AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A0E2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgFBTuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:50:50 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36854 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgFBTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:50:47 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:50:46 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 748FE40BEE;
        Tue,  2 Jun 2020 12:50:46 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 00/32] objtool: Make recordmcount a subcommand
Date:   Tue, 2 Jun 2020 12:49:53 -0700
Message-ID: <cover.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

recordmcount has its own ELF wrapper code and could utilize
objtool's ELF code to more-portably handle architecture variations.
This series makes recordmcount a subcommand of objtool. It  very
gradually convert recordmcount to become a subcommand of objtool and
then reuses parts of objtool's ELF code. recordmcount maps the file in
and collects simple information it needs to append a section to the
object file. The only part of the original file it modifies is the
address of new section tables -- interestingly enough this
resembles RCU in that we don't really trim the old tables so
much as unlink them via a critical offset and then rely on
future tooling, in this case, to drop the unused bits. Much of
the recordmcount ELF code is only reading and walking the data
structures to collect the mcount locations it records in a separate
area of memory. This means it's safe to mix access to the mapped
file with access to the objtool-style linked data
structures as we gradually convert it to using only the linked data
structures. Once the old ELF code is no longer in use we can drop it
and use objtool to take over the task of writing the results without
using the RCU-like trick any more.

Testing:

I've been using scripts to test cross compilation and execution of
objtool, and mcount on objects built for x86, ppc64le, arm64, s390, and
sparc. I used PowerPC as a sample arch for fixing a bug (see Changes)
and confirmed it builds a full zImage with defconfig
(CONFIG_DYNAMIC_FTRACE=y).

Changes
v4:
	Split out recordmcount cleanups and upstreamed.
	[ https://lore.kernel.org/lkml/20190802134712.2d8cc63f@gandalf.local.home/ ]

	Split out and iterated on objtool multi-arch support.
	[ https://lore.kernel.org/lkml/cover.1586468801.git.mhelsley@vmware.com/ ]

	Split out expanded relocation support, renamed types, and functions
	to reflect expanded relocation support, and posted.
	[ https://lore.kernel.org/lkml/cover.1590785960.git.mhelsley@vmware.com/ ]

	This set is based on the patches sent upstream and posted above.

	Adapted to renames by Ingo and Peter: s/elf_open/elf_open_read/

	Added weak symbols for mcount subcommand
		This nicely eliminated the need for the mcount.h header.

	Added tools/objtool/Makefile per-arch SUBCMD_ blocks for each
		arch recordmcount / mcount supports.

	Moved ftrace/mcount/record.h from objtool_dep to recordmcount_dep
		This keeps the dependencies better organized.

	Fixed Makefile issue reported for PowerPC and a couple other archs
		by kbuild test robot. The always-$(BUILD_C_RECORDMCOUNT)
		line wasn't sufficiently replaced. Added to prepare-objtool
		target in top level Makefile.

	Split up dependencies to be independent of CONFIG_STACK_VALIDATION
		and CONFIG_UNWINDER_ORC since these are x86-specific.
		Now any arch which uses the C version of recordmcount
		will build objtool if dynamic tracing is enabled.

	Added a second rename at the end to be consistent with other
		objtool subcommands.

v3:
        Rebased on mainline. s/elf_open/elf_read/ in recordmcount.c

v2:
        Fix whitespace before line continuation

        Add ftrace/mcount/record.h to objtool_dep

        Rename the Makefile variable BUILD_C_RECORDMCOUNT to
            better reflect its purpose

        Similar: rename recordmcount_source => recordmcount_dep
            When using objtool we can just depend on the
            binary rather than the source the binary is
            built from. This should address Josh's feedback and
            make the Makefile code a bit clearer

        Add a comment to make reading the Makefile a little
            easier

        Rebased to latest mainline -rc


Matt Helsley (32):
  objtool: Prepare to merge recordmcount
  objtool: Make recordmcount into mcount subcmd
  objtool: recordmcount: Start using objtool's elf wrapper
  objtool: recordmcount: Search for __mcount_loc before walking the
    sections
  objtool: recordmcount: Convert do_func() relhdrs
  objtool: mcount: Remove unused fname parameter
  objtool: mcount: Use libelf for section header names
  objtool: mcount: Walk objtool Elf structs in find_secsym_ndx
  objtool: mcount: Use symbol structs to find mcount relocations
  objtool: mcount: Walk relocation lists
  objtool: mcount: Move get_mcountsym
  objtool: mcount: Replace MIPS offset types
  objtool: mcount: Move is_fake_mcount()
  objtool: mcount: Stop using ehdr in find_section_sym_index
  objtool: mcount: Move find_section_sym_index()
  objtool: mcount: Restrict using ehdr in append_func()
  objtool: mcount: Use objtool ELF to write
  objtool: mcount: Move nop_mcount()
  objtool: mcount: Move has_rel_mcount() and tot_relsize()
  objtool: mcount: Move relocation entry size detection
  objtool: mcount: Only keep ELF file size
  objtool: mcount: Use ELF header from objtool
  objtool: mcount: Remove unused file mapping
  objtool: mcount: Reduce usage of _size wrapper
  objtool: mcount: Move mcount_adjust out of wrapper
  objtool: mcount: Pre-allocate new ELF sections
  objtool: mcount: Generic location and relocation table types
  objtool: mcount: Move sift_rel_mcount out of wrapper file
  objtool: mcount: Remove wrapper for ELF relocation type
  objtool: mcount: Remove wrapper double-include trick
  objtool: mcount: Remove endian wrappers
  objtool: mcount: Rename

 Documentation/dontdiff                     |   2 +-
 Documentation/trace/ftrace-design.rst      |   4 +-
 Documentation/trace/ftrace.rst             |   6 +-
 Makefile                                   |  24 +-
 arch/arm64/include/asm/ftrace.h            |   2 +-
 arch/x86/include/asm/ftrace.h              |   2 +-
 kernel/trace/Kconfig                       |   2 +-
 scripts/.gitignore                         |   1 -
 scripts/Makefile                           |   1 -
 scripts/Makefile.build                     |  22 +-
 scripts/recordmcount.c                     | 663 --------------------
 scripts/recordmcount.h                     | 606 ------------------
 scripts/sorttable.h                        |   2 +-
 tools/objtool/.gitignore                   |   1 +
 tools/objtool/Build                        |   2 +
 tools/objtool/Makefile                     |  37 +-
 tools/objtool/builtin-mcount.c             |  50 ++
 tools/objtool/builtin.h                    |   2 +
 tools/objtool/elf.c                        |   5 +-
 tools/objtool/elf.h                        |   2 +
 tools/objtool/mcount.c                     | 682 +++++++++++++++++++++
 tools/objtool/objtool.c                    |   1 +
 tools/objtool/objtool.h                    |   1 +
 {scripts => tools/objtool}/recordmcount.pl |   0
 tools/objtool/weak.c                       |   5 +
 25 files changed, 821 insertions(+), 1304 deletions(-)
 delete mode 100644 scripts/recordmcount.c
 delete mode 100644 scripts/recordmcount.h
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/mcount.c
 rename {scripts => tools/objtool}/recordmcount.pl (100%)


base-commit: 2160e6958fc4fa0a70d5f8a2f32760c7ab3bfd6c
-- 
2.20.1

