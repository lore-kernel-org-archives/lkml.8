Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24128C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0373920870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593628182;
	bh=crJp7T1y7h3ms6pwMfWZ/AF2fWLGrg8o4SQlljPWaBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RYepxzkJl2KyMI+Lq46u16uqRdGmb/zTDve+CO0jErBz8dWeWsrOWfCpmlXQ+yRGp
	 QBJIYYXRtHkIM5VTN2V/eWs4ZgGOsfl/e7yPkFVrTsNivlEIFgqw2jSE27XcxUK6eS
	 Wgazrm1o6rsS/SfCbQ9GaqE056TCyuOXlkOqLh0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbgGAS3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732868AbgGAS3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:29:40 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C6120870
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593628179;
        bh=crJp7T1y7h3ms6pwMfWZ/AF2fWLGrg8o4SQlljPWaBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=koYoPpbuXs4RL3kuuTS4M38hj6vbQXRpA+8X1x+3+l6Ca7Ih5M5KYi5+zo0xoyZxc
         0XJ1XPXYHosn6pwnI0rREMraFQOBtNRHgvmcwQJc+Ede0SpTX3uI+XWawvteONx0Y4
         A7dWqqpc8Ca1e8Xc47VJAPamVnRW98S8TLWntw0k=
Received: by mail-wr1-f42.google.com with SMTP id z13so25145645wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 11:29:39 -0700 (PDT)
X-Gm-Message-State: AOAM531nDZro1HaGok5yvjfwd6bFah82s491uOZKyM/jzLYtDBv/6OIS
        Bklx42onY32vxqHVN/zbahcXRq3Cn+vGcjHNfcpcKw==
X-Google-Smtp-Source: ABdhPJzAYTqZoZ9Jnf4eVby8yQ5wCITBXxsAN6h9N12eg3ZjQ8BMD6NarWMkpV6Hf6c+9gdN9bOQ9asRixpO52kU8Hs=
X-Received: by 2002:a5d:458a:: with SMTP id p10mr27397725wrq.184.1593628177649;
 Wed, 01 Jul 2020 11:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
In-Reply-To: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 1 Jul 2020 11:29:26 -0700
X-Gmail-Original-Message-ID: <CALCETrXLcyuVT2JCrb0d-5Oq8aRLrERUdhRfGLxVZyYYo3BoBQ@mail.gmail.com>
Message-ID: <CALCETrXLcyuVT2JCrb0d-5Oq8aRLrERUdhRfGLxVZyYYo3BoBQ@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 11:22 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
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

Do we really want the exception handling to do the CLAC?  Having
unsafe_get_user() do CLAC seems surprising to me, and it will break
use cases like:

if (!user_access_begin(...)
  goto out;

ret = unsafe_get_user(...);

user_access_end();

check ret;

I have no problem with a special ex_handler_uaccess_clac, but I don't
think it should be the default.

--Andy
