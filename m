Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581CDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2635B2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="1EBMFcJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgDGSaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:30:52 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46140 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgDGSau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:30:50 -0400
Received: by mail-il1-f194.google.com with SMTP id i75so4172128ild.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rDMA5WWn7bYB7MG4VGJuqHxYro2AVItySrW1xoxllWc=;
        b=1EBMFcJDgJCUOFSoZbm9gK1yN+paSHk6GKvf6+7Eggkdr9ZuDdu5fTQRHpNz326Uak
         ZUm5vP29+VIbKDclnFrF8Rz3IV2fp7iRHXshWxXWvZxwEc5RI8zG2VgEvXz7+r1cL3N4
         fo27h/b/Bpz+k2NVbBw+RYh2jqfg95ctsXS5yp5qXp7S00T/HuE90IVeux9x1PYvaGT/
         /HT/a11YwB2HxQXwEtjecCgAGBQJ7DN9davuW2LhfAkjMZ3oTJ0rJ2D74WXnkANGquE2
         LpMQoFmOOqDIIkle22uTY57uGsA8osb0FBvcE7tUv7eKkmJ/xQyRpxiI20HoykJa975W
         wATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rDMA5WWn7bYB7MG4VGJuqHxYro2AVItySrW1xoxllWc=;
        b=pYUo0useMjqED+Pt01o/sGYRL0RmuNgYAC2/M4/SPBJNTODUicRCzgeybbtkGF4Z1Q
         0YUXE4j3rk7UJVwyuUgikTiLxxruD2dNrzgWmARjL1KdHFAFM9M/p3joZUQfFDMQ/YHT
         0HpuWDWs0Bx6b6df9tgUZJ91zMe+KCqFmViO6e9dCB0qtnustUEC6UqSO6VXq/FLLjSL
         DDQXmYyJ86qGhTj6ih33hJ6t6nCUcOT8yICWpLVS5lWqScXp1zVCLwUStnyok7orCyIY
         ES1xgTSrZsFsWoA512CUoAQn3mrnAEyVyMcZh4nbfu/q5p/4njuTxK4VtumYXopLsPOj
         uqtQ==
X-Gm-Message-State: AGi0PuapMm+gVwdOiaqBVUrT/vI2Rc5GsJAbnzNKRyxYUj5VcMh8WPsu
        pSf9EmE9vOubdjoN156LQdY9+l9rHvOXFHPWGfZDKg==
X-Google-Smtp-Source: APiQypKZwz4dyQ4MNppl+hHvG0S9YeN1zwwzNgLNpAakkNsBO6dg4GndKxweLE0YodEX1Hb0Y7KwijrauRQUTlNAw9w=
X-Received: by 2002:a92:cf50:: with SMTP id c16mr3855767ilr.181.1586284249367;
 Tue, 07 Apr 2020 11:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com> <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net>
In-Reply-To: <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 7 Apr 2020 14:30:13 -0400
Message-ID: <CABV8kRxqcCmPKtX3DDOf+47Re1hO1gMeUPhCd6HtDP0-SpcSBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> TSX!

Yes, it's problematic, but luckily turns out to
be ok in practice if masked off in cpuid.

> I think rr should give the raw KVM API at least a try.  It should be poss=
ible to fire up a vCPU in CPL3 in the correct state.  No guest kernel requi=
red.  I don=E2=80=99t know if there will be issues with the perf API, thoug=
h.

Yes, I've looked into it, but stopped short of doing a
complete implementation. Using KVM to solve it
for replay would probably be feasible with a moderate
amount of engineering work, since rr does very few
syscalls during replay. I'm a bit afraid of the
performance implications, but I don't have numbers on this.

Record and diversions are a lot harder though, because
in this mode the tracee is a live process and able to do
syscalls (and needs to receive signals and all that good
stuff associated with being a real process). For diversions,
performance isn't super important, so we could probably
emulate this, but for record, performance is quite critical.
I assume it would be possible to add a feature to KVM
where it forwards syscalls made in guest CPL3 to the real
kernel without round-trip through userspace, but I'm just
seeing myself back here asking
for a weird KVM feature that nobody but me wants ;)
(well almost nobody, as I mentioned, there's an
academic project that tried this with a custom kernel
plugin - http://dune.scs.stanford.edu/).

Admittedly, the use case for this feature during record is
less pressing, since in our (operational) case
the replay machines tend to be much newer than
the record machines, but I wouldn't be surprised if I got
bit by this as soon as the next user xstate component gets
added and users start sending me those kinds of traces,
even if we mask off the feature in CPUID (which rr already
supports for record for similar reasons).
