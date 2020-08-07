Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4906CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DD822CA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="tosFGBkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgHGQsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgHGQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:48:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E58C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 09:48:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so2824801ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/WqT29bWdZ2/40qJaFhIMPQiWP1q4wAK2hW9rsZct4A=;
        b=tosFGBkUdBtkORQ302MrskHF6W1NJn73L8KF7SI5iRkle/CF4Dwt4NZFGVXebtmzXG
         HsBYvr72pzC/KUPThj8WJTCzrd+v6BVPLW1y8SzgtryTby72VWeXTx+CT2MKNB1YDfN9
         SA7YvpKGGmzeYGUt88bvNeJ/pp5bOH3gVflhPad4MLNtkJKR1Td9doEOZVUabMRXTzJg
         ugwjYxmCQMe4lM9xs7oBi7q8EiY6yI6Xp1IuCsC24IcBm4Vj6PyDCgjft4fvTkggp7Gt
         DQh9RYUPgrd0T4fDvmOwMQE0Imr/njG3gTNPY9IfpntfDN93DxOJMob1OYnDnLcvcEoo
         x52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/WqT29bWdZ2/40qJaFhIMPQiWP1q4wAK2hW9rsZct4A=;
        b=Q6U6pOXR9kFO/TKOaj58dMv0qy4MkbRxN1tPLwZRH5u2pwM9MjFN9Nc3TuqJ9MP4k5
         uedmoLHHlnakWN3lfkyLXtI0cCaUOajfqKRWQ6j2exL9GytBsxb4YW7YcdsrccsP/ESq
         ZOit3lnuURhUK2vQWrRcy4RD/q2tu8FVEhuy9PB6JUJr1CfG4s942uk1VwresHb2CkN7
         rO6upolMPAbWdB4YWo13izOXLdnSuzcRFivNqrTglN2XuB1MA9nbNIfvb0sphKAghNxq
         EtPVGpALJKkJdh+Hs/kU6bsWT1U5Hq0l8qdOMDAAKtZq8LlO/yxyI23DQMCK5gEhdgD+
         nqkQ==
X-Gm-Message-State: AOAM533zdTposshwrzpuRWaglhbtNKjzLmTv/D4dW7ZKQ6ziu9s7PKBi
        +NksGX5EEN/UgRsLy2fDznA13w==
X-Google-Smtp-Source: ABdhPJyWCK5+nfQ9lsBZI6fqTkGgAHf6OjC/UpCb+1nuGec3mjuNu7oJmNNVKY/wIJIFaaGQ7Mp9IA==
X-Received: by 2002:a05:651c:110:: with SMTP id a16mr7191490ljb.152.1596818886276;
        Fri, 07 Aug 2020 09:48:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v9sm4341665lja.81.2020.08.07.09.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 09:48:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 74CED102FA7; Fri,  7 Aug 2020 19:48:05 +0300 (+03)
Date:   Fri, 7 Aug 2020 19:48:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        cai@lca.pw, rppt@linux.ibm.com, vbabka@suse.cz,
        william.kucharski@oracle.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm, dump_page: do not crash with bad
 compound_mapcount()
Message-ID: <20200807164805.xm4ingj4crdiemol@box>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
 <20200807143504.4kudtd4xeoqaroqg@box>
 <20200807151029.GE17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807151029.GE17456@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 04:10:29PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 07, 2020 at 05:35:04PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Aug 04, 2020 at 02:48:07PM -0700, John Hubbard wrote:
> > > If a compound page is being split while dump_page() is being run on that
> > > page, we can end up calling compound_mapcount() on a page that is no
> > > longer compound. This leads to a crash (already seen at least once in
> > > the field), due to the VM_BUG_ON_PAGE() assertion inside
> > > compound_mapcount().
> 
> [...]
> > > +static inline int head_mapcount(struct page *head)
> > > +{
> > 
> > Do we want VM_BUG_ON_PAGE(!PageHead(head), head) here?
> 
> Well, no.  That was the point of the bug report -- by the time we called
> compound_mapcount, the page was no longer a head page.

Right. VM_BUG_ON_PAGE(PageTail(head), head)?

> > > A similar problem is possible, via compound_pincount() instead of
> > > compound_mapcount().
> > > 
> > > In order to avoid this kind of crash, make dump_page() slightly more
> > > robust, by providing a pair of simpler routines that don't contain
> > > assertions: head_mapcount() and head_pincount().
> > 
> > I find naming misleading. head_mapcount() and head_pincount() sounds like
> > a mapcount/pincount of the head page, but it's not. It's mapcount and
> > pincount of the compound page.
> 
> OK, point taken.  I might go for head_compound_mapcount()?  Or as I
> originally suggested, just opencoding it like we do in __page_mapcount().

I'm fine either way.

-- 
 Kirill A. Shutemov
