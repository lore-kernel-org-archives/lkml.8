Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F1B20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WzkhUBZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgDFMKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:10:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgDFMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HbahpenxFs2WlSOpyCi+8NS4LjYRGaVKCZV3KQuvnWE=; b=WzkhUBZpY4XeQFrQo4R81bDqrJ
        36m4MCGHB29NFSPoQpBAsq9xDbv1faU4N+Nnbnsy4oyy2aiY4Vg0xEBWtQVmseQj42B+ju7jgLE0h
        3GhHV1Jf7KS1TwLjvCRHHGK0C0dfuiMOtevlOvQKGROGPHvPvfnjTTfrcZ0pzMO/23f3c89uzIqSV
        9bvhUw20a3ENhS+sKjYNuB5Oe+jKg2zO8RMFYhW3WQFcjGoKVf+UixKnZ+IS8GfyU71v4MY/8Rtlp
        NwHKhNvLOMm+eWil7vpQunwQCmD8P1reNXEULuIeYVGXzD6+i3CN2Q+3nc4aP7gBHUvVrhnUhU5Ed
        mzyAXJzA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQaG-0002nC-3d; Mon, 06 Apr 2020 12:10:32 +0000
Date:   Mon, 6 Apr 2020 05:10:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] exec: open code copy_string_kernel
Message-ID: <20200406121032.GX21484@bombadil.infradead.org>
References: <20200406120312.1150405-1-hch@lst.de>
 <20200406120312.1150405-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406120312.1150405-7-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:03:12PM +0200, Christoph Hellwig wrote:
> +	int len = strnlen(arg, MAX_ARG_STRLEN) + 1 /* terminating null */;

If you end up doing another version of this, it's a terminating NUL, not null.

I almost wonder if we shouldn't have

#define TERMINATING_NUL		1

in kernel.h.

	int len = strnlen(arg, MAX_ARG_STRLEN) + TERMINATING_NUL;

has a certain appeal.  There's the risk people might misuse it though ...

	str[end] = TERMINATING_NUL;

so probably not a good idea.
