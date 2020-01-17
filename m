Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E58C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4272F20730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwmqNV3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAQJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:51:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55881 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgAQJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579254658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYd4XcpTB2WmAb9JpP9U+6d1Bzc5qT6nYxXsqhauuYY=;
        b=SwmqNV3n9XqABMdeYmONREnv2Wi5vstcEkzcBOhSImQ0RhDBF6qPCa0uLtGD3W1cijdJAL
        y2vW80qGORmaF1kPAqDUi2e7cazTIMVuFDqvfiSk8SNtXNpnDbAuBAjs0POp1nzelpcpT5
        QKFjflfZCjQAheGLGEKyTd0PCYGJgpA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-FfZtS8XxNBmxYw9VpP1Ghg-1; Fri, 17 Jan 2020 04:50:55 -0500
X-MC-Unique: FfZtS8XxNBmxYw9VpP1Ghg-1
Received: by mail-qt1-f198.google.com with SMTP id b7so15603837qtg.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYd4XcpTB2WmAb9JpP9U+6d1Bzc5qT6nYxXsqhauuYY=;
        b=P4BYpc+OG85qrqLcarkgKIKtBgm5rXhV4b63DrglMK+v07Xpm6poET42az+KJsATgw
         +ANeZc2NOxIyI6eaZkVI/nerVJJjQpsOedJAKGWtsqc9pgiEXjyLHma5sOUePoUwR9/K
         kSaatCqwoSZFic/wIVIvJG38KWSt4eYTzrdJ5KtBQQQIU1tA7EzW8DbAMM/nU6Seib7D
         lL9iok3cQvrAyhTgUmuktjUBz+fgAWPNyYKXqs/QFZDVxsBe/n1LCB8Dkr2pB4cSVlNc
         rTBMPonzozNcKi4n9LFuz04XrXY5LbwAvE08hGzxlZJ1K3kNHpuvcfNhQ+UeuB0XqokY
         oVKQ==
X-Gm-Message-State: APjAAAVm/fO6BRqu6p+kUk5T3Xv6lsPsvv70aQQLuJdWA5BpdKEetgsf
        N6ObYFE0ju2s5LlTxSVzsuieTVZhvgptJySl1JBD/tmGru8fGUMKvw+qxzfHnMzBBRJcBaKsKHW
        f/m8zEAzwRUwzQ2ZZEWN0YAKp
X-Received: by 2002:a37:a70b:: with SMTP id q11mr32130070qke.393.1579254655347;
        Fri, 17 Jan 2020 01:50:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPk0EzmH8BB5RmxgtwTU30bMvpsJqk/7qLf7iaQA6f+J68LLqTM68sZN85WrQckS6a24uP8w==
X-Received: by 2002:a37:a70b:: with SMTP id q11mr32130048qke.393.1579254655163;
        Fri, 17 Jan 2020 01:50:55 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id t38sm12968064qta.78.2020.01.17.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:50:54 -0800 (PST)
Date:   Fri, 17 Jan 2020 04:50:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200117045019-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200116033725-mutt-send-email-mst@kernel.org>
 <20200116162703.GA344339@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116162703.GA344339@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:27:03AM -0500, Peter Xu wrote:
> On Thu, Jan 16, 2020 at 03:38:21AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2020 at 09:57:20AM -0500, Peter Xu wrote:
> > > +	/* If to map any writable page within dirty ring, fail it */
> > > +	if ((kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff) ||
> > > +	     kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff + pages - 1)) &&
> > > +	    vma->vm_flags & VM_WRITE)
> > > +		return -EINVAL;
> > 
> > Worth thinking about other flags. Do we want to force VM_SHARED?
> > Disable VM_EXEC?
> 
> Makes sense to me.  I think it worths a standalone patch since they
> should apply for the whole per-vcpu mmaped regions rather than only
> for the dirty ring buffers.
> 
> (Should include KVM_PIO_PAGE_OFFSET, KVM_COALESCED_MMIO_PAGE_OFFSET,
>  KVM_S390_SIE_PAGE_OFFSET, kvm_run, and this new one)
> 
> Thanks,


I don't think we can change UAPI for existing ones.
Userspace might be setting these by mistake.

> -- 
> Peter Xu

