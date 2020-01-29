Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E738C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017B52064C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phRBcjau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgA2MWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:22:03 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43407 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA2MWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:22:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so15292507oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 04:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kgn4GQBjvZyBAIu6NGCbaVyen3lY97LcGgNiimjGj/Q=;
        b=phRBcjaur7ITBOkqk5XTPrxyTXZOs2jwKLwhceVHmZrIGkzjAA+YGugG9jRKZhA6Cd
         kwEAM87ZSvXBKr6baOvtgQJhb7e1hO3Ppm4SJKTJtE5DN8nbSv4k5WpiHW8QaeTl651J
         l93XHr9fMHLJRqRfTqvcZwfSIHqGyxXnDdQi98uWUA2p9doiLia3Zl+YWF6GXmhSOFop
         3I1JBPp59ih27dLmEn88Kby+o8RQgUgyL9AA1er0WLmmm2s0M4BA/1cRWtTkwSNGTaxL
         dnREovtzSOuKw8t/KR5ZmGQECMciE2XkcIwEEXh4R6TZ+JngFiNBjw5bAJwlK31KUSLE
         we3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kgn4GQBjvZyBAIu6NGCbaVyen3lY97LcGgNiimjGj/Q=;
        b=AVx3oZRpJPz0FvrtME0u87PbSJdkgpDncR+2S/zOO1MVRhRDDhyjurzYiPtNI8IR0M
         gCe8ZjhUTd3lplffa5YVKXKLaLj4DkoLWwZt3N/p44ckf8DCIfnHoqMbOvtJ6j8fI9oc
         zRbQ9qZA89SqvPBlMLZcQUA0tU4sHfVY832Phm6ctjqFH/XCaD7Q56OvFhSV/pwtZ01p
         9lOmwfjq4Fukmws7teWZ9likgLtgw37YyyNxxrFlV/Vk+CFDBP+tb5uBLXl7fv/eVpAz
         vu5mCHYD0YzVd93++zRNj44WCJJo0afbkJZNFB8pmn6+XHOuKvFKjU9NNyS7Vl9fQ6gd
         lXGg==
X-Gm-Message-State: APjAAAXw2tJbZCbN3Ithk0mAEqlZnq59vpNtFjjYKJvu6DHAm9x9PHZX
        CzBA8k1sR6zpQ1hhpRQ+XNZE8FNC7vbxaclJprvyFw==
X-Google-Smtp-Source: APXvYqzTfv+9BBZ36pv1LA1tPywV6VN5tvF9EncWG85nhPRdV9EPmBfwUGfUbafjTLYZXGT/tr30soJg+A6RqFedaxk=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr18932727oti.251.1580300521393;
 Wed, 29 Jan 2020 04:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20200129105224.4016-1-cai@lca.pw> <20200129120302.GJ24244@dhcp22.suse.cz>
 <59f892d0-5fc4-ae32-ce65-5a688d9180c8@I-love.SAKURA.ne.jp>
In-Reply-To: <59f892d0-5fc4-ae32-ce65-5a688d9180c8@I-love.SAKURA.ne.jp>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 Jan 2020 13:21:49 +0100
Message-ID: <CANpmjNOdFsU9gg7FSv7Pue0L2eAQ+5UHHaz9bgZ83r94prA4vQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_counter: fix various data races
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Qian Cai <cai@lca.pw>, Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 at 13:13, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/01/29 21:03, Michal Hocko wrote:
> >> Fixes: 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Please include
>
> Reported-by: syzbot+f36cfe60b1006a94f9dc@syzkaller.appspotmail.com
>
> for https://syzkaller.appspot.com/bug?id=744097b8b91cecd8b035a6f746bb12e4efc7669f .
>
> By the way, can READ_ONCE()/WRITE_ONCE() really solve this warning?
> The link above says read/write on the same location ( mm/page_counter.c:129 ).
> I don't know how READ_ONCE()/WRITE_ONCE() can solve the race.

It avoids the *data* race, with *_ONCE telling the compiler to not
optimize the accesses in concurrency-unfriendly ways.  Since *_ONCE is
used, it conveys clear intent that the code here is meant to be
concurrent, and KCSAN stops complaining (and assumes that the *logic*
is correct).

The race itself is still there, but as per comment in the file,
apparently fine and not a logic bug.

> >
> >> ---
> >>  mm/page_counter.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/page_counter.c b/mm/page_counter.c
> >> index de31470655f6..a17841150906 100644
> >> --- a/mm/page_counter.c
> >> +++ b/mm/page_counter.c
> >> @@ -82,8 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
> >>               * This is indeed racy, but we can live with some
> >>               * inaccuracy in the watermark.
> >>               */
> >> -            if (new > c->watermark)
> >> -                    c->watermark = new;
> >> +            if (new > READ_ONCE(c->watermark))
> >> +                    WRITE_ONCE(c->watermark, new);
> >>      }
> >>  }
> >>
> >> @@ -135,8 +135,8 @@ bool page_counter_try_charge(struct page_counter *counter,
> >>               * Just like with failcnt, we can live with some
> >>               * inaccuracy in the watermark.
> >>               */
> >> -            if (new > c->watermark)
> >> -                    c->watermark = new;
> >> +            if (new > READ_ONCE(c->watermark))
> >> +                    WRITE_ONCE(c->watermark, new);
> >>      }
> >>      return true;
> >>
> >> --
> >> 2.21.0 (Apple Git-122.2)
> >
>
