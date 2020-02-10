Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88E1C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EEC2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="HpRF/mqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJVVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:21:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35413 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:21:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id z18so5378129lfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xoubVLLqrUMwwq8k9aqhgPs8ugNxz2VRM04t0KZe/tw=;
        b=HpRF/mqfbtil9oUJ3RB70VAfErIXF960JdgkqsDsXxma5cIFU92TRKurk5LAEAbSc9
         y9AAaLekoC6hn4UybtCCJkMPziOR/DGOehXh8rMPf55B/bx5kPIgzs1QIhLr62haHtff
         Bwb8NQXOb/Rf7GH0LdzyXkXdPGblCfcZzec0Qn0oZ22v+/PSrVjMxK2V4SvC4pTCXLqF
         bzuK0OlLg22o+yTRPin9m0MNdf7em/ngNODGoq2DNxruj8WTjNkBzBa7BqGaAAphjFOm
         d0h99P2mdadzMGQqQDWs/BAfwoqwBdI8fWZ9zLX5dZwPy82US7qXyo5rlxho1QVvZaR3
         QxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xoubVLLqrUMwwq8k9aqhgPs8ugNxz2VRM04t0KZe/tw=;
        b=MtEgtJdwvbi/6agoTF1zGfUl9nPJj8hBccJBuTpBLSzw3d2+QvYZDqx3iBx2u5t4Ej
         h36p3tHyk9ZgHsaiUvkkj0WY/Y8bGhKdHyWAXiR/p/lghJIXNtbtBjKABah3mo1Y43QM
         P26DBIFF2gCDUKTMHO+y8ctjqYBrJyKFTO4Mzf5c+0dO/HOjAmI/dBIYarDDV2Bhio/m
         oTnd0TTVduwVyInQLh5ZsKMK7KLQ5uE28d76CBt15vRJaJI8/ohsBmilLqwVP/oHGNeF
         HAC9SnSxdQbeCglCvLAdXmOLZbKAPckBoGCQPE8eUb9p85+UBbmRopw6o6UPx+8N69bf
         BbwQ==
X-Gm-Message-State: APjAAAW8z2slWYnm4b+cKUhPdiuEbnO7C9YEuXLlc1YD57L+PBbcEQJF
        w2AI+dW0wu5JlLl831rvuNSpebP4vdA=
X-Google-Smtp-Source: APXvYqyZzZX2Dww+DruGGPVvwMvfk9iQyAdSFZvGqckgYJ8U2XkI5TyUUhuhAhSJJtnknU9D7mcoBA==
X-Received: by 2002:a19:8b88:: with SMTP id n130mr1735071lfd.210.1581369691703;
        Mon, 10 Feb 2020 13:21:31 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t9sm685208lfl.51.2020.02.10.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 13:21:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 64293100D30; Tue, 11 Feb 2020 00:21:49 +0300 (+03)
Date:   Tue, 11 Feb 2020 00:21:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
Message-ID: <20200210212149.u6zlpi2jefi2vkfg@box>
References: <1581354029-20154-1-git-send-email-cai@lca.pw>
 <20200210172511.GL8731@bombadil.infradead.org>
 <20200210180546.vt7yhdjav5oinij7@box>
 <1581364697.7365.45.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581364697.7365.45.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 02:58:17PM -0500, Qian Cai wrote:
> On Mon, 2020-02-10 at 21:05 +0300, Kirill A. Shutemov wrote:
> > On Mon, Feb 10, 2020 at 09:25:11AM -0800, Matthew Wilcox wrote:
> > > On Mon, Feb 10, 2020 at 12:00:29PM -0500, Qian Cai wrote:
> > > > @@ -2622,7 +2622,7 @@ void filemap_map_pages(struct vm_fault *vmf,
> > > >  		if (page->index >= max_idx)
> > > >  			goto unlock;
> > > >  
> > > > -		if (file->f_ra.mmap_miss > 0)
> > > > +		if (data_race(file->f_ra.mmap_miss > 0))
> > > >  			file->f_ra.mmap_miss--;
> > > 
> > > How is this safe?  Two threads can each see 1, and then both decrement the
> > > in-memory copy, causing it to end up at -1.
> > 
> > Right, it is bogus.
> > 
> > Below is my completely untested attempt on fix this. It still allows
> > races, but they will only lead to missed accounting, but not underflow.
> 
> Looks good to me. Do you plan to send out an official patch?

Feel free to submit it. After testing.

-- 
 Kirill A. Shutemov
