Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B64C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91CD2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLphA8Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBQGpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:45:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34302 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:45:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so16256350wrm.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 22:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGnUjGVLO1r9iWfqXt0qpMvnwv69UZFpNplwLZdkJAQ=;
        b=GLphA8HypKtuvC/GByFZF501hohmwqarTrNf9E6ChrWae7+uHIiU8jyLw4FwxpcXBX
         5LcpNQp8zr57B7Usw/T1/xOJoF/YMdkDnY7ngvj5S6dIQGY6emRGalo19ofKrYvmsXlq
         AK423hCUtqu7rWaAlwdU45y8MqvDp/PkZ02VT8b5MbyOiyMOwo3OTlb/qWgDMIIy/2pM
         k5URnymlAPDDajjuU8U+2ieS6Er3iGEzM/fvxbo6srk8Za+vWvrVasDTHTcbjCS/2upU
         UX0XAzmmn/mfgfvLF6y7v/QXPRbxi/0Eg7en3tC+7ARqwpB6enPIfv4RAiwBPNKgkeVc
         JYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGnUjGVLO1r9iWfqXt0qpMvnwv69UZFpNplwLZdkJAQ=;
        b=YZ0FAl2WdOPU4/IcHE/Vvp+PB+Q/QTOFku89T9vDV0Oejt2U9UpyBLM2sQ3z+Oifck
         OeK+f2rDoB5H8NAKzZfH5EHqoDIMt/yjZNeRbbtZ8T7JW1I0f0Fa5WpA1AJw/RdAAi7x
         aYPe0n9rKSr4i8gBCyy4JbcJyQVOQVqjpkM33p5tewFIBRz6p6qrw/mfVW12wqg7xnYq
         9gaiP1ruShiguBf4AjRGKoaGiu6CImmsTRw7z73B30F2Dn9ikStGISvdjf/8vmaCd5iL
         oVmztC3+/hfjm0aMnuTv9NE0oM/H3JI1zifV28XqY8La0G7YZkWVhb5XhASRYP3Va1R4
         aHGg==
X-Gm-Message-State: APjAAAWxJvoBss7NEx0eyGJLiL/2fNz0HZlu/cH/wC9R4PwkJ8vFvQvg
        hZIXGtJRXqL5QxT/fdU3vJytKffD7065f+IT2Z2gog==
X-Google-Smtp-Source: APXvYqzbCi4Ksj39/SDAJziZE5nN7/gkHIfOflaSzE4I9bTml3VB+ii025a3tLvE5avSH9K0vL0tuDOv5ApcTnQwEMA=
X-Received: by 2002:a5d:5188:: with SMTP id k8mr20044605wrv.151.1581921947030;
 Sun, 16 Feb 2020 22:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20200217145711.4af495a3@canb.auug.org.au> <CAOFY-A1nfPjf3EcQB6KiEifbFR+aUtdSgK=CHGt_k3ziSG6T_Q@mail.gmail.com>
In-Reply-To: <CAOFY-A1nfPjf3EcQB6KiEifbFR+aUtdSgK=CHGt_k3ziSG6T_Q@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Sun, 16 Feb 2020 22:45:35 -0800
Message-ID: <CAOFY-A3q_pmtHKAoOJdbB09wy=dxs9SdpXjCsU1wBxU5EDHVmw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 8:12 PM Arjun Roy <arjunroy@google.com> wrote:
>
> On Sun, Feb 16, 2020 at 7:57 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the akpm tree, today's linux-next build (sparc64 defconfig)
> > failed like this:
> >
> > mm/memory.c: In function 'insert_pages':
> > mm/memory.c:1523:56: error: macro "pte_index" requires 2 arguments, but only 1 given
> >    remaining_pages_total, PTRS_PER_PTE - pte_index(addr));
> >                                                         ^
> >
> > Caused by commit
> >
> >   366142f0b000 ("mm/memory.c: add vm_insert_pages()")
> >
> > This is the first use of pte_index() outside arch specific code and the
> > sparc64 version of pte_index() nas an extra argument.
> >
>
> Looks like this happens for sparc, and also metag. Other platforms
> just take the addr parameter based on a quick search.
>

And actually I guess there's no metag anyways now.
Looking further, then, it looks like in every non-sparc pte_index() is
an actual numerical index, while on sparc it goes a step further to
yield a pte_t *.
As far as I can tell, the sparc incarnation of this is only used by
the pte_offset_(kernel/map) macros.

So I think a possibly sane way to fix this would be:
1. Define pte_index() to be a numerical index, like the other architectures,
2. Define something like pte_entry() that uses pte_index(), and
3. Have pte_offset_(kernel/map) be defined as pte_entry() instead.

Then pte_index would be operating on just an address for all
platforms, and the reverted patchset would work without any changes.

If this sounds acceptable, I can send a patch.

Thanks!



> > I have reverted these commits for today:
> >
> >   219ae14a9686 ("net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy-fix")
> >   cb912fdf96bf ("net-zerocopy: use vm_insert_pages() for tcp rcv zerocopy")
> >   72c684430b94 ("add missing page_count() check to vm_insert_pages().")
> >   dbd9553775f3 ("mm-add-vm_insert_pages-fix")
> >   366142f0b000 ("mm/memory.c: add vm_insert_pages()")
> >
>
> In terms of fixing this; passing in an appropriate dir parameter is
> not really a problem, but what is concerning that it seems messy to
> have a per-platform ifdef to pass it either two arguments or one in
> this case. But it seems like either that would be one way to fix it,
> or having some arch method across all arches that takes two arguments
> (and ignores one of them for most arches).
>
> Is there a general preference for the right way forward, in this case?
>
> Thanks,
> -Arjun
>
> > --
> > Cheers,
> > Stephen Rothwell
