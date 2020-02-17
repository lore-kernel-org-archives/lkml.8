Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC397C7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B7D20717
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqBHCUg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgBQENH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:13:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41963 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgBQENH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:13:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so17938654wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 20:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+t2lAkJHHWrFw6xWV3SgprQvUaUl1BY+kJcD9vJxAFw=;
        b=DqBHCUg2BEqvLrW9aug6Iu5M9vdgPJjktizhhWsUeAu9Myk3h+5eSsIIJphj0G7roz
         dgn4pQJbXjvsyltRE9cC6TJlZ+F2H/zKmtqph8PZ5Wlyuc0lUStJJcCPwJtPs9RRvd+M
         fvw+HeUSFawyfABLMJfZeaXjKf6APAuj4KIntzf3+LbMYc3pVNw8HfE0VQZSXrLfCRG+
         NNz/Rw9ExeK8O2kWRK80ffyKPdQ4GKcmaG99DCSO8ys6GjrVW/m0Ejcmv5hg5Jp+Q/AR
         f3kw0avsgwosAwxT3pOISPkuAytimngtFCEPqmalzrl+dX4d+FbjHyEPnW8MDb6jlgXC
         rtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+t2lAkJHHWrFw6xWV3SgprQvUaUl1BY+kJcD9vJxAFw=;
        b=M7l1IkQqWp1APidZO14BwmkGlmw67rMJ6jbedcCXqqXGUeyEGl5FSD9c4PUAn/MDWC
         eeWIPhp+D80GlT8guukTRYPP8CD2MzzE6X2sw+jYVDwsJAJue/z0bvyRzWZtjgmKb4S4
         6sFBh5HOZco94W1PZW2K5JjW6iLsDcI+ookhkwgI1ZRRxg2WikpBtD9e4bjVBY2gXggw
         ooPrgYRVGwki33HuA9QU07Luri5dmThCJQQXJfe2nGGz7eWfo/G2IGL0yiidR+D15Kob
         b0pqgOdfTZLzwQuq4XKjOyL/X46X8mRifOGy+qDfDRcNCUFhEGGXdastFWPDtFmhbLjR
         5skQ==
X-Gm-Message-State: APjAAAWUzM7qKf86wDnj5W8/0t04hqqxrxRVeX/PGngPd2SUj65NHRF9
        CPn6fZAcon9yshB7PbKXwTzp+PABI4MA1ddWwd1DCg==
X-Google-Smtp-Source: APXvYqy8DstK6bOQQIriUK8rvFbqZFNIo81H4tlz+QiKRzdpPok+ra2ukbmMzZMLo/NfxDuNVumQ/EXyHtEI2PS90oE=
X-Received: by 2002:a5d:6545:: with SMTP id z5mr18921279wrv.3.1581912784734;
 Sun, 16 Feb 2020 20:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20200217145711.4af495a3@canb.auug.org.au>
In-Reply-To: <20200217145711.4af495a3@canb.auug.org.au>
From:   Arjun Roy <arjunroy@google.com>
Date:   Sun, 16 Feb 2020 20:12:53 -0800
Message-ID: <CAOFY-A1nfPjf3EcQB6KiEifbFR+aUtdSgK=CHGt_k3ziSG6T_Q@mail.gmail.com>
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

On Sun, Feb 16, 2020 at 7:57 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm tree, today's linux-next build (sparc64 defconfig)
> failed like this:
>
> mm/memory.c: In function 'insert_pages':
> mm/memory.c:1523:56: error: macro "pte_index" requires 2 arguments, but only 1 given
>    remaining_pages_total, PTRS_PER_PTE - pte_index(addr));
>                                                         ^
>
> Caused by commit
>
>   366142f0b000 ("mm/memory.c: add vm_insert_pages()")
>
> This is the first use of pte_index() outside arch specific code and the
> sparc64 version of pte_index() nas an extra argument.
>

Looks like this happens for sparc, and also metag. Other platforms
just take the addr parameter based on a quick search.

> I have reverted these commits for today:
>
>   219ae14a9686 ("net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy-fix")
>   cb912fdf96bf ("net-zerocopy: use vm_insert_pages() for tcp rcv zerocopy")
>   72c684430b94 ("add missing page_count() check to vm_insert_pages().")
>   dbd9553775f3 ("mm-add-vm_insert_pages-fix")
>   366142f0b000 ("mm/memory.c: add vm_insert_pages()")
>

In terms of fixing this; passing in an appropriate dir parameter is
not really a problem, but what is concerning that it seems messy to
have a per-platform ifdef to pass it either two arguments or one in
this case. But it seems like either that would be one way to fix it,
or having some arch method across all arches that takes two arguments
(and ignores one of them for most arches).

Is there a general preference for the right way forward, in this case?

Thanks,
-Arjun

> --
> Cheers,
> Stephen Rothwell
