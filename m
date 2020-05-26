Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998B62078C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392317AbgEZXKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:10:24 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389393AbgEZXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:10:23 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUGRh-1jVENz3Doh-00RKli for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 01:10:20 +0200
Received: by mail-qk1-f175.google.com with SMTP id c12so3683777qkk.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:10:20 -0700 (PDT)
X-Gm-Message-State: AOAM530cGL+dZfNLlAShnZGs3ZfWw2W0I75H4XTMk1pZoYDKqpVW3FO2
        RnKQJJfalR+GCY99BDzuK/Wij+pi99exz1Wpt20=
X-Google-Smtp-Source: ABdhPJxvhF5dAQEmjiyCXYpCNxiRVM0X1pG0cUQwk6kXEo96Pl+tV/VH1jHfqn9g+MFLfzHhWqVjdWOrH5a70s683l0=
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr1313150qkg.394.1590534619533;
 Tue, 26 May 2020 16:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
 <20200526120245.GB27166@willie-the-truck> <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
 <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
 <20200526173312.GA30240@google.com> <CAK8P3a3ZawPnzmzx4q58--M1h=v4X-1GtQLiwL1=G6rDK8=Wpg@mail.gmail.com>
In-Reply-To: <CAK8P3a3ZawPnzmzx4q58--M1h=v4X-1GtQLiwL1=G6rDK8=Wpg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 01:10:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com>
Message-ID: <CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement expression
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tDr3kwqXDn2DAV1kLym2OwfUGs0QXensvFlDmHfMxxc0+AXvo4S
 nMTH93yhdS7++FrvU/GBBdBpNG9pbi+VWlpaf+8miO3d9R1l2FBGR9IollbgoAoxFXqqig1
 ibYWPG4Ikm0xVeWqAy8IENBsimv4l0wng7mekp2vp79AeXINvMhoJDz44SWbP+dlNJl8TC0
 HV+0jE9fV2yb8d/MKrnLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AZ+8c5XW41w=:sxYyG3q0dUHzvd2HFP1y1M
 +0QOCVaRYuq+dC+vUypWv98MIY44UNk837XeVgBdzT4rd9yWzvUYzXWZeW8ZGFFUohHzuX01H
 7pZcXbPbB7SnVKKwYgD6Ist2A9RbaV+6s/Y1o2YYXfq0kklt6EQx+VsKsVG/XoCtt4qgSV+m+
 QhjS1bqKcGpnYnMg4C2tOCNMdh2vp2C5M/4FZfiHmSgTzJk5xGN9Zwu0O+DhfHo1bs0DWgXQ8
 5/PWMRlh8Ix6bDYZ3bBRwI+/vSbNrR2XfV0z2+Bwp8gqco9+AHvmIXMpT/Oe9nbsclyLEalac
 bQHuVvBIlQpBR/FmAzCaVW8D7gHgTcJXmz/PTgGFdw+zZM4S5lrFJVwJa4Pwic0bHl35Dl1o5
 0q3Ug+BhIxlnu3atDnGApUGs5LJwXti+gJhan1arjYOR2kHZo0Ul5IlapSYE+A4ov9CVJXSDM
 1gIfR5o0wYhr7/7Re2YCAHHcvxwoV1QCXL94ZXwe8oUk5zW7K0BfvJONRn2rc5BnBV11FPpfO
 646/xEmINkkeCu1F7AGr2xf+Ld5QaVB9DZKVuegqLKhgZglc0MSfbg/Bzi4GP0ztQ1/g9J0sx
 Z2l1c0Pp5mf82LeXFOWQtFW8DgNBbG2ndlgXXdQRiN1Eu5gnZ5C3ZNQhT7UBRABJXig6Fn1pM
 NxjsUi4Ke8ZsiQQZwGmjvCkcJSwbw1nfc+AHktwhO6YQcovqtL6b6nJ22sDkU5XpBdpU3S8eq
 2kwDaSNZNOxirkf/+izSOptsVI9RwooL2Veci5hUysQlktQR1Syuf/uQUrBRXb8upJ5Cbjb8b
 bxu/7AYyxpz8GmZLdDM4Cyqtm5ruqSTcAo5i8HrP5IMS2bglOw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 9:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 26, 2020 at 7:33 PM 'Marco Elver' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> > On Tue, 26 May 2020, Marco Elver wrote:
> > > On Tue, 26 May 2020 at 14:19, Arnd Bergmann <arnd@arndb.de> wrote:
> > > Note that an 'allyesconfig' selects KASAN and not KCSAN by default.
> > > But I think that's not relevant, since KCSAN-specific code was removed
> > > from ONCEs. In general though, it is entirely expected that we have a
> > > bit longer compile times when we have the instrumentation passes
> > > enabled.
> > >
> > > But as you pointed out, that's irrelevant, and the significant
> > > overhead is from parsing and pre-processing. FWIW, we can probably
> > > optimize Clang itself a bit:
> > > https://github.com/ClangBuiltLinux/linux/issues/1032#issuecomment-633712667
> >
> > Found that optimizing __unqual_scalar_typeof makes a noticeable
> > difference. We could use C11's _Generic if the compiler supports it (and
> > all supported versions of Clang certainly do).
> >
> > Could you verify if the below patch improves compile-times for you? E.g.
> > on fs/ocfs2/journal.c I was able to get ~40% compile-time speedup.
>
> Yes, that brings both the preprocessed size and the time to preprocess it
> with clang-11 back to where it is in mainline, and close to the speed with
> gcc-10 for this particular file.
>
> I also cross-checked with gcc-4.9 and gcc-10 and found that they do see
> the same increase in the preprocessor output, but it makes little difference
> for preprocessing performance on gcc.

Just for reference, I've tested this against a patch I made that completely
shortcuts READ_ONCE() on anything but alpha (which needs the
read_barrier_depends()):

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -224,18 +224,21 @@ void ftrace_likely_update(struct
ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x) (*(const volatile __unqual_scalar_typeof(x) *)&(x))
+#define __READ_ONCE(x) (*(const volatile typeof(x) *)&(x))

+#ifdef CONFIG_ALPHA /* smp_read_barrier_depends is a NOP otherwise */
 #define __READ_ONCE_SCALAR(x)                                          \
 ({                                                                     \
        __unqual_scalar_typeof(x) __x = __READ_ONCE(x);                 \
        smp_read_barrier_depends();                                     \
-       (typeof(x))__x;                                                 \
+       __x;                                                            \
 })
+#else
+#define __READ_ONCE_SCALAR(x) __READ_ONCE(x)
+#endif

 #define READ_ONCE(x)                                                   \
 ({                                                                     \

In the configuration I posted earlier, this produces noticeably faster
build times
patch, but yours gets most of the way: https://pastebin.com/pCwALmUD

Looking just at the "task-clock" output from 'perf stat make vmlinux -skj30'

                 clang-11          gcc-9
linux-next     6939594.65 msec   4191482.92 msec
Marco's patch  5399261.82 msec   3800409.58 msec
Arnd's patch   5273888.54 msec   3584550.23 msec

        Arnd
