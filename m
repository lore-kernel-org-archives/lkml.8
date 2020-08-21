Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E862C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D31220656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029450;
	bh=Drx90GmrxTCG4Y+8buTOeL7dM/DROnR7B44Wi50Yq84=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XUFpJ24EuN6kPvZkqnzlieWtVKrKvFmWQWnyV9aXI5V9kE24UwVS8bfvh+zfCsf2V
	 To6iuDV0bYTOMicf3JCyvQHUFd1/In7gaaAOGDBcwTJq/2MEzGOzspPkFe4L49Aqn0
	 0dyBpWmi7pg30MhfjWKIJrX+x4zKutEXlu4uxj/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgHUREC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgHURBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:01:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A2AC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:01:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so2594766ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXLHMGIPdVkIhXLps0eqzqu9gb1jBU6At3Q0gRIPsOk=;
        b=LMGya38u0UebERx+VyXuhbTqigAW+BkbMraZO7VYNU3FF0kycK7jAzZp4BxMZz5Uz2
         thnDr1lHDGLOodacgbMVJmrAnyS0ZHbXx2B3OOxYizKhXGCKPsMWq8drS/k40VRShgCI
         aS6oIf4a8yskW0YdgV0wOIiwSXwNHHS4WcRNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXLHMGIPdVkIhXLps0eqzqu9gb1jBU6At3Q0gRIPsOk=;
        b=HdB00ZljoGqICSgUWR0t9NKymZsOXRgHZ0mmmne86qV5z4azo5t4CkhYJkcrfchbrp
         IJ6KW4pRmF7Nh9zkv8h5Djh5NAVohVPkMTGfkA6AnIt6PmipuKisVWQzh75pmEQVg+3x
         0Wg9faSDj4WtCpa9evtI1562Df8TmY7MBu/M8zowc6TSfFJ3fKz/BeCcrHR0/BZxGdy3
         lO9orFbWAZzfA7L/3SrI9z6avMtPdg8wMGLpJNaP3BlKEcbtfWo4I8muRUpyPF4o5Lpi
         WOfwVgZNd32RgBqm6rzvEIg7+wSGgffRsMnAWzWKy9KlAmzkw8Zg5wiK4/GDrx+BbKWe
         aIOw==
X-Gm-Message-State: AOAM5303H5BEseuX7DlnPXKQoR/1EBf/fYQDBj0AgfEzlsSlVdwvC44C
        5Z2Re50by3aiqzFfWd9NZL3P73I6cx0EwA==
X-Google-Smtp-Source: ABdhPJxuvYHh2UTZgUsv87Xl5KMCJhkVpPNROzTQtYLmnIwofpsIMe4tpx9w/2YdtsLxOLjvGAPuEg==
X-Received: by 2002:a2e:9156:: with SMTP id q22mr2021687ljg.348.1598029277399;
        Fri, 21 Aug 2020 10:01:17 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 85sm486576ljj.61.2020.08.21.10.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 10:01:16 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m22so2605503ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:01:15 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr1825308ljh.70.1598029275225;
 Fri, 21 Aug 2020 10:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com> <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1> <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1> <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz> <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
 <20200821154756.GC3432@quack2.suse.cz>
In-Reply-To: <20200821154756.GC3432@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 10:00:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
Message-ID: <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 8:48 AM Jan Kara <jack@suse.cz> wrote:
>
> I was more concerned about the case where you decide to writeably map (i.e.
> wp_page_reuse() path) a PageKsm() page.

Yeah, so I think what I do is stricter than what we used to do - any
KSM page will never be re-used, simply because the KSM part will have
incremented the page count.

So as far as I can tell, with that patch we will never ever share
except for the "I really am the _only_ user of the page, there are no
KSM or swap cache pages" case.

That's the whole point of the patch. Get rid of all the games. If
there is *any* possible other use - be it KSM or swap cache or
*anything*, we don't try to re-use it.

> And also here I was more concerned that page_mapcount != 1 || page_count !=
> 1 check could be actually a weaker check than what reuse_swap_page() does.

If that is the case, then yes, that would be a problem.

But really, if page_count() == 1, then we're the only possible thing
that holds that page. Nothing else can have a reference to it - by
definition.

And if page_count() != 1, we will not share. Ever. We'll just do what
zap_paghe_range() does - unmap the old page and do the
page_remove_rmap().

The only small worry would be the race between releasing the page
table lock - when we allocate a new page - and somebody coming in and
doing something magical to that page. But that's where holding the
page lock comes in.

Plus that part isn't anything my patch changes.

               Linus
