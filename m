Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9A7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82172084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6Ej3TQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGCSla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:41:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53674 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbgGCSl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593801688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c83Dgu3F7bsHrP60t6VLlQzU3WYklyXESDcu0K3MgRU=;
        b=Q6Ej3TQCkc1Qeg2ZcIHOMLY2zCWH48g4Mvp0SUVqwQbeTsNHjVPXf0duSYvqmXCXcSnRd1
        HgS+wDmpihf605mCgQCFktrdClz8/X4Hg/MQ/igD/8TwFXEoD10hDwPyqND1A93k2BhH19
        mqmSA9UpP5nJHBj16J49jDfrJvU874o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-H8CCHlhONMmkprjaoBDMMg-1; Fri, 03 Jul 2020 14:41:25 -0400
X-MC-Unique: H8CCHlhONMmkprjaoBDMMg-1
Received: by mail-qt1-f198.google.com with SMTP id i5so22379649qtw.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 11:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c83Dgu3F7bsHrP60t6VLlQzU3WYklyXESDcu0K3MgRU=;
        b=L3DA5GEA4TCsMLO6yG83zBnqRTyK559f+TFCMhavkl9J/1tpzzQeIWuky0xvHmvR6p
         YK6A2QKzYLw2ZphfKEMrt0VePIA4gsMYKxXC8SCaEJbmcx1aa67K56fIHqzpi2qBilYy
         ue1xTvMBs4KItJSz6qyZlfyMeOGu6ZiBfJ7HojIX2q3qDp/R31nEV9vWj4Aaf5Re93rp
         tOC1W783EX2al8lV4rD6CqzaNBhVlgRsV42tU6ao6Tp+G1hI0Gg83PPfUx3lzB7HZFQn
         I1UyaTx8ZWLOo6pojCrcpzA2jfcxZ7B41pfgIuSjttXI/v1O/szswwFgXIiSgEl8i+Eq
         Anug==
X-Gm-Message-State: AOAM530UgW887K039SpJZjSpecIChlfwnjUYhVio9Da+y4iYnZdA0gMy
        TdGkkJSwlFauRnnE9ZwzCwiIDmDJc9cRCtKz/RaJx0nN9F1UHArOcAfYFOa44IcFQg+sd8wYrnP
        L/N13YnxAPHM5En8gSIRSPYIa
X-Received: by 2002:a0c:db8a:: with SMTP id m10mr36623055qvk.21.1593801684762;
        Fri, 03 Jul 2020 11:41:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBEnbzWFcgnnEyEN9LPngYgaXBJvTYCdREKhTVEN13IPzAhqv4lj8Wr6UjTQ7Znh1FC+wJ5w==
X-Received: by 2002:a0c:db8a:: with SMTP id m10mr36623028qvk.21.1593801684349;
        Fri, 03 Jul 2020 11:41:24 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a28sm10753840qko.45.2020.07.03.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:41:23 -0700 (PDT)
Date:   Fri, 3 Jul 2020 14:41:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v10 02/14] KVM: Cache as_id in kvm_memory_slot
Message-ID: <20200703184122.GF6677@xz-x1>
References: <20200601115957.1581250-1-peterx@redhat.com>
 <20200601115957.1581250-3-peterx@redhat.com>
 <20200702230849.GL3575@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702230849.GL3575@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 04:08:49PM -0700, Sean Christopherson wrote:
> On Mon, Jun 01, 2020 at 07:59:45AM -0400, Peter Xu wrote:
> > Cache the address space ID just like the slot ID.  It will be used in
> > order to fill in the dirty ring entries.
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/kvm_host.h | 1 +
> >  virt/kvm/kvm_main.c      | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 01276e3d01b9..5e7bbaf7a36b 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -346,6 +346,7 @@ struct kvm_memory_slot {
> >  	unsigned long userspace_addr;
> >  	u32 flags;
> >  	short id;
> > +	u16 as_id;
> >  };
> >  
> >  static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 74bdb7bf3295..ebdd98a30e82 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1243,6 +1243,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  	if (!mem->memory_size)
> >  		return kvm_delete_memslot(kvm, mem, &old, as_id);
> 
> This technically needs to set as_id in the deleted memslot.  I highly doubt
> it will ever matter from a functionality perspective, but it'd be confusing
> to encounter a memslot whose as_id did not match that of its owner.

Yeah it shouldn't matter because as_id is directly passed in to look up the
pointer of kvm_memslots in kvm_delete_memslot, and memslot->as_id shouldn't be
further referenced.

I can add a comment above if this can clarify things a bit:

+	u16 as_id; /* cache of as_id; only valid if npages != 0 */

Thanks,

-- 
Peter Xu

