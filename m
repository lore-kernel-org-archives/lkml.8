Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C6DC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867682468B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hX58Sn+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAOP1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:27:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53484 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726562AbgAOP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579102034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GrQDI1QKJQFSWKTPV8QBF65zJbsbNfFS1aRIu3lctzI=;
        b=hX58Sn+lYBEgqWDeK2IWvEk51PvXoT0AtP+sXJtUwMxmuJaP7bkXg75fsUqoZUJS0+oE9I
        niWx76KCv6l2bvOD7T9HrbFKJTJ7e4rzR+rT++TXoFuLuU+PYb/th8O0TLp0cwpjczv4JW
        Sq8Fq5WXYJA4x1GIT7q56GG8WNVUkUU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-9TaxZWSyMw6XOI9Qymn3Hw-1; Wed, 15 Jan 2020 10:27:13 -0500
X-MC-Unique: 9TaxZWSyMw6XOI9Qymn3Hw-1
Received: by mail-qv1-f70.google.com with SMTP id v5so11238852qvn.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GrQDI1QKJQFSWKTPV8QBF65zJbsbNfFS1aRIu3lctzI=;
        b=eHbiJJJfOwzvSSkZlJCTCTS4B+g7oGly88akPJddW04DDkmW2VK73oyqEkhvZXujDV
         WqNJpB42xM4n1eR3EPAIppw5027UgnNkVNrXQy7fd9Kze5uDT4F6CQJnmSEJjlE/ZNck
         5tqcwIJL+TDjO7h3Gwx9QXZUgVv7ZTU8cDCxxG8zLbwsjkz6x7LX+4O5Ue0pKzvqz1zf
         oUNd2OKCGIyC8tBVvUkxkS1lYHnQc2FgDX+zDfkQKjNyvxt8LY7EllfewVHNelzgQ0vG
         ip4+08hg69nqD/fWgPfGZ6rTaG8f8NAhtELZJ4TF4xCfMR0X0WaRP6HtnEW8cicH5J+j
         QFVg==
X-Gm-Message-State: APjAAAX1duq0wrcdmmUzY6tm/6s56auCMTvgddQmgDpVmtMXMnvBrs+F
        iEEtf2n5Lt2gMVO3pTrBmfqHaJLphOX1W3w40uVSeNUvOBQbT/Lg6O3GhLhzXGPQ3ii72yCJpE8
        nzqt5ATa54r87NSqBaRTLrJYy
X-Received: by 2002:ad4:47ad:: with SMTP id a13mr26671533qvz.29.1579102033348;
        Wed, 15 Jan 2020 07:27:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyf/k+vFbqZWyHaisJpZvjvigX9YZaUA6qbIjXme6863s0ct9zw5T+J85MQddVkV1a+vd4PsA==
X-Received: by 2002:ad4:47ad:: with SMTP id a13mr26671502qvz.29.1579102033071;
        Wed, 15 Jan 2020 07:27:13 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id t15sm8461294qkg.49.2020.01.15.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:27:12 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:27:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH v3 12/21] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200115152711.GG233443@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200115014047-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200115014047-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 01:47:15AM -0500, Michael S. Tsirkin wrote:
> > diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
> > new file mode 100644
> > index 000000000000..d6fe9e1b7617
> > --- /dev/null
> > +++ b/include/linux/kvm_dirty_ring.h
> > @@ -0,0 +1,55 @@
> > +#ifndef KVM_DIRTY_RING_H
> > +#define KVM_DIRTY_RING_H
> > +
> > +/**
> > + * kvm_dirty_ring: KVM internal dirty ring structure
> > + *
> > + * @dirty_index: free running counter that points to the next slot in
> > + *               dirty_ring->dirty_gfns, where a new dirty page should go
> > + * @reset_index: free running counter that points to the next dirty page
> > + *               in dirty_ring->dirty_gfns for which dirty trap needs to
> > + *               be reenabled
> > + * @size:        size of the compact list, dirty_ring->dirty_gfns
> > + * @soft_limit:  when the number of dirty pages in the list reaches this
> > + *               limit, vcpu that owns this ring should exit to userspace
> > + *               to allow userspace to harvest all the dirty pages
> > + * @dirty_gfns:  the array to keep the dirty gfns
> > + * @indices:     the pointer to the @kvm_dirty_ring_indices structure
> > + *               of this specific ring
> > + * @index:       index of this dirty ring
> > + */
> > +struct kvm_dirty_ring {
> > +	u32 dirty_index;
> > +	u32 reset_index;
> > +	u32 size;
> > +	u32 soft_limit;
> > +	struct kvm_dirty_gfn *dirty_gfns;
> 
> Here would be a good place to document that accessing
> shared page like this is only safe if archotecture is physically
> tagged.

Right, more importantly is where to document for kvm_run, and any
other shared mappings that I'm not yet aware of across the whole KVM.

[...]

> > +/*
> > + * The following are the requirements for supporting dirty log ring
> > + * (by enabling KVM_DIRTY_LOG_PAGE_OFFSET).
> > + *
> > + * 1. Memory accesses by KVM should call kvm_vcpu_write_* instead
> > + *    of kvm_write_* so that the global dirty ring is not filled up
> > + *    too quickly.
> > + * 2. kvm_arch_mmu_enable_log_dirty_pt_masked should be defined for
> > + *    enabling dirty logging.
> > + * 3. There should not be a separate step to synchronize hardware
> > + *    dirty bitmap with KVM's.
> 
> 
> Are these requirement from an architecture? Then you want to move
> this out of UAPI, keep things relevant to userspace there.

Good point, I removed it, and instead of this...

> 
> > + */
> > +
> > +struct kvm_dirty_gfn {
> > +	__u32 pad;
> > +	__u32 slot;
> > +	__u64 offset;
> > +};
> > +
> 
> Pls add comments about how kvm_dirty_gfn must be mmapped.

... I added this:

/*
 * KVM dirty rings should be mapped at KVM_DIRTY_LOG_PAGE_OFFSET of
 * per-vcpu mmaped regions as an array of struct kvm_dirty_gfn.  The
 * size of the gfn buffer is decided by the first argument when
 * enabling KVM_CAP_DIRTY_LOG_RING.
 */

Thanks,

-- 
Peter Xu

