Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC3A20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597092732;
	bh=Cth0CWbvqYIM1JxO5iU265LG31HU3abJyzeQFu17Xpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PPP7RYxc25z6P7mABWIcOEgrezH8qBAgWSWC31fJc3TdKVZ7ufuWgqhQ5qa4ZQfNs
	 PvBOe3DxpBc+6g6DgE6O7m2saDNCRXdnJ/97a4tiF+3PQlNtpD+Q6dlShhjM6cuudw
	 dHrU6X6Wf33J4kjD9vwc2ZacpKl0LuryKxYdSmbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHJUwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgHJUwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:52:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7C3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:52:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k13so5481432lfo.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPJOh2B8UqnDROYW3i9xOwYOYe8010p4GwF3JyYBmy8=;
        b=hwkEnHVPA+E+9rkWzxh4lStANcEMn0x+5pjB22oF01Rz3n6+aP273yOuBXeeH3qMZe
         wPV09IiK4VXqZDapL26ueSiQQ4i5VUG9H0Kl7MMigWmoKc//lQ+l4m/Ht/uMiYggKITQ
         xN83E6le55ewRr20mhhX/QL7u0YnKvAzApwbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPJOh2B8UqnDROYW3i9xOwYOYe8010p4GwF3JyYBmy8=;
        b=jz5DhAd2yiGWQe6J6xPjGQMaLF8HWIEWcRYevtW+5ryQbrlA7p0OBj/k6E6TY0Mcqr
         0g/dEeDwVh1C1sAbOcYiC4ZtdJdjAk6D5Bd/VL8+uFxknvGNqzqo/snXpqEg9Nule7YL
         kyRNavs8ekctGiU2sZjtRL7kQsEoaXHnCxWmsnpQb+gzzE+q5qkqYZOdJJWKaanOR9+9
         APfUXaBefGyxH+tDUS6W7Hqx3An0hW+EsQe6S/QKDwPKtcBNI97ZVmzWNSC24BrAcsoX
         FaBoWtop6pf9pz+Teqc5VpJ0J2NoXdh1ofWLanpD3j7yl/Mt3e+31KdfvCmWRSGCZOWM
         HC5A==
X-Gm-Message-State: AOAM5317VKHlKyVUZUMHG/fdiPow/ffpuoX3KHG2xhNBaH0JompAph/9
        qKSkn3X/5Yvw0uM3rLqGCvWst6ifdNs=
X-Google-Smtp-Source: ABdhPJz/SwlF5UCKPJuOrltMPneAWkpYaZ6dMfDhUNrrZX8fAsulbfzWj5zj78f07jXvU6ZWkeeftw==
X-Received: by 2002:a19:644:: with SMTP id 65mr1466506lfg.203.1597092727038;
        Mon, 10 Aug 2020 13:52:07 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id e19sm7976242lfc.7.2020.08.10.13.52.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:52:06 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b30so5465183lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:52:05 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr1452946lfo.125.1597092725337;
 Mon, 10 Aug 2020 13:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200810145701.129228-1-peterx@redhat.com> <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
 <20200810191520.GA132381@xz-x1>
In-Reply-To: <20200810191520.GA132381@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Aug 2020 13:51:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
Message-ID: <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
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

On Mon, Aug 10, 2020 at 12:15 PM Peter Xu <peterx@redhat.com> wrote:
>
> My previous understanding was that although COW is always safe, we should still
> avoid it when unnecessary because it's still expensive.  Currently we will do
> enforced COW only if should_force_cow_break() returns true, which seems to be a
> good justification of when to ask for the enforcement.

It's not the _enforcement_ I worry about.

It's the _users_.

So COW is always the safe thing to do, but as you say, it can be
expensive (although we actually seemed to get a robot that claimed it
sped up some test benchmark, it wasn't clear why).

But because not breaking COW can be very subtly unsafe - considering
that we had this behavior for over two decades - I think the users
that decide to not break COW need to explain why it is safe for them.

See what I'm saying?

That's why an explicit  FOLL_READ_WRONG_SIDE_COW_OK flag would be
good, because it would force people to *think* about what they are
doing, and explain why it's ok to do that unsafe thing, and get a page
that may actually end up not being your page at all!


> + * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read).
> + *                        Please read FOLL_BREAK_COW for more information.

This comment is useless - because it's aimed at the wrong people.

It's aimed at the people who already know they want to break COW. They
understand, and they are doing the safe thing.

The case I worry about is the people who do NOT say "break COW". Not
because they are smart and know what they are doing, but because they
don't think about the issue.

> Userfaultfd-wp should not care about this because it's not a write operation,

Ok, I will *definitely* not be applying tyhis patch, beause you don't
even understand what the problem is.

The fact is, A READ operation that doesn't break COW can GET THE WRONG ANSWER.

Why?

If you have two (threaded) processes A and B, who have that shared COW
page, what can happen is:

 - A does a READ operation using get_follow_page, and gets the shared page

 - another thread in A ends up doing an unmap operation

 - B does write to the page, and causes a COW, but now doesn't see the
A mapping at all any more, so takes over the page and writes to it

 - the original get_follow_page() thread in A is now holding a page
that contains data that wasn't written by A

See? That's the whole point. It doesn't _matter_ if you're only
reading the data, without the COW you may be reading the _wrong_ data.

So no. I will not be applying the patch, because you apparently didn't
understand why reading needs to do a COW.

                     Linus
