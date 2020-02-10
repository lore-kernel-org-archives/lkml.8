Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A92C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F119F206ED
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ToQYS2ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgBJTWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:22:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CiM52pTPVqz/skTBLeX1gYuocEamvKWE7EoYWXekqbE=; b=ToQYS2eeMN6pm+nzAjgrfjNuGk
        vx08Ib9g47C+wFMlqE6aEgHU+TDP9y769k0l5C5tTFhCrV4AuD33lgMv4AKJOW3I4/wpzQFGCmt7Q
        MlZTrZjdtonDDFjePt3EMml0AsAl+NF0OqM3TPqzKfKMbaIU0xlPMkax5sjaoJckafvIIv/T8b8LT
        KyhZZIX6Oni0VFLdoquOLWDQJcU401YytKrbPs0KKIC2KN/ke4KCvUx07wrbSyMt58ppqA5e7dOub
        R2zFcI2aTeD/OYDWzPgdAlffQICKo7+Yj9CIdVVFjaKjzZEnkIro//Y7ZztJm3jctCDlyAaaMJHN7
        4bi6qvuA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Ed1-0001zg-8H; Mon, 10 Feb 2020 19:21:55 +0000
Date:   Mon, 10 Feb 2020 11:21:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
Message-ID: <20200210192155.GM8731@bombadil.infradead.org>
References: <1581354029-20154-1-git-send-email-cai@lca.pw>
 <20200210172511.GL8731@bombadil.infradead.org>
 <1581362448.7365.38.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581362448.7365.38.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 02:20:48PM -0500, Qian Cai wrote:
> On Mon, 2020-02-10 at 09:25 -0800, Matthew Wilcox wrote:
> > On Mon, Feb 10, 2020 at 12:00:29PM -0500, Qian Cai wrote:
> > > @@ -2622,7 +2622,7 @@ void filemap_map_pages(struct vm_fault *vmf,
> > >  		if (page->index >= max_idx)
> > >  			goto unlock;
> > >  
> > > -		if (file->f_ra.mmap_miss > 0)
> > > +		if (data_race(file->f_ra.mmap_miss > 0))
> > >  			file->f_ra.mmap_miss--;
> > 
> > How is this safe?  Two threads can each see 1, and then both decrement the
> > in-memory copy, causing it to end up at -1.
> 
> Well, I meant to say it is safe from *data* races rather than all other races,
> but it is a good catch for the underflow cases and makes some sense to fix them
> together (so we don't need to touch the same lines over and over again).

My point is that this is a legitimate warning from the sanitiser.
The point of your patches should not be to remove all the warnings!
