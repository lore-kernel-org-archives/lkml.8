Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99559C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F850217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NuUpcvlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgFRFiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgFRFiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:38:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61CCC06174E;
        Wed, 17 Jun 2020 22:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=sggmEXQDsSXu33ja7wNDfNK8p4zxYDlskpe84OjqcXI=; b=NuUpcvlM6lLnP6YGu07G0B1WMv
        IP7m56RjMWKrff1fMxrP2e9Bqf85PkP0gcZ2SGNFbfbv+yQO/7hosKtNTdFzHjS/+XPHSysvBy5aj
        nA6Eq1b28Ry5J01lJCdq99/AgcI5hnd8mZO5H4mub7K6FfF/VdBg/rC4+gJcsffKVlOnPsidHFjFp
        Tr2rnUR+DYzrnB+zm+OORerWS9y3BUNmI2zr48pjg4bAUoaVkYBBXI+mhXsrrCYaLmbX4cIOnvNCL
        xNoyvMVBQy2bmQGS//W4wTQJMDRcYZGH7jd3R0vDJTXnO4fudyM0qLz2tprjKPBjB1tRUx+CCpE+x
        TWdFciFA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlnFY-0000zF-1Q; Thu, 18 Jun 2020 05:38:08 +0000
Subject: Re: linux-next: Tree for Jun 18 (fs/io_uring)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        axboe <axboe@kernel.dk>, Al Viro <viro@ZenIV.linux.org.uk>
References: <20200618141530.0ca9897d@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25b48bfa-07ef-c6c8-c4c9-61c213e22f66@infradead.org>
Date:   Wed, 17 Jun 2020 22:38:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618141530.0ca9897d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 9:15 PM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next release tomorrow.
> 
> Changes since 20200617:
> 

when CONFIG_BLOCK is not set/enabled:

../fs/io_uring.c: In function 'io_async_task_func':
../fs/io_uring.c:4559:7: error: implicit declaration of function 'io_sq_thread_acquire_mm'; did you mean 'atomic_read_acquire'? [-Werror=implicit-function-declaration]
   if (io_sq_thread_acquire_mm(ctx, req)) {
       ^~~~~~~~~~~~~~~~~~~~~~~
       atomic_read_acquire
../fs/io_uring.c: In function 'io_sq_thread':
../fs/io_uring.c:6268:4: error: implicit declaration of function 'io_sq_thread_drop_mm'; did you mean 'io_sq_thread'? [-Werror=implicit-function-declaration]
    io_sq_thread_drop_mm(ctx);
    ^~~~~~~~~~~~~~~~~~~~
    io_sq_thread



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

