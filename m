Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B76DC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 02:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D8D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 02:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgEGCgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728079AbgEGCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 22:36:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCEFC061A0F;
        Wed,  6 May 2020 19:36:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWWOD-002cOr-Vc; Thu, 07 May 2020 02:35:58 +0000
Date:   Thu, 7 May 2020 03:35:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20200507023557.GE23230@ZenIV.linux.org.uk>
References: <20200507103921.371b1329@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507103921.371b1329@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:39:21AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> fs/eventfd.c: In function 'eventfd_read':
> fs/eventfd.c:226:6: error: implicit declaration of function 'iov_iter_count' [-Werror=implicit-function-declaration]
>   226 |  if (iov_iter_count(to) < sizeof(ucnt))
>       |      ^~~~~~~~~~~~~~
> In file included from include/linux/file.h:9,
>                  from fs/eventfd.c:9:
> fs/eventfd.c:257:15: error: implicit declaration of function 'copy_to_iter'; did you mean 'copy_to_user'? [-Werror=implicit-function-declaration]
>   257 |  if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) != sizeof(ucnt)))
>       |               ^~~~~~~~~~~~
> 
> Caused by commit
> 
>   a6515b3a7410 ("eventfd: convert to f_op->read_iter()")
> 
> I have applied the following patch for today:

[snip]

folded and pushed out
