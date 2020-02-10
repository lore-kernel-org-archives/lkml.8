Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A400C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A4820733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="culiPi1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgBJRZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:25:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBJRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FKWDJRQkvccelSptVw0DM+3Z0/fjsynGFQORnsVICQc=; b=culiPi1QCROeF4470hWIw1cPqD
        ulAoApdWZj7NpYbaioAxNM6Pbe6LDQa2IxTm8sjfw0f9+pVtPDOrpP1Ym+tBrQpeoBGXIkjRitGKM
        6t3OBa2V4+mFxqAUhW3NJ010fV7ju+coEejm/lQP98xawvj4rCzMkJQlDOG+Ky08L4LRMIAKTZfu9
        8zlrp0pdp5Zn94Bju8ph2HAWgeTldnk4n+8m1qhDv/lUo7YyoWF6E6EAuyTjgacegQ0KHiKhQHx99
        PI1Vy4TsALOqFyM6Nd5vLHCcxKYAEJ16aCYaq37fOINoLINIVDG/3mgY9ZPq82h0WGIogihYIPHQb
        8Vto2tDg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Co3-0003NN-NZ; Mon, 10 Feb 2020 17:25:11 +0000
Date:   Mon, 10 Feb 2020 09:25:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
Message-ID: <20200210172511.GL8731@bombadil.infradead.org>
References: <1581354029-20154-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581354029-20154-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:00:29PM -0500, Qian Cai wrote:
> @@ -2622,7 +2622,7 @@ void filemap_map_pages(struct vm_fault *vmf,
>  		if (page->index >= max_idx)
>  			goto unlock;
>  
> -		if (file->f_ra.mmap_miss > 0)
> +		if (data_race(file->f_ra.mmap_miss > 0))
>  			file->f_ra.mmap_miss--;

How is this safe?  Two threads can each see 1, and then both decrement the
in-memory copy, causing it to end up at -1.
