Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C5C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CD9216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgEATAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729766AbgEATAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 15:00:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10DC061A0C;
        Fri,  1 May 2020 12:00:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUatW-00G8Kl-V5; Fri, 01 May 2020 19:00:19 +0000
Date:   Fri, 1 May 2020 20:00:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3b] eventfd: convert to f_op->read_iter()
Message-ID: <20200501190018.GN23230@ZenIV.linux.org.uk>
References: <97a28bdb-284a-c215-c04d-288bcef66376@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a28bdb-284a-c215-c04d-288bcef66376@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 11:54:01AM -0600, Jens Axboe wrote:

> @@ -427,8 +424,17 @@ static int do_eventfd(unsigned int count, int flags)
>  
>  	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
>  			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
> -	if (fd < 0)
> +	if (fd < 0) {
>  		eventfd_free_ctx(ctx);
> +	} else {
> +		struct file *file;
> +
> +		file = fget(fd);
> +		if (file) {
> +			file->f_mode |= FMODE_NOWAIT;
> +			fput(file);
> +		}

No.  The one and only thing you can do to return value of anon_inode_getfd() is to
return the fscker to userland.  You *CAN* *NOT* assume that descriptor table is
still pointing to whatever you've just created.

As soon as it's in descriptor table, it's out of your hands.  And frankly, if you
are playing with descriptors, you should be very well aware of that.

Descriptor tables are fundamentally shared objects; they *can* be accessed and
modified by other threads, right behind your back.

*IF* you are going to play with ->f_mode, you must use get_unused_fd_flags(),
anon_inode_getfile(), modify ->f_mode of the result and use fd_install() to
put it into descriptor table.  With put_unused_fd() as cleanup in case
of allocation failure.
