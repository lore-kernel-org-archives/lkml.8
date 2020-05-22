Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED463C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 00:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B655020849
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 00:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hphFGtYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgEVAEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 20:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgEVAEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 20:04:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADFCC061A0E;
        Thu, 21 May 2020 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0gOUmHtpRYnz9Bbg3v6tj1lTQPoZ+mPSDaF1xLyFN8Q=; b=hphFGtYd2XgvPWK2bd4ZFV2Zff
        s0fSDoF5bcuq6Ip8kbmfxp5C4RG/dlRBr/JPiabV4setjPWs/bvYeKsshWTD98xFdy+YM741kCdg5
        2Yxbkd/theGLA/emkM3D8R1a8z36VfNmuy9dlpki8MDOC1Qapr2wkOTM1WeY7RKzrYuMljuUJJq6D
        fbT7tFjCC7Re9X6P+70BTd+SOxIOQsjeZocUSxgyOwii/+rjJcu1n6tzxIupmp1ywzBmcGvZ4oUKn
        VVG85WOLyJFoHubusHO8EqJx0YzBDyLLLYaumyzwpHS4DjMn0XOsFEtsYEUOw1S9iAPqnC/Tt7Bcn
        6VMpqXYg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbvAZ-0002Qg-5D; Fri, 22 May 2020 00:04:11 +0000
Date:   Thu, 21 May 2020 17:04:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/36] Large pages in the page cache
Message-ID: <20200522000411.GI28818@bombadil.infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200521224906.GU2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521224906.GU2005@dread.disaster.area>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 08:49:06AM +1000, Dave Chinner wrote:
> Ok, so the main issue I have with the filesystem/iomap side of
> things is that it appears to be adding "transparent huge page"
> awareness to the filesysetm code, not "large page support".
> 
> For people that aren't aware of the difference between the
> transparent huge and and a normal compound page (e.g. I have no idea
> what the difference is), this is likely to cause problems,
> especially as you haven't explained at all in this description why
> transparent huge pages are being used rather than bog standard
> compound pages.

The primary reason to use a different name from compound_*
is so that it can be compiled out for systems that don't enable
CONFIG_TRANSPARENT_HUGEPAGE.  So THPs are compound pages, as they always
have been, but for a filesystem, using thp_size() will compile to either
page_size() or PAGE_SIZE depending on CONFIG_TRANSPARENT_HUGEPAGE.

Now, maybe thp_size() is the wrong name, but then you need to suggest
a better name ;-)

> And, really, why should iomap or the filesystems care if the large
> page is a THP or just a high order compound page? The interface
> for operating on these things at the page cache level should be the
> same. We already have page_size() and friends for operating on
> high order compound pages, yet the iomap stuff has this new
> thp_size() function instead of just using page_size(). THis is going
> to lead to confusion and future bugs when people who don't know the
> difference use the wrong page size function in their filesystem
> code.

There is no wrong function to use -- just one that expands to more code
in the case where CONFIG_TRANSPARENT_HUGEPAGE is disabled.
