Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618B8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3024C206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+B+8+34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgFOKHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:07:47 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC38AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:07:47 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s13so12647581otd.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4asCK8iE1tsgTlzvkWs2MDPLf8Kbt2TTtKtjoZO77s=;
        b=Q+B+8+34AP6GG64cG7pD+ZooDFjglnOWEMyGmBu6d/WyuStbMDK69jM8VIDC4ZY+AY
         HprBsm1wpae9WEQ329MxKUxf/vN8glbDfmt8CmA5lx227S43A8gUknfVCo3G7ZkW5h4f
         qojHS669JNIzGyuvDwjtKr/egVeLEqodPGCyScLPMdOPn2w7tLVBwmtFEYS55fjV/Kiw
         latNeire8XAhb+BjRKoSh0uQq56ae/s0/gv1Q/qg7P0SF5SeiuOYPSTghfTG30mjD5NG
         FhQulbHEmvHZilZvob+9KvsRCi6g+AIEoLCVAckM73QeiA96v8smRZu49tN082yBKJy2
         gwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4asCK8iE1tsgTlzvkWs2MDPLf8Kbt2TTtKtjoZO77s=;
        b=a22HSNCZU2pBlwr3rFku0ajN07EkwnxyiQ73QmYcuxalNrZGNFWdy0F8Bd2KA5iuBe
         ioiEjbvcLo8u/G9sra8xrcH9hd5ZWDWkvLY0cLnBNv9bcTUtPjfBdEiQPPXmQD1zm797
         gntj/ol9UaaoaIBSkD2QJVeRXzyO6JOpKcYYBD5VxFg7zkTQdDLsVeuo5DPt1VcmlRhb
         +mbzszeGYQ9W7JFFwSoZ8e5W+FSVeHakkun08asvoGe941ahVv2erbZ+rVT2BaqVdhDd
         Ri7sWo/aB/eZUwEg/5y5kIlMf4+Hwq8o4IS26S8FHUpjcCpGB6dPxrFksKcsND1bouK7
         /UnQ==
X-Gm-Message-State: AOAM530bUmFLbqTSUxD4hmnPFFzMhO5EtCdz/eERhXM+k5Ll72kfdfOo
        AaG8GIR5R0lFtCljdtr5vNiyVemjAYNnb0mnQJRpkA==
X-Google-Smtp-Source: ABdhPJxnnMVq9b+/SKLh+a5VSaUZzfgykQsDMLMqGhBxyfhykzdh1a2IVmlaGsdSNqNJ7/eb0kRTRyDS1lQNVrJfnWk=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr22086900oth.233.1592215665986;
 Mon, 15 Jun 2020 03:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200604102241.466509982@infradead.org> <CANpmjNPEXdGV-ZRYrVieJJsA01QATH+1vUixirocwKGDMsuEWQ@mail.gmail.com>
In-Reply-To: <CANpmjNPEXdGV-ZRYrVieJJsA01QATH+1vUixirocwKGDMsuEWQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 15 Jun 2020 12:07:34 +0200
Message-ID: <CANpmjNP2ayM6Oehw08yFM4+5xTjXWcCT7P3u7FL=cCMxFJNkXw@mail.gmail.com>
Subject: Re: [PATCH 0/8] x86/entry: KCSAN/KASAN/UBSAN vs noinstr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 13:01, Marco Elver <elver@google.com> wrote:
>
> On Thu, 4 Jun 2020 at 12:25, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hai,
> >
> > Here's the remaining few patches to make KCSAN/KASAN and UBSAN work with noinstr.
>
> Thanks for assembling the series!
>
> For where it's missing (1,2,3 and last one):
>
> Acked-by: Marco Elver <elver@google.com>

Where was this series supposed to go? I can't find it on any tree yet.

How urgent is this? Boot-test seems fine without this, but likely
doesn't hit the corner cases. Syzbot will likely find them, and if we
noticeably end up breaking various sanitizers without this, I'd
consider this urgent.

Thanks,
-- Marco
