Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA937C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D2F24673
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h80hSl7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgCDRt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:49:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36667 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729471AbgCDRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HRWK0p6I1LWStBHqfoAuFaTR2UJeOmXO70EvjnMwzKM=;
        b=h80hSl7UDQTv8A7iyMjoFRqToXUi14GqnhFGV+yZ/ojsKFR6qK7dYAsISTsD40q3BJdwPS
        JRQ9CgxLOsS3UV5zV3/EbU3+J7CVb6CAr7ZUILsY05yP6u05Un4xN+8FZogC8o55sW54vW
        oO27Q1V1Y0UP8x56+n+QB6rCTadX5Ko=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-tzmJmyR5ONi4mbnOz3pPEQ-1; Wed, 04 Mar 2020 12:49:51 -0500
X-MC-Unique: tzmJmyR5ONi4mbnOz3pPEQ-1
Received: by mail-qt1-f199.google.com with SMTP id s5so1982442qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRWK0p6I1LWStBHqfoAuFaTR2UJeOmXO70EvjnMwzKM=;
        b=gDbUcgGk+/n4msRjWE7/f/0wjazrGVRpVnFKGKW5TSfnI88VHlP4kjz8xMgU7nwpfx
         it8D/3WVbL+NOYieQYIq556RU/obcRoVlDvq4OFMi5LUovl28pEQxjii+ANymyJVpeC+
         ZaaCkg4DZPoZWCqEoSSdiRHMYjjiY/YxsAqTXyySC8YxNR+fB7mdNT3ztA4OJyPYmvfG
         ofA2YZKrSOI1aIau0j68NaalFtDYLb43SYDK6Hvc5RRNHQxYm1fleKdW+WDWhL4ZES5n
         U/DVF7BC5u19PVk2w0z/8DvHzPnc9ppOTdWNzARWy06ie2ddmRZzwCa/fqoPLy4eBnlq
         Ogtw==
X-Gm-Message-State: ANhLgQ13t7aVUqJQDmhwuedvwfNCSGRDQHGit5HvifG/0rZxA4U2Fq7z
        m5K0usLXteb/ju4Ug2AW2j4BDrs5HDuJ9CU5g8w8s716hdotakz41fHvtkFyqbGMt512tY5ecji
        VnstHk444h0qxCDIPb/QcHgW1
X-Received: by 2002:a37:b48:: with SMTP id 69mr3966060qkl.362.1583344190874;
        Wed, 04 Mar 2020 09:49:50 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuWUdHcDaT7gZYvMwEEbjQNEGppRVQg++TbU7MnlbDDq4RAg7RhEeWLqMwAEyYWemvBvvuA2Q==
X-Received: by 2002:a37:b48:: with SMTP id 69mr3966036qkl.362.1583344190549;
        Wed, 04 Mar 2020 09:49:50 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id x184sm10337683qkb.128.2020.03.04.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:49:49 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v5 00/14] KVM: Dirty ring interface
Date:   Wed,  4 Mar 2020 12:49:33 -0500
Message-Id: <20200304174947.69595-1-peterx@redhat.com>
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

v5:
- rebased to 5.6-rc4 (removed Paolo's r-b in patch 4 for context change)
- selftest: run all supported modes if mode not specified [Drew]
- selftest: expose vcpu->fd directly to test using vcpu_get_fd [Drew]

v4:
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
V4: https://lore.kernel.org/kvm/20200205025105.367213-1-peterx@redhat.com

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

 Documentation/virt/kvm/api.rst                | 123 +++++
 arch/x86/include/asm/kvm_host.h               |   6 +-
 arch/x86/include/uapi/asm/kvm.h               |   1 +
 arch/x86/kvm/Makefile                         |   3 +-
 arch/x86/kvm/mmu/mmu.c                        |  10 +-
 arch/x86/kvm/mmutrace.h                       |   9 +-
 arch/x86/kvm/svm.c                            |   9 +-
 arch/x86/kvm/vmx/vmx.c                        |  85 +--
 arch/x86/kvm/x86.c                            |  49 +-
 include/linux/kvm_dirty_ring.h                |  50 ++
 include/linux/kvm_host.h                      |  21 +
 include/trace/events/kvm.h                    |  78 +++
 include/uapi/linux/kvm.h                      |  44 ++
 tools/include/uapi/linux/kvm.h                |  44 ++
 tools/testing/selftests/kvm/Makefile          |   2 -
 .../selftests/kvm/clear_dirty_log_test.c      |   2 -
 tools/testing/selftests/kvm/dirty_log_test.c  | 488 ++++++++++++++++--
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  67 +++
 .../selftests/kvm/lib/kvm_util_internal.h     |   4 +
 virt/kvm/dirty_ring.c                         | 176 +++++++
 virt/kvm/kvm_main.c                           | 236 ++++++++-
 22 files changed, 1386 insertions(+), 125 deletions(-)
 create mode 100644 include/linux/kvm_dirty_ring.h
 delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c
 create mode 100644 virt/kvm/dirty_ring.c

-- 
2.24.1

