Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BEE2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="exPCUDNk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WW2P/omh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgHCKtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:49:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:49:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596451777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCcHpfOYP09p8zY14r/HtTxM2t9JURMOmwbTy+WTzEQ=;
        b=exPCUDNkIUSsEk+m93wt286ygaaCqgwqdD6dmnXCCpNcDlS+ANw9TPI9tyr9UedVBK91yK
        wVaETPEKGYC5SuiO+opVJKVO178taH1yV/dGFfN39zIxD3YgRh+SQcfpoUGQuET13hfuL9
        VY5+0MzVXbK17SuypLCIscQQk5nOETJePrsN7SpH255LdJGIceMxTGHnqJtDk2gm+VJSfj
        R36bdYgczuRW1CHB9G2WXL/hRvLovDRtGtlR0lj8zs6/r7n3svbJEBeGQBrgLPkrNopYWT
        OfqiQ9u0GZrFZ0ETjfYAHYPjudz5ETLh1r+1fP4Cy4T1KLe2SwNqm/5JGwKmHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596451777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCcHpfOYP09p8zY14r/HtTxM2t9JURMOmwbTy+WTzEQ=;
        b=WW2P/omh52HC9kFYVAeeg3h+L56cnLkgbjiWsO8VD72lowVNM28fz0fbaLs9T49RJDULRX
        eY0JDYKN9PJq8EAA==
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <873654m9zi.fsf@kurt>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt>
Date:   Mon, 03 Aug 2020 12:49:36 +0200
Message-ID: <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt,

Kurt Kanzenbach <kurt.kanzenbach@linutronix.de> writes:
> On Thu Jul 30 2020, Vladimir Oltean wrote:
> OK. I've reproduced it on a Marvell Armada SoC with v5.6 mainline. See
> splats below. Running with irq time accounting enabled, kills the
> machine immediately. However, I'm not getting the possible deadlock
> warnings in 8250 as you did. So that might be unrelated.
>
> Unfortunately I have no idea what to debug here.

lets look at the facts we have so far.

 1) When irq accounting is disabled, RT throttling kicks in as
    expected.

 2) With irq accounting the RT throttler does not kick in and the RCU
    stall/lockups happen.

Not much, but there is clearly interaction between irq time accounting
and scheduler accounting.

Can you please reduce /proc/sys/kernel/sched_rt_runtime_us in steps of
50000? At least in theory, reduction should bring the throttling back.

Thanks,

        tglx



