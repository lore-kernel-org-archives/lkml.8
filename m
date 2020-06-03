Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C747F206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhIZbyjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgFCF3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:29:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59641 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725792AbgFCF3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591162146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xNVdNTJykIgXntfyZGGGb9JsxUOLAT7J/N2JWA0NTcE=;
        b=XhIZbyjw8YHAsTnqE4JCNu9uJwlEngQyd05NGX8gVW3vX4gzEKfzaew+9yBkfVFdT7Cm2o
        i+PMd/QR2iGT50lqOwqPblahDpwB6looXlAx362a5gWqcpAkwyU2i17F38swmYOM9sl34Y
        sfTPgxMtjIhWrftA9xjx273YXPiaICQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-5-tMOHJ8N7e_5QZJWr4Otg-1; Wed, 03 Jun 2020 01:29:04 -0400
X-MC-Unique: 5-tMOHJ8N7e_5QZJWr4Otg-1
Received: by mail-wr1-f71.google.com with SMTP id r5so606530wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 22:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNVdNTJykIgXntfyZGGGb9JsxUOLAT7J/N2JWA0NTcE=;
        b=SOamlP+NjHmKYO6oNhTEzyurEIRdDp4NMmHQMNFDFILWgYXKIXnjjzMuDZUWGjAnwl
         nFOYSxs1nNV/WEBPFrVxs4uKC0Dj078BYzaWbxP2SeY57C1CIpytdvscyAJ1jwNUBgWW
         vXGNDNZaO/qHoRX/1a/f8vxKawXBI/YdRgdOzFcFLXBa34honZtoX+5oaCyhmDh352lr
         DJlZ6EbPOs5B/HVNsRVgQ2vPOIe9/RIslH4Ns3uHbGUzDL+bRnQnIr0rd0esyIJwM7lS
         mHIlBHjhs288wAkgVldC87xDtEWuMkdkgBAKmflADsgwT1WZRuuxqciUTjCd1FBPs2+f
         eoKw==
X-Gm-Message-State: AOAM531joe6HavVpERU3pHEZxMvZkph2b/OYDPUISyND6F8ARBTtH8gu
        IORVmh7hBahCscGWovlMUocPeU3g+YlQMapMApLsxZFb+B5OU9WZlq6u4N9pgvczNyPF91CREgs
        EM21VKee+P56vhfcsxEUQKAXk
X-Received: by 2002:a5d:5261:: with SMTP id l1mr30015740wrc.246.1591162143066;
        Tue, 02 Jun 2020 22:29:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzatHie8R5GxYMNVKDHlOh0ilfiE7KgXoOGtC9FzER3y1IyDQTbS3WNBoItX96AFMH7YDa8vA==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr30015727wrc.246.1591162142746;
        Tue, 02 Jun 2020 22:29:02 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id y5sm1588673wrs.63.2020.06.02.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 22:29:02 -0700 (PDT)
Date:   Wed, 3 Jun 2020 01:29:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200603011810-mutt-send-email-mst@kernel.org>
References: <20200602084257.134555-1-mst@redhat.com>
 <20200603014815.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603014815.GR23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 02:48:15AM +0100, Al Viro wrote:
> On Tue, Jun 02, 2020 at 04:45:05AM -0400, Michael S. Tsirkin wrote:
> > So vhost needs to poke at userspace *a lot* in a quick succession.  It
> > is thus benefitial to enable userspace access, do our thing, then
> > disable. Except access_ok has already been pre-validated with all the
> > relevant nospec checks, so we don't need that.  Add an API to allow
> > userspace access after access_ok and barrier_nospec are done.
> 
> BTW, what are you going to do about vq->iotlb != NULL case?  Because
> you sure as hell do *NOT* want e.g. translate_desc() under STAC.
> Disable it around the calls of translate_desc()?
> 
> How widely do you hope to stretch the user_access areas, anyway?

So ATM I'm looking at adding support for the packed ring format.
That does something like:


get_user(flags, desc->flags)
smp_rmb()
if (flags & VALID)
copy_from_user(&adesc, desc, sizeof adesc);


this would be a good candidate I think.






> BTW, speaking of possible annotations: looks like there's a large
> subset of call graph that can be reached only from vhost_worker()
> or from several ioctls, with all uaccess limited to that subgraph
> (thankfully).  Having that explicitly marked might be a good idea...

Sure. What's a good way to do that though? Any examples to follow?
Or do you mean code comments?


> Unrelated question, while we are at it: is there any point having
> vhost_get_user() a polymorphic macro?  In all callers the third
> argument is __virtio16 __user * and the second one is an explicit
> *<something> where <something> is __virtio16 *.  Similar for
> vhost_put_user(): in all callers the third arugment is
> __virtio16 __user * and the second - cpu_to_vhost16(vq, something).
> 
> Incidentally, who had come up with the name __vhost_get_user?
> Makes for lovey WTF moment for readers - esp. in vhost_put_user()...


Good points, I'll fix these.

-- 
MST

