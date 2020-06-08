Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9354EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663882067B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFHAQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgFHAQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:16:20 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350EAC08C5C3;
        Sun,  7 Jun 2020 17:16:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 990D4127431FE;
        Sun,  7 Jun 2020 17:16:19 -0700 (PDT)
Date:   Sun, 07 Jun 2020 17:16:18 -0700 (PDT)
Message-Id: <20200607.171618.569910731236239182.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Jun 2020 17:16:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Rework the sparc32 page tables so that READ_ONCE(*pmd), as done by
   generic code, operates on a word sized element.  From Will Deacon.

2) Some scnprintf() conversions, from Chen Zhou.

3) A pin_user_pages() conversion from John Hubbard.

4) Several 32-bit ptrace register handling fixes and such from Al Viro.

Please pull, thanks a lot!

The following changes since commit 24085f70a6e1b0cb647ec92623284641d8270637:

  Merge tag 'trace-v5.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2020-05-12 11:06:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next 

for you to fetch changes up to 4f8ad73898171cea2dce9ecf5bd4337c9dfcddc1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2020-06-07 17:11:41 -0700)

----------------------------------------------------------------
Al Viro (3):
      sparc64: fix misuses of access_process_vm() in genregs32_[sg]et()
      sparc32: fix register window handling in genregs32_[gs]et()
      fix a braino in "sparc32: fix register window handling in genregs32_[gs]et()"

Anupam Aggarwal (1):
      sparc: remove unused header file nfs_fs.h

Chen Zhou (2):
      sparc: use scnprintf() in show_pciobppath_attr() in pci.c
      sparc: use scnprintf() in show_pciobppath_attr() in vio.c

David S. Miller (6):
      Merge branch 'Rework-sparc32-page-table-layout'
      Merge branch 'sparc-scnprintf'
      Merge branch 'sparc32-SRMMU-fixes-for-SMP'
      Merge branch 'for-davem' of git://git.kernel.org/.../viro/vfs
      Merge branch 'for-davem' of git://git.kernel.org/.../viro/vfs
      Merge git://git.kernel.org/.../davem/sparc

Gustavo A. R. Silva (1):
      sparc64: Replace zero-length array with flexible-array

Jason Yan (1):
      sparc: mm: return true,false in kern_addr_valid()

John Hubbard (1):
      oradax: convert get_user_pages() --> pin_user_pages()

Mike Rapoport (1):
      sparc32: register memory occupied by kernel as memblock.memory

Wei Yongjun (1):
      tty: vcc: Fix error return code in vcc_probe()

Will Deacon (7):
      sparc32: mm: Fix argument checking in __srmmu_get_nocache()
      sparc32: mm: Restructure sparc32 MMU page-table layout
      sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *
      sparc32: mm: Reduce allocation size for PMD and PTE tables
      sparc32: mm: Don't try to free page-table pages if ctor() fails
      sparc32: mm: Disable SPLIT_PTLOCK_CPUS
      sparc32: mm: Only call ctor()/dtor() functions for first and last user

 arch/sparc/include/asm/page_32.h    |  12 ++---
 arch/sparc/include/asm/pgalloc_32.h |  11 +++--
 arch/sparc/include/asm/pgtable_32.h |  40 ++++++++++------
 arch/sparc/include/asm/pgtsrmmu.h   |  36 ++-------------
 arch/sparc/include/asm/viking.h     |   5 +-
 arch/sparc/kernel/cpumap.c          |   2 +-
 arch/sparc/kernel/ds.c              |   8 ++--
 arch/sparc/kernel/head_32.S         |   8 ++--
 arch/sparc/kernel/pci.c             |   2 +-
 arch/sparc/kernel/ptrace_32.c       | 233 ++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------
 arch/sparc/kernel/ptrace_64.c       |  17 ++-----
 arch/sparc/kernel/sys_sparc32.c     |   1 -
 arch/sparc/kernel/vio.c             |   2 +-
 arch/sparc/mm/hypersparc.S          |   3 +-
 arch/sparc/mm/init_32.c             |   1 +
 arch/sparc/mm/init_64.c             |  10 ++--
 arch/sparc/mm/srmmu.c               | 106 +++++++++++++++++--------------------------
 arch/sparc/mm/viking.S              |   5 +-
 drivers/sbus/char/oradax.c          |   8 ++--
 drivers/tty/vcc.c                   |   1 +
 mm/Kconfig                          |   4 ++
 21 files changed, 221 insertions(+), 294 deletions(-)
