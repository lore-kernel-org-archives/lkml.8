Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C4C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C7021775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxSHfEE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgBFVlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:41:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28019 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727526AbgBFVlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581025274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fv7hocxnCQMQx/Ef0JfmL5g1BsW3yRUgDUYfbGA1aT0=;
        b=gxSHfEE4jjQSGZgcjqOLnkFzstB3p5uO+9jEWAeUY0+COObnX7XI+EVMPNXqAqaEcOYR30
        ZyufSrqVQNP4E7bRzl7x5bzm6V1LC0MtMN85oqL8F4XO1sQEKWMR7Nw2GAEh8rrEInxVoD
        OWH+pa1QJbbGcyZ0obujPIXziBez8tY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-Wv-7LZ25PAuAs2HnsmvX1w-1; Thu, 06 Feb 2020 16:41:12 -0500
X-MC-Unique: Wv-7LZ25PAuAs2HnsmvX1w-1
Received: by mail-qv1-f72.google.com with SMTP id p3so4593004qvt.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 13:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fv7hocxnCQMQx/Ef0JfmL5g1BsW3yRUgDUYfbGA1aT0=;
        b=rflVW3dR3G/IuXeZxWXv3CIuBTn5To/XJItwDos38WV861pBnKr6tb3GaGNuXnEvYd
         i2Dl8q2r7TRW5jnQMxJJycYzkOAlZu3QP6JmN8YSBu69NIpQ34k7CMcqBaIw7QFiMxCX
         fBArtvH4Nchh/GskqSHgDqwsj4PlrM0bfMuUIVHMv4fBfwHoTFLYEoA9usWTlHaR3+Sq
         pGV0+w61KTvzVTpLMT2tNSMjzNfP9G5eRI+DqjTjzIetoSi2ESaE/TGn1KOdJe5nszzu
         tQ36PieI/gXLS/m+ikRQUPVwQLiShlR1ARZoHImXxuTKlu4v5ykDA+7Z3D5AJGOvz3Rd
         2Cpw==
X-Gm-Message-State: APjAAAU0IT8AMx5KPmMPItpBLrPgo3BYrDffa12d3sN9d+pJ3LpXMqTJ
        XpaKpf6Zt+y/9gGzYCSS6A3oWNfWwBS4zgS4OCzn+07KrivfJ53QPxZEwh8XkfVoLkszJK72S2w
        myWLiFfoJPeXdgzY6K+mBhMhG
X-Received: by 2002:a05:620a:7f2:: with SMTP id k18mr4541153qkk.207.1581025271641;
        Thu, 06 Feb 2020 13:41:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJgBpP+Sn/XW78feM1lgNrPZNv0ribzryOvpKTws4jf2FMfbWVePD88+Gb3lvt+IGO4p+aFA==
X-Received: by 2002:a05:620a:7f2:: with SMTP id k18mr4541080qkk.207.1581025270452;
        Thu, 06 Feb 2020 13:41:10 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id w9sm304509qka.71.2020.02.06.13.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:41:09 -0800 (PST)
Date:   Thu, 6 Feb 2020 16:41:06 -0500
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
Subject: Re: [PATCH v5 15/19] KVM: Provide common implementation for generic
 dirty log functions
Message-ID: <20200206214106.GG700495@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-16-sean.j.christopherson@intel.com>
 <20200206200200.GC700495@xz-x1>
 <20200206212120.GF13067@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206212120.GF13067@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 01:21:20PM -0800, Sean Christopherson wrote:
> On Thu, Feb 06, 2020 at 03:02:00PM -0500, Peter Xu wrote:
> > On Tue, Jan 21, 2020 at 02:31:53PM -0800, Sean Christopherson wrote:
> > 
> > [...]
> > 
> > > -int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *log)
> > > +void kvm_arch_dirty_log_tlb_flush(struct kvm *kvm,
> > > +				  struct kvm_memory_slot *memslot)
> > 
> > If it's to flush TLB for a memslot, shall we remove the "dirty_log" in
> > the name of the function, because it has nothing to do with dirty
> > logging any more?  And...
> 
> I kept the "dirty_log" to allow arch code to implement logic specific to a
> TLB flush during dirty logging, e.g. x86's lockdep assert on slots_lock.
> And similar to the issue with MIPS below, to deter usage of the hook for
> anything else, i.e. to nudge people to using kvm_flush_remote_tlbs()
> directly.

The x86's lockdep assert is not that important afaict, since the two
callers of the new tlb_flush() hook will be with slots_lock for sure.

> 
> > >  {
> > > -	struct kvm_memslots *slots;
> > > -	struct kvm_memory_slot *memslot;
> > > -	bool flush = false;
> > > -	int r;
> > > -
> > > -	mutex_lock(&kvm->slots_lock);
> > > -
> > > -	r = kvm_clear_dirty_log_protect(kvm, log, &flush);
> > > -
> > > -	if (flush) {
> > > -		slots = kvm_memslots(kvm);
> > > -		memslot = id_to_memslot(slots, log->slot);
> > > -
> > > -		/* Let implementation handle TLB/GVA invalidation */
> > > -		kvm_mips_callbacks->flush_shadow_memslot(kvm, memslot);
> > > -	}
> > > -
> > > -	mutex_unlock(&kvm->slots_lock);
> > > -	return r;
> > > +	/* Let implementation handle TLB/GVA invalidation */
> > > +	kvm_mips_callbacks->flush_shadow_memslot(kvm, memslot);
> > 
> > ... This may not directly related to the current patch, but I'm
> > confused on why MIPS cannot use kvm_flush_remote_tlbs() to flush TLBs.
> > I know nothing about MIPS code, but IIUC here flush_shadow_memslot()
> > is a heavier operation that will also invalidate the shadow pages.
> > Seems to be an overkill here when we only changed write permission of
> > the PTEs?  I tried to check the first occurance (2a31b9db15353) but I
> > didn't find out any clue of it so far.
> > 
> > But that matters to this patch because if MIPS can use
> > kvm_flush_remote_tlbs(), then we probably don't need this
> > arch-specific hook any more and we can directly call
> > kvm_flush_remote_tlbs() after sync dirty log when flush==true.
> 
> Ya, the asid_flush_mask in kvm_vz_flush_shadow_all() is the only thing
> that prevents calling kvm_flush_remote_tlbs() directly, but I have no
> clue as to the important of that code.

As said above I think the x86 lockdep is really not necessary, then
considering MIPS could be the only one that will use the new hook
introduced in this patch...  Shall we figure that out first?

Thanks,

-- 
Peter Xu

