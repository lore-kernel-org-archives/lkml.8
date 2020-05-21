Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B33C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554952072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXlGtQiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgEUN1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgEUN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:27:03 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C1C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:27:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v17so5523240ote.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Moc8xalnKllIyEU4EMIrwAPrYnUw5Fl91QeBkTIQAoU=;
        b=GXlGtQiQaxvoKjPhENuW0Yo48zaUNh8OYTsBNf5sIYxfYJMM7j5rAKAGmJxEYsu5o/
         XKwVa8BGYWdWTkZpRNcHr1kt6CoaDsL41XAhLXyRuuxC2zaRkTkiTRHgezKsr6xh7i3U
         Jeizwmzq/m3u/7DKGSwYzWVlCQNURvQAG6PFIrrWLi+lBS14IiAVGLr+uTxrwDn7j8P6
         ZXewMF/LMvF5NCAsDXCW3Fo08pBQynl+f5jzwblurJnUCjgKiA1u9BnaANrcfrQs1klZ
         SXqK5fpmbfRGbbmodC6eJgbYX2VccAEwqxwj4C0HB+eU2co6lDDf8RdlAU2733umcqo8
         +SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Moc8xalnKllIyEU4EMIrwAPrYnUw5Fl91QeBkTIQAoU=;
        b=HTZF6fZfEKrCk+pRzAJpXNthfY5EFqJcOz3R3Yjyf/zPwPY2qTOeZV3gxTgoNdxNqY
         MMTHUJ+CcOJYJ27Wx9FT/EWHZlE1ON7+LTUZMVolBpSvCEsm4YAdAE/7u/FoAKvD6kAd
         g4HmSoRx76a2iMeYLobFe10s1T4kHW/4+nq2YRVL4Kl8AEPSTtJdYmrjDAsyMa4cFwHU
         he4kGD/CwU5gBaw5c7vEka2lDidlFbjEcX0SuEDDVJxvEQdBBE/0/9z34qigGpO0EXui
         BgnboWo2P25XP//gITAFtoh8MCG/bdonuuHmz2mYenCIJhUEKM89NCgk0gn+qk1i1PNh
         hZig==
X-Gm-Message-State: AOAM531jfQD1K4pHZ9lb+ojTtgUIDBHSHKVlVREr2Kz/Om1ndc9LzK6k
        eYj7+yMD2H34vqdjA39OcgHXXpua8QDTCNV+9JW1Ew==
X-Google-Smtp-Source: ABdhPJyT8hKiTawRva7d5TY4mEqbpwDUXMt/leaQKn5E2alKa6Dw6mOZkg+aznYEIRJPaFPvaPLmc2qlGHhrUXd/DPg=
X-Received: by 2002:a05:6830:18ce:: with SMTP id v14mr6550417ote.251.1590067622152;
 Thu, 21 May 2020 06:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200521110854.114437-1-elver@google.com> <20200521110854.114437-4-elver@google.com>
 <20200521131803.GA6608@willie-the-truck>
In-Reply-To: <20200521131803.GA6608@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 15:26:48 +0200
Message-ID: <CANpmjNNDRb+wokzagQtLRVvZrj-8eH87gOX1JwG9hWf+eicRNg@mail.gmail.com>
Subject: Re: [PATCH -tip v2 03/11] kcsan: Support distinguishing volatile accesses
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 at 15:18, Will Deacon <will@kernel.org> wrote:
>
> On Thu, May 21, 2020 at 01:08:46PM +0200, Marco Elver wrote:
> > In the kernel, volatile is used in various concurrent context, whether
> > in low-level synchronization primitives or for legacy reasons. If
> > supported by the compiler, we will assume that aligned volatile accesses
> > up to sizeof(long long) (matching compiletime_assert_rwonce_type()) are
> > atomic.
> >
> > Recent versions Clang [1] (GCC tentative [2]) can instrument volatile
> > accesses differently. Add the option (required) to enable the
> > instrumentation, and provide the necessary runtime functions. None of
> > the updated compilers are widely available yet (Clang 11 will be the
> > first release to support the feature).
> >
> > [1] https://github.com/llvm/llvm-project/commit/5a2c31116f412c3b6888be361137efd705e05814
> > [2] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html
> >
> > This patch allows removing any explicit checks in primitives such as
> > READ_ONCE() and WRITE_ONCE().
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Reword Makefile comment.
> > ---
> >  kernel/kcsan/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> >  scripts/Makefile.kcsan |  5 ++++-
> >  2 files changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index a73a66cf79df..15f67949d11e 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -789,6 +789,49 @@ void __tsan_write_range(void *ptr, size_t size)
> >  }
> >  EXPORT_SYMBOL(__tsan_write_range);
> >
> > +/*
> > + * Use of explicit volatile is generally disallowed [1], however, volatile is
> > + * still used in various concurrent context, whether in low-level
> > + * synchronization primitives or for legacy reasons.
> > + * [1] https://lwn.net/Articles/233479/
> > + *
> > + * We only consider volatile accesses atomic if they are aligned and would pass
> > + * the size-check of compiletime_assert_rwonce_type().
> > + */
> > +#define DEFINE_TSAN_VOLATILE_READ_WRITE(size)                                  \
> > +     void __tsan_volatile_read##size(void *ptr)                             \
> > +     {                                                                      \
> > +             const bool is_atomic = size <= sizeof(long long) &&            \
> > +                                    IS_ALIGNED((unsigned long)ptr, size);   \
> > +             if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
> > +                     return;                                                \
> > +             check_access(ptr, size, is_atomic ? KCSAN_ACCESS_ATOMIC : 0);  \
> > +     }                                                                      \
> > +     EXPORT_SYMBOL(__tsan_volatile_read##size);                             \
> > +     void __tsan_unaligned_volatile_read##size(void *ptr)                   \
> > +             __alias(__tsan_volatile_read##size);                           \
> > +     EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
> > +     void __tsan_volatile_write##size(void *ptr)                            \
> > +     {                                                                      \
> > +             const bool is_atomic = size <= sizeof(long long) &&            \
> > +                                    IS_ALIGNED((unsigned long)ptr, size);   \
> > +             if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
> > +                     return;                                                \
> > +             check_access(ptr, size,                                        \
> > +                          KCSAN_ACCESS_WRITE |                              \
> > +                                  (is_atomic ? KCSAN_ACCESS_ATOMIC : 0));   \
> > +     }                                                                      \
> > +     EXPORT_SYMBOL(__tsan_volatile_write##size);                            \
> > +     void __tsan_unaligned_volatile_write##size(void *ptr)                  \
> > +             __alias(__tsan_volatile_write##size);                          \
> > +     EXPORT_SYMBOL(__tsan_unaligned_volatile_write##size)
> > +
> > +DEFINE_TSAN_VOLATILE_READ_WRITE(1);
> > +DEFINE_TSAN_VOLATILE_READ_WRITE(2);
> > +DEFINE_TSAN_VOLATILE_READ_WRITE(4);
> > +DEFINE_TSAN_VOLATILE_READ_WRITE(8);
> > +DEFINE_TSAN_VOLATILE_READ_WRITE(16);
>
> Having a 16-byte case seems a bit weird to me, but I guess clang needs this
> for some reason?

Yes, the emitted fixed-size instrumentation is up to 16 bytes, so
we'll need it (for both volatile and non-volatile -- otherwise we'll
get linker errors). It doesn't mean we'll consider 16 byte volatile
accesses as atomic, because of the size check to compute is_atomic
above.

Thanks,
-- Marco
