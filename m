Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC82C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B3B2072B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asW7lBr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgASJLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 04:11:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726619AbgASJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 04:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579425093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mUEmmfK3pKxnf8qfhqO5jZ3Rte4BKgIla9+I2biLiA=;
        b=asW7lBr0gXhbJH64GTyTCNe0J20sWIiuYlSaBIte/Z8RsT/R3C1gKt5kea36tl8RMPeNxw
        cthBxzOSRyXi3Ctnof7CnZ2UMAITW+YqI6eNtUQgjizChtLmP2E018HGJ0gHtZp3d4MGoE
        uUPw92dUzg+Fy7ExQ/TY1TOLgghTrro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-2-JG8gGPMKGE-aOgVWFPrA-1; Sun, 19 Jan 2020 04:11:32 -0500
X-MC-Unique: 2-JG8gGPMKGE-aOgVWFPrA-1
Received: by mail-wm1-f71.google.com with SMTP id q206so3017384wme.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 01:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mUEmmfK3pKxnf8qfhqO5jZ3Rte4BKgIla9+I2biLiA=;
        b=Q0wAZzSt3QdPhb0WtwchPursYhry94aK/0909xweQyU5qlePQBqjf1lrKmWW0AC+Ks
         0pZEE6Pt7IAn9RRV2M9n/DRGl+ub4q/36s2Lf1fgJtWNn/CydONfZFRQ7qUH5u7DV+eW
         w2v70zFWmM0gxsS2pd30TEiV1xTKvWu/up6mR09x75/pTO5d2eF6XPgoXpXnWPRpOabN
         Y+dl7lOUGBaMnM7RZrxihul4EcpmDWHIIlzj2Pio/PN1YXM13VF7OlgdlPXIBi6F8TCF
         A8+kU1/FQWxGWsCuBuMLY1VEsGlV08R2N/+xtdaXCeVKRJqwdxnptjyso3yibCiS/Of0
         8M9Q==
X-Gm-Message-State: APjAAAWSTn5jYYoTyUoJ7JpIrnNYfFUf8tl3gk/UrTJjcgN7Rj4BM09i
        lqiFEEvtkkPAZPDOX9qF5rrJiQsAOVu6pc9HMdpY0786PAvnFIgzmSl76pj9M61fvo+R8R5HgTC
        e3NYZb1i/xqdMKUsFLT+3K0rd
X-Received: by 2002:adf:8041:: with SMTP id 59mr12478719wrk.257.1579425091357;
        Sun, 19 Jan 2020 01:11:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGb1o3YpqTj/cbGW33FaUmZUWW/58dQ/oYjm/ckrPdY8MfV7om5nW1S90C9yqIJUSmOIAIQg==
