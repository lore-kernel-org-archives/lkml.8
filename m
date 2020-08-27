Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E80C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148B22075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgH0Vgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgH0Vgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:36:46 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC01C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:36:46 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBPZU-005mIB-Ux; Thu, 27 Aug 2020 21:36:37 +0000
Date:   Thu, 27 Aug 2020 22:36:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
Message-ID: <20200827213636.GF1236603@ZenIV.linux.org.uk>
References: <20200827013636.149307-1-allen.lkml@gmail.com>
 <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
 <1598553133.4237.8.camel@HansenPartnership.com>
 <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
 <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com>
 <202008271150.7231B901@keescook>
 <CAHk-=whDhHWQo_QjZp36=x=GLMGOJ2xnfsUk9xkUuWRz=i9gOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whDhHWQo_QjZp36=x=GLMGOJ2xnfsUk9xkUuWRz=i9gOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 01:46:33PM -0700, Linus Torvalds wrote:

> You really have to pick some pretty excessive type names (or variable
> names) to get close to 80 characters. Again, to pick an example:
> 
>         struct timer_group_priv *priv = container_of(handle,
>                         struct timer_group_priv, timer[handle->num]);
> 
> ends up being long even if you were to split it, but that funky
> container_from() wouldn't have helped the real problem - the fact that
> the above is complex and nasty.
> 
> And I had to _search_ for that example. All the normal cases of
> split-line container-of's were due to doing it with the declaration,
> or beause the first argument ended up being an expression in itself
> and the nested expressions made it more complex.

Speaking of searching, this kind of typeof use is, IMO, actively
harmful - it makes finding the places where we might get from
e.g. linked list to containing objects much harder.  container_of
(unless combined with obfuscating use of typeof()) at least gives
you a chance to grep - struct foo *not* followed by '*' is a pattern
that doesn't give too many false positives.  This one, OTOH, is
essentially impossible to grep for.
