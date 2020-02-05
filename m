Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBE6C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4CF21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fe4L0RQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBECvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:51:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727887AbgBECvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DKtUKnKq1J1pqiJ5NWomQSmReHrjvPI4rlRqnUPkaxE=;
        b=Fe4L0RQXCA7yfBVWJAZ3wJnSwA6XJsVBSF+5ep0Rn2Yp4rwtOMmjhQHIF3/AFk9M47YPsz
        cPp2IoxxyLAoNpjBjUJILMSO8EmBJf+pMr7sDuStyV5WRx/sLk2BbAG/Pe99Xxmdc3A53j
        ZgL/FJlGued1cI4omGFMyYT4s5vYwxo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-ZanSpeqnPIu6Ziv3uO63eg-1; Tue, 04 Feb 2020 21:51:10 -0500
X-MC-Unique: ZanSpeqnPIu6Ziv3uO63eg-1
Received: by mail-qk1-f198.google.com with SMTP id s9so376779qkg.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DKtUKnKq1J1pqiJ5NWomQSmReHrjvPI4rlRqnUPkaxE=;
        b=pr64Bocmw0IEAJTU8xRmZ1Kpl0tO2U1v3fm1vpuRscI6Hv5ln/rF4mxcRtSb773liw
         sq7yXAgthOq1vgzO1M8d1Khdb6TDNELQmfSKVLj3yRwCmOrvoUbb2EU7iQ+wrSinCO4P
         MMUJNIvepTLlzH/w3LffSPAZRaymyGQ1qBzAIRGh3it7f30sDDdzyS+Fh/+hdI50DyPl
         F3lD6uuwDyQPBE3skTmWaA6vx/Vr71WQaJbL25Da9Lz9V8IBJQ5VWGnaW6OWpujKbKbG
         /SMIA1KDZ8pCT3l2jKFS9kiYzzzpaChEbCAeuxAF/HvYZ2PODidOA6RUsU7XP8zXAi9t
         NThA==
X-Gm-Message-State: APjAAAXk52B8Z9qCjlWphNqG7FGjXx2366vI0gSieNOG+WaCsmIn3Q0a
        jZP7tkFQf//fmVLi3FBlH69y2bXJuLnKdjVhO/Pv/mwHM+IhcVuIHpPx6jhn+EcUBUrAsSec6Ki
        4ypflvF22c0r0/PSxAvlbmWCV
X-Received: by 2002:a0c:f24a:: with SMTP id z10mr30929670qvl.33.1580871069821;
        Tue, 04 Feb 2020 18:51:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4Rzc4aPHLj7hhqYA+ZxPSLB6YJX/04N/lV5KKFxqu0yKbFNNIn/r3iiLYD2cYqAqGTafHFQ==
X-Received: by 2002:a0c:f24a:: with SMTP id z10mr30929647qvl.33.1580871069426;
        Tue, 04 Feb 2020 18:51:09 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id b141sm12380923qkg.33.2020.02.04.18.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:51:08 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
        Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 00/14] KVM: Dirty ring interface
Date:   Tue,  4 Feb 2020 21:50:51 -0500
Message-Id: <20200205025105.367213-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM branch:
  https://github.com/xzpeter/linux/tree/kvm-dirty-ring

QEMU branch for testing:
  https://github.com/xzpeter/qemu/tree/kvm-dirty-ring

v4 changelog:

- refactor ring layout: remove indices, use bit 0/1 in the gfn.flags
  field to encode GFN status (invalid, dirtied, collected) [Michael,
  Paolo]
- patch memslot_valid_for_gpte() too to check against memslot flags
  rather than dirty_bitmap pointer
- fix build on non-x86 arch [syzbot]
- fix comment for kvm_dirty_gfn [Michael]
- check against VM_EXEC, VM_SHARED for mmaps [Michael]
- fix "KVM: X86: Don't track dirty for
  KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]" to unbreak
  unrestricted_guest=N [Sean]
- some rework in the test code, e.g., more comments

For previous versions, please refer to:

V1: https://lore.kernel.org/kvm/20191129213505.18472-1-peterx@redhat.com
V2: https://lore.kernel.org/kvm/20191221014938.58831-1-peterx@redhat.com
V3: https://lore.kernel.org/kvm/20200109145729.32898-1-peterx@redhat.com

Overview
============

This is a continued work from Lei Cao <lei.cao@stratus.com> and Paolo
Bonzini on the KVM dirty ring interface.

The new dirty ring interface is another way to collect dirty pages for
the virtual machines. It is different from the existing dirty logging
interface in a few ways, majorly:

  - Data format: The dirty data was in a ring format rather than a
    bitmap format, so dirty bits to sync for dirty logging does not
    depend on the size of guest memory any more, but speed of
    dirtying.  Also, the dirty ring is per-vcpu, while the dirty
    bitmap is per-vm.

  - Data copy: The sync of dirty pages does not need data copy any more,
    but instead the ring is shared between the userspace and kernel by
    page sharings (mmap() on vcpu fd)

  - Interface: Instead of using the old KVM_GET_DIRTY_LOG,
    KVM_CLEAR_DIRTY_LOG interfaces, the new ring uses the new
    KVM_RESET_DIRTY_RINGS ioctl when we want to reset the collected
    dirty pages to protected mode again (works like
    KVM_CLEAR_DIRTY_LOG, but ring based).  To collecting dirty bits,
    we only need to read the ring data, no ioctl is needed.

