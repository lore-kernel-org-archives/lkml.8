Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB7AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E9F2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593635158;
	bh=vmuxykkusP8Sss2HaPwY0y0queGIesJQPkhUI0J+g2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TcWgfOFortVHsP3WhMQz6QxlSgVOssqLoLvRv1cjMG0T7o95BpQs1zdKxDcZlWZLV
	 WIx9ZOaKMwyJSFViuyIJo24o1sue0WhHz6QRCTeqfqHSFOhMhqIHgkFvMpl4gew/5V
	 Tqlj4aRbqmkrorcy6ozmkwUY/P4ZkOIUofECSPdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGAUZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgGAUZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:25:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF408C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 13:25:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so14103264ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksD9QkiHR08Ohmph9dxydHMFrxrcmluqn9uR39dpkfY=;
        b=D3O/QeKOoId9j6oa3Hw9jrnKy0i1WaeBcGi9fiegINnzMRXt6ngpEAYI/VVFtM6xlj
         Xvcm4mEza5AiPsYyfUR93FPot5Yh0vJDjuB8u2CBQfYcoiOKIrp4XZB1STOUoW1OBc/8
         EIlisbBKdCE+vG7AcJo0OU9W6UCzrJvFid23E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksD9QkiHR08Ohmph9dxydHMFrxrcmluqn9uR39dpkfY=;
        b=Jeqwgf1hR7R6ytrevLl/QpOLabWFSR9qIOJJ66kyXcSsWXPvaIvWyBRByOAbfO8j0I
         cnO0sLhorfqxR0wAruy63Hto/HXowQP59O3BW6ppTphbe7+JzE/G51tgU21dqsSapnG+
         5m2tcl5JWWpDBDdvfMNp+k2yq591Vuw3vTl+7zJYtQEfTHq7NwsaKBUKdofJqQvgSpqH
         GwDLk7mYiJGHJzD+7pYMNUGNE9b1HHGQBTBKsQ9fGNvs4vc8RxpVUTzwNDuMf/hXOsdl
         tXsOOuvNgIAzLXjcIphvpXGVwtCeZ+v+0vV1nhgLy96uiPCxCzqAOrzD0EVippXW4w12
         mBmw==
X-Gm-Message-State: AOAM530sfsCJ9loo+2aB1Ydej1HEVp7UqBeF7GLUvjf4c22ikYN9JS6R
        S7bYY0slZNKWURke/+ziwlnvFPEuin0=
X-Google-Smtp-Source: ABdhPJwCG+mJzzDSE0icKufeiUpQU4pCCPLIeLijvjw3+WgzK5V8eg5NtQX2wQteEJi6RMp3N/Mg8A==
X-Received: by 2002:a2e:8747:: with SMTP id q7mr13198125ljj.459.1593635153975;
        Wed, 01 Jul 2020 13:25:53 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 203sm2188363ljf.14.2020.07.01.13.25.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 13:25:53 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id d17so14103131ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:25:52 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr9204172lji.70.1593635152418;
 Wed, 01 Jul 2020 13:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200701195914.GK2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 13:25:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
Message-ID: <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 12:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jul 01, 2020 at 12:04:36PM -0700, Linus Torvalds wrote:
> >
> > That's actually for the access granting. Shutting the access down ends
> > up always doing the same thing anyway..
>
> #define user_read_access_end            prevent_current_read_from_user
> #define user_write_access_end           prevent_current_write_to_user
> static inline void prevent_current_read_from_user(void)
> {
>         prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
> }
>
> static inline void prevent_current_write_to_user(void)
> {
>         prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
> }
>
> and prevent_user_access() has instances that do care about the direction...

Go and look closer.

There are three cases:

 (a) the 32-bit book3s case. It looks like it cares, but when you look
closer, it ends up not caring about the read side, and saving the
"which address to I allow user writes to" in current->thread.kuap

 (b) the nohash 32-bit case - doesn't care

 (c) the 64-bit books case - doesn't care

So yes, in the (a) case it does make a difference between reads and
writes, but at least as far as I can tell, it ignores the read case,
and has code to avoid the unnecessary "disable user writes" case when
there was only a read enable done.

Now, it's possible that I'm wrong, but the upshot of that is that even
on powerpc, I think that if we just made the rule be that "taking a
user exception should automatically do the 'user_access_end()' for us"
is trivial.

But I'll add the powerpc people to the list too. And the arm64 people
too, although it looks like they still haven't actually made the
uaccess_disable() logic visible as user_access_begin/end and the
unsafe_xyz code, so they'd not be impacted.

Christophe/Michael: the discussion is that I'd actually want to change
the "exception on user access" case to do the user_access_end()
automatically, so that you can write code like

        if (!user_access_begin(...))
                goto out;

        unsafe_get_user(..., out);
        unsafe_get_user(..., out);

        user_access_end();
        .. all is good, use the value we got..
        return 0;

out:
        return -EFAULT;

and use the same error label for both the "user_access_begin() failed"
_and_ for the "oops, the access faulted".

Right now the code needs to explicitly do the user_access_end()
handling manually if one of the accesses fault.

See for example fs/readdir.c, which has that

     efault_end:
             user_write_access_end();
     efault:
             buf->result = -EFAULT;
             return -EFAULT;

pattern of two different error targets several times. I'd like to
avoid that user_{read_,write_,}access_end() case for the error
handling entirely. It's extra complexity.

I checked every single non-arch user, and for all of them it was just
extra work (eg i915 driver, readdir, select, etc)

The only case it wasn't an extra bother was the
lib/strn{cpy,len}_from_user() cases, but that was because I literally
organized the code to call a helper function be called in such a way
that it always did the right thing.

                Linus
