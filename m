Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F33BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A8E22B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHl+j2V9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbgGaShu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:37:49 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D922C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r9so21616832qtp.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xWSYjHc+nNdSzqwJCR0Bklwg1NIcyWlbe0Z3kPyxnWY=;
        b=UHl+j2V9dhsDIpXllhTd7jR0aoK7gz3zEDu2e8D2wo87p2jNh2PEv05B77btBa2WHg
         t4q9x8YrBGZ9mWVt2w/JAycC+YM363ctKxR6EZAiLJ1H2iARbDjGX7llw1Nc+VeYE9es
         yLcU/z3RRBx0nUqSGNv5//jg5qgnMt5Wu8m3R/7GIOqQxw0kKjBTswm1QjKpSO78MsPD
         3QPrOmOcbwtKQa5BO4IsGOI0g/U7+2GEkC1glS9jR40LCLfy1gPodeZY8yYY8H+aPQMA
         RSRRVYFCS/Ib7J0kJ1dmF/hxt8HVvPuyhMZglgFrgZH3/I5FkvLkG/kOCu9yAgBrbpJl
         xHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xWSYjHc+nNdSzqwJCR0Bklwg1NIcyWlbe0Z3kPyxnWY=;
        b=Tv6wYv0GMpJEi8TP3y5qLTX0saI4gwqkH/Xud4L2YbTOaOn+H1XlLddGaTliKcwgcK
         nYGrs6HbjsmRG0YGhpFiYIFDiqvXG5yiAs2pwty+HAxGm5NqjLI/z0dIkgiFIscQ/0aI
         EGyPhhrkzUzTuTjH9q+2eXTyLnVYAlZCVaxtkclh9uBLa0ouvO5i8EOk5WJZ7SdBVDVm
         /74ljA68wgSfcO7mz+3vnzlt/X8GoVadiQvUY0GUeKnbs6qkTcydGiBjATVvnh3+x/fL
         +0Y4aEMtlVM1sgJWwPP9wb/WQHHO9b5otEJkoHak9tKv0oN6eUjb4xfY7lWc/0CB9BZa
         6FfA==
X-Gm-Message-State: AOAM531PMvMsXG3Irgkt2reuNOceIZlQDu7YuugzHgLIVcceNPuqbaHz
        cA8TMxUNGDOo414oU3Z5FBneglPBaJBHOEY=
X-Google-Smtp-Source: ABdhPJwXJL3gk9kvQMJJpLmkcSGCU6nZqceKkw9xlltDxuzwPaAHb7crDooksHey6e2zSNoOpkyE2MgqTt+x1Wk=
X-Received: by 2002:a0c:d44e:: with SMTP id r14mr5459448qvh.105.1596220668284;
 Fri, 31 Jul 2020 11:37:48 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:37:42 -0400
Message-Id: <20200731183745.1669355-1-ckennelly@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 0/2 v2] Selecting Load Addresses According to p_align
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ELF loading mechancism provides page-aligned mappings.  This
can lead to the program being loaded in a way unsuitable for
file-backed, transparent huge pages when handling PIE executables.

While specifying -z,max-page-size=0x200000 to the linker will generate
suitably aligned segments for huge pages on x86_64, the executable needs
to be loaded at a suitably aligned address as well.  This alignment
requires the binary's cooperation, as distinct segments need to be
appropriately paddded to be eligible for THP.

For binaries built with increased alignment, this limits the number of
bits usable for ASLR, but provides some randomization over using fixed
load addresses/non-PIE binaries.

Changes V1 -> V2:
* Added test

Chris Kennelly (2):
  fs/binfmt_elf: Use PT_LOAD p_align values for suitable start address.
  Add self-test for verifying load alignment.

 fs/binfmt_elf.c                             | 24 ++++++++
 tools/testing/selftests/exec/.gitignore     |  1 +
 tools/testing/selftests/exec/Makefile       |  9 ++-
 tools/testing/selftests/exec/load_address.c | 68 +++++++++++++++++++++
 4 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/exec/load_address.c

-- 
2.28.0.163.g6104cc2f0b6-goog

