Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B0C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFB82081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfehPDJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgAOVxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:53:41 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43880 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgAOVxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:53:40 -0500
Received: by mail-ot1-f51.google.com with SMTP id p8so17463468oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 13:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rif7OTSlbjKeTverAR4D1rWAOFI/XOBA+YksPtckMNk=;
        b=AfehPDJoXfZ0wuTfgNJehsRLDPkD6ddrEE4bAhRtbUfgYwObP0HW4UuTok+WGILILx
         U6kCdNVJuLZ2IVBZlxBV+wT9zvpc54Dwwc3QtE7+kLRNgiPHAcAN7GybBQPulYg1yVxo
         8Am0b6iAibnpywmcsGSeQTBxiwBAsShvW4HnJ1BAXDGo1XewD29bohTS+/Qtv2lmFCH6
         66X+VXpwNl1M3wAKLNMDOdyPZn5M2/2owF/XdEHhJ0mMtVao0hVpE92+kQ27TO4f3Xnv
         J9003iTHnQ+83onBMJYWlBkMKHraR8pqW4XakZzSdi/vW3P3X7mYAT5JCeL1X+F0xa7X
         lzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rif7OTSlbjKeTverAR4D1rWAOFI/XOBA+YksPtckMNk=;
        b=LWUcldG76Rc0BEmsmZvB5JWwL1NLp8wp1vPWykbVbsog6LgnBPQOMIDjlD9hyHvHk1
         AbIG8zYGo9Lh6q67X62kD48+UpIER1Z1KUC/vZx22x/T5JpRTrJ54Vnn9H+KDFuPUnBX
         KDyc3HZUftD/2l/FBFIE9eoBe+qRlyOi7Tkx51lHm9QEp9ms9KJx0h23TmDlhSE3HS33
         fr8TvYtzFepmlpoVHmxqw6YVNychxeFgawNTE+tG8QGVyRIqT7u7VzLMggxskwJ/cp1c
         JCGtolHLh3MdPB0Zywjp+PQmJLlGp+NUnPbRUXYgjYkZ8Tx5dAvLgiyNcRekDqzBiDQ2
         PwZg==
X-Gm-Message-State: APjAAAVi7EZa/7pUugB+L/AvJWIoKZX2+XGvjFRyK+zLuESWZigEWecI
        xEFvPseNAEjqXqXOKSrmhmmNxAI1Rk/3DFPcQVo=
X-Google-Smtp-Source: APXvYqybLLkAFyebqGnNXeuiIeVRBrE8bP9ZScdLeM8OtwtBS5JVcy9oSUbmJvarBaDaX8nq7AU3NRX7n1/hkjEEp2c=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr4195764otk.189.1579125219729;
 Wed, 15 Jan 2020 13:53:39 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com> <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 15 Jan 2020 13:53:28 -0800
Message-ID: <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Taehee Yoo <ap420073@gmail.com>,
        syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 3:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> +Taehee, Cong,
>
> In the other thread Taehee mentioned the creation of dynamic keys for
> net devices that was added recently and that they are subject to some
> limits.
> syzkaller creates lots of net devices for isolation (several dozens
> per test process, but then these can be created and destroyed
> periodically). I wonder if it's the root cause of the lockdep limits
> problems?

Very possibly. In current code base, there are 4 lockdep keys
per netdev:

        struct lock_class_key   qdisc_tx_busylock_key;
        struct lock_class_key   qdisc_running_key;
        struct lock_class_key   qdisc_xmit_lock_key;
        struct lock_class_key   addr_list_lock_key;

so the number of lockdep keys is at least 4x number of network
devices.

I think only addr_list_lock_key is necessary as it has a nested
locking use case, all the rest are not. Taehee, do you agree?

I plan to remove at least qdisc_xmit_lock_key for net-next
after the fix for net gets merged.

Thanks!
