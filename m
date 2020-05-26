Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D80EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1482320849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNOLZx+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgEZRdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730126AbgEZRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:33:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D04C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:33:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u12so358330wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sys0Nh8QzHuS5xSYWpqlM7xhUHriFZcWSU4k6Houjjc=;
        b=vNOLZx+V9PHfTKNJE77TjAPs8gpGdOhJLHjsKhBB7uiRDRih/JjHWfuUkRSr7RrG63
         y52mqcbOd2s09uWcQXYY0juYnoVvX/1ocuyAwVbooIfRdV6CwMTwNkTMedyimRKCBPku
         TCo9xpABEYaE68bVrFH+J2H4DroBy+IVnXS5XwMGPZzGCsh2j32/bWKE0guwW2/Fe/RL
         2aCICAvENunrf5NvasNCUMLPmBxeDoay51ujl2CCB8xli7sMJGubch0ouRJWQMU+l9J2
         nsS1Mj1vj4dIAs8OdGU1Ny4ieMWta3csztYEFd9dabbE0H6EHAaqYML3Rtui3PD9Vzrr
         OAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sys0Nh8QzHuS5xSYWpqlM7xhUHriFZcWSU4k6Houjjc=;
        b=C4UxSj+7w+NI7b9h5Wgntp+jnRBrtEQNa2KwrAqKO+wwmaOZAUBxC3SpJf6BUBFDmt
         MhO2q8EF1EoqxEVWuAE3maHvjLm2NVS4YoIYmGOOOKnqEyFlbVn7D0OANRerTEzSFwlq
         wrcYGxxHGk29PHpNE5X7RDGOUev4/UGI+k02Zb/3Fg5sTtkUr82Kt76KmBvc2JMar8rC
         q+OfdZLbweyvwLIBspmqlU/mnZeKioe81HiKWDo1ISYIxSqUVLQZea2lwqSEm279HHOM
         Exwj8UQyZh79Y49AOJgjvbXh6PfWMr+FUVlhlpronN8eEXyMdzFBOsg6furgYDS/feVU
         4iDQ==
X-Gm-Message-State: AOAM533H2za75xe7YcLpddU03OiBFtiPlNZt90xVZdvUA9qSaxk95UqF
        igQa0UMkdbusZ12ONBg5hAJDTg==
X-Google-Smtp-Source: ABdhPJzvh92MOjYPVX/DWXpsDQGy5CF8m4Z/R9p3RTIp8UdLMyMSRfVGfN1aMmr5bsqukiJf0bG/Wg==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr267995wmh.37.1590514398940;
        Tue, 26 May 2020 10:33:18 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id e29sm525252wra.7.2020.05.26.10.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:33:17 -0700 (PDT)
Date:   Tue, 26 May 2020 19:33:12 +0200
From:   Marco Elver <elver@google.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement
 expression
Message-ID: <20200526173312.GA30240@google.com>
References: <20200521142047.169334-1-elver@google.com>
 <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
 <20200526120245.GB27166@willie-the-truck>
 <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
 <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020, Marco Elver wrote:

> On Tue, 26 May 2020 at 14:19, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, May 26, 2020 at 2:02 PM Will Deacon <will@kernel.org> wrote:
> > > On Tue, May 26, 2020 at 12:42:16PM +0200, Arnd Bergmann wrote:
> > > >
> > > > I find this patch only solves half the problem: it's much faster than
> > > > without the
> > > > patch, but still much slower than the current mainline version. As far as I'm
> > > > concerned, I think the build speed regression compared to mainline is not yet
> > > > acceptable, and we should try harder.
> > > >
> > > > I have not looked too deeply at it yet, but this is what I found from looking
> > > > at a file in a randconfig build:
> > > >
> > > > Configuration: see https://pastebin.com/raw/R9erCwNj
> > >
> > > So this .config actually has KCSAN enabled. Do you still see the slowdown
> > > with that disabled?
> >
> > Yes, enabling or disabling KCSAN seems to make no difference to
> > compile speed in this config and source file, I still get the 12 seconds
> > preprocessing time and 9MB file size with KCSAN disabled, possibly
> > a few percent smaller/faster. I actually thought that CONFIG_FTRACE
> > had a bigger impact, but disabling that also just reduces the time
> > by a few percent rather than getting it down to the expected milliseconds.
> >
> > > Although not ideal, having a longer compiler time when
> > > the compiler is being asked to perform instrumentation doesn't seem like a
> > > show-stopper to me.
> >
> > I agree in general, but building an allyesconfig kernel is still an important
> > use case that should not take twice as long after a small kernel change
> > regardless of whether a new feature is used or not. (I have not actually
> > compared the overall build speed for allmodconfig, as this takes a really
> > long time at the moment)
> 
> Note that an 'allyesconfig' selects KASAN and not KCSAN by default.
> But I think that's not relevant, since KCSAN-specific code was removed
> from ONCEs. In general though, it is entirely expected that we have a
> bit longer compile times when we have the instrumentation passes
> enabled.
> 
> But as you pointed out, that's irrelevant, and the significant
> overhead is from parsing and pre-processing. FWIW, we can probably
> optimize Clang itself a bit:
> https://github.com/ClangBuiltLinux/linux/issues/1032#issuecomment-633712667

Found that optimizing __unqual_scalar_typeof makes a noticeable
difference. We could use C11's _Generic if the compiler supports it (and
all supported versions of Clang certainly do).

Could you verify if the below patch improves compile-times for you? E.g.
on fs/ocfs2/journal.c I was able to get ~40% compile-time speedup.

Thanks,
-- Marco

------ >8 ------

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 5faf68eae204..a529fa263906 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -245,7 +245,9 @@ struct ftrace_likely_data {
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
- *
+ */
+#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900
+/*
  * We build this out of a couple of helper macros in a vain attempt to
  * help you keep your lunch down while reading it.
  */
@@ -267,6 +269,24 @@ struct ftrace_likely_data {
 			__pick_integer_type(x, int,				\
 				__pick_integer_type(x, long,			\
 					__pick_integer_type(x, long long, x))))))
+#else
+/*
+ * If supported, prefer C11 _Generic for better compile-times. As above, 'char'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ */
+#define __scalar_type_to_expr_cases(type)				\
+		type: (type)0, unsigned type: (unsigned type)0
+
+#define __unqual_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 __scalar_type_to_expr_cases(char),		\
+			 signed char: (signed char)0,			\
+			 __scalar_type_to_expr_cases(short),		\
+			 __scalar_type_to_expr_cases(int),		\
+			 __scalar_type_to_expr_cases(long),		\
+			 __scalar_type_to_expr_cases(long long),	\
+			 default: (x)))
+#endif
 
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \

