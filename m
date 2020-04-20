Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C3EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEC720B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/+vovtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgDTOQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:16:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDTOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587392178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JkxIFVIohEorxeTZe98++uLsQqk7YmDIx4Z7KvJXfYk=;
        b=J/+vovtH4rUFhy1acS3xf4cXditJ6DyOfYzH0wHtbd8mBrZZZWBw2LErnFHPtLcUseW8Pc
        R5TEJAvI4Ied6rVXUK7oOGRmW5gvmGUoYbSt68dLsaSsurj2JYnp1NpCXDpuRF3q9k7zpe
        QipqJ2id23oTrCvRdnA2qRDYknPOYh4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-dqDXe1FfMOuflb79c-ZSwQ-1; Mon, 20 Apr 2020 10:16:16 -0400
X-MC-Unique: dqDXe1FfMOuflb79c-ZSwQ-1
Received: by mail-wr1-f69.google.com with SMTP id r17so5763433wrg.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JkxIFVIohEorxeTZe98++uLsQqk7YmDIx4Z7KvJXfYk=;
        b=Hp1a2ZVR8o4JWbqIafsVIHZFt85h5c0YUTcEI2zrES0NSeXTEyLTULBIaOd2DNn10K
         cyFkHdswkydGWxksmDlox1xah5XnYu7tfCRSuCQ4cbkN598W0gPkVA+JVut7LmPXoHde
         GX9uRG4dnGOa/eNoYkMZYV/KEXdGb7XuH1s79i4VXi6ToYPn49zC8dSnw3xC79RyNuky
         FUBIiLU3ZICxCNCazYur4DmvAUkanVvkJ1UwHjlE5CiIUIhxkBOYCfthts3AZwTcCagx
         bt29PFFBPE/YfYNA9MJlAlyh/Jl45hoDmXSty7jyWl0ubzwCVbotWpC5naPeuDnZEnvW
         ksnQ==
X-Gm-Message-State: AGi0Pubk+gaD7sMPz9dnp5yOWSvAmEluRuuKzbqFH7cO5El/HMhccGkB
        ZdFX888dF8YLx1fN3q0TGqIbOvJpiJbaW6vr32VEpQPNYDFgrErYASEo1KOTn6eulO6k43KSaQQ
        RaBiL9QmHXj7p1+MY+9S90g6C
X-Received: by 2002:adf:aa92:: with SMTP id h18mr16805516wrc.20.1587392175530;
        Mon, 20 Apr 2020 07:16:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypILEROI3x8fort+5bkMx0TZQmQ1zQlGbT1pp1O6iljI2XwZ+SmO3RgUlnhFtDZnZ7lv8EOcYQ==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr16805492wrc.20.1587392175345;
        Mon, 20 Apr 2020 07:16:15 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id f18sm1432047wrq.29.2020.04.20.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 07:16:14 -0700 (PDT)
Date:   Mon, 20 Apr 2020 10:16:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3] vhost: disable for OABI
Message-ID: <20200420101511-mutt-send-email-mst@kernel.org>
References: <20200416221902.5801-1-mst@redhat.com>
 <20200420082909.GA28749@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420082909.GA28749@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 01:29:09AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 16, 2020 at 06:20:20PM -0400, Michael S. Tsirkin wrote:
> > vhost is currently broken on the some ARM configs.
> > 
> > The reason is that that uses apcs-gnu which is the ancient OABI that is been
> > deprecated for a long time.
> > 
> > Given that virtio support on such ancient systems is not needed in the
> > first place, let's just add something along the lines of
> > 
> > 	depends on !ARM || AEABI
> > 
> > to the virtio Kconfig declaration, and add a comment that it has to do
> > with struct member alignment.
> > 
> > Note: we can't make VHOST and VHOST_RING themselves have
> > a dependency since these are selected. Add a new symbol for that.
> 
> This description is horrible.  The only interesting thing for ARM OABI
> is that it has some strange padding rules, but that isn't something
> that can't be handled.   Please spend some time looking into the issue
> and add te proper __padded annotations, we've done that elsewhere in
> the kernel and it isn't too bad - in fact it helps understanding issues
> with implicit alignment.

Yes I have a patch queued to fix it. I wanted a minimal patch for this
release though.

> And even if you have a good reason not to fix vhost (which I think you
> don't have) this changelog is just utter crap, as it fails to mention
> what the problem with ARM OABI even is.

I'll tweak that, thanks!

-- 
MST

