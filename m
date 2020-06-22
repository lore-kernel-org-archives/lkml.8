Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0242C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7C62481B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRefbf1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgFVDv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgFVDv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:51:57 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BBC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 20:51:57 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id p82so3651232oif.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jPZz3H1bJualnrErIHRAoXkRSJR+RreP0gv4U2JUbAM=;
        b=TRefbf1XBoHU3XEWfK+yS1GTpddDROt157GoNTug8rQKo9YzcccO3bB23S/0VXnAYd
         m3jodIvW4rlnED6fmq4uGFFp6Q8NcJNBCOZsS3Cek9Da623kFmckW2RW5rb3xJ/JXdtE
         2R8Q/0lxzvbMsMQc12UZsdNXtkSv2EV7MM/f3BqtvoX57wK6gZ/TvKrIDY0D9OgZeOKI
         9T7uAxyiLKR7FL1iVtX3Nl+zjnmEAVTroEVQ/GWH7XXOhHPCtiP2Gc3eT9Sn/dxB+7I0
         zdmUdwFiZ3ExH9CsQ28GLyLtcLwNMH2/7PayGLY/n6bbshOjsFoHkIQ6aQKIYgB2I+3A
         tejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPZz3H1bJualnrErIHRAoXkRSJR+RreP0gv4U2JUbAM=;
        b=J4qP6AdT4TIY4Agl5PyZRNgdXk2VIEqRJHqQn6VQVLaiSzr9nwGsZRyfqxExcwMyXZ
         6HFpTB6QTfEUp2K/p889R/0Qq5SMCyEQ8mhvF0ftFwOINrf8oyY/dLWd1nMWGlwFQoIE
         DkS6fzoKwhDEQOnW+2AOK0x0rv1nneKg7CWDMCK8WFQjKu3HJBzBuh3io1CKge/66zNw
         77wFuGm8A4RNsPoPDFtPu2y5u2N6yd2ZtK+vCChd2I2yH6Ied/P16A6iS1Ng6uMXznwu
         k1gnX2ra+M5QfWWm7cU36BXcARYC1zZ2F7nfm+MkOJYpLbLrNfM4HRh+ZNNk4J9BkXEx
         QCAg==
X-Gm-Message-State: AOAM533pw7pkRyAawuhY/F5siGcuhNlfgCuJ3WSMTt+PA+DPWAYqZyo1
        8q+RCLQ6P72f8PO8fIpEQ/g=
X-Google-Smtp-Source: ABdhPJzcSGYDArFucea6nPqXHuCylaX7IoxCagdqha0drxVX/DXwwFWTmZjaFXusp9a/ciZpKPjIlA==
X-Received: by 2002:aca:41c2:: with SMTP id o185mr10744207oia.94.1592797916305;
        Sun, 21 Jun 2020 20:51:56 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id i16sm3050364otc.33.2020.06.21.20.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 20:51:55 -0700 (PDT)
Date:   Sun, 21 Jun 2020 20:51:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2 3/5] mm: memcg/percpu: per-memcg percpu memory
 statistics
Message-ID: <20200622035153.GA3073407@ubuntu-n2-xlarge-x86>
References: <20200608230819.832349-1-guro@fb.com>
 <20200608230819.832349-4-guro@fb.com>
 <20200622014803.GA2916179@ubuntu-n2-xlarge-x86>
 <20200622032635.GC293939@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622032635.GC293939@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 08:26:35PM -0700, Roman Gushchin wrote:
