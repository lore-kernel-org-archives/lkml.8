Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286CE207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsqITsJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgF3UpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37281 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729669AbgF3UpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XecCxqNuikt/ufBD1g6ZnLJJZQJ5oET93VAWNtvus80=;
        b=JsqITsJVSoaHImJ78ovmSWATaXgcJ1U99Fr7kaKUC8mGvv+QGp1KNak27Pnni0uX3loOZk
        8isOKIXP9CqLGDd2MznkKGaApVLxx8VdzJfzWtkhJwgjCtSqOerBswD59rOD8no3uTGaRu
        b0Wae2qm3ccXpg1/yf/5vgFbFVNnc0g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-dsMhog3XN_qZ-SKEveoa0w-1; Tue, 30 Jun 2020 16:45:05 -0400
X-MC-Unique: dsMhog3XN_qZ-SKEveoa0w-1
Received: by mail-qv1-f72.google.com with SMTP id j18so14679196qvk.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XecCxqNuikt/ufBD1g6ZnLJJZQJ5oET93VAWNtvus80=;
        b=J+rV3pojJ+dVEb13tRI0BKBz+gvpBlEUFf4JJRAKiyLNP7FWm3MbpOZqmoZz7IyX3/
         pad0ElHg/MAQLWYHWMKfxWbZBzmNmlPIOrRaTZmIAV3R3oe+H6DbOJyVJw1J2zUeb8Ix
         6wqp6paDP4hk/9KD4bHKiHjgkRCxd/16KwT36mDNaIXAc6o6g81vdVBwpTxwObcwM2At
         kp7TBWTrFizPIJ66e0MhvyyxoqZYuM4XaMTCaZOPoRR8bdE+qB9qduwK82PRn0xFRX0e
         FRqepDwoHmsu66Hb62U5aKvufB7vf03W4LAWmPNy78Yx0yHn4D1v9N8Jkewz+E/o15ry
         aLLQ==
X-Gm-Message-State: AOAM530dtRCTC+85m8baC2mcsj0NKce2pZF1E6cF8B6wKlKXfr6EoIhq
        nOblXvx9jKdl4jf1qIW5TLFIipYEX/PFzDMoOHCsHbOTe5Zd5JiQexNoi/89qeaovt9MHbTGDMD
        sAJMfV2TQ8C8YOvedtdH4tpt+
X-Received: by 2002:ac8:4f13:: with SMTP id b19mr12344912qte.146.1593549903930;
        Tue, 30 Jun 2020 13:45:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnjeNgGb3VgyiWRazZJnXpk1WXkLvNRxZ6+DixPQ/oofTuS8GpnF0F4qDUmW3N1xOBIVbE8A==
X-Received: by 2002:ac8:4f13:: with SMTP id b19mr12344886qte.146.1593549903608;
        Tue, 30 Jun 2020 13:45:03 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p63sm4105395qkc.80.2020.06.30.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 00/26] mm: Page fault accounting cleanups
