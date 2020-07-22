Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED558C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA77120792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbgGVBYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 21:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgGVBYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:24:33 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DFCC061794;
        Tue, 21 Jul 2020 18:24:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A412B11DB315F;
        Tue, 21 Jul 2020 18:07:48 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:24:32 -0700 (PDT)
Message-Id: <20200721.182432.1321288727189331162.davem@davemloft.net>
To:     viro@zeniv.linux.org.uk
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc32: fix a user-triggerable oops in clear_user()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200720012151.GM2786714@ZenIV.linux.org.uk>
References: <20200720012151.GM2786714@ZenIV.linux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jul 2020 18:07:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 20 Jul 2020 02:21:51 +0100

> Back in 2.1.29 the clear_user() guts (__bzero()) had been merged
> with memset().  Unfortunately, while all exception handlers had been
> copied, one of the exception table entries got lost.  As the result,
> clear_user() starting at 128*n bytes before the end of page and
> spanning between 8 and 127 bytes into the next page would oops when
> the second page is unmapped.  It's trivial to reproduce - all
> it takes is
> 
> main()
> {
> 	int fd = open("/dev/zero", O_RDONLY);
> 	char *p = mmap(NULL, 16384, PROT_READ|PROT_WRITE,
> 			MAP_PRIVATE|MAP_ANON, -1, 0);
> 	munmap(p + 8192, 8192);
> 	read(fd, p + 8192 - 128, 192);
> }
> 
> which had been oopsing since March 1997.  Says something about
> the quality of test coverage... ;-/  And while today sparc32 port
> is nearly dead, back in '97 it had been very much alive; in fact,
> sparc64 had only been in mainline for 3 months by that point...
> 
> Cc: stable@kernel.org
> Fixes: v2.1.29
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied, thanks Al.
