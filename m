Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7817C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A878020791
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+MiGLci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgHOV7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgHOVvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:54 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48817C0F26DB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:39:11 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z6so13748318iow.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwnENJtZcTDyRowOll9BqELCaHCpWYH0qCJCKyyi9Wk=;
        b=G+MiGLcif5DCcsQJ7v2ioepIk6jXx5VRMkgMKoSkPKhCM4uqzvts04XWodlwFzeY5P
         NclSMUl/w2hiXLcpbvaHWDJ3TdUG3jGO7uBwVI8lfbydMVUWKiY402fO91FHJi0vSU5c
         WA2Yft+iACB/ch7aP/l2qYtTWJ2pIatVRYrW2gQWzarBzNE9HjmYmrToCQdlCxAITkW6
         G9NIxIJkcTF6oR47dFXvAMZUTbFjzdtm7B/V4cLhQuz3R/HavtviwDymE0n6M1QdLSKc
         PyXrmsGq+f8JQhJ9L4n4f1SLD8PHDuP3Ch66CLzVYWSaHT4Q4r1dhzDLQfH2MovQAowX
         xLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwnENJtZcTDyRowOll9BqELCaHCpWYH0qCJCKyyi9Wk=;
        b=nz9Z9vUyMsUBvbjJS/Y7jthTFOCXjojdR0z72NNZBzWQoVcrfB0xibIH7jEy9wkCEA
         4DLw6WFTAf369M6POEORVQMR2Xmqef8gu+OJfz2f4xdrriMaX8pP/j77Ejlnllb6sf5U
         8n+jJeVhFb2mRFYGs02jfywhbDL0s18jp1NGF+/wGNLAT5jeCGzjLB4eSPIl/tTuFZUm
         38OHnsjeQdR39GX/UEFXiSCz95ADB7fYbLC48sroAuSUiwZJzUOoKvOPzUDqv+zebOLp
         +rt17izw2s5JtwwWu7XSAqlx8WFrLr6c/CHQ3oqk818VJRNE0gzGqZKYHxg1S7D84ns3
         Mytg==
X-Gm-Message-State: AOAM530WM9Gvfob8//rwB8qDW8H5qANDO2M/LCgJtBLuYGDD8CdyWxC4
        Y/c7q5+sRyxWP9dCenadaX0WV0lipc5cQGvUIvZcvQ==
X-Google-Smtp-Source: ABdhPJzcRPuzpUvOUtSTbfV6H5JUuJ16ZCQDnG3mf/q7oZEvlSW4uCbycbflqCY6ehJZuh/YEjgTFlhz2kN8M+lj1NY=
X-Received: by 2002:a5d:9d8a:: with SMTP id 10mr6650437ion.195.1597513149676;
 Sat, 15 Aug 2020 10:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200814181617.442787-1-edumazet@google.com> <20200815114825.GA2685004@gmail.com>
In-Reply-To: <20200815114825.GA2685004@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 15 Aug 2020 10:38:58 -0700
Message-ID: <CANn89i+YhDW2HRPNvfuHSDtrqGgXstgzTgcOx=A40XwJwbhSmg@mail.gmail.com>
Subject: Re: [PATCH] x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 4:48 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Eric Dumazet <edumazet@google.com> wrote:
>
> > syzbot found its way in 86_fsgsbase_read_task() [1]
> >
> > Fix is to make sure ldt pointer is not NULL.
>
> Thanks for this fix. Linus has picked it up (inclusive the typos to
> the x86_fsgsbase_read_task() function name ;-), it's now upstream
> under:
>
>   8ab49526b53d: ("x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task")
>
> By the fixes tag it looks like this should probably be backported all
> the way back to ~v4.20 or so?

This is absolutely right, sorry about the lack of a stable tag.

Most of my patches usually land into David Miller trees, where the
stable tag is not welcomed.
We use  Fixes: tags to convey the exact information needed for stable backports.

Thanks.