Ring Layout
===========

KVM dirty ring is per-vcpu.  Each ring is an array of kvm_dirty_gfn
defined as:

struct kvm_dirty_gfn {
        __u32 flags;
        __u32 slot; /* as_id | slot_id */
        __u64 offset;
};

Each GFN is a state machine itself.  The state is embeded in the flags
field, as defined in the uapi header:

/*
 * KVM dirty GFN flags, defined as:
 *
 * |---------------+---------------+--------------|
 * | bit 1 (reset) | bit 0 (dirty) | Status       |
 * |---------------+---------------+--------------|
 * |             0 |             0 | Invalid GFN  |
 * |             0 |             1 | Dirty GFN    |
 * |             1 |             X | GFN to reset |
 * |---------------+---------------+--------------|
 *
 * Lifecycle of a dirty GFN goes like:
 *
 *      dirtied         collected        reset
 * 00 -----------> 01 -------------> 1X -------+
 *  ^                                          |
 *  |                                          |
 *  +------------------------------------------+
 *
 * The userspace program is only responsible for the 01->1X state
 * conversion (to collect dirty bits).  Also, it must not skip any
 * dirty bits so that dirty bits are always collected in sequence.
 */

Testing
=======

This series provided both the implementation of the KVM dirty ring and
the test case.  Also I've implemented the QEMU counterpart that can
run with the new KVM, link can be found at the top of the cover
letter.  However that's still a very initial version which is prone to
change and future optimizations.

I did some measurement with the new method with 24G guest running some
dirty workload, I don't see any speedup so far, even in some heavy
dirty load it'll be slower (e.g., when 800MB/s random dirty rate, kvm
dirty ring takes average of ~73s to complete migration while dirty
logging only needs average of ~55s).  However that's understandable
because 24G guest means only 1M dirty bitmap, that's still a suitable
case for dirty logging.  Meanwhile heavier workload means worst case
for dirty ring.

More tests are welcomed if there's bigger host/guest, especially on
COLO-like workload.

Please review, thanks.

Peter Xu (14):
  KVM: X86: Change parameter for fast_page_fault tracepoint
  KVM: Cache as_id in kvm_memory_slot
  KVM: X86: Don't track dirty for KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
  KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
  KVM: X86: Implement ring-based dirty memory tracking
  KVM: Make dirty ring exclusive to dirty bitmap log
  KVM: Don't allocate dirty bitmap if dirty ring is enabled
  KVM: selftests: Always clear dirty bitmap after iteration
  KVM: selftests: Sync uapi/linux/kvm.h to tools/
  KVM: selftests: Use a single binary for dirty/clear log test
  KVM: selftests: Introduce after_vcpu_run hook for dirty log test
  KVM: selftests: Add dirty ring buffer test
  KVM: selftests: Let dirty_log_test async for dirty ring test
  KVM: selftests: Add "-c" parameter to dirty log test

 Documentation/virt/kvm/api.txt                | 125 +++++
 arch/x86/include/asm/kvm_host.h               |   6 +-
 arch/x86/include/uapi/asm/kvm.h               |   1 +
 arch/x86/kvm/Makefile                         |   3 +-
 arch/x86/kvm/mmu/mmu.c                        |  10 +-
 arch/x86/kvm/mmutrace.h                       |   9 +-
 arch/x86/kvm/svm.c                            |   9 +-
 arch/x86/kvm/vmx/vmx.c                        |  85 ++--
 arch/x86/kvm/x86.c                            |  49 +-
 include/linux/kvm_dirty_ring.h                |  50 ++
 include/linux/kvm_host.h                      |  21 +
 include/trace/events/kvm.h                    |  78 ++++
 include/uapi/linux/kvm.h                      |  44 ++
 tools/include/uapi/linux/kvm.h                |  44 ++
 tools/testing/selftests/kvm/Makefile          |   2 -
 .../selftests/kvm/clear_dirty_log_test.c      |   2 -
 tools/testing/selftests/kvm/dirty_log_test.c  | 441 ++++++++++++++++--
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  76 +++
 .../selftests/kvm/lib/kvm_util_internal.h     |   4 +
 virt/kvm/dirty_ring.c                         | 176 +++++++
 virt/kvm/kvm_main.c                           | 225 ++++++++-
 22 files changed, 1347 insertions(+), 117 deletions(-)
 create mode 100644 include/linux/kvm_dirty_ring.h
 delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c
 create mode 100644 virt/kvm/dirty_ring.c

-- 
2.24.1

