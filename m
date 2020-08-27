Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC9322CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Sx9t3jLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgH0PKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgH0Lt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:49:57 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BBDC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:41 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id dd25so1825382edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jJaArDC7TxiyWMPiHAEJ9CuiEBqX/dHACXSbOxkT4GQ=;
        b=Sx9t3jLt3fRnRVHI8AjMe0N0Y8tpQBiIeW/iTMoct+JVtMg/eqZ4rgqbZpnF95YgOg
         n65kn+hVVtVFi0kVyu/4dEOXAJ4G/INzK27uZrvVagFNapCeIv8N6I7LhET21HoFLJtC
         0F35yxOshCdncPGF4t7P90hW5b/EgubrWk3ZSrwar711eXJI4oTYk/PaUJ++U1k/DesV
         OMwQt31wHX1ywhRSddXdhAk60LoP09PP4p87vqy0sOaIVWdor/PH/JuzkiBpZi1W1JHO
         2Rk+VyCdbNfqpzTR4agPBOj6cYHuWwKwp3ru+gmgvHY4VOIrRBtYD3Lvc82o3sMPBGiM
         ghfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jJaArDC7TxiyWMPiHAEJ9CuiEBqX/dHACXSbOxkT4GQ=;
        b=qbRfouKwqxZcM1xObQ/EyrehM2VNPf88xS5TDie6W6vBVE6O50tE1xB5R6UWdqvZeT
         gJVRQOY4KzcehNZhWfYVdfTwkZ6bILtUsEfPfHns9bf7IQAdhFcrBkPvZcWCvd+0dWt8
         cSAxusvNfbW+yAllkTSy6GBOSYXfAp4ECbIUk/mekfKuAC/A5t4dKp3dZzfXTG49cDEf
         pmuNqWqOHosX0If+7R5a3pWkWSkQ/mSNl0ficU8Knyi1pSSMGD/3S4k4BLau9PinZ82d
         dCx/dyKnWJk3sOwj4nf8zOtqyk1VNIfXdirIA+rDzBZ64xsUQGzRvxqmFSCbaH/4mLHI
         Vk8g==
X-Gm-Message-State: AOAM532jdRnGzhndeUXezYpKObidsGECSaYchKhR8BDrCZUuNB0iNGXy
        UkOpu8ZMKfGX9elkYgagm2gjTCLHbg==
X-Google-Smtp-Source: ABdhPJyuC/6TjvHfRUNcOWTk00OeB8q/y6iWl4E7GC1dtm02wUVz+GY64yKhV19RjS+w4cHVnb96XCZ0tA==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:aa7:d6d9:: with SMTP id x25mr12155398edr.265.1598528980099;
 Thu, 27 Aug 2020 04:49:40 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:25 +0200
Message-Id: <20200827114932.3572699-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 0/7] Fix ELF / FDPIC ELF core dumping, and use mmap_lock
 properly in there
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

new in v5:
 - patches 1-3 and 6 are unchanged
 - added patch 4: rework vma_dump_size() into a common helper (Linus)
 - added patch 7: actually do the mmget_still_valid() removal (Linus)
 - for now, let dump_vma_snapshot() take the mmap_lock in write mode
   instead of read mode to avoid the data race with stack expansion

new in v4:
 - simplify patch 4/5 by replacing the heuristic for dumping the first
   pages of ELF mappings with what Linus suggested


At the moment, we have that rather ugly mmget_still_valid() helper to
work around <https://crbug.com/project-zero/1790>: ELF core dumping
doesn't take the mmap_sem while traversing the task's VMAs, and if
anything (like userfaultfd) then remotely messes with the VMA tree,
fireworks ensue. So at the moment we use mmget_still_valid() to bail
out in any writers that might be operating on a remote mm's VMAs.

With this series, I'm trying to get rid of the need for that as
cleanly as possible. ("cleanly" meaning "avoid holding the mmap_lock
across unbounded sleeps".)


Patches 1, 2, 3 and 4 are relatively unrelated cleanups in the core
dumping code.

Patches 5 and 6 implement the main change: Instead of repeatedly
accessing the VMA list with sleeps in between, we snapshot it at the
start with proper locking, and then later we just use our copy of
the VMA list. This ensures that the kernel won't crash, that VMA
metadata in the coredump is consistent even in the presence of
concurrent modifications, and that any virtual addresses that aren't
being concurrently modified have their contents show up in the core
dump properly.

The disadvantage of this approach is that we need a bit more memory
during core dumping for storing metadata about all VMAs.

At the end of the series, patch 7 removes the old workaround for
this issue (mmget_still_valid()).


I have tested:

 - Creating a simple core dump on X86-64 still works.
 - The created coredump on X86-64 opens in GDB and looks plausible.
 - X86-64 core dumps contain the first page for executable mappings at
   offset 0, and don't contain the first page for non-executable file
   mappings or executable mappings at offset !=0.
 - NOMMU 32-bit ARM can still generate plausible-looking core dumps
   through the FDPIC implementation. (I can't test this with GDB because
   GDB is missing some structure definition for nommu ARM, but I've
   poked around in the hexdump and it looked decent.)

Jann Horn (7):
  binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
  coredump: Let dump_emit() bail out on short writes
  coredump: Refactor page range dumping into common helper
  coredump: Rework elf/elf_fdpic vma_dump_size() into common helper
  binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
  mm/gup: Take mmap_lock in get_dump_page()
  mm: Remove the now-unnecessary mmget_still_valid() hack

 drivers/infiniband/core/uverbs_main.c |   3 -
 drivers/vfio/pci/vfio_pci.c           |  38 ++--
 fs/binfmt_elf.c                       | 238 +++-----------------------
 fs/binfmt_elf_fdpic.c                 | 162 +++---------------
 fs/coredump.c                         | 236 +++++++++++++++++++++++--
 fs/proc/task_mmu.c                    |  18 --
 fs/userfaultfd.c                      |  28 +--
 include/linux/coredump.h              |  11 ++
 include/linux/sched/mm.h              |  25 ---
 mm/gup.c                              |  61 +++----
 mm/khugepaged.c                       |   2 +-
 mm/madvise.c                          |  17 --
 mm/mmap.c                             |   5 +-
 13 files changed, 346 insertions(+), 498 deletions(-)


base-commit: 06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
-- 
2.28.0.297.g1956fa8f8d-goog

