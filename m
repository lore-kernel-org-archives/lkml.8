Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EF5C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76302469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ubod28Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgB1EEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:04:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37275 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbgB1EEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:04:41 -0500
Received: by mail-pl1-f194.google.com with SMTP id q4so701742pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 20:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Mb+GXitK62yQ1M3tJCil58KnWQatqaLnDM8GS4W1DY8=;
        b=Ubod28RtEkdJd3Hi8hDlbiGPxxGjZwfCwSKMe6XvTdS7UrCDvlPHFSFff+GMqEy7Zb
         Q+oFuYFMBgQUcCjgs82T0soaXDoq015hZAstKMxoczWTOUe8A0lZRXjnPHCovxfV2+Sm
         v6Y+hUl6G0blhj2WMfhk5ryuIP6M5HenCpqQm+dHYMH0g5ugHt5b9NtLZ+CJX4URPtgg
         pcrzVdZr+AcuI1Fyw9U2JITRbTu1O6+uwT4gzJslWavGzBscRc5XunNiwyRXEur7KnpY
         V80oIiIfR32pFodG0vwGy7Iysx+Za2rQTKhM+Rp3g6Bho0FubUtfbnfK4NmWGY1yrwTl
         Pkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Mb+GXitK62yQ1M3tJCil58KnWQatqaLnDM8GS4W1DY8=;
        b=hkRoyCSDxuoX0/dM+HijjVojbmqfqHBMg7YwZJ0E0fgdluww7dcMqhVCs0PjQUcjWE
         iXCGMKOKqtZRGGBi9noi1/qK0UAuEufbPjPdv09zWem+AhG1ayvG3zF9VW3ZHRGQI0kd
         M1B24CyJxUj/BTzMXcOOuplyIO/W57VJLDaG04mCQVJD14TadnL9yE8r851B3YeLfGzH
         f60nj+DqBHMmS1IDs8alYI3nQWfUQbIGqyB4O+NGErd6yABJnkwmu2L0KRk1eXn6UqU0
         jJYHXZsrH1rRTK1BFvIVEgtCC1+xkO3bDV3WlHrVQAtuEwNPXVm4KzUnSFIY1LvspTwp
         thaQ==
X-Gm-Message-State: APjAAAUnA7C6WcH6i/CR5taCI7Gqw0srDTnrfnsBtj4Ufe6tpCefNlp8
        x79kTjZpdI5sflf2TJskoJMNUQ==
X-Google-Smtp-Source: APXvYqxUBA5NSOQTBfmpde2KyCEtyQtJW6iPImTP/0IyPJaVGXsAJPkaOrAegBUzX1C5chqDLpOSrw==
X-Received: by 2002:a17:90a:394d:: with SMTP id n13mr2500811pjf.1.1582862679656;
        Thu, 27 Feb 2020 20:04:39 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id q21sm9241494pff.105.2020.02.27.20.04.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Feb 2020 20:04:38 -0800 (PST)
Date:   Thu, 27 Feb 2020 20:04:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] huge tmpfs: try to split_huge_page() when punching
 hole
In-Reply-To: <20200227084704.aolem5nktpricrzo@box>
Message-ID: <alpine.LSU.2.11.2002271909250.2026@eggly.anvils>
References: <alpine.LSU.2.11.2002261959020.10801@eggly.anvils> <20200227084704.aolem5nktpricrzo@box>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, Kirill A. Shutemov wrote:
> On Wed, Feb 26, 2020 at 08:06:33PM -0800, Hugh Dickins wrote:
> > Yang Shi writes:
> > 
> > Currently, when truncating a shmem file, if the range is partly in a THP
> > (start or end is in the middle of THP), the pages actually will just get
> > cleared rather than being freed, unless the range covers the whole THP.
> > Even though all the subpages are truncated (randomly or sequentially),
> > the THP may still be kept in page cache.
> > 
> > This might be fine for some usecases which prefer preserving THP, but
> > balloon inflation is handled in base page size.  So when using shmem THP
> > as memory backend, QEMU inflation actually doesn't work as expected since
> > it doesn't free memory.  But the inflation usecase really needs to get
> > the memory freed.  (Anonymous THP will also not get freed right away,
> > but will be freed eventually when all subpages are unmapped: whereas
> > shmem THP still stays in page cache.)
> > 
> > Split THP right away when doing partial hole punch, and if split fails
> > just clear the page so that read of the punched area will return zeroes.
> > 
> > Hugh Dickins adds:
> > 
> > Our earlier "team of pages" huge tmpfs implementation worked in the way
> > that Yang Shi proposes; and we have been using this patch to continue to
> > split the huge page when hole-punched or truncated, since converting over
> > to the compound page implementation.  Although huge tmpfs gives out huge
> > pages when available, if the user specifically asks to truncate or punch
> > a hole (perhaps to free memory, perhaps to reduce the memcg charge), then
> > the filesystem should do so as best it can, splitting the huge page.
> 
> I'm still uncomfortable with proposition to use truncate or punch a hole
> operations to manage memory footprint. These operations are about managing
> storage footprint, not memory. This happens to be the same for tmpfs.

I'd slightly reword that as "These operations are mainly about managing
storage footprint. This happens to be the same as memory for tmpfs."
and then happily agree with it.

> 
> I wounder if we should consider limiting the behaviour to the operation
> that explicitly combines memory and storage managing: MADV_REMOVE.

I'd strongly oppose letting MADV_REMOVE diverge from FALLOC_FL_PUNCH_HOLE:
if it came down to that, I would prefer to revert this patch.

> This way we can avoid future misunderstandings with THP backed by a real
> filesystem.

It's good to consider the implications for hole-punch on a persistent
filesystem cached with THPs (or lower order compound pages); but I
disagree that they should behave differently from this patch.

The hole-punch is fundamentally directed at freeing up the storage, yes;
but its page cache must also be removed, otherwise you have the user
writing into cache which is not backed by storage, and potentially losing
the data later.  So a hole must be punched in the compound page in that
case too: in fact, it's then much more important that split_huge_page()
succeeds - not obvious what the fallback should be if it fails (perhaps
in that case the compound page must be kept, but all its pmds removed,
and info on holes kept in spare fields of the compound page, to prevent
writes and write faults without calling back into the filesystem:
soluble, but more work than tmpfs needs today)(and perhaps when that
extra work is done, we would choose to rely on it rather than
immediately splitting; but it will involve discounting the holes).

Hugh
