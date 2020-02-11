Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86482C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD2B20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UfzGHdBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBKBK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 20:10:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgBKBKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vtx3GuoucCB7GHmDuyJEH6fVHqrp/1ZumwqI2mL1l24=; b=UfzGHdBQv58rdN0fTCxFUQMUML
        6aRCWb0mQMzxLmctfZv4Ar0eK3ud5abaYIYVXGCl1FKucrkL/b5S7X2fUWzhrUnFHqVVWWhjA0ApF
        GDYvAfbLvR57bnyvmU04VGEpKQFlLek+UlkWrybi/bTUnUoGb5IZW7+y565jQJcnlh5NIDWVPxjro
        7E8PY24rHv6x8BoXdWCmdICj3E43+/8MKOq5UPX+NiuDLYqbZlwN/quukXUzzuDNx3Ht3KNZbachV
        nNQOiM2P5WHVen9pJWoWQ5Z/ildtTuAA/En9XeDOtJiV7aptvCQIFS5RFUasjGqUj+VtGoYSh8TwV
        C/rL77aw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1K4E-00053D-0Q; Tue, 11 Feb 2020 01:10:22 +0000
Date:   Mon, 10 Feb 2020 17:10:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200211011021.GP8731@bombadil.infradead.org>
References: <20200211001958.170261-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211001958.170261-1-minchan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:19:58PM -0800, Minchan Kim wrote:
>       filemap_fault
>         find a page form page(PG_uptodate|PG_readahead|PG_writeback)

Uh ... That shouldn't be possible.

        /*
         * Same bit is used for PG_readahead and PG_reclaim.
         */
        if (PageWriteback(page))
                return;

        ClearPageReadahead(page);

