Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F03AC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD75E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgA3KTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:19:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52708 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3KTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:19:30 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4AD9E15AB16DD;
        Thu, 30 Jan 2020 02:19:29 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:19:27 +0100 (CET)
Message-Id: <20200130.111927.1184332737812002632.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jan 2020 02:19:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Add a proper .exit.data section.

2) Fix ipc64_perm type definition, from Arnd Bergmann.

3) Support folded p4d page tables on sparc64, from Mike Rapport.

4) Remove uses of struct timex, also from Arnd Bergmann.

Please pull, thanks a lot!

The following changes since commit 7b5cf701ea9c395c792e2a7e3b7caf4c68b87721:

  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-07-22 09:30:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to d68712ee35069455ea4043d443c8d4fb9a1ee956:

  y2038: sparc: remove use of struct timex (2020-01-30 11:14:28 +0100)

----------------------------------------------------------------
Andreas Larsson (1):
      sparc32, leon: Stop adding vendor and device id to prom ambapp path components

Arnd Bergmann (2):
      sparc32: fix struct ipc64_perm type definition
      y2038: sparc: remove use of struct timex

Arvind Sankar (1):
      sparc/console: kill off obsolete declarations

David S. Miller (1):
      sparc: Add .exit.data section.

Masahiro Yamada (1):
      sparc: remove unneeded uapi/asm/statfs.h

Mike Rapoport (1):
      sparc64: add support for folded p4d page tables

 arch/sparc/include/asm/pgalloc_64.h  |  6 +++---
 arch/sparc/include/asm/pgtable_64.h  | 24 ++++++++++++------------
 arch/sparc/include/uapi/asm/ipcbuf.h | 22 +++++++++++-----------
 arch/sparc/include/uapi/asm/statfs.h |  7 -------
 arch/sparc/kernel/prom_32.c          | 18 ++++--------------
 arch/sparc/kernel/signal32.c         |  6 +++++-
 arch/sparc/kernel/smp_64.c           | 13 ++++++++++++-
 arch/sparc/kernel/sys_sparc_64.c     | 33 +++++++++++++++++----------------
 arch/sparc/kernel/vmlinux.lds.S      |  6 ++++--
 arch/sparc/mm/fault_64.c             |  6 +++++-
 arch/sparc/mm/hugetlbpage.c          | 28 ++++++++++++++++++----------
 arch/sparc/mm/init_64.c              | 33 +++++++++++++++++++++++++++++----
 include/linux/console.h              |  2 --
 include/uapi/linux/timex.h           |  2 ++
 14 files changed, 122 insertions(+), 84 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/statfs.h
