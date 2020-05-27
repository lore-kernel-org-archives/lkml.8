Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA91C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0562020835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXTIpopG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391739AbgE0Rzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387653AbgE0Rzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:55:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A1C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:55:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y11so2123335plt.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJBYNC82NEK7x8dg+i0heBurZRdVbjA3vrgBU6V12M4=;
        b=aXTIpopGmyddAjXhIqoKG+WhFjn8oDlcxZJA54zQq7ysZKo1Efm/lBVPNknrDfpFbE
         tdjxJvEcB7VtuSIuFr8lrwXjv3t+M42UgIb7qKO3AP5eSqzEFAl3mKK65x+LRU3+5cFB
         owtzO27omqQlHzQ93AqPLuiCYgqSVNpn6nsRVY2v+TrLVyAOeKg8DgMIWntL14c+svfu
         42XE/24+FRgxOGUmfzcc20FRcrKrKz4Z9CGOcL4bfZTT2/z/sKipItoUpWwcOem0ItpY
         kWfVuJHCPFkkZY21ascjp5VhGk9iTN0AFdap29/F54VByjmzHWgiuhY7q5j1HkOdsy+p
         FJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJBYNC82NEK7x8dg+i0heBurZRdVbjA3vrgBU6V12M4=;
        b=Iaf4uK5rIqd/isldslS+MqkxtCcLzssS6B78cferfOoRO3Go7swG2Xsq7lwcQTgpPm
         fU0WcNU0KNzLFEib9iycJpt5JxcqrwBdkaFuvGgTrQA8OkuXYdmeWq1FH2NvIpxpUGru
         frP+El47MnpwM4Upvu+XgEcw1AjA7bbM/FNBtRjzMuBuJfxEnkBWQlVaUHm0VQEdtSVG
         8wect2Nvw3N3y6XS2TXy4aTIEGev3l/Gk5Tf2Qc8if+d0ekwW2ubf+2o/GS2CSNvD6aL
         dm5aLtV1Mo8LZ1+V0YP0qSnzE38GvSBC6ej1w6DjP5n4vrwFcUp9W2WESSiKcKrPo/Rm
         4Gkw==
X-Gm-Message-State: AOAM533QBz/kjDK2dnJJud7nS2wJmdkm0wOl8Rt05dlIrfKV4rjTon0+
        WeHjM/5T5FM/r4erfUrfMNwlGxHnQhvS9YlR7XNj4A==
X-Google-Smtp-Source: ABdhPJyJQQ2c1D01xZIN8zVnubpyY/DMXiTEzIKKdFF28gU5xSU/7XCGzI6d/c9CFiYJSE0m6MbG1hDAZRiVQq6XR6U=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr6497081pjb.101.1590602135592;
 Wed, 27 May 2020 10:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200526173117.155339-1-ndesaulniers@google.com> <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com>
In-Reply-To: <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 May 2020 10:55:24 -0700
Message-ID: <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-05-26 18:31, Nick Desaulniers wrote:
> > Custom toolchains that modify the default target to -mthumb cannot
> > compile the arm64 compat vdso32, as
> > arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > contains assembly that's invalid in -mthumb.  Force the use of -marm,
> > always.
>
> FWIW, this seems suspicious - the only assembly instructions I see there
> are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the
> -march=armv7a baseline that we set.
>
> On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and
> built a Thumb VDSO quite happily with Ubuntu 19.04's
> gcc-arm-linux-gnueabihf. What was the actual failure you saw?

From the link in the commit message: `write to reserved register 'R7'`
https://godbolt.org/z/zwr7iZ
IIUC r7 is reserved for the frame pointer in THUMB?

What is the implicit default of your gcc-arm-linux-gnueabihf at -O2?
-mthumb, or -marm?
-- 
Thanks,
~Nick Desaulniers
