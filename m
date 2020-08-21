Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEC520724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598012900;
	bh=FyT2qvOgCd1d4RFL2pkzqcNEjG8u0pgvhqcSayfPdZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wDJrdAMAnA56PuYc5ud8iJOmJWjB/3hTFS4ISNO1BJCMiHhk+bbaZpq5q7CvRAizJ
	 7+UZSjMTs4MSHK+ULAlB+oF8YmqO8n4FlO/iBEhxSxADu7Q2S0nvNdTuIlcCOdPfFu
	 S7T7fm5qqUfjvWCeCbmqlDimfvdoKjvkYspMPFHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHUM2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:28:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182F5C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:28:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so1620113ljc.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVEnmevXmWjia/tSlEkYasW33doqxhq1hrrAE4gD2Zs=;
        b=Uslkk0kLQy8rVRDLWSC4ZSu6zvuyMgq+S/0d9jEY3xM3jauyLCUuB1L5uuSRDph/tK
         EI/3nCJ4e1wvBuC6vpeEHOcGT9fwhPy9TNUii0Ts+Qql8fTUZrxacQGLJO6i9xKFZGss
         3ZAdtX/wD7LddOm/Dx5TflS8QpQ9/sGryn/rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVEnmevXmWjia/tSlEkYasW33doqxhq1hrrAE4gD2Zs=;
        b=skDrIGoHrDlvevGPJZRrKrD/6qLOo2cUZATMzvri4oR47NV3ViJb+uH0MpHtV//muQ
         1be404i0XuPhs59eh3Eyyv4hCtcR/1KScucAV47J52786H2Y19jVH1HO1CgoDp7bJk4b
         wuvnXRqsBJI2rr+752dL0a/EVWbreb6yZJ/tgcbXfB3SggdgNrjqvcHEMlnhMRsEQiWv
         LisOfYh3bMqUt27gfG9UZkn0hTQUuo9jrlzq+hFr9vcRpuvBjIzUY0pQnKyxxk6N/pKS
         XXYadU211sObJ/GqsvLKyV/Wwl0uJDB81DxJqpQezcrXCP/id5KV226mxG3YIushfVWr
         fdnQ==
X-Gm-Message-State: AOAM533xagTtDdj0jLtmWyjwwXKlmnUWNkd4S7VOoAgAD7dAZdQNpLGZ
        cPDQIORorYbZT+y/IsFk4E+FmpaMf7II8A==
X-Google-Smtp-Source: ABdhPJzpaww07W3UjRgC8XmFAp0Cr84bWmTAIMv6zy5QM1+AqM044Umf8ENPRSxVvdEbdUWA1b4m/A==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr1338024ljj.396.1598012878960;
        Fri, 21 Aug 2020 05:27:58 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id t22sm362397lfr.12.2020.08.21.05.27.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 05:27:57 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id i19so825476lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:27:57 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr1365004lfc.152.1598012876870;
 Fri, 21 Aug 2020 05:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com> <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1> <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1> <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz>
In-Reply-To: <20200821101333.GA3432@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 05:27:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
Message-ID: <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Jan Kara <jack@suse.cz>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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

On Fri, Aug 21, 2020 at 3:13 AM Jan Kara <jack@suse.cz> wrote:
>
> > +             if (page_mapcount(page) != 1 && page_count(page) != 1) {
>
> So this condition looks strange to me... Did you mean:
>
>                 if (page_mapcount(page) != 1 || page_count(page) != 1)

Duh. Yes.

> > -             if (PageKsm(vmf->page)) {
>
> Also I know nothing about KSM but looking at reuse_ksm_page() I can see it
> plays some tricks with page index & mapping even for pages with page_count
> == 1 so you cannot just drop those bits AFAICT.

Yeah, I wasn't really sure what we want to do.

In an optimal world, I was thinking that we'd actually do exactly what
we do at munmap time.

Which is not to get the page lock at all. Just look at what
zap_pte_range() does for an a page when it unmaps it:

                        page_remove_rmap(page, false);

and that's it. No games.

And guess what? That "'page_remove_rmap()" is what wp_page_copy() already does.

So I really think *all* of these games we play are complete garbage
and completely wrong.

Because the zap_page_range() path is a *lot* more common than the WP
path, and triggers for every single page when we do munmap or exit or
whatever.

So why would WP need to do anything else for correctness? Absolutely
no reason I can see.

> Also I'm not sure if dropping this is safe for THP - reuse_swap_page()
> seems to be a misnomer and seems to do also some THP handling.

Again, I think that's a bogus argument.

Because this all is actually not the common path at all, and the thing
is, the common path does none of these odd games.

I really think this COW handling magic is just legacy garbage because
people have carried it along forever and everybody is worried about
it. The fact is, the "copy" case is always safe, because all it does
is basically the same as zap_page_range() does, with just adding a new
page instead.

And it's also possible I'm missing something.

But yes. That '&&' should very much be a '||'. What can I say? Oops.

              Linus
