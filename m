Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F7DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D20217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/cdiXS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgBGSSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:18:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727752AbgBGSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581099474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPT63VS6JkFJRjpL5MMsWxNfN8Beu47vJy8tbC2r7XM=;
        b=Y/cdiXS9qg198XeYOe6OfszY8IiD737uVmSUJE64TzYvg13u9ESEGkmZF/72192DBYdQL7
        6/T7/mO1JCuDDQjRzkApSoIq1OhrLPvdDdCt1QZxCBDOmdTL/j4gr7tzbI8xPLS+NSxjZ0
        TPF5KfngjJMm20SkOCKHiCB1ZJ8FSQI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-FHYEPBncMw-LQjb7p_8LrA-1; Fri, 07 Feb 2020 13:17:52 -0500
X-MC-Unique: FHYEPBncMw-LQjb7p_8LrA-1
Received: by mail-qv1-f72.google.com with SMTP id d7so65863qvq.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPT63VS6JkFJRjpL5MMsWxNfN8Beu47vJy8tbC2r7XM=;
        b=q4dOUn6rFCN5PXBlOkKjus0tZfs126oK5vSLPbwUjenjAHZAdIt1uP9yfYDLXt10sI
         JjEyMvt9epacJzh/H0rM1NgGrxYCSZkz/MQyg0TFA+P6T+QPDLvZc/FMY88HjXLLqOqL
         Pm4jIoQCS4jvKfXcjoBYlNn9y4/g5s9DVuv+3Isi1Z3VClG2eUkOfWA7FvipbNBkaTLa
         HGLmgtG25wlCqitFAXAXjr6zwEVMgXNUI5soykQYAoaBqxCsq296GFFq3HUS+z6Puc0X
         qUD9iih3sH0xGNnyE8DR95G/TCZ6Ul9Qznaf0KNtDS7jvC/FqO6P5z5YmDwMhV/Jjn8U
         AFRQ==
X-Gm-Message-State: APjAAAXszB2dL8uKs9EcKs3EQ0pN6/yF975lrTnBkbM6IVfcgjm5E9+M
        xJ/AJCJNt2vF/GkRBzCOjOwMS/Hm0JWMLntEfOEyejcFSTCPXttniVGdo8sut+0QHW9U1NAYJz4
        0gqV1ksRnznosYp8ABhUVujPW
X-Received: by 2002:a05:6214:1253:: with SMTP id q19mr106736qvv.75.1581099472154;
        Fri, 07 Feb 2020 10:17:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRox8Bo7fyFYmNOjYNh/V3B0M3O5rtHPF6if8Y080MuT3a3U4ayt/3NWDSUCkErG4IzY/vdw==
X-Received: by 2002:a05:6214:1253:: with SMTP id q19mr106704qvv.75.1581099471868;
        Fri, 07 Feb 2020 10:17:51 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id b24sm1725899qto.71.2020.02.07.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 10:17:51 -0800 (PST)
Date:   Fri, 7 Feb 2020 13:17:48 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 12/19] KVM: Move memslot deletion to helper function
Message-ID: <20200207181748.GC720553@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-13-sean.j.christopherson@intel.com>
 <20200206161415.GA695333@xz-x1>
 <20200206162818.GD13067@linux.intel.com>
 <20200206165116.GE695333@xz-x1>
 <20200207175912.GG2401@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200207175912.GG2401@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 09:59:12AM -0800, Sean Christopherson wrote:
> On Thu, Feb 06, 2020 at 11:51:16AM -0500, Peter Xu wrote:
> > On Thu, Feb 06, 2020 at 08:28:18AM -0800, Sean Christopherson wrote:
> > > On Thu, Feb 06, 2020 at 11:14:15AM -0500, Peter Xu wrote:
> > > > On Tue, Jan 21, 2020 at 02:31:50PM -0800, Sean Christopherson wrote:
> > > > > Move memslot deletion into its own routine so that the success path for
> > > > > other memslot updates does not need to use kvm_free_memslot(), i.e. can
> > > > > explicitly destroy the dirty bitmap when necessary.  This paves the way
> > > > > for dropping @dont from kvm_free_memslot(), i.e. all callers now pass
> > > > > NULL for @dont.
> > > > > 
> > > > > Add a comment above the code to make a copy of the existing memslot
> > > > > prior to deletion, it is not at all obvious that the pointer will become
> > > > > stale during sorting and/or installation of new memslots.
> > > > 
> > > > Could you help explain a bit on this explicit comment?  I can follow
> > > > up with the patch itself which looks all correct to me, but I failed
> > > > to catch what this extra comment wants to emphasize...
> > > 
> > > It's tempting to write the code like this (I know, because I did it):
> > > 
> > > 	if (!mem->memory_size)
> > > 		return kvm_delete_memslot(kvm, mem, slot, as_id);
> > > 
> > > 	new = *slot;
> > > 
> > > Where @slot is a pointer to the memslot to be deleted.  At first, second,
> > > and third glances, this seems perfectly sane.
> > > 
> > > The issue is that slot was pulled from struct kvm_memslots.memslots, e.g.
> > > 
> > > 	slot = &slots->memslots[index];
> > > 
> > > Note that slots->memslots holds actual "struct kvm_memory_slot" objects,
> > > not pointers to slots.  When update_memslots() sorts the slots, it swaps
> > > the actual slot objects, not pointers.  I.e. after update_memslots(), even
> > > though @slot points at the same address, it's could be pointing at a
> > > different slot.  As a result kvm_free_memslot() in kvm_delete_memslot()
> > > will free the dirty page info and arch-specific points for some random
> > > slot, not the intended slot, and will set npages=0 for that random slot.
> > 
> > Ah I see, thanks.  Another alternative is we move the "old = *slot"
> > copy into kvm_delete_memslot(), which could be even clearer imo.
> 
> The copy is also needed in __kvm_set_memory_region() for the MOVE case.

Right.  I actually meant to do all "old = *slot" in any function we
need to cache the data explicitly, with that we also need another one
after calling kvm_delete_memslot() for move.  But with the comment as
you suggested below it looks good to me too.

Thanks,

> 
> > However I'm not sure whether it's a good idea to drop the test-by for
> > this.  Considering that comment change should not affect it, would you
> > mind enrich the comment into something like this (or anything better)?
> > 
> > /*
> >  * Make a full copy of the old memslot, the pointer will become stale
> >  * when the memslots are re-sorted by update_memslots() in
> >  * kvm_delete_memslot(), while to make the kvm_free_memslot() work as
> >  * expected later on, we still need the cached memory slot.
> >  */
> 
> As above, it's more subtle than just the kvm_delete_memslot() case.
> 
> 	/*
> 	 * Make a full copy of the old memslot, the pointer will become stale
> 	 * when the memslots are re-sorted by update_memslots() when deleting
> 	 * or moving a memslot, and additional modifications to the old memslot
> 	 * need to be made after calling update_memslots().
> 	 */
> 

-- 
Peter Xu

