Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839BC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2489120708
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgA1HHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:07:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47982 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgA1HHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:07:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwKyV-0007Av-Mv; Tue, 28 Jan 2020 08:07:51 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 29366101227; Tue, 28 Jan 2020 08:07:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull 0/7] Various tip branches
In-Reply-To: <CAHk-=wjQYcq=tFqGDm7HVHozrf4ijWyCBWqT61NJ9DYcHVKZjg@mail.gmail.com>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de> <CAHk-=wjQYcq=tFqGDm7HVHozrf4ijWyCBWqT61NJ9DYcHVKZjg@mail.gmail.com>
Date:   Tue, 28 Jan 2020 08:07:51 +0100
Message-ID: <87ftg05a9k.fsf@nanos.tec.linutronix.de>
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
> On Mon, Jan 27, 2020 at 4:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> the following pull request are my first attempt of using signed
>> tags. Please double check and yell if something went wrong.
>
> Well, the first one looked fine, but the subject lines were a bit odd
> on most of them.
>
> They say "[GIT pull] xyz for" without saying what they are for.  So
> there's a missing "5.6-rc1" there ;)

Indeed. Seems I deleted the check for that second argument when adding
the tag magic to the pull request scripting. Added it back now.

Thanks,

        tglx
