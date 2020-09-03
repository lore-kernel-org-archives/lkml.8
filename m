Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CAC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C073020897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599161499;
	bh=kjH/LgGMlPHqItmXItRd65Sxc/1xMjTZ2pzItqGlC4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lDt6mqk/IcmfX7TsjJzACElEMdjzLbPdpEm7+YL9Mw5GgQyqhS90I0MN11iKFO3cK
	 ++wdI/sAwYtGsAhLucQOoergep8c/ogZ0paUJeErUGUEstrrM2IrXiZPxRH6XHWmJV
	 DIv6sR/qSgVRTyEiefOgmDMrApW4wCudqz8yQtCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgICTbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgICTbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:31:37 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF3320722;
        Thu,  3 Sep 2020 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599161497;
        bh=kjH/LgGMlPHqItmXItRd65Sxc/1xMjTZ2pzItqGlC4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jd3cCWzL2cRoQHm6rOL0pxBtYmC1Di+s5yUps8WLuig2busBXY0oAs9s9orBgMjjQ
         22hSYPzeq9iK8gIUrFAZMNc388tcVkcvs1PC810D6c8RoAjXJlz026hJJ3J/WluG0S
         EGqpreHs1fxWuQY2UJVuKPGsCQQhAQBItHIfVXyk=
Date:   Thu, 3 Sep 2020 12:31:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, mhocko@suse.com, linux-mm@kvack.org,
        osalvador@suse.de, richard.weiyang@gmail.com, vbabka@suse.cz,
        rientjes@google.com
Subject: Re: [PATCH v2] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
Message-Id: <20200903123136.1fa50e773eb58c6200801e65@linux-foundation.org>
In-Reply-To: <6ec66eb9-eeba-5076-af97-cef59ed5cbaa@redhat.com>
References: <20200903140032.380431-1-pasha.tatashin@soleen.com>
        <6ec66eb9-eeba-5076-af97-cef59ed5cbaa@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 19:36:26 +0200 David Hildenbrand <david@redhat.com> wrote:

> (still on vacation, back next week on Tuesday)
> 
> I didn't look into discussions in v1, but to me this looks like we are
> trying to hide an actual bug by implementing hacks in the caller
> (repeated calls to drain_all_pages()). What about alloc_contig_range()
> users - you get more allocation errors just because PCP code doesn't
> play along.
> 
> There *is* strong synchronization with the page allocator - however,
> there seems to be one corner case race where we allow to allocate pages
> from isolated pageblocks.
> 
> I want that fixed instead if possible, otherwise this is just an ugly
> hack to make the obvious symptoms (offlining looping forever) disappear.
> 
> If that is not possible easily, I'd much rather want to see all
> drain_all_pages() calls being moved to the caller and have the expected
> behavior documented instead of specifying "there is no strong
> synchronization with the page allocator" - which is wrong in all but PCP
> cases (and there only in one possible race?).
> 

It's a two-line hack which fixes a bug in -stable kernels, so I'm
inclined to proceed with it anyway.  We can undo it later on as part of
a better fix, OK?

Unless you think there's some new misbehaviour which we might see as a
result of this approach?
