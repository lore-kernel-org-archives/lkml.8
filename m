Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B5CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33D721D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT3gD/LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgIKIPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKIPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:15:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7DC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:15:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so10561457wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhS9snf38WEKxTPI94C4Awp/1a6Jee0RpAYvecBwpL0=;
        b=JT3gD/LNdjFGWnsGebdP8WfXaR2P6P557JuGzr5wvFM7AokYUjUnM8t559vUxk4DTv
         6riqP9hf7eADkL25tu59h8JVzklut8402hZ1GFOp1m8NrtkPy1Lw1+5yzIUQetbEx1Yj
         IOlwavPs12/SgICtJGy75jXvFqoDKH64QYYBkjGkAyWGdZgfHjKwL15FbA9mQ/EUs/8y
         F52iDfO/kYomFk0DZ7CJUBAaM13A/9sjft0LH1ki+zdsTrawepp7bs3/v+2C163AUyPi
         nKQCrZZU1HgUp8XnIGgE0Cp87WPnH3Yf93so9WGOFTi2YmzQExQHcUR9GXfhlo4jeiLn
         yC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhS9snf38WEKxTPI94C4Awp/1a6Jee0RpAYvecBwpL0=;
        b=Qx1Z/Yjm1AFWU8FclZAN7fpkajZFg75K//tc2r9N2mavDUW3gvUlpJAYa7aSY1kVDz
         gNsns56H8NxDt+tGCdP7K93+Lviy1Y4+76nTTMxpN64rpuPUnV5gnik7f44WgLUE4v45
         x30tyCqFrD1QO0mjCDsn6YO8+6tvqdInB6OQqC5zyqMrLvxglRu3xSvNAMRgKAh7kIzq
         esh9J178nFFZ4ChJaIOLFk2vy7aCL3ktXwslNTKjQBY595r8Rg8lM22fW8suRwbzfqe4
         UlD6UkO4yWn+kUYVk5msuku/CzJV9tPjYn6Lo8FGZqpEboOK9L6y3lbt/5lFiX7r5HxX
         S/6g==
X-Gm-Message-State: AOAM531F8rH87P9fBxNJzUHxALwlCxYtc/brbB7y+FO4gimEBkA2/erR
        YwIJlueal2IktL+4FRVGJkU=
X-Google-Smtp-Source: ABdhPJwKcE72G+WrzGoEXjw/Ya+U8r8X+/spqaEzXW112JhBTPS8ztAKhFjyb+HKy4czc7JX9VXQ3A==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr823824wrs.107.1599812131154;
        Fri, 11 Sep 2020 01:15:31 -0700 (PDT)
Received: from ubuntu-laptop ([2a01:598:b906:6939:8868:1825:7dd4:faeb])
        by smtp.googlemail.com with ESMTPSA id 9sm2748407wmf.7.2020.09.11.01.15.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 01:15:30 -0700 (PDT)
Message-ID: <ef82be594709a8f954f4933968bd96888e589df3.camel@gmail.com>
Subject: Re: [PATCH RFC] mm: Let readahead submit larger batches of pages in
 case of ra->ra_pages == 0
From:   Bean Huo <huobean@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Date:   Fri, 11 Sep 2020 10:15:24 +0200
In-Reply-To: <20200904110938.d9a2cb53a58e67a15c960f47@linux-foundation.org>
References: <20200904144807.31810-1-huobean@gmail.com>
         <20200904110938.d9a2cb53a58e67a15c960f47@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 2020-09-04 at 11:09 -0700, Andrew Morton wrote:
> On Fri,  4 Sep 2020 16:48:07 +0200 Bean Huo <huobean@gmail.com>
> wrote:
> 
> > From: Bean Huo <beanhuo@micron.com>
> > 
> > Current generic_file_buffered_read() will break up the larger
> > batches of pages
> > and read data in single page length in case of ra->ra_pages == 0.
> > This patch is
> > to allow it to pass the batches of pages down to the device if the
> > supported
> > maximum IO size >= the requested size.
> > 
> > ...
> > 
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2062,6 +2062,7 @@ ssize_t generic_file_buffered_read(struct
> > kiocb *iocb,
> >  	struct file *filp = iocb->ki_filp;
> >  	struct address_space *mapping = filp->f_mapping;
> >  	struct inode *inode = mapping->host;
> > +	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
> >  	struct file_ra_state *ra = &filp->f_ra;
> >  	loff_t *ppos = &iocb->ki_pos;
> >  	pgoff_t index;
> > @@ -2098,9 +2099,14 @@ ssize_t generic_file_buffered_read(struct
> > kiocb *iocb,
> >  		if (!page) {
> >  			if (iocb->ki_flags & IOCB_NOIO)
> >  				goto would_block;
> > -			page_cache_sync_readahead(mapping,
> > -					ra, filp,
> > -					index, last_index - index);
> > +
> > +			if (!ra->ra_pages && bdi->io_pages >=
> > last_index - index)
> > +				__do_page_cache_readahead(mapping,
> > filp, index,
> > +							  last_index -
> > index, 0);
> > +			else
> > +				page_cache_sync_readahead(mapping, ra,
> > filp,
> > +							  index,
> > +							  last_index -
> > index);
> >  			page = find_get_page(mapping, index);
> >  			if (unlikely(page == NULL))
> >  				goto no_cached_page;
> 
> I assume this is a performance patch.  What are the observed changes
> in behaviour?
> 
> What is special about ->ra_pages==0?  Wouldn't this optimization
> still
> be valid if ->ra_pages==2?
> 
> Doesn't this defeat the purpose of having ->ra_pages==0?


Hi Andrew
Sorry, I am still not quite understanding your above three questions. 

Based on my shallow understanding, ra_pages is associated with
read_ahead_kb. Seems ra_pages controls the maximum read-ahead window
size, but it doesn't work when the requested size exceeds ra_pages. 

If I set the read_ahead_kb to 0, also, as Christoph mentioned, MTD
forcibly sets ra_pages to 0.  I think the intention is that only wants
to disable read-ahead, however, doesn't want
generic_file_buffered_read() to split the request and read data with
4KB chunk size separately.

Thanks,
Bean

