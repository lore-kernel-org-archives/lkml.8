Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C18EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738EC208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgFRUjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:00 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:16524 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbgFRUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:38:59 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:38:55 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 932A9B2656;
        Thu, 18 Jun 2020 16:38:58 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 00/51] objtool: Make recordmcount a subcommand
Date:   Thu, 18 Jun 2020 13:37:46 -0700
Message-ID: <cover.1592510545.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

recordmcount has its own ELF wrapper code and could utilize
objtool's ELF code to more-portably handle architecture variations.
This series makes recordmcount a subcommand of objtool. It very
gradually converts recordmcount to become a subcommand of objtool and
then reuses parts of objtool's ELF code.

recordmcount maps the file in and collects simple information it needs to
append a section to the object file. The only part of the original file it
modifies is the address of new section tables -- interestingly enough this
resembles RCU in that we don't really trim the old tables so
much as unlink them via a critical offset and then rely on
future tooling, in this case, to drop the unused bits.

Much of the recordmcount ELF code is only reading and walking the data
structures to collect the mcount locations it records in a separate
area of memory. This means it's safe to mix access to the mapped
file with access to the objtool-style linked data
structures as we gradually convert it to using only the linked data
structures. Once the old ELF code is no longer in use we can drop it
and use objtool to take over the task of writing the results without
using the RCU-like trick any more.

After that we greatly simplify the mcount subcommand by adding a
few flags to the ELF reading code in objtool. Overall the series
removes about 600 lines of recordmcount while adding little to
objtool's ELF code.

Testing so far:

I've been using scripts to test cross compilation and execution of
objtool, and mcount on objects built for x86, ppc64le, arm64, s390, and
sparc.


Applies on top of:
	objtool/core

	Peter Zijlstra's "x86/entry: noinstr fixes" [2]

	Sami Tolvanen's patch enabling support for more than 64k
	sections in recordmcount, already going upstream. [3]

Changes since v4[1]:
v5:
	Updated the HAVE_C_RECORDMCOUNT Kconfig description.

	Removed unused extern is_cmd_mcount_available() spotted by Julien Thierry.

	Issue with symbol info handling reported and fixed by Kamalesh Babulal.

	Removed the giant per-supported-arch series of ifdef blocks in
	the objtool Makefile and replaced with new CONFIG_ variables
	as suggested by Julien Thierry.

	Moved the first pass through the sections into objtool's ELF
	code as suggested by Peter Zijlstra.

	Removed a redundant section lookup.

	Removed old comments that no longer apply since conversion to objtool.

v4:
	Split out recordmcount cleanups and upstreamed. [5]

	Split out, iterated on objtool multi-arch support, and upstreamed. [6]

	Split out expanded relocation support, renamed types, and functions
	to reflect expanded relocation support, and upstreamed. [4]

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

[1] https://lore.kernel.org/lkml/cover.1591125127.git.mhelsley@vmware.com/
[2] https://lore.kernel.org/lkml/20200618144407.520952071@infradead.org
[3] https://lore.kernel.org/lkml/20200424193046.160744-1-samitolvanen@google.com
[4] https://lore.kernel.org/lkml/cover.1590785960.git.mhelsley@vmware.com/
[5] https://lore.kernel.org/lkml/20190802134712.2d8cc63f@gandalf.local.home/
[6] https://lore.kernel.org/lkml/cover.1586468801.git.mhelsley@vmware.com/