Date:   Tue, 30 Jun 2020 16:45:01 -0400
Message-Id: <20200630204501.38468-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:=0D
- rebase to linux-next/akpm=0D
- picked one more r-b=0D
=0D
v3:=0D
- comment fixes [Gerald]=0D
- check VM_FAULT_ERROR too [Gerald]=0D
- collect r-b=0D
=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cover letter f=
or v2 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0D
=0D
This is v2 of the pf accounting cleanup series.  It originates from Gerald=
=0D
Schaefer's report on an issue a week ago regarding to incorrect page fault=
=0D
accountings for retried page fault after commit 4064b9827063 ("mm: allow=0D
VM_FAULT_RETRY for multiple times"):=0D
=0D
  https://lore.kernel.org/lkml/20200610174811.44b94525@thinkpad/=0D
=0D
This version used a better approach suggested by Linus so that we do accoun=
ting=0D
directly in handle_mm_fault().  Moreover, we'll cover some special accounti=
ng=0D
too like gup or IOMMU fault requests on process page tables.  The outcome o=
f=0D
this series is to keep all the pf accountings in handle_mm_fault() (besides=
=0D
PERF_COUNT_SW_PAGE_FAULTS, which is still done in per-arch #pf handlers).=0D
=0D
Since v2 changed quite a lot from v1, changelog is omitted, and I also didn=
't=0D
have a chance to pick up any r-b in previous version.  I really appreciate=
=0D
anyone who has looked at v1.  V1 for reference:=0D
=0D
  https://lore.kernel.org/lkml/20200615221607.7764-1-peterx@redhat.com/=0D
=0D
What this series did:=0D
=0D
  - Correct page fault accounting: we do accounting for a page fault (no ma=
tter=0D
    whether it's from #PF handling, or gup, or anything else) only with the=
 one=0D
    that completed the fault.  For example, page fault retries should not b=
e=0D
    counted in page fault counters.  Same to the perf events.=0D
=0D
  - Unify definition of PERF_COUNT_SW_PAGE_FAULTS: currently this perf even=
t is=0D
    used in an adhoc way across different archs.=0D
=0D
    Case (1): for many archs it's done at the entry of a page fault handler=
, so=0D
    that it will also cover e.g. errornous faults.=0D
=0D
    Case (2): for some other archs, it is only accounted when the page faul=
t is=0D
    resolved successfully.=0D
=0D
    Case (3): there're still quite some archs that have not enabled this pe=
rf event.=0D
=0D
    Since this series will touch merely all the archs, we unify this perf e=
vent=0D
    to always follow case (1), which is the one that makes most sense.  And=
=0D
    since we moved the accounting into handle_mm_fault, the other two MAJ/M=
IN=0D
    perf events are well taken care of naturally.=0D
=0D
  - Unify definition of "major faults": the definition of "major fault" is=
=0D
    slightly changed when used in accounting (not VM_FAULT_MAJOR).  More=0D
    information in patch 1.=0D
=0D
  - Always account the page fault onto the one that triggered the page faul=
t.=0D
    This does not matter much for #PF handlings, but mostly for gup.  More=
=0D
    information on this in patch 25.=0D
=0D
Patchset layout:=0D
=0D
Patch 1:     Introduced the accounting in handle_mm_fault(), not enabled.=0D
Patch 2-24:  Enable the new accounting for arch #PF handlers one by one.=0D
Patch 25:    Enable the new accounting for the rest outliers (gup, iommu, e=
tc.)=0D
Patch 26:    Cleanup GUP task_struct pointer since it's not needed any more=
=0D
=0D
For each of the patch that fixes a specific arch, I'm CCing the maintainers=
 and=0D
the arch list if there is.  Besides, I only lightly tested this series on x=
86.=0D
=0D
Please have a look, thanks.=0D
=0D
Peter Xu (26):=0D
  mm: Do page fault accounting in handle_mm_fault=0D
  mm/alpha: Use general page fault accounting=0D
  mm/arc: Use general page fault accounting=0D
  mm/arm: Use general page fault accounting=0D
  mm/arm64: Use general page fault accounting=0D
  mm/csky: Use general page fault accounting=0D
  mm/hexagon: Use general page fault accounting=0D
  mm/ia64: Use general page fault accounting=0D
  mm/m68k: Use general page fault accounting=0D
  mm/microblaze: Use general page fault accounting=0D
  mm/mips: Use general page fault accounting=0D
  mm/nds32: Use general page fault accounting=0D
  mm/nios2: Use general page fault accounting=0D
  mm/openrisc: Use general page fault accounting=0D
  mm/parisc: Use general page fault accounting=0D
  mm/powerpc: Use general page fault accounting=0D
  mm/riscv: Use general page fault accounting=0D
  mm/s390: Use general page fault accounting=0D
  mm/sh: Use general page fault accounting=0D
  mm/sparc32: Use general page fault accounting=0D
  mm/sparc64: Use general page fault accounting=0D
  mm/unicore32: Use general page fault accounting=0D
  mm/x86: Use general page fault accounting=0D
  mm/xtensa: Use general page fault accounting=0D
  mm: Clean up the last pieces of page fault accountings=0D
  mm/gup: Remove task_struct pointer for all gup code=0D
=0D
 arch/alpha/mm/fault.c                       |   8 +-=0D
 arch/arc/kernel/process.c                   |   2 +-=0D
 arch/arc/mm/fault.c                         |  18 +---=0D
 arch/arm/mm/fault.c                         |  25 ++---=0D
 arch/arm64/mm/fault.c                       |  29 ++----=0D
 arch/csky/mm/fault.c                        |  13 +--=0D
 arch/hexagon/mm/vm_fault.c                  |   9 +-=0D
 arch/ia64/mm/fault.c                        |   9 +-=0D
 arch/m68k/mm/fault.c                        |  14 +--=0D
 arch/microblaze/mm/fault.c                  |   9 +-=0D
 arch/mips/mm/fault.c                        |  14 +--=0D
 arch/nds32/mm/fault.c                       |  19 +---=0D
 arch/nios2/mm/fault.c                       |  14 +--=0D
 arch/openrisc/mm/fault.c                    |   9 +-=0D
 arch/parisc/mm/fault.c                      |   8 +-=0D
 arch/powerpc/mm/copro_fault.c               |   7 +-=0D
 arch/powerpc/mm/fault.c                     |  11 +-=0D
 arch/riscv/mm/fault.c                       |  16 +--=0D
 arch/s390/kvm/interrupt.c                   |   2 +-=0D
 arch/s390/kvm/kvm-s390.c                    |   2 +-=0D
 arch/s390/kvm/priv.c                        |   8 +-=0D
 arch/s390/mm/fault.c                        |  16 +--=0D
 arch/s390/mm/gmap.c                         |   4 +-=0D
 arch/sh/mm/fault.c                          |  11 +-=0D
 arch/sparc/mm/fault_32.c                    |  13 +--=0D
 arch/sparc/mm/fault_64.c                    |  11 +-=0D
 arch/um/kernel/trap.c                       |   6 +-=0D
 arch/unicore32/mm/fault.c                   |  14 +--=0D
 arch/x86/mm/fault.c                         |  17 +--=0D
 arch/xtensa/mm/fault.c                      |  15 +--=0D
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |   2 +-=0D
 drivers/infiniband/core/umem_odp.c          |   2 +-=0D
 drivers/iommu/amd/iommu_v2.c                |   2 +-=0D
 drivers/iommu/intel/svm.c                   |   3 +-=0D
 drivers/vfio/vfio_iommu_type1.c             |   4 +-=0D
 fs/exec.c                                   |   2 +-=0D
 include/linux/mm.h                          |  16 +--=0D
 kernel/events/uprobes.c                     |   6 +-=0D
 kernel/futex.c                              |   2 +-=0D
 mm/gup.c                                    | 109 +++++++-------------=0D
 mm/hmm.c                                    |   3 +-=0D
 mm/ksm.c                                    |   3 +-=0D
 mm/memory.c                                 |  69 ++++++++++++-=0D
 mm/process_vm_access.c                      |   2 +-=0D
 security/tomoyo/domain.c                    |   2 +-=0D
 virt/kvm/async_pf.c                         |   2 +-=0D
 virt/kvm/kvm_main.c                         |   2 +-=0D
 47 files changed, 222 insertions(+), 362 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

