Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5DA2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p4+E/Hse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404189AbgEYPdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404092AbgEYPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:33:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B72C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KJaDHPPz3lTydc/Mf8t2Wq2qJfQbT/hZX56yF4I1VI0=; b=p4+E/Hse0321y64/36UuJ2Qfs6
        Gul+xxNp5aJduaZ1PfZNM7gTIZ0t0rr3gwpCZsfrh0ytNiwMA75G5TDk+cIJY9tNoNeXGQtJFFMup
        knIA8v1zC3tUEqafZQmNbpSMuACX2Sq6rw8krU5ByzLLwQGK+a+fH8dmZFGaVYRYKUscUAnJ3Kagl
        u7wXK0Lp6ZVPmsbOINIzof+ztfnlI7CcYNS3giFYq6YuRQUxaZGb2Y4vTbg7im8KArXPdi0yZWet7
        VMBZ+G5jWafwo1yJ5UkkeK+3LCe5hknIglHaw8y2vW9zN+w6q2Hgz0+TXUL14LHt1dLkaoS4sUHXU
        C5Zt8M9g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdF6J-0000se-SQ; Mon, 25 May 2020 15:33:15 +0000
Date:   Mon, 25 May 2020 08:33:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm: dump_page: add debugfs file for dumping page state
 by pfn
Message-ID: <20200525153315.GC17206@bombadil.infradead.org>
References: <159041635119.987025.7321864888027213705.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159041635119.987025.7321864888027213705.stgit@buzz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:19:11PM +0300, Konstantin Khlebnikov wrote:
> Tool 'page-types' could list pages mapped by process or file cache pages,
> but it shows only limited amount of state exported via procfs.
> 
> Let's employ existing helper dump_page() to reach remaining information:
> writing pfn into /sys/kernel/debug/dump_page dumps state into kernel log.
> 
> # echo 0x37c43c > /sys/kernel/debug/dump_page
> # dmesg | tail -6
>  page:ffffcb0b0df10f00 refcount:1 mapcount:0 mapping:000000007755d3d9 index:0x30
>  0xffffffffae4239e0 name:"libGeoIP.so.1.6.9"
>  flags: 0x200000000020014(uptodate|lru|mappedtodisk)
>  raw: 0200000000020014 ffffcb0b187fd288 ffffcb0b189e6248 ffff9528a04afe10
>  raw: 0000000000000030 0000000000000000 00000001ffffffff 0000000000000000
>  page dumped because: debugfs request

This makes me deeply uncomfortable.  We're using %px, and %lx
(for the 'raw' lines) so we actually get to see kernel addresses.
We've rationalised this in the past as being acceptable because you're
already in an "assert triggered" kind of situation.  Now you're adding
a way for any process with CAP_SYS_ADMIN to get kernel addresses dumped
into the syslog.

I think we need a different function for this, or we need to re-audit
dump_page() for exposing kernel pointers, and not expose the raw data
in struct page.

