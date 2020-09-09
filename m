Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412F0C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F041E2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OL93yWh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgIIRHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbgIIPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:37:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C709C0619C3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 08:13:58 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 185so2677017oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krZf25HoLYNOs+89jtLjxVuIVVFDL/DS0/iONN95wCA=;
        b=OL93yWh7YYd3Kjpp++lmqusu98KBOYAUlFtscMPkxq3j+FlurgE872aMXM+jYrZLfA
         slVo0YeMasFlKvpatP/yG3NYkdN7G9zeOdYYDSr/jO1YA4PDmwsY3l3/g2a+UUUUk0sh
         N/9n/d0axxncRngDQDQ73AzQCMoaR1Qi3RTeH2s7jWwOLkvp7DY3rFzAbiSaUOkyiI0j
         GbFHlK7xl53jSwXJVpwDyLq1COKTawKzlznu/fwxR2F5MYpx+55Ea2pfphDixt40qy/O
         4WUi+T1ptbN4Z8SKmtiSt+QhKD3pGAaSGq2pBDoVmB67cUexujsDH5uHp7kmk03dwp6Y
         27qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krZf25HoLYNOs+89jtLjxVuIVVFDL/DS0/iONN95wCA=;
        b=lVTAgjnXdmfry+FPAUiXnNw0dpyaJSL6BCOeIYYU1TKstQ9bmTfEKA9G/bMrhjnnwI
         5Cb86d1CxTu221jqkzkhnKlakKfTjnjq+krSaWovUbVBdHRb73d/dVP/BnHEXNRQ2H0W
         xJKLfqgMolJjiBZQuBrshhbYRbNFB5OART19AHR34598nAXpKcUV95zRd8ePFGSUo9A/
         ueQOzH/YBEs5WqPkAlbsw8UXCf56weLmLefQB/FDMH5FjgsBCOFontjxJf3/nRx7BdKg
         kinUsWsfV7Ka6UyYlue4cd6nnUsBljc7+cM1Pw7oOTbMwo2JiO0PupltmWYM3otStTPX
         IFyw==
X-Gm-Message-State: AOAM532E6sYPmZqMUzpuGtZ/nH5UpbU2YBY8/z2FAa8/ZRppUfFZ+sXZ
        wtJ8fZoiZi+I6RiQFOwDCH6lshfcTnZezl4wA1Ca8A==
X-Google-Smtp-Source: ABdhPJxUwoCrzBiq+mXsi/+rblK6OvwTU4QXrdeC28cSOlaNtqbrVQKyBMOckNHPSlXH4EYREa5LAoQDUNJklnzlV5o=
X-Received: by 2002:aca:5158:: with SMTP id f85mr992820oib.121.1599664437260;
 Wed, 09 Sep 2020 08:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-4-elver@google.com>
In-Reply-To: <20200907134055.2878499-4-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Sep 2020 17:13:45 +0200
Message-ID: <CANpmjNMRMkFxdGHuyyWEPhMiW-uF4qjiKKRRrd_s13X2P6cv9Q@mail.gmail.com>
Subject: Re: [PATCH RFC 03/10] arm64, kfence: enable KFENCE for ARM64
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm64 maintainers,

On Mon, 7 Sep 2020 at 15:41, Marco Elver <elver@google.com> wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the arm64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>. Currently, the arm64 version does
> not yet use a statically allocated memory pool, at the cost of a pointer
> load for each is_kfence_address().

> For ARM64, we would like to solicit feedback on what the best option is
> to obtain a constant address for __kfence_pool. One option is to declare
> a memory range in the memory layout to be dedicated to KFENCE (like is
> done for KASAN), however, it is unclear if this is the best available
> option. We would like to avoid touching the memory layout.

We can't yet tell what the best option for this might be. So, any
suggestions on how to go about switching to a static pool would be
much appreciated.

Many thanks,
-- Marco
