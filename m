Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FAFC33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1491207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggdLx6MG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgATHr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:47:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51689 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgATHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579506476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DRxgwdNfsPjpaqCnob500hqCEgh7ZacCIxaAxxV7tMc=;
        b=ggdLx6MGMjMwo0+7H2ug9tQPC3LQsXtfK5iy6UwHKvf8rStcmA3GtEloz+ZLb5BlSujeKS
        sd/D26zaOU2zRn67i/Jxf3P7jDF7U5Ydx1mUaaZhQl1Bc09yBnD/0KVHijGuW2owo1z0Nw
        K6KMchosMPaLHyxsZzPfQHrP9LSpmcM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-61dsQsstPtC5zn8NuS9_Lg-1; Mon, 20 Jan 2020 02:47:53 -0500
X-MC-Unique: 61dsQsstPtC5zn8NuS9_Lg-1
Received: by mail-qk1-f199.google.com with SMTP id 24so19892373qka.16
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRxgwdNfsPjpaqCnob500hqCEgh7ZacCIxaAxxV7tMc=;
        b=GtILMTdgy5B00eqce5dns80afQpCwrUyfAJ8YX0qx7CodviDRo8G5X48HQ2Mt/ebq2
         grNvTYcMVyVvmH6KgBv6RvDHkMMYx0Wr7K9BvglYDiRveU5QIjKfDIDWVQPMod16Uo3L
         ocf8CXnQN0xN8Nqj7FG0co87S3HbB0DJTjMXGXX5p0D1JFVi5Kdnj99KHnVgN3i/tNDs
         nAsadad9bPfvANRGf9HbDBEzIQ4024JqF7iFVL7BYWmaT1kmmZie9ZAZ8goSLVs2yW+o
         0r/VYRX72GO/Ldwk72ExOh/Gwnep52juFOOrNv+ws07ZQihP0vE8LcmAzhHJiPkKT93t
         yxmA==
X-Gm-Message-State: APjAAAW31ID+O7BxwJVUMYO0H5B6c1CkEqrJGng5K5govFHw0tl6WI8I
        n0Vxnnz7Nrc3fLa2YOA+9Rv6iVY/W7yTxdRjZBak+9ECSKvrf4DtFurfpTrHYAyYm8F89z82boD
        02+O9Rz8n8U0FONjGK+U28MRn
X-Received: by 2002:ad4:52cb:: with SMTP id p11mr19032837qvs.40.1579506473109;
        Sun, 19 Jan 2020 23:47:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEtY1SIzk7pMswk1YUQyizl2SeTF2C4wWLaIi1wnQRoKNrV6mfhMbDyW+/x5CqEr86nb11+g==
X-Received: by 2002:ad4:52cb:: with SMTP id p11mr19032827qvs.40.1579506472874;
        Sun, 19 Jan 2020 23:47:52 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id q126sm15453824qkd.21.2020.01.19.23.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:47:52 -0800 (PST)
Date:   Mon, 20 Jan 2020 02:47:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200120024717-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <22bcd5fc-338c-6b72-2bda-47ba38d7e8ef@redhat.com>
 <20200119051145-mutt-send-email-mst@kernel.org>
 <20200120072915.GD380565@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120072915.GD380565@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:29:15PM +0800, Peter Xu wrote:
> On Sun, Jan 19, 2020 at 05:12:35AM -0500, Michael S. Tsirkin wrote:
> > On Sun, Jan 19, 2020 at 10:09:53AM +0100, Paolo Bonzini wrote:
> > > On 09/01/20 20:15, Peter Xu wrote:
> > > > Regarding dropping the indices: I feel like it can be done, though we
> > > > probably need two extra bits for each GFN entry, for example:
> > > > 
> > > >   - Bit 0 of the GFN address to show whether this is a valid publish
> > > >     of dirty gfn
> > > > 
> > > >   - Bit 1 of the GFN address to show whether this is collected by the
> > > >     user
> > > 
> > > We can use bit 62 and 63 of the GFN.
> > 
> > If we are short on bits we can just use 1 bit. E.g. set if
> > userspace has collected the GFN.
> 
> I'm still unsure whether we can use only one bit for this.  Say,
> otherwise how does the userspace knows the entry is valid?  For
> example, the entry with all zeros ({.slot = 0, gfn = 0}) could be
> recognized as a valid dirty page on slot 0 gfn 0, even if it's
> actually an unused entry.

So I guess the reverse: valid entry has bit set, userspace sets it to
0 when it collects it?


> > 
> > > I think this can be done in a secure way.  Later in the thread you say:
> > > 
> > > > We simply check fetch_index (sorry I
> > > > meant this when I said reset_index, anyway it's the only index that we
> > > > expose to userspace) to make sure:
> > > > 
> > > >   reset_index <= fetch_index <= dirty_index
> > > 
> > > So this means that KVM_RESET_DIRTY_RINGS should only test the "collected
> > > by user" flag on dirty ring entries between reset_index and dirty_index.
> > > 
> > > Also I would make it
> > > 
> > >    00b (invalid GFN) ->
> > >      01b (valid gfn published by kernel, which is dirty) ->
> > >        1*b (gfn dirty page collected by userspace) ->
> > >          00b (gfn reset by kernel, so goes back to invalid gfn)
> > > That is 10b and 11b are equivalent.  The kernel doesn't read that bit if
> > > userspace has collected the page.
> 
> Yes "1*b" is good too (IMHO as long as we can define three states for
> an entry).  However do you want me to change to that?  Note that I
> still think we need to read the rest of the field (in this case,
> "slot" and "gfn") besides the two bits to do re-protect.  Should we
> trust that unconditionally if writable?
> 
> Thanks,
> 
> -- 
> Peter Xu

