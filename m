Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D269C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0269A206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgG2Uuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Uuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:50:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0DC061794;
        Wed, 29 Jul 2020 13:50:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0t24-005CZh-9W; Wed, 29 Jul 2020 20:50:36 +0000
Date:   Wed, 29 Jul 2020 21:50:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/23] fs: don't change the address limit for
 ->write_iter in __kernel_write
Message-ID: <20200729205036.GA1236929@ZenIV.linux.org.uk>
References: <20200707174801.4162712-1-hch@lst.de>
 <20200707174801.4162712-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707174801.4162712-9-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 07:47:46PM +0200, Christoph Hellwig wrote:
> If we write to a file that implements ->write_iter there is no need
> to change the address limit if we send a kvec down.  Implement that
> case, and prefer it over using plain ->write with a changed address
> limit if available.

	You are flipping the priorities of ->write and ->write_iter
for kernel_write().  Now, there are 4 instances of file_operations
where we have both.  null_fops and zero_fops are fine either way -
->write() and ->write_iter() do the same thing there (and arguably
removing ->write might be the right thing; the only reason I hesistate
is that writing to /dev/null *is* critical for many things, including
the proper mail delivery ;-)

However, the other two (infinibarf and pcm) are different; there we
really have different semantics.  I don't believe anything writes into
either under KERNEL_DS, but having kernel_write() and vfs_write() with
subtly different semantics is asking for trouble down the road.

How about we remove ->write in null_fops/zero_fops and fail loudly if
*both* ->write() and ->write_iter() are present (in kernel_write(),
that is)?

There's a similar situation on the read side - there we have /dev/null
with both ->read() and ->read_iter() (and there "remove ->read" is
obviously the right thing to do) *and* we have pcm crap, with different
semantics for ->read() and ->read_iter().
