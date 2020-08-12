Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAD3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6C82080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="V71ytWat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHLStB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgHLStA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:49:00 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D70C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:49:00 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g20so910939uan.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBO/pnEHQ4hT1uxwOQx8Qyul82lB7+FBvNPMRSuDsMc=;
        b=V71ytWati3npYzKkoAcduUnnApyd+6kA1oXsO+L51h8l5zAG2zjTsiM8TDAU9T8sTs
         12IbLK2P+X0JeHDb3kEHzbi/y6DcWUNEjm/eIeKkpki1axcUvEtUeAGaBVyqkpnS8bui
         vLHitqGsJNM5RK6kbYAWp3jyx/DDsgrwHDuBnGItHZ9bKhMuwA0qxOpx7rQry7ZrBjRh
         JRmVNx7QjndxRZqMV6gaJSmxsgoSAkmqXl2vzD6fm/+tjtKIg7YV+xYVUt2spuNnBP+f
         g4wSslut9AoBDqRRL5rLPa7IDj1+BI6jvQpEpmT64LCehqltfCnupGlyHETUpA9GEcbC
         hs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBO/pnEHQ4hT1uxwOQx8Qyul82lB7+FBvNPMRSuDsMc=;
        b=OOPyl1SjQzI6vqcXSdE0VsAEpBWYPpSpUb5VTCZgbTxWGBJRvf1I7Igxm+XDcCqWNa
         ojecUsUO39UYwnUq/p9cKB1aRC2+ywU4iEDK99z+3lfINcK+nqNvpS6hWNmIiD9ttqwr
         S+Qb8kS2cvIKd+YhjrHoCxNr2MXSGeHo7LIC1oZK+6zmTxWdp5/gnHzcIF+p6Tfhz9lm
         7OfTY24V8o8eZ1qfqdKg1lkTu9GT2vKklXbI6w077zmRJt6XksEA0LU6vxr1QJgUeSsC
         UNXkPWl6cOF0Jb8dTw+DqnmtYpmt3PaWiINKjMdO7bywimWmUet09RtoUKt5p+PelFdl
         OqCA==
X-Gm-Message-State: AOAM5308LJqG81TFs3a0Q8IlWR3uv2aKdTJvv0qjUOoPZoYluVcdouqq
        FBGfLJk7+AcngPnMHH8X3im5ZunT4q5y2QTZwigiYg==
X-Google-Smtp-Source: ABdhPJx8/1L2kT86GuKDJ6DY5Yy7qaAv9hC3dvZJuMg5pOSFdHegAupzz2DzgAY2y9++wc/8aSxisWLMOpmmMPI5iLY=
X-Received: by 2002:ab0:4d69:: with SMTP id k41mr564373uag.131.1597258139845;
 Wed, 12 Aug 2020 11:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200811000959.2486636-1-posk@google.com> <20200811062733.GP3982@worktop.programming.kicks-ass.net>
 <CAFTs51XK0HLwCCvXCcfE5P7a4ExANPNPw7UvNigwHZ8sZVP+nQ@mail.gmail.com> <1003774683.6088.1597257002027.JavaMail.zimbra@efficios.com>
In-Reply-To: <1003774683.6088.1597257002027.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Wed, 12 Aug 2020 11:48:49 -0700
Message-ID: <CAFTs51XJhKXn7M2U2dZpFRsTrog4juy=UQfbtcdJfOj5TUSbqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 11:30 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:

[...]

> "flags" is there to allow extensibility without requiring to add new
> membarrier commands for every change. Even though it is not used now,
> I don't think re-purposing it is a good idea. What is wrong with just
> adding an additional "cpu" parameter to the system call ?

Can we do that? I thought adding an additional parameter means adding
another syscall (ABI => parameter types/count cannot change?)

> A "flags" parameter is very common for system calls. I don't see why
> we should change its name, especially given it is already exposed and
> documented as "flags" in man pages.
>

[...]

> We basically have the following feature matrix:
>
> - private / global
> - expedited / non-expedited
> - sync-core / non-sync-core
> - rseq-fence / non-rseq-fence
>
> For a total of about 16 combinations in total if we want to support them
> all.
>
> We can continue to add separate commands for new combinations, but if we
> want to allow them to be combined, using flags rather than adding extra
> commands would have the advantage of keeping the number of commands
> manageable.
>
> However, if there is no actual use-case for combining a membarrier sync-core
> and a membarrier rseq-fence, then it limits the number of commands and maybe
> then it's acceptable to add the rseq-fence as a separate membarrier command.
>
> I prefer to have this discussion now rather than once we get to the point of
> having 40 membarrier commands for all possible combinations.

All commands are currently distinct bits, but are treated as separate commands.
One way of doing what you suggest is to allow some commands to be bitwise-ORed.

So, for example, the user could call

membarrier(CMD_PRIVATE_EXPEDITED_SYNC_CORE | CMD_PRIVATE_EXPEDITED_RSEQ, cpu_id)

Is this what you have in mind?

[...]

Thanks,
Peter
