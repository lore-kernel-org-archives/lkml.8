Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC9EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280B020B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597187479;
	bh=SvT0rvnnvQrqVaaOf5x7WAW1GmNYgN3HsG7gujkrphg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L3Q3XVQONnPD9Klo7bvnYJ9NnvqdUrFq2Wjru69cjuYp79EsegbZa16xxVLnBbO77
	 LyQuuEKEKHJEcO44Po+gNk+5L2quief0UPzs/2yX7j5tQ0dBap9V/ZPOBAiRL8FPgd
	 Z+4HcAmO55wmAuwPzt+T1fhf+pMRo2RZg+9mj95A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHKXLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKXLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:11:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102D7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 16:11:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so132044ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLNNVJSdWQONVjpAUUPGUdY9DEPRmdPHuKKqpzDsfqg=;
        b=a5GhrKjBf0PAmxmSEbjWUBWZJO4eP+0G9mthkovjp8ofgJc7Jk8Qoqa1S58g+k2mDE
         fcAYRDnfGmnARo0/Q2cxcOrRvBNGF9me0fXh6xWZv950UXqcW/1TYtzsx/E7oz4GBSn2
         88Q218pBpIdSZTW+PUNZxzbLstopizX7AChLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLNNVJSdWQONVjpAUUPGUdY9DEPRmdPHuKKqpzDsfqg=;
        b=WpPHexHp1f6IwYx9j0bxSEz8HTNEhrPdUwYySkhJqm52ePgy2v+g29e1Th/FVrOl5T
         utNJGVzrIGHqPxwYnjhZ9a0Uw9lO+umYt0fuWCPpp+Mt0EPhuft3vGLBhV4tFxWYv6mX
         VLLunW3AK0POy0TXNAOxg+fTwcjPMYp6+4O4iiMlmwXIKjf+YTq7a9DsVmwXGqEkijCf
         XnGE4dhRIlCHLgULxkCtv+7eQSikI3U5v3cGdQp6NIC/JA5s6C/sz0pVqqrJQvBNQX3x
         Rg5dFdq7icVFtZ64sQt4b6rKYRfcU7H+rl0dG1CIQsAyReITJO1qBBCHQ/3DZU3rvVdq
         Bo8w==
X-Gm-Message-State: AOAM5310MEr4ZCxc5RLQmJTP0qWAXYhInAfMFzUHm8I62p07LVGTqWAX
        xaVCEroHJ4R3/SNOPpDSwQ/y+0J056g=
X-Google-Smtp-Source: ABdhPJzY4tz7TAe2Xt/iPktFsvErbPxLeTcge0nL+TyrUBcB7K4/y3OeHmCxD/NYQspCCphFcEz6qQ==
X-Received: by 2002:a2e:a483:: with SMTP id h3mr356579lji.76.1597187475043;
        Tue, 11 Aug 2020 16:11:15 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id h2sm42507ljl.16.2020.08.11.16.11.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 16:11:13 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h19so116678ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 16:11:13 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr3849775lji.314.1597187473000;
 Tue, 11 Aug 2020 16:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com> <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com> <20200811214255.GE6353@xz-x1>
In-Reply-To: <20200811214255.GE6353@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 16:10:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
Message-ID: <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 2:43 PM Peter Xu <peterx@redhat.com> wrote:
>
> I don't know good enough on the reuse refactoring patch (which at least looks
> functionally correct), but... IMHO we still need the enforced cow logic no
> matter we refactor the page reuse logic or not, am I right?
>
> Example:
>
>   - Process A & B shares private anonymous page P0
>
>   - Process A does READ of get_user_pages() on page P0
>
>   - Process A (e.g., another thread of process A, or as long as process A still
>     holds the page P0 somehow) writes to page P0 which triggers cow, so for
>     process A the page P0 is replaced by P1 with identical content
>
> Then process A still keeps the reference to page P0 that potentially belongs to
> process B or others?

The COW from process A will indeed keep a reference to page P0 (for
whatever nefarious kernel use it did the GUP for). And yes, that page
is still mapped into process B.

HOWEVER.

Since the GUP will be incrementing the reference count of said page,
the actual problem has gone away. Because the GUP copy won't be
modifying the page (it's a read lookup), and as long as process B only
reads from the page, we're happily sharing a read-only page.

And if process B now starts writing to it, the "page_count()" check at
fault time will trigger, and process B will do a COW copy.

So now we'll have three copies of the page: the original one is being
kept for the GUP, and both A and B did their COW copies in their page
tables.

And that's exactly what we wanted - they are all now containing
different data, after all.

The problem with the *current* code is that we don't actually look at
the page count at all, only the mapping count, so the GUP reference
count is basically invisible.

And the reason we don't look too closely at the page count is that
there's a lot of incidental things that can affect it, like the whole
KSM reference, the swap cache reference, other GUP users etc etc. So
we historically have tried to maximize the amount of sharing we can
do.

But that "maximize sharing" is really complicated.

That's the big change of that simplification patch - it's basically
saying that "whenever _anything_ else has a reference to that page,
we'll just copy and not even try to share".

             Linus
