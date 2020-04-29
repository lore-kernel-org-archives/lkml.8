Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDEFC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2338C206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="Ahl0SrD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgD2Tdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2Tdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:33:38 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D0C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:38 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b5so2196567vsb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRdI90AKsL3O7dZ2lSJYmqj/6bz+YdejFzW1mnJUrgI=;
        b=Ahl0SrD/Dt6/HPWqDYFbPOt3ulNQ2HfWnZhkhXokNsx1QHwgfANGwY2BHX6T2K4oVz
         VwAQhTNdcelI+WWQ0TmWUyWwOt6fZhWhHDK6by4VDQGONhAzpNURylA8uSgCuesm42t0
         17aha8ZdRiUgSnJ6mog0XmkBqsDzHxm1Ij1iCMKtriYzgjkUw0OlmsPwdBVmotDO1m/y
         GtIm6LK4RF4GOuwzxy84aPFuh+Y4sHHD3OL69B6TMSxUVesGtbPRiPfN/SXoQ4D1sCL0
         ErfI6nkYG7xsCxsjOOqO2Ysp1N1LRrkoxy6AR3icFvGxEmZnKoEJSKp/fYzkUa+1XNIk
         lEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRdI90AKsL3O7dZ2lSJYmqj/6bz+YdejFzW1mnJUrgI=;
        b=MJf+A8B0sboI6/mR4/k8Uz2vsjytNyxhgoh1kqcnnKbcHhWi/GM51/E+Psp/EqbVym
         jmUyqLZwvWXU9quS14H59AdFIhYBap6qPSfhopZsHaJ4+n8FULZ2j9vCsmCYqYBQ+nOg
         0CfYJJowJRLInZD9kF8bNMtaogutnZ7v+HFgwcDnimFWbMngg1/GPUi7gFR7C3uQaIOE
         xO8yahJQ8XpUt5kf1k9gyCbby6+VjeguoKn2vibcKcSpeWgy2TOHmgMu8+Fa3cJjO2wh
         VCmUi9AHTtyBjlz9hlna42sILSS8nqHJ8GJdiUqp3J+8TPfP8nZtSw3AalAWo6BE4F2M
         aK0g==
X-Gm-Message-State: AGi0PuYbokACAG68MiPcCoXtknzdIzvweJehsaBU+P5Nlj8f/dXclwxJ
        69Z3N39STdyb8I9ChZWTOsfJRw==
X-Google-Smtp-Source: APiQypJX5UZsy6P0sBNEDb7qJAv8joElK74wbwZA2oeda0vMgAUh4TB8VL/kYJD4wdoNKcszYL0sIw==
X-Received: by 2002:a67:dd98:: with SMTP id i24mr27983294vsk.239.1588188817594;
        Wed, 29 Apr 2020 12:33:37 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:33:37 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 0/9] Popcorn Linux Distributed Thread Execution
Date:   Wed, 29 Apr 2020 15:32:47 -0400
Message-Id: <cover.1588127445.git.javier.malave@narfindustries.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <0>
References: <0>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds the Popcorn Distributed Thread Execution support
to the kernel. It is based off of Linux 5.2 commit 72a20ce. We are
looking for feedback on design and implementation from the community.

Background
==========

Popcorn Linux is a collaborative work by the Software and Systems Research
Group at Virginia Tech. It is based on the original thesis by David
Katz. Principal contributors since include, Sang-Hoon Kim, Maria Sadini
Ajith Saya, Vicnent Legout, Antonio Barbalace and Binoy Ravindran. 

Popcorn Linux is a Linux kernel-based software stack that enables
applications to execute, with a shared code base, on distributed hosts.
Popcorn allows applications to start execution on a particular host and
migrate, at run-time, to a remote host. Multi-threaded applications may
migrate any particular thread to any remote host. 

Unlike userspace checkpoint-restart solutions (e.g., CRIU), Popcorn 
enables seamless and dynamic migration across hosts during execution
(no user interaction), and ensures coherent virtual memory across hosts 
for concurrent thread execution.

