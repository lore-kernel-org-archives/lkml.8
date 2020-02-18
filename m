Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1D1C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268F8206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3PMLLCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRChn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:37:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44129 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBRChm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:37:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so22971288eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 18:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5Wztdcq0xb5666uBgxA54T8GeJH0yGcRfh+PsUTNPQ=;
        b=P3PMLLCEbNYaCu0qdw/g5C4RvRHZH85ToAPVXjkycwT8DIIjd6ZnrBTzeYT154aEPU
         8WIRYxAtxADcakO/f5CnGd5ezgaZF5PMjJjuYZK/PrJmUwLwAuOXoYBZnDtvynnC+/Qt
         UIexo26ogliBZwZZho21As0rU3GfVsDYaH0FCF6PSZ7czmNUdasyWG/Ja/iAqEDRK/c4
         8p31iIF+2pShFmlqk6Svt8ErLUIY1P0+XQ0rSPTM/fl0IvQEmTRmAkshWhIxBxtELrpF
         xivT3NSQkXbHZbpu/VGozRGSFtTXZWHL+A+cewLOibUbJ5BnUhKDpMqxsGqXAfKg7bQS
         UO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5Wztdcq0xb5666uBgxA54T8GeJH0yGcRfh+PsUTNPQ=;
        b=lXnviHwke6GMY/8h1s5Z4c6KtS82BLy7nlxX4py2199pTYfjQxXV3L0D4tfmXm7x7g
         zg6ZQSj8yRO2wVhBQ4gRhoevyJsN4NyjYU5vCdgO06IudVKRdbFsMmDPomi+0VkLpjLJ
         qwrK9wXzTEqXwT9hJLXCrYATih8of2Wnj5fgMCdsQzk28g+MicyJn8jv5x9sLD/BCx9D
         p0kQZZmGDrIX717IXHB6eilUeTz/NqviSEPI+rS0qnUQQH9Yyf+Wm2r0ohVrVwdQpyin
         PjMZX7WNpugOUsfa51Sr+oDm8iAlWGpHLMesb+9wWZL68p4O38Wr0llR+PCmFiguKFSp
         mcyw==
X-Gm-Message-State: APjAAAV+fjcCH8NVM2b3hmT0mmGO4k6XeNHcCeMNw443BY6e3wXdDGMr
        aCs+X0eQ1d1f5krywNATGhCMvioEuSLUYwQ5vEKOO2JR
X-Google-Smtp-Source: APXvYqyysff+IA+5Q35KabhhUKRuTjpfJH5sDLutVmjJQVn2DteQkh+pCl3J/8Ev2FQ1ldvpa+g9zVQGCS+rSMWdxJ4=
X-Received: by 2002:a05:6402:61a:: with SMTP id n26mr15749135edv.135.1581993459575;
 Mon, 17 Feb 2020 18:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20200214225849.108108-1-bgeffon@google.com> <20200214231954.GA29849@redhat.com>
 <CADyq12w3tBO5NfZ33R__B3jvF=ed7ys+o4horGwyUO3bNevObg@mail.gmail.com>
 <20200217160739.GB1309280@xz-x1> <CADyq12zU25+w2nX9bFGm=O2svgMM_ReC73qfE7JDeVfJz0Y0UQ@mail.gmail.com>
 <20200218022655.GE29216@redhat.com>
In-Reply-To: <20200218022655.GE29216@redhat.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 17 Feb 2020 20:37:07 -0600
Message-ID: <CADyq12wjRLTEJALQwAbskHyTonbxTT8XR=WD74jzaGydgJ6HDw@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: Address race after fault.
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sonny Rao <sonnyrao@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,
That all makes sense, thanks so much for that detailed explanation.

Brian

On Mon, Feb 17, 2020 at 8:27 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Mon, Feb 17, 2020 at 07:50:19PM -0600, Brian Geffon wrote:
> > But in the meantime, if the plan of record will be to always allow
> > retrying then shouldn't the block I mailed a patch on be removed
> > regardless because do_user_addr_fault always starts with
> > FAULT_FLAG_ALLOW_RETRY and we shouldn't ever land there without it in
> > the future and allows userfaultfd to retry?
>
> It might hide the limitation but only if the page fault originated in
> userland (Android's case), but that's not something userfault users
> should depend on. Userfaults (unlike sigsegv trapping) are meant to be
> reliable and transparent to all user and kernel accesses alike.
>
> It is also is unclear how long Android will be forced to keep doing
> bounce buffers copies in RAM before considering passing any memory to
> kernel syscalls.
>
> For all other users where the kernel access may be the one triggering
> the fault the patch will remove a debug aid and the kernel fault would
> then fail by hitting on the below:
>
>                 /* Not returning to user mode? Handle exceptions or die: */
>                 no_context(regs, hw_error_code, address, SIGBUS, BUS_ADRERR);
>
> There may be more side effects in other archs I didn't evaluate
> because there's no other place where the common code can return
> VM_FAULT_RETRY despite the arch code explicitly told the common code
> it can't do that (by not setting FAULT_FLAG_ALLOW_RETRY) so it doesn't
> look very safe and it doesn't seem a generic enough solution to the
> problem.
>
> That dump_stack() helped a lot to identify those kernel outliers that
> erroneously use get_user_pages instead of the gup_locked/unlocked
> variant that are uffd-capable.
>
> Thanks,
> Andrea
>
