Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA262C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B15020738
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596589184;
	bh=UkmSP1/gzVDZLMhX1opuIDre7K9FcheyRSPjB3OONZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0mMOmhCmE24RhMZLal2y3IV9vvr2f3ArZidnZ7dMn8M5ImY/BtDwSm+pZmZuSKh8s
	 7U5mgLo6DR05ETNqd//4KkzRVlifwuIg1NuAoITDE+hyTWvPe12+lqUT1/Xas427VT
	 ACctzrb8f8nMspYs/UjbF6uEnLP29nHB7nkdAyFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHEA7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgHEA7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:59:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D122BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 17:59:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so15383144ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 17:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YYfu/xgqz693Pt83ni1NU1MOzFWnsY8KnwOFU/Zl6A=;
        b=f1LzaY3GjRLDZfh/pp3L7AVVdORSAFkxKPjEHMAjL80Ldta1l+NmN2t1CgEtrONHX/
         5EmF1CDUDw2K4dMeNGZqiu9wEFUjDbI7wGBuGYsY+EMRcOgeIQR2ShAbUxp6mfENVgKT
         LWHdMODRUg+SWk/4f7SrbDA2DNN5fymN/yt+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YYfu/xgqz693Pt83ni1NU1MOzFWnsY8KnwOFU/Zl6A=;
        b=SlpeRHDyy+y4PZDZ1xZ3jS5DKeiZl+zAoFngx64EulQpR2TmCeBfzQn6Qg7BYpCCkb
         58SdEvP/KYmSylnYEYFxlgTGixXvPtlnzVob9oOqxZZ9RxJQkDR+4p+3c+s+Ex8Vzo0o
         sv/M7It+4XSUGetDFpektOzL4QOFti09ugOpThqP3NU/RYtKewrY3PrWRxWmQYZG6CPV
         AiMXzewAnqhA1gLYRnHSSJM3+D7zlEuYIAR84RmFkF1if/5+qk8JZaVpsOfJnQLGjXIm
         Y2+trZSqoLJhG7hkpMBtJu7JCn1upm8V6inqi6TrYea7x2tsjYndfIcRyn628vNHw3eR
         MGRQ==
X-Gm-Message-State: AOAM533t+5vha2hRr6qyHY2CZrtZS+R/7xjXU2oKIP6odO4QkMGTn5Og
        VfHpYH4a5ZmjPCknQgFZOkJjXdYtz3U=
X-Google-Smtp-Source: ABdhPJytSBE+2ViJcRICcnyMb7Z6rHFN2nTiM0WMD3WFqRdt5ejRaHYcKllN6GKut6gwoDDXykSVgA==
X-Received: by 2002:a05:651c:1b4:: with SMTP id c20mr195016ljn.432.1596589177048;
        Tue, 04 Aug 2020 17:59:37 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 72sm303135lfh.97.2020.08.04.17.59.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 17:59:36 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id t23so22198820ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 17:59:35 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr168790ljk.421.1596589175449;
 Tue, 04 Aug 2020 17:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200803140726.GA752014@infradead.org> <CAHk-=wg1h_XfPbXvisfAUsXU-WiOeCJDUibhxZGu=x9w-VKB0A@mail.gmail.com>
In-Reply-To: <CAHk-=wg1h_XfPbXvisfAUsXU-WiOeCJDUibhxZGu=x9w-VKB0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 17:59:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9dzJOkvysjgdHv5eFJU76EFAwCxNenRxTtq6VWof98Q@mail.gmail.com>
Message-ID: <CAHk-=wg9dzJOkvysjgdHv5eFJU76EFAwCxNenRxTtq6VWof98Q@mail.gmail.com>
Subject: Re: [GIT PULL] configfs updates for 5.9
To:     Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 5:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The commit is completely confused and wrong.
>
> In particular, this part:
>
> +       /* Only commit the data if no more shared refs to file */
> +       if (file_count(file) > 1)
> +               return 0;
>
> is bogus and prone to races, meaning that if there are multiple
> openers, *none* of them flush.

Side note: this made me worry that this is some kind of pattern, so I
started grepping.

It isn't, thankfully. But I do notice that st_flush() has the same
bug, probably going back to forever.

In fact, that bogus use may be going back so far in time that it might
even have been almost ok. Back when we had the big kernel lock, the
fundamental race wasn't so fundamental, although it is still true that
it could possibly have been mixed up by other non-file references (ie
code sequences doing get_file() on it without ever doing a real
open/close).

I have to say, I cannot find it in myself to care about SCSI tapes and
possible races with multiple concurrent openers or whatever.

So I'm cc'ing the appropriate authorities, but I don't really expect
the bogus code in st.c to go away.

It _is_ very wrong, though, and I very much don't want to have new
cases of that wrongness.

For another example of where "file_count()" isn't reliable or useful
at close() time, you can have any of mmap/io_uring/proc and probably a
number of other cases do get_file/put_file to get a refcount on the
file that can remain active even after the last user has actually
closed it.

And yeah, maybe mmap() doesn't end up being relevant for these file
descriptors, but things like /proc/*/fdinfo/* are possible for all
files, and do that refcount increase exactly to avoid races.

So again, doing that

        if (file_count(file) > 1)

kind of check is very very wrong even outside of the fundamental race
with two close() calls at the same time.

It is a very dangerous pattern, because it likely works in practice
during testing, and looks like it might work.

But it is completely and unfixably wrong.

Again, the only reliable way to do that "last close" is "->release()",
but you will never get errors from that, since (for all the same
reasons) it might not even be done by a close. The last releaser of a
file descriptor might be that mmap/io_uring/proc case now releasing
the no longer used file, possibly long after the last "close()" call
has happened.

One acceptable half-way measure *may* be

 - do the flush with the above bogus test at ->flush() time, knowing
it might never trigger at all

 - do the flush *again* at ->release() time, in case it didn't trigger

 - add a big comment to the flush-time case to show you understand the
issue, and understand

but I'd discourage it because of how unreliable it is.

              Linus
