Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D892C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBBA20880
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582572306;
	bh=oOHszlFOWqPiyt7YKu8OaN+K9VdXOHs5FHSBtf09JQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jiHK7siUCscZuz/+BOw6BaDSyInyrprVXXPJrF0eptthZ7XadQTmcsYOcT1dxqxVs
	 Siv/k80pav5H89AHkrLOLcu0dJ6FYwLVL+g+kRv7f8EjaDmrehCNbYIqQvpwohccwD
	 sPohdBg5hSztE4Wqvfkt/jTuPqa0KoFV+/RQbpyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgBXTZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:25:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39892 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgBXTZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:25:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id o15so11421409ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 11:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkBEZqoYeZRU9zAFFfaGS/Ens+5XAQcsdMi1hRbDEjU=;
        b=TEpip/KxpfTePdoxkcjMZ2k+46V6eI6LlNweXrNIhk1dDRSJIB/0kn/V41qVyUU+zr
         x7dnlImwIwzLh76rHY8T78rJknkbNPh6/q8YAbC+9x0e7PF46Vr0tG4pysFQcLdFGJAH
         MIu075l9fksHpt2XTuTviZ1m2Wvk4aNIp18TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkBEZqoYeZRU9zAFFfaGS/Ens+5XAQcsdMi1hRbDEjU=;
        b=tqGct6YYB4ReisFr5HUIWjBkd6oQCgGd0foGDONxw8BuZdiXmCKZtOGK9bDJu2W2LK
         fB+b/XUhfruLO4H0RI0BjPycU+Bz+oYK/9m2+dV8JN3B/yv8DgCAigyMXtI0SnJNFXSu
         k1zqyyGk/KmUNJeSEZlmkSad7+FIhC3HEjdswNV1wuIS7tLSI9q1ApzutxPuaE+jw8RT
         PKujJY8RfW2JUaF/3E/mZagKK2ULOJ0BSXGKqtmqtMp13h04/rR2d8bMU++8Xm/HCnnN
         2yaLX3LarOhAH5PCY8yXmwHFggy8CJNxUDcZCojQ89SnlQWDtB1eJXiB9LKvmLiEq6kt
         YGyg==
X-Gm-Message-State: APjAAAXDgzdbWsTjZpdWvIVCQAE9yIeKajBd9At41QMkieUe+PyVWDAm
        FpeoP8VOrBnKt9KIz2Dh6bVVeO3nY8w=
X-Google-Smtp-Source: APXvYqzKvUx9NQ6dYbfgApvCCtdW9gkyQdaDD0GXlF0Scoah4Pf0x/5vVw2/w98CKyddFMW2vUBT3A==
X-Received: by 2002:a2e:580c:: with SMTP id m12mr31247427ljb.252.1582572300707;
        Mon, 24 Feb 2020 11:25:00 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id v2sm6080986lfo.6.2020.02.24.11.24.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 11:24:59 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id n25so7658840lfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 11:24:58 -0800 (PST)
X-Received: by 2002:a19:6144:: with SMTP id m4mr1295169lfk.192.1582572297965;
 Mon, 24 Feb 2020 11:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20200205123216.GO12867@shao2-debian> <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com> <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com> <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com> <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com>
In-Reply-To: <20200224021915.GC5061@shbuild999.sh.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Feb 2020 11:24:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
Message-ID: <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 6:19 PM Feng Tang <feng.tang@intel.com> wrote:
>
> > What was it without the alignment?
>
> For 5.0-rc6:
>         ffffffff8225b4c0 d types__ptrace
>         ffffffff8225b4e0 D root_user
>         ffffffff8225b580 D init_user_ns
>
> For 5.0-rc6 + 81ec3f3c4c4
>         ffffffff8225b580 d types__ptrace
>         ffffffff8225b5a0 D root_user
>         ffffffff8225b640 D init_user_ns
>
> The sigpending and __count are in the same cachline.

Ok, so they used to be 32-byte aligned, and making it 64-byte aligned
changed something.

None of it makes any sense, though, since as you say, the two fields
you see having cache movement are still in the same cacheline.

The only difference ends up being whether they are in the first or
second half of the cacheline.

I thought that Cascade Lake ends up having full-cacheline transfers at
all caching levels, though, so even that shouldn't matter.

That said, it's a 2-socket system, so maybe there's something in the
cache transfer between sockets that cares which half of the cacheline
goes first.

Or maybe some critical-word-first logic that is simply buggy (or just
has unfortunate interactions).

I did try your little micro-benchmark on my desktop (small
8-core/16-thread 9900K CPU, just to verify the hotspots.

It does show that the fact that we have *two* atomics is a big deal:
the profiles show __sigqueue_alloc as having about half the cost being
that initial "lock xadd" for the refcount update, and a quarter being
the "lock inc" for the sigpending update.

The sigpending update is cheaper, because clearly the cacheline is
generally on the same core (since we just got it for the refcount).

The dequeuing isn't quite as clear in the profiles, because the "lock
decl" is in __dequeue_signal(), and then we have that free_uid ->
refcount_dec_and_lock_irqsave() chain to the 'lock  cmpxchg' which is
the combined lock and decrement (it's basically
refcount_dec_not_one()).

The rest is xsave/restore and the userspace return (which is very
expensive due to the Intel CPU bugs - 30% of all CPU cycles are on
that stupid 'verw').

I'm guessing this might be another thing that makes Cascade Lake show
things: maybe Intel fixed the CPU bug, and thus the contention is much
more visible because it's not being hidden by the overhead?

ANYWAY.

Considering that none of the numbers make any sense at all, I think
that what's going in is (WARNING: wild handwaving commences) that this
is just extremely timing-sensitive for just _when_ the cacheline
transfer happens, and depending on pure bad luck you can get into a
situation where the likelihood that there's a transfer between the two
locked accesses (particularly maybe on the dequeuing path where they
aren't right next to each other), so instead of doing both accesses
with the same cacheline ownership, you get a bounce in between them.

And maybe there is some data transfer path where the cacheline is
transferred as two 32-byte transfers, and if the two words are in the
"high" 32 bytes, it takes longer to get them initially, and then it's
also likelier that you end up losing it again between accesses.

Yeah, if we could harness the energy from that handwaving, we could
probably power a small village.

I don't know. This does not seem to be a particularly serious load.
But it does feel like it should be possible to combine the two atomic
accesses into one, where you don't need to do the refcount thing
except for the case where sigcount goes from zero to non-zero (and
back to zero again).

But is it worth spending resources on it?

It might be a good idea to ask a hardware person why that 32-byte
cacheline placement might matter on that platform.

Does anybody else have any ideas?

                Linus
