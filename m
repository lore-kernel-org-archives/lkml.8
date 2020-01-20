Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F62C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39042207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsd9NCBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgATH3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:29:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbgATH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579505373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jI34RrcUPMd0jM0u87vFiLfbd5SdFZjWwVYjwdRJHw4=;
        b=dsd9NCBylj26Ow2sgsHjjq19UnP8OEP9GaLgfCgCBwgAo76/LqRMm2+0qdGSPCyQU5zMzu
        YkJj36bNVa38f/NNVytlXvdfXRdftxYjm03DO0nIxSB7HcMaCPVYBGxAENdZozC1BJ5+m7
        TuwQ/6M1DI1XM1ZmI/pFeqEoqT/rhQw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-p10zCZTiP4urzwb9-IPERQ-1; Mon, 20 Jan 2020 02:29:29 -0500
X-MC-Unique: p10zCZTiP4urzwb9-IPERQ-1
Received: by mail-pl1-f200.google.com with SMTP id f10so13887284plr.21
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jI34RrcUPMd0jM0u87vFiLfbd5SdFZjWwVYjwdRJHw4=;
        b=ZlWBcuPKeCqzD13xr8Ud6T6gagwNy2vbArht0cSHvIGzAMlglW2+RdJcd2NoWlxzpF
         VrW774N4qOUC1BcjY4hF0n/WTetEgFLRO0uSpLZtFq0JTqFT+kVoIXXLWyxXcwQhvytb
         jASntaVV6Q49MmGvJ39l89AEL1nWSnkKmUR19vN1hMStorvT163HgKLYrR/XQ2HPAE7T
         gWEjXqTFMt74en0RU8XK+IH1/taUOEosDDUhWAiXLNsdfXxvZUT9H8WSkNQxCEK46pme
         MJJNycatQluRY+WGWukGok4TCzZQo/mgA4ZLp9BrvlkXMl37pE1hddyxRJPT+ZL5cxvP
         d96Q==
X-Gm-Message-State: APjAAAV5OkYpyXdT0H7b02rqcRsGRLjL1faszrsxcU/9s6f3oVwM365s
        Sx7YsvWbT3b1LSP66TxVGJICPHVlGcgYRld+PUCysd3jSTm+mkwVC5E8trr1rJAGyr78jCH6jEI
        eZkwCCk7JVR7s8KAS/Z9iDcZg
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr13987758plp.324.1579505368988;
        Sun, 19 Jan 2020 23:29:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPyolAukpA6MYI9Ufq/PRLUWLhID+YoT4UYIEQRyTCrxIEsEGeooxUbVvLw9NC5i1u7Tgb6w==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr13987732plp.324.1579505368730;
        Sun, 19 Jan 2020 23:29:28 -0800 (PST)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j9sm37663567pfn.152.2020.01.19.23.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:29:27 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:29:15 +0800
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
Message-ID: <20200120072915.GD380565@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <22bcd5fc-338c-6b72-2bda-47ba38d7e8ef@redhat.com>
 <20200119051145-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200119051145-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 05:12:35AM -0500, Michael S. Tsirkin wrote:
> On Sun, Jan 19, 2020 at 10:09:53AM +0100, Paolo Bonzini wrote:
> > On 09/01/20 20:15, Peter Xu wrote:
> > > Regarding dropping the indices: I feel like it can be done, though we
> > > probably need two extra bits for each GFN entry, for example:
> > > 
> > >   - Bit 0 of the GFN address to show whether this is a valid publish
> > >     of dirty gfn
> > > 
> > >   - Bit 1 of the GFN address to show whether this is collected by the
> > >     user
> > 
> > We can use bit 62 and 63 of the GFN.
> 
> If we are short on bits we can just use 1 bit. E.g. set if
> userspace has collected the GFN.

I'm still unsure whether we can use only one bit for this.  Say,
otherwise how does the userspace knows the entry is valid?  For
example, the entry with all zeros ({.slot = 0, gfn = 0}) could be
recognized as a valid dirty page on slot 0 gfn 0, even if it's
actually an unused entry.

> 
> > I think this can be done in a secure way.  Later in the thread you say:
> > 
> > > We simply check fetch_index (sorry I
> > > meant this when I said reset_index, anyway it's the only index that we
> > > expose to userspace) to make sure:
> > > 
> > >   reset_index <= fetch_index <= dirty_index
> > 
> > So this means that KVM_RESET_DIRTY_RINGS should only test the "collected
> > by user" flag on dirty ring entries between reset_index and dirty_index.
> > 
> > Also I would make it
> > 
> >    00b (invalid GFN) ->
> >      01b (valid gfn published by kernel, which is dirty) ->
> >        1*b (gfn dirty page collected by userspace) ->
> >          00b (gfn reset by kernel, so goes back to invalid gfn)
> > That is 10b and 11b are equivalent.  The kernel doesn't read that bit if
> > userspace has collected the page.

Yes "1*b" is good too (IMHO as long as we can define three states for
an entry).  However do you want me to change to that?  Note that I
still think we need to read the rest of the field (in this case,
"slot" and "gfn") besides the two bits to do re-protect.  Should we
trust that unconditionally if writable?

Thanks,

-- 
Peter Xu

