Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A66C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28D72071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CBk/rJNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgFONcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFONcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:32:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27E4C061A0E;
        Mon, 15 Jun 2020 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lp5DlO/OShb3qWPJbf6KTclUJMM2vVsGWEVRG2GOUyg=; b=CBk/rJNRZrGoDsIgXRbmF83ahA
        8HZXVRWDoLfj8AbfLPcAlvA9mzhbGd8Hr4S8a6ES6MxWO3tK7M35sTWBqKnOspS2gZp6EoC7f9Ebx
        T4sgeFTe/+gUCb1OS846QQudO3EPoj4VpoZKSv3ItDA6woMEtOPHPsSmmjTIXzYjBkPWa6Iozds8s
        BXkuDVBB3m73e9mr83YyjzbDweWuTNByhJNT4mlcLNB3whw5TLFEult9WrebvFeXLTasIwoWIOiMl
        buAZPYOJzDBircZ8r7zc7dYqVP7XznunrObBkS2aGl244S/KbAIzAkA/9iBpbGDrK9E6UVyFjuBTz
        ZUjYUkRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkpDq-0007J0-DO; Mon, 15 Jun 2020 13:32:22 +0000
Date:   Mon, 15 Jun 2020 06:32:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v6 00/51] Large pages in the page cache
Message-ID: <20200615133222.GA26990@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
 <20200611065954.GA21475@infradead.org>
 <20200611112412.GA8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611112412.GA8681@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 04:24:12AM -0700, Matthew Wilcox wrote:
> On Wed, Jun 10, 2020 at 11:59:54PM -0700, Christoph Hellwig wrote:
> > On Wed, Jun 10, 2020 at 01:12:54PM -0700, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Another fortnight, another dump of my current large pages work.
> > > I've squished a lot of bugs this time.  xfstests is much happier now,
> > > running for 1631 seconds and getting as far as generic/086.  This patchset
> > > is getting a little big, so I'm going to try to get some bits of it
> > > upstream soon (the bits that make sense regardless of whether the rest
> > > of this is merged).
> > 
> > At this size a git tree to pull would also be nice..
> 
> That was literally the next paragraph ...

Oops.  Next time with more coffee..
