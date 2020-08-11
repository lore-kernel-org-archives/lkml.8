Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F007C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A0820772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uA2yZ3mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgHKG4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgHKG4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:56:23 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317BDC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:56:23 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 93so9352856otx.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBONm3JGSIredide1r1f2aq4pO6yJwD51o3qC+jyQL4=;
        b=uA2yZ3mDI1T3Jw/4Vw6Q4OmEX9280h204wtCZslPvkbSbJ++eKzvSeAhhrNM1Wljp6
         Y7jwvdnHOJmxy2ME53uMlxfjGa8nNwPpcWr/eBJiwl2SQ2nnOnvaZ+SGE7nDsXWULQZ7
         l9ABu3WkNG0A+tWxm0LMfVE3BbTCxIiruxb7xHNggyPLUXgHojv9deY8GtcOSZFkTZtO
         SWPZ2yA5TVOEclgWK5w86Rcrjj3rOLPXLXaazg3ubnN7o5BLTV+YhfiDJ6Dr7w6+pFPG
         c95FeTXCtPyqJ+jsTtG0H21f7CTsb2o1m4nK/UVIA2rU4KEvTowNdSbe2y0eBJylenQO
         5PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBONm3JGSIredide1r1f2aq4pO6yJwD51o3qC+jyQL4=;
        b=s3RZLuRuI+dXEnxC6EdAOrRsPm1wa9qVCYoG6mfBSc6MCX3UCqvy2OnsnkH7M+PnW6
         i6G0E9jOlNnq77qbI6haElw1o89vSlwbnjRjOH0ZeZu6o5rFWjQ3i4ZjgCZRYFm9XPG5
         aX8y/onfwAX3NR8vSQgTc08mwJ6lDxo8MpYiZ1S+Hvg+lpCz/hNKjyYQBADM5xSLlmr/
         5G0aFAngE34yXoJA9Eia8/SHt6J8zjPQPKSH5ssqEeYafMHKhCTXNh5H8SXmJwabW2Om
         NtDp/V2qCO1htO+GoA+NJ6G9KOH2N6BquV7cS2+kgl6E+PcABbyikelWIqAWK3XZ7nEq
         J1FQ==
X-Gm-Message-State: AOAM531gs8EuSNiOYGymdzrafaJkjodVjr5MlFxivJFvoJmNIp/8PVhn
        Z8SAKlVkjURHisI2Ak2/+XmfgMbm2CCo87Nl9o3+tw==
X-Google-Smtp-Source: ABdhPJz0h+PAxT9CHR0cArH9HnFQg8IEq9+hbJ00AW1gM8CTFdKuHLfSLn6hydj29Nxks8KouNcv/78fjJVRgWKJJjU=
X-Received: by 2002:a9d:3da1:: with SMTP id l30mr3989495otc.233.1597128982279;
 Mon, 10 Aug 2020 23:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200807090031.3506555-1-elver@google.com> <87pn7yxnjc.fsf@nanos>
In-Reply-To: <87pn7yxnjc.fsf@nanos>
From:   Marco Elver <elver@google.com>
Date:   Tue, 11 Aug 2020 08:56:10 +0200
Message-ID: <CANpmjNPz8vZLGWUzO_8xxtxdXC7cODUL1zVyZf-rBKDBd9LOpA@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Treat runtime as NMI-like with interrupt tracing
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 at 22:18, Thomas Gleixner <tglx@linutronix.de> wrote:
> Marco Elver <elver@google.com> writes:
> > Since KCSAN instrumentation is everywhere, we need to treat the hooks
> > NMI-like for interrupt tracing. In order to present an as 'normal' as
> > possible context to the code called by KCSAN when reporting errors, we
> > need to update the IRQ-tracing state.
> >
> > Tested: Several runs through kcsan-test with different configuration
> > (PROVE_LOCKING on/off), as well as hours of syzbot testing with the
> > original config that caught the problem (without CONFIG_PARAVIRT=y,
> > which appears to cause IRQ state tracking inconsistencies even when
> > KCSAN remains off, see Link).
> >
> > Link: https://lkml.kernel.org/r/0000000000007d3b2d05ac1c303e@google.com
> > Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
> > Reported-by: syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
> > Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > Patch Note: This patch applies to latest mainline. While current
> > mainline suffers from the above problem, the configs required to hit the
> > issue are likely not enabled too often (of course with PROVE_LOCKING on;
> > we hit it on syzbot though). It'll probably be wise to queue this as
> > normal on -rcu, just in case something is still off, given the
> > non-trivial nature of the issue. (If it should instead go to mainline
> > right now as a fix, I'd like some more test time on syzbot.)
>
> I'd rather stick it into mainline before -rc1.
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thank you, sounds good.

FWIW I let it run on syzkaller over night once more, rebased against
Sunday's mainline, and found no DEBUG_LOCKDEP issues. (It still found
the known issue in irqentry_exit(), but is not specific to KCSAN:
https://lore.kernel.org/lkml/000000000000e3068105ac405407@google.com/)

Thanks,
-- Marco