Popcorn Linux implements a software-based distributed shared memory 
by extending Linux's virtual memory subsystem and it enables processes 
on different machines to observe a common and coherent virtual address
space. Coherency of virtual memory pages of different hosts is ensured 
using a reader-replicate/writer-invalidate, page-level consistency protocol.

The version of Popcorn Linux presented in this RFC supports only x86
configurations. The stack in this RFC includes a modified kernel and a 
userspace run-time library.

There is a more advanced version of Popcorn Linux that allows applications
to concurrently execute across ISA-different cores (.e.g. X86, ARM). This 
feature-rich version adds a customized LLVM-compiler toolchain to the stack. 
Nevertheless, this RFC focuses on a simpler single-architecture form of 
Popcorn that does not require compiler modifications.

Both the compiler toolchain and the heterogeneous implementation of
Popcorn Linux may be found at these github locations. It should be noted
the heterogeneous version is under active development and is likely less 
stable than the one provided in this patch.

Heterogeneous Popcorn Linux
https://github.com/ssrg-vt/popcorn-kernel

LLVM Compiler
https://github.com/ssrg-vt/popcorn-compiler

More information on the Popcorn Linux research team and their current
work may be found here:

http://popcornlinux.org/

Popcorn Library
===============

The Popcorn kernel library is a suite of light tests that showcase
the use of Popcorn's core system calls. These tests allow for a 
basic migration of processes and threads between 2 or more nodes.

The test suite is being expanded and may be found in at 
https://github.com/ssrg-vt/popcorn-kernel-lib. The branch 
matching this RFC kernel code base is called "upstream". 

Reverting L1TF protections
==========================

This initial iteration of code currently reverts L1TF side channel
protections on x86 systems. Future iterations of code will comply
with the L1TF patches and current pagetable walking algorithms.

Security Disclaimer
===================

Popcorn Linux assumes that it is operating across equally-trusted host
systems. This patch-set is intended to initiate discussions and should
not be built and loaded onto public (internet-connected) machines.
Popcorn Linux, as-is, runs a kernel-based daemon that listens for
messages passed to it via a TCP socket.  This IP-based message layer
is intended for Popcorn testing and development purposes only, given
obvious latency and security issues stemming from passing pages and
kernel structures over TCP.