X-Received: by 2002:adf:8041:: with SMTP id 59mr12478691wrk.257.1579425091059;
        Sun, 19 Jan 2020 01:11:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id j12sm42942885wrt.55.2020.01.19.01.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 01:11:30 -0800 (PST)
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2dbda1b2-888e-dcb8-50ec-b8400e83225c@redhat.com>
Date:   Sun, 19 Jan 2020 10:11:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 15:57, Peter Xu wrote:
> Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> (based on kvm/queue)
> 
> Please refer to either the previous cover letters, or documentation
> update in patch 12 for the big picture.  Previous posts:
> 
> V1: https://lore.kernel.org/kvm/20191129213505.18472-1-peterx@redhat.com
> V2: https://lore.kernel.org/kvm/20191221014938.58831-1-peterx@redhat.com
> 
> The major change in V3 is that we dropped the whole waitqueue and the
> global lock. With that, we have clean per-vcpu ring and no default
> ring any more.  The two kvmgt refactoring patches were also included
> to show the dependency of the works.
> 
> Patchset layout:
> 
> Patch 1-2:         Picked up from kvmgt refactoring
> Patch 3-6:         Small patches that are not directly related,
>                    (So can be acked/nacked/picked as standalone)
> Patch 7-11:        Prepares for the dirty ring interface
> Patch 12:          Major implementation
> Patch 13-14:       Quick follow-ups for patch 8
> Patch 15-21:       Test cases
> 
> V3 changelog:
> 
> - fail userspace writable maps on dirty ring ranges [Jason]
> - commit message fixups [Paolo]
> - change __x86_set_memory_region to return hva [Paolo]
> - cacheline align for indices [Paolo, Jason]
> - drop waitqueue, global lock, etc., include kvmgt rework patchset
> - take lock for __x86_set_memory_region() (otherwise it triggers a
>   lockdep in latest kvm/queue) [Paolo]
> - check KVM_DIRTY_LOG_PAGE_OFFSET in kvm_vm_ioctl_enable_dirty_log_ring
> - one more patch to drop x86_set_memory_region [Paolo]
> - one more patch to remove extra srcu usage in init_rmode_identity_map()
> - add some r-bs for Paolo
> 
> Please review, thanks.
> 
> Paolo Bonzini (1):
>   KVM: Move running VCPU from ARM to common code
> 
> Peter Xu (18):
>   KVM: Remove kvm_read_guest_atomic()
>   KVM: Add build-time error check on kvm_run size
>   KVM: X86: Change parameter for fast_page_fault tracepoint
>   KVM: X86: Don't take srcu lock in init_rmode_identity_map()
>   KVM: Cache as_id in kvm_memory_slot
>   KVM: X86: Drop x86_set_memory_region()
>   KVM: X86: Don't track dirty for KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
>   KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
>   KVM: X86: Implement ring-based dirty memory tracking
>   KVM: Make dirty ring exclusive to dirty bitmap log
>   KVM: Don't allocate dirty bitmap if dirty ring is enabled
>   KVM: selftests: Always clear dirty bitmap after iteration
>   KVM: selftests: Sync uapi/linux/kvm.h to tools/
>   KVM: selftests: Use a single binary for dirty/clear log test
>   KVM: selftests: Introduce after_vcpu_run hook for dirty log test
>   KVM: selftests: Add dirty ring buffer test
>   KVM: selftests: Let dirty_log_test async for dirty ring test
>   KVM: selftests: Add "-c" parameter to dirty log test
> 
> Yan Zhao (2):
>   vfio: introduce vfio_iova_rw to read/write a range of IOVAs
>   drm/i915/gvt: subsitute kvm_read/write_guest with vfio_iova_rw
> 
>  Documentation/virt/kvm/api.txt                |  96 ++++
>  arch/arm/include/asm/kvm_host.h               |   2 -
>  arch/arm64/include/asm/kvm_host.h             |   2 -
>  arch/x86/include/asm/kvm_host.h               |   7 +-
>  arch/x86/include/uapi/asm/kvm.h               |   1 +
>  arch/x86/kvm/Makefile                         |   3 +-
>  arch/x86/kvm/mmu/mmu.c                        |   6 +
>  arch/x86/kvm/mmutrace.h                       |   9 +-
>  arch/x86/kvm/svm.c                            |   3 +-
>  arch/x86/kvm/vmx/vmx.c                        |  86 ++--
>  arch/x86/kvm/x86.c                            |  43 +-
>  drivers/gpu/drm/i915/gvt/kvmgt.c              |  25 +-
>  drivers/vfio/vfio.c                           |  45 ++
>  drivers/vfio/vfio_iommu_type1.c               |  81 ++++
>  include/linux/kvm_dirty_ring.h                |  55 +++
>  include/linux/kvm_host.h                      |  37 +-
>  include/linux/vfio.h                          |   5 +
>  include/trace/events/kvm.h                    |  78 ++++
>  include/uapi/linux/kvm.h                      |  33 ++
>  tools/include/uapi/linux/kvm.h                |  38 ++
>  tools/testing/selftests/kvm/Makefile          |   2 -
>  .../selftests/kvm/clear_dirty_log_test.c      |   2 -
>  tools/testing/selftests/kvm/dirty_log_test.c  | 420 ++++++++++++++++--
>  .../testing/selftests/kvm/include/kvm_util.h  |   4 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  72 +++
>  .../selftests/kvm/lib/kvm_util_internal.h     |   3 +
>  virt/kvm/arm/arch_timer.c                     |   2 +-
>  virt/kvm/arm/arm.c                            |  29 --
>  virt/kvm/arm/perf.c                           |   6 +-
>  virt/kvm/arm/vgic/vgic-mmio.c                 |  15 +-
>  virt/kvm/dirty_ring.c                         | 162 +++++++
>  virt/kvm/kvm_main.c                           | 215 +++++++--
>  32 files changed, 1379 insertions(+), 208 deletions(-)
>  create mode 100644 include/linux/kvm_dirty_ring.h
>  delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c
>  create mode 100644 virt/kvm/dirty_ring.c
> 

Queued patches 3-6, 8-9, 11; thanks!

Paolo

