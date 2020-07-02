Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E55207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9f/je5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGBAcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgGBAcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:32:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E77C08C5C1;
        Wed,  1 Jul 2020 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q/MGBmpqvDE2/0MSXOyoSKHtoMwcFwFDPcNkwI5LzZs=; b=Y9f/je5WEN5lJPIHo9GuDgamE0
        A0jUPA3N0+WzK9Rj7iB0xk7YdQFuEXxXJ/SK5DMNEDezHupyBZA7dZKAkDT3Q4IOKr8wEaqa0g1jM
        9TntLDg0M4oDYzrzSDcaLR/8h/1L43RK3ovqHExGEGqj+smzB4c5dHH93LAadBoFxDL5Z774Br814
        JSiPgj7FR61qSdTkUkgE3y0Zu8Z9xRwyde1posaM7sKxqf96xu8IwYO86BTsogENql9qIxYM0p3Ao
        /D/K5GBsXGDpKqKFkUH6ZNFiJJD2z1ctEgYwIik9kXno5G4eGcKwQwYOyjDOI23JpaYRLZo7Cv5C3
        8yEHdX9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqn9c-0004Qk-FH; Thu, 02 Jul 2020 00:32:40 +0000
Date:   Thu, 2 Jul 2020 01:32:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/23] sysctl: Call sysctl_head_finish on error
Message-ID: <20200702003240.GW25523@casper.infradead.org>
References: <20200701200951.3603160-1-hch@lst.de>
 <20200701200951.3603160-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701200951.3603160-20-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:09:47PM +0200, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This error path returned directly instead of calling sysctl_head_finish().
> 
> Fixes: ef9d965bc8b6 ("sysctl: reject gigantic reads/write to sysctl files")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I think this one needs to go to Linus before 5.8, not get stuck in the
middle of a large patch series.
