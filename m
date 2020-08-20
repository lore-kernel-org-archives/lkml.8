Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB02C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08676208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="G6qFHzRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgHTRKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgHTRGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:06:54 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494AC061346
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:05:50 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id f1so1802112qvx.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=b7DoUVnpxFkIRzDbY79jsojJy3aTV9fDe4Ip8iAfTxQ=;
        b=G6qFHzRxH8tE+NQgVHe3aJDnjfVKpBi9JzEY++QUvnb6xoP4UL5YFe5sbFhKZ0gi1U
         Pan9TBWTEC7BF+2aZc0mqBv/kQwlsn5r0K3h60LPx01FIqpJljvvKUtcQNEKCuUEIYcf
         xG6AFaCuH19WI0tH9uTxHYIF5N/361YtX5GqJnekKRRACYb8RA6fhIvLnc1P/Yzeqr+H
         nm9sZjaq1e7Q8Ernq2ssLtCOLiUok7gbm5TyYkyMnEZ27b7ZMzkQBlVSI2rs4r58X6mp
         SViazal97l6xDrY5/0ApjBCUDFM/Mc0STSbbb38JOtssSGin/N/gfAXspNajLPcArkNT
         TMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=b7DoUVnpxFkIRzDbY79jsojJy3aTV9fDe4Ip8iAfTxQ=;
        b=X86+LgIEVSz2wsmSngY+ehLKB0574viCjBoJ/i8qkpqgyWQMflU+asTbkn8D78jXVM
         g6tEXsB7sILxqWg/EuNOuTcEoMiXy09qc/5YVSj4chRetXPqMJarMb4O8ZPmwOZG2u8V
         7Wdwh7z+5OUJ+lKib8Gcv+jwird+Ac73bfC7J71ByvnBx3JC0SZ30EChaKOTpEB6cPfd
         XLjGzT5WAcfhI6RLxYCz00ZlCbHTa3dm3clXmWxUhSR6Ws846Eh9va3hhG94UjeMJhqh
         W3J3wBxdc238SJo588Z2abSr5D2kBnmypINPD3MSfiegARwHtm9Pa/rOQYbt4vq3AeTw
         IuoQ==
X-Gm-Message-State: AOAM530rDJGOsuUY0BKnyAi5gsAS+Ogpj1oTgzNDl8u87AGCeao1pc3u
        UojGu4Rx9y51Ivg3B5NM7V8tuYni95NR2H4=
X-Google-Smtp-Source: ABdhPJzQ303gG3zC6FMNRV8/7nehOE6TV+ALYSqyVmfx5TexEd8BHJGo0+ecTS9riPmHAJYwqf3lo4sw1B8I4o0=
X-Received: from ckennelly28.nyc.corp.google.com ([2620:0:1003:1003:3e52:82ff:fe5a:a91a])
 (user=ckennelly job=sendgmr) by 2002:ad4:51c8:: with SMTP id
 p8mr3882955qvq.31.1597943149942; Thu, 20 Aug 2020 10:05:49 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:05:39 -0400
Message-Id: <20200820170541.1132271-1-ckennelly@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v3 0/2] Selecting Load Addresses According to p_align
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

Changes V2 -> V3:
* Minor code tweaks based on off-thread feedback

Changes V1 -> V2:
* Added test

Chris Kennelly (2):
  fs/binfmt_elf: Use PT_LOAD p_align values for suitable start address.
  Add self-test for verifying load alignment.

 fs/binfmt_elf.c                             | 23 +++++++
 tools/testing/selftests/exec/.gitignore     |  1 +
 tools/testing/selftests/exec/Makefile       |  9 ++-
 tools/testing/selftests/exec/load_address.c | 68 +++++++++++++++++++++
 4 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/exec/load_address.c

-- 
2.28.0.297.g1956fa8f8d-goog

