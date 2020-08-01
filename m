Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 03:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3530207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 03:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGHeaopy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgHADKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 23:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgHADKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 23:10:46 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CACC061757
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 20:10:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s15so10626856qvv.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnbKMRa0zAhH2ZLCHxKJeQcqF5KDy+gopDBFNWf9shA=;
        b=YGHeaopyWpWDLXKrlCgqbR5mbkeut5pnAELw0FzoWdN7xZragxD0MZNk/+QvrNZ/c2
         6pzKYfC81dsQxIR8S/lFrE77vLfUW0dKl25JEHThgUCdcQR0za56xEcQI0+0Shbso2kd
         m1i1jYtdV0f4DH7ui189AN9Ei4Te1mbZsRbB2rCpdeUqmtiyfs1W74JpyqpN2rngFtDD
         34dk9dHkFHnq12FnA/gyutfxFVmkXTcL3ze3i1WOi/a6kStFBq/VeqBf98aHNMbEylnJ
         fPsazjefJDs+xSrki4s9ge4N2hZm7GZyUUzKq2IbzXtQZ7Xua2l4x7yjgv3VKCgUOllC
         r9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnbKMRa0zAhH2ZLCHxKJeQcqF5KDy+gopDBFNWf9shA=;
        b=QTYyA7SW+ldCxy3d1q8eE3oE7srUtH8dJQ5OFOeXEb5sRV+DvLi/+BKDe8eO5U2MPk
         erGrjdZhW0+zfB009IllUZ47HaOwr5pC/SyBDJ2ixt1qkMOZBrs48E+6X28DJZp3jc4A
         r9T++5PxNDHfErmnPFNNKRg1j1obc8tf07TbNpvHXQE/sw2uN4S9n6zsSG97JeBEK5ox
         vJukbgoGTakfkJKFr8lThQ1ualb8Ekbb/gdr9vPO+7FJawZKSd3QJP5MyrrY604zidFf
         d6p5qASiajWu421TNp6AnKyOyBFoPYz2CjE2yKnxN+Rx5mrYVgEqJ1uTLzg7vEHJq2MC
         B8Bw==
X-Gm-Message-State: AOAM531uKWNgk3m3OQRXP/khBKm41DPGzXass+81oRnGmgBHDNNzkahM
        4cuGlne3Nwuknohtpx6/sqjvLBDhptQA+QH/cpSTqA==
X-Google-Smtp-Source: ABdhPJxxv74V44su6AibvjiFHIXbBoiSD84UvuRcz1CLauN/EnkSZgm5Vd733BgYyNWL+ARVFmG16C2R+BZK65sTGKg=
X-Received: by 2002:a0c:fdc5:: with SMTP id g5mr6855641qvs.189.1596251444129;
 Fri, 31 Jul 2020 20:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200731211909.33b550ec@canb.auug.org.au> <4c6abcd0-e51b-0cf3-92de-5538c366e685@infradead.org>
 <20200801103507.03ae069b@canb.auug.org.au> <97853126-c3fb-fced-547f-6dd7d5c89ca9@infradead.org>
In-Reply-To: <97853126-c3fb-fced-547f-6dd7d5c89ca9@infradead.org>
From:   Brian Vazquez <brianvv@google.com>
Date:   Fri, 31 Jul 2020 20:10:32 -0700
Message-ID: <CAMzD94QypaHC_qswvNxgjM8TtXmGDkUJthWwHtf++iEThhCUjw@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 31 (net/decnet/ & FIB_RULES)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh I completely missed CONFIG_IP_MULTIPLE_TABLES too, I sent the new
patch. This time I believe I cover all the cases. PTAL.

Thanks,
Brian

On Fri, Jul 31, 2020 at 5:50 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/31/20 5:35 PM, Stephen Rothwell wrote:
> > Hi Randy,
> >
> > On Fri, 31 Jul 2020 08:53:09 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> on i386:
> >>
> >> ld: net/core/fib_rules.o: in function `fib_rules_lookup':
> >> fib_rules.c:(.text+0x16b8): undefined reference to `fib4_rule_match'
> >> ld: fib_rules.c:(.text+0x16bf): undefined reference to `fib4_rule_match'
> >> ld: fib_rules.c:(.text+0x170d): undefined reference to `fib4_rule_action'
> >> ld: fib_rules.c:(.text+0x171e): undefined reference to `fib4_rule_action'
> >> ld: fib_rules.c:(.text+0x1751): undefined reference to `fib4_rule_suppress'
> >> ld: fib_rules.c:(.text+0x175d): undefined reference to `fib4_rule_suppress'
> >>
> >> CONFIG_DECNET=y
> >> CONFIG_DECNET_ROUTER=y
> >>
> >> DECNET_ROUTER selects FIB_RULES.
> >
> > I assume that CONFIG_IP_MULTIPLE_TABLES was not set for that build?
>
> Correct.
>
> > Caused by commit
> >
> >   b9aaec8f0be5 ("fib: use indirect call wrappers in the most common fib_rules_ops")
> >
> > from the net-next tree.
>
> thanks.
>
> --
> ~Randy
>
