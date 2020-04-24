Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA37C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9546620736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJM7Wmo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgDXOTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:19:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726699AbgDXOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587737990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7p6l2JSQjHdHB24SyyMCf4UOfahpyjWFoDJ3GFXOQTs=;
        b=WJM7Wmo363qZwNvDVhjzJzsMhD+hEppJRC0JvsZsaLvNdtRCLtFt8MoyktsF20F9CW3uCl
        +JOHWRp98fFbmNm0e/a3AewU1NUxbH9YFhf2W2mkV24YqnwD8uqBefC12MGWyNVhDMKFlC
        RzbyHW718Q4oGQKCUU2B9Mp1bPaZA/Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-5ZmWsH9xOKO_k5CfGy38gg-1; Fri, 24 Apr 2020 10:19:48 -0400
X-MC-Unique: 5ZmWsH9xOKO_k5CfGy38gg-1
Received: by mail-qv1-f69.google.com with SMTP id g6so8851723qvn.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7p6l2JSQjHdHB24SyyMCf4UOfahpyjWFoDJ3GFXOQTs=;
        b=GqHRNKAMs+tPYQvydEMb37yCQ/ChiMpuhf+hIVSjyePe8uV6fMy0kNUbAX9+1lNWue
         f0VaLk0vG36aWzhwfAB0p4IlvfQwUNvbQdmRm6b9LD+3HC7pEVhGxciB5X3Yo2MD5eFb
         W6Rghb3zS038zqqXi7RyKg4234PfncWbpJeKbXgjW0EN/KCxU/gcML7+Vl1+eRb6LmjM
         Le4fWB+2oSnAdLNhfap3EDkaLVuEtjRj3xWUXZEeN2Vo0XtQZEW/2ajRfOHLJ+e/UDqC
         uoNHe/fVN7n32jfPerTgZQZCQzxv0OA83KwmUpg/362kB7xjqZXx+0En8pZjeIbNO4wK
         V2Fw==
X-Gm-Message-State: AGi0Pub/kFAmHSyuFweMKDFduSDLMoynzYzoaaPCD6F7OP3SqvoWcODq
        +2TzbM0tzX1Sy7JmWxECpQ+nSo1mcVkA4s1TiLWExRt1zCNhJwIxnLyQTjCVUiRCxSfTPahLO9/
        J5aeoqiuYsRwX9a70BQogrUZA
X-Received: by 2002:a0c:e752:: with SMTP id g18mr8460605qvn.111.1587737987941;
        Fri, 24 Apr 2020 07:19:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLulaNDCambrG6qaNpcawHkKnh9FT43MlHotWED9Nqezj+BP+ruVVjLPTsk9EHKqkvUojglqA==
X-Received: by 2002:a0c:e752:: with SMTP id g18mr8460580qvn.111.1587737987463;
        Fri, 24 Apr 2020 07:19:47 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w22sm3761200qkb.43.2020.04.24.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:19:46 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:19:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v8 00/14] KVM: Dirty ring interface
Message-ID: <20200424141944.GA41816@xz-x1>
References: <20200331190000.659614-1-peterx@redhat.com>
 <20200422185155.GA3596@xz-x1>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D877A3B@SHSMSX104.ccr.corp.intel.com>
 <20200423152253.GB3596@xz-x1>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D899D8D@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D899D8D@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 06:01:46AM +0000, Tian, Kevin wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Thursday, April 23, 2020 11:23 PM
> > 
> > On Thu, Apr 23, 2020 at 06:28:43AM +0000, Tian, Kevin wrote:
> > > > From: Peter Xu <peterx@redhat.com>
> > > > Sent: Thursday, April 23, 2020 2:52 AM
> > > >
> > > > Hi,
> > > >
> > > > TL;DR: I'm thinking whether we should record pure GPA/GFN instead of
> > > > (slot_id,
> > > > slot_offset) tuple for dirty pages in kvm dirty ring to unbind
> > kvm_dirty_gfn
> > > > with memslots.
> > > >
> > > > (A slightly longer version starts...)
> > > >
> > > > The problem is that binding dirty tracking operations to KVM memslots is
> > a
> > > > restriction that needs synchronization to memslot changes, which further
> > > > needs
> > > > synchronization across all the vcpus because they're the consumers of
> > > > memslots.
> > > > E.g., when we remove a memory slot, we need to flush all the dirty bits
> > > > correctly before we do the removal of the memslot.  That's actually an
> > > > known
> > > > defect for QEMU/KVM [1] (I bet it could be a defect for many other
> > > > hypervisors...) right now with current dirty logging.  Meanwhile, even if
> > we
> > > > fix it, that procedure is not scale at all, and error prone to dead locks.
> > > >
> > > > Here memory removal is really an (still corner-cased but relatively)
> > important
> > > > scenario to think about for dirty logging comparing to memory additions
> > &
> > > > movings.  Because memory addition will always have no initial dirty page,
> > > > and
> > > > we don't really move RAM a lot (or do we ever?!) for a general VM use
> > case.
> > > >
> > > > Then I went a step back to think about why we need these dirty bit
> > > > information
> > > > after all if the memslot is going to be removed?
> > > >
> > > > There're two cases:
> > > >
> > > >   - When the memslot is going to be removed forever, then the dirty
> > > > information
> > > >     is indeed meaningless and can be dropped, and,
> > > >
> > > >   - When the memslot is going to be removed but quickly added back with
> > > > changed
> > > >     size, then we need to keep those dirty bits because it's just a commmon
> > > > way
> > > >     to e.g. punch an MMIO hole in an existing RAM region (here I'd confess
> > I
> > > >     feel like using "slot_id" to identify memslot is really unfriendly syscall
> > > >     design for things like "hole punchings" in the RAM address space...
> > > >     However such "punch hold" operation is really needed even for a
> > common
> > > >     guest for either system reboots or device hotplugs, etc.).
> > >
> > > why would device hotplug punch a hole in an existing RAM region?
> > 
> > I thought it could happen because I used to trace the KVM ioctls and see the
> > memslot changes during driver loading.  But later when I tried to hotplug a
> 
> Is there more detail why driver loading may lead to memslot changes?

