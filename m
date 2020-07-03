Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E268C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D062073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtJaKG5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgGCTC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:02:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37669 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgGCTC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593802974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=twCkwjE0ryMOZi8fpz1SnT5K9pmvk7PL5PT5FftWV/0=;
        b=CtJaKG5dMWZsU7SZn5EBApnMn7s58x70BSjZmecY+b+EZugUyF6s8rc4mlSwvDmUGKtcBW
        YpIeyA3Q9VK2lEG3yj3fuqNEjVi/PoXqVNPapMETi/p9ZGxZBBNzc5XQm530kwZIpEAOT0
        CMvc0vk5EdxNPRbyCcvdNHMJ3UvQ6Bo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-pjZC3gQuOfC5lfLykzHTdg-1; Fri, 03 Jul 2020 15:02:50 -0400
X-MC-Unique: pjZC3gQuOfC5lfLykzHTdg-1
Received: by mail-qv1-f71.google.com with SMTP id m8so3616089qvv.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=twCkwjE0ryMOZi8fpz1SnT5K9pmvk7PL5PT5FftWV/0=;
        b=kEx+TJUVnKmo4HO5BQHPnS8zWLZbRqlxqh+G2nXh9O+EN1lCebgt1tqVM7sHC/7eNr
         VZT0YM4kaOqorD6IsDOMtLr3G8cEqzVUpT8VPD3ZwKnWx1ZsnHzaq5dvXdEz7z4khkwS
         XGMuLfI0KD6TM0C6NbqcQv+Ro7dyRKWqIy3uFhVBlgzQ/fxDpUPhq47qFz0/yuHiC34x
         h5QrEXjQVqcvOsnQN9JhE/cwCe51PRTeSvV92cP5dgA1yCwD2hwKQ7YojmzgpQXly5QJ
         enM65qRrRiwazj4C+KFosVcgAx3GWVt9CWQxlonWnXeAtVY2ZwVvde4OfibqzmwRDdwN
         Gchw==
X-Gm-Message-State: AOAM5315eQlNE6SxYibojtUpmY7TVL3P0pWB2npTCS5QpOrekNZyLzL0
        ewl26GbBm2L3tMjZL8r95ZMVS45oScuKCawAbV2LiRpXEMENkICd30fpo71fHJcSd+035ipK6jh
        T0Zj3JP19RMlaSwxMPKO0jUKz
X-Received: by 2002:a05:6214:1882:: with SMTP id cx2mr37285509qvb.240.1593802970304;
        Fri, 03 Jul 2020 12:02:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9utD0D8BS338JK3zldVLP/DumaDiDAvSmzpYFOet+EDIzmo1/XzuAyJnljqPxWQ2+i8nViA==
X-Received: by 2002:a05:6214:1882:: with SMTP id cx2mr37285481qvb.240.1593802970018;
        Fri, 03 Jul 2020 12:02:50 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t65sm8946800qkf.119.2020.07.03.12.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 12:02:49 -0700 (PDT)
Date:   Fri, 3 Jul 2020 15:02:47 -0400
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
Subject: Re: [PATCH v10 03/14] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200703190247.GG6677@xz-x1>
References: <20200601115957.1581250-1-peterx@redhat.com>
 <20200601115957.1581250-4-peterx@redhat.com>
 <20200703000557.GM3575@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200703000557.GM3575@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:05:57PM -0700, Sean Christopherson wrote:
> >  	/* Set up identity-mapping pagetable for EPT in real mode */
> >  	for (i = 0; i < PT32_ENT_PER_PAGE; i++) {
> >  		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
> >  			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
> > -		r = kvm_write_guest_page(kvm, identity_map_pfn,
> > -				&tmp, i * sizeof(tmp), sizeof(tmp));
> > -		if (r < 0)
> > +		r = __copy_to_user(uaddr + i * sizeof(tmp), &tmp, sizeof(tmp));
> > +		if (r) {
> > +			r = -EFAULT;
> 
> Another case where capturing the result is unnecessary.  I don't have a
> preference as to whether the result of __copy_{to,from}_user() is returned
> directly or morphed to -EFAULT, but we should be consistent, especially
> within a single patch.

OK, I'll clean all these __copy_to_user() callers in the next version.

> 
> >  			goto out;
> > +		}
> >  	}
> >  	kvm_vmx->ept_identity_pagetable_done = true;
> >  
> > @@ -3532,19 +3525,22 @@ static void seg_setup(int seg)
> >  static int alloc_apic_access_page(struct kvm *kvm)
> >  {
> >  	struct page *page;
> > -	int r = 0;
> > +	void __user *r;
> > +	int ret = 0;
> >  
> >  	mutex_lock(&kvm->slots_lock);
> >  	if (kvm->arch.apic_access_page_done)
> >  		goto out;
> >  	r = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
> >  				    APIC_DEFAULT_PHYS_BASE, PAGE_SIZE);
> 
> Naming the new 'void __user *hva' would yield a smaller differ and would
> probably help readers in the future.

OK.

> >  	} else {
> > -		if (!slot || !slot->npages)
> > -			return 0;
> > -
> >  		/*
> >  		 * Stuff a non-canonical value to catch use-after-delete.  This
> >  		 * ends up being 0 on 32-bit KVM, but there's no better
> >  		 * alternative.
> >  		 */
> >  		hva = (unsigned long)(0xdeadull << 48);
> > +
> > +		if (!slot || !slot->npages)
> > +			return (void __user *)hva;
> 
> My clever shenanigans got discarded, so this weirdness happily is gone. 

I'll see what I get when I rebase.  This series is easy to encounter conflicts
during previous rebases for misterious reasons.  I guess I'll just repost less
frequently so I suffer less from rebase too. :)

Thanks.

-- 
Peter Xu

