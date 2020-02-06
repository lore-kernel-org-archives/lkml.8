Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C28DC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BB921775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq7ytd0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBFQv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:51:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42134 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727684AbgBFQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581007885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6wEZC2xS1ICrNAGJ+8QI1N9zsFW9IzwC/0IJCgjt8nk=;
        b=Nq7ytd0eXJdKZ8CPoo1n96CnFlnJhjtZYxcK4REDrfdZ4NLZPjpnPRQjds91J+inHL1pvL
        GSoYApQLM/3CMNgsq/qAA5ECTA9/RMppEXmSAdu+MJOutnfp8hUdKYocgT4pcIjbBbgnHk
        y4GuTS7s+xg3gazFR/xi9tX3G0MpLGs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-MzOsycC3Otq2FgZ2GX4QKg-1; Thu, 06 Feb 2020 11:51:21 -0500
X-MC-Unique: MzOsycC3Otq2FgZ2GX4QKg-1
Received: by mail-qt1-f199.google.com with SMTP id l25so4262706qtu.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6wEZC2xS1ICrNAGJ+8QI1N9zsFW9IzwC/0IJCgjt8nk=;
        b=BajLm3Za8lTtnqaSj0eHAar8r4DKZgOK+BEmqHlOYCuuxTM/xL1KqmaOXuGsnJ+m4p
         mt8HHBaQlItp2E76nsGjBXVfSC/fui7MS7+lHom6SWIMhtfDRQygcQGPncHFNHN2ykr7
         LD+VytqFQlw53hjyomv2mhRQdv+QiLOPy+cPelZnaTff600OJsMmSI5vWuP5HsFFfDow
         7JAjMKHxWgTiM1KRDUIRkDDqeZnhJ121tO8AOh3EOfPeUzHv7bsJPvae9h9DiJIcg5vl
         J4EMudWtSpED/0LUO3Lk655uZtzh8Um7EYxhdw/ytMDxwS/XT4J661QNMzXsoKXwDYrb
         YFeA==
X-Gm-Message-State: APjAAAW7ojgxpaCtKnuTYLDO49E0M8OkyzipPZB/kfXxMY6AWDrWTkUU
        OwJbKXQ8XaupwBVpvbHoQOpQprNbQ+BlQlMo4gEfTGCuYlgzBGS2LQ7BFNCUtD2C6t1vbfeBXJA
        sN+2zKdbREkOuM/CRxNT3f8Ty
X-Received: by 2002:a0c:ed22:: with SMTP id u2mr3142545qvq.13.1581007880669;
        Thu, 06 Feb 2020 08:51:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/jX2RKvHGf3JDTGGU+D3o2LP4p21Bk3Kl7+mbxJpFhXmYhA374b5M6RMOGMp7RFtjxv6e0g==
X-Received: by 2002:a0c:ed22:: with SMTP id u2mr3142516qvq.13.1581007880314;
        Thu, 06 Feb 2020 08:51:20 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id v10sm1058913qtj.26.2020.02.06.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 08:51:19 -0800 (PST)
Date:   Thu, 6 Feb 2020 11:51:16 -0500
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
Message-ID: <20200206165116.GE695333@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-13-sean.j.christopherson@intel.com>
 <20200206161415.GA695333@xz-x1>
 <20200206162818.GD13067@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206162818.GD13067@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 08:28:18AM -0800, Sean Christopherson wrote:
> On Thu, Feb 06, 2020 at 11:14:15AM -0500, Peter Xu wrote:
> > On Tue, Jan 21, 2020 at 02:31:50PM -0800, Sean Christopherson wrote:
> > > Move memslot deletion into its own routine so that the success path for
> > > other memslot updates does not need to use kvm_free_memslot(), i.e. can
> > > explicitly destroy the dirty bitmap when necessary.  This paves the way
> > > for dropping @dont from kvm_free_memslot(), i.e. all callers now pass
> > > NULL for @dont.
> > > 
> > > Add a comment above the code to make a copy of the existing memslot
> > > prior to deletion, it is not at all obvious that the pointer will become
> > > stale during sorting and/or installation of new memslots.
> > 
> > Could you help explain a bit on this explicit comment?  I can follow
> > up with the patch itself which looks all correct to me, but I failed
> > to catch what this extra comment wants to emphasize...
> 
> It's tempting to write the code like this (I know, because I did it):
> 
> 	if (!mem->memory_size)
> 		return kvm_delete_memslot(kvm, mem, slot, as_id);
> 
> 	new = *slot;
> 
> Where @slot is a pointer to the memslot to be deleted.  At first, second,
> and third glances, this seems perfectly sane.
> 
> The issue is that slot was pulled from struct kvm_memslots.memslots, e.g.
> 
> 	slot = &slots->memslots[index];
> 
> Note that slots->memslots holds actual "struct kvm_memory_slot" objects,
> not pointers to slots.  When update_memslots() sorts the slots, it swaps
> the actual slot objects, not pointers.  I.e. after update_memslots(), even
> though @slot points at the same address, it's could be pointing at a
> different slot.  As a result kvm_free_memslot() in kvm_delete_memslot()
> will free the dirty page info and arch-specific points for some random
> slot, not the intended slot, and will set npages=0 for that random slot.

Ah I see, thanks.  Another alternative is we move the "old = *slot"
copy into kvm_delete_memslot(), which could be even clearer imo.
However I'm not sure whether it's a good idea to drop the test-by for
this.  Considering that comment change should not affect it, would you
mind enrich the comment into something like this (or anything better)?

/*
 * Make a full copy of the old memslot, the pointer will become stale
 * when the memslots are re-sorted by update_memslots() in
 * kvm_delete_memslot(), while to make the kvm_free_memslot() work as
 * expected later on, we still need the cached memory slot.
 */

In all cases:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

