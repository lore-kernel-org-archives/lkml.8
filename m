Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10220C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EA920885
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="asHKwznp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgFSIaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbgFSIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:30:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B43EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:30:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so4010440pjv.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=bal/f6C5W3hI/7eEDoJMPCvhC5IDLMyLNXSt4/S+Z6w=;
        b=asHKwznp8EZNJTx5F+A/9eKKgUGgsWkbC1twAT3301DPYW41sseSJwhpPeYQW2YpvB
         IjWQD8A0wDX/58ArkSviJh+wTiDlUhI4RX5exrXQ2fB89EmRq9QC+2EeGsn5/8xCNHcT
         dLdt/XKSjGAfV2aXSpQB0gjVamY2HLSon89Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=bal/f6C5W3hI/7eEDoJMPCvhC5IDLMyLNXSt4/S+Z6w=;
        b=lrwMP4l06XCEiegq9aUrPVWadkYuZwTBmnKFJ2MtkNraMUZSiZcSRazy5JnSHurger
         7yVb9UG2MOWxSDi4wD78/ACsefIqdmePiINynjMIWc0QvvMKCVPJtbWSNzNntkyzF9Q2
         iwPL/hkPvID3Gl/r0TQvBGZSQnxWXxuS1UuFnBLank0grEvnTyMWOpUGyIRdGQW7CGlb
         QBN4x28+PTkxLVAjxzLa03Z8520Rno+sfllvxuw+gR1Hh/bEA46e7GpASYeHx3plQYM0
         QmB/s6NXmOBozw0xHzcS6Yjz602EXy3/8MhUsfNmLZU9rGcjSxJiuT2dm0xHaEqrvdM5
         7m4Q==
X-Gm-Message-State: AOAM532GCY4mAU++WSgNe9XAKU5f/w6WeDJi+zALlEQcmysKOl26flb0
        oin2Q+7sKwKPcJVdEYAw1hGgCw==
X-Google-Smtp-Source: ABdhPJzSNN0Qpr5cQYl53gfznBN1okIAMcFX4yLnK/9HsM4RGMZCO2BfOQ/cjG1bNmm74yfvZUvcTw==
X-Received: by 2002:a17:90a:284b:: with SMTP id p11mr2480021pjf.22.1592555400970;
        Fri, 19 Jun 2020 01:30:00 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id hi19sm4687515pjb.49.2020.06.19.01.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 01:30:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bc265120-0d48-bcab-a58e-3b94f8c540ce@arm.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com> <20200617113851.607706-4-alexandru.elisei@arm.com> <159242503203.62212.1690942414916053920@swboyd.mtv.corp.google.com> <bc265120-0d48-bcab-a58e-3b94f8c540ce@arm.com>
Subject: Re: [PATCH v5 3/7] arm64: perf: Remove PMU locking
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mark.rutland@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Jun 2020 01:29:59 -0700
Message-ID: <159255539947.62212.6059916295459835174@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Elisei (2020-06-18 03:51:31)
> Hi,
>=20
> On 6/17/20 9:17 PM, Stephen Boyd wrote:
> > Quoting Alexandru Elisei (2020-06-17 04:38:47)
> >> From: Julien Thierry <julien.thierry@arm.com>
> >>
> >> The PMU is disabled and enabled, and the counters are programmed from
> >> contexts where interrupts or preemption is disabled.
> >>
> >> The functions to toggle the PMU and to program the PMU counters access=
 the
> >> registers directly and don't access data modified by the interrupt han=
dler.
> >> That, and the fact that they're always called from non-preemptible
> >> contexts, means that we don't need to disable interrupts or use a spin=
lock.
> > Maybe we should add a lockdep assertion that the code isn't preemptible?
> > I.e. add a cant_sleep() call? Or is it more that we don't need locking
> > because we're just doing register accesses and don't need to protect
> > those accesses from each other?
>=20
> It's both. The spinlocks were there to protect the functions from being p=
reempted
> and possibly migrated to another CPU, and from being interrupted by the P=
MU irq
> handler.
>=20
> There was no data race with the interrupt handler, but before the previou=
s patch
> ("arm64: perf: Avoid PMXEV* indirection"), in order to read/write/program=
 a
> counter, one had to write the counter number to a counter selection regis=
ter, and
> then write/read the desired value from another register. This was done fr=
om both
> the armv8pmu_{enable,disable}_event() functions and the irq handler, and =
the
> spinlock was necessary. Now that we can access a counter using a single r=
egister
> access, there's no need to protect the functions from being interrupted b=
y the IRQ
> handler. As for armv8pmu_{start,stop}(), they consist of one register wri=
te, so
> it's also safe for the irq handler to interrupt them.
>=20
> For the preemption part of the locking. The armv8pmu_{enable,disable}_eve=
nt(),
> when called by the perf core code via the pmu->{start,stop,add,del} callb=
acks, are
> guaranteed to be called with IRQs and preemption disabled, as per the com=
ment in
> include/linux/perf_event.h. They are also called from the arm_pmu driver =
by the
> CPU PM notifiers, which should also be executed with interrupts disabled.=
 Should
> we check here that the top level code respects these guarantees?
>=20
> The armv8pmu_{start,stop}() functions are called from the irq handler, so=
 we're
> safe from preemption in this case. They are also called via
> pmu->pmu_{enable,disable} callbacks, and I didn't find an explicit contra=
ct
> regarding preemption in include/linux/perf_event.h. I've checked the othe=
r call
> sites, and I didn't find any instances where they are called with preempt=
ion
> enabled, which makes sense as we don't want to disable the PMU on a anoth=
er CPU by
> accident.

If they're all callbacks then it's overkill to add this. Presumably it
is better to enforce this wherever the callbacks are called from so as
to not litter the callee with random cant_sleep() calls. Probably best
to ignore my suggestion.

>=20
> I would be inclined to add cant_sleep() calls to armv8pmu_{start,stop}().=
 In the
> previous iteration, there were WARN_ONs in these functions, and Will said=
 [1] they
> can be removed because they are per-CPU operations. Will, what do you thi=
nk about
> adding the lockdep assertions?
>=20
> [1] https://www.spinics.net/lists/arm-kernel/msg745161.html
>=20

If I read it correctly Will is saying the same thing in that thread.
