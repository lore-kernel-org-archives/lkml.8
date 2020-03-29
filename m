Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2836C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD49620774
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgC2SGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:06:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56765 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgC2SGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:06:40 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIcKT-0000EF-Hn; Sun, 29 Mar 2020 20:06:37 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DFFEC101175; Sun, 29 Mar 2020 20:06:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for v5.6
In-Reply-To: <CAHk-=whTDGWiaBcUfx2UhffL8FAPZ2Qy4dzmAcVoB+_=0vvx3w@mail.gmail.com>
References: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de> <158549780514.2870.1236107824707197925.tglx@nanos.tec.linutronix.de> <CAHk-=whTDGWiaBcUfx2UhffL8FAPZ2Qy4dzmAcVoB+_=0vvx3w@mail.gmail.com>
Date:   Sun, 29 Mar 2020 20:06:36 +0200
Message-ID: <87iminvxw3.fsf@nanos.tec.linutronix.de>
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
> On Sun, Mar 29, 2020 at 9:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> please pull the latest x86/urgent branch from:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-03-29
>
> Heh. I already got this from Ingo, where it was "x86-urgent-for-linus"
> and merged on Tuesday: commit 3f3ee43a4623 ("Merge branch
> 'x86-urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

Stupid me forgot to update the linus branch...
