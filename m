Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A278DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D492070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BtmjxCtK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qr8Lr+Ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGXUDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXUDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:03:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E003C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:03:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeW9A/qlTP1o8VO5EnHYgVwdURE2GyvHXNk/PN9Dj5s=;
        b=BtmjxCtK8ctJgLSe8EjHUW2wx6+tzgzp71S39DtmA2VdicGT1NKLEFXkmc9HsIB3Lr3uqj
        2AiBktpkFXj8ke5ISYhdL28i6mjaV17dLXTqB6tEA3xGtwn98xeFrXJt3sW1poETBtmWm9
        0CrIW8HmtVRk0qnCA/nrf8IWN8nVHUgWbXwwjLvuZwpH89EICdm8zRCPzCfs9JdN/zioQh
        IJIOquRNKpSBpgy2OUIh+EEzSyeo+/vpK0x42UhtTSDxNg16X2NZuxGUBm6z6c/LLyn5Tl
        9dESUbP1iPqIuqnb1h9jhPnqg5QlMduPfBMYctzzg0LnWhN4rs1FQl5nSZcilA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeW9A/qlTP1o8VO5EnHYgVwdURE2GyvHXNk/PN9Dj5s=;
        b=qr8Lr+Ay0lMnpkHs46mGO8NrG8s/Ha1Lws3i6vjRcQBpkm3avItorbjRTpQo+X+JYSPbgO
        +XbGzm/Q4bv/hJCQ==
To:     John Keeping <john@metanate.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ben Herrenschmidt <benh@amazon.com>,
        Ali Saidi <alisaidi@amazon.com>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] genirq/affinity: Handle affinity setting on inactive interrupts correctly
In-Reply-To: <20200724182422.27ddced6.john@metanate.com>
References: <87k0z2s2q3.fsf@nanos.tec.linutronix.de> <877dv2rv25.fsf@nanos.tec.linutronix.de> <20200724182422.27ddced6.john@metanate.com>
Date:   Fri, 24 Jul 2020 22:03:50 +0200
Message-ID: <87h7twu1cp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

John Keeping <john@metanate.com> writes:
> On Fri, 17 Jul 2020 18:00:02 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> It seems that this patch breaks perf events on RK3288 because the PMU
> interrupts that should be per-cpu are now all on CPU0 so no events are
> collected from CPUs 1-3 and those interrupts are killed as spurious
> after a few seconds.
>
> I'm seeing this on 4.19.134 and 5.4.53 but as far as I can tell the
> relevant code hasn't changed through to next-20200723.  Reverting the
> backport of this change fixes the problem.

Bah.

> It looks like what happens is that because the interrupts are not
> per-CPU in the hardware, armpmu_request_irq() calls irq_force_affinity()
> while the interrupt is deactivated and then request_irq() with
> IRQF_PERCPU | IRQF_NOBALANCING.
>
> Now when irq_startup() runs with IRQ_STARTUP_NORMAL, it calls
> irq_setup_affinity() which returns early because IRQF_PERCPU and
> IRQF_NOBALANCING are set, leaving the interrupt on its original CPU.

Right. My brain tricked me to believe that we made activation mandatory,
but that's not.

I have some ideas for a trivial generic way to solve this without
undoing the commit in question and without going through all the irq
chip drivers. So far everything I came up with is butt ugly. Maybe Marc
has some brilliant idea.

Sorry for the wreckage and thanks for the excellent problem
description. I'll come back to you in the next days.

Thanks,

        tglx


