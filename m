Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77C2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26E620720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OspgZzSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgGGUia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:38:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728347AbgGGUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594154308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMjCiC4fXOOzIsPO0KvxcCfMxXjgG381WcddzPegvjk=;
        b=OspgZzSh+09WrDVaoEsrCrk+bOWWGA0jCh1lJVYVVLfN1bfgjW5ypvcHE7otgMp8axLEMT
        O8Rl0TeicwjK+4LbH6MyplExsI8i3tZ0i9yawT+PN/8ZBWMM9TXSU1OpSZR91XjGDF3i8t
        XJUUF4q2lkcY5ddn+ifYQRODA957XWc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-X5COuLccNxujqkvCuZsU6A-1; Tue, 07 Jul 2020 16:38:26 -0400
X-MC-Unique: X5COuLccNxujqkvCuZsU6A-1
Received: by mail-qt1-f199.google.com with SMTP id s25so168838qth.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aMjCiC4fXOOzIsPO0KvxcCfMxXjgG381WcddzPegvjk=;
        b=DFHhFt9taO+fJViugvjqfQSU4s7WDZx1/ItF8uv15bD9tLzD+GPw1S/bGLpJ6uuX+8
         5rciHZHdWVhOOASI0VM7jOacBvO11tMv0bxO51jTeiB7QY1DSCpXncMXczPbjc42r8CS
         AMsW0HCWXnmvtdz3JGt9jVx5c64z/qWu9EhDo/hWmT4YBlk7g980p7eI2qzfNTlpp0NN
         WkWsVcQNI4ByFlHQOf/J1MmSfSbS3bZ0jdnsW5UV0HNEj7xc03SSQG28m92bmKIpyEO8
         lT0Y43RskEVef+1Y+hBwB18CPyjoYfhWCZThz/ePfmPLaQpDgnBNrPQBoCe8jDgGxnvE
         EIOA==
X-Gm-Message-State: AOAM532rcGngHie4IYJ/1WAP03jZ6CQiG3Uw2yyyFCywau2xAy1VdySb
        ZNrr0mWPHH8iNoXaGwVopN3KQ6M561zvXdtYrKr4vhNRbJjJPgkhS9msBkHska91N2lu61XijWd
        i1yVjzpLlOi/awvoxS5oTPiCQ
X-Received: by 2002:a0c:a8e6:: with SMTP id h38mr48101763qvc.15.1594154306096;
        Tue, 07 Jul 2020 13:38:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzleWjN2olOhhrG5haHwdKHsD0Dqr3AfHJ7k/D2DRg2L3jSRHghjGvq6xqW45fgCMAxgq8VpQ==
X-Received: by 2002:a0c:a8e6:: with SMTP id h38mr48101747qvc.15.1594154305869;
        Tue, 07 Jul 2020 13:38:25 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id n143sm23806440qkn.94.2020.07.07.13.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:38:25 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:38:23 -0400
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
Message-ID: <20200707203823.GI88106@xz-x1>
References: <20200601115957.1581250-1-peterx@redhat.com>
 <20200601115957.1581250-3-peterx@redhat.com>
 <20200702230849.GL3575@linux.intel.com>
 <20200703184122.GF6677@xz-x1>
 <20200707061732.GI5208@linux.intel.com>
 <20200707195009.GE88106@xz-x1>
 <20200707195658.GK20096@linux.intel.com>
 <20200707201508.GH88106@xz-x1>
 <20200707202623.GM20096@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707202623.GM20096@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:26:23PM -0700, Sean Christopherson wrote:
> On Tue, Jul 07, 2020 at 04:15:08PM -0400, Peter Xu wrote:
> > On Tue, Jul 07, 2020 at 12:56:58PM -0700, Sean Christopherson wrote:
> > > > > It's a single line of code, and there's more than one
> > > > > "shouldn't" in the above.
> > > > 
> > > > If you want, I can both set it and add the comment.  Thanks,
> > > 
> > > Why bother with the comment?  It'd be wrong in the sense that the as_id is
> > > always valid/accurate, even if npages == 0.
> > 
> > Sorry I'm confused.. when npages==0, why as_id field is meaningful?  Even if
> > the id field is meaningless after the slot is successfully removed, or am I
> > wrong?
> > 
> > My understanding is that after your dynamic slot work, we'll only have at most
> > one extra memslot that was just removed, and that slot should be meaningless as
> > a whole.  Feel free to correct me.
> 
> Your understanding is correct.  What I'm saying is that if something goes
> awry and the memslots need to be debugged, having accurate info for that one
> defunct memslot could be helpful, if only to not confuse a future debugger
> that doesn't fully understand memslots or address spaces.  Sure, it could be
> manually added back in for debug, but it's literally a single line of code
> to carry and it avoids the need for a special comment.

Sure, will do.  But again, I hope you allow me to add at least some comment.
To me, it's still weird to set these in a destroying memslot...

-- 
Peter Xu

