Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9284AC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6536622464
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580136575;
	bh=EQH4btHYYmEcvx2pvjSqvnf6Yu7uT48LDzMZI6U8cjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dI0dlkFEW5uPPTFUl4UjnZDlqp0PRrGFonMSbUQQ+WoIcAJxR5kptJTKdliQCgCWS
	 HxI6LsWKB8euNCaMZfV9G6sW25I04ioAIc3pjVXANvPOqvTcKYk2UhIHcmMsqv4Xgl
	 VCtvUUnp50pw6gBU3sUG+gTY8SMIJSvTXZqEbIMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgA0Ote (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:49:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgA0Otd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:49:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so7333074wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 06:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KoEnCm20hXD1XW9rE/9TMYQX4pzcwOm+aqs2dDRx82U=;
        b=I7oMw3U6DS5FfjuRU3+Io1enQ9kcpDit5D1qF5dw6ishvKNUW7KBTWk1i0icNxEPKn
         cwxyq0kV+h41zmtkeqYGK9F4gwZmyi3sb7zry2h6X9/Wtcdm6it5I/O2o5CuBvpIP01k
         NvQcNH7HKPrcx/IGygNLzLVgwFOR63gLzXROGgiOeeAVLCpHRbohG9VZSP9AF2y5aF/l
         4lOXl7dce9rIGvHi9MktzxfvXSsa9sq0+fxYWySA8TuxRwNI89YtaFluUqYoOCPcmlmO
         pRTx9m8fjBRFYJQA8ZlUXxdYMoZAmMY3vlB7zk6iLdP4CdkYAJvXTQFC+7g6BNtU5TTA
         QDpA==
X-Gm-Message-State: APjAAAWWW6d7pcvmTyNWubC98jTmX21z9QiXmsuCbPY7UxbpnGwP85Z8
        ITSRJckZaPwkq1/J7VWI/lw=
X-Google-Smtp-Source: APXvYqx9WNrgr7HHQfTqud3BqenwS73GmMwfmpCxBwYB84Rt8BMx7DovMlzJ+FckIH1XjrXmS6Hbcw==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr13919704wml.134.1580136572370;
        Mon, 27 Jan 2020 06:49:32 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y20sm10509394wmj.23.2020.01.27.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:49:31 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:49:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200127144931.GM1183@dhcp22.suse.cz>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 26-01-20 11:53:55, Cong Wang wrote:
> On Tue, Jan 21, 2020 at 1:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 20-01-20 14:48:05, Cong Wang wrote:
> > > It got stuck somewhere along the call path of mem_cgroup_try_charge(),
> > > and the trace events of mm_vmscan_lru_shrink_inactive() indicates this
> > > too:
> >
> > So it seems that you are condending on the page lock. It is really
> > unexpected that the reclaim would take that long though. Please try to
> > enable more vmscan tracepoints to see where the time is spent.
> 
> Sorry for the delay. I have been trying to collect more data in one shot.
> 
> This is a a typical round of the loop after enabling all vmscan tracepoints:
> 
>            <...>-455450 [007] .... 4048595.842992:
> mm_vmscan_memcg_reclaim_begin: order=0 may_writepage=1
> gfp_flags=GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE
> classzone_idx=4
>            <...>-455450 [007] .... 4048595.843012:
> mm_vmscan_memcg_reclaim_end: nr_reclaimed=0

This doesn't tell us much though. This reclaim round has taken close to
no time. See timestamps.

> The whole trace output is huge (33M), I can provide it on request.

Focus on reclaim rounds that take a long time and see where it gets you.
-- 
Michal Hocko
SUSE Labs
