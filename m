Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21558C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E9220674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YffjYSym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCJOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:11:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26276 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbgCJOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583849502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4VMlPSkkEaFEV/UY+CJNGIQlRtniz4tmHocOHXLHtXw=;
        b=YffjYSymLwRq2Vnn9m546Fi2mQ1vf49ASO5EuGf4jpi2xBMG4ApQJ0bROQBmj3HABPqVtw
        aORiOLCeDFgCI/7CnLR+LNP/igS3BB9VJuSBw9THSi/WYjW8kvmWfbgNDILRZ7EEfFG6AH
        0HzSDxnMd0VTS+DJmeYUidxxi7fHvF8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-MpVkm-sqPlWK073Z4yYrXA-1; Tue, 10 Mar 2020 10:11:38 -0400
X-MC-Unique: MpVkm-sqPlWK073Z4yYrXA-1
Received: by mail-qt1-f199.google.com with SMTP id o10so9161957qtk.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4VMlPSkkEaFEV/UY+CJNGIQlRtniz4tmHocOHXLHtXw=;
        b=EQPvSc9Umlg3R4tzIroxVxnFFiwDCajk4cLLdRlpzd2RUBW5EiGdq2yfPVhucD93zq
         NsUeKyrgOXYtpmyi1RkJFS40RQC9S4daCU8Jua/G+2to/vtcJGr+5M2s2KTkXXIr2tpi
         dgASmhNIbtFcIbQ5Xiyp8GrGHFo6UbZ4HnWXAS2QP86TUGElvLELLn4QgrQYVloWVLKw
         H2nO5+C8KRX8EpRR7JtCddNaVQBjy4RhJwLbX/9dtzV9jPvOsrw/QTOPDIuzcql96wRu
         P5PFH4leYrCeBmRVhLi19H1CzD53l7eQS+lW7UlgGaqafrSpBxm0x2Vdon9mm9HbLk+i
         FRUg==
X-Gm-Message-State: ANhLgQ0pTjLgHHqWyv7sna+yRdcPo4E22Ym84iBeQnDwpxVwpBYQtu6c
        UWtIHYE8zW7rTCzI9fQYGxGT0nfUDzhc9Q7yJ9PBIl5bi9gro3EXSWWwnsDuquj/NcrREzy1Ghd
        vQNYUbEgrvPkgyHncQgl46QCv
X-Received: by 2002:ad4:498c:: with SMTP id t12mr13713734qvx.27.1583849498207;
        Tue, 10 Mar 2020 07:11:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuq5Hd2E1gOPKAjD/xk0yU5tPclVVvaT0lJDm/8lSD7XYa6TVP1JdMFzrX8lvQtFIZQU5Qu7g==
X-Received: by 2002:ad4:498c:: with SMTP id t12mr13713704qvx.27.1583849497927;
        Tue, 10 Mar 2020 07:11:37 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id i4sm24289819qkf.111.2020.03.10.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:11:36 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:11:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH v5 05/14] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200310101039-mutt-send-email-mst@kernel.org>
References: <20200304174947.69595-6-peterx@redhat.com>
 <202003061911.MfG74mgX%lkp@intel.com>
 <20200309213554.GF4206@xz-x1>
 <20200310022931-mutt-send-email-mst@kernel.org>
 <20200310140921.GD326977@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310140921.GD326977@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:09:21AM -0400, Peter Xu wrote:
> On Tue, Mar 10, 2020 at 02:31:55AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Mar 09, 2020 at 05:35:54PM -0400, Peter Xu wrote:
> > > I'll probably also
> > > move KVM_DIRTY_LOG_PAGE_OFFSET==0 definition to uapi/linux/kvm.h.
> > 
> > 
> > IMHO KVM_DIRTY_LOG_PAGE_OFFSET is kind of pointless anyway - 
> > we won't be able to move data around just by changing the
> > uapi value since userspace isn't
> > recompiled when kernel changes ...
> 
> Yes I think we can even drop this KVM_DIRTY_LOG_PAGE_OFFSET==0
> definition.  IMHO it's only a matter of whether we would like to
> directly reference this value in the common code (e.g., for kernel
> virt/kvm_main.c) or we want quite a few of this instead:
> 
> #ifdef KVM_DIRTY_LOG_PAGE_OFFSET
> ..
> #endif

Hmm do other arches define it to a different value?
Maybe I'm confused.
If they do then it makes sense.

> I slightly prefer to not use lots of "#ifdef"s so I chose to make sure
> it's defined.  However I've no strong opinion on this either. So I'm
> open to change that if anyone insists with some reasons.
> 
> Thanks,
> 
> -- 
> Peter Xu

