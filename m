Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832FC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C79206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f++UMzw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgD1UWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:22:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54203 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgD1UWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588105354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=voGLyeD1WxfVMgEf4Mai58JZB/u+WPmTGh+LxkJS5LU=;
        b=f++UMzw5p5A+zZhSYzvxyBZbXs9d/reeXczk6fU8XZZ5pmlGBS27A7lhQi6wbHdteHc06F
        Mwz/PD6qLvUWPv/FCN79A/qI+iWSNBvm7KXT8ALj5KHueXmNKIzQhwbOV8SweS33B8C3qF
        ViegAgm+18AdIuhRVafkuiz5OLqjKOI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-QsdrZyw3NquT1tLO2ARKcQ-1; Tue, 28 Apr 2020 16:22:32 -0400
X-MC-Unique: QsdrZyw3NquT1tLO2ARKcQ-1
Received: by mail-qt1-f200.google.com with SMTP id n22so25940215qtp.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=voGLyeD1WxfVMgEf4Mai58JZB/u+WPmTGh+LxkJS5LU=;
        b=FGrN74JigIcTPXTepd9OUEo7DfQNG2xVEZzmz0VzXm2Y57rYtjhJCp8CJL0JbuwY9p
         YzsaQ29a1Fb/3fVwhIh+EwizDijHFdzPjyrpmVPKPY3NkS7+xvLyHWBfHZgMtsju+x7W
         fMHwJP5rmXBJ0orNBtbp+1fX2gB5OgMM9c6rFgqvOlAWl+1cukVvBtN4UFbRyybzVP/E
         4HfCqjHDRHfwuTTvsHZXRVjERmhcqMfPsyCB/BMcPWmApfAxNhGwa7J1T2gq4mu+yccO
         rM2pBII3EBNE6THzqBg8r8AbnRRSvQgVhvqcKyM2APJ3XkO1t2F7iQzddnmhV3+ScVSp
         nDOQ==
X-Gm-Message-State: AGi0PubXiFxlgXJe8IhBsP0sNdYF+3nPGn3Dm18wZF0fCkfNIAp2vc6/
        gNRaq7Qv7O/WDQrLXMpvnxJQEHa6/WBSBzNvPKtE4VkHYwKwt7VcqrPYDinbirZ5r3vIFW33gWw
        f4cqn/QX/vM5F0492RZ81luqJ
X-Received: by 2002:a37:66d8:: with SMTP id a207mr28461418qkc.127.1588105351220;
        Tue, 28 Apr 2020 13:22:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypK+LsYsK4GPD3bREyTNhokuLO2gi/E05ejK2hXFbJea8Bo086oicUgNv17RFKAAPIkQ+byHkg==
X-Received: by 2002:a37:66d8:: with SMTP id a207mr28461388qkc.127.1588105350974;
        Tue, 28 Apr 2020 13:22:30 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id x24sm14925754qth.80.2020.04.28.13.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:22:30 -0700 (PDT)
Date:   Tue, 28 Apr 2020 16:22:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v8 03/14] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200428202228.GB4280@xz-x1>
References: <20200331190000.659614-1-peterx@redhat.com>
 <20200331190000.659614-4-peterx@redhat.com>
 <20200423203944.GS17824@linux.intel.com>
 <20200424152151.GB41816@xz-x1>
 <20200427181054.GL14870@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200427181054.GL14870@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:10:54AM -0700, Sean Christopherson wrote:

[...]

> > It will "return (0xdeadull << 48)" as you proposed in abbed4fa94f6? :-)
> > 
> > Frankly speaking I always preferred zero but that's just not true any more
> > after above change.  This also reminded me that maybe we should also return the
> > same thing at [1] below.
> 
> Ah, I was looking at this code:
> 
> 	if (!slot || !slot->npages)
> 		return 0;
> 
> That means deletion returns different success values for "deletion was a
> nop" and "deletion was successful".  The nop path should probably return
> (or fill in) "(unsigned long)(0xdeadull << 48)" as well.

Yep.  Since I touched the line here after all, I'll directly squash this small
fix into this patch too when I repost.  Thanks,

[...]

> > > 
> > > >  	} else {
> > > >  		if (!slot || !slot->npages)
> > > > -			return 0;
> > > > +			return ERR_PTR_USR(0);
> > 
> > [1]

-- 
Peter Xu

