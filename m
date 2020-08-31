Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC8DC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282452072D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrMbHras";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tU4ZIc3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgHaHMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:12:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:12:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598857967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0T5AK1WewHGFQuB5YXJMQjTPSmjOUGySbyGnm8WX0I=;
        b=YrMbHrasYKyLkWFIEIRoalEVyprNvplnrpACKO43TQIEXZatQRhNClTXO3+a7Us0XlkWJJ
        8e7+SfDSmSjSKiwn/24Vx2Ulrdqt/EBYzOGu8btpNNcx04oiOy53GrQwTn0h/kH5ewKQ1w
        T5PtPFUHcL39S/cTO6u+9ab8ttSB7Ss1PqRf5q/gd6+OEL9qZ8oKE+YorAL7awTzqtPawu
        9M9KL2HMxWCDnmDYMvXNgu4vRftwJClzz7BhDBO19jFr2LQV9d3ujuSfu423RViAnzTeY/
        bvzzGDQHJ+oJoa8j1Z1afU7V7gmmpWcadTMNgttzGVPXtRl2mat56QFYqmIMGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598857967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0T5AK1WewHGFQuB5YXJMQjTPSmjOUGySbyGnm8WX0I=;
        b=tU4ZIc3ojfzFE/Rxxslj1z2GcI/2vMo0RVOETFwJ9F5S0fny4QplnfFqACwf34N6RduVLD
        uM1KFOl4JntRVABQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
In-Reply-To: <CAHk-=wj16dFx2Mx1oO2oxhJjAmsaPOqLcGvEGb86-z+v5iu5tw@mail.gmail.com>
References: <159881061564.27993.11909051048930389391.tglx@nanos> <159881061925.27993.10669865438175129325.tglx@nanos> <CAHk-=wj16dFx2Mx1oO2oxhJjAmsaPOqLcGvEGb86-z+v5iu5tw@mail.gmail.com>
Date:   Mon, 31 Aug 2020 09:12:47 +0200
Message-ID: <87mu2bi900.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30 2020 at 12:13, Linus Torvalds wrote:
> On Sun, Aug 30, 2020 at 11:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>    The historical inconsistent for_each_cpu() behaviour of
>>    ignoring the cpumask and unconditionally claiming that CPU0 is in the
>>    mask struck again. Sigh.
>
> I guess we could remove the UP optimizations these days. It's not like
> they matter like they used to.

Indeed.

> Or leave the optimizations in the sense that they wouldn't do the
> crazy bit searching, but they could look at bit 0 of the mask they're
> passed..

Yes, that's trivial enough and the compiler should turn the whole thing
into a simple conditional checking bit 0 and remove the rest of the loop
gunk.

Thanks,

        tglx
