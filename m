Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A172C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3588820738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rajZp/2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFCOGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:06:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A150FC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 07:06:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c17so2860371lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCMwwfFVZYEgkxVHE4dr/ePj/4wKMJeH+gSl8PNTdQ8=;
        b=rajZp/2FMkFBLZKKhWrLhHNA0z3IMa4+LHyq+6HtrwYdZa7bMZs89B0ydUprvhVTMW
         KEKQshm/OMlJQdZQsaMjBesgJ8nfpLso6BaChvnWRxA/SLNbIVRw8WOUSXqqNgNN6fKl
         gwcT3gV9vLPw90c+ndl5XydNRYAJuU2PCJfTUmAj9lgqfMscLp0tU3sEQbGkemQgcN2u
         meK6uON74NY4cB3xIBWzWD8r7iS8hBriNISR0XB6/1u78kfp6OlgqbZlg8TDY0txReZg
         CmZbSl7+DSxgiz9BaTIYrKGJMqFl3vsWV62y3AOk9WZPxb67rqJ5yxZMVx9IGFhAadXZ
         36yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCMwwfFVZYEgkxVHE4dr/ePj/4wKMJeH+gSl8PNTdQ8=;
        b=W7eFM4vEHEy2lGxXpCoqkGZtz2c0wU0OJswYD3i3+jgdRVyieEW3VuUkQQD8n8fpsz
         kVg/oTlQp68tyB0HWFgFlTaVyxpR8qB/dt/mW0Tj+YRCgCUiBnqQCCNrmc2WJmaPuAme
         iNPyneuECfoWI4VTQnPd3z22EpN3B5eZPcN6nnxgA4u8Mueoqe/7TTAwDae2o5j+xOpe
         4a8pxgSrrD74AAgBcZ1LADtZ+T2x/VmKs2w2nLB4eeoMYttpZoUWMWEyxTzOmzV0vo8a
         zxcWgDL1nP0Ia80gI2UGprNpa3Ge3t/xMYkr3uVI/fVvylIXjcBeapXs+ka/pzbOZ7Jn
         XgBA==
X-Gm-Message-State: AOAM53249LUmluM8rUbPacx9z7viYFfm7R40S1pAiGWsaDlNDtkWmHWt
        lOKd35xSDkuFM4hJHBBovU2k2tQx3en/0/T8vE8=
X-Google-Smtp-Source: ABdhPJxkNsshI1Wyne7bYH2cEMfBvSBO8Nsf/gU0fZJn/CX4xVlDlCZOi/h129nksJLvuygXdlNRPfsvgpTqAaI02/Q=
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr2275345ljo.29.1591193195076;
 Wed, 03 Jun 2020 07:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <20200602184409.22142-2-elver@google.com>
 <CAKwvOdkXVcZa5UwnoZqX7_FytabYn2ZRi=zQy_DyzduVmyQNMA@mail.gmail.com>
In-Reply-To: <CAKwvOdkXVcZa5UwnoZqX7_FytabYn2ZRi=zQy_DyzduVmyQNMA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Jun 2020 16:06:23 +0200
Message-ID: <CANiq72=iNHeLc3aqt0NrykucHsTPwmBfnsyaay3VYnEhV9T5ag@mail.gmail.com>
Subject: Re: [PATCH -tip 2/2] compiler_types.h: Add __no_sanitize_{address,undefined}
 to noinstr
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 8:49 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Currently most of our compiler attribute detection is done in
> include/linux/compiler_attributes.h; I think this should be handled
> there. +Miguel Ojeda

Thanks a lot for the CC Nick! Marco is right, since this attribute is
different per-compiler, we don't want them in `compiler_attributes.h`
(for the moment -- we'll see if they end up with the same
syntax/behavior in the future).

Acked-by:  Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
