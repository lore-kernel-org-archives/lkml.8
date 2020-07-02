Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60678C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E142082F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593650884;
	bh=XEyn4rciJR68bCOMhcqvZPsUAaqbl3LjFAxVl5+yEJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O4TGdiMxj4YRt95MRN1uR/ryqwVW3d511VhT8JxruCndDMKB2+/m4TNL/Du4Oos1t
	 1yZSIuuQ/VpMPX1Q9Op716HxIrob+mSEKmWYSDXcdrIxecMafN2lkbxXiKG9th4pWv
	 ahb9IOb7sDNf+YmrGuaR7lqdkzPaTSE3sVP2kNko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGBAsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgGBAsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:48:02 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823CB2083E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 00:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593650881;
        bh=XEyn4rciJR68bCOMhcqvZPsUAaqbl3LjFAxVl5+yEJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L0xUkYlUw943INWmd8Up0ldWkOlWr7zMj1L52awGzU4rl7zqrhskjKCw/nOnaWLLS
         WzCMhOa6hdmImfVBvVzZ67H8cGVCqDdSWG/Py6Ny2ffr6ia6kxYwghKafHnjssq1Kl
         8l2fUs/3R+dErhPCz7GqiXsTvsNoGdeIv7RMtE64=
Received: by mail-wm1-f48.google.com with SMTP id o8so24630999wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 17:48:01 -0700 (PDT)
X-Gm-Message-State: AOAM532/vqXb7D8yKezmdj5PI0JrAUBACcezgebyxvrs5aHUqxx/sTuM
        edtu0xhEZIJ3JrU7uK3wFh+fPejrC9hhXSsRZyHQcQ==
X-Google-Smtp-Source: ABdhPJy/HEndSetfwvrT6mNXQnAH45hzDb8dDLtpYyndeldFdAxMTjx1eo18q6uOa+xzdpbjx95LmJarr/FnbO4zKow=
X-Received: by 2002:a1c:2402:: with SMTP id k2mr29132297wmk.138.1593650880105;
 Wed, 01 Jul 2020 17:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net> <CAHk-=wh0X1YBQm8b6dqu=FpE8jgHriisXDeqJ7jai41Ob+sJDA@mail.gmail.com>
In-Reply-To: <CAHk-=wh0X1YBQm8b6dqu=FpE8jgHriisXDeqJ7jai41Ob+sJDA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 1 Jul 2020 17:47:48 -0700
X-Gmail-Original-Message-ID: <CALCETrXpKAR2A0+96b+RWUE0vUmoPwmp-mfF1u=g2270DNi96w@mail.gmail.com>
Message-ID: <CALCETrXpKAR2A0+96b+RWUE0vUmoPwmp-mfF1u=g2270DNi96w@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000009b04ad05a96ac2b9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009b04ad05a96ac2b9
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 1, 2020 at 1:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 1, 2020 at 1:36 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > We ought to be able to do it the way I described and get decent code generation too.
>
> No, we really can't.
>
> Each access really needs to jump to an exception label. Otherwise any
> time you have multiple operations (think "strncpy()" and friends) you
> have to test in between each access.
>
> That is why *fundamnetally* the interface to "unsafe_get/put_user()"
> takes a label for the error case. There is absolutely no way to make
> any other interface work efficiently.

You inspired me to mock it up.  I don't think I did anything special
here, except that I mocked up unsafe_put_user() and a fudged it a
little bit because I'm using gcc 9.3.1 which doesn't support asm goto
outputs.  Code like this:

    if (unsafe_put_user(&a, user_a))
        goto error;
    if (unsafe_put_user(&b, user_b))
        goto error;
    if (unsafe_put_user(&c, user_c))
        goto error;
    if (unsafe_put_user(&d, user_d))
        goto error;

generates a series of movs.  The conditions are entirely omitted from
the generated assembly output because gcc is smart enough to figure
out that the return value of unsafe_put_user() indicates which way the
asm goto went.  I don't think I could generate better output by hand
than gcc generated from my test.

So I stand by my claim. :)  Each access does need to jump, but that
jump can be entirely within the exception entry, and we don't need to
generate any actual jump instructions.

--Andy

--0000000000009b04ad05a96ac2b9
Content-Type: text/x-csrc; charset="US-ASCII"; name="asm_goto_opt.c"
Content-Disposition: attachment; filename="asm_goto_opt.c"
Content-Transfer-Encoding: base64
Content-ID: <f_kc42gtow0>
X-Attachment-Id: f_kc42gtow0

I2RlZmluZSBFRkFVTFQgMTQKCnN0YXRpYyBpbnQgdW5zYWZlX3B1dF91c2VyKGludCAqdmFsdWUs
IGludCAqcHRyKQp7Cglhc20gZ290byAoIjE6IG1vdmwgJVt2YWx1ZV0sICVbbWVtXVxuXHQiCgkJ
ICAiLnB1c2hzZWN0aW9uIF9fZXhfdGFibGVcblx0IgoJCSAgIi5sb25nIDFiIC0gLlxuXHQiCgkJ
ICAiLmxvbmcgZXJyIC0gLlxuXHQiCgkJICAiLnBvcHNlY3Rpb24iCgkJICA6OiBbdmFsdWVdICJy
bWkiICgqdmFsdWUpLCBbbWVtXSAibSIgKCpwdHIpCgkJICA6OiBlcnIgKTsKCXJldHVybiAwOwoK
ZXJyOgoJcmV0dXJuIC1FRkFVTFQ7Cn0KCmludCB0ZXN0KGludCAqdXNlcl9hLCBpbnQgKnVzZXJf
YiwgaW50ICp1c2VyX2MsIGludCAqdXNlcl9kKQp7CglpbnQgYSA9IDEsIGIgPSAyLCBjID0gMywg
ZCA9IDQ7CgoJaWYgKHVuc2FmZV9wdXRfdXNlcigmYSwgdXNlcl9hKSkKCQlnb3RvIGVycm9yOwoJ
aWYgKHVuc2FmZV9wdXRfdXNlcigmYiwgdXNlcl9iKSkKCQlnb3RvIGVycm9yOwoJaWYgKHVuc2Fm
ZV9wdXRfdXNlcigmYywgdXNlcl9jKSkKCQlnb3RvIGVycm9yOwoJaWYgKHVuc2FmZV9wdXRfdXNl
cigmZCwgdXNlcl9kKSkKCQlnb3RvIGVycm9yOwoKCXJldHVybiAwOwoJCmVycm9yOgoJcmV0dXJu
IC1FRkFVTFQ7Cn0K
--0000000000009b04ad05a96ac2b9--
