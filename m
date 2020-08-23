Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C517620774
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ymf1Powz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IJnNknW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHWWBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgHWWBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:01:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D0C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:01:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598220059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKVO7Wm54dysRevNdLz/KvbYh383bmrDlPAg6QCOvQQ=;
        b=ymf1PowzWit07wkPZES1918ry3nAJi9WKqbOX7Quw0ywNY/fPA9UXWqMzITJEegB0yJIH/
        5ZXT40WhSylUE3hNARIndCIWGze4Fwkzo+ZR5Eh4Km1odcCNEkGxVc4PbNC6+WRDPmrDXf
        mDyxEjPILDwYfogNRmFzwCaHybr+mTF79au7uCBPzuwVZ8JgKvkh+nujv/6hceikPUCikE
        VKd57AY3r6ckRD0TF+ETuElqYWtTLtDjtQBPSW2le/ORevR9gEEEZjM8npSbfd93aM01n/
        6Br+vIRDzrMmRX0GETYbSwWfKf4VHiXpI6l6bvJICqvDHmZFxbHZ6QD9BXUCzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598220059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKVO7Wm54dysRevNdLz/KvbYh383bmrDlPAg6QCOvQQ=;
        b=IJnNknW5RDBfVPTA/x443xN2WOEYtzeoTk+TRaRsx7tvYnOw/mA1RehCVOD1T7V5B5gwam
        ko0OY8zpb6GkLODg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
In-Reply-To: <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
References: <159817113401.5783.14776307451257171431.tglx@nanos> <159817113762.5783.6214320432160748743.tglx@nanos> <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
Date:   Mon, 24 Aug 2020 00:00:59 +0200
Message-ID: <87ft8dqaxw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23 2020 at 11:29, Linus Torvalds wrote:
> On Sun, Aug 23, 2020 at 1:26 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Remove the RDPID optimization, which is not even
>> backed by numbers from the paranoid entry path instead.
>
> Ugh, that's sad. I'd expect the LSL to be quite a bit slower than the
> RDPID on raw hardware, since LSL has to go out to the GDT.

We asked for numbers several times but so far we got none and some quick
checks I did myself are in the noise.

> And I don't think we need the GDT for anything else normally, so it's
> not even going to be cached.

Who cares, really?

It's pretty irrelevant because the main source of horrors are in having
to run through _ALL_ registered NMI handlers. Why would you worry about
the extra cache miss? It gets worse when the NMI handler needs to access
the NMI cause register and that happens more often than you would expect
in the cases where it matters, e.g. high frequency PERF NMIs, due to the
well designed hardware mechanism.

OTOH, enforcing the writes on every VMENTER/EXIT is insanely expensive
compared to the maybe RDPID advantage.

While my general reasoning is that virtualization causes more problems
than it solves, in this particular case insisting on a few bare metal
cycles in paranoid entry would be beyond hypocritical.

> Oh well.

My summary would be less politically correct, so I just join the choir:

   Oh well ...

Thanks,

        tglx

