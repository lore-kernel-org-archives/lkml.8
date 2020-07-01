Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A33EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851D42085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGASlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGASln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:41:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFADC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 11:41:43 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqhfn-003Vzq-Dz; Wed, 01 Jul 2020 18:41:31 +0000
Date:   Wed, 1 Jul 2020 19:41:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200701184131.GI2786714@ZenIV.linux.org.uk>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 11:22:01AM -0700, Linus Torvalds wrote:
> Josh / PeterZ,
>  it turns out that clang seems to now have fixed the last known
> nagging details with "asm goto" with outputs, so I'm looking at
> actually trying to merge the support for that in the kernel.
> 
> The main annoyance isn't actually using "asm goto" at all, the main
> annoyance is just that it will all have to be conditional on whether
> the compiler supports it or not. We have the config option for that
> already, but it will just end up with two copies of the code depending
> on that option.
> 
> It's not a huge deal: the recent cleanups wrt the x86 uaccess code
> have made the code _much_ more straightforward and legible, and I'm
> not so worried about it all.
> 
> Except that when I looked at this, I realized that I really had picked
> the wrong model for how exceptions are handled wrt stac/clac. In
> particular user access exceptions return with stac set, so we end up
> having a code pattern where the error case will also have to do the
> user_access_end() to finish the STAC region.
> 
> Adding a user_access_end() to the user exception fault handler is trivial.
> 
> But the thing I'm asking you for is how nasty it would be to change
> objtool to have those rules?
> 
> IOW, right now we have
> 
>     if (!user_acces_begin(...))
>            goto efault;
>     unsafe_get/put_user(ptr, val, label);
>     user_access_end();
>     return 0;
> 
> label:
>      user_access_end();
> efaulr:
>      return -EFAULT;
> 
> and I'd like to make the "label" case just go to "efault", with
> objtool knowing that the exception handling already did the
> user_access_end().
> 
> That would end up cleaning up the flow for a number of cases.
> 
> Nasty? Trivial?

Rather nasty for ppc; they have separate user_read_access_end() and
user_write_access_end().
