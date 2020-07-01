Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F17BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF882073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPVzRSe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgGACa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGACa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:30:56 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB43C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 19:30:56 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id y17so9076024ybm.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 19:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orh850FlYi6ymGIsnPeKmpVTbgMuFgP3BsMdOWApeO8=;
        b=WPVzRSe29IxXSIUGCzVBbN1Fvdz+LCN0ILXxYv+auvExF/M2kQMNV2v5XMT2C5IS8A
         HArtPGBdd6KV5ibhE7QbBN6ClyFqAikrJrmgQexb3syQM2wCppMa+qo/cUlxyYyjsSJW
         a8cwjoUSABWMyYyDZwGzBFbH14tGo+oBrSMqBaIboOuCxNxavlD9uB8iOXHBVyh03xWU
         tTcZJybPRgya2NcY6jFXx7G7AC7XsI9gv/oDkVk4vtpgeFoIY9YB1HSiIJc1OizOeYUJ
         uzSdhPyLyjlO/DEKUV4+sEKFOEaJt4mRuZbDN4lPrmc2/2gTxIyFEqKF3cQNUAaNIq1b
         6bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orh850FlYi6ymGIsnPeKmpVTbgMuFgP3BsMdOWApeO8=;
        b=XrjPe29zQ12Kv/r4yPGP1XGuOhCYj9k1RysfwuhhTRWRo3zjMy1P/W9tACpoQkctAO
         AT/mMyDr99L2ZQzcqVAXrrsKvFm1rCkDmp9A9hexlpef7sFMsZS0qZep3s8cwtrZA09I
         59N8U4Bflp84C8aXgVJzBaiAgyllT8/EeaYQaJ6k2X077nJqeVQr1dujZEx2yhrBRkUM
         wzcbW1y1ScmkPJNpyJtioXOT9VMVSST6e3D7aTeu8VP99jDrx09ZqlNZDG1sTCKVVMSA
         mu1qU5BNnVDeZqloC4nyVqiSS0/MwEuT0BjEYjvbYdYmUUl7Dhy7rsclsyt7DYPDMsJe
         bXuw==
X-Gm-Message-State: AOAM531XMMfW36JSHVLGZ6Ov/UKUX4h7nC1XSVLkBD+AP/RCcdWGIeO/
        4aKrLai3y/upSL3DM99/+IefkFyMcIzbP0pVsR4ZfA==
X-Google-Smtp-Source: ABdhPJwsOFM+bWqFepo8ZmFEToJ3SswQgejDI7L7embhj1VChymRUikpgSLMJsjAySkiB6Ec3Kaa3FE3fFIoe4z4LDo=
X-Received: by 2002:a25:b8c5:: with SMTP id g5mr920040ybm.395.1593570655562;
 Tue, 30 Jun 2020 19:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iLPqtJG0iESCHF+RcOjo95ukan1oSzjkPjoSJgKpO2wSQ@mail.gmail.com>
 <20200701020211.GA6875@gondor.apana.org.au> <CANn89iKP-evuLxeLo6p_98T+FuJ-J5YaMTRG230nqj3R=43tVA@mail.gmail.com>
 <20200701022241.GA7167@gondor.apana.org.au>
In-Reply-To: <20200701022241.GA7167@gondor.apana.org.au>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 Jun 2020 19:30:43 -0700
Message-ID: <CANn89iLKZQAtpejcLHmOu3dsrGf5eyFfHc8JqoMNYisRPWQ8kQ@mail.gmail.com>
Subject: Re: [regression] TCP_MD5SIG on established sockets
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Jonathan Rajotte-Julien <joraj@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 7:23 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Jun 30, 2020 at 07:17:46PM -0700, Eric Dumazet wrote:
> >
> > The main issue of the prior code was the double read of key->keylen in
> > tcp_md5_hash_key(), not that few bytes could change under us.
> >
> > I used smp_rmb() to ease backports, since old kernels had no
> > READ_ONCE()/WRITE_ONCE(), but ACCESS_ONCE() instead.
>
> If it's the double-read that you're protecting against, you should
> just use barrier() and the comment should say so too.

I made this clear in the changelog, do we want comments all over the places ?
Do not get me wrong, we had this bug for years and suddenly this is a
big deal...

    MD5 keys are read with RCU protection, and tcp_md5_do_add()
    might update in-place a prior key.

    Normally, typical RCU updates would allocate a new piece
    of memory. In this case only key->key and key->keylen might
    be updated, and we do not care if an incoming packet could
    see the old key, the new one, or some intermediate value,
    since changing the key on a live flow is known to be problematic
    anyway.

    We only want to make sure that in the case key->keylen
    is changed, cpus in tcp_md5_hash_key() wont try to use
    uninitialized data, or crash because key->keylen was
    read twice to feed sg_init_one() and ahash_request_set_crypt()
