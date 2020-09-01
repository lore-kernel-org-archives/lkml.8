Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD3A206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtMWvdlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgIARDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgIAPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:20:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9105C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:20:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z25so1627726iol.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ge/+DxJ15Ua6HWzt57ivLu5/J7fl349A6GNKghGBc48=;
        b=AtMWvdlzwwyu1P5XIqLQoKsW/5MrUf0fZZ3rjuA9nIxDGzYk1+hiIsXN17FAzg8KM3
         IkoV7nJ0dd4VtHLUuSD3pkBP6Ig3VZd3FFYyZkK2eKz526VCSz2o5x7wia+06I+0NO60
         3HyYMyseHFimP0lcXYILtCAhyI87wgfqFsOXTnoaXvsFGrHaVgHewDv3+cTBb2dlCOxq
         F3DekR95KANdSEBlSUBS/0H3hzJnnKUVtC3WS7fXipRyFGK5ZBoS0O+Ig2rB/eAIpSvW
         NB336CVUKMPQJRjkvGdZPy2GQ9lcZ0Leme9VBfiKKxgD/mcUzHLM71qlpDoFKJjcE+pw
         MO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ge/+DxJ15Ua6HWzt57ivLu5/J7fl349A6GNKghGBc48=;
        b=eazCOWIDFhHc9gTrtbK8JIC0wBMk4Q3tFdjx/NiKFMLsExr1YqT6NmPeVqnoYKgdHU
         XLD66EEwKJxFHjgS1dWGCmkO9Uln3g9sEGBdjtTw8i4899dD34NvsfdjXmHCHxP8g3gB
         ZyUNAWXBm5thv0q61+Mf4vhGslPU+bPCvKxkNICF3uNF1Z8ARWwzGuYxmX9Op1nSbf7a
         JziONwPSJYIHfLZjoTg+nE7XGL0e8o0VO+lzyBDAvWb6zXHD+JBLM0ve3wpnqZdtPQJ5
         xnXj1imMi5aXp94Iv1W8ZuALSASG4NMvJ3/SOyWBM1GWo8aeDQqRWAzpkenRRfdIMmk8
         7DSA==
X-Gm-Message-State: AOAM530KORXgSI/53R4RAR4+IYiztMkzSd2rKW0Y/kLIyY99zF1eNpe3
        U/fkKGfXVKrm4WJ7L6yAL/M4LyvoEsXjU2H7RsfU+Q==
X-Google-Smtp-Source: ABdhPJx/Q89NgOh0VXJempeQiPr1aHcPIYG1M/1O83JNyWFNS6esLspfeXt9U3yxfbBeUXq8jO2jGHrzluthJVmreM0=
X-Received: by 2002:a02:e47:: with SMTP id 68mr1864149jae.17.1598973605935;
 Tue, 01 Sep 2020 08:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200901064302.849-1-w@1wt.eu> <CA+icZUVvOArpuR=PJBg288pJmLmYxtgZxJOHnjk943e9M22WOQ@mail.gmail.com>
 <20200901145509.GC1059@1wt.eu>
In-Reply-To: <20200901145509.GC1059@1wt.eu>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Sep 2020 17:19:54 +0200
Message-ID: <CANn89iJ87D3NXHk418Qeeuzr1ANp9STqMQtqdA_QyCpXL=24CQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] prandom_u32: make output less predictable
To:     Willy Tarreau <w@1wt.eu>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, George Spelvin <lkml@sdf.org>,
        Amit Klein <aksecurity@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        Marc Plumb <lkml.mplumb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 4:55 PM Willy Tarreau <w@1wt.eu> wrote:
>
> On Tue, Sep 01, 2020 at 04:41:13PM +0200, Sedat Dilek wrote:
> > I have tested with the patchset from [1].
> > ( Later I saw, you dropped "WIP: tcp: reuse incoming skb hash in
> > tcp_conn_request()". )
>
> Yes because it's a bit out of the cope of this series and makes sense
> even without these patches, thus I assume Eric will take care of it
> separately.

Yes, I am still pondering on this one and really there is no hurry.
