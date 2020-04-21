Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B246C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A9920882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587442378;
	bh=0stJHqO/CMElxQxgtwJK5qKK+mD2WutwBkPSA2WH9ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=I1mEjqKl/KrD1LzsL4BJz3I0PCXylY/DK2pl7GgdR0Qmb4zWXf1TjiR9TkLxin86Q
	 uJCsW+xnVY8dE0yrl8NRpM0F6037WxbwLk1rINICGMdQnQLVES2gsCegqY2lS+S6bJ
	 AVBck/h4ZEfrPR2+aPb5mceLrTxn0EuHHSoNmTeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUEM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgDUEM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:12:56 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343722084D;
        Tue, 21 Apr 2020 04:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587442376;
        bh=0stJHqO/CMElxQxgtwJK5qKK+mD2WutwBkPSA2WH9ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pt/a8+CSt1Fr4ooDnz33LrLucxb+jNTp3XBgFPG6qN1U1em2n0hDWA3RJymEQ1E6y
         CJ1k43PqfW1ItjTykgRnF4XxLVCc369BUfBY9mClNLggkNPxz47mK4YC3q04CB/jh/
         mvK/b07J/W9iER6NvYvjMgY1WGiCxfjPHt9+sYLA=
Date:   Mon, 20 Apr 2020 21:12:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Robert Stupp <snazy@gmx.de>
Subject: Re: [PATCH 2/3] mm: fix long time stall from mm_populate
Message-Id: <20200420211255.55bb6e1275cf90f9dc292238@linux-foundation.org>
In-Reply-To: <20200212221614.215302-2-minchan@kernel.org>
References: <20200212221614.215302-1-minchan@kernel.org>
        <20200212221614.215302-2-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 14:16:13 -0800 Minchan Kim <minchan@kernel.org> wrote:

> Basically, fault handler releases mmap_sem before requesting readahead
> and then it is supposed to retry lookup the page from page cache with
> FAULT_FLAG_TRIED so that it avoids the live lock of infinite retry.
> 
> However, what happens if the fault handler find a page from page
> cache and the page has readahead marker but are waiting under
> writeback? Plus one more condition, it happens under mm_populate
> which repeats faulting unless it encounters error. So let's assemble
> conditions below.
> 
> __mm_populate
> for (...)
>   get_user_pages(faluty_address)
>     handle_mm_fault
>       filemap_fault
>         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> 	it will return VM_FAULT_RETRY
>   continue with faulty_address
> 
> IOW, it will repeat fault retry logic until the page will be written
> back in the long run. It makes big spike latency of several seconds.
> 
> This patch solves the issue by turning off fault retry logic in second
> trial.

I guess a resend would be helpful, to refresh memories.

Please mention in the changelog whether this "long time stall" has been
observed in practice.  If so, under what conditions, how often and how
long was it?  etcetera.


