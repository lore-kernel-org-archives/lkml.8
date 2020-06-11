Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116CEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB942072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RktZuzi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgFKG7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgFKG7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:59:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9FAC08C5C1;
        Wed, 10 Jun 2020 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R0b5WkdACUM7oPMoOIUFF4w42xXw2fe5/UqkB5fmG6o=; b=RktZuzi7x62uk46IspoJpxzT3u
        73PNUqHfP5mQieHcQHaaEZ5eFSM7ekgXqbbbEq7lg+tKeW9G5REicCDRz2cRQpjRlqlFQXfkamiZS
        EUXq6koMuIWnRbplxl9JPrG3tdJAhcYb0urN5n5Wt/NXDtbTtAZMeNGXhY4+EhugQlooDtPjjE8PB
        sN3NAl8AG65jMXPkcNf9duUfIsR3kQOvWbUvhVDbYeqwHzMLUEJNJPFxetXxdJOvr0C0nhs3rWWaI
        aenZslO/Pn1svJIpuDimG/DzaDaVKOYDI9RyfcsUliw1ARO9zf920Do9G+YOAF8KpT+JSaSVTPpbp
        WkdimzmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjHBq-0005uS-Kd; Thu, 11 Jun 2020 06:59:54 +0000
Date:   Wed, 10 Jun 2020 23:59:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v6 00/51] Large pages in the page cache
Message-ID: <20200611065954.GA21475@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:12:54PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Another fortnight, another dump of my current large pages work.
> I've squished a lot of bugs this time.  xfstests is much happier now,
> running for 1631 seconds and getting as far as generic/086.  This patchset
> is getting a little big, so I'm going to try to get some bits of it
> upstream soon (the bits that make sense regardless of whether the rest
> of this is merged).

At this size a git tree to pull would also be nice..
