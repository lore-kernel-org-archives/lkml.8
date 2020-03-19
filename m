Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B9FC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025D92071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCSLw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:52:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:45102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgCSLw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:52:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2E7BAC84;
        Thu, 19 Mar 2020 11:52:50 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        "linux-fsdevel @ vger . kernel . org --in-reply-to=" 
        <20200225173541.1549955-1-npiggin@gmail.com>
Subject: [PATCH v11 0/8] Disable compat cruft on ppc64le v11
Date:   Thu, 19 Mar 2020 12:52:20 +0100
Message-Id: <cover.1584613649.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Less code means less bugs so add a knob to skip the compat stuff.

Changes in v2: saner CONFIG_COMPAT ifdefs
Changes in v3:
 - change llseek to 32bit instead of builing it unconditionally in fs
 - clanup the makefile conditionals
 - remove some ifdefs or convert to IS_DEFINED where possible
Changes in v4:
 - cleanup is_32bit_task and current_is_64bit
 - more makefile cleanup
Changes in v5:
 - more current_is_64bit cleanup
 - split off callchain.c 32bit and 64bit parts
Changes in v6:
 - cleanup makefile after split
 - consolidate read_user_stack_32
 - fix some checkpatch warnings
Changes in v7:
 - add back __ARCH_WANT_SYS_LLSEEK to fix build with llseek
 - remove leftover hunk
 - add review tags
Changes in v8:
 - consolidate valid_user_sp to fix it in the split callchain.c
 - fix build errors/warnings with PPC64 !COMPAT and PPC32
Changes in v9:
 - remove current_is_64bit()
Chanegs in v10:
 - rebase, sent together with the syscall cleanup
Changes in v11:
 - rebase
 - add MAINTAINERS pattern for ppc perf

Michal Suchanek (8):
  powerpc: Add back __ARCH_WANT_SYS_LLSEEK macro
  powerpc: move common register copy functions from signal_32.c to
    signal.c
  powerpc/perf: consolidate read_user_stack_32
  powerpc/perf: consolidate valid_user_sp
  powerpc/64: make buildable without CONFIG_COMPAT
  powerpc/64: Make COMPAT user-selectable disabled on littleendian by
    default.
  powerpc/perf: split callchain.c by bitness
  MAINTAINERS: perf: Add pattern that matches ppc perf to the perf
    entry.

 MAINTAINERS                            |   2 +
 arch/powerpc/Kconfig                   |   5 +-
 arch/powerpc/include/asm/thread_info.h |   4 +-
 arch/powerpc/include/asm/unistd.h      |   1 +
 arch/powerpc/kernel/Makefile           |   6 +-
 arch/powerpc/kernel/entry_64.S         |   2 +
 arch/powerpc/kernel/signal.c           | 144 +++++++++-
 arch/powerpc/kernel/signal_32.c        | 140 ----------
 arch/powerpc/kernel/syscall_64.c       |   6 +-
 arch/powerpc/kernel/vdso.c             |   3 +-
 arch/powerpc/perf/Makefile             |   5 +-
 arch/powerpc/perf/callchain.c          | 356 +------------------------
 arch/powerpc/perf/callchain.h          |  20 ++
 arch/powerpc/perf/callchain_32.c       | 196 ++++++++++++++
 arch/powerpc/perf/callchain_64.c       | 174 ++++++++++++
 fs/read_write.c                        |   3 +-
 16 files changed, 556 insertions(+), 511 deletions(-)
 create mode 100644 arch/powerpc/perf/callchain.h
 create mode 100644 arch/powerpc/perf/callchain_32.c
 create mode 100644 arch/powerpc/perf/callchain_64.c

-- 
2.23.0

