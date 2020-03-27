Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1758C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C452620705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT7ZlF8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgC0K2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:28:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44619 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgC0K2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:28:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id j188so7390227lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxagbeVNh29/16YYCqUxcED/GWqaMY2FRZILhD+326E=;
        b=pT7ZlF8+QDzNnMTTTXVJzakDoz3QhyP01pvtfVf0GteWt8Tf11MzXads6cx+Bxozvu
         7IwWHj/EYxLdmAYqXnu3Dzq90WiKIW1empmHvyFt/AijbOBlBUPhW9nmE2JZVehlJgbN
         NTBGYVH9UGPZYUQvd1FVnU1m+KgpfMrj1zgXu57yRBx1DphOpbDs5CkZl7+u8sMvhhir
         L0RR25GHO7Mz1GtSu1HvgZbbECv5HQq9Emo2s9Ikp/ipzszJO1hknf2CNh7MSQPqMofd
         Wt5/puPA8rg9AyH248JalQ2H9s1xyFn7arWrt7jY9PjKFWBKQSS+Wfej7e4Z6HSZ+hVK
         McaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxagbeVNh29/16YYCqUxcED/GWqaMY2FRZILhD+326E=;
        b=C4r277mURxQHrYXTjcY262oyic4Ei3XN069Ryub/cRu3fafInN/kr0XCRz/5glQk1f
         NzuliLrTxZaeE6b2CZCicQ5Ij8xPgc0n82FFNMQJXHxgqsFgu1bDg2Gs1Qa5hEFm96ji
         TcPaqTIXZr8bQvPk3w6+4oXYgxXK1uRQaKq2LHW0cfgX8B5ria74ifsGCMt9coFl9U1B
         Kq7U153qaZZcTtUAup5NFpD6kEh3ZN8JRS8xi89g6RsgmhDvym4b3TwpBc3ZuFD7TVgZ
         zsdM4UVz8VzGn/kaSTRsvvKRayW8wR1+HbghsBEnsoWzH8lURfyaWC/oOg+AeY+/xHpI
         vvpw==
X-Gm-Message-State: ANhLgQ0mwVSGHQ6xu7H4rkaX8VcCu0Bq1MGR/59gpkxEh9BemGj+iw0y
        gL/yfUl4QEyC+W0FHM7s5cDmZeBxbV0e8wZt7KgTLw==
X-Google-Smtp-Source: ADFU+vvZNwYjJkyVgssSDHPr3mydsb+13EqKSqnHmnCoyAtcRPGriExF6G69ogu4A5lq5aiiVUR+AM2Z+n1m+zil0U0=
X-Received: by 2002:ac2:5b49:: with SMTP id i9mr8745710lfp.21.1585304929987;
 Fri, 27 Mar 2020 03:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <002b72cab9896fa5ac76a52e0cb503ff@kernel.org> <20200319023448.1479701-1-mans0n@gorani.run>
In-Reply-To: <20200319023448.1479701-1-mans0n@gorani.run>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 11:28:38 +0100
Message-ID: <CACRpkdZZN9hfZ7ARRd+JbFKjfXDMa_M3wqYD1gPqUCiTpp=LNA@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/versatile-fpga: Handle chained IRQs properly
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-oxnas@groups.io, Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 3:36 AM Sungbo Eo <mans0n@gorani.run> wrote:

> Enclose the chained handler with chained_irq_{enter,exit}(), so that the
> muxed interrupts get properly acked.
>
> This patch also fixes a reboot bug on OX820 SoC, where the jiffies timer
> interrupt is never acked. The kernel waits a clock tick forever in
> calibrate_delay_converge(), which leads to a boot hang.
>
> Fixes: c41b16f8c9d9 ("ARM: integrator/versatile: consolidate FPGA IRQ handling code")
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> ---
> v2: moved readl below chained_irq_enter()
>     added Fixes tag

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I wonder how Integrator keeps working so well despite
this. I can't test it right now but I'm sure it is fine.

Yours,
Linus Walleij
