Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A6C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0F721734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581546279;
	bh=6xxtcRGEqLWVVK850kDdT7XB02jgICrdrdzJy8uO9dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GkXwzieBEA4BB2ZjpizeV0GLbM9WG4cOJGAtYHDjaaPYBgDyALeGOdE+yL+/mX7CX
	 OQ+0XHb+L/cKODHUtfbU5X5sR9MvgIIauV7GmUwaJiwlwMRljiIVx/rhtFU9gIeSTx
	 fB25IsUOQfOMfwZpzxFDg4OiF9Jx2rcOEaLrSCvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgBLWYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgBLWYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:24:36 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C8A82168B;
        Wed, 12 Feb 2020 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581546275;
        bh=6xxtcRGEqLWVVK850kDdT7XB02jgICrdrdzJy8uO9dQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=St4l6sXEZSo9vMcsMXMQVycf8+gdfXbIVc7ALBfuRTNx3DauOg9GOgu4irqF+XsbJ
         l2GUqSxCouJVMfCmFAOW3cFGpMyOr2PcsTXXHKW5H5bpMzQjx57ctdNgpvuGabsDIc
         YuG+U46XAngr7rEgwiGIgNvrNQyTvGZ3FQ68w38Q=
Date:   Wed, 12 Feb 2020 14:24:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-Id: <20200212142435.0b7e938fe8112fa35fcbcc71@linux-foundation.org>
In-Reply-To: <20200212195322.GA83146@google.com>
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
        <20200212195322.GA83146@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 11:53:22 -0800 Minchan Kim <minchan@kernel.org> wrote:

> > That's definitely wrong.  It'll clear PageReclaim and then pretend it did
> > nothing wrong.
> > 
> > 	return !PageWriteback(page) ||
> > 		test_and_clear_bit(PG_reclaim, &page->flags);
> > 
> 
> Much better, Thanks for the review, Matthew!
> If there is no objection, I will send two patches to Andrew.
> One is PageReadahead strict, the other is limit retry from mm_populate.

With much more detailed changelogs, please!

This all seems rather screwy.  if a page is under writeback then it is
uptodate and we should be able to fault it in immediately.
