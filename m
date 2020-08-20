Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E31C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A772208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LliNBby4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgHTRM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgHTRMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:12:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE8C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sNKOyAN070cUsV8VT5l3bx4jOXj3jbU+B3Xnf+xMJbU=; b=LliNBby4Jz/n3J8MwHRrJ2CQzi
        o6j9/rormt1Yg0F5ZhXEUvyqbxEHD7jkgg2KjSzf63lvQ3cFu5wq8FRi3WG6kyPEcjoYhzK13hW8y
        T376qiV0+ZwOI97/wM5AVpa2qUxF0CtK4rHu8JxocQAn0n49vw3o6ULWF+cDs6IHlqINTR0jZib6S
        ElYPOzdyai+/g6bSIZJKEwjqezLha3dcJrPscd22VAq/UQ+hoeIuAV5FDVDk0v385NeUbh3dVqVXL
        /nuGd7667wv90lywivb6L3pLCCgWgOYoJJEGlJ4uLJc/zqP0L3IEAQHWSos3Tc7pMIRU0NPEflc2a
        QMH2hVOg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8o6p-0004aM-1f; Thu, 20 Aug 2020 17:12:15 +0000
Date:   Thu, 20 Aug 2020 18:12:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
Message-ID: <20200820171214.GA15207@infradead.org>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
 <20200820170729.GA4116@lx-t490>
 <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:10:58AM -0600, Jens Axboe wrote:
> To be fair, I've only heard this one complaint about it, so hopefully it's
> not too widespread. I'm on an x86-64 laptop myself with nvme, and it works
> just fine :-)

The cause for this is the weird NVMe of by ones, where 0 in a field
means 1.  So for the overflow to happen you need a controller that
supports USHORT_MAX queue entries.  Which don't seem to be all that
common.
