Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE61C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB8217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IptwhJvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBGNR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:17:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46295 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgBGNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:17:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so2061885otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=txfOiqU6r3nZpJSM4LXcf5+mlZrE6+M6BjFGQlFsKaQ=;
        b=IptwhJvIHaJCZv+wMWkb3I4RgrcLVPUmmFijbKZUeOv7puVnSYtm8y5RYgXrc6o4PB
         KF95CHnEbRQ07xjwQlXKAb1dBv7GsjlYjMps2SOGfshxgc6wJROTZYzH3N40tr53C46y
         Q9qNEaiW6SneaOwckNGLzIMxyALbkUc3ElCqcDBUTz9gyDP7Fju8te8TORhaF+v9TGs5
         kQaqgY4L2NkGVtycRKeznmYm9mTQKbrzPH0o7wOPqy5OUOXMLBQ2Vf2IqR+0vfVgmxY/
         JlYn60xijsqrsB6KSsTPd50npTeJAy9YH0JmTu3eD8Hxmpr/xI/5IVAGo58wprBKE/RL
         8K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=txfOiqU6r3nZpJSM4LXcf5+mlZrE6+M6BjFGQlFsKaQ=;
        b=NHix7DSeV+C/UvXUx0Y9AKqaTINdlGpTrArU0f0dxPX8MEloGgP4Wzfz5gLWJ//F/M
         kYUm/OCuEblu8tJiUhf7+0i2RJPGYuyPCGmz2h0pVziM9MR0lhXCSS+aIGi2/uAJjGta
         DL743B/z6+nXi/ByCb/sC8jX9MerZ/WX8sEHxTzGRp8YyjxDlYi9m0m4huyBSMCFoBLF
         S+c7sUdtqH6BgeyyDCdq3R8cU+keqeGvEW8SLzMcx3jmC2I7zeH4BKo0whXhb8zAf+pC
         sOSlhCWpTfW4jVdozMNC7FTKqMKOL/q0Xr8jbAXckfIc35YtPe/7/qNzQBMRfEC2SHAt
         efzg==
X-Gm-Message-State: APjAAAWq0wOczGath3jbB6Qzxzz1P/TXv4PZQd0ZdWZ51hM198V2RfLW
        UKK7mWU0wDgmd7ZJYOnztCMfnve8egQp0xWcdSxltA==
X-Google-Smtp-Source: APXvYqwlzt28Kn1QZL3vIPmdPXpzQ8s+AG3yAKwzaxS/BcMVYI/e60MJPNI5yVwUDpcMgalH/jG2I7gKiWwcvef6TpU=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr2462904oti.251.1581081476918;
 Fri, 07 Feb 2020 05:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20200206145501.GD26114@quack2.suse.cz> <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
 <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com> <235ACF21-35BE-4EDA-BA64-9553DA53BF12@lca.pw>
 <90ab0b09-0f70-fe6d-259e-f529f4ef9174@nvidia.com> <1CFC5A47-3334-4696-89FE-CDF01026B12B@lca.pw>
