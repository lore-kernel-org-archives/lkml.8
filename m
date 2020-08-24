Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35415C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010A620706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598308611;
	bh=Ukg6PN5rR9z+MPkj5bceL0dM2BoHywyCwtm1dZvL5Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NPqrcuHkgtfJWBw0xhyJO8Hm3VDbr7IpNIbmKbt7NIpv4iVEK3P2Cy1YtCbk91pSQ
	 TK080Dcw9hvMgqN5IdLEv6uAI87fHoOhwRNNLlXmc85KDa5cg+1y8ot8tBvKzjMewV
	 /DJGESHeAydpUPUOqdQAQ/GmKfP8jHPoYfkzfDKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHXWgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgHXWgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:36:47 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56D020656;
        Mon, 24 Aug 2020 22:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598308607;
        bh=Ukg6PN5rR9z+MPkj5bceL0dM2BoHywyCwtm1dZvL5Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vtBtTyOQhXf33WWccNsDMxOCaVcMO1MXGOfeNHUwB37XaQo1Dp/Jp9nDG4Hd9KgQ7
         ukrZe3ncXQ3o9/mDy25Y//MIdd/j8pQdIq+9KVnRKjDiWCmbdUub/CHc7GK4XfVjM+
         6RthfDo8cv9psE+zFyXbsWkio3j+02r5tVWkO7lA=
Date:   Mon, 24 Aug 2020 15:36:45 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        rientjes@google.com, ying.huang@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC][PATCH 0/9] [v3] Migrate Pages in lieu of discard
Message-ID: <20200824223645.GA1490647@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818184122.29C415DF@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818184122.29C415DF@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:41:22AM -0700, Dave Hansen wrote:
> Dave Hansen (5):
>       mm/numa: node demotion data structure and lookup
>       mm/vmscan: Attempt to migrate page in lieu of discard
>       mm/numa: automatically generate node migration order
>       mm/vmscan: never demote for memcg reclaim
>       mm/numa: new reclaim mode to enable reclaim-based migration
> 
> Keith Busch (2):
>       mm/migrate: Defer allocating new page until needed
>       mm/vmscan: Consider anonymous pages without swap
> 
> Yang Shi (1):
>       mm/vmscan: add page demotion counter
> 
>  Documentation/admin-guide/sysctl/vm.rst |    9
>  include/linux/migrate.h                 |    6
>  include/linux/node.h                    |    9
>  include/linux/vm_event_item.h           |    2
>  include/trace/events/migrate.h          |    3
>  mm/debug.c                              |    1
>  mm/internal.h                           |    1
>  mm/migrate.c                            |  400 ++++++++++++++++++++++++++------
>  mm/page_alloc.c                         |    2
>  mm/vmscan.c                             |   88 ++++++-
>  mm/vmstat.c                             |    2
>  11 files changed, 439 insertions(+), 84 deletions(-)

The commit summary and diff stat appear to be from an earlier revision
of the series. No big deal, just pointing that out. BTW, thank you for
continuing to enhance this capability! :) I'd missed out on the earlier
discussion from some bad filters that have should now be fixed
(hopefully), so I've some catching up to do.
