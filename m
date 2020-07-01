Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB23C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F79B20781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593627744;
	bh=1lLimZuX2E1yxCQ9id4rxBfXCwHtqeDkToymw1EuDIU=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=Z7qijCiQv7Eq2dhJwufs9c/Zwh1GP446v17bqqVhGOTye0bbEOioxWDkQu42S5zvS
	 1qTTSGXR4glZXlKVR+lWLKbJAkNvGcJ4GT2khx7s17MT832Q0THsbvZ52Az+YKRbk2
	 31GlbnXrJDhUrL8aPHD3F9olU4Jp0y/4BSXiPP1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbgGASWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgGASWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:22:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3EDC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 11:22:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q7so15125004ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=x81wUyeE6edhNLmeEDm3xlnjGBDJuLBR3gciagbrLEM=;
        b=FHw+TPEwLbaCt17n6/gR1qq+Ag4lAR2XNknHb/iCF+Gpc7OGHu3lA0/y2uBYeAEIED
         Q22P4oZ0jXxsEzWhlMPe2dIc87i5jCgcODu7EI+G9yScCNogl8AHEppLJ6+tWoc+w5YE
         /ta+3B1KyE7lAE8Mi+b+C2xwsi5lBrylEuaSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=x81wUyeE6edhNLmeEDm3xlnjGBDJuLBR3gciagbrLEM=;
        b=RwsfJs41W0yRXAucAFaLMQ+DQ4ep98FfL/pebyDc6H0L0j63oIyYEIdnnwZMpNOR7D
         tQwSGv2F+2qEX6gYjYUIAebN8nPEkln/g7pmt7BbdxArA+pX+VR7cKwJdyaTJkXEJ4RK
         mYKTK1MxX3UtxNGsliOP2XQVICiCL2k8s08JtpSUd65ZWMYSCIJaBRahW7wvYEVgrU1R
         OD0URthfe8HMWE/Uzkkg3IGVNk/pvqK0hPSoFqbMm8v6Ld2bDhz8HkUCxAshE9fHyozs
         LvglIEzFTicDVThVR/BnhGcQryyQc0L4Qs55UZ6ptr92Ou4ujtEEavicN7YnuextLFd0
         KL0Q==
X-Gm-Message-State: AOAM533lh0AJdubx7+QsnlHziql12z/VTo2tzWQBhvcc1p0ekrwKkagn
        EM7KvjSeb382aaGLs7JqHgqmbwhPmuU=
X-Google-Smtp-Source: ABdhPJzctVqEGuwPHgcPitCSPed6r+JLQB9QlVf6qLq9R4IuWwIihsk700OgXrKNc1kKKeZswF6tPw==
X-Received: by 2002:a2e:b889:: with SMTP id r9mr14180341ljp.92.1593627739401;
        Wed, 01 Jul 2020 11:22:19 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id g7sm2085587ljl.7.2020.07.01.11.22.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 11:22:18 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id o4so14289065lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 11:22:18 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr15931800lfn.30.1593627737906;
 Wed, 01 Jul 2020 11:22:17 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 11:22:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
Message-ID: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
Subject: objtool clac/stac handling change..
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh / PeterZ,
 it turns out that clang seems to now have fixed the last known
nagging details with "asm goto" with outputs, so I'm looking at
actually trying to merge the support for that in the kernel.

The main annoyance isn't actually using "asm goto" at all, the main
annoyance is just that it will all have to be conditional on whether
the compiler supports it or not. We have the config option for that
already, but it will just end up with two copies of the code depending
on that option.

It's not a huge deal: the recent cleanups wrt the x86 uaccess code
have made the code _much_ more straightforward and legible, and I'm
not so worried about it all.

Except that when I looked at this, I realized that I really had picked
the wrong model for how exceptions are handled wrt stac/clac. In
particular user access exceptions return with stac set, so we end up
having a code pattern where the error case will also have to do the
user_access_end() to finish the STAC region.

Adding a user_access_end() to the user exception fault handler is trivial.

But the thing I'm asking you for is how nasty it would be to change
objtool to have those rules?

IOW, right now we have

    if (!user_acces_begin(...))
           goto efault;
    unsafe_get/put_user(ptr, val, label);
    user_access_end();
    return 0;

label:
     user_access_end();
efaulr:
     return -EFAULT;

and I'd like to make the "label" case just go to "efault", with
objtool knowing that the exception handling already did the
user_access_end().

That would end up cleaning up the flow for a number of cases.

Nasty? Trivial?

               Linus
