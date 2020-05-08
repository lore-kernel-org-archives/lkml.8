Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C453C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAEA2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="bdGbD2A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgEHNix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgEHNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:38:51 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7099C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:38:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r3so724177qvm.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s3c/kHKjv4oi4xRI+SDdDjgcOJfA2m3GEd8rwNL8FJM=;
        b=bdGbD2A/K34eENIxrCE2mZH62IdbA4NbgUCDWNqpn8XBZAxW2jontvXRjCqJdK6uVp
         tLCQGN6n1BbZtWtCAdliAh80NpRzCgOR0R3DxFXitpehOva/RVp/LVCtLcQd2slTZXM6
         7YN4ubLyjwbRL9qsv13akCcwa6UtQH8gdRTF5dA2KRAc7uI9B6eVzMF5PvMHlXmybtV2
         XI0enlpf/OIKfjrQTh0C6FENh2YXYkAEK8nYAATeZeZTHJILEFpQVseDBCA4vz1D0YRs
         0P3ehoSHiSOukGW9R/MiEdevBux0MRyrsZJOLqlp6RdRMmH5fhFJcnGsvLYJesv+KOtv
         ohWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3c/kHKjv4oi4xRI+SDdDjgcOJfA2m3GEd8rwNL8FJM=;
        b=rO5zGChh0RSFCiEmZRPaflmtOP9xipZ1TmhtpfdB68bvfklzv8daXrrscQt2LQJtd1
         nQFqQOdX3b7aVeBwx6F92QR/qj/0XtrP0kW0CTbZgpbidMttwbEt96RKv01cNM67R3hi
         tLGQdtbox3aXUPZkNiSejYtjj51viTIyN865ndG0w/q70/LTEeHofJPxUsWGLVwtjNSC
         nz8ZRGiI99j9vu2wUlubX9tZ0YfetisXAbaGYVSD7iQ6SGmbuTTSASMAP4vAaaddXsJA
         Bd/GkTeDDoQv6NPmI4igZgX2HB8iDXB7PJrATyr5GjdTGnDVbInFU3JggjKSR3GwLP9J
         vbZQ==
X-Gm-Message-State: AGi0PuYpJ4Qdkdk1sR2xkf7ID6a5ez7nReHb/pB8XmRAFIv3v4jCba9U
        ZPAw/Nng2xRaiCzkS76X5gSYgXoK/YM=
X-Google-Smtp-Source: APiQypLjm7g5uyaNxmKnnhh0sSGk189fzCge53i7i5N/MovX8Gq7Ym3S3ZqrB5FalA/lrRUaYyZKQg==
X-Received: by 2002:ad4:4b6b:: with SMTP id m11mr2814178qvx.130.1588945129920;
        Fri, 08 May 2020 06:38:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id q17sm1162686qkq.111.2020.05.08.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:38:49 -0700 (PDT)
Date:   Fri, 8 May 2020 09:38:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgsteal and pgscan
Message-ID: <20200508133833.GA181181@cmpxchg.org>
References: <20200507204913.18661-1-shakeelb@google.com>
 <CALOAHbAHK4b2p0oWXY6oHG+WQzK3+TEa46=dPabhYT8ab=65zA@mail.gmail.com>
 <CALvZod7VujYgU=6XfgjSZnzLqDpbHwEYsp2Xbq9MK7w_z=LphA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7VujYgU=6XfgjSZnzLqDpbHwEYsp2Xbq9MK7w_z=LphA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 06:25:14AM -0700, Shakeel Butt wrote:
> On Fri, May 8, 2020 at 3:34 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Fri, May 8, 2020 at 4:49 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > One way to measure the efficiency of memory reclaim is to look at the
> > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > not updated consistently at the system level and the ratio of these are
> > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > reclaim while pgrefill gets updated for global as well as cgroup
> > > reclaim.
> > >
> >
> > Hi Shakeel,
> >
> > We always use pgscan and pgsteal for monitoring the system level
> > memory pressure, for example, by using sysstat(sar) or some other
> > monitor tools.

I'm in the same boat. It's useful to have activity that happens purely
due to machine capacity rather than localized activity that happens
due to the limits throughout the cgroup tree.

> Don't you need pgrefill in addition to pgscan and pgsteal to get the
> full picture of the reclaim activity?

I actually almost never look at pgrefill.

> > But with this change, these two counters include the memcg pressure as
> > well. It is not easy to know whether the pgscan and pgsteal are caused
> > by system level pressure or only some specific memcgs reaching their
> > memory limit.
> >
> > How about adding  cgroup_reclaim() to pgrefill as well ?
> >
> 
> I am looking for all the reclaim activity on the system. Adding
> !cgroup_reclaim to pgrefill will skip the cgroup reclaim activity.
> Maybe adding pgsteal_cgroup and pgscan_cgroup would be better.

How would you feel about adding memory.stat at the root cgroup level?

There are subtle differences between /proc/vmstat and memory.stat, and
cgroup-aware code that wants to watch the full hierarchy currently has
to know about these intricacies and translate semantics back and forth.

Generally having the fully recursive memory.stat at the root level
could help a broader range of usecases.
