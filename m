Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F262075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CW0NVHqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHZPPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgHZPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:38 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C39C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:38 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id m24so1129051eje.20
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=AWpqH+Dejg28Roy1rqzZRhfYiQLMimyCDG9hT7Ygkv8=;
        b=CW0NVHqq7aTBdhwV7EWyH8DzEZU6fXX8Sc7G+UFN0jCiQ+flcssLRXEaMZeBsQRvLR
         YB4t/lvwg8jZwjQins9aNslSurxcOl8DauW/dA/N4CpZHmZxcemnx1If+zIRMo8OyIDk
         EBlAGY6WJupZb6imUULcrsSK7hWyP3O0XkROSx76IhkTPlFwQYxbBeA+GuPyNfYBIlLD
         u0K4iwOmflvuw3XViSsH/k93TSD1EP6fRaOKUq809Hfm96+wl4lLznht8LnEIIFKfurf
         yWeJJBnVdbRfUKYZi5X+Jakf1cbsTTRtHRy+ggML1PvF/OinihAWcY+nnqpArLOzq//O
         Fo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=AWpqH+Dejg28Roy1rqzZRhfYiQLMimyCDG9hT7Ygkv8=;
        b=ZCOV6/seJ4S3qcz8uod3uWh9FQ9eAKcZAQJqYKJ6SzfkCtqg+rC6spWDn8cNmF78tQ
         AF+1I/s84jVM84sb/aKQRKnttyfdQh3qHwgeg0vB+eGD9NUmmiKeDhkiAO1O35mr35vD
         Zs92YQ+g2aKjBOTCmAmmdJfDwSuVsupf5p1jrxJZDLfd40GIDqey4twLQbcMWMwR3C5I
         c8lf6T+tGJCvb8M1m1FUc91wzeiGhLk84DZC0JtE1WoKJBAjUO63OfiN3+93WN2hOP/l
         l0RMRtQxHTBVjUGdoe7MCRHi+Sk0riqjm1l2c6sY0JgtzPYnUR7Zkx2RPJ430r+qoc01
         akoA==
X-Gm-Message-State: AOAM5305VAvq4vWCj2uDUfjKqV87XNnTbLd1ffQuyBtnhoyp9bCVIVXR
        ODl+GFdlrQL4pjfwzJrobcTjT1Wktg==
X-Google-Smtp-Source: ABdhPJyrgoBll+EfEon55MbRPtFm8Q5Q5JISmT8yAVysaWfWUK+wYM7LZLfWqX+1CxCDtCpTw9qU2XivEA==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a17:906:19d5:: with SMTP id
 h21mr15903316ejd.505.1598454933638; Wed, 26 Aug 2020 08:15:33 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:14:43 +0200
Message-Id: <20200826151448.3404695-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_lock
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
 - X86-64 core dumps contain the first page for executable mappings at
   offset 0, and don't contain the first page for non-executable file
   mappings or executable mappings at offset !=0.
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

 fs/binfmt_elf.c          | 147 ++++++++-------------------------------
 fs/binfmt_elf_fdpic.c    | 106 +++++++++++-----------------
 fs/coredump.c            | 125 ++++++++++++++++++++++++++++++---
 include/linux/coredump.h |  11 +++
 mm/gup.c                 |  61 ++++++++--------
 5 files changed, 227 insertions(+), 223 deletions(-)


base-commit: 06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
-- 
2.28.0.297.g1956fa8f8d-goog

