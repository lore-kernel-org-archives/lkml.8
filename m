Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB2C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F0921897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594716090;
	bh=Kiir7gBYT/yQFXBimok418PvnNKQie0UWB+K+ImJKEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ctuOT7qycvUviGxTYHk80oOEHCkbhAn2I/4nRv+dB3Wzpprc0Uo9QRjLLNf4cVLFu
	 jdMjhVNla5wNLcVjf968my01CrvS3L+k1sSAyZ8FriK6XS6gWbkXSMWj9+kqJXD7O8
	 QHwcbdA4yAm/xcWj1vzeyrcjW5mv8Hb/bg0J18Lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGNIl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:41:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46054 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgGNIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:41:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id s10so20247439wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZJI4J4GWPCiHcryb6MzhVJv5JF+Q8LkCIIU9I8lCYw=;
        b=F9w2G08cQ13wPxyygbTJh+dYJXOtZgPD7wcQsejltLHbi11Mq/iqyONdeLnmejcaMo
         fabD8WAVM4DHBo1PxUsiE9nwROPy2RG2HE4De76YztT/VF2P2eBGSU6O6BYEV3d7QcO3
         6hCh2y+uG9D2/LT72yrLgcYORy84HVdLLmyUM4jshtNmRF/saGmD3qQw9ZYLmi4PynSv
         wOYVXs5bDKay7FOvYuvb8jGD5OzPbBclUe+CseCCGHXGkikMPSrGXEztKhQrIepNUpEC
         vtx0ydPzFevVdGT9MH7Fv3kLkuvrBFcl7C5bZg1WlNHv7iQLsrio7/ekRuYqZucg/ief
         Ygpw==
X-Gm-Message-State: AOAM530JVHfn2MnQUjmo9R4B+WB/HhxbdT+oOpo0MQ6Xl0kx2nPyY06D
        +iI9Qu5nMxd1KKkE3/NFeoLa8W/w
X-Google-Smtp-Source: ABdhPJxTNcf8EkhjrdL/FnjXZ4Igi2NSjQyCDEFbKe9Yox0PnbOgIh5YD0E1iH0E7yiJmmONgB/Bqw==
X-Received: by 2002:adf:bc41:: with SMTP id a1mr3749906wrh.186.1594716086018;
        Tue, 14 Jul 2020 01:41:26 -0700 (PDT)
Received: from localhost (ip-37-188-148-171.eurotel.cz. [37.188.148.171])
        by smtp.gmail.com with ESMTPSA id j4sm28721035wrp.51.2020.07.14.01.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:41:25 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:41:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering
 memory.high
Message-ID: <20200714084123.GG24642@dhcp22.suse.cz>
References: <20200709194718.189231-1-guro@fb.com>
 <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
 <20200710184205.GB350256@carbon.dhcp.thefacebook.com>
 <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-07-20 12:19:37, Shakeel Butt wrote:
> On Fri, Jul 10, 2020 at 11:42 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Jul 10, 2020 at 07:12:22AM -0700, Shakeel Butt wrote:
> > > On Fri, Jul 10, 2020 at 5:29 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> > > > > Memory.high limit is implemented in a way such that the kernel
> > > > > penalizes all threads which are allocating a memory over the limit.
> > > > > Forcing all threads into the synchronous reclaim and adding some
> > > > > artificial delays allows to slow down the memory consumption and
> > > > > potentially give some time for userspace oom handlers/resource control
> > > > > agents to react.
> > > > >
> > > > > It works nicely if the memory usage is hitting the limit from below,
> > > > > however it works sub-optimal if a user adjusts memory.high to a value
> > > > > way below the current memory usage. It basically forces all workload
> > > > > threads (doing any memory allocations) into the synchronous reclaim
> > > > > and sleep. This makes the workload completely unresponsive for
> > > > > a long period of time and can also lead to a system-wide contention on
> > > > > lru locks. It can happen even if the workload is not actually tight on
> > > > > memory and has, for example, a ton of cold pagecache.
> > > > >
> > > > > In the current implementation writing to memory.high causes an atomic
> > > > > update of page counter's high value followed by an attempt to reclaim
> > > > > enough memory to fit into the new limit. To fix the problem described
> > > > > above, all we need is to change the order of execution: try to push
> > > > > the memory usage under the limit first, and only then set the new
> > > > > high limit.
> > > >
> > > > Shakeel would this help with your pro-active reclaim usecase? It would
> > > > require to reset the high limit right after the reclaim returns which is
> > > > quite ugly but it would at least not require a completely new interface.
> > > > You would simply do
> > > >         high = current - to_reclaim
> > > >         echo $high > memory.high
> > > >         echo infinity > memory.high # To prevent direct reclaim
> > > >                                     # allocation stalls
> > > >
> > >
> > > This will reduce the chance of stalls but the interface is still
> > > non-delegatable i.e. applications can not change their own memory.high
> > > for the use-cases like application controlled proactive reclaim and
> > > uswapd.
> >
> > Can you, please, elaborate a bit more on this? I didn't understand
> > why.
> >
> 
> Sure. Do we want memory.high a CFTYPE_NS_DELEGATABLE type file? I
> don't think so otherwise any job on a system can change their
> memory.high and can adversely impact the isolation and memory
> scheduling of the system.

Is this really the case? There should always be a parent cgroup that
overrides the setting. Also you can always set the hard limit if you do
not want to add another layer of cgroup in the hierarchy before
delegation. Or am I missing something?

-- 
Michal Hocko
SUSE Labs
