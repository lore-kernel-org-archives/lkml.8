Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78391C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4AA24676
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHPhUsdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCBSdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:33:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35676 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgCBSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:33:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id b18so252288oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZbmtOiRk93OR72yt1EoTbIuU9x3jbqZX+qgicq1dyY=;
        b=fHPhUsdH/WGi4r7CdvRCBfNGmdlZvtnX231MF92MKAbd5HFrx9tE8AN6x3opkdKxdm
         BZTBiminBOnhmL6RrbLkv/Xo7eYqfJUIuwW0cua1UYAfkKfx3Y7Dca3M6eAh1KIwz5AL
         17i2ae47Uk8ucDGK1OwbN25nQ0Tfc/VakEOE9rQX6VXy630HHs5ECpPYqyWYJikxD5M0
         uflpOsemja9vUeA/k1tgDPcn1FIYXROKwl1t1yFQuKNgBCJENuLxywAf0KyzYhWBzBAS
         eQUmXZBEAqcRNDqspF4qzeWzp4z2Tgp3yffpRA1jTwY3S+WTpSWP4tcFciXPsECTyGKf
         tD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZbmtOiRk93OR72yt1EoTbIuU9x3jbqZX+qgicq1dyY=;
        b=QXMLSAJOf99uZzSLaFyPKkfVislX4lI3B92L8iNO8i7TATyLPi6wByBb+g710a4CuX
         OeDKUZhCCMCJX/ms/r01PlQ3J5ZEPlTkF/IqXtGoz2l2TOk3e6Vi1MLw9FwDCMkOCLpC
         qzER7ARqX8XuAyK56CO97MB1ONaKSfnuVwMiSNrxOjoVeCGKzH53nB6jjeiz049vvTW9
         rO3ODlg0X0leAAOB5g4fyNqJHTh8fjlH+jN0Hbalx0oFuZ5iG6vNexJpfp26ZdOfG1Gn
         dyCJOkxF9gyPnmi0gN+us1hBZcahs+A6NL0HW90eN4PZMSh0CgJRTWlRUBlX7tb/i6oG
         huRg==
X-Gm-Message-State: ANhLgQ3X8Lm/gnWac1JRnLsLuc5AhYMB+cu74j6srIiMDHB/3YsxBoyg
        uaXz/xZXjAyE/WTy/feoUaYl4HzkY9sP8/u+cltEzQ==
X-Google-Smtp-Source: ADFU+vueGLxOizdwYqnKQMfJ4/RA5ZTXxD27z+32t38CQSoxfHOxF07okTKhlFJ+fzxC1be5Dz+ZJ2lCXetSWS5Y5Zw=
X-Received: by 2002:a05:6808:983:: with SMTP id a3mr317859oic.172.1583173993550;
 Mon, 02 Mar 2020 10:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20200302141819.40270-1-elver@google.com> <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
In-Reply-To: <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 2 Mar 2020 19:33:02 +0100
Message-ID: <CANpmjNNbXLzrVOpLPVaCfX_f96s9kdGXUioBm8QnS8A+B_-NKg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model/Documentation: Fix "conflict" definition
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 at 18:44, David Laight <David.Laight@aculab.com> wrote:
>
> From: Marco Elver
> > Sent: 02 March 2020 14:18
> >
> > The definition of "conflict" should not include the type of access nor
> > whether the accesses are concurrent or not, which this patch addresses.
> > The definition of "data race" remains unchanged.
> >
> > The definition of "conflict" as we know it and is cited by various
> > papers on memory consistency models appeared in [1]: "Two accesses to
> > the same variable conflict if at least one is a write; two operations
> > conflict if they execute conflicting accesses."
>
> I'm pretty sure that Linux requires that the underlying memory
> subsystem remove any possible 'conflicts' by serialising the
> requests (in an arbitrary order).
>
> So 'conflicts' are never relevant.

A "conflict" is nothing bad per-se. A conflict is simply "two accesses
to the same location, at least one is a write". Conflicting accesses
may not even be concurrent.

> There are memory subsystems where conflicts MUST be avoided.
> For instance the fpga I use have some dual-ported memory.
> Concurrent accesses on the two ports for the same address
> must (usually) be avoided if one is a write.
> Two writes will generate corrupt memory.
> A concurrent write+read will generate a garbage read.
> In the special case where the two ports use the same clock
> it is possible to force the read to be 'old data' but that
> constrains the timings.
>
> On such systems the code must avoid conflicting cycles.

What I gather is that on this system you need to avoid "concurrent
conflicting" accesses. Note that, "conflict" does not imply
"concurrent" and vice-versa.

Thanks,
-- Marco
