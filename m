Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB550C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9821F206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNVx1F/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHJV5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:57:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58670 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgHJV5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597096659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rrVdSaYVQuSZaYpG06W8M6IlfIos1BW3RVd4O0RIQqk=;
        b=fNVx1F/ZhADn/GgLM8o0KhtIc6NP+kY4A221EfzoOSHgSxSlsCMqkBUWDZrXhIHuwZ8SYs
        DzUbd60FsJhttuEQ4D48ghltleNXlGYj74GJwZ/iQoit/AjuQ9XgIFDps7Qu6T+4K7Uo5f
        KMJoQU1CVSufNzjc7igsePvXyy75ObU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-MwDMFkR5NUmgQwiyrP-_Ng-1; Mon, 10 Aug 2020 17:57:37 -0400
X-MC-Unique: MwDMFkR5NUmgQwiyrP-_Ng-1
Received: by mail-qv1-f72.google.com with SMTP id x4so8191605qvu.18
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rrVdSaYVQuSZaYpG06W8M6IlfIos1BW3RVd4O0RIQqk=;
        b=qiB5nl50POvbHUBNym0WRoR35cyZLIiJseuhTi08aoa8AixP1lsxSCrvuTYXJrFeJa
         6R1gEwUTYQiFlcmJzmRqITFm58g8ROOetFomOjBRoOx1rHP88bS5ZunU+hmAHNvpeWyI
         4YDoOcb6cfSTJZ5s8HsREavV7nzFYeucU1YDiyvsVHW/f6vn54JpJpLlHZ1Q5l9RDSsW
         9VW5tvEZvFMdidAfpg6v3yGkAiX13wkouylv8Pq1mB+qhV8kK9NdMEPFDgZrKEM2vHUA
         MxmgvjDrSBpdugKkpflgpEHrqBtdnGuouD3n2t/OGunZ+LGWoJnRKzHbTVhx3wh1/Fre
         Bt+Q==
X-Gm-Message-State: AOAM5336SLBM9/WKrqrNbXyBaKkEAu60b6HUdRwHck2PreFFIsbc2+nG
        3F/uaKPSihJOV06zKJ1VcQ6837slNaS0JmjI9hFYbVax6Phh/k+oaMCadAILjukl3gl0YTz0ZkH
        spCZS7MTfEvKWkdvzeB9a6a8N
X-Received: by 2002:a05:620a:1645:: with SMTP id c5mr28344111qko.309.1597096657399;
        Mon, 10 Aug 2020 14:57:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL++O3tbNSZgbsZ6wKkssmM2YzFk+UuTBx2EmQdLa+lDoc8EZTSoolq7jOnyUk4/5CXJu4fg==
X-Received: by 2002:a05:620a:1645:: with SMTP id c5mr28344081qko.309.1597096657008;
        Mon, 10 Aug 2020 14:57:37 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id d57sm17386554qte.91.2020.08.10.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:57:36 -0700 (PDT)
Date:   Mon, 10 Aug 2020 17:57:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200810215734.GB132381@xz-x1>
References: <20200810145701.129228-1-peterx@redhat.com>
 <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
 <20200810191520.GA132381@xz-x1>
 <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 01:51:49PM -0700, Linus Torvalds wrote:
> On Mon, Aug 10, 2020 at 12:15 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > My previous understanding was that although COW is always safe, we should still
> > avoid it when unnecessary because it's still expensive.  Currently we will do
> > enforced COW only if should_force_cow_break() returns true, which seems to be a
> > good justification of when to ask for the enforcement.
> 
> It's not the _enforcement_ I worry about.
> 
> It's the _users_.
> 
> So COW is always the safe thing to do, but as you say, it can be
> expensive (although we actually seemed to get a robot that claimed it
> sped up some test benchmark, it wasn't clear why).
> 
> But because not breaking COW can be very subtly unsafe - considering
> that we had this behavior for over two decades - I think the users
> that decide to not break COW need to explain why it is safe for them.
> 
> See what I'm saying?
> 
> That's why an explicit  FOLL_READ_WRONG_SIDE_COW_OK flag would be
> good, because it would force people to *think* about what they are
> doing, and explain why it's ok to do that unsafe thing, and get a page
> that may actually end up not being your page at all!

Disregarding the name that we'd prefer, I thought the new flag should only be
used internally in GUP just like FOLL_COW, or am I wrong?

Now FOLL_BREAK_COW (or whatever we'd like to call it) is applied as long as for
FOLL_PIN and FOLL_GET irrelevant to who calls __get_user_pages().  Shouldn't
that be enough that the new flag will be applied correctly always?...

I'd be fine if you want me to rename the flag into FOLL_READ_WRONG_SIDE_COW_OK.
It's just a bit awkward to read and check, because otherwise for the COW path
we'll need to use "(FAULT_FLAG_WRITE || !FAULT_FLAG_READ_WRONG_SIDE_COW_OK)".

> 
> 
> > + * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read).
> > + *                        Please read FOLL_BREAK_COW for more information.
> 
> This comment is useless - because it's aimed at the wrong people.
> 
> It's aimed at the people who already know they want to break COW. They
> understand, and they are doing the safe thing.
> 
> The case I worry about is the people who do NOT say "break COW". Not
> because they are smart and know what they are doing, but because they
> don't think about the issue.
> 
> > Userfaultfd-wp should not care about this because it's not a write operation,
> 
> Ok, I will *definitely* not be applying tyhis patch, beause you don't
> even understand what the problem is.
> 
> The fact is, A READ operation that doesn't break COW can GET THE WRONG ANSWER.
> 
> Why?
> 
> If you have two (threaded) processes A and B, who have that shared COW
> page, what can happen is:
> 
>  - A does a READ operation using get_follow_page, and gets the shared page
> 
>  - another thread in A ends up doing an unmap operation
> 
>  - B does write to the page, and causes a COW, but now doesn't see the
> A mapping at all any more, so takes over the page and writes to it
> 
>  - the original get_follow_page() thread in A is now holding a page
> that contains data that wasn't written by A
> 
> See? That's the whole point. It doesn't _matter_ if you're only
> reading the data, without the COW you may be reading the _wrong_ data.

Yeah, that's why I totally agree we need to do enforced COW even for a read gup
as long as the page can be further referenced (GET|PIN).  However frankly
speaking I didn't follow the rest on what's wrong with "Userfaultfd-wp should
not care about this because it's not a write operation" that I mentiond.  Is
that the major part of the objection?

I'm afraid I still think that's the right thing to do...

Could you help elaborate more?  It would be better if you can help to point out
the code changes that are wrong or suspecious, maybe that'll help me to
understand what I might have missed too.

Thanks,

-- 
Peter Xu

