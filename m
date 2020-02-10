Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7220842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ot9S+A+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBJQXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:23:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33934 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgBJQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:23:15 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so1069173qkm.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 08:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaHv+PKpHG2kLF+syKmgL65ROquUkDcK5zPG7XnFfj8=;
        b=ot9S+A+SKIJ10cvWpMVaaYrqqDKwI8Dvoav5W6xsvsS3mSLN93bsuMFLYPgaaoM16L
         REh4NMYoLn54LLM2uPn2Y5UjjveL9hDvu+PqWdWRBKKI7kZElzpCTvLF03fqqnOXRScw
         syq0lZDNglnKLhx0xeJ+MnVrD57lgsDsSatFYECRzNCemyQeuyh0pBQu9stbc8b3dvMB
         8yWcVO/0+hW053plsoVi2kZbNbS0XptflPnhDN0jY176OHCtg1GPvW2LynN6wRyDItpV
         eF58NrHu5dK0BefbTWb/EZLivA+smyHY2sGhIAvWTxOgOVt9yrlGRmCBVlLckLWTwoED
         M+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaHv+PKpHG2kLF+syKmgL65ROquUkDcK5zPG7XnFfj8=;
        b=ictV5HopxRAp+smp+/kVDf6HMhx2AUb8pUVo0aGgZHgkfkqbBGE+eGGZnt18iYt2+y
         VLyQGJ0aWZA+0Lr0BajUm3q2TAJxtvk3E4VcSTkG44pMdEEFr9YxCQfwZ2WOeCdGUhwK
         6eoiosIOspJbZj7drpp0OGu9HMVFAFwYeIm0cJF3JVGZVv5hVBheEHKukowRhr8hbLdO
         g/9mhFfRJ1jdwWHgZ1QC+ego8wXYUCU/kbIA2QXRw4NjVHZ56QQcVp4h96ire7YXgJju
         V/ibjmdmRuZqd7E5eIsfDSiKPWlJU7Lg60plO/KvuLNZ1ExcTQIde7/bT1ic0GaM9omK
         VGNg==
X-Gm-Message-State: APjAAAVSMIcmWwcv34L+o9LNufQwYbtJXLPlA2LuITXAL3gD44B4DOPn
        PU0+YBnsufx0t4exQdnEKk+PpQ==
X-Google-Smtp-Source: APXvYqxbU8J3b8OSVhklgbcprlJkDiq20U5N6jKEWVq0xbTU3s4v/Jkuk8Q08KyXs5BHcoN5lmJTsg==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr2094560qkf.162.1581351792284;
        Mon, 10 Feb 2020 08:23:12 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g6sm359335qki.100.2020.02.10.08.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 08:23:11 -0800 (PST)
Message-ID: <1581351789.7365.32.camel@lca.pw>
Subject: Re: [PATCH] mm: fix a data race in put_page()
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>, John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Date:   Mon, 10 Feb 2020 11:23:09 -0500
In-Reply-To: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
References: <5402183a-2372-b442-84d3-c28fb59fa7af@nvidia.com>
         <8602A57D-B420-489C-89CC-23D096014C47@lca.pw>
         <1a179bea-fd71-7b53-34c5-895986c24931@nvidia.com>
         <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 08:48 +0100, Marco Elver wrote:
