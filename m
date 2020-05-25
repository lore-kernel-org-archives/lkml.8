Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37206C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1573D2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbgEYJkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgEYJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:40:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3906C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:40:54 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jd9bI-00065f-IB; Mon, 25 May 2020 11:40:52 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A813A100D01; Mon, 25 May 2020 11:40:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] sched/urgent for v5.7-rc7
In-Reply-To: <CAHk-=wjkwxJZDjgrqqugzsW++5Oo43DvFL1z8Ei=+0FZuQ84uQ@mail.gmail.com>
References: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de> <159033288238.21635.76261789367356025.tglx@nanos.tec.linutronix.de> <CAHk-=wjkwxJZDjgrqqugzsW++5Oo43DvFL1z8Ei=+0FZuQ84uQ@mail.gmail.com>
Date:   Mon, 25 May 2020 11:40:51 +0200
Message-ID: <87v9kkpd24.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, May 24, 2020 at 8:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>    [..] overlooked a corner case where the first iteration terminates
>>    do a entiry being on rq which makes the list management incomplete [..]
>
> You had some kind of mini-stroke while writing that explanation. I

Indeed.

> tried to fix it up as best I could.

That looks much more like what I wanted to write actually.

Thanks for fixing it!

       tglx
