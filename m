Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F88C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7790320781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqxlb5ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgF3JIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731666AbgF3JIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:08:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A25C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:08:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d194so6281302pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=992mBVKl8fRwzZCwrZpqSt5GDbC/BVSNr7NmNu7bQpE=;
        b=uqxlb5ba17VM+ybVvn42BLZxmPfWtJ/V4Z/qPvDeUzYaxDgNqFmqmi0rMD9J748joD
         5HYAlgKYN8Zoe303R8nJKh/W224WLIOXvXNMVUREgKhDderoMS47PstIFlvcnBaGXEYk
         pWLKryEZ1v2LeFEVD+ZBu1LMcZ87JDdyJHvc1XLE0CknZNPJzZKR73ELjMQVDUgi+7zN
         7/U7DYSlYIRuOkvt2YN+6vSg9lrtq7MUcj1wCugecd4XU7Lhxes9NCofvzAZkAB47NVD
         0ulWpIjVx/IGYSXBpN3XcpUGCrvwbj4kg8mbGG2nndeiOek86aL8Zw8UakhaijtBk8f4
         pkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=992mBVKl8fRwzZCwrZpqSt5GDbC/BVSNr7NmNu7bQpE=;
        b=WHiZcLozFlGjbWTvcOh8Xcf1UCjyYf+KGinZSBWt5edqH+7hHZ0v65ukMQbsyrL9oy
         02ANqvbM5G6pHIoB/k5Vqd0xNE45Q+IaPM9n/BK7+X40bxqy04NDzeCbuYlv3a9H5wQm
         dUJNfTvhmkKVuz9RL7ip7+6RUpKPsrkTzAIQQ4MKfp9G0kZWc+zfWezo7k00uGixePbs
         wceEjO+dxYv+yuvMJeCSFpC9zKfnwmD2A+R78J+QdXVC10jDJgiyQ5LcEgiSoMrhl68+
         HV8g2OeNVUQEspVrm0d2M7GiIMRMYzqoCnenI0Y0Azb6Ii9tmlSMs8EKnAy720eftRmu
         E77Q==
X-Gm-Message-State: AOAM531z1rrCOvvPumNRy9gYRv211ttVoiWmYhAkWWFRQXVb8R08/zpx
        Q1+ra8j4acz8dmkgjyt22ZI=
X-Google-Smtp-Source: ABdhPJz8lADVxcqO7souJtMhhOOZfe1KIbqhcs0hYa3xac2OQwnCod8tYvOzioUi5PWM8DY9BFFMog==
X-Received: by 2002:a63:e404:: with SMTP id a4mr11163444pgi.79.1593508097935;
        Tue, 30 Jun 2020 02:08:17 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id b4sm1588100pjo.57.2020.06.30.02.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 02:08:16 -0700 (PDT)
Date:   Tue, 30 Jun 2020 19:08:10 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200624161142.GA12184@redhat.com>
        <20200624162042.GA12238@redhat.com>
        <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
        <20200626154313.GI4817@hirez.programming.kicks-ass.net>
        <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
        <1593396958.ydiznwsuu8.astroid@bobo.none>
        <20200629140245.GB20323@redhat.com>
        <1593482844.k3rh7s05o8.astroid@bobo.none>
        <20200630061708.GA21263@redhat.com>
In-Reply-To: <20200630061708.GA21263@redhat.com>
MIME-Version: 1.0
Message-Id: <1593505946.t0nxq8q8kj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Oleg Nesterov's message of June 30, 2020 4:17 pm:
> On 06/30, Nicholas Piggin wrote:
>> Excerpts from Oleg Nesterov's message of June 30, 2020 12:02 am:
>> > On 06/29, Nicholas Piggin wrote:
>> >>
>> >> prepare_to_wait_event() has a pretty good pattern (and comment), I wo=
uld
>> >> favour using that (test the signal when inserting on the waitqueue).
>> >>
>> >> @@ -1133,6 +1133,15 @@ static inline int wait_on_page_bit_common(wait=
_queue_head_t *q,
>> >>         for (;;) {
>> >>                 spin_lock_irq(&q->lock);
>> >>
>> >> +               if (signal_pending_state(state, current)) {
>> >> +                       /* Must not lose an exclusive wake up, see
>> >> +                        * prepare_to_wait_event comment */
>> >> +                       list_del_init(&wait->entry);
>> >> +                       spin_unlock_irq(&q->lock);
>> >> +                       ret =3D -EINTR;
>> >
>> > Basically this is what my patch in the 1st email does. But note that w=
e can't
>> > just set "ret =3D -EINTR" here, we will need to clear "ret" if test_an=
d_set_bit()
>> > below succeeds. That is why I used another "int intr" variable.
>>
>> You snipped off one more important line of context. No such games are
>> required AFAIKS.
>=20
> 		for (;;) {
> 			spin_lock_irq(&q->lock);
> 	=20
> 	+               if (signal_pending_state(state, current)) {
> 	+                       /* Must not lose an exclusive wake up, see
> 	+                        * prepare_to_wait_event comment */
> 	+                       list_del_init(&wait->entry);
> 	+                       spin_unlock_irq(&q->lock);
> 	+                       ret =3D -EINTR;
> 	+                       break;
> 	+               }
>=20
>=20
> so wait_on_page_bit_common() just returns -EINTR if signal_pending_state(=
) =3D=3D T.
> And this is wrong if "current" was already woken up by unlock_page().
>=20
> That is why ___wait_event() checks the condition even if prepare_to_wait_=
event()
> returns -EINTR. The comment in prepare_to_wait_event() tries to explain t=
his.

Hmm, yeah because we can loop around here with task in task sleeping=20
state. Which comes back to Linus' fix. Thanks.

It looks like I broke this with 62906027091f1, then Linus mostly fixed
it in a8b169afbf06a. My patch is what actually introduced this ugly
bit test, but do we even need it at all? If we do then it's=20
under-commented, I can't see it wouldn't be racy though. Can we just
get rid of it entirely?

Thanks,
Nick
