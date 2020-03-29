Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623F3C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E2A2073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585501888;
	bh=0eiDMIKlucXor1CKj3MUMoxv/0gJOdYw+K+/Di8CAz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RmQscFlbgRvTu6LoeDmagW3dcBe6dp3Vb559r5po20ZUbnhILb+X0OUFgaqm2fub0
	 FwXWjAm6th/EG2WTYtwLoI5c2sxy4Tpho8hu7eistbJYudgpWRj5emdZmnadnIZvbo
	 lDqz+WqXdshCB/hWQVawqH3JMtpsaDX2NpyM6fhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgC2RF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 13:05:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45773 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgC2RF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 13:05:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id v4so11976895lfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+buOghIefXoqJ85J3krkeYSFnepTic0YgGtBasPJ4hg=;
        b=LjygP6dqGb9+8GT2FzA/bAmugtC8lI7rpMSe87n4u40me9GHIY1Gngbtl+B8U5IaYj
         TVLWwFkFymQmOoCJUk394dJZnQn8gIaSz4H5gVxCy/LWjm1gpN1tnYa2P/eSbDNtZ2tU
         ZRh9KaElQGki4n/HoiuryLjA4wCqaW1dhiWgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+buOghIefXoqJ85J3krkeYSFnepTic0YgGtBasPJ4hg=;
        b=M4GZzCywPN8/x0P1+0AMTRtdR6UchAwZplTA5dHZQYkWDRlxJ9ek3ZmQJqiGLh//io
         1tm8KYmzeZCGwaGxoA0cLDuuPP9CM4TyTQLbiliuB9cmarE/WTFL3BK/Kvhmd6DzKrIf
         n8yS9VecE+p1ml2MZDHhLgfhvwm3K7FXRImvqfzdxoixBdtiBqFZnA6GWAAknytXa+7o
         YVYYfGAbw77WeNNF/Hy68ZlFEEJwxmTuD/J4kAgTnJlpGQ8mM8jA4IAVVwgkTP6E5gvZ
         5QfJp2OZpRCa3b4CXDBuf+w7fDPicYyOxulVYLH8LcNtXxyA1E6b/oEJh+kyg3hAzWAh
         0Ivw==
X-Gm-Message-State: AGi0PubGCYXRUlduoERdgUpxzPjT/hZhzXEaeGt38otVk2hj1SLMBP/e
        p2fhI+R/QHx2lEaQl5pmuGwgJzaI1gM=
X-Google-Smtp-Source: APiQypKwTlaXEmG5XjgnazO+kcvLdvjW4P2rzX+7N4o4764ykLQke5u10wGoTDKdZUnt4yhXkN6iMQ==
X-Received: by 2002:a19:7e01:: with SMTP id z1mr5638776lfc.196.1585501556038;
        Sun, 29 Mar 2020 10:05:56 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u25sm1372873lfo.71.2020.03.29.10.05.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 10:05:55 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id h6so6245865lfp.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:05:54 -0700 (PDT)
X-Received: by 2002:ac2:4a72:: with SMTP id q18mr5795353lfp.10.1585501554562;
 Sun, 29 Mar 2020 10:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com> <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
In-Reply-To: <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 10:05:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgB39j-fwYz3A4a6AZymT21BjJv0SvrQNTJfZk9N+sv0A@mail.gmail.com>
Message-ID: <CAHk-=wgB39j-fwYz3A4a6AZymT21BjJv0SvrQNTJfZk9N+sv0A@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 9:50 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> My incliniation is to just get rid of the __get_user()-style APIs.

That's definitely the direction we're going in, and Al has already
been moving that way.

There is basically zero advantage of __get_user() over get_user() these days.

Historically the advantage used to be quite noticeable (one could be
inlined and generated nice dense code for repeated single accesses),
but with CLAC/STAC that simply isn't the case any more.

> (It's possible that some arch code somewhere uses __get_user as a way
> to say "access user or kernel memory -- I know what I'm doing".

Not just possible - it was what was literally happening in tracing.
Except for the "I know what I'm doing" part, where tracing code used a
pointer that could be user pointer or kernel pointer interchangeably.

Which isn't even possible on some architectures (it just happens to
work on the common ones), because the same pointer bit pattern can be
either or.

But that got fixed, and hopefully there aren't other cases around any
more. But slowly converting away from __get_user() and friends should
end up fixing them all, since objtool will then verify that you do the
right user_access_begin() etc.

              Linus