Matt Helsley (51):
  objtool: Factor out reasons to build objtool
  objtool: Prepare to merge recordmcount
  objtool: Make recordmcount into mcount subcmd
  objtool: recordmcount: Start using objtool's elf wrapper
  objtool: recordmcount: Search for __mcount_loc before walking the
    sections
  objtool: recordmcount: Convert do_func() relhdrs
  objtool: mcount: Move nhdr into find_symtab()
  objtool: mcount: Remove unused fname parameter
  objtool: mcount: Use libelf for section header names
  objtool: mcount: Walk objtool Elf structs in find_secsym_ndx
  objtool: mcount: Use symbol structs to find mcount relocations
  objtool: mcount: Walk relocation lists
  objtool: mcount: Return symbol from mcountsym
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
  objtool: mcount: Use objtool relocation section
  objtool: mcount: Move sift_rel_mcount out of wrapper file
  objtool: mcount: Remove wrapper for ELF relocation type
  objtool: mcount: Remove wrapper double-include trick
  objtool: mcount: Remove endian wrappers
  objtool: mcount: Rename to mcount.c
  objtool: mcount: Simplify mcount name matching
  objtool: mcount: mcount symbol name simplification
  objtool: mcount: Verify x86 instruction with memcmp()
  objtool: mcount: const-ify ARM instruction patterns
  objtool: mcount: Convert nop writes to elf_write_insn()
  objtool: mcount: Move mcount symbol name testing
  objtool: check: Use class to recognize kcov calls
  objtool: mcount: Keep lists locations and relocations
  objtool: mcount: Move mcount section test to objtool ELF
  objtool: mcount: Flag mcount relocation sections
  objtool: mcount: Merge section mcount flags
  objtool: mcount: Eliminate first pass
  objtool: mcount: Remove relocation size check
  objtool: mcount: Remove useless lookup
  objtool: mcount: Remove stale description

 Documentation/dontdiff                     |   2 +-
 Documentation/trace/ftrace-design.rst      |   4 +-
 Documentation/trace/ftrace.rst             |   6 +-
 Makefile                                   |  39 +-
 arch/Kconfig                               |  23 +
 arch/arm64/include/asm/ftrace.h            |   2 +-
 arch/x86/Kconfig.debug                     |   1 +
 arch/x86/include/asm/ftrace.h              |   2 +-
 kernel/trace/Kconfig                       |   9 +-
 lib/Kconfig.debug                          |   1 +
 scripts/.gitignore                         |   1 -
 scripts/Makefile                           |   1 -
 scripts/Makefile.build                     |  22 +-
 scripts/recordmcount.c                     | 663 --------------------
 scripts/recordmcount.h                     | 692 ---------------------
 scripts/sorttable.h                        |   2 +-
 tools/objtool/.gitignore                   |   1 +
 tools/objtool/Build                        |   2 +
 tools/objtool/Makefile                     |  14 +-
 tools/objtool/builtin-mcount.c             |  50 ++
 tools/objtool/builtin.h                    |   1 +
 tools/objtool/check.c                      |   3 +-
 tools/objtool/elf.c                        |  60 +-
 tools/objtool/elf.h                        |  12 +-
 tools/objtool/mcount.c                     | 596 ++++++++++++++++++
 tools/objtool/objtool.c                    |   1 +
 tools/objtool/objtool.h                    |   1 +
 {scripts => tools/objtool}/recordmcount.pl |   0
 tools/objtool/weak.c                       |   5 +
 29 files changed, 806 insertions(+), 1410 deletions(-)
 delete mode 100644 scripts/recordmcount.c
 delete mode 100644 scripts/recordmcount.h
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/mcount.c
 rename {scripts => tools/objtool}/recordmcount.pl (100%)


base-commit: 14bda4e5293ed9722f1dc39b543024e37707d6c6
prerequisite-patch-id: b9f6483185e4e80fccbb6ec7276bf61ce0329472
prerequisite-patch-id: 6d3fec64974cdce64fec35141ff71f0532cb8c82
prerequisite-patch-id: b71e084f3d2adeb4d05e4327183b75b388a20e6d
prerequisite-patch-id: 261f5d8102f4ecee86df2eb93be6a29495702717
prerequisite-patch-id: 64fa3e2f92e5dfd1b64289b4118288b6d2a25a67
prerequisite-patch-id: e5671d612490912b263505907657f3197c4a0833
prerequisite-patch-id: cba407d3dc82ad54095a9b5149b0c851c4e30b19
prerequisite-patch-id: bcf669a844506eec601cba1797f954e59cc7a2ad
-- 
2.20.1

