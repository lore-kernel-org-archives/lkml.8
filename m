Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76094C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B0D2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f5nfhowC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389590AbgDBRYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:24:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55608 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388815AbgDBRYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:24:49 -0400
Received: from zn.tnic (p200300EC2F0A0E00F19031BC22499B7D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e00:f190:31bc:2249:9b7d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 430A31EC0591;
        Thu,  2 Apr 2020 19:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585848288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Q6GiElcQkq+dZDwC5PRKZy++E6fBbkRBQ4bpalCpiE=;
        b=f5nfhowC1u72b2wdBBiCPL//sSUnmTuc5gnAA5075MX4UzuaXhc3++02D93MUJ4dT7zYUy
        8+17/RTZ0HSXgCZv0FXv8AyMcO8irtTqz790pZERh5+HcHkxZjiiJnse1Afg/qrBsOhCAC
        JQuJ8khcskAo8bWV2+tfaYCt/w7Go44=
Date:   Thu, 2 Apr 2020 19:24:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Matz <matz@suse.de>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
Message-ID: <20200402172443.GG9352@zn.tnic>
References: <20200331080111.GA20569@gmail.com>
 <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
 <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
 <87v9mioj5r.fsf@nanos.tec.linutronix.de>
 <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
 <20200402134051.GC9352@zn.tnic>
 <CAHk-=whCw-WFbHhq6uYZcXrMEoi4y_FhZk48adf4JePxBzmFsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whCw-WFbHhq6uYZcXrMEoi4y_FhZk48adf4JePxBzmFsg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:00:26AM -0700, Linus Torvalds wrote:
> But while I love looking at small things like this, and I'd like to
> have all compilers support it, I have to admit that it's not likely to
> really _matter_ much.

Yap, doesn't look like it.

But, TBH, I have myself wondered a couple of times, "dang, if that
asm goto only had outputs" so I'm thinking if gcc guys are bored and
wondering what to put in gcc11, why not this. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
