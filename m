Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68E92072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbnlAAnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgEUNfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgEUNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:35:12 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83514C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:35:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id z9so1359179oid.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zx1Zxii7kuqEBAAZh/SfralQu7+w6Yj6Omise5zlDew=;
        b=lbnlAAnrNskZGuMGkYZHY1vCSCCxjBA8d4U/fxCr2/qMDE7ZCGaZBoEiO7auDLiiX0
         2LAsqH5gfhniNU8lz509hK48CxoFbEyJ6eNIOzCR/QiMBXpRcIK3n0BZrxlYh+P26Uh9
         sbMJCqF4FyIPwwF7KtlBv7pmdrcjLlwTNEoX7AsfIsXhoG1bKDz9rsYs14vDmHweS2yI
         0xaICp3BR1Mu1WBso8nR7PREmtBpiAtl1Nd19szCTX1bgzpfvIPV1FFYReT1GpaIdN8D
         6HjuGSj6pyy3Z6/eyGfxkuIJ7hsbfFSTSrT/UqcOQE0a9G9lBUitLQ/aZ5wFQ5fQchpz
         TRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zx1Zxii7kuqEBAAZh/SfralQu7+w6Yj6Omise5zlDew=;
        b=oMFRVKU2GbY4nEGOajwQRMmbNrLHnxy8MfyCX0FsEmjwRuhaMdsegYNTDqpGkA7fNc
         bsIkn7PDpnlVwv/YgboSdCfc3+9k2oVS5cFOdjX7ms6SRZzRZOvIpuw0os+eHLXFYGxU
         YT/6w8AQekP1q9baLVsoqgk5DELrMaP7hXL1P5AnU37GrHe2V6mqqtOnuDHb8jLVwGRU
         8XjKaNl38jk9hBiN3cQa5SgYcJgvFzKVOOtojdqrkXMWih+uKSQ/INopG0zgO7CWxz45
         V4I6Vj4eTdrBXiydvbm3Z+S0zSicSkGK84IacommjSkiOtI27LygcxJqKGuLgR5ja2Ew
         lIhA==
X-Gm-Message-State: AOAM533YTPu5RSuhc0GaDZINE7dNqBuSsJbb1Ix3bIvCR13IQ1PxUTAm
        vPSNx1bYpLTfRgfKPGZ4w59yTwlHD9w2s1hPUuWLUA==
X-Google-Smtp-Source: ABdhPJyV+H2XuIpwPdXawrK7zAk9LhoUEYkcBzQ259T+WBC+TDCcYdf3viJw1KjepVRQtrjw2s7Kab7xpIPrx1WW3EM=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr6839565oih.70.1590068111768;
 Thu, 21 May 2020 06:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200521110854.114437-1-elver@google.com> <20200521110854.114437-8-elver@google.com>
 <20200521133322.GC6608@willie-the-truck>
In-Reply-To: <20200521133322.GC6608@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 15:35:00 +0200
Message-ID: <CANpmjNNgQkw77uATD0jWezXheX0ZtKK9GcgWd_EQu1_u-m3PoA@mail.gmail.com>
Subject: Re: [PATCH -tip v2 07/11] kcsan: Update Documentation to change
 supported compilers
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

On Thu, 21 May 2020 at 15:33, Will Deacon <will@kernel.org> wrote:
>
> On Thu, May 21, 2020 at 01:08:50PM +0200, Marco Elver wrote:
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  Documentation/dev-tools/kcsan.rst | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
>
> -ENOCOMMITMSG

Oops. Ok, then there will be a v3.

> Will
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200521133322.GC6608%40willie-the-truck.
