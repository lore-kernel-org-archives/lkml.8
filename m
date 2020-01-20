Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFABC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108C2207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrMhGYfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgATGs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:48:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgATGs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579502907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbPSCio8/LP2m+y+0WtJxGAsKNtPaMEjLFdacvoLLa8=;
        b=WrMhGYfsJ3BoNl8+8n1CmGMTYGAS05hGieYSqzn2nJtdWF7AnAL1IoKv03PK7SPmzYSJSY
        Z/jmulbCYCmp3xQMgzElqKo7t5kHMP7zD2Qou/c/gDUaDQBcCWZM+CDidUhOePzauJIWjB
        80bnETZTfOnvIeNIf6KRF6Pt5KMsrF0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-nfzhNLOTMFaMlFUCzTYXWg-1; Mon, 20 Jan 2020 01:48:26 -0500
X-MC-Unique: nfzhNLOTMFaMlFUCzTYXWg-1
Received: by mail-pg1-f197.google.com with SMTP id g20so18746292pgb.18
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 22:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mbPSCio8/LP2m+y+0WtJxGAsKNtPaMEjLFdacvoLLa8=;
        b=AWfWmbX5dQ4L0QUJHtygGAu5gRavPUp1PmFgjDHf7lBAJNRIx3ciiuyvBbFd0oOge9
         glruGhk8l5eQXGtBMVZPBMq3VnJrt5is5cdi1lw6oXDJhuGS+//dm9nCjfXVEZ4GCxli
         GZJWHtClz/lGJV+U7NKUXEz9bzCMdcb063CZoRNZwBdI0APGGIu69eiEBlKrTbTS3cqr
         fKgkAp6bCwSttQ+E9utJ83WAIM1xgChS1wYZxJlLLKgwnLsJBWRSU64SlHmDLY5mmhK2
         52JvYxfYNwWqbBdIb0tt03bJeEBF/DnyxTDsUz2ZCq11pmDLDptD/BW+ORcfOSvvKAUa
         hkNg==
X-Gm-Message-State: APjAAAWNXRONXcozgE65jwa6XaSwLSe1mbX9EroP5qFthjCf20D26W9R
        1BavlObSYpl9y0SkGDT5je+CC0Vs7l6BlmAWle1yJFgbOR4Kr/y+q9W3udUx06OUgA6r0oUKArW
        O9IKT2OXcDx+xLXHcluE8jHif
X-Received: by 2002:a63:a4b:: with SMTP id z11mr56366217pgk.97.1579502905190;
        Sun, 19 Jan 2020 22:48:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXFGmeddIVnOlaDqMWJbI+cXOBU/LMjL/VsJRQLf4JU44G/RoO8NR+SY+o895T3e4rZphHIA==
X-Received: by 2002:a63:a4b:: with SMTP id z11mr56366193pgk.97.1579502904925;
        Sun, 19 Jan 2020 22:48:24 -0800 (PST)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q64sm16484005pjb.1.2020.01.19.22.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 22:48:24 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:48:11 +0800
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
Message-ID: <20200120064811.GC380565@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200116033725-mutt-send-email-mst@kernel.org>
 <20200116162703.GA344339@xz-x1>
 <20200117045019-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200117045019-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:50:48AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 16, 2020 at 11:27:03AM -0500, Peter Xu wrote:
> > On Thu, Jan 16, 2020 at 03:38:21AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Jan 09, 2020 at 09:57:20AM -0500, Peter Xu wrote:
> > > > +	/* If to map any writable page within dirty ring, fail it */
> > > > +	if ((kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff) ||
> > > > +	     kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff + pages - 1)) &&
> > > > +	    vma->vm_flags & VM_WRITE)
> > > > +		return -EINVAL;
> > > 
> > > Worth thinking about other flags. Do we want to force VM_SHARED?
> > > Disable VM_EXEC?
> > 
> > Makes sense to me.  I think it worths a standalone patch since they
> > should apply for the whole per-vcpu mmaped regions rather than only
> > for the dirty ring buffers.
> > 
> > (Should include KVM_PIO_PAGE_OFFSET, KVM_COALESCED_MMIO_PAGE_OFFSET,
> >  KVM_S390_SIE_PAGE_OFFSET, kvm_run, and this new one)
> > 
> > Thanks,
> 
> 
> I don't think we can change UAPI for existing ones.
> Userspace might be setting these by mistake.

Right (especially for VM_EXEC)... I'll only check that for the new
pages then.  Thanks,

-- 
Peter Xu