> On Sun, Jun 21, 2020 at 06:48:03PM -0700, Nathan Chancellor wrote:
> > On Mon, Jun 08, 2020 at 04:08:17PM -0700, Roman Gushchin wrote:
> > > Percpu memory can represent a noticeable chunk of the total
> > > memory consumption, especially on big machines with many CPUs.
> > > Let's track percpu memory usage for each memcg and display
> > > it in memory.stat.
> > > 
> > > A percpu allocation is usually scattered over multiple pages
> > > (and nodes), and can be significantly smaller than a page.
> > > So let's add a byte-sized counter on the memcg level:
> > > MEMCG_PERCPU_B. Byte-sized vmstat infra created for slabs
> > > can be perfectly reused for percpu case.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Acked-by: Dennis Zhou <dennis@kernel.org>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst |  4 ++++
> > >  include/linux/memcontrol.h              |  8 ++++++++
> > >  mm/memcontrol.c                         |  4 +++-
> > >  mm/percpu.c                             | 10 ++++++++++
> > >  4 files changed, 25 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index ce3e05e41724..7c1e784239bf 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1274,6 +1274,10 @@ PAGE_SIZE multiple when read back.
> > >  		Amount of memory used for storing in-kernel data
> > >  		structures.
> > >  
> > > +	  percpu
> > > +		Amount of memory used for storing per-cpu kernel
> > > +		data structures.
> > > +
> > >  	  sock
> > >  		Amount of memory used in network transmission buffers
> > >  
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index eede46c43573..7ed3af71a6fb 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -32,11 +32,19 @@ struct kmem_cache;
> > >  enum memcg_stat_item {
> > >  	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
> > >  	MEMCG_SOCK,
> > > +	MEMCG_PERCPU_B,
> > >  	/* XXX: why are these zone and not node counters? */
> > >  	MEMCG_KERNEL_STACK_KB,
> > >  	MEMCG_NR_STAT,
> > >  };
> > >  
> > > +static __always_inline bool memcg_stat_item_in_bytes(enum memcg_stat_item item)
> > > +{
> > > +	if (item == MEMCG_PERCPU_B)
> > > +		return true;
> > > +	return vmstat_item_in_bytes(item);
> > 
> > This patch is now in -next and this line causes a warning from clang,
> > which shows up in every translation unit that includes this header,
> > which is a lot:
> > 
> > include/linux/memcontrol.h:45:30: warning: implicit conversion from
> > enumeration type 'enum memcg_stat_item' to different enumeration type
> > 'enum node_stat_item' [-Wenum-conversion]
> >         return vmstat_item_in_bytes(item);
> >                ~~~~~~~~~~~~~~~~~~~~ ^~~~
> > 1 warning generated.
> > 
> > I assume this conversion is intentional; if so, it seems like expecting
> > a specific enum is misleading. Perhaps this should be applied on top?
> 
> Hi Nathan!
> 
> Yeah, these enums are kind of stacked on each other, so memcg_stat values
> extend node_stat values. And I think your patch is correct.

Yeah, I figured. It happens in the kernel in a couple of different
places that we have seen so far. So far, my suggestion seems to be the
best one that we have uncovered when dealing with one enum that
supplments or extends another. These functions are fairly self
explanation so I don't think that blowing away the type safety here is a
big deal.

> I'm going to refresh the series with some small fixups. If you're not against
> it, I'll merge your patch into the corresponding patches.

Please do! Thanks for the quick response.

Cheers,
Nathan

> And thank you for reporting the problem!
> 
> > 
> > Cheers,
> > Nathan
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 2499f78cf32d..bddeb4ce7a4f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -38,7 +38,7 @@ enum memcg_stat_item {
> >  	MEMCG_NR_STAT,
> >  };
> >  
> > -static __always_inline bool memcg_stat_item_in_bytes(enum memcg_stat_item item)
> > +static __always_inline bool memcg_stat_item_in_bytes(int item)
> >  {
> >  	if (item == MEMCG_PERCPU_B)
> >  		return true;
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 084ee1c17160..52d7961a24f0 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -211,7 +211,7 @@ enum node_stat_item {
> >   * measured in pages). This defines the API part, the internal representation
> >   * might be different.
> >   */
> > -static __always_inline bool vmstat_item_in_bytes(enum node_stat_item item)
> > +static __always_inline bool vmstat_item_in_bytes(int item)
> >  {
> >  	/*
> >  	 * Global and per-node slab counters track slab pages.
