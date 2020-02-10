Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FEC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E7020715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ecRg2C95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBJSFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:05:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40238 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:05:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id c23so4893064lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y4Bm0V75xs4E9d5KoFxNlIFDOvUlqLn1HJW2IQtl9+k=;
        b=ecRg2C95MZZKpuyX1OS5SgB5WMpKOHvTN+P+xXrF4pWw6qe6pnsDcwpCcbBA6DVH7/
         LUoljMghOFcAWCo24+4hT9CfYC6pSM1WPU58MldU3f9xsI4KXouq3B3cyKSjICwxPoVJ
         eNIwYAZQQ5rBt2IA4DOGy8IgUmdq6Zx5UFgub+VNbOwIoetCh72nstuIjGTam3c7ViVF
         pqnU+GEkiK0F8bHdJbzXfIv6saRgOpFZhbG/80sJORZMo3y6bhXz32nLF9uKBLJAKgSZ
         Y9AaK2vRjHq7mj5Yo2A1sYLQM0E2XrHpEjqMQX0gKOD9urLrmUaKN5xWabHJO1jX1CCy
         HrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y4Bm0V75xs4E9d5KoFxNlIFDOvUlqLn1HJW2IQtl9+k=;
        b=mLJeKBhz2V3/6hPlHhItXLgEepEUn5NZ2i+b/ZfEpxv5c5VudPfCRqgR/PApD+fSzx
         F26iZWK5gNT2iB/8jt1g4VrlzCS3gDgoSvcunRxjaD8LSNS0TyDaCGasBfe0TjH1fUAd
         tmFlZ1OuIoHZrSVII7u6AARou4ydz2dMRr9YIFtgnPSmKQhsTfFpbID648L48b+tiUtV
         uN1Ojs+49SYqxM0ltY7qL1jcbwKePuZaZou0fv7D4JfqGKNJRKcr4nyzQgjR9eiZD9kY
         lr/PllauCDIHmUK94sF9hh8Mqe1PT3E2I52pbb3iiBp+dKb2kJWmR56B2StJAIkL162j
         IjQg==
X-Gm-Message-State: APjAAAWuXh6U+gv/JoYPnv84DbxJvcahXkS9oxtAZzWgabRysuVwmxNZ
        rJFILgtlZ/Uy0K5T4bk2VfEhDg==
X-Google-Smtp-Source: APXvYqxmTVT7EcpvAphn04QlNxyA3w7m51t8Ttmm6ajkNMfG0g8GNHLr1okN8JW25tAyraGX4AiChA==
X-Received: by 2002:a19:a40a:: with SMTP id q10mr1352460lfc.204.1581357928579;
        Mon, 10 Feb 2020 10:05:28 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w71sm630671lff.0.2020.02.10.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:05:28 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id CD21C100D30; Mon, 10 Feb 2020 21:05:46 +0300 (+03)
Date:   Mon, 10 Feb 2020 21:05:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
Message-ID: <20200210180546.vt7yhdjav5oinij7@box>
References: <1581354029-20154-1-git-send-email-cai@lca.pw>
 <20200210172511.GL8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210172511.GL8731@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 09:25:11AM -0800, Matthew Wilcox wrote:
> On Mon, Feb 10, 2020 at 12:00:29PM -0500, Qian Cai wrote:
> > @@ -2622,7 +2622,7 @@ void filemap_map_pages(struct vm_fault *vmf,
> >  		if (page->index >= max_idx)
> >  			goto unlock;
> >  
> > -		if (file->f_ra.mmap_miss > 0)
> > +		if (data_race(file->f_ra.mmap_miss > 0))
> >  			file->f_ra.mmap_miss--;
> 
> How is this safe?  Two threads can each see 1, and then both decrement the
> in-memory copy, causing it to end up at -1.

Right, it is bogus.

Below is my completely untested attempt on fix this. It still allows
races, but they will only lead to missed accounting, but not underflow.


diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..1919d37c646a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2365,6 +2365,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct address_space *mapping = file->f_mapping;
 	struct file *fpin = NULL;
 	pgoff_t offset = vmf->pgoff;
+	unsigned mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
@@ -2380,14 +2381,15 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	}
 
 	/* Avoid banging the cache line if not needed */
-	if (ra->mmap_miss < MMAP_LOTSAMISS * 10)
-		ra->mmap_miss++;
+	mmap_miss = READ_ONCE(ra->mmap_miss);
+	if (mmap_miss < MMAP_LOTSAMISS * 10)
+		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
 
 	/*
 	 * Do we miss much more than hit in this file? If so,
 	 * stop bothering with read-ahead. It will only hurt.
 	 */
-	if (ra->mmap_miss > MMAP_LOTSAMISS)
+	if (mmap_miss > MMAP_LOTSAMISS)
 		return fpin;
 
 	/*
@@ -2413,13 +2415,15 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
 	struct file *fpin = NULL;
+	unsigned int mmap_miss;
 	pgoff_t offset = vmf->pgoff;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
-	if (ra->mmap_miss > 0)
-		ra->mmap_miss--;
+	mmap_miss = READ_ONCE(ra->mmap_miss);
+	if (mmap_miss)
+		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
 	if (PageReadahead(page)) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_readahead(mapping, ra, file,
@@ -2586,7 +2590,9 @@ void filemap_map_pages(struct vm_fault *vmf,
 	unsigned long max_idx;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *page;
+	unsigned long mmap_miss;
 
+	mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_pgoff) {
 		if (xas_retry(&xas, page))
@@ -2622,8 +2628,8 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (page->index >= max_idx)
 			goto unlock;
 
-		if (file->f_ra.mmap_miss > 0)
-			file->f_ra.mmap_miss--;
+		if (mmap_miss > 0)
+			mmap_miss--;
 
 		vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		if (vmf->pte)
@@ -2643,6 +2649,7 @@ void filemap_map_pages(struct vm_fault *vmf,
 			break;
 	}
 	rcu_read_unlock();
+	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 }
 EXPORT_SYMBOL(filemap_map_pages);
 
-- 
 Kirill A. Shutemov
