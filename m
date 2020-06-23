Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E13C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A73220776
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbKnzvpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgFWPGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732845AbgFWPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:06:39 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05157C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:06:39 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a3so19111485oid.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30jZZJyoCOJi08Aubf0/SfjQqMuFLP8B24XJpfK0XLQ=;
        b=FbKnzvpxKC06g0MIQWWlrNb4n4JI4Ly0YN2LVqm58IUcVU7jG2Ru2GG4i6d+6JdQBC
         GO2bjrEYKrftcCTBgD4lDBohr/TLMiR8Qnuc8uZG0h4Y8avY1zI5UcPDxBSTZAB94pOK
         kUFpnp1RMy5fKLsBcJaXJjJHBLRtRQB7eZhzYadj75bbSV4NYZRiPx7O/7mQ2s4kEhI4
         7EYiDZoVOL1ryXYTygf95qjcDqyAmWLRi2SgxjepcxvKkdnGHY35lwxUvFKwNF71ozrE
         lK4RDcz+ac8hnmbz1XC3Q4q6fseMA5xqXTV0tZuFtTr6x3ln/VZAQqzOckidMetz9BtL
         hW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30jZZJyoCOJi08Aubf0/SfjQqMuFLP8B24XJpfK0XLQ=;
        b=gJ7m04x1yqdfziqYwHzVymK5S3neT9sKdIltv86TscH2+fGWUw+sP7GBQ/lOHMKbBD
         oxfsWPgBKfEjGICoPcTT2TSNwcBIgN7cyZONyKM9rVqiCvfEyCM6EBrBskc+DakmJTsy
         QUh2wAe0l2OYb9jIoegkOIOnBSTRGKXgu+RC+1zckGchlTpn9gnf2fxHtwS+bMsGWfP9
         B6EZih38Njr7Mo1RYjYVE4Lkpm9yoS5vDmLVBAwQgHPAS4SihbzNYSBmraNW9VtZm04U
         0n2/Uw0ZMddsvRyzJU4MvfrhXlob61/fDhQ8UM7QtFZecVmejsEwVIMx+4vrSdmU47qG
         a6jQ==
X-Gm-Message-State: AOAM533Dv44a1D9VzKGfupOdWqPy5+Jy+AEZ9Lg0TPX9K4WuntpUtEGZ
        A5rCp9XMGNr3/Foqy+27J5VDJ51oKt7gze9sERyGstuJoOD1lQ==
X-Google-Smtp-Source: ABdhPJxZUy0PlLwYAPeiWgr+WILaUS95fwf3agdlx3y2WA64WwNLgWX/QuYotEsVIWFVNnD+jQ6irlBBKt0dw/iuKvI=
X-Received: by 2002:aca:1205:: with SMTP id 5mr16939378ois.70.1592924798097;
 Tue, 23 Jun 2020 08:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200623004310.GA26995@paulmck-ThinkPad-P72> <CANpmjNOV=rGaDmvU+neSe8Pyz-Jezm6c45LS0-DJHADNU9H_QA@mail.gmail.com>
 <20200623134309.GB9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200623134309.GB9247@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Jun 2020 17:06:26 +0200
Message-ID: <CANpmjNO_2N5PB6MOQqEgpwNKmTtLrSNcY+-a2fVncESyjuO=Wg@mail.gmail.com>
Subject: Re: [PATCH kcsan 0/10] KCSAN updates for v5.9
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 15:43, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jun 23, 2020 at 08:31:15AM +0200, Marco Elver wrote:
> > On Tue, 23 Jun 2020 at 02:43, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > This series provides KCSAN updates:
> > >
> > > 1.      Annotate a data race in vm_area_dup(), courtesy of Qian Cai.
> > >
> > > 2.      x86/mm/pat: Mark an intentional data race, courtesy of Qian Cai.
> > >
> > > 3.      Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu().
> > >
> > > 4.      Add test suite, courtesy of Marco Elver.
> > >
> > > 5.      locking/osq_lock: Annotate a data race in osq_lock.
> > >
> > > 6.      Prefer '__no_kcsan inline' in test, courtesy of Marco Elver.
> > >
> > > 7.      Silence -Wmissing-prototypes warning with W=1, courtesy of Qian Cai.
> > >
> > > 8.      Rename test.c to selftest.c, courtesy of Marco Elver.
> > >
> > > 9.      Remove existing special atomic rules, courtesy of Marco Elver.
> > >
> > > 10.     Add jiffies test to test suite, courtesy of Marco Elver.
> >
> > Do we want GCC support back for 5.9?
> >
> >    https://lkml.kernel.org/r/20200618093118.247375-1-elver@google.com
> >
> > I was hoping it could go into 5.9, because it makes a big difference
> > in terms of usability as it provides more compiler choice. The only
> > significant change for GCC support is the addition of the checking of
> > (CC_IS_GCC && (....)).
>
> Very good, I will rebase the following into the KCSAN branch for v5.9:
>
>         3e490e3 kcsan: Re-add GCC as a supported compiler
>         03296de kcsan: Simplify compiler flags
>         d831090 kcsan: Disable branch tracing in core runtime
>
> Please let me know if any other adjustments are needed.

Looks good to me, thank you!

Thanks,
-- Marco
