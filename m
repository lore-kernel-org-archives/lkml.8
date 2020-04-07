Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F1BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA187206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IumPu7+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgDGJy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:54:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23775 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728093AbgDGJy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586253297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=el11Oz/pQuOVMF2uMBXTZlpAn+Yh+0JzX31amVwM/8s=;
        b=IumPu7+PvqZB+vlBy/v6pRSpP0bs9jI16cEHoKAdAKQyrntKgFF9W6z4YxrAEihSheeCG6
        zMd90VSN0qep5e64V1aV/wD1nXc6fqbm80emF7OI9K/u+Y6PS9BfaB3JegNGSSlX4WD6vY
        I1cVGUePf11dt0gd9kbJgpsG057hMrc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-DUDGuDzsPNCuEpthtoJ2bA-1; Tue, 07 Apr 2020 05:54:54 -0400
X-MC-Unique: DUDGuDzsPNCuEpthtoJ2bA-1
Received: by mail-wm1-f71.google.com with SMTP id f8so381908wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=el11Oz/pQuOVMF2uMBXTZlpAn+Yh+0JzX31amVwM/8s=;
        b=ogNnir5n5hDSh9OCnBO0J+nHh4nqpo+zz1KVKbcFLSf04txvcM2OQvHd+GHRxJugB+
         kknBL0yZBS/pHJqGDQHGkvBmqV5SnzQcakFln83VbDCdpGNAIa2CTl+UvqBwAw1Wipuq
         6qNiN5sCE/WWGZTwxkgmvWFHsxjtfvF0cU0cdbzDgC17qMvvMkVlqDh8qBGHvK27KgrV
         arBgtaFNBJJma7ZT0/rVgEoDy0DWJoMzrAhsJcLgs1TtCv0O+xf6olKCWPt1+SWnoY4j
         IA0SXjVgQrqRJwzW+o6Xml4hkdCh1Zvc/5ftVyn9QAp4y4agGDLutdhfplgpypehWfXk
         URyg==
X-Gm-Message-State: AGi0PuZJKdV+ZDPQZ6peQeSsOzrmq78Ww/TiFTRlcdGaYDFWLks6gH72
        cPs5KN3ROhiqsU15migKIYH5Q6ZTwcZI8qQomMa0Jp8THPj8K+AklJTcoJX2mHuF2usSJEssEZG
        tKgmg4hHYdY8JY9/efpleJVHL
X-Received: by 2002:adf:b6a9:: with SMTP id j41mr1857789wre.70.1586253292984;
        Tue, 07 Apr 2020 02:54:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypL4AzzGuCb+/SPuBeTLQChENkJSntsNvAOSf15+PWge49hAPyo9lPsh2y5yXRV3JLlzDNv2+g==
X-Received: by 2002:adf:b6a9:: with SMTP id j41mr1857768wre.70.1586253292819;
        Tue, 07 Apr 2020 02:54:52 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id t81sm1629697wmb.15.2020.04.07.02.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:54:52 -0700 (PDT)
Date:   Tue, 7 Apr 2020 05:54:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the vhost
 tree
Message-ID: <20200407055243-mutt-send-email-mst@kernel.org>
References: <20200330193137.44fd70c9@canb.auug.org.au>
 <20200407132521.656db6fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407132521.656db6fa@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:25:21PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 30 Mar 2020 19:31:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the akpm-current tree got a conflict in:
> > 
> >   drivers/virtio/virtio_balloon.c
> > 
> > between commit:
> > 
> >   5a6b4cc5b7a1 ("virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM")
> > 
> > from the vhost tree and commits:
> > 
> >   5193acb63eef ("virtio-balloon: pull page poisoning config out of free page hinting")o
> >   226d0484a676 ("virtio-balloon: add support for providing free page reports to host")
> >   49006aae9e94 ("virtio-balloon: switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM")
> > 
> > from the akpm-current tree.
> > 
> > OK, this is such a mess that all I could do was to revert commit
> > 5a6b4cc5b7a1 from the vhost tree and keep all the akpm-current tree
> > patches. Please sort this out before Linus gets to see it.
> 
> I am still reverting that commit ...

Oh. Thanks for reminding me. And I sent a pull with this :(
Sorry.  I pushed the revert now and sent PULL request v2.
Hope I did it in time ...

> -- 
> Cheers,
> Stephen Rothwell


