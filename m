Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99624C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4432065C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3DoQg0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgFDRFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbgFDRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:05:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55129C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:05:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so2441884plt.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lISUp6znJVR2B4ykX8SGIADCyXExJUwiZFK3+UkXhn4=;
        b=F3DoQg0w7AizR01hSACjgdbIEuPLsQtzNSZwkwl57RZ0eC+rtlR1dcu7saYRx4xSrT
         7N3BhM/cpgTeDDwuYbjQ60vVUt0FPGFLMz0lIxiggg5GMjiCeOCEHqE5O6bfDNmt9kIp
         PTC4SNEBBLptoQ+Wjl0QqTk2i5p0IGz3r2j18VVaI9VKl61fWVeJoig2SEvHCoux+pGG
         eV3BFVavTGz4E7IA0ka9ce3m1XDoNyvxSNR5O75USy8B5iQ6fUfnsEPEHmG+cxrIlUxT
         I859yqdFdR0ernptJWtekpW1o6XVBL1tNr1jQMfu4/ZRrOg+jpSTefYbICLZWUapyyxl
         qe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lISUp6znJVR2B4ykX8SGIADCyXExJUwiZFK3+UkXhn4=;
        b=JWci1TQ2gTakghgNh8w7UhiJNRiR6YKh+JckLx1y5t5Sh5bREcBOig5bnNrEDFANwV
         XqcAYY1QvkVSBB9PgO+jqUgIJxcbtAERBSlsG+GLPlkZoCvcarX2O4ca1IU3BKg5efAM
         3FjtP5vkQ3U/W0a95IJL1PWX7AQhfwsZ1WLoGBeJMTulBn9qLt5PGfOAHjJ6qIdJY3MF
         hJ+2ftogko4yBlTwuiUHOrePWg7oVT0kb9SeCorRSs26eKbU7FH3hAct+lLrixse/Xh7
         WEBYw9jE02er4l90iABPajf6acKKO1SFKSPstbvje6gCNdLyHPQULsBEHYIx2eQ/UM9W
         vaPA==
X-Gm-Message-State: AOAM533TkcM2Sbn8hozgZqGnIpU3fISWG8R2CR89HTn+zTp/5jGcparC
        ptQDs5+UUm1IaVGI29UO/q53GOHFielJFtwZzdOBIQ==
X-Google-Smtp-Source: ABdhPJxxWzvZz3h/Yv2EwjXQLas1MpS0OzqRFLwlaLnSMX4HFbqcxZ/URSWiUaKVHcB7jn0zy695hx9kIPA0AXTO460=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr7304224pjb.101.1591290315538;
 Thu, 04 Jun 2020 10:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200604145635.21565-1-elver@google.com> <20200604145635.21565-2-elver@google.com>
In-Reply-To: <20200604145635.21565-2-elver@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Jun 2020 10:05:04 -0700
Message-ID: <CAKwvOdnxqzMgs_CNd5xQgXBOt5GmirfCjKYk7d+cxEBEeKgLrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kcov: Pass -fno-stack-protector with Clang
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 7:56 AM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> For Clang, correctly pass -fno-stack-protector via a separate cc-option,
> as -fno-conserve-stack does not exist with Clang.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index ce8716a04d0e..82153c47d2a6 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -35,7 +35,7 @@ KCOV_INSTRUMENT_stacktrace.o := n
>  KCOV_INSTRUMENT_kcov.o := n
>  KASAN_SANITIZE_kcov.o := n
>  KCSAN_SANITIZE_kcov.o := n
> -CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> +CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) $(call cc-option, -fno-stack-protector)

All supported compiler versions understand -fno-stack-protector.
Please unwrap it from cc-option.  That's one less compiler invocation
at build time.

>
>  # cond_syscall is currently not LTO compatible
>  CFLAGS_sys_ni.o = $(DISABLE_LTO)
> --
-- 
Thanks,
~Nick Desaulniers