> On Sun, 9 Feb 2020 at 08:15, John Hubbard <jhubbard@nvidia.com> wrote:
> > 
> > On 2/8/20 7:10 PM, Qian Cai wrote:
> > > 
> > > 
> > > > On Feb 8, 2020, at 8:44 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> > > > 
> > > > So it looks like we're probably stuck with having to annotate the code. Given
> > > > that, there is a balance between how many macros, and how much commenting. For
> > > > example, if there is a single macro (data_race, for example), then we'll need to
> > > > add comments for the various cases, explaining which data_race situation is
> > > > happening.
> > > 
> > > On the other hand, it is perfect fine of not commenting on each data_race() that most of times, people could run git blame to learn more details. Actually, no maintainers from various of subsystems asked for commenting so far.
> > > 
> > 
> > Well, maybe I'm looking at this wrong. I was thinking that one should attempt to
> > understand the code on the screen, and that's generally best--but here, maybe
> > "data_race" is just something that means "tool cruft", really. So mentally we
> > would move toward visually filtering out the data_race "key word".
> 
> One thing to note is that 'data_race()' points out concurrency, and
> that somebody has deemed that the code won't break even with data
> races. Somebody trying to understand or modify the code should ensure
> this will still be the case. So, 'data_race()' isn't just tool cruft.
> It's documentation for something that really isn't obvious from the
> code alone.
> 
> Whenever we see a READ_ONCE or other marked access it is obvious to
> the reader that there are concurrent accesses happening.  I'd argue
> that for intentional data races, we should convey similar information,
> to avoid breaking the code (of course KCSAN would tell you, but only
> after the change was done). Even moreso, since changes to code
> involving 'data_race()' will need re-verification that the data races
> are still safe.
> 
> > I really don't like it but at least there is a significant benefit from the tool
> > that probably makes it worth the visual noise.
> > 
> > Blue sky thoughts for The Far Future: It would be nice if the tools got a lot
> > better--maybe in the direction of C language extensions, even if only used in
> > this project at first.
> 
> Still thinking about this.  What we want to convey is that, while
> there are races on the particular variable, nobody should be modifying
> the bits here. Adding a READ_ONCE (or data_race()) would miss a
> harmful race where somebody modifies these bits, so in principle I
> agree. However, I think the tool can't automatically tell (even if we
> had compiler extensions to give us the bits accessed) which bits we
> care about, because we might have something like:
> 
> int foo_bar = READ_ONCE(flags) >> FOO_BAR_SHIFT;  // need the
> READ_ONCE because of FOO bits
> .. (foo_bar & FOO_MASK) ..  // FOO bits can be modified concurrently
> .. (foo_bar & BAR_MASK) ..  // nobody should modify BAR bits
> concurrently though !
> 
> What we want is to assert that nobody touches a particular set of
> bits. KCSAN has recently gotten ASSERT_EXCLUSIVE_{WRITER,ACCESS}
> macros which help assert properties of concurrent code, where bugs
> won't manifest as data races. Along those lines, I can see the value
> in doing an exclusivity check on a bitmask of a variable.
> 
> I don't know how much a READ_BITS macro could help, since it's
> probably less ergonomic to have to say something like:
>   READ_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT) >> ZONES_PGSHIFT.
> 
> Here is an alternative:
> 
> Let's say KCSAN gives you this:
>    /* ... Assert that the bits set in mask are not written
> concurrently; they may still be read concurrently.
>      The access that immediately follows is assumed to access those
> bits and safe w.r.t. data races.
> 
>      For example, this may be used when certain bits of @flags may
> only be modified when holding the appropriate lock,
>      but other bits may still be modified locklessly.
>    ...
>   */
>    #define ASSERT_EXCLUSIVE_BITS(flags, mask)   ....
> 
> Then we can write page_zonenum as follows:
> 
> static inline enum zone_type page_zonenum(const struct page *page)
>  {
> +       ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
>         return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
>  }

Actually, it seems still need to write if I understand correctly,

ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
return data_race((page->flags >> ZONES_PGSHIFT) & ZONES_MASK);

On the other hand, if you really worry about this thing could go wrong, it might
be better of using READ_ONCE() at the first place where it will be more future-
proof with the trade-off it might generate less efficient code optimization?

Alternatively, is there a way to write this as this?

return ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);

Kind of ugly but it probably cleaner.

> 
> This will accomplish the following:
> 1. The current code is not touched, and we do not have to verify that
> the change is correct without KCSAN.
> 2. We're not introducing a bunch of special macros to read bits in various ways.
> 3. KCSAN will assume that the access is safe, and no data race report
> is generated.
> 4. If somebody modifies ZONES bits concurrently, KCSAN will tell you
> about the race.
> 5. We're documenting the code.
> 
> Anything I missed?
> 
> Thanks,
> -- Marco
> 
> 
> 
> 
> 
> > thanks,
> > --
> > John Hubbard
> > NVIDIA
> > 
> > > > 
> > > > That's still true, but to a lesser extent if more macros are added. In this case,
> > > > I suspect that READ_BITS() makes the commenting easier and shorter. So I'd tentatively
> > > > lead towards adding it, but what do others on the list think?
> > > 
> > > Even read bits could be dangerous from data races and confusing at best, so I am not really sure what the value of introducing this new macro. People who like to understand it correctly still need to read the commit logs.
> > > 
> > > This flags->zonenum is such a special case that I don’t really see it regularly for the last few weeks digging KCSAN reports, so even if it is worth adding READ_BITS(), there are more equally important macros need to be added together to be useful initially. For example, HARMLESS_COUNTERS(), READ_SINGLE_BIT(), READ_IMMUTATABLE_BITS() etc which Linus said exactly wanted to avoid.
> > > 
