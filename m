Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33493C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE8C20863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JNQbuvAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgBJT6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:58:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37470 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:58:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id c188so7779145qkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYGFsd3OXEi9GKcbRC9zUa47GEfhq/gdmQM5+oaRjMk=;
        b=JNQbuvAHB+LvQM63jiL2mV4AuV62yR92wHEYGBYWqjlVlwwWaa2VuIuFNfIVV9AxxM
         LCc7p8dAknwSBHPaUpGeJTc4Cl+Bc/9Cow3P8M6UsfUVFJ8/XDqtcMdLKvJz91MNPomm
         oXCfpEjxAi/Z46OUHFWKQ7RfXn6MFouEskXfaU2fNg5A43G++snsPNRB5zfkd+dvJBQ/
         DPntkfr8JpdFrIRQMPt9ahOZvUDPmy3Fz1dO7JZNAp6lRsEUXVAq+a1H1o+x4C3khhXA
         MjgyV+re2JYttcQsdYvdFjRgC4KsKNYm+8gQ0sAo3lYBeJMJuRC3ylrSDzw7CtlBv2s3
         LBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYGFsd3OXEi9GKcbRC9zUa47GEfhq/gdmQM5+oaRjMk=;
        b=krJqDGcVEqfVV9bpex1WX9p+XQd1qNO6lz1sNX+IzbKJjOAg/xrqgx/OFYoGc8Ai0b
         PsuH7r4p6PXe4M13D6w0RdjMkvg8jvZMjj0Aj4omVT0L41N87yAlb1T56XMuTUJW8UcE
         xnC066hWWJzqUCwJ44VA1A0nAl02pjp9BDpKpvfSz77xgLnwfX7LfnC7sGTy+yrG6BCW
         ZZtUCog4jgZn/WUoVaQPF+mPC4L3seOGKVAUYKOpE+l6lA65IhLyXd8xWAM6kA+BoVPz
         tsdp5mHMeNnE7p65N1CaHY3MMdqypcbiR/sKKa8jSmmIDFPeiV8WzfgFqraPP480/u+y
         fF+w==
X-Gm-Message-State: APjAAAUsRz0xDIzqFkoFNuZ60XbD9eq/9sTj/OXWpUJgbFbF9dUJmwxj
        jFmZuPq0T3r+JCIzYVHtBHwKxQ==
X-Google-Smtp-Source: APXvYqzaTnBGc+oGvMokoQzM/TDVbYoBgxsUSjJ67hXHMSrH+U1maZqQOSWoGBk9HcC5iQ4M24fHMA==
X-Received: by 2002:a37:8e03:: with SMTP id q3mr2918928qkd.395.1581364699626;
        Mon, 10 Feb 2020 11:58:19 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w16sm627632qkj.135.2020.02.10.11.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 11:58:18 -0800 (PST)
Message-ID: <1581364697.7365.45.camel@lca.pw>
Subject: Re: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
From:   Qian Cai <cai@lca.pw>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 14:58:17 -0500
In-Reply-To: <20200210180546.vt7yhdjav5oinij7@box>
References: <1581354029-20154-1-git-send-email-cai@lca.pw>
         <20200210172511.GL8731@bombadil.infradead.org>
         <20200210180546.vt7yhdjav5oinij7@box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 21:05 +0300, Kirill A. Shutemov wrote:
> On Mon, Feb 10, 2020 at 09:25:11AM -0800, Matthew Wilcox wrote:
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
> Right, it is bogus.
> 
> Below is my completely untested attempt on fix this. It still allows
> races, but they will only lead to missed accounting, but not underflow.

Looks good to me. Do you plan to send out an official patch?

> 
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1784478270e1..1919d37c646a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2365,6 +2365,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	struct address_space *mapping = file->f_mapping;
>  	struct file *fpin = NULL;
>  	pgoff_t offset = vmf->pgoff;
> +	unsigned mmap_miss;
>  
>  	/* If we don't want any read-ahead, don't bother */
>  	if (vmf->vma->vm_flags & VM_RAND_READ)
> @@ -2380,14 +2381,15 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	}
>  
>  	/* Avoid banging the cache line if not needed */
> -	if (ra->mmap_miss < MMAP_LOTSAMISS * 10)
> -		ra->mmap_miss++;
> +	mmap_miss = READ_ONCE(ra->mmap_miss);
> +	if (mmap_miss < MMAP_LOTSAMISS * 10)
> +		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
>  
>  	/*
>  	 * Do we miss much more than hit in this file? If so,
>  	 * stop bothering with read-ahead. It will only hurt.
>  	 */
> -	if (ra->mmap_miss > MMAP_LOTSAMISS)
> +	if (mmap_miss > MMAP_LOTSAMISS)
>  		return fpin;
>  
>  	/*
> @@ -2413,13 +2415,15 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	struct file_ra_state *ra = &file->f_ra;
>  	struct address_space *mapping = file->f_mapping;
>  	struct file *fpin = NULL;
> +	unsigned int mmap_miss;
>  	pgoff_t offset = vmf->pgoff;
>  
>  	/* If we don't want any read-ahead, don't bother */
>  	if (vmf->vma->vm_flags & VM_RAND_READ)
>  		return fpin;
> -	if (ra->mmap_miss > 0)
> -		ra->mmap_miss--;
> +	mmap_miss = READ_ONCE(ra->mmap_miss);
> +	if (mmap_miss)
> +		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
>  	if (PageReadahead(page)) {
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		page_cache_async_readahead(mapping, ra, file,
> @@ -2586,7 +2590,9 @@ void filemap_map_pages(struct vm_fault *vmf,
>  	unsigned long max_idx;
>  	XA_STATE(xas, &mapping->i_pages, start_pgoff);
>  	struct page *page;
> +	unsigned long mmap_miss;
>  
> +	mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
>  	rcu_read_lock();
>  	xas_for_each(&xas, page, end_pgoff) {
>  		if (xas_retry(&xas, page))
> @@ -2622,8 +2628,8 @@ void filemap_map_pages(struct vm_fault *vmf,
>  		if (page->index >= max_idx)
>  			goto unlock;
>  
> -		if (file->f_ra.mmap_miss > 0)
> -			file->f_ra.mmap_miss--;
> +		if (mmap_miss > 0)
> +			mmap_miss--;
>  
>  		vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>  		if (vmf->pte)
> @@ -2643,6 +2649,7 @@ void filemap_map_pages(struct vm_fault *vmf,
>  			break;
>  	}
>  	rcu_read_unlock();
> +	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
>  }
>  EXPORT_SYMBOL(filemap_map_pages);
>  
