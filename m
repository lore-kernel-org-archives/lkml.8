Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6391C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE12520724
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyzzVdrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgHVRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgHVRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 13:24:41 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCC5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 10:24:40 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id u6so2822381ybf.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybp0wdgwE7m9j8jixPB61E8yqwGFeg6+ew/47T57D0o=;
        b=CyzzVdrLb4+Di2Q82/n6W8bIEwv+gyrNgjc3gNatd0WH9dSMwLzeoHOQcaP2ZulTRH
         cgQlF7UrUmPBGQpFj6JM0zhCOe5UyX1rFc/wM6kXOPH4nayVKOfAhD85ilcnH/H259nq
         Q7Vn9tCeavcxyuzl48XZ+PUVb4b6ZMHKeu7tVctIoQ0405BH5xO419VnQZoOFpTX4H4U
         aKiMAvA9E0+3sRIH1CNG7ZGQy+sJPzT5c7Qtc+I8E/JYNwXl6/Gc7QOkkWe9XU1g0nFp
         LLXImfLVVFSO3AVTVcoGQymM8TIkiil6x7l6//J2gaHIOTbi3By0uzZBg2uKQfYJAQTD
         sZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybp0wdgwE7m9j8jixPB61E8yqwGFeg6+ew/47T57D0o=;
        b=dTPGQ3JM0DSy4C568UM8edauPtGZGBLgPeeZWXS0vYZyEXYrTlmcxXJMRDDgpN8QUc
         CRgDY+zj0Ds4685WLKwKmKZRAd7AE52EvAfgjXCaCtNG1UfFVvDIjeYxe67jGIKgpLGt
         jwfk2e+gMYD4pL5aVAycTSrRqy08y24WFUGxCRzcw5BWKGuuCa31VvItzfCeD3CZBj2/
         eR51YsYRPsgYfmPeFWYqcWiA2dETglAY7wLxiqtgcThFwad0ynOZc3K6MXsa1X6tAHZA
         ZMdw4L17DUK4Q2NhD2CzbWjm/74yky360SOopn/S8jKMSy9cjKI5YOgTxLs6EvmGKsKU
         CzBw==
X-Gm-Message-State: AOAM5333oEcro8VTyOdnDO6eOvSW4oVx5IVJxC1UpJlWIjN0r6s4SrHo
        7lHQWj5f1kFcLowWSlJManLWXDefErd7QFl9rjNidA==
X-Google-Smtp-Source: ABdhPJyW7KS0bCwQao0Y7XCz3TxaSaQqRZlcUsVf1D3hf/HKOKjnycp7x/ig9SIyHskner0ztnwekd1Hf7I4HNWizhU=
X-Received: by 2002:a25:ae43:: with SMTP id g3mr11157254ybe.459.1598117078768;
 Sat, 22 Aug 2020 10:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANN689HMLC4uKCjztqfZsDO7pPbsvViOQQ_HDWWYU4=8cZbKvQ@mail.gmail.com>
 <20200822163909.GR1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200822163909.GR1362448@hirez.programming.kicks-ass.net>
From:   Michel Lespinasse <walken@google.com>
Date:   Sat, 22 Aug 2020 10:24:25 -0700
Message-ID: <CANN689HSUgvJX0bH=V56YfOJ4CYKLo2KA-9GP-wghhc9td=dUw@mail.gmail.com>
Subject: Re: Lockdep question regarding two-level locks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 9:39 AM <peterz@infradead.org> wrote:
> On Sat, Aug 22, 2020 at 09:04:09AM -0700, Michel Lespinasse wrote:
> > Hi,
> >
> > I am wondering about how to describe the following situation to lockdep:
> >
> > - lock A would be something that's already implemented (a mutex or
> > possibly a spinlock).
> > - lock B is a range lock, which I would be writing the code for
> > (including lockdep hooks). I do not expect lockdep to know about range
> > locking, but I want it to treat lock B like any other and detect lock
> > ordering issues related to it.
> > - lock A protects a number of structures, including lock B's list of
> > locked ranges, but other structures as well.
> > - lock A is intended to be held for only short periods of time, lock
> > B's ranges might be held for longer.
>
> That's the 'normal' state for blocking locks, no?
>
> See how both struct mutex and struct rw_semaphore have internal locks.

Right (note that I already have an implementation of my range lock
('B') along these lines, with a low-level lock ('A') tucked into it
and all the expected lockdep support).

> > Usage would be along the following lines:
> >
> > acquire:
> > A_lock();
> > // might access data protected by A here
> > bool blocked = B_lock(range); // must be called under lock A; will
> > release lock A if blocking on B.
> > // might access data protected by A here (especially to re-validate in
> > case A was released while blocking on B...)
> > A_unlock()
> >
> > release:
> > A_lock()
> > // might access data protected by A here
> > A_B_unlock(range); // must be called under lock A; releases locks A and B.
>
> up_{read,write}() / mutex_unlock() release 'B', the actual lock, early,
> and then take 'A', the internal lock, to actually implement the release.
>
> That way lockdep doesn't see the B-A order :-)
>
> > There might also be other places that need to lock A for a short time,
> > either inside and outside of lock B.
>
> Any cases that aren't covered by the current implementation of rwsems ?

My issue is that I have other data, unrelated to B, which frequently
needs to be accessed or updated at just the same points where we are
acquiring or releasing B.

(to go into use cases: that data would be the vma rbtree and per-MM
statistics; one may want to find a free gap between vmas before range
locking it, or take vmas in and out of the rbtree as we acquire or
release a lock on the corresponding address range, etc...)

As the accesses to that data tend to naturally align with the places
where we take or release the B lock, it is tempting to expose A to the
caller so that A can protect additional data not directly related to
B. It seems like changing B's internal lock into a public one which
the caller would take and release explicitly around B calls would be
straighforward, but it causes issues as lockdep doesn't understand
that construct...

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
