Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE79C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD62420780
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VijpbEx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgCWQQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:16:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35062 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbgCWQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584980193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IYrLYvqnGZEV23VKew7hMTB9MLlxza06argJ9Y4MphY=;
        b=VijpbEx1sJLsDOOMoOR5ARqJrAdHi9pTk1gBgUL8gYCCsm6A8LnZ23AGHOHmIW6Uh6GD+z
        IlVxsoYtOI0Kl2B6W43Ikzi/Y5ZdaQYtTN5qB1dSqV0wiq9nQaPzaJAwA6PiJAoN/kap5W
        PfQd9TxorXNB9c4m5PFQ8dvPVkd/Yys=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-BF0C9nH5P0atuVcAFBB7uQ-1; Mon, 23 Mar 2020 12:16:31 -0400
X-MC-Unique: BF0C9nH5P0atuVcAFBB7uQ-1
Received: by mail-wm1-f72.google.com with SMTP id y1so22238wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IYrLYvqnGZEV23VKew7hMTB9MLlxza06argJ9Y4MphY=;
        b=Jf4O1Xt+xUTM4dYoWN5+CRtFeNnb8TDaQzCRSdJTQLHuPFf3f5aVbixgboWkztoyqG
         g20tCyvA+qL5Q0B8C1MxCURjFlNA6+uEDP0dGVdf3K6eF0cjpvBEZaIGfQApIy6foRJe
         OjMQlZY4jPy3XjYbg5oDyeRDVLngaH3AvXbReFegavH/PaQcTlgcA/ze1QZ31wavpngZ
         qKBnvNzcWjCPxCIdJvZXc839bmeUYzY9+XbN2SdRfA1VYqOi52QF3j5NiZyoE0luwhMK
         4xYygNxSn2T6mi+ZHPMl37Cx/YS8VtwfUHhUOy8CHFDBLyy9WQvQ3CQ3Juz7O3oIl4yr
         KvFA==
X-Gm-Message-State: ANhLgQ0DuqkfEiYJsDDO1uJdrQAreqwMBGTXQ8q6hpXUyfXipZaqQFVR
        cFGT6BiFfSWmSk2oMy6SMeb/VnvpprIZcMrD6Pumklk97E3KYKyxsastWnmx+g3DPiaKjNfTTpG
        ebFJUZG5nwLMIaAyBc5HKNCqN
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr28227557wro.32.1584980190356;
        Mon, 23 Mar 2020 09:16:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvbW0tcdx3bsp/p23/luhT8S5W7BBOXb4FD91QyavWn3XWwFNHTv4rOmubmFt012JdzIk11aA==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr28227526wro.32.1584980190068;
        Mon, 23 Mar 2020 09:16:30 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id s7sm23648472wro.10.2020.03.23.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:16:29 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:16:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 06/14] KVM: Make dirty ring exclusive to dirty bitmap
 log
Message-ID: <20200323161626.GJ127076@xz-x1>
References: <20200318163720.93929-1-peterx@redhat.com>
 <20200318163720.93929-7-peterx@redhat.com>
 <20200321191250.GB13851@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321191250.GB13851@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 12:12:50PM -0700, Sean Christopherson wrote:
> On Wed, Mar 18, 2020 at 12:37:12PM -0400, Peter Xu wrote:
> > There's no good reason to use both the dirty bitmap logging and the
> > new dirty ring buffer to track dirty bits.  We should be able to even
> > support both of them at the same time, but it could complicate things
> > which could actually help little.  Let's simply make it the rule
> > before we enable dirty ring on any arch, that we don't allow these two
> > interfaces to be used together.
> > 
> > The big world switch would be KVM_CAP_DIRTY_LOG_RING capability
> > enablement.  That's where we'll switch from the default dirty logging
> > way to the dirty ring way.  As long as kvm->dirty_ring_size is setup
> > correctly, we'll once and for all switch to the dirty ring buffer mode
> > for the current virtual machine.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  Documentation/virt/kvm/api.rst |  7 +++++++
> >  virt/kvm/kvm_main.c            | 12 ++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 99ee9cfc20c4..8f3a83298d3f 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6202,3 +6202,10 @@ make sure all the existing dirty gfns are flushed to the dirty rings.
> >  
> >  The dirty ring can gets full.  When it happens, the KVM_RUN of the
> >  vcpu will return with exit reason KVM_EXIT_DIRTY_LOG_FULL.
> > +
> > +NOTE: the KVM_CAP_DIRTY_LOG_RING capability and the new ioctl
> 
> Leave off "new", it'll be stale a few months/years from now.

Ok.

> 
> > +KVM_RESET_DIRTY_RINGS are exclusive to the existing KVM_GET_DIRTY_LOG
> 
> Did you mean "mutually exclusive with"?  "exclusive to" would mean they
> can only be used by KVM_GET_DIRTY_LOG with doesn't match the next
> sentence.

I meant "mutual-exclusive".  I'll fix it up.

Thanks,

-- 
Peter Xu

