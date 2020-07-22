Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3606205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5CLDhMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbgGVMu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:50:28 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 05:50:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so1800146qka.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+el/4IjxY5c/A2Xkjehcvj/Zw3lDkjmnm4fPzj7FEY=;
        b=K5CLDhMO8VOhCWsQmJTWzgBr8pNoz9/g9XoMr2GBxhc4faqvibRjSC7ijhfd0rj4Or
         EAh4KUB+a8SDhfvg2DstycRIHsTbwwOUwrLyIwBC77KG0mWVNaca++DEe3Do+NQS9tAK
         rJh4ulyrFi3MypW6toTUSRapLAxXFRZVnfbivL42DORirSSCTkq8ztYBSa9mwppHubMx
         uasntbPhG1oeuxsz4lYhUVcTP3gvoH1kWTz4h6ozQDe6asb7eC//LcxUvXVwRSZtxfoA
         BkEWy3oWL114hJC06FQLhFbRuMtBkc1lBfEiihWT1tMOAdE+6JtzE6qLS49NkhBjmJ4t
         oh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+el/4IjxY5c/A2Xkjehcvj/Zw3lDkjmnm4fPzj7FEY=;
        b=Zo+KXBjwaPaWPBfAU7YSvl37/fDtzg288bcDbBKXRp0dyK1jGT1kyNvX64Hi2RtPkw
         HHx85u4MaV33SnTSMo7sXxYGGl7hXpx5OG1FWi5OmapWZfr6/Q3K+2OcfyrDj6cN8mrg
         LE07m9yLwylyLA+5HQZVaaWyyHJjKbUCk4cfhqYtfdoMz+R5m6GcGHdW67+lypp+WxQN
         YHjyYswJILPtiR4IHMTyqqsUAGYBYq5ISbBnZ1vvakmQMM8PSIhQNCscYV2r7QXZmEkn
         E5j3eo9YEwvY7Q0hjGNoh4hZdKS9In1JgKdJN7hzZAO+kJ/OmZP+EnGWczBEVzGxeIZq
         F1eg==
X-Gm-Message-State: AOAM533g023E/X2V61auhpy2u8/phwmYSTwo32Cv4fx1iSTgUQ/tKX1q
        Stgm4mCGxJwOZe8qYPdxghuBb9Jt
X-Google-Smtp-Source: ABdhPJx9HH115E9Zu+xCwlVHyBcBMrv+Tu4lfG2pa9PhRq84EP/wMeHyldwyk6ZxndCS7sLNEg7aqA==
X-Received: by 2002:a37:78c7:: with SMTP id t190mr31591973qkc.464.1595422226258;
        Wed, 22 Jul 2020 05:50:26 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 19sm5138390qke.44.2020.07.22.05.50.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 05:50:25 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id g6so941950ybo.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 05:50:24 -0700 (PDT)
X-Received: by 2002:a25:cc4e:: with SMTP id l75mr50937615ybf.165.1595422224171;
 Wed, 22 Jul 2020 05:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
 <20200721161710.80797-1-paolo.pisati@canonical.com> <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
 <CAMsH0TTQnPGrXci3WvjM+8sdJdxOjR9MnwFvv4DS6=crMCAt4A@mail.gmail.com>
In-Reply-To: <CAMsH0TTQnPGrXci3WvjM+8sdJdxOjR9MnwFvv4DS6=crMCAt4A@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 22 Jul 2020 08:49:47 -0400
X-Gmail-Original-Message-ID: <CA+FuTSc0V4TGMF6KhZVkLfv1=OXXdV+J3ufKuXd0GhrHb2hjbw@mail.gmail.com>
Message-ID: <CA+FuTSc0V4TGMF6KhZVkLfv1=OXXdV+J3ufKuXd0GhrHb2hjbw@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: txtimestamp: fix net ns entry logic
To:     Paolo Pisati <paolo.pisati@canonical.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jian Yang <jianyang@google.com>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 4:37 AM Paolo Pisati <paolo.pisati@canonical.com> wrote:
>
> On Tue, Jul 21, 2020 at 6:26 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Fixes: cda261f421ba ("selftests: add txtimestamp kselftest")
> >
> > Acked-by: Willem de Bruijn <willemb@google.com>
>
> Besides, is it just me or this test fails frequently? I've been
> running it on 5.4.x, 5.7.x and 5.8-rcX and it often fails:
>
> ...
>     USR: 1595405084 s 947366 us (seq=0, len=0)
>     SND: 1595405084 s 948686 us (seq=9, len=10)  (USR +1319 us)
> ERROR: 6542 us expected between 6000 and 6500
>     ACK: 1595405084 s 953908 us (seq=9, len=10)  (USR +6541 us)
>     USR: 1595405084 s 997979 us (seq=0, len=0)
>     SND: 1595405084 s 999101 us (seq=19, len=10)  (USR +1121 us)
>     ACK: 1595405085 s 4438 us (seq=19, len=10)  (USR +6458 us)
>     USR: 1595405085 s 49317 us (seq=0, len=0)
>     SND: 1595405085 s 50680 us (seq=29, len=10)  (USR +1363 us)
> ERROR: 6661 us expected between 6000 and 6500
>     ACK: 1595405085 s 55978 us (seq=29, len=10)  (USR +6661 us)
>     USR: 1595405085 s 101049 us (seq=0, len=0)
>     SND: 1595405085 s 102342 us (seq=39, len=10)  (USR +1293 us)
> ERROR: 6578 us expected between 6000 and 6500
>     ACK: 1595405085 s 107627 us (seq=39, len=10)  (USR +6577 us)
>     USR-SND: count=4, avg=1274 us, min=1121 us, max=1363 us
>     USR-ACK: count=4, avg=6559 us, min=6458 us, max=6661 us
>
>
> In particular, "run_test_v4v6 ${args}       # tcp" is the most
> susceptible to failures (though i've seen the udp variant fail too).

Not for me. The interval bounds have been set as is based on previous
experience.

Are you running it inside a VM? Especially qemu without kvm
acceleration could increase jitter.

The reports are not far outside the bounds. They can be extended a bit
if that considerably reduces flakiness.
