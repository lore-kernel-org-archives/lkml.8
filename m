Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7D12073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593016636;
	bh=EAQvVuKoFFR8by9QDcgCPxQQ6QeUaSzOqzGExTCodow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KPSoESzsYA0rmUNqQpDXiorUOty9nn1NfgmrIvlXJtTrBp1bC6Ct2PDn2He11Esi8
	 QBc1/fk09yeMDYf/3Xa3FvD2bbeKWSPupLpRVR7eCCcckCxqFC6L4U7tpH3YJ9X78N
	 jNqd2cjTGaSQxxY0h7gJNfj31l5Rx67hT84Xdq0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404625AbgFXQhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404107AbgFXQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:37:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496DDC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:37:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c11so1620776lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62Xj7hKS4iEXybqtWTP7dnf8W0/FDnwKOHv5t4Clvfs=;
        b=A9ZFAvp+DcDIrnvTU7ulPWhWIMO3wpzNjYwLVpIwktgIf91CDC5v94hx9IjsgdxhKe
         ck2W2i/2sarX6PKxigSzQRGWCEorMt9AcZ6ZgA5tzNeH/lALioTZVQeUYVoYwxg1Hbzt
         N5fF8GVFnnWgnj2iINWgizdaygBT4g2zP7QNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62Xj7hKS4iEXybqtWTP7dnf8W0/FDnwKOHv5t4Clvfs=;
        b=bT/LzaJAKrbzrS+OPnK4vh2bm/JPewMjbgEu9B9/EASZ4nbpshlkKstpXbOILd/TTv
         m0z2JWwenfcDZDV+6SLcYpSg8HL/Dix/70pnVqBIeDSrf2dO7XfiL48auUpJ55BMfsx3
         vVQnhTKbcMsSzfU/8I72pkvD4zb+tcjBm/UyUEJjfjjTHelfHntPKfrynioWDh20P0Wg
         u1KSyYAmH0nRoj9Q1LwYaB/4qg+ExbbfbyYfFfAQysCjtDQkpwKYnGrsyt6eFuWy902e
         OiJ011o6/97YwZiCFYSWi2GrRyXquDJjm41N9Th4nepdiK7quuJCqX4A8TpNBuPdQp3Q
         wKPQ==
X-Gm-Message-State: AOAM533kPK1EHZm3dn5iF4zqJBDOh6nbmYwk76u9YZCynVjzuNyKb0Cz
        MwSUQbAnXKhxim4BQIwEwOPWAp321Qg=
X-Google-Smtp-Source: ABdhPJyGzhoZUiWoth20X4qiEP/xTOTQABOGug3J8Zxb0n6tAXSkhqvij9WxKNekjP9xBdHbalOSjg==
X-Received: by 2002:a19:806:: with SMTP id 6mr15533418lfi.171.1593016632264;
        Wed, 24 Jun 2020 09:37:12 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v5sm4261869lji.73.2020.06.24.09.37.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 09:37:11 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id n23so3277461ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:37:11 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr385264ljj.102.1593016630687;
 Wed, 24 Jun 2020 09:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200624161142.GA12184@redhat.com> <20200624162042.GA12238@redhat.com>
In-Reply-To: <20200624162042.GA12238@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 09:36:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
Message-ID: <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss wakeup?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 9:20 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> If T1 is killed it is TASK_RUNNING, try_to_wake_up() should return 0.

Hmm. I already acknowledge your bug, but yeah, this is subtle.

But I think the bug still exists.

So the requirement is:

 - bit_is_set returns false so we don't call io_schedule: we're still
TASK_KILLABLE

 - somebody else gets the lock, so the test_and_set_bit_lock() fails

 - that somebody else releases the lock almost immediately, and wakes
us up because we're still on the wait-queue (and still TASK_KILLABLE,
not TASK_RUNNING)

 - another party sends us a SIGKILL

 - we see the signal_pending_state() and exit

 - we've now been woken up, but didn't wake anybody else up, and the
lock is released but there may be waiters who came in at the same time
and never saw the wakeup.

I think this is basically impossible to hit in practice, but it does
look like a real bug.

Maybe I'm missing something. This code is subtle.

But as mentioned, I _think_ the real problem is that "don't do
io_schedule()" optimization, because that's the thing that means that
we can miss the wakeup.

If we only had a single "test_and_set_bit_lock()" thing, we'd be ok.
Either we got the lock or we didn't, and if we didn't we'd schedule
and re-try, and we'd never have the race between testing signals and
bits while we're "sleeping" and can be woken up and try_to_wake_up()
thought we took it.

                Linus
