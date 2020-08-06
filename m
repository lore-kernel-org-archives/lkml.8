Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B011C43600
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE0C22D0A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GYDAHSN5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZX39Ynp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgHFKVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:21:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57264 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgHFKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:20:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596709253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ge+JX+cdMitocjDLHQfgYX/vUnt+cVAX7PgNeviNeYs=;
        b=GYDAHSN5wkxgqmkAARRIaQUULLn8vk8ySHSMhINwSAdhgazH5jbckkmVRnelkdmV2tKBjS
        1+daZnxX2NEX5S3lieDFoEgmVNricvPRH5hQ+wveC/1nlncNhPptRzXolIqh9gOjblmPpk
        AplFijjBd6qmFDQaFWysZ30V+xvccLhQAuq3d32WZvXTFwstk8oHdS8SjPpb+YyUU6zCDi
        43O13wf+ntR6VEGk4dlT6beJXu0y+sxC1LK65r0AkP5871d/ZddnSLEKg7U81KtLS8nPzQ
        DUgC6JyiJy6pXeP8eKp/LNG54gmwJU9L8ZLZPj6/0E2HDIpOiXgLPEsqrcVvPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596709253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ge+JX+cdMitocjDLHQfgYX/vUnt+cVAX7PgNeviNeYs=;
        b=2ZX39YnprqfHb0qiYbvBSregfP4dhiP3FRpCZTtLiGg1vT36FGj3zGB7kK4t8ifjc7IfVP
        A4ybL42RSHFG/oCg==
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: siox: indicate exclusive support of threaded IRQs
In-Reply-To: <20200805061753.5o63zu4ionhgjab4@pengutronix.de>
References: <20200804091603.541-1-a.fatoum@pengutronix.de> <20200805061753.5o63zu4ionhgjab4@pengutronix.de>
Date:   Thu, 06 Aug 2020 12:20:52 +0200
Message-ID: <871rkkhy7v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
> On Tue, Aug 04, 2020 at 11:16:03AM +0200, Ahmad Fatoum wrote:
>> Generic GPIO consumers like gpio-keys use request_any_context_irq()
>> to request a threaded handler if irq_settings_is_nested_thread() =3D=3D
>> true or a hardirq handler otherwise.
>>=20
>> Drivers using handle_nested_irq() must be sure that the nested
>> IRQs were requested with threaded handlers, because the IRQ
>> is handled by calling action->thread_fn().
>>=20
>> The gpio-siox driver dispatches IRQs via handle_nested_irq,
>> but has irq_settings_is_nested_thread() =3D=3D false.
>>=20
>> Set gpio_irq_chip::threaded to remedy this.
>
> Sounds reasonable, but I have to keep this for others to judge if this
> is indeed how the irq stuff works.

handle_nested_irq() documentation clearly says: "Handle a nested irq
from a irq thread". As a consequence the caller of this function must
run in an interrupt thread. This is an optimization to spare tons of
interrupt threads and context switches.

So the solution for this driver is either to make the dispatch handler
threaded or use the hard interrupt variant of dispatching the
demultiplexed GPIO interrupts.

Thanks,

        tglx


