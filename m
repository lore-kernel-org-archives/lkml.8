Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D561C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC9C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyPvpxTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHRGMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRGMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:12:48 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E19FC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:47 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id ew2so6383929ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eFG3+ZU04dg7j/n8RQMsX5KJHQEOve2F0DGeAT5bRdQ=;
        b=lyPvpxTAYkmA1z+nQG0Kuj8CGkbqhbEixqfs7MpHSSXUBLVcJi6NLxh/KEhmQL5EH7
         5LSouC2V3yBab61eAHZyRvORAUg5Be9pSM+3L3iUKRgDm6Mht1H4yvISTZ0Ww03gpvdg
         pnVXfrkIqkKKPA6Kdb1H+YIfNpae2jXeKun5A+WYPF6E9AF4vTnFoEs9MtZZqYuyqUoG
         /O9iGZrtwqIJ4vBGeVgVfTjOsU2HyLOMVEYbXkMZdWfbUSDhXrtKg1BKoyYesGENNP4o
         h9VEoWGepxLcXumVisMg6kou8lmk28WgL62sHFtT2pC/3sWTKoXMY3O1d5+rjCTOUoAb
         /vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eFG3+ZU04dg7j/n8RQMsX5KJHQEOve2F0DGeAT5bRdQ=;
        b=Cv6rC8twOhkmLRj1EiN8077vDk2ckl3GvR89nmZAO9GKR9E65wCR233jnr5nIkITpA
         j48+i0A3k6Bg7ZRGuQOW9+OXgxU0ny+sIiy5lkTLBQsVwJw2Kq4O/4zNhdB+og0ECn8L
         sOrpfVPpCfzrh0+YHfi5JGQdWvbqmqujcOLkeB8hbv7wJ4yLMMzbxSlx3G+MyrZwYXBp
         VUz2ZsZDTCZtVMQf2BX8e1OWWlGI7oOCWf+Gs3XmNty+SG/HPaTSVLLzcPGriibDgZ5z
         N3QD7zf818OPovT40villaHg4f0IGmMnEkJCCmDTuYjrawSrn1UVZnirOgqcBibohswn
         6+EA==
X-Gm-Message-State: AOAM533SWJhuesPEUr0zd1i7VrvrJ7XcDOlPNFjDlmCqu9fXYzbhLaTB
        6WXV5cMzsm4/Zfb/aNZBmPrzgZHRBw==
X-Google-Smtp-Source: ABdhPJx/znTRf5ONMvee2ts2374fyNiuRaF1EBB88UBg4JiH+0EZjiz4EMZMQwRCBdDWPBloMOlMMnRJdw==
X-Received: by 2002:a05:6402:1ca6:: with SMTP id cz6mr17981292edb.310.1597731166134;
 Mon, 17 Aug 2020 23:12:46 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:34 +0200
Message-Id: <20200818061239.29091-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_lock
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

At the moment, we have that rather ugly mmget_still_valid() helper to
work around <https://crbug.com/project-zero/1790>: ELF core dumping
doesn't take the mmap_sem while traversing the task's VMAs, and if
anything (like userfaultfd) then remotely messes with the VMA tree,
fireworks ensue. So at the moment we use mmget_still_valid() to bail
out in any writers that might be operating on a remote mm's VMAs.

With this series, I'm trying to get rid of the need for that as
cleanly as possible. ("cleanly" meaning "avoid holding the mmap_lock
across unbounded sleeps".)


Patches 1, 2 and 3 are relatively unrelated cleanups in the core
dumping code.

Patches 4 and 5 implement the main change: Instead of repeatedly
accessing the VMA list with sleeps in between, we snapshot it at the
start with proper locking, and then later we just use our copy of
the VMA list. This ensures that the kernel won't crash, that VMA
metadata in the coredump is consistent even in the presence of
concurrent modifications, and that any virtual addresses that aren't
being concurrently modified have their contents show up in the core
dump properly.

The disadvantage of this approach is that we need a bit more memory
during core dumping for storing metadata about all VMAs.

After this series has landed, we should be able to rip out
mmget_still_valid().


I have tested:

 - Creating a simple core dump on X86-64 still works.
 - The created coredump on X86-64 opens in GDB and looks plausible.
 - NOMMU 32-bit ARM can still generate plausible-looking core dumps
   through the FDPIC implementation. (I can't test this with GDB because
   GDB is missing some structure definition for nommu ARM, but I've
   poked around in the hexdump and it looked decent.)

Jann Horn (5):
  binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
  coredump: Let dump_emit() bail out on short writes
  coredump: Refactor page range dumping into common helper
  binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
  mm/gup: Take mmap_lock in get_dump_page()

 fs/binfmt_elf.c          | 184 ++++++++++++++-------------------------
 fs/binfmt_elf_fdpic.c    | 106 +++++++++-------------
 fs/coredump.c            | 125 +++++++++++++++++++++++---
 include/linux/coredump.h |  11 +++
 mm/gup.c                 |  61 +++++++------
 5 files changed, 265 insertions(+), 222 deletions(-)


base-commit: 06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
-- 
2.28.0.220.ged08abb693-goog