E.g., I can observe these after Linux loads and before the prompt, which is a
simplest VM with default devices on:

41874@1587736345.192636:kvm_set_user_memory Slot#3 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.192760:kvm_set_user_memory Slot#65539 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.193884:kvm_set_user_memory Slot#3 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.193956:kvm_set_user_memory Slot#65539 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.195788:kvm_set_user_memory Slot#3 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.195838:kvm_set_user_memory Slot#65539 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.196769:kvm_set_user_memory Slot#3 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.196827:kvm_set_user_memory Slot#65539 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.197787:kvm_set_user_memory Slot#3 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.197832:kvm_set_user_memory Slot#65539 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.198777:kvm_set_user_memory Slot#3 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.198836:kvm_set_user_memory Slot#65539 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.200491:kvm_set_user_memory Slot#3 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.200537:kvm_set_user_memory Slot#65539 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.201592:kvm_set_user_memory Slot#3 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.201649:kvm_set_user_memory Slot#65539 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.202415:kvm_set_user_memory Slot#3 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.202461:kvm_set_user_memory Slot#65539 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.203169:kvm_set_user_memory Slot#3 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.203225:kvm_set_user_memory Slot#65539 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.204037:kvm_set_user_memory Slot#3 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.204083:kvm_set_user_memory Slot#65539 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.204983:kvm_set_user_memory Slot#3 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.205041:kvm_set_user_memory Slot#65539 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.205940:kvm_set_user_memory Slot#3 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.206022:kvm_set_user_memory Slot#65539 flags=0x0 gpa=0xfd000000 size=0x0 ua=0x7fadf6800000 ret=0
41874@1587736345.206981:kvm_set_user_memory Slot#3 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41874@1587736345.207038:kvm_set_user_memory Slot#65539 flags=0x1 gpa=0xfd000000 size=0x1000000 ua=0x7fadf6800000 ret=0
41875@1587736351.141052:kvm_set_user_memory Slot#9 flags=0x1 gpa=0xa0000 size=0x10000 ua=0x7fadf6800000 ret=0

After a careful look, I noticed it's only the VGA device mostly turning slot 3
off & on.  Frankly speaking I don't know why it happens to do so.

> 
> > device I do see that it won't...  The new MMIO regions are added only into
> > 0xfe000000 for a virtio-net:
> > 
> >   00000000fe000000-00000000fe000fff (prio 0, i/o): virtio-pci-common
> >   00000000fe001000-00000000fe001fff (prio 0, i/o): virtio-pci-isr
> >   00000000fe002000-00000000fe002fff (prio 0, i/o): virtio-pci-device
> >   00000000fe003000-00000000fe003fff (prio 0, i/o): virtio-pci-notify
> >   00000000fe840000-00000000fe84002f (prio 0, i/o): msix-table
> >   00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
> > 
> > Does it mean that device plugging is guaranteed to not trigger RAM changes?
> 
> I'd think so. Otherwise from guest p.o.v any device hotplug implies doing
> a memory hot-unplug first then it's a bad design.

Right that's what I was confused about.  Then maybe you're right. :)

> 
> > I
> > am really curious about what cases we need to consider in which we need to
> > keep
> > the dirty bits for a memory removal, and if system reset is the only case, then
> > it could be even easier (because we might be able to avoid the sync in
> > memory
> > removal but do that once in a sys reset hook)...
> 
> Possibly memory hot-unplug, as allowed by recent virtio-mem? 

That should belong to the case where dirty bits do not matter at all after the
removal, right?  I would be mostly curious about when we (1) remove a memory
slot, and at the meantime (2) we still care about the dirty bits of that slot.

I'll see whether I can remove the dirty bit sync in kvm_set_phys_mem(), which I
think is really nasty.

> 
> btw VFIO faces a similar problem when unmapping a DMA range (e.g. when
> vIOMMU is enabled) in dirty log phase. There could be some dirty bits which are
> not retrieved when unmapping happens. VFIO chooses to return the dirty
> bits in a buffer passed in the unmapping parameters. Can memslot interface
> do similar thing by allowing the userspace to specify a buffer pointer to hold
> whatever dirty pages recorded for the slot that is being removed?

Yes I think we can, but may not be necessary.  Actually IMHO CPU access to
pages are slightly different to device DMAs in that we can do these sequence to
collect the dirty bits of a slot safely:

  - mark slot as READONLY
  - KVM_GET_DIRTY_LOG on the slot
  - finally remove the slot

I guess VFIO cannot do that because there's no way to really "mark the region
as read-only" for a device because DMA could happen and DMA would fail then
when writting to a readonly slot.

On the KVM/CPU side, after we mark the slot as READONLY then the CPU writes
will page fault and fallback to the QEMU userspace, then QEMU will take care of
the writes (so those writes could be slow but still working) then even if we
mark it READONLY it won't fail the writes but just fallback to QEMU.

Btw, since we're discussing the VFIO dirty logging across memory removal... the
unmapping DMA range you're talking about needs to be added back later, right?
Then what if the device does DMA after the removal but before it's added back?
I think this is a more general question not for dirty logging but also for when
dirty logging is not enabled - I never understand how this could be fixed with
existing facilities.

Thanks,

-- 
Peter Xu

