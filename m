Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8021EC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520F520661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUwmu0GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgA1K3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:29:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39247 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgA1K3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:29:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so11484408oty.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 02:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gcED4ZlmJtyovEG5JdlRhvSs0Jksu0OFoc3+PCIVqXY=;
        b=BUwmu0GE0Rcc+1UBNZsrzbQNpFfbcREG6DcUvZCQi2jT9v/IvUk+nQ8oFyKoa2/zTc
         ugiAhMbuzt0bcoIKrUgrXfeOA33UWz/+869S17yghumlNhR3Ri7+zyVrT4vfsLTnK5Lu
         q8EOdgTU4yEOyNV3HphjwsKUA+RiZ7ZZa3A5IOz896rPx3L46hkZimSmCLPJuRtxI4Jq
         BMqW3qWzO1/LJjMlAYnL3r8p3FHXMfQTWuCHoqlfkOM7U+KMC+4N+CVYz3GtyO4gMMW+
         CUfkojgEavUQ83XI7ET69HA11OBwlrBF5l8h2EolzaoaS1eYENmP2QpUqUmeWzWFRqFi
         dGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gcED4ZlmJtyovEG5JdlRhvSs0Jksu0OFoc3+PCIVqXY=;
        b=nhHtH7UbfGNwPQTMzu8PGQr58CW0hQoeoVJ+mg24FiAC+KIEdq2miZ8nx9k+M0bNCW
         7XNWCIK51SjESgD3P9pNuvtH4DViSJ4IRaMspoUblfKMrQDwK/AhFoDx1lm8R3yiHZ6l
         cFEiEUw32lTYiVErL5w4ygdGSo4Xv2K/vE7z4nkpqyUnqiQ6JryZtKaObQyXwWJyARGv
         riAR9ey9RDN1d2dyK6vCGdP4QPpyxJht086agS/FP6glU+mgh0/JilIaFiduYgB9PYMa
         AgMlJwcbyWIZzrx1nhMBoHW58jeL30xFvK7rPfcxMxT5y2toh7/h+Uj5LkX2T3WDI4RH
         armw==
X-Gm-Message-State: APjAAAWSfBXgfsfFfPIgxgqknee1DsZkMfBCJYXEJDLZZQ70xR8V0KU2
        Otyrlr4AK+O4Jy5aUrweNiGGZ9mDugcwLpNGHyk2otDG
X-Google-Smtp-Source: APXvYqzc3S/crHEzbEjQS4F3FomiDAtebl0zV8C7DZvl0NmnEoqKbbbHfAu7bueh9FpsPJM2YyfXweMK+vT7aLuR9qw=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr16795906otq.17.1580207363151;
 Tue, 28 Jan 2020 02:29:23 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMzvcrQWpGWVgNRxvZroecAEZYYa2yYAtm5+ekcK=H3OQ@mail.gmail.com>
 <E65D0BFC-719A-4CF9-A934-55ACFF663F98@lca.pw>
In-Reply-To: <E65D0BFC-719A-4CF9-A934-55ACFF663F98@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jan 2020 11:29:11 +0100
Message-ID: <CANpmjNNFBLB4iB7gj3sR9y1RKB6PmneNZmfpyJ4418impvwqBA@mail.gmail.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 at 11:10, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Jan 28, 2020, at 3:18 AM, Marco Elver <elver@google.com> wrote:
> >
> > This should be an instance of same-value-store, since the node->cpu is
> > per-CPU and smp_processor_id() should always be the same, at least
> > once it's published. I believe the data race I observed here before
> > KCSAN had KCSAN_REPORT_VALUE_CHANGE_ONLY on syzbot, and hasn't been
> > observed since. For the most part, that should deal with this case.
>
> Are you sure? I had KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dy here and saw somet=
hing similar a splat. I=E2=80=99ll also double check on my side and provide=
 the decoding.

The data race you reported in this thread is a different one (same
function, but different accesses). I will reply separately.
