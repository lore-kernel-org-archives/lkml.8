Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8625DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572E9206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2A78hJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgAPQ1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:27:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25828 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbgAPQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579192032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WC8Z8j4wZiM+iDNfePn8Q6kPV/b9KT3V2XFsUH+aPzw=;
        b=c2A78hJsrxeSpCl2yTwzfFs8ZFR9thdGmWuVnyTYtPng0I0g1po+galVEp3UOWVp5h3f72
        oRQf3eXK4Cnq5gO2r3oTTUJ/a46sYfFaO/ditnLuYlY6d+f9SlEyMCW5+jeeY1XwUUJzMb
        JX/J4kvw0205QKGCEiXkLtfZqL5BRTQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-9JyFAkkjMV-zeYfI-GEfKw-1; Thu, 16 Jan 2020 11:27:06 -0500
X-MC-Unique: 9JyFAkkjMV-zeYfI-GEfKw-1
Received: by mail-qv1-f72.google.com with SMTP id n11so13655833qvp.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WC8Z8j4wZiM+iDNfePn8Q6kPV/b9KT3V2XFsUH+aPzw=;
        b=Ajtd0d1XQKK3tbxPZGBBQbH/ugEjjRdjd+tI4AOyBx5bzxVbJC8p5shERTGqjMiXQV
         1VhmiHu5Nm2oglyBsEpWEKf+++kLIvyiDz7p2TqeE3hDaGH1I8jbuqQiaB/ZvInIoguy
         9CymvctCNyzKRFzX+mEIk+zk6ACWABfEmKbWoAhOP1O3KBay5MPgY68CdniIrEbhvymP
         oQCb+Wq/w8RATLCrz17LU1yOWlG8+/fVqo8ENL/XPCia6SzMKdIDJzHPvQSsyu8iv5oM
         aDFHu7On+SRjygTO6P4+mdyME/Jlx/NAb2to/UGXhOxxnSFQ9klKaIJsJSfgRuAEkyJv
         TH5Q==
X-Gm-Message-State: APjAAAW04xi2thO9RNNmpTgiTSsUr7nMeJ6qq2/g3flTYmcLIZcWEcOW
        I+NZNYMnrZSKWAjaqPfEY6K+zDaRowfWXdECXangMja5L7wpoY6IN4clw/8FB2JfBpCIEBHQqyI
        VsKREslDzxgbDOorHyh9rilkZ
X-Received: by 2002:a37:8ac4:: with SMTP id m187mr29027939qkd.277.1579192025801;
        Thu, 16 Jan 2020 08:27:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYtk2Bh02F1YEqXqx8bwti4pMx8sbu0T6IbdlxQJ1t7qPkHRZYDmYJaMmrkINO8rf3duc41Q==
X-Received: by 2002:a37:8ac4:: with SMTP id m187mr29027901qkd.277.1579192025558;
        Thu, 16 Jan 2020 08:27:05 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id k29sm11420492qtu.54.2020.01.16.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:27:04 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:27:03 -0500
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
Message-ID: <20200116162703.GA344339@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200116033725-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200116033725-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 03:38:21AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2020 at 09:57:20AM -0500, Peter Xu wrote:
> > +	/* If to map any writable page within dirty ring, fail it */
> > +	if ((kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff) ||
> > +	     kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff + pages - 1)) &&
> > +	    vma->vm_flags & VM_WRITE)
> > +		return -EINVAL;
> 
> Worth thinking about other flags. Do we want to force VM_SHARED?
> Disable VM_EXEC?

Makes sense to me.  I think it worths a standalone patch since they
should apply for the whole per-vcpu mmaped regions rather than only
for the dirty ring buffers.

(Should include KVM_PIO_PAGE_OFFSET, KVM_COALESCED_MMIO_PAGE_OFFSET,
 KVM_S390_SIE_PAGE_OFFSET, kvm_run, and this new one)

Thanks,

-- 
Peter Xu

