Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E729DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF527206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8soxI7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgFOHdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgFOHdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:33:10 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276EDC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:33:10 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a26so4455354lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ij8fwvzXOj7JAq3VNU3da0LvTOItJ04cqi51tCAw79I=;
        b=v8soxI7JFoh4zGrZAEyl8fl+2jN4kIlKUy/EUANM6s7L1MHVo0TM0XWZJG4YaEBwyv
         OyeNSNfKfyhSoS4KBzPaX+t0C4rQ5TYtsVG5a9ea2W2LQDIWaDDhh1hT0JrERexy+3k0
         XtVCLOfOBZFtXpW9rEF/YkuikSpc5lX5ktw/klmasRLPOnl/t0l+CeggTrwkPOcKNXPX
         NUAoh+TfIb4fa8ZBsQ+CFF0dQTz1VdhgfG8cx9OL0kfvdo4/OE+vJCSQ24LzFWtUukDB
         SAlEnH6HjZQJsXVVE/yU7/r1Npj3qfVUaTY1TQaGKBIAjzX1uUluWcdV+r7BHkj9m+RP
         7i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ij8fwvzXOj7JAq3VNU3da0LvTOItJ04cqi51tCAw79I=;
        b=ED/3omi48LgZY3WtSK1F3BkeWvcef6HQmlAruKDA783iN9SfNzaCopWKdM3+4m8TX2
         rjCP6czdy3GFSzdMKhwOVv2YpBOd6nmorh4i9PNb/WEr01bYzBFbnKspiQZ+WT00GwHB
         aYuDgQMtfz8LQo2ZYvcZsWEoyUjIgFfG/nm5N8uTypzsVd/ldVZFtysNdcJQFjX6rCvw
         nC6eevSUh13f1SYnkkZCHoWbVE1pDnPel0hTzvF9UFytE9zq1neFo+T+KpOfvHJSB6ii
         IvrhhajyJTtxXEVI7dTyBgx+WYJMyxI7ky+xcQePUOO4vEstyVT2W82JaSmW7XQndrfj
         feaA==
X-Gm-Message-State: AOAM5304o/1AGlsGu79JYmz+YjiBoEmkTGHgF5cI0rrvhPwnBPCcn+Sw
        0IYKI/VNWO70jnwzoDyEMaXzMOzCzAeniePDG2yKkg==
X-Google-Smtp-Source: ABdhPJzEicUXKC8IRUX1eyH13oGOH5H9D+YWab5gHpw18rCkH0djpB34Bs4tIT7oEtNazq6NayYBCmYeqBowDsapHwY=
X-Received: by 2002:a19:cb92:: with SMTP id b140mr13260841lfg.63.1592206388389;
 Mon, 15 Jun 2020 00:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200611040453.GK12456@shao2-debian> <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
In-Reply-To: <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Jun 2020 09:32:41 +0200
Message-ID: <CAG48ez1v1b4X5LgFya6nvi33-TWwqna_dc5jGFVosqQhdn_Nkg@mail.gmail.com>
Subject: Re: [gup] 17839856fd: stress-ng.vm-splice.ops_per_sec 2158.6% improvement
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jun 10, 2020 at 9:05 PM kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > FYI, we noticed a 2158.6% improvement of stress-ng.vm-splice.ops_per_sec due to commit:
> >
> > commit: 17839856fd588f4ab6b789f482ed3ffd7c403e1f ("gup: document and work around "COW can break either way" issue")
>
> Well, that is amusing, and seeing improvements is always nice, but
> somehow I think the test is broken.
>
> I can't see why you'd ever see an improvement from that commit, and if
> you do see one, not one by a factor of 20x.

FWIW, if this is the testcase:
<https://kernel.ubuntu.com/git/cking/stress-ng.git/tree/stress-vm-splice.c>

then that testcase is essentially testing how fast vmsplice() is when
called in a loop on an uninitialized mmap() mapping. So before that
commit, I think it will create zeropage PTEs in the first iteration
(and zeropage PTEs are _PAGE_SPECIAL, see do_anonymous_page()). And
get_user_pages_fast() bails out in gup_pte_range() if pte_special().
So that testcase was always hitting the GUP slowpath.
But now the first iteration will force the creation of a normal RW
PTE, so all following iterations can go through the GUP fastpath.

So in summary I guess the test was just really slow up until now
because it was hitting a slowpath that you wouldn't hit during normal
usage? At least for vmsplice(), writing uninitialized pages doesn't
really make a whole lot of sense...
