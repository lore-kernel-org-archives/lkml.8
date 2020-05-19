Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3560C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EBD12075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgESUzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:55:55 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:40869 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgESUzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:55:55 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 May 2020 13:55:52 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6EE55404B7;
        Tue, 19 May 2020 13:55:54 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH 0/3] Enable objtool multiarch build
Date:   Tue, 19 May 2020 13:55:30 -0700
Message-ID: <cover.1589913349.git.mhelsley@vmware.com>
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

As a necessary first step to adding new architecture and subcommand
support to objtool enabling building of objtool for more than the x86
architecture.

Some folks have been working on enabling objtool checking functionality
for arm64. Rather than repeat that work here this minimal set does not
port the existing commands but replaces them with weak, not-implemented
versions which exit with status 127. On x86 the check and orc
subcommands will still build and operate correctly while on other
architectures the commands will exit with status 127. This allows future
changes to port the check command to arm64 or add new subcommands
such as mcount to replace the separate recordmcount tool.

Since the series does not add support for stack validation or checking
to any new architectures there's no reason to make KConfig or Makefile
changes which would normally be used to test this. So I've been forcing
builds of objtool with:

make O=build-foo ARCH=foo CROSS_COMPILE=foo-linux-gnu- defconfig
make O=build-foo ARCH=foo CROSS_COMPILE=foo-linux-gnu- tools/objtool

And running the resulting binary to verify that it shows all objtoo
subcommands are supported on x86 and unsupported on other archs.

Changes since RFC[1]:
 - Removed the arch/missing pattern and put everything in weak.c
	(Julien Thierry and Josh Poimboeuf)
 - Kept arch.h, special, etc. in the top level objtool dir (Julien)
 - Dropped the patch reporting which subcommands are missing in --help
	output
 - Postponed the rela patch
	Josh asked to rename a bunch of these variables and suggested
	an untested improvement. Since they're necessary for
	recordmcount but not the current arch built support we can drop
	them from this set.
 - Misc: Removed else (Josh) and updated the commit messages (Julien)
 - Cleaned up includes
	Moved the prototypes for the command entry functions and other
	functions that weak symbols need to be consistent with into
	objtool.h. (Josh)

Tested with cross-compilation for sparc, arm64, s390, and powerpc

[1] https://lore.kernel.org/lkml/cover.1588888003.git.mhelsley@vmware.com/

Matt Helsley (3):
  objtool: Exit successfully when requesting help
  objtool: Move struct objtool_file into arch-independent header
  objtool: Enable compilation of objtool for all architectures

 tools/objtool/Build           | 13 +++++++++----
 tools/objtool/Makefile        | 11 ++++++++++-
 tools/objtool/arch.h          |  4 +++-
 tools/objtool/builtin-check.c |  2 +-
 tools/objtool/builtin-orc.c   |  3 +--
 tools/objtool/check.c         |  4 ++--
 tools/objtool/check.h         | 12 ------------
 tools/objtool/objtool.c       |  4 +++-
 tools/objtool/objtool.h       | 34 ++++++++++++++++++++++++++++++++++
 tools/objtool/orc.h           | 18 ------------------
 tools/objtool/orc_dump.c      |  3 ++-
 tools/objtool/orc_gen.c       |  1 -
 tools/objtool/weak.c          | 35 +++++++++++++++++++++++++++++++++++
 13 files changed, 100 insertions(+), 44 deletions(-)
 create mode 100644 tools/objtool/objtool.h
 delete mode 100644 tools/objtool/orc.h
 create mode 100644 tools/objtool/weak.c


base-commit: bba413deb1065f1291cb1f366247513f11215520
-- 
2.20.1

