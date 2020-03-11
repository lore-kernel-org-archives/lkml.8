Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A41C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2ECE20734
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIeUlHsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgCKRo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:44:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25924 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730385AbgCKRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583948667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Egr0Wvsijd8a/sAsIii/kuR4HDSloQdA1QBM06VTEsc=;
        b=OIeUlHsj5qzDAcuJIWpGxRv5AcMqbdE1+6ui2DcXYMSOXb52CEt8bBH1lSq4g98HClYttN
        6HMmwV7vlu0LT3dfAfvdgRg4btdV9K4UxcpcWhR6ds1RsJp2orRWj0+EI0g9G0/Y6t9ltB
        okLlXCHyFSYyXAZ+M//1t/5p76LmIAE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-jqhHfW7vMCSLRtoVSGC1bw-1; Wed, 11 Mar 2020 13:44:25 -0400
X-MC-Unique: jqhHfW7vMCSLRtoVSGC1bw-1
Received: by mail-qt1-f200.google.com with SMTP id d2so1709232qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Egr0Wvsijd8a/sAsIii/kuR4HDSloQdA1QBM06VTEsc=;
        b=bjBfxchO1HWdFA7wmQHkVzaKZil5bQtIpWb2MSYFBHPOqocgIRQnsrGTaI1U7LXr2h
         DyCZJyEXIJAYG+sAb12xum55st5Dh7iFfM3rttDIYpZLojuFUJTzY5ulT74zTUiTulm5
         FJkYBwxM9yn/7NR46CTtWwItDpg7nVBnGuRzlsZfVYRAtvUoPJk1sDf6kkkXbcN2vW8l
         y6t1HmJSIXM03DtMvNci6XbNyha9S52dhTHWa1m+gCtAf+JfogNES2yPU5wu6IDYnbgU
         jwSUqoVcBntATTahWTzvN+aIifOlF1p/GOsExG3AFLTqTwwsNjwPRyFWYtQwgNaPCg9j
         l0VA==
X-Gm-Message-State: ANhLgQ2DHU68LFhbMHcq4L4/AnLeF/RNPqx3DDKaCDqB7cZRXqaAaRH/
        ZiuG7sfThGeQLscM12QkZ/RR+L9Eg+O28PTWVd27JXe4FDTJyvPi6hkI2TOuvkkI/FPbQ3hHA9p
        J6aWZKL0UOrw+3b4HhZkzY0nL
X-Received: by 2002:ac8:45d6:: with SMTP id e22mr3754081qto.34.1583948665095;
        Wed, 11 Mar 2020 10:44:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvGjzKVXYRhk/h7ikNvjVRLCg8NW9Tm42+Z//BzMUUJ3eGevXv4paQogeanWo2CnV941bKdsg==
X-Received: by 2002:ac8:45d6:: with SMTP id e22mr3754054qto.34.1583948664740;
        Wed, 11 Mar 2020 10:44:24 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d201sm5220436qke.59.2020.03.11.10.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:44:24 -0700 (PDT)
Date:   Wed, 11 Mar 2020 13:44:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 12/14] KVM: selftests: Add dirty ring buffer test
Message-ID: <20200311174422.GI479302@xz-x1>
References: <20200309214424.330363-1-peterx@redhat.com>
 <20200309222529.345699-1-peterx@redhat.com>
 <20200310081847.42sx5oc3q6m3wsdj@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310081847.42sx5oc3q6m3wsdj@kamzik.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 09:18:47AM +0100, Andrew Jones wrote:
> On Mon, Mar 09, 2020 at 06:25:29PM -0400, Peter Xu wrote:
> > +void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid)
> > +{
> > +	struct vcpu *vcpu;
> > +	uint32_t size = vm->dirty_ring_size;
> > +
> > +	TEST_ASSERT(size > 0, "Should enable dirty ring first");
> > +
> > +	vcpu = vcpu_find(vm, vcpuid);
> > +
> > +	TEST_ASSERT(vcpu, "Cannot find vcpu %u", vcpuid);
> > +
> > +	if (!vcpu->dirty_gfns) {
> > +		void *addr;
> > +
> > +		addr = mmap(NULL, size, PROT_READ,
> > +			    MAP_PRIVATE, vcpu->fd,
> > +			    vm->page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
> > +		TEST_ASSERT(addr == MAP_FAILED, "Dirty ring mapped private");
> > +
> > +		addr = mmap(NULL, size, PROT_READ | PROT_EXEC,
> > +			    MAP_PRIVATE, vcpu->fd,
> > +			    vm->page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
> > +		TEST_ASSERT(addr == MAP_FAILED, "Dirty ring mapped exec");
> > +
> > +		addr = mmap(NULL, size, PROT_READ | PROT_WRITE,
> > +			    MAP_SHARED, vcpu->fd,
> > +			    vm->page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
> 
> No TEST_ASSERT for this mmap?

It'll be used (verified) later. :) Though never harm to add one!

Thanks,
> 
> > +
> > +		vcpu->dirty_gfns = addr;
> > +		vcpu->dirty_gfns_count = size / sizeof(struct kvm_dirty_gfn);
> > +	}
> > +
> > +	return vcpu->dirty_gfns;
> > +}
> 

-- 
Peter Xu

