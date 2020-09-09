Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC2DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6620C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599705167;
	bh=G/d7I7uYDPr+xcXLSAz55tCVxS++/YD+BwhhhZQ43rE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gokMV4/KvOXFeMd492xIR7rFlZtY/B8Wmq030wxfoiHWO09BJiNadQpxkNDaUR/lr
	 hWGCJjKjcWC/BzSoDL/y0v8QVZxabquH8gTbYav8iW/2Ch+yTuI6Ax8XeTZa1xoLaZ
	 iqbzm66e9bmZFyQsqrDdv4vjUK6jAKrTJJh9GBfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgIJCcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbgIJCZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:25:30 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB2D208CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599695820;
        bh=G/d7I7uYDPr+xcXLSAz55tCVxS++/YD+BwhhhZQ43rE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qP1mLFoFElIO3POE7p4mPUAYXwmsO/XSRrk3t5/qHZWwPmEBX9oUK3Ytty/iZa4Mh
         UxBxO0tdVkS8hnI6o3a/YfGj5gTiUN4wdk00h/C60TAK1Lr75rN+d793UgH2dGKZXE
         87xu1sF3AVtntrGULLDYy7gBUkGv67K2IFmH9JPI=
Received: by mail-wm1-f41.google.com with SMTP id k18so4007605wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 16:57:00 -0700 (PDT)
X-Gm-Message-State: AOAM532+5oyO6h4DRkrmvQjuvNo4B5X1bD0ehbOaBPySh1ws2NULO8fs
        QfZFT4EIpP3RWyFyCOo4WjtEBph2y/mnqf8kwa8IkQ==
X-Google-Smtp-Source: ABdhPJzH/nmU4Vf4z8Anq+NWWPNlJPoNfTnH0PJIk0ApNI/X6nVQ/+QvDJXA4QaLUUOZaFv1S6ywVK6a0FKb2CQSs0Q=
X-Received: by 2002:a05:600c:2183:: with SMTP id e3mr6114629wme.49.1599695818930;
 Wed, 09 Sep 2020 16:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200908193029.GM25236@zn.tnic> <025308CD-6E1A-41E1-8B3D-E9842CE00794@amacapital.net>
 <CACdnJusOJVb0xpecFgPQB4N2WhUORikv_1eXAcGfJ3xwBVTo9Q@mail.gmail.com>
In-Reply-To: <CACdnJusOJVb0xpecFgPQB4N2WhUORikv_1eXAcGfJ3xwBVTo9Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 9 Sep 2020 16:56:46 -0700
X-Gmail-Original-Message-ID: <CALCETrV+zLzKvmkJSyXVqVw6FREC__sMXrv2rygruSq3ZAwtiQ@mail.gmail.com>
Message-ID: <CALCETrV+zLzKvmkJSyXVqVw6FREC__sMXrv2rygruSq3ZAwtiQ@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Matthew Garrett <mjg59@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 3:32 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Sep 8, 2020 at 1:35 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
> > Undervolting is a bit different. It=E2=80=99s a genuinely useful config=
uration that can affect system stability.  In general, I think it should be=
 allowed, and it should have a real driver in tree.
>
> Agree that this should be a proper driver rather than permitting
> arbitrary poking (especially if this isn't an architecturally defined
> MSR - there's no guarantee that it'll have the same functionality
> everywhere).

After looking at the code for intel-undervolt a bit, that definitely
needs kernel or even firmware support.  That MSR really is a mailbox.
You write commands to it and read responses.  There's no way that user
code can have adequate locking.
