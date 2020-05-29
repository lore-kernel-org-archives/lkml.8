Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4ED207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="VDHKN3Ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2LpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2LpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:45:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA2C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:45:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u26so6635204wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80bZ25LFkYGpnK4fJsT/jM+faHqe+BrPlD3nVDw+J14=;
        b=VDHKN3KiPbGZ3Mzh+XkZikTPHkyenzVkfUUwGGUCDvfp6R/oF8pzZPhfjO74WCMiXF
         mgroetUQKkE5exrhLOpB39/PTeZQ9VHiMxUCxJA7paRI10BDZ7oSMoDpaODmQzfTtmE3
         qSR4XNxpu3P3rLBnNAgCHGx4rhtQik1REA2yABgyw2jIULosWqLwLfuLCwzE1YBsHiw2
         IPRlf7zwYiQ15DjBjiIiKhijoJPxjjZlBL4xSprayMNOlk+aNPL7zM4P1iS/8jbKkZX0
         q2AOJ43bY5CPs3kMQHlooAXFXR8zSyXCYCox5dD+2zeVO5MJxw/fxMWN0GB0DbYZR7+F
         56fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80bZ25LFkYGpnK4fJsT/jM+faHqe+BrPlD3nVDw+J14=;
        b=ZV12WvcD71X6M4eQqWb6mNsCW5V3zBNCbswrCfG7dmM9vEebFC9QVQz7VTgmQB50cT
         yyk20Ipz+J+2VarZy0ZI6se7oL/4NrhAIi7A7tc/gWZ0WeAhTKn+CVpZ8nasAR/ptzUZ
         x4t1bT9YiawDy9isXNsfs8qKLpPNHGCBztqyMweI5keP5MKVjZ+HtRkNuiK/KKUGla3j
         Ckf8/fZeJwJdASV3zUBMKO9S/QgUzirWaJCmf127GabfjWnFU367gTcV5PbRCc685d02
         cETivefkawtZ+RNmUScCuoV2wHzQZIc0HDJLgEW0yvVh2OxTb34e9aqk9hCDN9LPG/an
         5rTQ==
X-Gm-Message-State: AOAM530UB1EHcXLZL18aGl/EdXqNHePp+9jF+THp8rYNESaqeRoX+N+l
        N7ykVxRkl6wDOYGl6uEB114NWgYjsGUWAXRf1xQRrQ==
X-Google-Smtp-Source: ABdhPJwAtowAG1R+yTIBQVls0j6RQzfQagRw1F8EGcEDpRpbszT3jyUNP7ERJ23xR8mbw6h0K/RaOycTiqGZA+SQTSY=
X-Received: by 2002:a7b:c5d7:: with SMTP id n23mr8784679wmk.185.1590752715012;
 Fri, 29 May 2020 04:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200521133301.816665-1-anup.patel@wdc.com> <20200521133301.816665-4-anup.patel@wdc.com>
 <140c6fa723225ff138e8b39c4f16c9c0@kernel.org> <CAAhSdy1uRzsF7w_GMaPhfyNnRkhRNqT2edL0+96gwocWiXNpOA@mail.gmail.com>
 <40251a7764fc23ed19426df0adf0fc4d@kernel.org>
In-Reply-To: <40251a7764fc23ed19426df0adf0fc4d@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 29 May 2020 17:15:03 +0530
Message-ID: <CAAhSdy3iDbMSPeTSv7vM=1DSY8i1a1ugoB2Vxt3PY_if8JWJKA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] irqchip: RISC-V per-HART local interrupt
 controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:40 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-05-29 11:45, Anup Patel wrote:
> > On Fri, May 29, 2020 at 3:39 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-05-21 14:32, Anup Patel wrote:
>
> [...]
>
> >> > +/* Get the OF device node used by INTC irq domain */
> >> > +struct device_node *riscv_of_intc_domain_node(void)
> >> > +{
> >> > +     return intc_domain_node;
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(riscv_of_intc_domain_node);
> >>
> >> Why do you need this? Why can't the timer node refer to its
> >> interrupt-parent? The irqchip shouldn't be in the business of
> >> working around DT issues.
> >>
> >> At worse, use the default irqdomain if you must, but please
> >> avoid this kind of construct.
> >
> > Even, I don't like exporting riscv_of_intc_domain_node().
> >
> > Thanks for your suggestion, I will certainly use the default irqdomain.
>
> This should be a last resort solution. The irqdomain should
> naturally come from the parent interrupt controller, accessible
> from the device (the timer in this case) node.
>
> Use it to for backward compatibility if you *really* must,
> but this is generally a very bad idea as it allows all kind
> of bizarre fallbacks and hides bugs.

Okay, I will explore other approaches and keep default irqdomain
as a last resort solution.

Regards,
Anup
