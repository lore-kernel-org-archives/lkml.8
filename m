Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3F4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18BF20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6YkbzpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFOWQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40140 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbgFOWQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qVFaTHERIS8zyGm9WNuNIMiOUtUSSq7Mw9RxxyBA+O0=;
        b=R6YkbzpVnj4TZo8sJPs9oao/BEOrrmoyGATHzMlipAUZCA5BaVEvdVQjDs9nDFnANpm8q1
        naaO9Ry0ampPNEH2s/2uqaYSC98i6vZFioq7VJaMyD8PyeWcp+4gh04X2GEs/x+feLAGJK
        lBM1pwUJ6Sdi7blz8uxvetf9nRFnFBU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-XN8iuLSWON6rgnEMWNZLiA-1; Mon, 15 Jun 2020 18:16:10 -0400
X-MC-Unique: XN8iuLSWON6rgnEMWNZLiA-1
Received: by mail-qt1-f199.google.com with SMTP id y7so15170273qti.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVFaTHERIS8zyGm9WNuNIMiOUtUSSq7Mw9RxxyBA+O0=;
        b=I5Z5d/rc4vBl1b37BjvU0Z1i0sXv0AFsmFvtk4ZnGEZo3c1ZT+E3446sk/ygywpsG3
         C/YovhxQ11tixNwLZfsDwh+mAzwZbXGN8Zkzz0WjRnsfEheO0ze46hIBCFsAtwAIdpOt
         q08N/HJRqB5zOnE4N/fVSh8qF3EAAkmiPrXnLemAnwmE58giGzH8Uz/FmiDJMHpvFRrn
         cOLhB9LnsO4hjOoMQQE/jKB4zfOV9hUZrQTGa22sIjrVRaKOx9sl7Lkik3H8DjbuEf0o
         DGMd5qpkOCFRdtVOV+u7rRF1wXT1tT3YAnPZ2yz/vuR+/qtlz3s24FBRA531Yj2L54M/
         t+qA==
X-Gm-Message-State: AOAM531pjW4kHCgGLrJornIx7jglZl6etozdZUS+PzSPluls2fdxcB5x
        D9z97pOjs0hZyHiGYCnO84SpQQ0Tb6hO0sqKCEvGK2gNoHwxmd+XvGFfXoZmHmEiL8lAYtuwqro
        VJEyNgs1qaOraREJ8u+NtlV6k
X-Received: by 2002:a37:d89:: with SMTP id 131mr18163757qkn.454.1592259369624;
        Mon, 15 Jun 2020 15:16:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO4CUTnwkVRCrJ0Win2S1iok5yGvnnMgqhjNgxkBMVdltq3RhL4r6jXOOLCvoq1cxn7UqqQA==
X-Received: by 2002:a37:d89:: with SMTP id 131mr18163733qkn.454.1592259369320;
        Mon, 15 Jun 2020 15:16:09 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 00/25] mm: Page fault accounting cleanups
Date:   Mon, 15 Jun 2020 18:15:42 -0400
Message-Id: <20200615221607.7764-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gerald Schaefer reported an issue a week ago regarding to incorrect page fault
accountings for retried page fault after commit 4064b9827063 ("mm: allow
VM_FAULT_RETRY for multiple times"):

  https://lore.kernel.org/lkml/20200610174811.44b94525@thinkpad/

When I was looking at the issue, I actually found some other trivial issues too
related to the page fault accounting, namely:

  - Incorrect accountings

    - The major issue that was reported by Gerald, that we did multiple
      accounting when the page fault retried while we should only do it once
      (for either perf event accounting or per-task accounting).

    - In many archs, major fault is only accounted when the 1st page fault is a
      major fault, or the last page fault is a major fault.  Ideally we should
      account the page fault as a major fault as long as any of the page fault
      retries is a major fault and keep the same behavior across archs.

  - Missing accountings of perf events (PERF_COUNT_SW_PAGE_FAULTS[_[MAJ|MIN]]).

  - Doing accounting with mmap_sem: not a big deal, but logically we can move
    it after releasing the mmap_sem because accounting does not need it.

This series tries to address all of them by introducing mm_fault_accounting()
first, so that we move all the page fault accounting into the common code base,
then call it properly from arch pf handlers just like handle_mm_fault().  There
are some special cases, e.g., the um arch does not have "regs" in the fault
handler, so it's still using the manual statistics.

For each of the patch that fixes a specific arch, I'm CCing the maintainers and
the arch list if there is.  Besides, I only lightly tested this series on x86.

Please have a look, thanks.

Peter Xu (25):
  mm/um: Fix extra accounting for page fault retries
  mm: Introduce mm_fault_accounting()
  mm/alpha: Use mm_fault_accounting()
  mm/arc: Use mm_fault_accounting()
  mm/arm: Use mm_fault_accounting()
  mm/arm64: Use mm_fault_accounting()
  mm/csky: Use mm_fault_accounting()
  mm/hexagon: Use mm_fault_accounting()
  mm/ia64: Use mm_fault_accounting()
  mm/m68k: Use mm_fault_accounting()
  mm/microblaze: Use mm_fault_accounting()
  mm/mips: Use mm_fault_accounting()
  mm/nds32: Use mm_fault_accounting()
  mm/nios2: Use mm_fault_accounting()
  mm/openrisc: Use mm_fault_accounting()
  mm/parisc: Use mm_fault_accounting()
  mm/powerpc: Use mm_fault_accounting()
  mm/riscv: Use mm_fault_accounting()
  mm/s390: Use mm_fault_accounting()
  mm/sh: Use mm_fault_accounting()
  mm/sparc32: Use mm_fault_accounting()
  mm/sparc64: Use mm_fault_accounting()
  mm/unicore32: Use mm_fault_accounting()
  mm/x86: Use mm_fault_accounting()
  mm/xtensa: Use mm_fault_accounting()

 arch/alpha/mm/fault.c      |  9 ++++-----
 arch/arc/mm/fault.c        | 15 +++------------
 arch/arm/mm/fault.c        | 21 ++++-----------------
 arch/arm64/mm/fault.c      | 17 ++---------------
 arch/csky/mm/fault.c       | 13 +------------
 arch/hexagon/mm/vm_fault.c |  9 +++------
 arch/ia64/mm/fault.c       |  8 +++-----
 arch/m68k/mm/fault.c       | 13 +++----------
 arch/microblaze/mm/fault.c |  8 +++-----
 arch/mips/mm/fault.c       | 14 +++-----------
 arch/nds32/mm/fault.c      | 19 +++----------------
 arch/nios2/mm/fault.c      | 13 +++----------
 arch/openrisc/mm/fault.c   |  8 +++-----
 arch/parisc/mm/fault.c     |  8 +++-----
 arch/powerpc/mm/fault.c    | 13 ++++---------
 arch/riscv/mm/fault.c      | 21 +++------------------
 arch/s390/mm/fault.c       | 21 +++++----------------
 arch/sh/mm/fault.c         | 15 +++------------
 arch/sparc/mm/fault_32.c   | 16 +++-------------
 arch/sparc/mm/fault_64.c   | 16 ++++------------
 arch/um/kernel/trap.c      | 13 +++++++------
 arch/unicore32/mm/fault.c  | 15 +++++++--------
 arch/x86/mm/fault.c        | 10 +---------
 arch/xtensa/mm/fault.c     | 14 +++-----------
 include/linux/mm.h         |  2 ++
 mm/memory.c                | 18 ++++++++++++++++++
 26 files changed, 101 insertions(+), 248 deletions(-)

-- 
2.26.2

