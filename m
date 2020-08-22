Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF273C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8468320738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhTHZDNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgHVQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgHVQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:04:27 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55853C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:04:26 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id y134so2744503yby.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Rp7rpGcAxodjWbwNRUMx6ahwYwXjj8p9E0g+pjCg/jA=;
        b=nhTHZDNIzlwzfVLKTFsmHNjZcCZ1X4mTAwxjqwQTh/quOJrOZr0NGC3lmb0/Mw98Cu
         UMS9tY4OrNGMbG0sBKnfeD7BqhMff8JjY7AkoBYamIv2vczQLISuUxKQbGN1R7/gZ7b9
         8GoUh8nYfp0K5qpy2ARjPEcFPlTn9+BlaW1JHspKNyPcTkzfHwqDE31QGfwRAt+82OHU
         OcPgwnmK1f1lzExfRuII2/+jMR2rrLz2NuTlKB78ktiNxe6pPPKv28/BMtbcyevKV9rT
         Sxg9ok2O2l9mLtVf8iAZXkRcBTircBUOj2UE7E1AChg6U3bJcsttTnD4HrwGKO+ctTey
         JtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Rp7rpGcAxodjWbwNRUMx6ahwYwXjj8p9E0g+pjCg/jA=;
        b=d8q1tbSrk8FlErIcynSpyYM15jRupedBPfMMpt7uLbEtRh1DQ+mpBFSEFAExlFtchg
         a75xARvmar0h/H01vuSrGKs7gQ95JInIgkjqA5QEEVbZOEWLrdBwIzJYfu98aLXgCXuE
         VwPeNNLc/Yd1UaHKDuhamk02jFa6GPc7oE4rQwNMCXlSp7Uj2USqq2dhwKJJ95hGBa67
         OQnXVIKiI/01q2uumZ8J4PZX9CoFSm/jfsEPqVrD/2AZU7icswK9XzT/Gc2ve9BBP+0K
         A6SWVEtCTHstJM2YNBG8mRUKpqom3g83ZlNtfLGayIZDyw4IyGL+JjRV9DN7ZId0WhaZ
         ytSQ==
X-Gm-Message-State: AOAM531rrPOTqp/Po6rEXeZ3HtCkAWOohRB/7uowvs2KY5z3y3+KECrN
        KjclfmhqIamC+YgUtEJJD0mBvKoirggQMZ2gIYmPI+Xub/ZXIGrB
X-Google-Smtp-Source: ABdhPJzoRMVCj6eKOqvwqI/cKEwCbW4UyionF95pE5MgwNypsK3iR50KUdfkRpXnKSaMzawiKTGWxo1NF4wO86yHj5w=
X-Received: by 2002:a25:ae43:: with SMTP id g3mr10800828ybe.459.1598112261845;
 Sat, 22 Aug 2020 09:04:21 -0700 (PDT)
MIME-Version: 1.0
From:   Michel Lespinasse <walken@google.com>
Date:   Sat, 22 Aug 2020 09:04:09 -0700
Message-ID: <CANN689HMLC4uKCjztqfZsDO7pPbsvViOQQ_HDWWYU4=8cZbKvQ@mail.gmail.com>
Subject: Lockdep question regarding two-level locks
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am wondering about how to describe the following situation to lockdep:

- lock A would be something that's already implemented (a mutex or
possibly a spinlock).
- lock B is a range lock, which I would be writing the code for
(including lockdep hooks). I do not expect lockdep to know about range
locking, but I want it to treat lock B like any other and detect lock
ordering issues related to it.
- lock A protects a number of structures, including lock B's list of
locked ranges, but other structures as well.
- lock A is intended to be held for only short periods of time, lock
B's ranges might be held for longer.

Usage would be along the following lines:

acquire:
A_lock();
// might access data protected by A here
bool blocked = B_lock(range); // must be called under lock A; will
release lock A if blocking on B.
// might access data protected by A here (especially to re-validate in
case A was released while blocking on B...)
A_unlock()

release:
A_lock()
// might access data protected by A here
A_B_unlock(range); // must be called under lock A; releases locks A and B.

There might also be other places that need to lock A for a short time,
either inside and outside of lock B.

The correct lock ordering here is that lock A can be acquired while
holding lock B. However, the acquire sequence here seems to violate
that, as A must be locked before B there. In reality, the usage
pattern does not create circular dependencies, because lock A would be
released if blocking on lock B. However, I am not sure how to convey
that usage pattern to lockdep.


A few options I am considering:

- Is there a way to indicate to lockdep, in B's locking function
definition, that I am acquiring B after A but really want the lock
order to be registered as A after B, since I know how to avoid the
circular dependency issue by releasing A if blocking on B ?

- B's locking function definition could tell lockdep that B was
acquired with a trylock. This avoids lockdep reporting a lock ordering
issue between A and B, but also will make lockdep ignore lock ordering
issues between any other lock and B. So this is not a proper solution,
as we may just as well not implement lockdep support in lock B in that
case.

- B's implementation could, when lockdep is enabled, always release
lock A before acquiring lock B. This is not ideal though, since this
would hinder testing of the not-blocked code path in the acquire
sequence.

Would the lockdep maintainers have any guidance as to how to handle
this locking case ?

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
