Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C3FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D151D22BEF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7YTfmBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgGUIJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgGUIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:09:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680AAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:09:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so20453461iox.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5uXIl0XLm92YFeb9hC7/nZPQwctVwAjVznJvDpfY4JA=;
        b=Z7YTfmBRYzgiLjTyCve9aAjphgcb0+ObYh3oHepQRhMwZyFB++g2mWAGL0JDeTp8aD
         InojmbW9YEjLNF5awNkn+TNBlQWw06mmCbOt9s+LjFM0RNt3fT+hFp2X/I6ylm22xF9J
         25JA8OLozcUeYNPWqpbl3hLX0Em7Pl8QQfMmxFdVad27K9x8NVz3ukH7cpnFy38T7mLd
         5B1eIDSKGHseIeNZ5hKP2Bec38ZEug+8Vg3JwNFtCajpVLXV/7KrqSjLxjsEVIhVgcEM
         2Bmz2G4+KgMTvrvcugQB77fngUBurRfSGIhGROJzuwGf/TxNvvtxvuB7kfdiJUKQMcF0
         C1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5uXIl0XLm92YFeb9hC7/nZPQwctVwAjVznJvDpfY4JA=;
        b=XCUlRxfpQTA3En9rbvDQblkBXkxH45irGZki41RwHbWCXhz52FmnT4iEs5st7KekS5
         SPJz8DYCoAwHrr11pTULh94nBYcb5dDE8R7U0jiXJLafojg3m+IH/fMpwp8PR0It/Oyg
         LbDpu3GSVhXz0fh4VcuubYenn42qhSmctn0Amf62SMC6V0yItLbQGlZi7nSJbX91lO0R
         h3fo5qBwdCOaJ5zDYJz1KQKHxIJ0jE5ZVo6qMNWy/D+7Ji9hUWdtpT6YNhTgOyFdq4Bo
         SfTIWjQ9tg+cUDjg1mTR41b+KAmD8rZarX7KDeulWb4C2AIMRV9HC9KwI2THD0SHMroM
         l+2w==
X-Gm-Message-State: AOAM5317yAF2c+kUDJN3NjZwpYypIAXgYbAop0iUbrUyjDvLnvCJqR+8
        n8du3uCMGn8QJTrjcWIJlfzOkI+XX/xx1iaJiN0=
X-Google-Smtp-Source: ABdhPJwJjDDw1jCoNYRglUU8gaMF9Ud4ZDStHzoQsHFjXUSA/wEcBRRJj9GmbOlYntc0genQn+Hz+OBwFOZTCncaLHU=
X-Received: by 2002:a02:ce9a:: with SMTP id y26mr31164481jaq.121.1595318965508;
 Tue, 21 Jul 2020 01:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 21 Jul 2020 10:09:14 +0200
Message-ID: <CA+icZUUzRM-pwVfAYMn-26cB-2SSvG_0jdh-aWHiuA+hFFFJ+Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] i386 Clang support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:49 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Resend of Brian's v2 with Acks from Peter and Linus collected, as well
> as the final patch (mine) added. The commit of the final patch discusses
> some of the architectural differences between GCC and Clang, and the
> kernels tickling of this difference for i386, which necessitated these
> patches.
>
> Brian Gerst (10):
>   x86/percpu: Introduce size abstraction macros
>   x86/percpu: Clean up percpu_to_op()
>   x86/percpu: Clean up percpu_from_op()
>   x86/percpu: Clean up percpu_add_op()
>   x86/percpu: Remove "e" constraint from XADD
>   x86/percpu: Clean up percpu_add_return_op()
>   x86/percpu: Clean up percpu_xchg_op()
>   x86/percpu: Clean up percpu_cmpxchg_op()
>   x86/percpu: Clean up percpu_stable_op()
>   x86/percpu: Remove unused PER_CPU() macro
>
> Nick Desaulniers (1):
>   x86: support i386 with Clang
>
>  arch/x86/include/asm/percpu.h  | 510 +++++++++++----------------------
>  arch/x86/include/asm/uaccess.h |   4 +-
>  2 files changed, 175 insertions(+), 339 deletions(-)
>
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>

Hi,

I have tested this patchset v3 on top of Linux v5.8-rc6 with a
selfmade llvm-toolchain (snapshot version: v11+git-e05c7e400f3a plus
cherry-picked 8b354cc8db41).

This happened out of interest if this is in good shape together with
my Debian AMD64 system.
I checked my build-log and dmesg-output and it looks good.

Feel free to add my...

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Thanks.

Regards,
- Sedat -
