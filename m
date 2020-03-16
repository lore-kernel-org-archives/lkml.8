Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B017DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7339020663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s4Fa/txq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgCPMSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:18:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbgCPMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VYqKvlIFkQW+pYWKw2xVsDJi1K3BGJvUDJbFubWL0xw=; b=s4Fa/txqhFusSCj//z0CGHHLnt
        SzCovk4A9hIakdxXBSWwrUr3oebo6/kI+ZA0GqaiyA1BKdVIOanqg4YpnBT3+oR5qQMz6uK4Nm67i
        UGhhtL0E6B+4bVcGeaG4B/VZpedBfuRIXuLoXSFtipOh4/usKFOj4Gf7oiEqEXSXYhM1AFr9g290w
        T/bwvigK4HyMPrFH7bK4sj88OaERz0osPh4BNanoKy2FAxvd7HXC9LPOGxx9i4SkXutYS6NjaCG0v
        I9Zjp22V1gZGuZQm1vuZeYsKTv53VZBT6DCWT2dZuEH5IXEIbNqo6VgNng5j7+6pir5Ok9dJRc+U7
        bpT7PfgA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDohj-00007t-7P; Mon, 16 Mar 2020 12:18:47 +0000
Date:   Mon, 16 Mar 2020 05:18:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        richard.weiyang@gmail.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 1/2] mm/sparse.c: Use kvmalloc/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200316121847.GX22433@bombadil.infradead.org>
References: <20200316102150.16487-1-bhe@redhat.com>
 <CAM9Jb+iow40dCvrC8xoKAv5di2J_TDxvAkzKkHk5a0OXNaq3Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+iow40dCvrC8xoKAv5di2J_TDxvAkzKkHk5a0OXNaq3Yg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 12:17:49PM +0100, Pankaj Gupta wrote:
> > This change makes populate_section_memmap()/depopulate_section_memmap
> > much simpler.
> >
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>

> With David's indentation suggestion:
> Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
(for both patches)
