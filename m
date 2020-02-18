Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F9C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8182C206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9+lDh/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgBRBux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 20:50:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37760 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgBRBux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:50:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so11252573edr.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 17:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPJTmL7M/KQjilpjiQvSnCs28pkECQ3GbYH85X9jLmk=;
        b=s9+lDh/5BUI0pym1FldGomHkvz5qiNZwA0r+zHjhzGda5b6rbhrwtE4krO8GkFdagq
         /WCOcB6Q65T98y4ejsfeXNuYEz+0Jx2qQBEcFEcwzZJenBdwzDoInleNQd/PgTGIb9Sa
         ETrxr2ZZbvjfUfjitId2ryCuUY0sRGIkiLsnFBYpm8SfH7aBn0aeBxEBv6jYpxlff9MI
         SzkJBof+bYUhjhZBV6dVmBiR5aKCxb4q6oa34g0J9daoSU775oqGpoliOuZoCB73Xaa0
         jtz3FfzTFyNFAhlN+bjGfteTf01Tgutbx3mETKFzMMHcxWBsGz3UIE3REFomgYn6obji
         emgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPJTmL7M/KQjilpjiQvSnCs28pkECQ3GbYH85X9jLmk=;
        b=svCktUOxWroE43EUMgT9Ino9hqKAPc2q+vhTyjkSGp6B2xJLuxZoEhUZTBsCUr5onW
         cbhRypKkohJElM/6ET7w0Yo6J8XQdcGKnvWD8IARN3h6KNxCvMS73nXzyIJIUgwyb8ND
         2fEzzVUMl5o9Wo94IHK8Ti+ybM8miTtc6GfaexjLQ53UUV2SROM2lHODWi0vGAmIvUhv
         xbLXLYg+8ODIExYM/Lm9JPtKH391GdqN33b9HnQvFxc2YDfbchpTjf/RIIRSGNbJTQeB
         ODL7NBPQAkzmZ1Oz5Uy/BH6vFgwC/lme+gQct2ZDLB4Ru4xnUBmLo9qmVVb62cX7shf7
         KrNA==
X-Gm-Message-State: APjAAAUg5TbP8ceBOv47aUMvslEeY7IlsToyPpmcnd1UaJd8uL/HXsFl
        S8asOs8mMQP0NJEmW1M5vm5gAlNg2NukvsKCyWFo8A==
X-Google-Smtp-Source: APXvYqyNN3yx/S+WRiCLT6r4gund166Nyn8aPiJYFec6JgvbZ2l4aiehPXWsqqpY8Vt6aY5rzPF5SOgw3vZPFVp7IBo=
X-Received: by 2002:a17:906:4e01:: with SMTP id z1mr17520009eju.46.1581990651117;
 Mon, 17 Feb 2020 17:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20200214225849.108108-1-bgeffon@google.com> <20200214231954.GA29849@redhat.com>
 <CADyq12w3tBO5NfZ33R__B3jvF=ed7ys+o4horGwyUO3bNevObg@mail.gmail.com> <20200217160739.GB1309280@xz-x1>
In-Reply-To: <20200217160739.GB1309280@xz-x1>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 17 Feb 2020 19:50:19 -0600
Message-ID: <CADyq12zU25+w2nX9bFGm=O2svgMM_ReC73qfE7JDeVfJz0Y0UQ@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: Address race after fault.
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
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

Hi Peter,
I'll try helping out by giving the entire patchset a try.

But in the meantime, if the plan of record will be to always allow
retrying then shouldn't the block I mailed a patch on be removed
regardless because do_user_addr_fault always starts with
FAULT_FLAG_ALLOW_RETRY and we shouldn't ever land there without it in
the future and allows userfaultfd to retry?

Thanks,
Brian

On Mon, Feb 17, 2020 at 10:07 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Sat, Feb 15, 2020 at 09:29:46AM -0500, Brian Geffon wrote:
> > Hi Andrea,
> > Thanks for the quick reply. That's great to hear that Peter has been
> > working on those improvements. I didn't try the entire patchset but I
> > did confirm that patch 13, not surprisingly, also resolves that issue
> > on at least on x86:
> >   https://lkml.org/lkml/2019/9/26/179
> >
> > Given that seems pretty low risk and it definitely resolves a pretty
> > big issue for the non-cooperative userfaultfd case, any chance it
> > could be landed ahead of the rest of the series?
>
> Thanks Andrea & Brian!  Yes it would be great if the series (or some
> of the patches) could be moved forward.  Please just let me know if
> there's still anything I can do from my side.
>
> Thanks,
>
> >
> > Thanks,
> > Brian
> >
> > On Fri, Feb 14, 2020 at 6:20 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> > >
> > > Hello,
> > >
> > > this and other enhancements have already implemented by Peter (CC'ed)
> > > and in the right way, by altering the retry logic in the page fault
> > > code. This is a requirement for other kind of usages too, notably the
> > > UFFD_WRITEPROTECT ioctl after which multiple consecutive faults can
> > > happen and must be handled.
> > >
> > > IIRC Kirill asked at last LSF-MM uffd-wp talk if there's any
> > > particular reason the fault couldn't be retried currently. I had no
> > > sure answer other than there's apparently no strong reason why
> > > VM_FAULT_RETRY is only allowed 1 time currently, so there should be no
> > > issue in lifting that artificial restriction.
> > >
> > > I'm running with this patchset applied in my systems since Nov with no
> > > regression at all. I got sidetracked by various other issues, so
> > > unfortunately I didn' post a proper reviewed-by on the last submit yet
> > > (pending), but I did at least test it and it was rock solid so far.
> > >
> > > https://lore.kernel.org/lkml/20190926093904.5090-1-peterx@redhat.com/
> > >
> > > Can you test and verify it too if it solves your use case?
> > >
> > > Also note the complete uffd-WP support submit also from Peter:
> > >
> > > https://lore.kernel.org/lkml/20190620022008.19172-1-peterx@redhat.com/
> > >
> > > https://github.com/xzpeter/linux/tree/uffd-wp-merged
> > >
> > > Thanks,
> > > Andrea
> > >
> >
>
> --
> Peter Xu
>
