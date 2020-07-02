Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64945C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA80212CC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgGBOEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbgGBOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:04:54 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78879C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:04:54 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqzpX-003ydg-K7; Thu, 02 Jul 2020 14:04:47 +0000
Date:   Thu, 2 Jul 2020 15:04:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200702140447.GN2786714@ZenIV.linux.org.uk>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk>
 <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <20200702140159.GM2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702140159.GM2786714@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:01:59PM +0100, Al Viro wrote:
> On Thu, Jul 02, 2020 at 11:34:31PM +1000, Michael Ellerman wrote:
> 
> > I think we can do something to make it work.
> > 
> > We don't have an equivalent of x86's ex_handler_uaccess(), so it's not
> > quite as easy as whacking a user_access_end() in there.
> > 
> > Probably the simplest option for us is to just handle it in our
> > unsafe_op_wrap(). I'll try and come up with something tomorrow.
> 
> The goal is to avoid using unsafe_op_wrap()...

Incidentally, the change Linus proposes would affect unsafe_put_user()
as well.  And you are not using unsafe_op_wrap() anywhere on that
path...
