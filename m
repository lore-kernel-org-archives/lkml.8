Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5E0C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A9E206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2Mp3lE/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVjs9+S3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgHWVZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 17:25:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 17:25:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598217922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yde3fV/HC0Y1B8W0NPb3Q50q+roFFxPcDjy+qNnGptI=;
        b=U2Mp3lE/QUtkt/w2d+SLXdBfF8dmeem7kl7cA9xLDmxztOsVQKt7d3+jOig90NsTRDkj0i
        ZwEGaTAdgTLLvsf0ZN/yuguSZieDk7X+fYq/cV0UvdoFHoPthSYSL937ouquGqzkiiVqTt
        sgcPqVQ2Fs61aFQ8g25U4bKeCuur2uifyHQeVTI8lsCTnYrVFsWCdvmZ6uXwh8IcPr7U4K
        5jVhiPTrOpmQNHqzPPsZ8EIaZ912W0dKk9g/D6ojWcZlaqmdF25jCFkNHnGLZ4I8rGh+mR
        6r7cyWRgFQl1Lk4f4ZKytclLGWphUDsc0gfQSsWcjNvx93DdwSHKh80WpNYLJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598217922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yde3fV/HC0Y1B8W0NPb3Q50q+roFFxPcDjy+qNnGptI=;
        b=EVjs9+S3kNZRqAQEen2t4UZAvOjG+rwSNHtTb0bOYSdfF8rSCFQd/008uJ/PIZPP0VT0mA
        eEAn2yAfj4Ro0pAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf/urgent for v5.9-rc2
In-Reply-To: <CAHk-=wh1PRRxGgEaSf4TWcyja+_rbsmo6qy1d63vS4GfkV_tmA@mail.gmail.com>
References: <159817113401.5783.14776307451257171431.tglx@nanos> <159817113641.5783.13356693197176111647.tglx@nanos> <CAHk-=wh1PRRxGgEaSf4TWcyja+_rbsmo6qy1d63vS4GfkV_tmA@mail.gmail.com>
Date:   Sun, 23 Aug 2020 23:25:21 +0200
Message-ID: <87imd9qcla.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23 2020 at 11:16, Linus Torvalds wrote:

> On Sun, Aug 23, 2020 at 1:26 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> A single update for perf on x86 which ass support for the
>> broken down bandwith counters.
>
> Spot the freudian slip..

At least it clearly reflects my true feelings vs. the well designed
details of the X86 architecture.

Thanks,

        tglx
