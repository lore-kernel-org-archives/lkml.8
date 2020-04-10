Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88487C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6655820801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDJTgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:36:24 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:55107 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgDJTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:36:23 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:36:05 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id D5E72B2C7E;
        Fri, 10 Apr 2020 15:36:09 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
Date:   Fri, 10 Apr 2020 12:35:23 -0700
Message-ID: <cover.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
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
This series makes recordmcount a subcommand of objtool.

The initial 5 patches make objtool compilable for more than x86.
Unlike recordmcount the check command and orc tools are not currently
checking other architectures so we need a way to cleanly build
objtool for those architectures that don't support check / orc. I
went with using weak symbols and added a "missing" architecture
which can be used to indicate the tool is not implemented while
avoiding the need for every architecture to explicitly specify
which subcommands / features are not implemented. I'm curious if
there are better approaches folks recommend though -- this is the
one I landed on. The patches do not add HAVE_OBJTOOL to all
architectures.

Note:
I've been following some of the discussion around making check work
for arm64. So I'd say this series moves check into arch/x86 to
reflect its current status and demonstrates how a command relevant
to a single arch could be handled -- not necessarily what
will/should happen to check.

Subsequent patches, the bulk of the set, very gradually convert
recordmcount to become a subcommand of objtool and then reuse
parts of objtool's ELF code. recordmcount maps the file in and
collects simple information it needs to append a section to the
object file. The only part of the original file it modifies is the
address of new section tables -- interestingly enough this
resembles RCU in that we don't really trim the old tables so
much as unlink them via one critical offset and then rely on
future (tooling in this case) to drop the unused bits. So much of
the recordmcount ELF code is only reading and walking the data
structures to collect the mcount locations it records in a separate
area of memory. This means it's safe to mix access to the mapped
file with access to the objtool-style linked data
structures as we gradually convert it to using only the linked data
structures. Once the old ELF code is no longer in use we can drop it
and use objtool to take over the task of writing the results without
using the RCU-like trick any more.

Testing so far:

I've been using scripts to test compilation, execution of objtool,
and mcount output for x86, ppc64le, arm64, s390, and sparc.

Matt Helsley (36):
  objtool: Exit successfully when requesting help
  objtool: Move struct objtool_file into arch-independent header
  objtool: Enable compilation of objtool for all architectures
  objtool: Report missing support for subcommands
  objtool: Add support for relocations without addends
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
  objtool: mcount: Move helpers out of ELF wrapper
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
  objtool: mcount: Remove wordsized endian wrappers

 Documentation/dontdiff                     |   2 +-
 Documentation/trace/ftrace-design.rst      |   4 +-
 Documentation/trace/ftrace.rst             |   6 +-
 Makefile                                   |   6 +-
 arch/arm64/include/asm/ftrace.h            |   2 +-
 arch/x86/include/asm/ftrace.h              |   2 +-
 kernel/trace/Kconfig                       |   2 +-
 scripts/.gitignore                         |   1 -
 scripts/Makefile                           |   1 -
 scripts/Makefile.build                     |  24 +-
 scripts/recordmcount.c                     | 663 --------------------
 scripts/recordmcount.h                     | 606 ------------------
 scripts/sorttable.h                        |   2 +-
 tools/objtool/.gitignore                   |   1 +
 tools/objtool/Build                        |   6 +-
 tools/objtool/Makefile                     |   1 +
 tools/objtool/arch/missing/Build           |   4 +
 tools/objtool/arch/missing/check.c         |  16 +
 tools/objtool/arch/missing/mcount.c        |  16 +
 tools/objtool/arch/missing/orc_dump.c      |  13 +
 tools/objtool/arch/missing/orc_gen.c       |  16 +
 tools/objtool/arch/x86/Build               |   4 +
 tools/objtool/{ => arch/x86}/arch.h        |  42 +-
 tools/objtool/{ => arch/x86}/cfi.h         |   0
 tools/objtool/{ => arch/x86}/check.c       |  11 +-
 tools/objtool/arch/x86/decode.c            |   2 +-
 tools/objtool/{ => arch/x86}/orc_dump.c    |   5 +-
 tools/objtool/{ => arch/x86}/orc_gen.c     |   9 +-
 tools/objtool/{ => arch/x86}/special.c     |   4 +-
 tools/objtool/{ => arch/x86}/special.h     |   2 +-
 tools/objtool/builtin-check.c              |   5 +
 tools/objtool/builtin-mcount.c             |  56 ++
 tools/objtool/builtin-orc.c                |   9 +-
 tools/objtool/builtin.h                    |   4 +
 tools/objtool/check.h                      |  48 +-
 tools/objtool/elf.c                        |  60 +-
 tools/objtool/elf.h                        |   7 +-
 tools/objtool/mcount.h                     |  14 +
 tools/objtool/objtool.c                    |  40 +-
 tools/objtool/objtool.h                    |  20 +
 tools/objtool/orc.h                        |   3 +-
 tools/objtool/recordmcount.c               | 682 +++++++++++++++++++++
 {scripts => tools/objtool}/recordmcount.pl |   0
 43 files changed, 1038 insertions(+), 1383 deletions(-)
 delete mode 100644 scripts/recordmcount.c
 delete mode 100644 scripts/recordmcount.h
 create mode 100644 tools/objtool/arch/missing/Build
 create mode 100644 tools/objtool/arch/missing/check.c
 create mode 100644 tools/objtool/arch/missing/mcount.c
 create mode 100644 tools/objtool/arch/missing/orc_dump.c
 create mode 100644 tools/objtool/arch/missing/orc_gen.c
 rename tools/objtool/{ => arch/x86}/arch.h (59%)
 rename tools/objtool/{ => arch/x86}/cfi.h (100%)
 rename tools/objtool/{ => arch/x86}/check.c (99%)
 rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
 rename tools/objtool/{ => arch/x86}/orc_gen.c (96%)
 rename tools/objtool/{ => arch/x86}/special.c (98%)
 rename tools/objtool/{ => arch/x86}/special.h (95%)
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/mcount.h
 create mode 100644 tools/objtool/objtool.h
 create mode 100644 tools/objtool/recordmcount.c
 rename {scripts => tools/objtool}/recordmcount.pl (100%)

-- 
2.20.1

