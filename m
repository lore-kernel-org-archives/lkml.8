Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154D6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D822071C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRIGG/fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgEDMjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726625AbgEDMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:39:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D9FC061A0E;
        Mon,  4 May 2020 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f2dOPUrKZgUgGSkMrdOrs8H5s2b4gi+dnFwdsR381A4=; b=MRIGG/fk13IU7YQiPfdBNpKH6j
        DTRMMWl3oSa0d8XgMW4fpaSdWKCxKhphckwfEbWTA1dfs5pxJrb3KFnJa6fN7xC3CBduUKAZTvcVQ
        uB7SMCKeroTFlZj1g7/NeHGHXsZuMOQtVxKUi+SmGcMecwgo9nJEwqLtnbP2Kmz3w8kp/nXtMRntL
        yqA9IoyAWZTMc02SjkNpbasDk0SbHQ9jlQ8/fXsDQRWGiDgyP3BDKvqF3/4vv2ghDkT1qAX7qXXBU
        3/q+5tWrOnhXHhyBKo602j2DRmXGy/gQuhKkmYBxHe0lqdOwEhN/8VUKGgPtjrtyBzSdxf4i9NXE8
        aIgD6cvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVaNN-0007QD-6f; Mon, 04 May 2020 12:39:13 +0000
Date:   Mon, 4 May 2020 05:39:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] eventfd: convert to f_op->read_iter()
Message-ID: <20200504123913.GA14334@infradead.org>
References: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 01:11:09PM -0600, Jens Axboe wrote:
> eventfd is using ->read() as it's file_operations read handler, but
> this prevents passing in information about whether a given IO operation
> is blocking or not. We can only use the file flags for that. To support
> async (-EAGAIN/poll based) retries for io_uring, we need ->read_iter()
> support. Convert eventfd to using ->read_iter().
> 
> With ->read_iter(), we can support IOCB_NOWAIT. Ensure the fd setup
> is done such that we set file->f_mode with FMODE_NOWAIT.

Can you add a anon_inode_getfd_mode that passes extra flags for f_mode
instead of opencoding it?  Especially as I expect more users that might
want to handle IOCB_NOWAIT.
