Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EFFC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF832070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJySvP5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCTPd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:33:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21563 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgCTPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584718437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XeyzAJxgBh+6PUhoAp4SlYW+6ERsTWH0yvGznNw4e58=;
        b=SJySvP5t7Ke36aysK+gsB4vK3pgSuBO/EbFoP19BDAvXKO6GhkKFlY9maxOtR9NprJHbdx
        p9l+rFBvz1L/OxeSAUa5n7GXjmMIDLOYKV7ynQwkPuSOoj45x5ZOGrhru8MR7+sSwzF7AG
        IXDtQALCMlfFoDV9QSMQKISr4epyhlM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-xzBkP3V0NVGssPUd_ueYng-1; Fri, 20 Mar 2020 11:33:55 -0400
X-MC-Unique: xzBkP3V0NVGssPUd_ueYng-1
Received: by mail-wm1-f70.google.com with SMTP id f185so2503176wmf.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XeyzAJxgBh+6PUhoAp4SlYW+6ERsTWH0yvGznNw4e58=;
        b=r+rzIlWjacC5H0Dz1C8D8on2s5hE7pEajjrFCH9EDo7xk8uDXEEZRpaARAZoe8nLOr
         Oqvb/RXAMaQ/D1xMM9QcOpk2mfDLkosIJpNMy76Igww/Xw35TWvcYFc7uAJMX2LPO5sg
         Neez5P2Ahla0YxWunPDtmkjblJ1BT6BJ9CJpu97jrfxL8PyMknK9XFl3pwIn4RkzVlu9
         u5ja1gwZeZxS//HwgL1pc1YXKYUIWv/y3h+Wck0iw3Mr6D72jYfrre5duMtvTzXIXwQM
         FMJ+D2yFMc9Q2BVuG9cUXI9qgqDg9LeYo8erkxl83NnuCSGzn4zcveaTeXmd6QyTFxgJ
         WsUA==
X-Gm-Message-State: ANhLgQ1yqyaBCms4B9hM9TaYSqTaL0WNkDot2JaBaJ+kJfANriE2wsMn
        P6dIesebbWILKOstvqhkxXRlim8yQojqX7ZDQx3fwP5P8Dj4NTAUsb4i5aNoZSZOOcNrGveUB5m
        ZwsLHy9htE8ZFVH9B3tFAazwFRl4N64Y8hChD12eP
X-Received: by 2002:a7b:c40f:: with SMTP id k15mr5696842wmi.144.1584718434412;
        Fri, 20 Mar 2020 08:33:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuDBST3/7qZQPX/Zppz7rPxOCK13Gbo/YEvu+3q6wsOmXOKe/OICTow4GBaSf+RSlljQr+C0CfYFyEuy0h6EQw=
X-Received: by 2002:a7b:c40f:: with SMTP id k15mr5696810wmi.144.1584718434072;
 Fri, 20 Mar 2020 08:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb> <20200309203625.GU3818@techsingularity.net>
 <20200312095432.GW3818@techsingularity.net> <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net> <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com> <20200320152251.GC3818@techsingularity.net>
In-Reply-To: <20200320152251.GC3818@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 20 Mar 2020 16:33:43 +0100
Message-ID: <CAE4VaGA+GOh-wgHBbSsgpRVXgrGtz8egu6dYp143TAH0siL5fA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> MPI or OMP and what is a low thread count? For MPI at least, I saw a 0.4%
> gain on an 4-node machine for bt_C and a 3.88% regression on 8-nodes. I
> think it must be OMP you are using because I found I had to disable UA
> for MPI at some point in the past for reasons I no longer remember.

Yes, it's indeed OMP.  With low threads count, I mean up to 2x number
of NUMA nodes (8 threads on 4 NUMA node servers, 16 threads on 8 NUMA
node servers).

> One possibility would be to spread wide always at clone time and assume
> wake_affine will pull related tasks but it's fragile because it breaks
> if the cloned task execs and then allocates memory from a remote node
> only to migrate to a local node immediately.

I think the only way to find out how it performs is to test it. If you
could prepare a patch like that, I'm more than happy to give it a try!

Jirka


On Fri, Mar 20, 2020 at 4:22 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Mar 20, 2020 at 03:37:44PM +0100, Jirka Hladky wrote:
> > Hi Mel,
> >
> > just a quick update. I have increased the testing coverage and other tests
> > from the NAS shows a big performance drop for the low number of threads as
> > well:
> >
> > sp_C_x - show still the biggest drop upto 50%
> > bt_C_x - performance drop upto 40%
> > ua_C_x - performance drop upto 30%
> >
>
> MPI or OMP and what is a low thread count? For MPI at least, I saw a 0.4%
> gain on an 4-node machine for bt_C and a 3.88% regression on 8-nodes. I
> think it must be OMP you are using because I found I had to disable UA
> for MPI at some point in the past for reasons I no longer remember.
>
> > My point is that the performance drop for the low number of threads is more
> > common than we have initially thought.
> >
> > Let me know what you need more data.
> >
>
> I just a clarification on the thread count and a confirmation it's OMP. For
> MPI, I did note that some of the other NAS kernels shows a slight dip but
> it was nowhere near as severe as SP and the problem was the same as more --
> two or more tasks stayed on the same node without spreading out because
> there was no pressure to do so. There was enough CPU and memory capacity
> with no obvious pattern that could be used to spread the load wide early.
>
> One possibility would be to spread wide always at clone time and assume
> wake_affine will pull related tasks but it's fragile because it breaks
> if the cloned task execs and then allocates memory from a remote node
> only to migrate to a local node immediately.
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka

