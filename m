Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55DDC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949B720757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9mKcLex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgH3Ucu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgH3Ucn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:32:43 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F9C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:32:43 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c6so4817449ilo.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esi4APd6js7tQdMbufSPElZ7NuyBnkeTkL+ZgHZkw/M=;
        b=M9mKcLexU8UBVnf42soCjmozhxXNLprujelMGPf/u76saTm0BFGYIrQtr0PwA6pGhD
         O3Q+T0teWCIn0M4UjG/9b2SNA4GrfKBH9ee2e7xFDG6erP+ncwjQMwaM0LDxXV7MHfHR
         C6y8qeIw3+XqrqiLjwhF7EXY/E2ntjehIjPKQtHJsS7/WBwJGaDGgXcAay9ddJtcxMzB
         1lKX4FpjsM0vjwiCfH38wEbD4spMaBlcbKeiyBBo4PCuPjkeeT43/vlLMpRxvMZY5k7i
         J25f2DlyRE+QVW/tL7a3tNsYZKmKmXvdlZ/kaTwaU3CvdJV4/qHVKmHTtqDrxvW8H4Oz
         QUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esi4APd6js7tQdMbufSPElZ7NuyBnkeTkL+ZgHZkw/M=;
        b=tEe7KcSrX3qU+7v/xjToAFeP24FZ2qTrcHgTMJocVn/5INj3lk9i5CcyyY/6p6LFBC
         EaGtTLHv6hscjeFN0IeuqfPrJv7awUdsSNe/E+3TrxRvHmaE0a+NtYogWN1JcGRs3z7m
         TPMnrMhbcseqrJdpC8pHeXr+oitnJaKrPH4PkcKdXjzvr/gfJ1wouwfJIxjuqVuiK/lL
         vERz8an6RsFf26FtGgm3c55QsG9yYfGIx7UaEA924YJDiWMZGgkppzcJKWttEDYA+wP8
         sJ1TQzr8Jw+E6eW7KzOvfU5hm2Qgk7vlvqV6+u41y6/tvIQIfQjBdKSoHjCkN6+HMvT/
         CHqg==
X-Gm-Message-State: AOAM532TLqswPzLCrsI5yEOtnscHHnXIm27yyRFaQFPcHk/GlU6SeMC0
        HLEwUhql2bLiWn3TdpIuHEHBz/H0NS5se39hmlA=
X-Google-Smtp-Source: ABdhPJykWH7HEkh4v/H2sjTK6gmkzVPQHarMx3KqVJQEi8o6YVlyrhgF6s1M7EkJUq2QyLLc7vGVYy0gPT8iS6JX/Rs=
X-Received: by 2002:a92:b74c:: with SMTP id c12mr6237302ilm.237.1598819561416;
 Sun, 30 Aug 2020 13:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
 <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com> <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
 <CAKgT0UcXRB2HH4S+k=SmTz0Dgw9pKp=i4kT4U+yy8MFVC6_JWQ@mail.gmail.com> <e2bda56b-445d-f2a3-3a3c-3193d65cc743@linux.alibaba.com>
In-Reply-To: <e2bda56b-445d-f2a3-3a3c-3193d65cc743@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sun, 30 Aug 2020 13:32:30 -0700
Message-ID: <CAKgT0UdwOiFocPO5GtjeysPGtOPVVp3E507Wedwz69Em=ejqXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/pageblock: remove false sharing in pageblock_flags
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 3:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/8/20 =E4=B8=8A=E5=8D=8812:50, Alexander Duyck =E5=86=99=E9=
=81=93:
> > On Wed, Aug 19, 2020 at 1:11 AM Alex Shi <alex.shi@linux.alibaba.com> w=
rote:
> >>
> >>
> >>
> >> =E5=9C=A8 2020/8/19 =E4=B8=8B=E5=8D=883:57, Anshuman Khandual =E5=86=
=99=E9=81=93:
> >>>
> >>>
> >>> On 08/19/2020 11:17 AM, Alex Shi wrote:
> >>>> Current pageblock_flags is only 4 bits, so it has to share a char si=
ze
> >>>> in cmpxchg when get set, the false sharing cause perf drop.
> >>>>
> >>>> If we incrase the bits up to 8, false sharing would gone in cmpxchg.=
 and
> >>>> the only cost is half char per pageblock, which is half char per 128=
MB
> >>>> on x86, 4 chars in 1 GB.
> >>>
> >>> Agreed that increase in memory utilization is negligible here but doe=
s
> >>> this really improve performance ?
> >>>
> >>
> >> It's no doubt in theory. and it would had a bad impact according to
> >> commit e380bebe4771548  mm, compaction: keep migration source private =
to a single
> >>
> >> but I do have some problem in running thpscale/mmtest. I'd like to see=
 if anyone
> >> could give a try.
> >>
> >> BTW, I naturally hate the false sharing even it's in theory. Anyone wh=
o doesn't? :)
> >
> > You keep bringing up false sharing but you don't fix the false sharing
> > by doing this. You are still allowing the flags for multiple
> > pageblocks per cacheline so you still have false sharing even after
> > this.
>
> yes, the cacheline false sharing is still there. But as you pointed, cmpx=
chg level
> false sharing could be addressed much by the patchset.
>
>
> >
> > What I believe you are attempting to address is the fact that multiple
> > pageblocks share a single long value and that long is being used with
> > a cmpxchg so you end up with multiple threads potentially all banging
> > on the same value and watching it change. However the field currently
> > consists of only 4 bits, 3 of them for migratetype and 1 for the skip
> > bit. In the case of the 3 bit portion a cmpxchg makes sense and is
> > usually protected by the zone lock so you would only have one thread
> > accessing it in most cases with the possible exception of a section
> > that spans multiple zones.
> >
> > For the case such as the skip bit and MIGRATE_UNMOVABLE (0x0) where we
> > would be clearing or setting the entire mask maybe it would make more
> > sense to simply use an atomic_or or atomic_and depending on if you are
> > setting or clearing the flag? It would allow you to avoid the spinning
> > or having to read the word before performing the operation since you
> > would just be directly applying an AND or OR via a mask value.
>
> Right that the different level to fix this problem, but narrow the cmpxch=
g
> comparsion is still needed and helpful.

What I was getting at though is that I am not sure that is the case.
Normally I believe we are always holding the zone lock when updating
the migrate type. The skip flag is a one-off operation that could
easily be addressed by changing the logic to use atomic_and or
atomic_or for the cases where we are updating single bit flags and
setting the mask value to all 1's or all 0's. So adding this extra
complexity which only really applies to the skip bit may not provide
much value, especially as there are a number of possible paths that
don't use the skip bit anyway.
