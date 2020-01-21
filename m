Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A468C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C64724654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cy/hTHQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAUITa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:19:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44279 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:19:30 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so1747374oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ey/QLiL0E7ZncvQZ6vH/REg2blahZXkYqesU/itcw2I=;
        b=Cy/hTHQFH8EH5SSxNZiC748uoA9RQruI6O8Y5xazgevPHJ348y4gif900l9XDiszWG
         7VvP4cH5Dw3JPv+Y41Ax0sKIcT6NAjtFQ2F8l8nznvR/mOTz2DIvoAgr+2GljwfyvE/k
         SesQsCbOnQRzqafyKsLd8xA3Ow0/MjnqeVHmTewG7cK9B6O/zjp9x16H8Zsyfqej3h0A
         si9kg3FderQpZt1n5Ad9i7lOLTSquYgLzuQbAL8AoCp9Vk1VdlOPphCMP79lTdGSVimi
         qXFLsyI5vsYJ2HRZTUCasxxI6bKTR5m+0Y/H7hN4XNGMB86W4WUIfwWB9RlKaB7TCv0N
         h/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ey/QLiL0E7ZncvQZ6vH/REg2blahZXkYqesU/itcw2I=;
        b=hlaz0QhA75c2VpBZkhOw94qq/ud27kgIhrYgC+xa1dN/G+Xc/FVrXnMX0KIogWYlGu
         2l4Xjk2jJWD1LAFcyNluG3YDksoaogRJKtQYQprpNcIT2Y5UOrKSCU5R+iD7v6Tszf+F
         dYZ0T7JWil39Az6lSMHqvdM14CAJ+i26MvP549U7pioV4AmFFFQxZf95TKs9+ELON6p4
         bTio+vgh5ztohr7x4GSwkE8FExeJ8oFii3ORq8lL8C2Z2Sug7ZOKJKWT35gk+T49Hf+l
         bD8TFEstxeREo1l4nbDMKq/AnAwa8EqEJh/hDQi2nuKcloEPe5Y7YUGvDWCxGK9qwQ+A
         EaTg==
X-Gm-Message-State: APjAAAVzkShkHvwicPkGliTzhphBamfxWpHZyJiJ8TagyA915Q6HXEh8
        lPqroASSBRcHGbqbiIVQQNH0MiuEb5sCBeosq4xj3RZxOqE=
X-Google-Smtp-Source: APXvYqyzlNBzubrP1uBT8vF5UbLa++xXFjbT5RhwN9gpV9cyX8LyH6QKomYIVCkA14mbOENSJN3o3Vx3hM0odypO6JU=
X-Received: by 2002:aca:b183:: with SMTP id a125mr2169350oif.83.1579594769148;
 Tue, 21 Jan 2020 00:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20200121041200.2260-1-cai@lca.pw> <20200121072744.GA7808@zn.tnic>
In-Reply-To: <20200121072744.GA7808@zn.tnic>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jan 2020 09:19:18 +0100
Message-ID: <CANpmjNPFRCRg9wnFwyJpZVg8Urb9HAdZ++e3xbh1LXPjgAs4kw@mail.gmail.com>
Subject: Re: [PATCH -next] x86/mm/pat: fix a data race in cpa_inc_4k_install
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 at 08:27, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 20, 2020 at 11:12:00PM -0500, Qian Cai wrote:
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 20823392f4f2..31e4a73ae70e 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
> >
> >  static inline void cpa_inc_4k_install(void)
> >  {
> > -     cpa_4k_install++;
> > +     WRITE_ONCE(cpa_4k_install, READ_ONCE(cpa_4k_install) + 1);

As I said in my email that you also copied to the message, this is
just a stats counter. For the general case, I think we reached
consensus that such accesses should intentionally remain data races:
  https://lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/T/#u

Either you can use the data_race() macro, making this
'data_race(cpa_4k_install++)' -- this effectively documents the
intentional data race --

or just blacklist the entire file by putting
  KCSAN_SANITIZE_set_memory.o := n
into the Makefile.

[ Note that there are 2 more ways to blacklist:
  - __no_kcsan function attribute, for blacklisting entire functions.
  - KCSAN_SANITIZE :=n in the Makefile, blacklisting all compilation
units in the Makefile. ]

I leave it to you what makes more sense. I don't know if there are
other data races lurking here, since cpa_4k_install is not the only
stats counter.

> >  }
> >
> >  static inline void cpa_inc_lp_sameprot(int level)
> > --
>
> Fix a data race, says your subject?
>
> If it had to be honest, it probably should say "Make the code ugly
> because the next tool can't handle it".
>
> Frankly, I'm not a fan of all this "change the kernel to fix the tool"
> attitude.

I commented on better ways dealing with this, since this is just stats counting.

Thanks,
-- Marco
