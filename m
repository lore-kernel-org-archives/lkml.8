Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AC9C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 04:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4139E206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 04:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581395143;
	bh=3QMBxcD7fDbKTeP+bFi3ghcNsyrvYeoitAhcCrdVhL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wmewKuqFPt4DtGtfyySvfylCAKmrC2vB42MOetYWjXzNu0kRJdLkV1i3njOmwJgY5
	 g2aLCYko5H7wEHO5X0qrnF+QpsOEFBQLKgXGB3Sz4Tna5qNQ9cfeyd+AisDIfSIqgS
	 z6VL2y7+MDK0cWlMRquMUGtGRcZWLBkX8H9jZdVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgBKEZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 23:25:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36515 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBKEZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 23:25:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so3718947plm.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 20:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9KO1k9P8J3nM1/EjQwGBTH9H+54xdTL4UiNZzfIiIA=;
        b=LDfCTC/a9lACRyt/I8wPrZgYqbnFBRGBC5bGiEZv10ocg2VsnYAr/7t/zbq+YwiAle
         xPrpWdEcKjufQEEVPSNMwdgqXPCt9h3S1gFC7Rcjs7rT68Fi+uv1XwuowH2lTQPWQX3J
         bCSOpoaxOwtvKXSTQ51u526lKJIK0yxRPnduJzb+SlZX0dbLQCVyn7SXXdlmnxeDetLK
         9tiDXrKwPxX2gA2VGfnTQfNLupM7uerPtbOQePIlF6d+S1XnL9aV3U6K4iDC5Yz1Hawu
         NRc+GoPxqFIndLVJe5E9HuoYCphp7G/N8Vyfd4lGitbbf5V4u6X1nsFzCavInLlp2irW
         fI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9KO1k9P8J3nM1/EjQwGBTH9H+54xdTL4UiNZzfIiIA=;
        b=CLC2DERIVvR2XHLvmVGMSoYDv8JJnpvqs0hxV1t0jCuF9WEzhyoD/EYP/0rTdUb4xU
         VoKY+mBELsPUE65GUcQ496Cut7hrV2gFshhZPcRKoxi5Z6LhusN/py5GTYCXpKj0Tasg
         YQ+tHJdb+CBCr+M+RwFmu5Z9hORjcoxzy9xqb/9N1QcitfQP+MKBdfXVSGpXDU/8Kykm
         M7wX8bppLcN6qgAeuCeCTwEMNMzyrX5PcOxcIyTNYWWbqQQVI50bx84svRUQfuoMTndf
         pCqKdaK8wYGTC32fLM6x1dorZwEYOkx7YZlBQ0QMOL7vXMLnj4Eam2fNCHYL8eY2tg7u
         WLbw==
X-Gm-Message-State: APjAAAXqsRoub2SIBparc+mSm7PlewbXgNNiaXDFS2g6jKZHxHAv5srK
        xBaMtaYO3Rf6BJOrWREiiifgBHmG
X-Google-Smtp-Source: APXvYqxJp2Ga/NJR5Trp9Ws/QTu3Tgarvy4sJ1sGXdurS3XAnPql3Ks1sGNlySgCG+34o82mwQ7xcg==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr1341669pla.17.1581395139532;
        Mon, 10 Feb 2020 20:25:39 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z10sm1639684pgz.88.2020.02.10.20.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 20:25:38 -0800 (PST)
Date:   Mon, 10 Feb 2020 20:25:36 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200211042536.GB242563@google.com>
References: <20200211001958.170261-1-minchan@kernel.org>
 <20200211011021.GP8731@bombadil.infradead.org>
 <20200211035004.GA242563@google.com>
 <20200211035412.GR8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211035412.GR8731@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 07:54:12PM -0800, Matthew Wilcox wrote:
> On Mon, Feb 10, 2020 at 07:50:04PM -0800, Minchan Kim wrote:
> > On Mon, Feb 10, 2020 at 05:10:21PM -0800, Matthew Wilcox wrote:
> > > On Mon, Feb 10, 2020 at 04:19:58PM -0800, Minchan Kim wrote:
> > > >       filemap_fault
> > > >         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> > > 
> > > Uh ... That shouldn't be possible.
> > 
> > Please see shrink_page_list. Vmscan uses PG_reclaim to accelerate
> > page reclaim when the writeback is done so the page will have both
> > flags at the same time and the PG reclaim could be regarded as
> > PG_readahead in fault conext.
> 
> What part of fault context can make that mistake?  The snippet I quoted
> below is from page_cache_async_readahead() where it will clearly not
> make that mistake.  There's a lot of code here; please don't presume I
> know all the areas you're talking about.

Sorry about being not clear. I am saying  filemap_fault ->
do_async_mmap_readahead

Let's assume the page is hit in page cache and vmf->flags is !FAULT_FLAG
TRIED so it calls do_async_mmap_readahead. Since the page has PG_reclaim
and PG_writeback by shrink_page_list, it goes to 

do_async_mmap_readahead
  if (PageReadahead(page))
    fpin = maybe_unlock_mmap_for_io();
    page_cache_async_readahead
      if (PageWriteback(page))
        return;
      ClearPageReadahead(page); <- doesn't reach here until the writeback is clear
      
So, mm_populate will repeat the loop until the writeback is done.
It's my just theory but didn't comfirm it by the testing.
If I miss something clear, let me know it.

Thanks!

> 
> > > 
> > >         /*
> > >          * Same bit is used for PG_readahead and PG_reclaim.
> > >          */
> > >         if (PageWriteback(page))
> > >                 return;
> > > 
> > >         ClearPageReadahead(page);
