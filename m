Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A88AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBC321924
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SJlFo73f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDQPAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:00:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505CFC061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:00:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so3379161wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+pLzXV2uoWONcvIXLG60QmJnpF6qpxalQJEJVAlU5ZU=;
        b=SJlFo73fheabH5hiH/RJ37KRFeF6vcj+J3TT+NQ5Qiwt4UY2A/7hQayUJEKsxeJqiz
         W6eqjB1ojrsvckINI7UM64sPHV2ixzU9iDWbpnLaZ5Xi/8osCdcnlRDz4ZKgGfjR6ct/
         24JhjZMz3V23pEJ7WWIDMpIpFcUhNftInHJYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=+pLzXV2uoWONcvIXLG60QmJnpF6qpxalQJEJVAlU5ZU=;
        b=SB1c/gV7bBrm4MaSLmVUjKdknHrDuK3QOKnSMg82DvgMAX78Roh2e37SvVgsA/5HG8
         We6g9GISPcC1aRmU3xXZBHr05d5RS3HEPB5oEJ5NyMOt2xmkoYfsTTHS3vwuDwzR+JFH
         TKQ9hD6wjn1Wvk6UX2iIJoEP30soiVHgwxsr7/4NWzCC+SN61cjM3Q7IkSwyJlhaOeno
         vbTCnJUW3y9S6EU6Y4R06XO4Ttlb7SvnD4FGmJjtJ97LG9hl9YARPP6eg1q7K/wWPi9G
         c7PBkc56C63VBBNx/nFLZNkPzLllcmp/2GF6c0qO7pQQdSr/8yFLghzL/W68tipRn+py
         2RDg==
X-Gm-Message-State: AGi0Pua6O+G2fh0WRK8CSpQmkPbsRINflwLx/IRBw0mL9sTY+5zr1Gw4
        MmilHNoHy/zYug9oWwWDOvcfjg==
X-Google-Smtp-Source: APiQypI+XqYbgKYVQ6aVc9PEFMJyQDjicsm1whYiSRv3ZukR4N/x6YDtB22FRHpXAK0g1o+ga1mJiw==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr4216226wrq.119.1587135616818;
        Fri, 17 Apr 2020 08:00:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g186sm8077661wme.7.2020.04.17.08.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:00:16 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:00:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        driverdevel <devel@driverdev.osuosl.org>, nd <nd@arm.com>,
        Todd Kjos <tkjos@android.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Anders Pedersen <anders.pedersen@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        =?iso-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] staging: android: ion: Skip sync if not mapped
Message-ID: <20200417150013.GN3456981@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        driverdevel <devel@driverdev.osuosl.org>, nd <nd@arm.com>,
        Todd Kjos <tkjos@android.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Anders Pedersen <anders.pedersen@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        =?iso-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>,
        linux-media@vger.kernel.org
References: <20200414134629.54567-1-orjan.eide@arm.com>
 <20200414141849.55654-1-orjan.eide@arm.com>
 <20200414142810.GA958163@kroah.com>
 <CALAqxLX-SUhHPH6ewt-s9cEMc8DtMTgXem=JruAkLofuJf1syg@mail.gmail.com>
 <20200416102508.GA820251@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416102508.GA820251@kroah.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 12:25:08PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 14, 2020 at 09:41:31PM -0700, John Stultz wrote:
> > On Tue, Apr 14, 2020 at 7:28 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Apr 14, 2020 at 04:18:47PM +0200, Ørjan Eide wrote:
> > > > Only sync the sg-list of an Ion dma-buf attachment when the attachment
> > > > is actually mapped on the device.
> > > >
> > > > dma-bufs may be synced at any time. It can be reached from user space
> > > > via DMA_BUF_IOCTL_SYNC, so there are no guarantees from callers on when
> > > > syncs may be attempted, and dma_buf_end_cpu_access() and
> > > > dma_buf_begin_cpu_access() may not be paired.
> > > >
> > > > Since the sg_list's dma_address isn't set up until the buffer is used
> > > > on the device, and dma_map_sg() is called on it, the dma_address will be
> > > > NULL if sync is attempted on the dma-buf before it's mapped on a device.
> > > >
> > > > Before v5.0 (commit 55897af63091 ("dma-direct: merge swiotlb_dma_ops
> > > > into the dma_direct code")) this was a problem as the dma-api (at least
> > > > the swiotlb_dma_ops on arm64) would use the potentially invalid
> > > > dma_address. How that failed depended on how the device handled physical
> > > > address 0. If 0 was a valid address to physical ram, that page would get
> > > > flushed a lot, while the actual pages in the buffer would not get synced
> > > > correctly. While if 0 is an invalid physical address it may cause a
> > > > fault and trigger a crash.
> > > >
> > > > In v5.0 this was incidentally fixed by commit 55897af63091 ("dma-direct:
> > > > merge swiotlb_dma_ops into the dma_direct code"), as this moved the
> > > > dma-api to use the page pointer in the sg_list, and (for Ion buffers at
> > > > least) this will always be valid if the sg_list exists at all.
> > > >
> > > > But, this issue is re-introduced in v5.3 with
> > > > commit 449fa54d6815 ("dma-direct: correct the physical addr in
> > > > dma_direct_sync_sg_for_cpu/device") moves the dma-api back to the old
> > > > behaviour and picks the dma_address that may be invalid.
> > > >
> > > > dma-buf core doesn't ensure that the buffer is mapped on the device, and
> > > > thus have a valid sg_list, before calling the exporter's
> > > > begin_cpu_access.
> > > >
> > > > Signed-off-by: Ørjan Eide <orjan.eide@arm.com>
> > > > ---
> > > >  drivers/staging/android/ion/ion.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > Resubmit without disclaimer, sorry about that.
> > > >
> > > > This seems to be part of a bigger issue where dma-buf exporters assume
> > > > that their dma-buf begin_cpu_access and end_cpu_access callbacks have a
> > > > certain guaranteed behavior, which isn't ensured by dma-buf core.
> > > >
> > > > This patch fixes this in ion only, but it also needs to be fixed for
> > > > other exporters, either handled like this in each exporter, or in
> > > > dma-buf core before calling into the exporters.
> > > >
> > > > diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> > > > index 38b51eace4f9..7b752ba0cb6d 100644
> > > > --- a/drivers/staging/android/ion/ion.c
> > > > +++ b/drivers/staging/android/ion/ion.c
> > >
> > > Now that we have the dma-buff stuff in the tree, do we even need the
> > > ion code in the kernel anymore?  Can't we delete it now?
> > >
> > 
> > I agree that we shouldn't be taking further (non-security/cleanup)
> > patches to the ION code.
> > 
> > I'd like to give developers a little bit of a transition period (I was
> > thinking a year, but really just one LTS release that has both would
> > do) where they can move their ION heaps over to dmabuf heaps and test
> > both against the same tree.
> > 
> > But I do think we can mark it as deprecated and let folks know that
> > around the end of the year it will be deleted.
> 
> No one ever notices "depreciated" things, they only notice if the code
> is no longer there :)
> 
> So I'm all for just deleting it and seeing who even notices...

+1 on just deleting ion and watching if anyone notices. In case you're
typing that patch, here's my:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
