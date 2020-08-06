Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66656C47274
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988F522D02
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0en1W3fo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eBnpOGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgHFJlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:41:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57040 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHFJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:41:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596706866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7h1NwChE7k/KZnYmQuWPK12OfyVN6+DmIy8syMh+/Ks=;
        b=0en1W3foTyJQ/a3ORD69xVDuy6RGBmSpumUZOiO+zNNjdZ98YVdw025EVEVh0vFD7aYK5L
        I7/sw6SwqJ06boKGugm4ApL7T7jZi+K3MSw9qlCNmFfu9EErsq8zZIiorKQ3pqjJO/xSAH
        dXWv/P+S53NyOmxXmnn1hUvYJr7J6VS8rDiEaRTxqjuOzhYYRsVWfUQwB6kW+jys94AT4a
        HEswFNxvCS+6lkzecrs4K1zQ+a1c6eK50+ACvB9c97Pt0WIT9KYaegmfP1iAwrvUpKUUKx
        cr6Twjjgi6OcvnBtrgXF9m3y8Ei6KtDwlkecdJqbBsOGPUVfBIIARWxzghzVxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596706866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7h1NwChE7k/KZnYmQuWPK12OfyVN6+DmIy8syMh+/Ks=;
        b=4eBnpOGf08nGpnL+jnNqH5dmgNbgf5eT0rVBjjVBHEiNG3JQgMsYvX+22Ccpdz12hJBVUZ
        WJupblTyigLCvCCw==
To:     peterz@infradead.org,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <20200805153120.GU2674@hirez.programming.kicks-ass.net>
References: <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf> <87d047n4oh.fsf@nanos.tec.linutronix.de> <jhjh7tjivew.mognet@arm.com> <875z9zmt4i.fsf@nanos.tec.linutronix.de> <20200805134002.GQ2674@hirez.programming.kicks-ass.net> <jhja6z9i4bi.mognet@arm.com> <20200805153120.GU2674@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Aug 2020 11:41:06 +0200
Message-ID: <874kpgi025.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peterz@infradead.org writes:
> On Wed, Aug 05, 2020 at 02:56:49PM +0100, Valentin Schneider wrote:
>
>> I've been tempted to say the test case is a bit bogus, but am not familiar
>> enough with the RT throttling details to stand that ground. That said, from
>> both looking at the execution and the stress-ng source code, it seems to
>> unconditionally spawn 32 FIFO-50 tasks (there's even an option to make
>> these FIFO-99!!!), which is quite a crowd on monoCPU systems.
>
> Oh, so it's a case of: we do stupid without tuning and the system falls
> over. I can live with that.

It's not a question of whether you can live with that behaviour for a
particular silly test case.

The same happens with a single RT runaway task with enough interrupt
load on a UP machine. Just validated that. And that has nothing to do
with a silly test case. Sporadic runaways due to a bug in a once per
week code path simply can happen and having the safety net working
depending on a config option selected or not is just wrong.

Thanks,

        tglx




