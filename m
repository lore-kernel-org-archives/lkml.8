Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F7CC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE822168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581537207;
	bh=rpCM9ekTToj/j8DzvkJPe9VjJir7de0FzdYMpj4d/bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tC+k6gJ3kG65JDO/Sxz6FLUQcKLV1FOfcBg4Af8sMdi6HJjvHrEXOGjuutnf/OD4w
	 AAbsbRD/cPj4fLoFAOHim+0oa49OLYbFQTmNWGXAXKccyv9AJQ6KoUbR5iONHL/Z1Q
	 hIK2V5qqqOTg/XqACE7N0P56AhCDbdHKgPdro+bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgBLTx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:53:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35154 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgBLTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:53:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id y73so1759415pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=988zIL8d+x57bhbL7IA3JnepL7Xa/OoILgzP9jiq4TY=;
        b=qZnrSz369m8/FKxgWHq63V8eD4+egg40oz+Cpc4wyRGPR7h+iml6b27dFEKUnWPGnZ
         l7rPa7UyXBs6uzEneN/HbQGA7NigZLvd3cV+PkHW48SAAnWN3iDf3xTCzhOHJCH7XN/D
         M+Dz0vG4B93gT8mZVRZvcng4Rkv9vH2iXwARsp+Kqp8YGrAUnJRcSX0nCpkjvwXv4G6g
         +8m2dH4CSJ1RnXmkmAXOitqpQWQ3ZAZJJVxTw1BIsrtY/+0PQW3hP+QXaFVEKF8AHczP
         xjyGLOUfc2CxPBoj6cmBPuxjF7Iy5O6wMDf612h4m9/mXL0EsqaGzhQS7c+AjgZAxSrB
         8jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=988zIL8d+x57bhbL7IA3JnepL7Xa/OoILgzP9jiq4TY=;
        b=agThd3aiFpWaWXx4VBJ3P2NZmjRMyiTHdMKH5tFraFUm1hLimh3C8aP9jMbiMzhMpf
         I9z8O2sCy2AmsRtdu+gO13aYW0njTHRJb6Zbo5JAufSFkk6pzQVzURZRTRhWGf02epiL
         JQkwHAYS6txJ0e4jCGZm1ugCSF0gtGLERbO1En2KAbjfA1K/C3rfemoMoTTpDv4X4Rfo
         IEyAlX68ITa2YrkPRfRm3rCQGmg6A5Pa8J3Z3p2R46SX7XJ5KkqO95pY+AwfdR0GmnRP
         GdBTUWMciBYXVthOrKwk8kOLcCQrIFyLSDBko7eotE4wbpu7YVm9yoAtE1iXda9UOK21
         9E5g==
X-Gm-Message-State: APjAAAXu/rs5VBk/xETjsPzaxfn/Z/pbyG02x0MrEMOLCppTTtTDihpL
        9T4xtl/9IVBZbIytygtHKmI=
X-Google-Smtp-Source: APXvYqz47fSDzYXvypxdE3JPoalztTIbDa6+X8zSSTbWFSvKaq4eE2hMqiAowqb0sItclFu54Z778A==
X-Received: by 2002:a63:e18:: with SMTP id d24mr13786719pgl.36.1581537205345;
        Wed, 12 Feb 2020 11:53:25 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id dw10sm82303pjb.11.2020.02.12.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 11:53:24 -0800 (PST)
Date:   Wed, 12 Feb 2020 11:53:22 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200212195322.GA83146@google.com>
References: <20200211035004.GA242563@google.com>
 <20200211035412.GR8731@bombadil.infradead.org>
 <20200211042536.GB242563@google.com>
 <20200211122323.GS8731@bombadil.infradead.org>
 <20200211163404.GC242563@google.com>
 <20200211172803.GA7778@bombadil.infradead.org>
 <20200211175731.GA185752@google.com>
 <20200212101804.GD25573@quack2.suse.cz>
 <20200212174015.GB93795@google.com>
 <20200212182851.GG7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212182851.GG7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:28:51AM -0800, Matthew Wilcox wrote:
> On Wed, Feb 12, 2020 at 09:40:15AM -0800, Minchan Kim wrote:
> > How about this?
> > 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 1bf83c8fcaa7..d07d602476df 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -363,8 +363,28 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
> >  /* PG_readahead is only used for reads; PG_reclaim is only for writes */
> >  PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
> >  	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
> > -PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> > -	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> > +
> > +SETPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> > +CLEARPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> > +
> > +/*
> > + * Since PG_readahead is shared with PG_reclaim of the page flags,
> > + * PageReadahead should double check whether it's readahead marker
> > + * or PG_reclaim. It could be done by PageWriteback check because
> > + * PG_reclaim is always with PG_writeback.
> > + */
> > +static inline int PageReadahead(struct page *page)
> > +{
> > +	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
> > +	return test_bit(PG_reclaim, &(page)->flags) && !PageWriteback(page);
> 
> Why not ...
> 
> 	return page->flags & (1UL << PG_reclaim | 1UL << PG_writeback) ==
> 		(1UL << PG_reclaim);
> 
> > +static inline int TestClearPageReadahead(struct page *page)
> > +{
> > +	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
> > +
> > +	return test_and_clear_bit(PG_reclaim, &page->flags) && !PageWriteback(page);
> 
> That's definitely wrong.  It'll clear PageReclaim and then pretend it did
> nothing wrong.
> 
> 	return !PageWriteback(page) ||
> 		test_and_clear_bit(PG_reclaim, &page->flags);
> 

Much better, Thanks for the review, Matthew!
If there is no objection, I will send two patches to Andrew.
One is PageReadahead strict, the other is limit retry from mm_populate.

From 351236413beda22cb7fec1713cad4360de930188 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Wed, 12 Feb 2020 09:28:21 -0800
Subject: [PATCH] mm: make PageReadahead more strict

PG_readahead flag is shared with PG_reclaim but PG_reclaim is only
used in write context while PG_readahead is used for read context.

To make it clear, let's introduce PageReadahead wrapper with
!PageWriteback check so it could make code clear and we could drop
PageWriteback check in page_cache_async_readahead, which removes
pointless dropping mmap_sem.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/page-flags.h | 28 ++++++++++++++++++++++++++--
 mm/readahead.c             |  6 ------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1bf83c8fcaa7..f91a9b2a49bd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -363,8 +363,32 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+
+SETPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+CLEARPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+
+/*
+ * Since PG_readahead is shared with PG_reclaim of the page flags,
+ * PageReadahead should double check whether it's readahead marker
+ * or PG_reclaim. It could be done by PageWriteback check because
+ * PG_reclaim is always with PG_writeback.
+ */
+static inline int PageReadahead(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
+
+	return (page->flags & (1UL << PG_reclaim | 1UL << PG_writeback)) ==
+		(1UL << PG_reclaim);
+}
+
+/* Clear PG_readahead only if it's PG_readahead, not PG_reclaim */
+static inline int TestClearPageReadahead(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
+
+	return !PageWriteback(page) ||
+			test_and_clear_bit(PG_reclaim, &page->flags);
+}
 
 #ifdef CONFIG_HIGHMEM
 /*
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..85b15e5a1d7b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -553,12 +553,6 @@ page_cache_async_readahead(struct address_space *mapping,
 	if (!ra->ra_pages)
 		return;
 
-	/*
-	 * Same bit is used for PG_readahead and PG_reclaim.
-	 */
-	if (PageWriteback(page))
-		return;
-
 	ClearPageReadahead(page);
 
 	/*
-- 
2.25.0.225.g125e21ebc7-goog

