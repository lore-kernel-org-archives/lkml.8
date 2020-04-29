Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1776DC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BD520757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TI7o13vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgD2VuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2VuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:50:10 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5AC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:50:10 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a18so4251987qkl.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P4HtBjpSOsceKegug2sEdVIRavAA18N3gAKqWZxS3Rg=;
        b=TI7o13vZ0R4PIgdk5y6o23r6CG8YctneHrjonN+9jVFDJ8a0023jr599F8e7C/pCP1
         fL3VdXGkXbALChJNJ6t9m+IF3Wovo/x9/xrYX0g4YfMrgsQSVwwi23O/IaVGqNkQQ6h3
         x+0qrgSjRfFwRKbeWgXwjoMlqjH1lm4wAM3CELbCKXTiLq/swJ34pmCu23AMfL5Yjkgy
         2lr+IyuwfEsMfRYCu6HHrOrTyeTAAHhb+KjzIA+Iji3q7RLl2di8U0GeoekM5FEejqLO
         huXbxPxwrw4zSseLeMFqvnk/V1Q6Vuoaodwe0RRKcnawzra8PObdhok75bmLDdUPrs8e
         Ubdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P4HtBjpSOsceKegug2sEdVIRavAA18N3gAKqWZxS3Rg=;
        b=hqx4N/vE6D+tV9Iv8HJNii7gaQrE0xlCyDAgO5Y7UMylj0lbrVZQUZzWoKSnUYXqQa
         7cchvsU9dZSs9l16qRafIyavOHH1cTuiuF9Y5iczjQXLIA2njWdHCRaM4OxppJ6ymNCS
         NInCJ6kIWvf4dRJAxOsvj12nLaA2YnAX38r7KLGvSVmlYP5LrevnKLr+x92RNVSFv9NZ
         BXzZBghD0B5HY+GXY3kPg2BGclwsPqJPUuD6+pjJsroW2GlOdw8MvNH5LmWD8xxu+BOE
         RXz1Br3/Cu9y3+SFMhsiWeuczHwBwuqutdWvZIk3I0XskuLCTdvEcEZtKlmQ0eY96Pet
         vHGg==
X-Gm-Message-State: AGi0PuZygK+LYHBVjwDBG+I5XJu80C41LAwynuL+hzr6o5o/si+nxnlc
        s9KHzrKWiS/Ks7EE++JMCPRBU9awsw==
X-Google-Smtp-Source: APiQypKMctOewJ3jBsbKHfX9HPIgYNkTG/naYrVaiwmZ+zyaqG0pLqe4doZmeqtJnRlWlz10BcfPBfAjMw==
X-Received: by 2002:a0c:ba83:: with SMTP id x3mr36580637qvf.83.1588197009264;
 Wed, 29 Apr 2020 14:50:09 -0700 (PDT)
Date:   Wed, 29 Apr 2020 23:49:49 +0200
Message-Id: <20200429214954.44866-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
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
cleanly as possible.
In particular, I want to avoid holding the mmap_sem across unbounded
sleeps.


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


Testing done so far:

 - Creating a simple core dump on X86-64 still works.
 - The created coredump on X86-64 opens in GDB, and both the stack and the
   exectutable look vaguely plausible.
 - 32-bit ARM compiles with FDPIC support, both with MMU and !MMU config.

I'm CCing some folks from the architectures that use FDPIC in case
anyone wants to give this a spin.


This series is based on
<https://lore.kernel.org/linux-fsdevel/20200427200626.1622060-1-hch@lst.de/>
(Christoph Hellwig's "remove set_fs calls from the coredump code v4").


changed in v2:
 - replace "Fix handling of partial writes in dump_emit()" with
   "Let dump_emit() bail out on short writes" (Linus)
 - get rid of the useless complicated cache flushing in
   "Take mmap_sem in get_dump_page()" (Linus)

Jann Horn (5):
  binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
  coredump: Let dump_emit() bail out on short writes
  coredump: Refactor page range dumping into common helper
  binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
  mm/gup: Take mmap_sem in get_dump_page()

 fs/binfmt_elf.c          | 170 ++++++++++++---------------------------
 fs/binfmt_elf_fdpic.c    | 106 +++++++++---------------
 fs/coredump.c            | 123 +++++++++++++++++++++++++---
 include/linux/coredump.h |  12 +++
 mm/gup.c                 |  60 +++++++-------
 5 files changed, 245 insertions(+), 226 deletions(-)


base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
prerequisite-patch-id: c0a20b414eebc48fe0a8ca570b05de34c7980396
prerequisite-patch-id: 51973b8db0fa4b114e0c3fd8936b634d9d5061c5
prerequisite-patch-id: 0e1e8de282ca6d458dc6cbdc6b6ec5879edd8a05
prerequisite-patch-id: d5ee749c4d3a22ec80bd0dd88aadf89aeb569db8
prerequisite-patch-id: 46ce14e59e98e212a1eca0aef69c6dcdb62b8242
-- 
2.26.2.526.g744177e7f7-goog

