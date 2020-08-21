Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0488F20720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598034240;
	bh=nm0r0pbpxpRJlCr3CC7US1gIBXxav1AVjK0LW5D9Tl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jO2xrezd2v/JqB9gyKIG/wb4mK9gR5LQJnGaFEpFl3vyc/HM/NV2HiIhINkDScYmu
	 dfAE7irWayovCuumGBlfUbXd9Mge0Vpivtu+JGfWEwNXxXhfUm5lAV4HPW17O98zgH
	 msUjH7Oe2gt+uN2m9cpBruGgOOlUaVQxyIwABFjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHUSX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHUSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:23:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD708C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:23:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so2887724ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVM0nc5//lK1v8wxZ87XZqkf3LFcyTaix5QpBjQniwc=;
        b=MbyUwYZQh6bG3SmDnG7jthrAn7nv2nYdSg47RogmQ2pe5tOsy937deWQCL4eR1nwVQ
         mAVZLGkYereQlthbnwcftr/bl76j4K8MvSUrrPBfJRjTl+GOZM6lqmXlREHoDsF6aN+z
         4bGtHdAQ3oyu3EN2Nb8pGKFZOCaDXpXo0a7Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVM0nc5//lK1v8wxZ87XZqkf3LFcyTaix5QpBjQniwc=;
        b=ikSwNQDL3rYDQhaH85TVfIu0QiW0A4f1j6y/Uq64sD7nzE/4C02piOA9mwIwV9HBwO
         saNw/YOlOWe4XTbAoTJ/LHUXvYog1HdzU+8sxhGZslfKuxqHoQmUG74neNY65ljWWXtw
         VFlHbS/OLLMhV0Qt2J/e4elAo/sTDLcjj9oeEbnUu2Mn+nKzanxiSdag3gZXlsZn8ykn
         OqQiEr+OOHVDhqmpD3YETFMuX0mcODN2r+7NCrucSxBKFNK/wo7Lla3viKaqWAx+HIpY
         Xo2qAihbQU2j59hQN6v03C91KB6pw0ITUnfDfljeHfruPrstX3JXmvgzHJLUJo+XS3dC
         3ysQ==
X-Gm-Message-State: AOAM533ZL3NS3b4dY6mUdneCG9u1blqi8QqMCEa4gUsPBI9WiutpRe4R
        O0D5bcvI4qIyKQMVSb006ObGyWZIhs2tyQ==
X-Google-Smtp-Source: ABdhPJxDit96n5qHglb9M6PWssY9knLDdVxNC63Hkcc11TBtt3CekhBccIJXxXPaiEDvs+nGb6kJiw==
X-Received: by 2002:a2e:9842:: with SMTP id e2mr2155786ljj.88.1598034229569;
        Fri, 21 Aug 2020 11:23:49 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u5sm523344lfi.91.2020.08.21.11.23.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 11:23:48 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 185so2863652ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:23:47 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr1956690ljh.70.1598034227550;
 Fri, 21 Aug 2020 11:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1> <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1> <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz> <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
 <20200821154756.GC3432@quack2.suse.cz> <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
 <20200821180848.GA11376@xz-x1>
In-Reply-To: <20200821180848.GA11376@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 11:23:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3fY2dch7Ah-MLbJcfU3buoXgJnwc1zWFSjVujSd39GA@mail.gmail.com>
Message-ID: <CAHk-=wj3fY2dch7Ah-MLbJcfU3buoXgJnwc1zWFSjVujSd39GA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:08 AM Peter Xu <peterx@redhat.com> wrote:
>
> IIUC, Jan wanted to point out the fact that KSM didn't increase page count for
> stable pages (reasons are above get_ksm_page()).

Ouch.

> Do we still at least need to check the swap count if PageSwapCache(page)?

No. Because a PageSwapCache() page should be a perfectly normal page
cache thing. It will increment the page count if it's active.

That PageKsm() thing that *doesn't* increment the page could does look
worrisome, but

> So we check page_count() (which covers KSM or normal pages) after we've got the
> page lock, while we keep all the rest.

Why would we keep the rest? I

The actual thing I would really want to get rid of is the page lock,
in fact. We shouldn't need it in this path, and it's the most
expensive part of it all. But that's also why I did the page count
test optimistically unlocked - because if page_count is 1, then we
really shouldn't contend with anything else, so hopefully the
(currently quite expensive) page locking is actually a non-issue once
you get there.

But the PageKsm() page_count() issue I didn't even realize. That worries me.

                Linus
