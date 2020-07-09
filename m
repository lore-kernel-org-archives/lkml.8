Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DF7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D96F207FC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Uc4CCtML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgGIPzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgGIPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:55:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0D3C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:55:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y13so1436950lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ko2toLCZVcB1lleYvRhScChtwEJOK0oSQV22Yurja2Q=;
        b=Uc4CCtMLCs3lO9xhdmBONzGWRiRwT9i1ZMePGIYt4l0xaGLYpohw0IerOblGgyhLoW
         AT5UmJkwwuxoQRcctui1mXrBp211sfFdtr7d5kPb5DLJKl327ienkkdxSaj8OuYdeb0V
         gD1sYjx5U1/q4X6Lx2NbhLKuVFaBneMzUK5o+BllCwhWYGnXAbgfroWFhQSbqErEmWDK
         +AP91wv6In/CR0I+dXAnClibT5z9pp3YulfddtucRksexscSOh1ki4NY5LEcEYtJB1y0
         5GdX3YRnyOvUjqVkLqhHFf5V1TWpqXAIYide9TRITdEoQ58rlC8+trgvboocTbHdQGcQ
         dI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ko2toLCZVcB1lleYvRhScChtwEJOK0oSQV22Yurja2Q=;
        b=aziQ2ming0ye4G6TCf9Tq4rgT5qmooXZmqSQWIFIwNwnGi52sZnDqw38zLCp8IUNft
         thBsMe0ZXLX2YxfZ7IERzWex5MHyvHyhS+R4msIfr5qiG7UTXCg5qmuFQhH7VUBQcOdS
         GBuxgPGUuEteaE7h2ax5Sh8eWRmKKLjlEzinYbKmCy7J1quOkuzuLewJ/ZYhZF8AVHDY
         GNa8+BNAFPzCwVemBkgSqGE2S9qqTjC1VUv72pwsqAsXRdgwMoB5o1f8QcT/zhZQvN6p
         10a5p7T3T3D1vGj/aUzNtepErdU8Bt9m+I7xDLJDE9xBPwMYgTbVAzukoAA82pAwCdWC
         XIiw==
X-Gm-Message-State: AOAM532Kgzx4yQNoVOLtVU+jPlbMhQ46ll/ddPddToJQs3LF3Fl9+Juj
        7gm88wqFyg/gLXJKavUmugTQ0Q==
X-Google-Smtp-Source: ABdhPJz4tCeIwbs8YS4yldpnaa+nxdD/inUHg/Ru6+3qcswHKG+9xwpsXiqVxAdhy33UuaZPpmiZ1Q==
X-Received: by 2002:a05:6512:250:: with SMTP id b16mr39400876lfo.67.1594310137811;
        Thu, 09 Jul 2020 08:55:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q21sm933168ljj.67.2020.07.09.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 08:55:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BD87510222B; Thu,  9 Jul 2020 18:55:38 +0300 (+03)
Date:   Thu, 9 Jul 2020 18:55:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v15 05/21] mm/thp: move lru_add_page_tail func to
 huge_memory.c
Message-ID: <20200709155538.mf3gxutgckz7p67i@box>
References: <1594122412-28057-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594122412-28057-6-git-send-email-alex.shi@linux.alibaba.com>
 <9fa2cf92-c4a0-02ca-1f02-7ef71952de18@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fa2cf92-c4a0-02ca-1f02-7ef71952de18@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 08:00:11PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/7/7 下午7:46, Alex Shi 写道:
> >  
> > +static void lru_add_page_tail(struct page *page, struct page *page_tail,
> > +				struct lruvec *lruvec, struct list_head *list)
> > +{
> > +	VM_BUG_ON_PAGE(!PageHead(page), page);
> > +	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
> > +	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> > +	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> > +
> > +	if (!list)
> > +		SetPageLRU(page_tail);
> > +
> > +	if (likely(PageLRU(page)))
> > +		list_add_tail(&page_tail->lru, &page->lru);
> > +	else if (list) {
> > +		/* page reclaim is reclaiming a huge page */
> > +		get_page(page_tail);
> > +		list_add_tail(&page_tail->lru, list);
> > +	} else {
> > +		/*
> > +		 * Head page has not yet been counted, as an hpage,
> > +		 * so we must account for each subpage individually.
> > +		 *
> > +		 * Put page_tail on the list at the correct position
> > +		 * so they all end up in order.
> > +		 */
> > +		add_page_to_lru_list_tail(page_tail, lruvec,
> > +					  page_lru(page_tail));
> 
> 
> I missed some points for this function, since in the call chain:
> split_huge_page() to lru_add_page_tail, the head page's lru won't be
> set when !PageLRU(head). But the other page_tail are add to lru list here
> Is it ok for this situation?

It doesn't differ from the situation when some pages are isolated from
LRU. Tail page has become completely on its own after
__split_huge_page_tail() has completed, it's not tied to the head page.

-- 
 Kirill A. Shutemov
