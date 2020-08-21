Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF93C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C05A207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2mTGHNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgHUI6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgHUI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:58:16 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB2C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:58:15 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id o21so935004oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIVvoIxDscazkjxDxxPv5gvsunWCC5y5O+yvu3GA8zk=;
        b=q2mTGHNbZxMuit35p7qTafE3TeI5U4AIiwPe1TCQ60Bg1PNbHBQqxARTxJFakOXvBL
         EYL6UddvN/5PCURTSIoAebx15zIp/0ZbhZoxJPaEJlBiCR6YJuDEhuTz/pVEhqzHUmV6
         Ajtl9cLGPJLFG+SWjhjUBiHV8nk168vuEKXkilrXxA37Bdi/32/TnZCX8Atkn80dhR44
         Ji7uf9nJ5vTxBXu/whaj64aGyMA6jXeq/1rdeneA1W33lpiCnqvq07WArSTYz+lhbwC9
         U67GIy4wP+RIVPN9WE3SKEUGnaGheHwgAI6PB7EtT2wHLWeW53MoGB4nth+aYtJAjIkh
         TmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIVvoIxDscazkjxDxxPv5gvsunWCC5y5O+yvu3GA8zk=;
        b=pFJP8W3YWNus2XYnJV6EudyCYN53D9eEGI5oUZ7ydojXXzecO4oqo3YLCDN0aSdmev
         h0yELcIL3qdDGJtcoKKMldyxomdWNWBZiF4s9iZtCFVhMCLwew8zX8AMWd+vZykJCvLV
         fOKRrvB/VPWWGClt65fo/ksHbedk4Ze/tb01z3AZpEHoDrvsoVTUh5gSS9Xgo4Bg5V9P
         YAWMj1OQecIC2QbWf8ayb0HKO2rzqwOiZ5GpVAcs0Z06Z30OdxTNmGeSKj9JFCHHl+U+
         QPrQbKhX9Y1NnIIBytmp/8ZvSqcUVmVDAHNx/eCQ86Bke9ILVuf5xczn41KcQt1ZVlF4
         XpfA==
X-Gm-Message-State: AOAM531k/yqt7Lv+Or0aoHZHoWEF2NVvhRqeV1hicLh7v7qV/4hmYts5
        WzTCgdPGiB2e9rbR5dOjQFTQHPWzvxJ7MuVkp2r4xw==
X-Google-Smtp-Source: ABdhPJz9iTT3XBj8WRl+ZOCH4zNT0K/w11yAgDx5v19ejdo/Cy91vQs/Hr3vXSnSxwgC/L4S0ps04S39NWudNp4fubQ=
X-Received: by 2002:aca:d4d5:: with SMTP id l204mr1175616oig.70.1598000294457;
 Fri, 21 Aug 2020 01:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200821063043.1949509-1-elver@google.com>
In-Reply-To: <20200821063043.1949509-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 21 Aug 2020 10:58:02 +0200
Message-ID: <CANpmjNP9R7Ly3YCFD4cy8C0cRuJGqhWfqpqFCJniv4v-07oCHw@mail.gmail.com>
Subject: Re: [PATCH] random32: Use rcuidle variant for tracepoint
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        Netdev <netdev@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 at 08:30, Marco Elver <elver@google.com> wrote:
> With KCSAN enabled, prandom_u32() may be called from any context,
> including idle CPUs.
>
> Therefore, switch to using trace_prandom_u32_rcuidle(), to avoid various
> issues due to recursion and lockdep warnings when KCSAN and tracing is
> enabled.
>
> Fixes: 94c7eb54c4b8 ("random32: add a tracepoint for prandom_u32()")
> Link: https://lkml.kernel.org/r/20200820155923.3d5c4873@oasis.local.home
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  lib/random32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/random32.c b/lib/random32.c
> index 932345323af0..1c5607a411d4 100644
> --- a/lib/random32.c
> +++ b/lib/random32.c
> @@ -83,7 +83,7 @@ u32 prandom_u32(void)
>         u32 res;
>
>         res = prandom_u32_state(state);
> -       trace_prandom_u32(res);
> +       trace_prandom_u32_rcuidle(res);
>         put_cpu_var(net_rand_state);
>

Note that, for KCSAN's use, there is still a small chance this will
mess things up. So, as a short-term fix, I'd appreciate if this patch
will be applied to 5.9, assuming it doesn't mess with the original
usecase.

Longer-term, I think I need to switch KCSAN to use either
prandom_u32_state() or open-code its own prandom function, as the
trace-rcuidle code calls into srcu, which might have other weird
effects if KCSAN instruments that. Still working on the longer-term
fix.

Thanks,
-- Marco
