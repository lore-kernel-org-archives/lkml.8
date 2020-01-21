Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3713C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794BB24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+X4o++M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgAUI3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:29:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725890AbgAUI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579595380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMCuYgplpTFtMdfBdVg8uf0WAbc/YNguxs5ss6B6JTk=;
        b=W+X4o++M0vn8tiCSPsPZHs9M9e22hj8GnyOheRudISPI2d7mTIpaHZCk6PnKXqY3i6qo+F
        t5ihiQ7iC1iS9aAyWu0+ybDoXzi52BSqxVbm0Q7mIuZA+S5rWZIhaL9VZJvJl9ZRsaHbMf
        aU6cpjNVqxfshuRaI5IYIOUoUVXojPw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-3qiFyW6pP6m7LLC8DG9t_Q-1; Tue, 21 Jan 2020 03:29:39 -0500
X-MC-Unique: 3qiFyW6pP6m7LLC8DG9t_Q-1
Received: by mail-pj1-f72.google.com with SMTP id s6so1503519pjn.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lMCuYgplpTFtMdfBdVg8uf0WAbc/YNguxs5ss6B6JTk=;
        b=DlVm2q6k78Z8Rac76uUuScqyDbvluEjdervj06h9TJpKeerUSTSP1ThZuwL5Gqbkr1
         yFj/rtIgN5N8VkS9EwqArfLdLeUpCP0WJr2EcsCMUR5kjLMQwievE11D6EaOaomQaQPd
         DwxxpQSWbPijxtRGC3oBGs9H3vp5JGSgrBe/vUIupz6SyCX9zzHcbZRfbVEoGaa3M8qq
         4a3yGPnj9D5rQzdXWDwTImFK2pdUaSAyh3Ch6ilcA7npUHLmP2wvcq5uFSMiXWo16dWT
         1RxsMkrjnuBGtpzdw/AMMEm646lLs3ebl3UTUFDTv4UocgjQ4rNfvX2xwAS49U4cFWnz
         X51A==
X-Gm-Message-State: APjAAAUvdSWMNBCY6Tq6LnnTHKGt8DQIQzLPbOXksR53BcUiGD8Bl2Gq
        +NC0a0QxvT0zSc60Cvy09R7WThmIeOHgSrpDXTl2K2nREFZeUy5gv/jMbhE3eQqjvUDcYfCBttv
        GzIywV0lYXpRgFMZ3jE9n/apq
X-Received: by 2002:a63:1e47:: with SMTP id p7mr4087873pgm.339.1579595378421;
        Tue, 21 Jan 2020 00:29:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwinOqowEa2cqxN1xgUjt7Y0/UsC42ih+JHvVIsw8rMqznKpATTe5fL6EsyFJlbih/HgXXCzQ==
X-Received: by 2002:a63:1e47:: with SMTP id p7mr4087848pgm.339.1579595378146;
        Tue, 21 Jan 2020 00:29:38 -0800 (PST)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m3sm40146819pgp.32.2020.01.21.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 00:29:37 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:29:25 +0800
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
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
Message-ID: <20200121082925.GB440822@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <22bcd5fc-338c-6b72-2bda-47ba38d7e8ef@redhat.com>
 <20200119051145-mutt-send-email-mst@kernel.org>
 <20200120072915.GD380565@xz-x1>
 <20200120024717-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120024717-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:47:46AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 20, 2020 at 03:29:15PM +0800, Peter Xu wrote:
> > On Sun, Jan 19, 2020 at 05:12:35AM -0500, Michael S. Tsirkin wrote:
> > > On Sun, Jan 19, 2020 at 10:09:53AM +0100, Paolo Bonzini wrote:
> > > > On 09/01/20 20:15, Peter Xu wrote:
> > > > > Regarding dropping the indices: I feel like it can be done, though we
> > > > > probably need two extra bits for each GFN entry, for example:
> > > > > 
> > > > >   - Bit 0 of the GFN address to show whether this is a valid publish
> > > > >     of dirty gfn
> > > > > 
> > > > >   - Bit 1 of the GFN address to show whether this is collected by the
> > > > >     user
> > > > 
> > > > We can use bit 62 and 63 of the GFN.
> > > 
> > > If we are short on bits we can just use 1 bit. E.g. set if
> > > userspace has collected the GFN.
> > 
> > I'm still unsure whether we can use only one bit for this.  Say,
> > otherwise how does the userspace knows the entry is valid?  For
> > example, the entry with all zeros ({.slot = 0, gfn = 0}) could be
> > recognized as a valid dirty page on slot 0 gfn 0, even if it's
> > actually an unused entry.
> 
> So I guess the reverse: valid entry has bit set, userspace sets it to
> 0 when it collects it?

Right, this seems to work.

Thanks,

-- 
Peter Xu

