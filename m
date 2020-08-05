Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14887C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FC82073E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYNRhBUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgHERtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgHERoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:44:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED6AC061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:44:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so12583302plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeVarHB8PyC/4WrdMH1wOnZuquqBZq7uGaYiqaJ/H2s=;
        b=iYNRhBUE6a6QRqZgvap/7b6HfFiE6nn5SF6u9BZ45g4hcY5ly0Tddjzei52onqC+ua
         nPE6GMic/x8EdXYFlIZDbKtcad+icJvGX3GCSblD8YJnipnUimix3w1YUBEqJF7uNKIQ
         SyMZMMX9um2AZK0j+y258RYcKICG+Kr3q7aUuCTm8kL/G7cH+vGSy6AXxstJxKZCKiEA
         Avsvi2T6+glTOJKwv4M3c2hK/bf+NloSXGW66axtsQ6nRrPp0h0BKvQQFuA7UvBsSgCE
         2aXiKHiI/CVmpPlQN/pXwGB34/FyJBOpUQve7SYpYzOxBHlc/Uo6JETHMS2C1CWmXvzg
         9jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeVarHB8PyC/4WrdMH1wOnZuquqBZq7uGaYiqaJ/H2s=;
        b=K4TTn9UcLLyS1BeuWvNS7USiT7S+SjS8DWCZc7ciytTyHvNh8ncwZzaaL4EWwj9GEb
         kk/tw4IJfIN8yQnNr4gHMdvgaOU3IQEH65RZTUYk4madwZgRsYybZHvMNYWepxAUTRgE
         2i9K0x2KnLrOrA1DQCOs1hZJhP2fX7mdbrWwFw7yHnfXvAMnAOZOq7z/Eugy0iq2Vgr1
         xU8V3TiB/sMOVrhZOD2lpOx/t3Q3FrBu8hHU8ufJn1JE/pv4wns+Xi01qb/u7A6DW+m8
         ex+RN6Yo7EHVnr3X8gqfuquCuZXQdIJ39bNZqVosTW/DUGwuCRkMsPp53QDnRLQ456Qt
         +Z5w==
X-Gm-Message-State: AOAM5327Y4P2xPzACh4VTsxweqDZ+2SvmkJ0JDpr5g07Z59fgJotaBNQ
        AVv6VvbS5UYBE/Q/Jp4FnGAenFjPOD5opiXRGkoAlg==
X-Google-Smtp-Source: ABdhPJxYIH4X/KPPSVLO3TPfmhVajNLyAm6evVBVZ4ZWeH0jRb4W3Vq6aFy+xQJKcALm/osgPRjKbK+HjbIGlOk2hTY=
X-Received: by 2002:a17:90a:3ad1:: with SMTP id b75mr4123456pjc.25.1596649482146;
 Wed, 05 Aug 2020 10:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200708230402.1644819-1-ndesaulniers@google.com>
 <CAKwvOdmXtFo8YoNd7pgBnTQEwTZw0nGx-LypDiFKRR_HzZm9aA@mail.gmail.com>
 <CAKwvOdkGmgdh6-4VRUGkd1KRC-PgFcGwP5vKJvO9Oj3cB_Qh6Q@mail.gmail.com>
 <20200720.163458.475401930020484350.davem@davemloft.net> <CAKwvOdmU+Eh0BF+o4yqSBFRXkokLOzvy-Qni27DcXOSKv5KOtQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmU+Eh0BF+o4yqSBFRXkokLOzvy-Qni27DcXOSKv5KOtQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Aug 2020 10:44:30 -0700
Message-ID: <CAKwvOd=YBL_igN-Z1V9bePdt9+GOqkKq-H4Wg8GBZvBsdOHeOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2 net] bitfield.h cleanups
To:     David Miller <davem@davemloft.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, oss-drivers@netronome.com,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 3:37 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jul 20, 2020 at 4:35 PM David Miller <davem@davemloft.net> wrote:
> >
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > Date: Mon, 20 Jul 2020 12:48:38 -0700
> >
> > > Hi David, bumping for review.
> >
> > If it's not active in my networking patchwork you can't just bump your original
> > submission like this.
> >
> > You have to submit your series entirely again.
> >
> > And if it is in patchwork, such "bumping" is %100 unnecessary.  It's
> > in my queue, it is not lost, and I will process it when I have the
> > time.
> >
> > Thank you.
>
> Hi David,
> Sorry, I'm not familiar with your workflow.  By patchwork, are you
> referring to patchwork.ozlabs.org?  If so, I guess filtering on
> Delegate=davem
> (https://patchwork.ozlabs.org/project/netdev/list/?series=&submitter=&state=&q=&archive=&delegate=34)
> is your queue?  I don't see my patches in the above query, but I do
> see my series here:
> https://patchwork.ozlabs.org/project/netdev/list/?series=188486&state=*
> but they're marked "Not Applicable".  What does that mean?

Hi David,
I read through https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html#q-how-often-do-changes-from-these-trees-make-it-to-the-mainline-linus-tree
and noticed http://vger.kernel.org/~davem/net-next.html.  Since the
merge window just opened, it sounds like I'll need to wait 2 weeks for
it to close before resending? Is that correct? Based on:

> IMPORTANT: Do not send new net-next content to netdev during the period during which net-next tree is closed.

Then based on the next section in the doc, it sounds like I was
missing which tree to put the patch in, in the subject? I believe
these patches should target net-next (not net) since they're not
addressing regressions from the most recent cycle.

Do I have all that right?
-- 
Thanks,
~Nick Desaulniers
