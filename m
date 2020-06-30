Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E2AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7232068F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3oO3nnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgF3CMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgF3CMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:12:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:12:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g75so17277138wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=4wknG23HaVvyRUB7piPKzRsEJzEa/wUAynhdy+wisas=;
        b=f3oO3nnFjDZvFf+hMSus268RZXIfpI6JocqVz9m3c8DNLfrpNmC9na2fRnD3VtRu7Z
         JaZ7qpPnE78ak4qZkRAipEtNWtDkrnhP0Rz/+iutY8aBVZfpeWBJmm7A6NCpnkTAOfk8
         EwmCbfFL2ZT226aeri/k80+au5XzDBfIInS1m7aQYsP3OUdWmsTRHjO09QWcdkdtRtAM
         ZHwECSb86wctAvqs0769drbNm0CU0dQVUP5Mqhm6krb7UHfNuEH/Y0EoFKHrP2rRx5mw
         zWbVKAPlL1s2NVaOPossVoT63LVkI5ER3JeKzkExM48m8Y72RLKLyE5sS4DBGJwo4bYT
         wYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=4wknG23HaVvyRUB7piPKzRsEJzEa/wUAynhdy+wisas=;
        b=hALE9hh3Ji9SWmtwNomNr546ESBOMrZzSGlB+eae20gHrUUJ52kA+Jr8z+VMI95E+s
         /pecTprGfGmt8wJWGOSENkCtCvVLUtfkokPbPx4rBgIRfTNcgW5Q6ZttKM9Y1D9lPhbI
         c87470g3cOBlN4GZz4L3f3h8CG9LhFA1RgKkASXvqmJMSaDyC3JujfADsyduMBfQRwSO
         HwjcHdoc15Nkl72ILt3eTbDAWTrWZoSu5nNaZ4vkoL1IaJ68nSgAqcbfCOGbnrWVdNk4
         21yMzbLy9WusmJNzrmy78Goz3U1rTW46Kk5p7iDwtwjyQyDF329bSFWndAhjEWFNc8yt
         JG9w==
X-Gm-Message-State: AOAM5310sAOU+XGWMK+Ls9K147zmsIEshPDEEYnDP6kSNi0oEwMUR8LD
        YZclCUq+XFwQPvnWP0LkxooK/Y8Z
X-Google-Smtp-Source: ABdhPJx9eiMBqo7w0KwUcdkTymiGnMRqY6bfkIuGqmhNl5sK/2lMoQySfCYkTTbojRjNKGacQMwk2w==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr19814835wma.4.1593483159208;
        Mon, 29 Jun 2020 19:12:39 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id e25sm1865354wrc.69.2020.06.29.19.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 19:12:38 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:12:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200624161142.GA12184@redhat.com>
        <20200624162042.GA12238@redhat.com>
        <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
        <20200626154313.GI4817@hirez.programming.kicks-ass.net>
        <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
        <1593396958.ydiznwsuu8.astroid@bobo.none>
        <1593436373.x8otyji40u.astroid@bobo.none>
        <CAHk-=wjJKicPgmvf7atx=h6Li7ez9nFrpJdgTSRm5aUEnuVH6w@mail.gmail.com>
In-Reply-To: <CAHk-=wjJKicPgmvf7atx=h6Li7ez9nFrpJdgTSRm5aUEnuVH6w@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1593482936.bcy1487a6g.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Linus Torvalds's message of June 30, 2020 2:36 am:
> On Mon, Jun 29, 2020 at 6:16 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> No, ignore this part (which you explained well it was just a thinko,
>> and your patch of course would not have worked if this was the case):
>> the exclusive wake up doesn't get lost if schedule() was called because
>> state goes back to running regardless of what woke it.
>=20
> Right.
>=20
> The normal pattern for a wait-loop is
>=20
>  - add yourself to the wait-queue and set yourself "sleeping" with a
> memory barrier.
>=20
>  - test for the condition, exit if ok
>=20
>  - go to sleep
>=20
> and that pattern doesn't have the race.
>=20
> The other common pattern is to check for the "do I need to sleep at
> all" at the *top* of the function, long before you bother with any
> wait-queues at all. This code does that odd "let's check in the middle
> if we need to sleep" instead, which then caused the bug.
>=20
> So we had an odd setup because of three different wait conditions that
> had different rules for what they could/should do before sleeping, and
> then not sleeping reliably at all.
>=20
> We could also fix it by just splitting out the three cases into their
> own wait routines that match the normal pattern. The bug really
> happened because that wait-loop is doing things such an odd way due to
> all the different cases..
>=20
> I actually think it would be a lot more readable if it was three
> different cases instead of trying to be one "common" routine.
>=20
> The *common* parts is the special PG_locked logic at the top, and the
> thrashing/delayacct code at the bottom.
>=20
> And *that* could be a true common helper, but the wait loop (which
> isn't even a loop for the DROP case) are fundamentally different and
> probably should be separate functions.
>=20
> So I think my "one-liner" fixes the problem, but I'd certainly be open
> to somebody cleaning this up properly.

I think it does. I would rather my patch which doesn't add a barrier to=20
the "fast" path though (by the time we get here I think the fast path is
that we are sleeping on the page, doing the IO).

Alternatively (although this still adds more branching than necessary at
least it doesn't have a barrier for the sleeping case), you could set
the running state as an else case if you don't schedule.

Thanks,
Nick
