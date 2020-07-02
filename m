Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D621C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6319220899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593721976;
	bh=4fuJ4tXZiSZ3w1KcEO9C5+E58YcS0oxi+U10cZmDi2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dCE2oVGV/uNi0HVI3J504+CrrdSP9klt+a3LK4JgXN3V9GnFhn+uSslwdX34E6S+y
	 +u9H4+McFaTsvWnQcLHJC33K04jf3ysSYPSNtEzb7wP4ou65sr5o+fy0n5P9c/kOa/
	 k2LaO++RLqY+GGuE2/IDmirJxrPyFtZUOzTCQ4Bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgGBUcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:32:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A953C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:32:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t74so17028610lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQt4Y7Wg4ljfGdZh2OetJLFw6rd6e07ATlfmrHRXM+A=;
        b=gcVjD9Ma36Q3V5fPfsWnT5qcRn8AvXXTYRS2Wfm19eCwKx9S5If6uZc8agFQi3jX4f
         qobnTrteTasYUAvUzRgjS5UHSJuOhW0R1eE6WhQm78il5KQut6kif1vs7jnPaNAA2WDo
         zXgPX53hZhxMnZTw31GQe99CcJSJftC67hiAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQt4Y7Wg4ljfGdZh2OetJLFw6rd6e07ATlfmrHRXM+A=;
        b=ELtBqCWDDQv25Ly6XXuUf6GQIx06zLDNK0Yh1MQGXuMbTWeGuoQcg0hAesFc0Q20Oe
         nsRAAcHNydbiVFTy2LbKpjt6t0TcY56O5F8+/MIlfoZLdLPAIuOvmnMgEMg21aqMBzQ9
         rOyuhiDkYjJgHFLwgcTHR0iOX6SpLq5pXwSMJ5Hdo+GmpuK6vqayvK0AWtVDyWG12QgN
         wovda3lrqncMA1QGbaO8DQ42r1FH0x5bCenbcfiVDuqYx14Vg4s1gqGzOrxgxncUGkaU
         MXrDOnAcw8dVY02AyDmjRkZhWEscRVtAeQQlRJMEv7y54lR89BSXoPKBGUOfrowbkU6Y
         yOrw==
X-Gm-Message-State: AOAM533jp1WGQOTjJXtWZdxi8yfJ9cHvuAwpSTPdqqf9LVJ7ehMbOt6S
        6x30NrXMTFSj8hmdzDCH/pPB3y2wL24=
X-Google-Smtp-Source: ABdhPJx4f19eSOmFmUb5Ry6dm+nQCq8yVR/s4QCHc//pjH82bmeEKhqmynSM6NGbGTU44apwEu4qYw==
X-Received: by 2002:a19:ca48:: with SMTP id h8mr19509572lfj.161.1593721972245;
        Thu, 02 Jul 2020 13:32:52 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w2sm1117545lji.41.2020.07.02.13.32.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 13:32:51 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t25so29321795lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:32:50 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr16882472ljj.102.1593721970505;
 Thu, 02 Jul 2020 13:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au> <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200702201755.GO2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 13:32:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
Message-ID: <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 1:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         stac();
>         XSTATE_OP(XSAVE, buf, -1, -1, err);
>         clac();
>
> Rely upon objtool not noticing that we have, in effect, clac() in a state
> where AC is already cleared?  We could massage that thing to take a label,
> but it wouldn't be pretty...

Ugh, the above is bad anyway.

It doesn't use _ASM_EXTABLE_UA, so it won't warn about the noncanonical cases.

Yeah, it would need to be turned into a "jump out" instead of just "jump over".

Which it damn well should do anyway.,

That code should be taken behind a shed and shot. It does so many
things wrong that it's not even funny. It shouldn't do stac/clac on
its own.

At least it could use the "user_insn()" helper, which does it inside
the asm itself, has the right might_fault() marking (but not the
address check), and which can be trivially changed to have the fixup
jump be to after the "ASM_CLAC".

Or maybe it could use "asm goto" for that exception handling, because
it doesn't have any outputs (except for the error, which is exactly
what the goto case is for).

But no, at no point should we "rely on objtool not noticing". In fact,
I think Josh's patch would have made objtool notice, and it would have
been a good thing, because that code is unbelievably ugly and needs to
be cleaned up anyway.

Am I surprised that we have hacky stuff in our magic FPU/MMX/AVX state
handling? No I'm not.

I'm getting to the point where I'm thinking maybe all the horrendous
mis-steps from Intel over the last years are a good thing, and ARM
will take over, and we won't have to deal with this a decade from now.

                      Linus
