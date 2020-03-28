Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FB6C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0826C20578
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1L7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:59:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44328 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1L7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:59:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIA7k-004fYk-2k; Sat, 28 Mar 2020 11:59:36 +0000
Date:   Sat, 28 Mar 2020 11:59:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to
 explicit __get_user()
Message-ID: <20200328115936.GA23230@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328104857.GA93574@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 11:48:57AM +0100, Ingo Molnar wrote:
> 
> * Al Viro <viro@ZenIV.linux.org.uk> wrote:
> 
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > rather than relying upon the magic in raw_copy_from_user()
> 
> > -		bytes = __copy_from_user_nmi(&frame.next_frame, fp, 4);
> > -		if (bytes != 0)
> > +		if (__get_user(frame.next_frame, &fp->next_frame))
> >  			break;
> > -		bytes = __copy_from_user_nmi(&frame.return_address, fp+4, 4);
> > -		if (bytes != 0)
> > +		if (__get_user(frame.return_address, &fp->return_address))
> >  			break;
> 
> Just wondering about the long term plan here: we have unsafe_get_user() 
> as a wrapper around __get_user(),

Not on x86; that wrapper is the fallback for architectures without
non-trivial user_access_begin/user_access_end

> but the __get_user() API doesn't carry 
> the 'unsafe' tag yet.
> 
> Should we add an __unsafe_get_user() alias to it perhaps, and use it in 
> all code that adds it, like the chunk above? Or rename it to 
> __unsafe_get_user() outright? No change to the logic, but it would be 
> more obvious what code has inherited old __get_user() uses and which code 
> uses __unsafe_get_user() intentionally.
> 
> Even after your series there's 700 uses of __get_user(), so it would make 
> sense to make a distinction in name at least and tag all unsafe APIs with 
> an 'unsafe_' prefix.

"unsafe" != "lacks access_ok", it's "done under user_access_begin".
And this series is just a part of much bigger pile.

FWIW, with the currently linearized part I see 26 users in arch/x86 and
108 - outside of arch/*.  With 43 of the latter supplied by the sodding
comedi_compat32.c, which needs to be rewritten anyway (or git rm'ed,
for that matter)...

We'll get there; the tricky part is the ones that come in pair with
something other than access_ok() in the first place (many of those
are KVM-related, but not all such are).

This part had been more about untangling uaccess_try stuff,,,
