Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E080C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1349420758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589913434;
	bh=FdPJOTZLNjgjOFedjQw3gFktAuvuGHXZP48dtHCd7Mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r/Xex3MF8xLZSIjzxyLlAdzk6hRBCy+ui10xImShBIoT3LGyJSpYeNpA2R5a9IKcI
	 7+OehCT5sCon9lS1UBBrn4ieS+0vPFMAR5pTPYTCeEXuq2PtDE6HL99mTtuTV1XHPD
	 0wHpBVQa1nf7vGEAXoSvBa4zU4mN1u4tmbyl3+fA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgESShN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgESShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:37:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94593C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:37:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so804563ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPh1VSVckJPtJQsHU0gjkG9zuV3GFu1LedTcF51aAcM=;
        b=VufC5cVt/QsRYDbFjUrTgLBSJIGVamaZ6TqP+B2P/JryRaKr9pcGTQRH1L2ufpBeGo
         +HGpzbuKFZhBCeI0lW8cu8YaTMgO3KUjgMgFZQImD3dgot0BxtvQv4qWs9UBJf82/Sxm
         cU7py1ZSjkCtf3GiTwmwvvlOWXszXjd+6c4s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPh1VSVckJPtJQsHU0gjkG9zuV3GFu1LedTcF51aAcM=;
        b=TjDXnxGF5jwHeb4tnO+v5V/JLuiGKyJXLhCjq40WybYgOkC6Zi7gfArVm9oZRNVtP+
         3bUNJ0mQIlL2w+QAeDPCMe3WYLV9U1IgSfM4AbTspcbj/SImy1NfJjfnTKvceZb529lB
         GoECByc2eMv1yD1bX8XxcCrzc7hVW0fG9tY7LF34QzUx+47WLqx4jG89swtLA+BKx1xk
         jomcjj1Vi+0daJOhzM3gu1vpq6xOgxlqMfJXBSsBzz1eP7cDBipvTVRSC1tkPB/Qpk6u
         SH7bV7gYNHEbhj9uCZdWlDaNl0peHhppsktnYIxfwYxOjjiokDY+unoK/Qff2snL6Rgq
         Bzkw==
X-Gm-Message-State: AOAM531pfvZPHxA0pAzi9fFLkGRxGpuZDaxL55plN3gqHIsQsz/RLXwL
        0vB8lV15OQrOvaNySbrqA6vY0QrRbyU=
X-Google-Smtp-Source: ABdhPJwZGgmmP6LI4ygPOcz340Mf7UaMHQibkxqAZElppntpaj58kODv63YMjRnJBbVB7/yQrBTKvg==
X-Received: by 2002:a05:651c:119a:: with SMTP id w26mr463408ljo.53.1589913429886;
        Tue, 19 May 2020 11:37:09 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id g10sm95403lfc.95.2020.05.19.11.37.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 11:37:08 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l15so466041lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:37:08 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr411854ljp.209.1589913428000;
 Tue, 19 May 2020 11:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200519112657.17098-1-idryomov@gmail.com>
In-Reply-To: <20200519112657.17098-1-idryomov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 11:36:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9+qm_msiKsk32vaUMon6UQEE0-TydPF_-D6xNPjbOfg@mail.gmail.com>
Message-ID: <CAHk-=wi9+qm_msiKsk32vaUMon6UQEE0-TydPF_-D6xNPjbOfg@mail.gmail.com>
Subject: Re: [PATCH v3] vsprintf: don't obfuscate NULL and error pointers
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 4:27 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> This just came up again, please consider sending this to Linus
> for 5.7.

I just took it directly, since I like it and it looks trivial.

               Linus
