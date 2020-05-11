Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FD9C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53853206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgEKRff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:35:35 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:26394 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729698AbgEKRff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:35:35 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 May 2020 10:35:33 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1CF1540193;
        Mon, 11 May 2020 10:35:34 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 0/5] Enable objtool multiarch build
Date:   Mon, 11 May 2020 10:35:08 -0700
Message-ID: <cover.1588888003.git.mhelsley@vmware.com>
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

My previous RFC[1] tried to add recordmcount as the mcount subcommand
of objtool. As a necessary first step that required enabling building
of objtool for more than the x86 architecture.

Some folks have been working on enabling objtool checking functionality
for arm64. Rather than repeat that work here I aim to show a minimal
set which ensures that objtool builds for any architecture. This
will allow for not only building the check and ORC subcommands
but also incorporating more subcommands -- such as recordmcount.

I changed the Makefile to use the SRCARCH to determine which subcommands
should be available and set the appropriate SUBCMD_ variables. Those
variables then get used in the Build file to conditionally build them into
objtool. When the files are missing suitable empty definitions are located
in arch/missing so that the compilation will succeed while also allowing
objtool to report that the command is unavailable on the architecture.

Since the series does not add support for stack validation or checking
to any new architectures there's no reason to make KConfig or Makefile
changes which would normally be used to test this. So I've been forcing
builds of objtool with:

make O=build-ARCH ARCH=foo CROSS_COMPILE=foo-linux-gnu- defconfig
make O=build-ARCH ARCH=foo CROSS_COMPILE=foo-linux-gnu- tools/objtool

And running the resulting binary in qemu-static to verify that it
shows all objtool subcommands are supported on x86 and unsupported on
another arch.

[1] https://lore.kernel.org/lkml/cover.1586468801.git.mhelsley@vmware.com/

Matt Helsley (5):
  objtool: Exit successfully when requesting help
  objtool: Move struct objtool_file into arch-independent header
  objtool: Add support for relocations without addends
  objtool: Enable compilation of objtool for all architectures
  objtool: Report missing support for subcommands

 tools/objtool/Build                    | 10 +++--
 tools/objtool/Makefile                 | 11 +++++-
 tools/objtool/arch.h                   | 40 +++++++++++++++++++
 tools/objtool/arch/missing/Build       |  3 ++
 tools/objtool/arch/missing/check.c     | 16 ++++++++
 tools/objtool/arch/missing/orc_dump.c  | 13 ++++++
 tools/objtool/arch/missing/orc_gen.c   | 16 ++++++++
 tools/objtool/arch/x86/Build           |  1 +
 tools/objtool/{ => arch/x86}/special.c |  4 +-
 tools/objtool/{ => arch/x86}/special.h |  2 +-
 tools/objtool/builtin-check.c          |  5 +++
 tools/objtool/builtin-orc.c            |  9 ++++-
 tools/objtool/builtin.h                |  2 +
 tools/objtool/check.c                  |  5 ++-
 tools/objtool/check.h                  | 48 +---------------------
 tools/objtool/elf.c                    | 55 +++++++++++++++++++++-----
 tools/objtool/elf.h                    |  5 ++-
 tools/objtool/objtool.c                | 39 +++++++++++++++---
 tools/objtool/objtool.h                | 20 ++++++++++
 tools/objtool/orc.h                    |  3 +-
 tools/objtool/orc_dump.c               |  1 +
 tools/objtool/orc_gen.c                |  3 ++
 22 files changed, 235 insertions(+), 76 deletions(-)
 create mode 100644 tools/objtool/arch/missing/Build
 create mode 100644 tools/objtool/arch/missing/check.c
 create mode 100644 tools/objtool/arch/missing/orc_dump.c
 create mode 100644 tools/objtool/arch/missing/orc_gen.c
 rename tools/objtool/{ => arch/x86}/special.c (98%)
 rename tools/objtool/{ => arch/x86}/special.h (95%)
 create mode 100644 tools/objtool/objtool.h


base-commit: 6e7f2eacf09811d092c1b41263108ac7fe0d089d
-- 
2.20.1

