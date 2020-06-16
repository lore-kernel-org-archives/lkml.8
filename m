Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E5DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9571320B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuBVeUQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgFPMQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:16:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC259C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:16:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d128so2834981wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FXzi8SFvevnxFXfw0hJtEay1p87T2KpcQAaG7LkSaI=;
        b=RuBVeUQmbQmtjK3dkr1lqFQXpKTKQP6QDtJ8ytHnKx1PvweHuSw6sYSJZYakkmJssF
         xNWVKc334A2uNvQFf2uG7y7joLwTJxQCkYTufkU/TCLEOqoqJmEsCoEkmtN9qhSMu8Ja
         iSHYJQh7IY/cCxeOmFOosMUnX9oHQWATRWStPO2c+pcnhWxsyQo4HWn6I1EQ9l58meYN
         sxllk1MWnN06wdP3K6mWcPe19RN4C4BEKcdaEzS2GM4rVT2VM7mdrqjV023M/hTE+4fo
         ZWqehIWY3teUloSU8KP0JiT1zSLdyZiWH+9EyR+2Tx+9KqHOWJBIMYDjDnOGmlRkDrm2
         o6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FXzi8SFvevnxFXfw0hJtEay1p87T2KpcQAaG7LkSaI=;
        b=mJE4Ph/BCHAgPstX+VFdoTS/AzssAwd6m7IO/iejeoctgXpKWMoshJ+TdX9lBD8B2k
         uwueF82EVKqu950Dg5woJ3tncayiUgvIvoeDmQtGZZBYJoJGH2dcisG4ScerBzZeiNyC
         clFQa/rGjTlJRTquScpmS+MTH2nzQZ3VwhaG9QWa4JUnyIKBmtHua2+JXkLf0yhcCOBq
         vTFkk6jj1n5TpvwzBhUmEXZ8P6M8+wnH3fG5Q3pdLYZ095uxt2A2zxC9Q57D2xqJnndb
         aZmITTp4Hqto6jmmnWmwxpXUmLZlXCIc/1i20/hq6nRAE29jil0xRcWHRp3lKhW6LOXt
         s3WA==
X-Gm-Message-State: AOAM533QMHsjtldr9O0AV/qqBitZs/3x8oxbZO5oJuONH2MXlAUZW+dR
        JK7ymji5a1KBxfgXnMZX4a8A0MwhXPjKWXhE8b03oA==
X-Google-Smtp-Source: ABdhPJyVxSHKGbZJb+38QCkBEE45KEPKOUb72U66xerBV+0ooheNNJaqFnXHkn23kdt+q+ZTyEywxD1hf1Ia+zz8daE=
X-Received: by 2002:a1c:3286:: with SMTP id y128mr2802214wmy.29.1592309764320;
 Tue, 16 Jun 2020 05:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200616083435.223038-1-glider@google.com> <20200616100309.GA2614426@kroah.com>
In-Reply-To: <20200616100309.GA2614426@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 16 Jun 2020 14:15:52 +0200
Message-ID: <CAG_fn=VYN6ynu2bnW96-p-QRi77NstHC6DXS+AN0r0bm5K2j7w@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +KBUILD_CFLAGS        += -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> > +endif
>
> Gotta love the name...

This is basically the reason why we've been hesitating to add it to
the kernel from the very beginning.

> Anyway, if this is enabled, and clang changes the flag or drops it, does
> the build suddenly break?

My original intention (see v1 of this patch) was to make
zero-initialization a secondary option of INIT_STACK_ALL, so that
nothing changes for the existing users.
But I agree with Kees that these options should be made distinct, as
people may want to use them for different purposes (think debug vs.
release builds).

We could make INIT_STACK_ALL_ZERO fall back to INIT_STACK_ALL_PATTERN
if the compiler flag goes away - does this make sense?

> And does gcc have something like this as well, or does that have to come
> in a compiler plugin?

Kees mentioned someone's plans to implement that in GCC, but I don't
think they have done it already.
