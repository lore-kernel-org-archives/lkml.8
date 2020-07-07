Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B33DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3495321532
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apf3Li20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGGUPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:15:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49507 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728067AbgGGUPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594152913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DYtZMNoSH5tT3xKArGRPbFktJPFGX2LErV9OGvxddAA=;
        b=apf3Li20M8Lr959frlWMsrts4PNcgfb2qhLxUnhJ0fi2UQOeb+XlKj0dDfrQWnvVTvLO4S
        f9DZ4Hb59Y/pyooPqAsjF4heipHXCctzB43GAz3zxmkpqboL8XQsIPMMDg1P3LeSH69jPc
        HCF1zAYQU3DCE4ZLqJpGGAn3nrFjwls=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-cUH1IXlXMUSU-zpRbubvOg-1; Tue, 07 Jul 2020 16:15:11 -0400
X-MC-Unique: cUH1IXlXMUSU-zpRbubvOg-1
Received: by mail-qt1-f200.google.com with SMTP id r25so31513433qtj.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DYtZMNoSH5tT3xKArGRPbFktJPFGX2LErV9OGvxddAA=;
        b=jD5G5y2VrW25WrG6224yc79mVGDPLueG2pP7PlzYXfb3l1iXJfBcIF/epXzj0MTIwx
         UyPoFM8hZ0syz3QXHW0pKd422WwEuhovAiiPbqLDgVaRbRiDRqa/aGqEs53RLRBsqhDY
         AVCvNvadPL82JJjOmbkkOOhDZAVHCyPHt4iOuB04gfTlrNCJMP860/2C8gq0J9fLrfRn
         5s+fWmQZltNLy1TnWJHy2cz/LXwZCng3xlsnXkLarXKwqmV2e0AoJVMt+zEPlJuErR5S
         QD/4EDqkKtmCXTaZvr2lacJfUno8KbHx04zMxk/RTPktUrY96quzJdGOFMbIBlr7YjUm
         WX6A==
X-Gm-Message-State: AOAM533nsuE8IioeQbQXIjCso8FBtLx9MI8YeGSQQItVLO/f4WxE3vWo
        PVRiKPDGRUc2oTIDxW7yArjdcPwdyT9vYlAUQ+xY5yQcliHe64cb4hCeZLpqRbjhmGmo57RkBFr
        ZSziTNWgW38iDA7t8yrvL32Nl
X-Received: by 2002:a37:7ec1:: with SMTP id z184mr52466868qkc.185.1594152911004;
        Tue, 07 Jul 2020 13:15:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymaqFNwY67jxYXAjVi4pHOd20KFZ9k9uKRFyhRphB+5xxP+YZ4ehh2D+MYuYBMhFJYol+BhA==
X-Received: by 2002:a37:7ec1:: with SMTP id z184mr52466842qkc.185.1594152910791;
        Tue, 07 Jul 2020 13:15:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v12sm27518581qtj.32.2020.07.07.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:15:10 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:15:08 -0400
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
Message-ID: <20200707201508.GH88106@xz-x1>
References: <20200601115957.1581250-1-peterx@redhat.com>
 <20200601115957.1581250-3-peterx@redhat.com>
 <20200702230849.GL3575@linux.intel.com>
 <20200703184122.GF6677@xz-x1>
 <20200707061732.GI5208@linux.intel.com>
 <20200707195009.GE88106@xz-x1>
 <20200707195658.GK20096@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707195658.GK20096@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 12:56:58PM -0700, Sean Christopherson wrote:
> > > It's a single line of code, and there's more than one
> > > "shouldn't" in the above.
> > 
> > If you want, I can both set it and add the comment.  Thanks,
> 
> Why bother with the comment?  It'd be wrong in the sense that the as_id is
> always valid/accurate, even if npages == 0.

Sorry I'm confused.. when npages==0, why as_id field is meaningful?  Even if
the id field is meaningless after the slot is successfully removed, or am I
wrong?

My understanding is that after your dynamic slot work, we'll only have at most
one extra memslot that was just removed, and that slot should be meaningless as
a whole.  Feel free to correct me.

-- 
Peter Xu

