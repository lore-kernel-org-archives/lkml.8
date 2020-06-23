Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA898C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BDF20776
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZqLlsVf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgFWAF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbgFWAF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:05:27 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81012C061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:05:27 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so5532306qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZARmJJ7xCkdZZ2t8wNh4/tQvVIlLfUoBxGbPVnLj1no=;
        b=ZqLlsVf823WvkS6Pxei8NiC2W2IIsAJoQA2urO7e9M3j3n78WU8zuiQnBC/Hh13LQ7
         W82cIEkI8yK1kig27JBpN1A+kBTvdyfep2zqFSsRZ3bneYMoHddrECdeOHAhBx3jAggE
         8oQvGlZO4VuJSft8Izl2Bf/u/NJdZDmJmyKoVRcHZq2TKwggLrrOlhDeM/ysxoX7/Me3
         dqRCX3t0aoqiPb12yGgusjNMnEL8ewMvbu4zIi2lDYR1tedgzPmqU85hNdNt9mW7kpmp
         xuKIYdmxHb1ZwHUACc5P3GQ4w7GIm5gpp47skdgCpNYwfEX9eupQQgKd/elWzUh05kv2
         mhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZARmJJ7xCkdZZ2t8wNh4/tQvVIlLfUoBxGbPVnLj1no=;
        b=dvkVRe2bf0upV2opK3vASR00D/6S+FYVhvcVYwmxnlW/nvOwsIBQOKND3IPr7c0y3o
         1sjh7HGN6TWNC/FqTdrATEwWPs2UolYwVON+UqGGxM65lBhy2mBH/bHZpM5ilNwl6PJl
         l1AMGQpo1cLaB+T20gtNDsWLBQw3IlBkPhusmgL0hx5YHlO9dnKe+q1zG8gbVejZKGnN
         M4x2hUZmBXAep87X4RPKhPjAb3Uw4w9qZbkK2N0Mvmt0+7LmYBxsk0cnLIwQQ8xi2SSx
         G4U9mQ0xd4o1e7SyDh9DkJAW1UauUyYbdiqtC5wnithgA+AeLl+EPznmKC5zDdT+m2eB
         YHYQ==
X-Gm-Message-State: AOAM532XgdppAlxlK0M38NoiqaEZFWrp2vZHeK1psf34r8kC4UMyhSg7
        dfzyZlfyKr+wLk5Zsd32hL2uVA==
X-Google-Smtp-Source: ABdhPJybLGEC9Vkbo3afR1e0rkiE4Uqi81y09rG7Z316acKAzGcUboScxSHByPFqPGL4yR3GT9b3Ew==
X-Received: by 2002:ac8:279a:: with SMTP id w26mr18731669qtw.309.1592870726664;
        Mon, 22 Jun 2020 17:05:26 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n143sm1204192qkn.94.2020.06.22.17.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:05:26 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jnWRJ-00CHPu-Cd; Mon, 22 Jun 2020 21:05:25 -0300
Date:   Mon, 22 Jun 2020 21:05:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200623000525.GX6578@ziepe.ca>
References: <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <20200619201011.GB13117@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619201011.GB13117@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:10:11PM -0400, Jerome Glisse wrote:
 
> Maybe we can audit how user ptr buffer are use today and see if
> we can define a usage pattern that would allow to cut corner in
> kernel. For instance we could use mmu notifier just to block CPU
> pte update while we do GUP and thus never wait on dma fence.

The DMA fence is the main problem, if you can think of a way to avoid
it then it would be great!
 
> Then GPU driver just keep the GUP pin around until they are done
> with the page. They can also use the mmu notifier to keep a flag
> so that the driver know if it needs to redo a GUP ie:
> 
> The notifier path:
>    GPU_mmu_notifier_start_callback(range)
>         gpu_lock_cpu_pagetable(range)
>         for_each_bo_in(bo, range) {
>             bo->need_gup = true;
>         }
>         gpu_unlock_cpu_pagetable(range)

So some kind of invalidation tracking? But this doesn't solve COW and
Fork problem?

> > It is kind of unrelated to HMM, it just shouldn't be using mmu
> > notifiers to replace page pinning..
> 
> Well my POV is that if you abide by rules HMM defined then you do
> not need to pin pages. The rule is asynchronous device page table
> update.

I think one of the hmm rules is to not block notifiers for a long
time, which these scheme seem to violate already.

Pinning for a long time is less bad than blocing notifiers for a long
time, IMHO

Jason