In-Reply-To: <1CFC5A47-3334-4696-89FE-CDF01026B12B@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 Feb 2020 14:17:45 +0100
Message-ID: <CANpmjNPh0ZXt_t-cZGpM9nm3pzSsb4gzbpGVkhKKVOMdapxwMg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     Qian Cai <cai@lca.pw>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020 at 01:55, Qian Cai <cai@lca.pw> wrote:
>
> > On Feb 6, 2020, at 7:27 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 2/6/20 4:18 PM, Qian Cai wrote:
> >>> On Feb 6, 2020, at 6:34 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> >>> On 2/6/20 7:23 AM, Qian Cai wrote:
> >>>>> On Feb 6, 2020, at 9:55 AM, Jan Kara <jack@suse.cz> wrote:
> >>>>> I don't think the problem is real. The question is how to make KCSA=
N happy
> >>>>> in a way that doesn't silence other possibly useful things it can f=
ind and
> >>>>> also which makes it most obvious to the reader what's going on... I=
MHO
> >>>>> using READ_ONCE() fulfills these targets nicely - it is free
> >>>>> performance-wise in this case, it silences the checker without impa=
cting
> >>>>> other races on page->flags, its kind of obvious we don't want the l=
oad torn
> >>>>> in this case so it makes sense to the reader (although a comment ma=
y be
> >>>>> nice).
> >>>>
> >>>> Actually, use the data_race() macro there fulfilling the same purpos=
e too, i.e, silence the splat here but still keep searching for other races=
.
> >>>>
> >>>
> >>> Yes, but both READ_ONCE() and data_race() would be saying untrue thin=
gs about this code,
> >>> and that somewhat offends my sense of perfection... :)
> >>>
> >>> * READ_ONCE(): this field need not be restricted to being read only o=
nce, so the
> >>> name is immediately wrong. We're using side effects of READ_ONCE().
> >>>
> >>> * data_race(): there is no race on the N bits worth of page zone numb=
er data. There
> >>> is only a perceived race, due to tools that look at word-level granul=
arity.
> >>>
> >>> I'd propose one or both of the following:
> >>>
> >>> a) Hope that Marco (I've fixed the typo in his name. --jh) has an ide=
a to enhance KCSAN so as to support this model of
> >>>  access, and/or

From the other thread:

On Fri, 7 Feb 2020 at 00:18, John Hubbard <jhubbard@nvidia.com> wrote:
>
> Yes. I'm grasping at straws now, but...what about the idiom that page_zon=
enum()
> uses: a set of bits that are "always" (after a certain early point) read-=
only?
> What are your thoughts on that?

Without annotations it's hard to tell. The problem is that the
compiler can still emit a word-sized load, even if you're just
checking 1 bit. The instrumentation emitted for KCSAN only cares about
loads/stores, where access size is in number of bytes and not bits,
since that's what the compiler has to emit.  So, strictly speaking
these are data races: concurrent reads / writes where at least one
access is plain.

With the above caveat out of the way, we already have the following
defaults in KCSAN (after similar requests):
1. KCSAN ignores same-value stores, i.e. races with writes that appear
to write the same value do not result in data race reports.
2. KCSAN does not demand aligned writes (including things like 'var++'
if there are no concurrent writers) up to word size to be marked (with
READ_ONCE etc.), assuming there is no way for the compiler to screw
these up. [I still recommend writes to be marked though, if at all
possible, because I'm still not entirely convinced it's always safe!]

So, because of (2), KCSAN will not complain if you have something like
'flags |=3D SOME_FLAG' (where the read is marked). Because of (1), it'll
still complain about 'flags & SOME_FLAG' though, since the load is not
marked, and only sees this is a word-sized access (assuming flags is a
long) where a bit changed.

I don't think it's possible to easily convey to KCSAN which bits of an
access you only care about, so that we could extend (1).   Ideas?

> >> A similar thing was brought up before, i.e., anything compared to zero=
 is immune to load-tearing
> >> issues, but it is rather difficult to implement it in the compiler, so=
 it was settled to use data_race(),
> >>
> >> https://lore.kernel.org/lkml/CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=3DcozW=
5cYkm8h-GTBg@mail.gmail.com/#r
> >>
> >
> > Thanks for that link to the previous discussion, good context.
> >
> >>>
> >>> b) Add a new, better-named macro to indicate what's going on. Initial=
 bikeshed-able
> >>>  candidates:
> >>>
> >>>     READ_RO_BITS()
> >>>     READ_IMMUTABLE_BITS()
> >>>     ...etc...
> >>>

This could work, but 'READ_BITS()' is enough, if KCSAN's same-value
filter is default on anyway.  Although my preference is also to avoid
more macros if possible.

> >> Actually, Linus might hate those kinds of complication rather than a s=
imple data_race() macro,
> >>
> >> https://lore.kernel.org/linux-fsdevel/CAHk-=3Dwg5CkOEF8DTez1Qu0XTEFw_o=
HhxN98bDnFqbY7HL5AB2g@mail.gmail.com/
> >>
> >
> > Another good link. However, my macros above haven't been proposed yet, =
and I'm perfectly
> > comfortable proposing something that Linus *might* (or might not!) hate=
. No point in
> > guessing about it, IMHO.
> >
> > If you want, I'll be happy to put on my flame suit and post a patchset =
proposing
> > READ_IMMUTABLE_BITS() (or a better-named thing, if someone has another =
name idea).  :)
> >
>
> BTW, the current comment said (note, it is called =E2=80=9Caccess=E2=80=
=9D which in this case it does read the whole word
> rather than those 3 bits, even though it is only those bits are of intere=
sted for us),
>
> /*
>  * data_race(): macro to document that accesses in an expression may conf=
lict with
>  * other concurrent accesses resulting in data races, but the resulting
>  * behaviour is deemed safe regardless.
>  *
>  * This macro *does not* affect normal code generation, but is a hint to =
tooling
>  * that data races here should be ignored.
>  */
>
> Macro might have more to say.

I agree that data_race() would be the most suitable here, since
technically it's still a data race. It just so happens that we end up
"throwing away" most of the bits of the access, and just care about a
few bits.

Thanks,
-- Marco
