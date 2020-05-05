Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD017C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0822078C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZPHz2sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgEELml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728422AbgEELml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:42:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CD7C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 04:42:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so1236019ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikKwSi47RkdUncF8ZIue6G09Cc3O7H+FG1YBZJHLO1c=;
        b=PZPHz2sf+Y8/7voSUCVwWYQDTFp6jwT4eccln+h2V5t1fLtEiuMZ5ce3f8GLrLB5/+
         Lv1kPL8izEzV+2IdG5SUTSb1GcCNzzZfyx/zyH1vNX1EgrQil8bLC2Jc+9mBLhAhHXe7
         lOi78W5ciY1Ra0aIWnH4lpyflE7/EEEyKc94UjlHjcZQTnCuGIhy7/dnoqU7UVdaxjRC
         Rdy8T9f0YhG4rZRuZD9UxnGFLdby4z/l2sf/CrEw82JtjLZcoH91Y9xfMaRapGwaeY1W
         cCq9z7jHxn2gQYCZgaN9WotoV7g5/hfB1w9fLaw30A+XNiJTmnTXn2BktrD8y/mxhzoX
         nxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikKwSi47RkdUncF8ZIue6G09Cc3O7H+FG1YBZJHLO1c=;
        b=Mlm2xC+ohTzXSZd18ogUqA/Si+3VnTb08Se2StVky+mIOUbLYTdATd2Uzt57oOXsYh
         ii60c5N1pPU6ajUoHZIb883ZlapFoTJqZj+NeKO+ds+GczvtKqUQkkciDH09Do6CPLFU
         xHv8ACI12HUuXnaAEfRXXP91BDeiyhWlkqgrNB9+AR4fvQP2iIx4gSGAtKlfeXZuYQ+1
         xYb9GfLujDn472U0zDqvwMIe9P1kI7SWSfZZjzZApnU50eLcQ6Pv92xD0jhQwU1ZWMeV
         7dpvYt6V8mT4w0seGQ5kc+4sLXvD1ZP0BfD82M0/31qqaSP0ojSRBPkSrKJLeGeYzimo
         sMOQ==
X-Gm-Message-State: AGi0PuYBcMGxZEYoL1UgU7uOJo/B0S40HRK81bQUTWwCQad5mb5fJkl/
        dmqPymvqspZVdDBjaNwb5KCktaU3wt89LYGsKBgVto8qsnU=
X-Google-Smtp-Source: APiQypLzrurPKOFHS71dRCXI6iqbXYejtciTu5aveMTkrB6ldhKIG7OBjVfkuUaytzaP4Y/gPJR2+9djLt+JtIxmsXQ=
X-Received: by 2002:a2e:b249:: with SMTP id n9mr1613232ljm.221.1588678959039;
 Tue, 05 May 2020 04:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com> <20200429214954.44866-2-jannh@google.com>
 <20200505104805.GA17400@lst.de>
In-Reply-To: <20200505104805.GA17400@lst.de>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 May 2020 13:42:12 +0200
Message-ID: <CAG48ez3F70-UXwdHmO4CnR0bAForn-SBtstW5WAYjcrLFwS_9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] binfmt_elf_fdpic: Stop using dump_emit() on user
 pointers on !MMU
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 12:48 PM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Apr 29, 2020 at 11:49:50PM +0200, Jann Horn wrote:
> > dump_emit() is for kernel pointers, and VMAs describe userspace memory.
> > Let's be tidy here and avoid accessing userspace pointers under KERNEL_DS,
> > even if it probably doesn't matter much on !MMU systems - especially given
> > that it looks like we can just use the same get_dump_page() as on MMU if
> > we move it out of the CONFIG_MMU block.
>
> Looks sensible.  Did you get a chance to test this with a nommu setup?

Nope. Do you happen to have a recommendation for a convenient
environment I can use with QEMU, or something like that? I'm guessing
that just running a standard armel Debian userspace with a !mmu ARM
kernel wouldn't work so well?
