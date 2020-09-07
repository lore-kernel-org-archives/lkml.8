Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C942C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE2A2078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+ZJ2KCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgIGP3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:29:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730067AbgIGP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599492505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sVz1sXB3S8O+Ei2CKhwWlGsleL+awuWDP8l7TGlMTQ=;
        b=J+ZJ2KCLBLu9z2ZlcygP6YcNm5GH3S0BSLlkDTGVNg7vSRSMwhlm4WYaViU1iEzvLYoKRI
        oFP7E5FhpFOmo+3ov+Ho1xMVUo446QNl0XtRy3FPu/APrM93jyEvXSYuEoP/VtNAQdV5ni
        XQZWBEDOGkAsW7ld9cTnknjYEtdi5rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-lo-bhTY-OiOxxFEK9sC7Kg-1; Mon, 07 Sep 2020 11:28:24 -0400
X-MC-Unique: lo-bhTY-OiOxxFEK9sC7Kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D0DD18B9EC1;
        Mon,  7 Sep 2020 15:28:22 +0000 (UTC)
Received: from work-vm (ovpn-114-180.ams2.redhat.com [10.36.114.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 742D65D9D2;
        Mon,  7 Sep 2020 15:28:15 +0000 (UTC)
Date:   Mon, 7 Sep 2020 16:28:12 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Steven Price <steven.price@arm.com>, eric.auger@redhat.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <Peter.Maydell@arm.com>,
        Haibo Xu <Haibo.Xu@arm.com>
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
Message-ID: <20200907152812.GJ2682@work-vm>
References: <20200904160018.29481-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160018.29481-1-steven.price@arm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing in Eric Auger)

* Steven Price (steven.price@arm.com) wrote:
> Arm's Memory Tagging Extension (MTE) adds 4 bits of tag data to every 16
> bytes of memory in the system. This along with stashing a tag within the
> high bit of virtual addresses allows runtime checking of memory
> accesses.
> 
> These patches add support to KVM to enable MTE within a guest. They are
> based on Catalin's v9 MTE user-space support series[1].
> 
> I'd welcome feedback on the proposed user-kernel ABI. Specifically this
> series currently:
> 
>  1. Requires the VMM to enable MTE per-VCPU.
>  2. Automatically promotes (normal host) memory given to the guest to be
>     tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
>     tags are cleared if the memory wasn't previously MTE enabled.
>  3. Doesn't provide any new methods for the VMM to access the tags on
>     memory.
> 
> (2) and (3) are particularly interesting from the aspect of VM migration.
> The guest is able to store/retrieve data in the tags (presumably for the
> purpose of tag checking, but architecturally it could be used as just
> storage). This means that when migrating a guest the data needs to be
> transferred (or saved/restored).
> 
> MTE tags are controlled by the same permission model as normal pages
> (i.e. a read-only page has read-only tags), so the normal methods of
> detecting guest changes to pages can be used. But this would also
> require the tags within a page to be migrated at the same time as the
> data (since the access control for tags is the same as the normal data
> within a page).

(Without understanding anything about your tag system...)

Note that during (normal, non-postcopy) migration the consistency can
be a little loose - until the guest starts running; i.e. you can send
a page that's in themiddle of being modified as long as you make sure
you send it again later so that what the guest sees on the destination
when it runs is consistent; i.e. it would be fine to send your tags
separately to your data and allow them to get a little out of sync, as
long as they caught up before the guest ran.

> (3) may be problematic and I'd welcome input from those familiar with
> VMMs. User space cannot access tags unless the memory is mapped with the
> PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
> for the user space process (assuming the VMM enables tag checking for
> the process) and since the tags in memory are controlled by the guest
> it's unlikely the VMM would have an appropriately tagged pointer for its
> access. This means the VMM would either need to maintain two mappings of
> memory (one to access tags, the other to access data) or disable tag
> checking during the accesses to data.

Imagine I had a second mapping; what would it look like; how would I get
and restore the tags?

In terms of migration stream, I guess we have two ways to do this,
either it rides shotgun on the main RAM section pages, transmitting
those few extra bytes whenever we transmit a page, or you have a
separate iteratable device for RAMtags, and it just transmits those.
How you keep the two together is an interesting question.
The shotgun method sounds nasty to avoid putting special cases in the,
already hairy, RAM code.

> If it's not practical to either disable tag checking in the VMM or
> maintain multiple mappings then the alternatives I'm aware of are:
> 
>  * Provide a KVM-specific method to extract the tags from guest memory.
>    This might also have benefits in terms of providing an easy way to
>    read bulk tag data from guest memory (since the LDGM instruction
>    isn't available at EL0).
>  * Provide support for user space setting the TCMA0 or TCMA1 bits in
>    TCR_EL1. These would allow the VMM to generate pointers which are not
>    tag checked.

I guess you want the VMM to do as much tagged checked access as possible
on it's own data structures?

How do things like virtio work where the qemu or kernel is accessing
guest memory for IO?

Dave

> Feedback is welcome, and feel free to ask questions if anything in the
> above doesn't make sense.
> 
> Changes since the previous v1 posting[2]:
> 
>  * Rebasing clean-ups
>  * sysreg visibility is now controlled based on whether the VCPU has MTE
>    enabled or not
> 
> [1] https://lore.kernel.org/r/20200904103029.32083-1-catalin.marinas@arm.com
> [2] https://lore.kernel.org/r/20200713100102.53664-1-steven.price%40arm.com
> 
> Steven Price (2):
>   arm64: kvm: Save/restore MTE registers
>   arm64: kvm: Introduce MTE VCPU feature
> 
>  arch/arm64/include/asm/kvm_emulate.h       |  3 +++
>  arch/arm64/include/asm/kvm_host.h          |  9 ++++++++-
>  arch/arm64/include/asm/sysreg.h            |  3 ++-
>  arch/arm64/include/uapi/asm/kvm.h          |  1 +
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>  arch/arm64/kvm/mmu.c                       | 15 +++++++++++++++
>  arch/arm64/kvm/reset.c                     |  8 ++++++++
>  arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
>  8 files changed, 66 insertions(+), 7 deletions(-)
> 
> -- 
> 2.20.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

