Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B421EC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE9820CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+7YLxbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGML2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:11:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726575AbgEGML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588853487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EANwWfRY2fmMo9bV62Nn6bc92cfkBW2MVPtmjYJC3NY=;
        b=e+7YLxbkZcJS1Ulq3SCV/IqNG+q6ZNKtROJhiTwI4zZ5OfMxWMPnfG7yOg6f8LdtzgnZos
        y/RZy0OjFFTEi/fXwcWCg7ESRqYBJecjbqcms/0jTLXYPYJJ417e37hm26ip7ZJe2ve/py
        +M/sIV/SYexEslRsVfJi2eaaaseaMjo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-XoLCfDjBMvCFi5D8g2IskQ-1; Thu, 07 May 2020 08:11:25 -0400
X-MC-Unique: XoLCfDjBMvCFi5D8g2IskQ-1
Received: by mail-wr1-f69.google.com with SMTP id o6so3331119wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EANwWfRY2fmMo9bV62Nn6bc92cfkBW2MVPtmjYJC3NY=;
        b=KvjxCBPGt3olBvT9kU3FGm+B9D/B9HIATdZzcukdmTvEtipiaG+Zs6pcCzMz3wSWfX
         yrHSCfxmJ0d7cuU5bNTjESjofafWgcJMaSgwKtmdPlI09+NXm0JX3ZZdVwXEtpE/+tCs
         QaWMH9l/f/ESVdIsHzId8h1QwhcUNw04UDrhlwXBtuZBx1ox7wBXnDeq7210T5eMgywS
         9CeNKraW1gd3P7Hrc+J+PdN/IUB7aru/udQ+6U8ZawyTPBMN06C64FswJzfmwbwHp0kt
         COuwZ0M0yryegDgMcgiW2/GRrglJzSTJ6ehtjseyOMAqvlvgpZ7YPp1SdBMKP/mlRjOh
         Bssg==
X-Gm-Message-State: AGi0PuY6n7N6CBD0RjRtma3ZXt4YOg4v1gfIlgbCztxbebvKH+AM4Nib
        wVRsLXuT92fQyoWYU4qtZcw8v3jtLKKVrkyHE4+ZLPZrZo802ZyrX08EGon3PWoXby15VIEMkqe
        V3nKBOkDFvaMAdbB/zjkK5O8U
X-Received: by 2002:a5d:4389:: with SMTP id i9mr15945330wrq.374.1588853484090;
        Thu, 07 May 2020 05:11:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ7D0RkcqeXu3YBCPljtvjPEqgvhppTkrE0OvAuBlPYmp89z6WlX+VSiChRymh96iq6D4Ha+A==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr15945306wrq.374.1588853483876;
        Thu, 07 May 2020 05:11:23 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id v2sm8092084wrn.21.2020.05.07.05.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 05:11:23 -0700 (PDT)
Date:   Thu, 7 May 2020 08:11:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 07/15] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Message-ID: <20200507080849-mutt-send-email-mst@kernel.org>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-8-david@redhat.com>
 <20200507064558-mutt-send-email-mst@kernel.org>
 <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
 <441bfb92-ecfa-f54e-3661-b219ea166e55@redhat.com>
 <20200507073408-mutt-send-email-mst@kernel.org>
 <3bed2d1d-d94a-45ca-afe3-5e6ee660b0fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bed2d1d-d94a-45ca-afe3-5e6ee660b0fc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:37:30PM +0200, David Hildenbrand wrote:
> On 07.05.20 13:34, Michael S. Tsirkin wrote:
> > On Thu, May 07, 2020 at 01:33:23PM +0200, David Hildenbrand wrote:
> >>>> I get:
> >>>>
> >>>> error: sha1 information is lacking or useless (mm/memory_hotplug.c).
> >>>> error: could not build fake ancestor
> >>>>
> >>>> which version is this against? Pls post patches on top of some tag
> >>>> in Linus' tree if possible.
> >>>
> >>> As the cover states, latest linux-next. To be precise
> >>>
> >>> commit 6b43f715b6379433e8eb30aa9bcc99bd6a585f77 (tag: next-20200507,
> >>> next/master)
> >>> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> >>> Date:   Thu May 7 18:11:31 2020 +1000
> >>>
> >>>     Add linux-next specific files for 20200507
> >>>
> >>
> >> The patches seem to apply cleanly on top of
> >>
> >> commit a811c1fa0a02c062555b54651065899437bacdbe (linus/master)
> >> Merge: b9388959ba50 16f8036086a9
> >> Author: Linus Torvalds <torvalds@linux-foundation.org>
> >> Date:   Wed May 6 20:53:22 2020 -0700
> >>
> >>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > 
> > Because you have the relevant hashes in your git tree not pruned yet.
> > Do a new clone and they won't apply.
> > 
> 
> Yeah, most probably, it knows how to merge. I'm used to sending all my
> -mm stuff based on -next, so this here is different.


Documentation/process/5.Posting.rst addresses this:


Patches must be prepared against a specific version of the kernel.  As a
general rule, a patch should be based on the current mainline as found in
Linus's git tree.  When basing on mainline, start with a well-known release
point - a stable or -rc release - rather than branching off the mainline at
an arbitrary spot.

It may become necessary to make versions against -mm, linux-next, or a
subsystem tree, though, to facilitate wider testing and review.  Depending
on the area of your patch and what is going on elsewhere, basing a patch
against these other trees can require a significant amount of work
resolving conflicts and dealing with API changes.





> I'll wait a bit and then send v4 based on latest linus/master, adding
> the two acks and reshuffling the MAINTAINERS patch. Thanks.
> 
> -- 
> Thanks,
> 
> David / dhildenb

