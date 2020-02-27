Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D28C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8609B24683
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="npI8N/06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgB0G2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:28:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40373 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgB0G2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 01:28:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id p3so1886585edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 22:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qc/8gjwoSjhv1WAaPphN4gG7vMp46r7eAyhBiGEqLNs=;
        b=npI8N/06lMSjD76Xcc/BTWLlQT34lMDfw3GeZ58xWNJ/dhjfX4cJcHqhnYAfRrwMGr
         LPb5I8MHPsPEpf2j+kjjnkLdm8FNl5MfQtq+AbsEdOOBGKNg+gXW3/3mQSDUno7qspET
         QfGdFEYcQnKlfIjSUH4HN6s5OYzN1k0UHSvRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qc/8gjwoSjhv1WAaPphN4gG7vMp46r7eAyhBiGEqLNs=;
        b=Jxly89TSxZpTgNen3ECR6NjIKyc4QRE2hLzrwSGllm78GqJBF9Noq/dqHgEMhje3nQ
         zl5FDC5PJnZHkZSjsyMrgeAhrk+rKSA9wVzI2vCf/4jIudiJ2Z15SIB2Ayd2b9JkARvU
         d8YJUzH0RRj/gTL0kOkNitxiIdQOZvEYIeJZ+k9bpnhjSfx88Z33ET1fSx0xUdvP2vO2
         BqlpUnbcFV2LG9trmI4ELukY2WfxZVfnq0hFaKEN2I3p0BogohWazdV4YALZeDWan0kv
         KVzp93XJCFO70MDvseRs7qYDWO9o+r21QY/MraHE7+bMPSWKkFQT5kH+/SbSv5co9gdz
         XTFw==
X-Gm-Message-State: APjAAAXDemcMG4CKR8ChiJN3rjTYfhpuXKgOC8H+rehfEXmu/fKKCeBd
        3uOVui8O0Fz3wMhzbetAeNuhyDF2F5S3Sw==
X-Google-Smtp-Source: APXvYqzQJwJlwsojluGku+kAz1XPN9e44eImOA8O/uOuvsNIYsRHKTTLsWfo89tTkSLuw8MK2W/7Kw==
X-Received: by 2002:a50:ee91:: with SMTP id f17mr2227211edr.130.1582784898962;
        Wed, 26 Feb 2020 22:28:18 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id e21sm281321eds.36.2020.02.26.22.28.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 22:28:17 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id a5so2158259wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 22:28:17 -0800 (PST)
X-Received: by 2002:a05:600c:2c48:: with SMTP id r8mr3065839wmg.183.1582784896863;
 Wed, 26 Feb 2020 22:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20190802131226.123800-1-shik@chromium.org> <CANMq1KD3Pth7LNnVqxSesx3kSFte0eR5JqEBETv45s_9_YKWHw@mail.gmail.com>
 <20190930082310.GA1750@infradead.org> <20191001063744.GA10402@infradead.org>
In-Reply-To: <20191001063744.GA10402@infradead.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 27 Feb 2020 15:28:05 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BN63Y-zufQo9_b6kKVX7-1Qf1LwCOKQpMKkQ5KTOf2hw@mail.gmail.com>
Message-ID: <CAAFQd5BN63Y-zufQo9_b6kKVX7-1Qf1LwCOKQpMKkQ5KTOf2hw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Use streaming DMA APIs to transfer buffers
To:     Christoph Hellwig <hch@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Shik Chen <shik@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        notify@kernel.org, Keiichi Watanabe <keiichiw@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Sergey Senozhatsky who's going to be looking into this.

Hi Christoph,

On Tue, Oct 1, 2019 at 3:37 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Sep 30, 2019 at 01:23:10AM -0700, Christoph Hellwig wrote:
> > And drivers really have no business looking at the dma mask.  I have
> > a plan for dma_alloc_pages API that could replace that cruft, but
> > until then please use GFP_KERNEL and let the dma subsystem bounce
> > buffer if needed.
>
> Can you try this series:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_pages
>
> and see if it does whay you need for usb?

Reviving this thread. Sorry for no updates for a long time.

dma_alloc_pages() still wouldn't be an equivalent replacement of the
existing dma_alloc_coherent() (used behind the scenes by
usb_alloc_coherent()). That's because the latter can allocate
non-contiguous memory if the DMA device can handle it (i.e. is behind
an IOMMU), but the former can only allocate a contiguous range of
pages.

That said, I noticed that you also put a lot of effort into making the
NONCONSISTENT attribute more usable. Perhaps that's the way to go here
then? Of course we would need to make sure that the attribute is
handled properly on ARM and ARM64, which are the most affected
platforms. Right now neither handles them. The former doesn't use the
generic DMA mapping ops, while the latter does, but doesn't enable a
Kconfig option needed to allow generic inconsistent allocations.

Any hints would be appreciated.

Best regards,
Tomasz
