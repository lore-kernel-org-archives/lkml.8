Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BFDC76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ED12086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 09:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn1MoOVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgBPJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 04:47:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34098 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbgBPJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 04:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581846440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3c/WN0m/fSra0TkxvPfDqbPdSXCm+vdA6iOX3UjbCRY=;
        b=Yn1MoOVEGr6lVgT10N4xC6zcG6vNX4qoE0zBN0BFOXdLdqlea5y/Gt94sHPaKYHGbICTlX
        +60ENbVL1ZOT96+YamgIC4q0mCxKf/sZ9tatB5uVwC28llZFsT5OqvXA4NQ0Ql41l0BrYd
        zMFlClwjzrA5LeoaOHR9jiWABhvJBZE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-sK3vVnVOPRuUBoSzVRjcjA-1; Sun, 16 Feb 2020 04:47:17 -0500
X-MC-Unique: sK3vVnVOPRuUBoSzVRjcjA-1
Received: by mail-wr1-f71.google.com with SMTP id a12so7059633wrn.19
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 01:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3c/WN0m/fSra0TkxvPfDqbPdSXCm+vdA6iOX3UjbCRY=;
        b=grJZIng1JtA0PBmgagvc2zux2YJ5kjtqPc6VEASnJC9OYPUii9IDrz8mxkhkOkVzh/
         iyGsSSRI7kie3GXcYMf8VqSmS65SUaX3kXfhF+rhn51meNZZqKiUi9p63vRXK9z0ysNh
         ADl681nf5sJVE3PVYCBuciqa2Mj3JA7o6Jk+3LfBHhHLAxM5Xmh7E3k5XWFUChzeGT9L
         6qrrOeAG9/hMFWJHkocyhaJN0qtnLfrkF52mfRy9Oj03FGwTBC3Huy9Mo1SZ6Xn523p3
         F2NRRhShNU6FB4IYyaQgffRH9pt6LMTvaUAmasLdWDMGGgKE8RJoHuziUcZd+VMBb8js
         iW9Q==
X-Gm-Message-State: APjAAAW6YZoZDl3d3VXHXecy28mC1N/fZJckAqPBdCUBer+T7LQJ7Sre
        NAbtNj8t8u/kZ3ivo1+cR6E6xQdbgtKT0Aq1nlaIU10wZ2e0tYYJx36qUNWzA7xA4w4Um8Quje1
        4Ns8cuBklg2gp7nf1Hm+ILELC
X-Received: by 2002:adf:81c2:: with SMTP id 60mr14899128wra.8.1581846435945;
        Sun, 16 Feb 2020 01:47:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqzG6RrsUSe8N2Fvm+d5duF0MuB1svG4/FyfcHkv6fRCRbqtrjKVH9j/IKcsdYDYK8VCFBolkQ==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr14899111wra.8.1581846435739;
        Sun, 16 Feb 2020 01:47:15 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
        by smtp.gmail.com with ESMTPSA id a16sm14989900wrx.87.2020.02.16.01.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 01:47:15 -0800 (PST)
Date:   Sun, 16 Feb 2020 04:47:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200216044641-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:51:43AM +0100, David Hildenbrand wrote:
> On 05.02.20 17:34, David Hildenbrand wrote:
> > Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> > changed the behavior when deflation happens automatically. Instead of
> > deflating when called by the OOM handler, the shrinker is used.
> > 
> > However, the balloon is not simply some slab cache that should be
> > shrunk when under memory pressure. The shrinker does not have a concept of
> > priorities, so this behavior cannot be configured.
> > 
> > There was a report that this results in undesired side effects when
> > inflating the balloon to shrink the page cache. [1]
> > 	"When inflating the balloon against page cache (i.e. no free memory
> > 	 remains) vmscan.c will both shrink page cache, but also invoke the
> > 	 shrinkers -- including the balloon's shrinker. So the balloon
> > 	 driver allocates memory which requires reclaim, vmscan gets this
> > 	 memory by shrinking the balloon, and then the driver adds the
> > 	 memory back to the balloon. Basically a busy no-op."
> > 
> > The name "deflate on OOM" makes it pretty clear when deflation should
> > happen - after other approaches to reclaim memory failed, not while
> > reclaiming. This allows to minimize the footprint of a guest - memory
> > will only be taken out of the balloon when really needed.
> > 
> > Especially, a drop_slab() will result in the whole balloon getting
> > deflated - undesired. While handling it via the OOM handler might not be
> > perfect, it keeps existing behavior. If we want a different behavior, then
> > we need a new feature bit and document it properly (although, there should
> > be a clear use case and the intended effects should be well described).
> > 
> > Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
> > this has no such side effects. Always register the shrinker with
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
> > pages that are still to be processed by the guest. The hypervisor takes
> > care of identifying and resolving possible races between processing a
> > hinting request and the guest reusing a page.
> > 
> > In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
> > notifier with shrinker"), don't add a moodule parameter to configure the
> > number of pages to deflate on OOM. Can be re-added if really needed.
> > Also, pay attention that leak_balloon() returns the number of 4k pages -
> > convert it properly in virtio_balloon_oom_notify().
> > 
> > Note1: using the OOM handler is frowned upon, but it really is what we
> >        need for this feature.
> > 
> > Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU) we
> >        could actually skip sending deflation requests to our hypervisor,
> >        making the OOM path *very* simple. Besically freeing pages and
> >        updating the balloon. If the communication with the host ever
> >        becomes a problem on this call path.
> > 
> 
> @Michael, how to proceed with this?
> 

I'd like to see some reports that this helps people.
e.g. a tested-by tag.

> -- 
> Thanks,
> 
> David / dhildenb