Andrew Hughes (9):
  Core Popcorn Changes Popcorn Linux
  Add x86 specifc files for Popcorn
  Temporarily revert L1TF mitigation for Popcorn
  Popcorn system call additions
  Popcorn Utility
  Process Server for Popcorn Distributed Thread Execution
  Virtual Memory Address Server for Distributed Thread Execution
  Page Server for Distributed Thread Execution
  Add Popcorn Message Layer and socket support

 arch/x86/Kconfig                       |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 arch/x86/include/asm/pgtable-2level.h  |   17 -
 arch/x86/include/asm/pgtable-3level.h  |    2 -
 arch/x86/include/asm/pgtable.h         |   52 +-
 arch/x86/include/asm/pgtable_64.h      |    2 -
 arch/x86/kernel/Makefile               |    1 +
 arch/x86/kernel/process_server.c       |  250 +++
 arch/x86/mm/fault.c                    |   18 +
 arch/x86/mm/mmap.c                     |   21 -
 drivers/msg_layer/Kconfig              |   28 +
 drivers/msg_layer/Makefile             |    2 +
 drivers/msg_layer/common.h             |   63 +
 drivers/msg_layer/socket.c             |  710 +++++++++
 fs/proc/base.c                         |    9 +
 fs/read_write.c                        |   15 +-
 include/linux/mm_types.h               |   12 +
 include/linux/sched.h                  |   27 +-
 include/linux/syscalls.h               |    9 +
 include/popcorn/bundle.h               |   38 +
 include/popcorn/debug.h                |   38 +
 include/popcorn/page_server.h          |   34 +
 include/popcorn/pcn_kmsg.h             |  205 +++
 include/popcorn/process_server.h       |   18 +
 include/popcorn/regset.h               |   96 ++
 include/popcorn/stat.h                 |   16 +
 include/popcorn/types.h                |   20 +
 include/popcorn/vma_server.h           |   33 +
 include/uapi/asm-generic/mman-common.h |    4 +
 include/uapi/asm-generic/unistd.h      |   11 +-
 kernel/Kconfig.popcorn                 |   54 +
 kernel/Makefile                        |    1 +
 kernel/exit.c                          |    9 +
 kernel/fork.c                          |   51 +-
 kernel/futex.c                         |   32 +
 kernel/popcorn/Makefile                |    7 +
 kernel/popcorn/bundle.c                |  115 ++
 kernel/popcorn/fh_action.c             |  207 +++
 kernel/popcorn/fh_action.h             |   34 +
 kernel/popcorn/init.c                  |   58 +
 kernel/popcorn/page_server.c           | 2019 ++++++++++++++++++++++++
 kernel/popcorn/page_server.h           |   16 +
 kernel/popcorn/pcn_kmsg.c              |  231 +++
 kernel/popcorn/pgtable.h               |   31 +
 kernel/popcorn/process_server.c        | 1037 ++++++++++++
 kernel/popcorn/process_server.h        |   21 +
 kernel/popcorn/stat.c                  |  165 ++
 kernel/popcorn/trace_events.h          |   76 +
 kernel/popcorn/types.h                 |  358 +++++
 kernel/popcorn/util.c                  |  121 ++
 kernel/popcorn/util.h                  |   14 +
 kernel/popcorn/vma_server.c            |  818 ++++++++++
 kernel/popcorn/vma_server.h            |   24 +
 kernel/popcorn/wait_station.c          |   84 +
 kernel/popcorn/wait_station.h          |   27 +
 kernel/sched/core.c                    |  106 +-
 kernel/sys_ni.c                        |    3 +
 mm/gup.c                               |   18 +
 mm/internal.h                          |    4 +
 mm/madvise.c                           |   51 +
 mm/memory.c                            |  236 ++-
 mm/mmap.c                              |   53 +
 mm/mprotect.c                          |   70 +-
 mm/mremap.c                            |   20 +
 64 files changed, 7763 insertions(+), 165 deletions(-)
 create mode 100644 arch/x86/kernel/process_server.c
 create mode 100644 drivers/msg_layer/Kconfig
 create mode 100644 drivers/msg_layer/Makefile
 create mode 100644 drivers/msg_layer/common.h
 create mode 100644 drivers/msg_layer/socket.c
 create mode 100644 include/popcorn/bundle.h
 create mode 100644 include/popcorn/debug.h
 create mode 100644 include/popcorn/page_server.h
 create mode 100644 include/popcorn/pcn_kmsg.h
 create mode 100644 include/popcorn/process_server.h
 create mode 100644 include/popcorn/regset.h
 create mode 100644 include/popcorn/stat.h
 create mode 100644 include/popcorn/types.h
 create mode 100644 include/popcorn/vma_server.h
 create mode 100644 kernel/Kconfig.popcorn
 create mode 100644 kernel/popcorn/Makefile
 create mode 100644 kernel/popcorn/bundle.c
 create mode 100644 kernel/popcorn/fh_action.c
 create mode 100644 kernel/popcorn/fh_action.h
 create mode 100644 kernel/popcorn/init.c
 create mode 100644 kernel/popcorn/page_server.c
 create mode 100644 kernel/popcorn/page_server.h
 create mode 100644 kernel/popcorn/pcn_kmsg.c
 create mode 100644 kernel/popcorn/pgtable.h
 create mode 100644 kernel/popcorn/process_server.c
 create mode 100644 kernel/popcorn/process_server.h
 create mode 100644 kernel/popcorn/stat.c
 create mode 100644 kernel/popcorn/trace_events.h
 create mode 100644 kernel/popcorn/types.h
 create mode 100644 kernel/popcorn/util.c
 create mode 100644 kernel/popcorn/util.h
 create mode 100644 kernel/popcorn/vma_server.c
 create mode 100644 kernel/popcorn/vma_server.h
 create mode 100644 kernel/popcorn/wait_station.c
 create mode 100644 kernel/popcorn/wait_station.h

-- 
2.17.1

