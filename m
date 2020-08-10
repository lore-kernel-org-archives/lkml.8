Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F109207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597078067;
	bh=yJfIkkdCzrCMdbjH7ys/rBix9qN66sTAq5RdvL9Yb2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P+1oTdrG5f8nDYU0yE6mKo5nSX4sBzPzGbDDXe1e8gfNWRYExw7VMBRaDfU3Qi5VU
	 49xBoGhJHKGmw43gYop66T8h9lKgOCaeNMFr1P40Zix4lIJPGwwy9lfzhT4K0H6hDf
	 rGrbsDZG04CdMOw9nBP8HoEu9Os0ZeWennnE0BGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHJQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:47:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7ADC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 09:47:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so10326764ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FysGtb8inXqSIawN5ojOBaunBDDu9d2yxrSJc+Eh5Ik=;
        b=C/BnDPNLO6j29yT981hNypIvExpmF7gUDXGhgnPGt3Bkot3nAwqB7apErwKMe/ijP0
         xB+rnSLzE2Euv1HRTA66M+lDKN7cAazwWhR/3MA7Zbvlf/LSXOrSBDSbY6pN5rCsHt1i
         QOil+ZLfX+hf6wzPRkMgEz9Irv6W18qws41mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FysGtb8inXqSIawN5ojOBaunBDDu9d2yxrSJc+Eh5Ik=;
        b=MSHRb+KxNfqRhIg5Vh/8XX7vDuU8v4THCu0khnJMWj/jzXoPQieHsencDNlSUyAhFO
         rbvuKVNxbfzxjVof8ieUdv/8i9gMz7gvG4S76TwQyAZgrX4h6H1Uu/gKEDvlQ8gxUyln
         wLTMeJd7dVgUzo/uFb/ha1BwG2TOfDdmFWD4L/QD7TiP0DQUI7DhPkE2O+u7qnBPSluf
         fc087r5vitZkutulC98HT5LKiBRZ7/uBAM+AIxA8k3Yv7XgKDb0SwQevtEhdWyJ7wWZa
         IWhIfxF1l9iD/cJBM9lIfDd1V4YTCSFBn65+BzD+bi4ym6TMkw7OaeXHohBmAh2wJymS
         L1pA==
X-Gm-Message-State: AOAM532fnKXRAr8F6VwKPbD7cGtOQcvqxFnmUjDl6Vi5zcfAkXotN3oA
        D2wVrt/I1RnU5f39zR/BOA2ofT45khk=
X-Google-Smtp-Source: ABdhPJxBSgWNuXE5DtLQ2aQMyBMTHwf4kYqIdpLy0TXFKFnXQS2DjcoTvJeGJxsLcx3cwod7Bm3FFQ==
X-Received: by 2002:a2e:8087:: with SMTP id i7mr1004855ljg.98.1597078060063;
        Mon, 10 Aug 2020 09:47:40 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f14sm4806055ljp.138.2020.08.10.09.47.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 09:47:39 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id w14so10341320ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 09:47:38 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr975125lji.314.1597078058439;
 Mon, 10 Aug 2020 09:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200810145701.129228-1-peterx@redhat.com>
In-Reply-To: <20200810145701.129228-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Aug 2020 09:47:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
Message-ID: <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 7:57 AM Peter Xu <peterx@redhat.com> wrote:
>
> One solution is actually already mentioned in commit 17839856fd58, which is to
> provide an explicit BREAK_COW scemantics for enforced COW.  Then we can still
> use FAULT_FLAG_WRITE to identify whether this is a "real write request" or an
> "enfornced COW (read) request".

I think the patch is fine, but during discussions we also discussed
having the flag the other way around, in order to have the default be
"break COW", and the use cases that explicitly know they can handle
the ambiguity would have to say so explicitly with a "don't break COW"
bit.

I don't think this matters in theory, but in practice I think it would
be a good thing as documentation.

Because FAULT_FLAG_BREAK_COW doesn't really tell you anything:
breaking COW is "always safe".

In contrast, a "FAULT_FLAG_DONT_COW" bit could be accompanied with a
note like "I don't care which side I get - I'm not going to keep track
of the page, I just want random data, and it's ok if I get it from
another forked process".

In fact, maybe it shouldn't be called "DONT_COW", but more along the
lines of those semantics of "READ_WRONG_SIDE_COW_OK", so that people
who use the bit have to _think_ about it.

I think comments in general should be there.

Looking at your patch, for example, I go "Hmm" when I see this part:

-       if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+       if ((vmf->flags & FAULT_FLAG_WRITE) &&
+           userfaultfd_pte_wp(vma, *vmf->pte)) {
                pte_unmap_unlock(vmf->pte, vmf->ptl);
                return handle_userfault(vmf, VM_UFFD_WP);
        }

and I go "ok, for reads with COW breaking, we'll just silently break
the COW and not do VM_UFFD_WP?"

An explanation of why that is the right thing to do would be good. And
no, I don't mean "UFFD doesn't want a WP fault in this case". I mean
literally why "we do want the silent COW, but UFFD doesn't care about
it".

End result: I think the patch is fine, but the reason we had
discussion about it and the reason it wasn't done initially was that
you get all these kinds of subtle behavior differences, and I think
they need clarifying.

               Linus
