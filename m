Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C80C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA81206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guONlS+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbgFRWWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgFRWWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:22:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB45C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:22:34 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id l26so5563544qtr.14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ij26VoyzhYGvLjAG21TvPgeZf+MNFhcxJkH7FR67BL4=;
        b=guONlS+zDvIwKKVsdiiPKNH7/eiTgu2dN+5fua4h7UfSizaHOrh8PHvEFcbioXU0UE
         s48UzvSNhVC6diNscyJjApImeqZRrbqiKamhkJipt5yFN2Kn8NDTYNWwObqjqxlh3tAw
         QHa0E/9PRSzQDQYhqBbFLle/SXijKCDIA0zzWc3XHyAGq5qVvT8cyZ0rGKKypA+/bQDO
         hUAa51FtVs70IN0xsiqETb3j9NfIC6deYVTKb2RtekE4VwtYibPz8Tj4lR6ck1pfQIv8
         RtW2uLTOACEyOBvfTQJF4CqCiSIEJlTMR1AUn9awEU+Ez1WvYKQHHOuW7rpaY6v8UDGD
         9ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ij26VoyzhYGvLjAG21TvPgeZf+MNFhcxJkH7FR67BL4=;
        b=rvKjFQxCtRl2TuRu2Vm929EnYC0LMPNyn0nomGPChuw4eJINcDexrBLdHd+qAt7hJg
         ksGmBbQbkNGEqJZp6pryxdSGH5VtZS/JAByEw6+I/3wCekaF21qbQvgfphxNjO5VF0OE
         VzbTxw+TY2h3+TVNhhrKcgZP7bsHhwhq4hetuZVLeyzybQyp8TUkEvndA9ndLbX/Zz98
         Jv49C+CPh3ETSrCMsUFRWdXzovBqEvpbSWdMHM2lESRZXyNfkf7Nv59Dp41RukxqvR4G
         J8zLc1OZaAKKnUb9EQ8RG/9rKQlCHxDLM5Uux+ftymp6sW4KSvrXxu5pzCy0yUkDSW6g
         Ufzw==
X-Gm-Message-State: AOAM531+zm65M4JYy7LqNntuHM7TWk2zpnYVL878YJuKa1Z63hwu6/Oe
        GhA9LgCzMbSctARjcSBBRbLCnb0xrfGAgwQ3SbpN
X-Google-Smtp-Source: ABdhPJz8sjdhRA7XEQ+5GTNRGsSav0+5iQXsihIkL9r3Dui8VuzBELYDV00aZJCPsZUBQ3sWLkOwIlnWDqJfmRIMVRsS
X-Received: by 2002:a0c:e385:: with SMTP id a5mr6091856qvl.218.1592518953173;
 Thu, 18 Jun 2020 15:22:33 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:22:24 -0700
Message-Id: <20200618222225.102337-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [RFC PATCH v3 0/1] Add rwsem "contended hook" API and mmap_lock histograms
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Michel Lespinasse <walken@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Adams <jwadams@google.com>,
        David Rientjes <rientjes@google.com>,
        Ying Han <yinghan@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overall goal of this patch is to add tracepoints around mmap_lock
acquisition. This will let us collect latency histograms, so we can see
how long we block for in the contended case. Our goal is to collect this
data across all of production at Google, so low overhead is critical.

I'm sending this RFC for feedback on the changes to rwsem.{h,c} and
lockdep.h in particular. I'll describe reasoning for the down_write case,
for brevity.

We want to measure the time lock acquisition takes. Naively, this is:

u64 start = sched_clock();
down_write(/* ... */);
trace(sched_clock() - start);

My measurements show that this adds ~5-6% overhead to building a kernel on
a test machine [1]. This level of overhead is unacceptably high.

My measurements show that only instrumenting the contended case lowers
overhead to < 1%. Naively, we can instrument only the contended case like
this:

if (!down_write_trylock(/* ... */))
	/* Time and call down_write as before. */

However, in the case where `_trylock` succeeds, we have lost the lockdep
annotations (e.g. around ordering) `down_write` would normally include.
(Granted, we don't run with lockdep in production, but debug builds do.)

Assuming we need lower overhead, we aren't okay with losing lock
annotations, and we reject various alternatives to this patch:

- Making rwsem.c's __down_write and __down_write_trylock public, so
  mmap_lock.c could construct its own version of LOCK_CONTENDED with
  tracepoint calls.
- Having mmap_lock.c reach into rwsem.c's internals with "extern" forward
  declarations for these functions (and removing "static inline").
- Somehow adding the instrumentation directly to rwsem.c (either affecting
  all locks, or polluting it some other way).

The remaining alternative, I think, is what this patch proposes: add API
surface to rwsem.h which allows callers to provide instrumentation
callbacks which are invoked in the contended case.



[1]: For measuring the overhead of the instrumentation, I've been timing a
defconfig kernel build. The numbers above come from a KVM instance with
4 CPUs + 32G RAM, running 5.8-rc1 with this patch applied and a histogram
trigger configured for the acquire_returned tracepoint. My test script is
simple:

for (( i=0; i<5; ++i)); do
        make mrproper > /dev/null || exit 1
        make defconfig > /dev/null || exit 1
        sync || exit 1
        echo 3 > /proc/sys/vm/drop_caches || exit 1
        /usr/bin/time make -j5 > /dev/null
done

The numbers I'm giving above are computed as:
(avg of 5 runs with this hist trigger enabled) / (avg on 5.8-rc1).

Axel Rasmussen (1):
  mmap_lock: add tracepoints around mmap_lock acquisition

 include/linux/lockdep.h          |  47 ++++++
 include/linux/mmap_lock.h        |  27 ++-
 include/linux/rwsem.h            |  12 ++
 include/trace/events/mmap_lock.h |  76 +++++++++
 kernel/locking/rwsem.c           |  64 +++++++
 mm/Kconfig                       |  19 +++
 mm/Makefile                      |   1 +
 mm/mmap_lock.c                   | 281 +++++++++++++++++++++++++++++++
 8 files changed, 526 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/mmap_lock.h
 create mode 100644 mm/mmap_lock.c

--
2.27.0.111.gc72c7da667-goog

