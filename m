Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EEAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8EC20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="STIqoXPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgGVL1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGVL1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:27:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF3C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gzjIpPTE0BOMS+w0TJyJ1YeBbYxcBd9ssbvwpStcd2Y=; b=STIqoXPBQrh67Rq3RQ2a3HH1Gz
        vMo8BeblxQGh2iST1cDC83ADsBLlr3xiRZCjKXMNAX92u0n3ssD72DAz/ssd5dJNLW0XK0VPGSunn
        iqurWIoRNfM1jCVFHWpjCEub3LDY50gAt9YlH/tk/9bHFzJizIXw+5icxqyjAs1O5FydgbOwXOvQJ
        oYDlawn1aaKXnSDcaxJ1jm3qAe4hx57G4cMOnMf9DPjqkTtM7QYd85V0713584BP3v8jn4CK7+Sps
        bkGNeMaGwQLoVpfHSy0z0QauBL5Y3CNq3Oojxc8ON4DbjCb1wWqm56SQq8dgOUJ83xT853upRlrjY
        BIbMacUg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyCuR-0005Ao-1m; Wed, 22 Jul 2020 11:27:40 +0000
Date:   Wed, 22 Jul 2020 12:27:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     qiang.zhang@windriver.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/dmapool.c: add lock protect in dma_pool_destroy
Message-ID: <20200722112738.GN15516@casper.infradead.org>
References: <20200722090516.28829-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722090516.28829-1-qiang.zhang@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:05:16PM +0800, qiang.zhang@windriver.com wrote:
> When traversing "pool->page" linked list, to prevent possible
> other path operations this list, causing it to be destroyed, we
> should add lock protect for this list in dma_pool_destroy func.

The pool is being destroyed.  If somebody else is trying to allocate from
it while it's in the middle of being destroyed, there is a larger problem
to solve, and it can't be solved in the dmapool code.

