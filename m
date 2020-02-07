Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6416221775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKL2H2f6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGS7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:59:22 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34556 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGS7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:59:21 -0500
Received: by mail-vs1-f66.google.com with SMTP id g15so286758vsf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H817kb+TRBD1h4LUB3Ukky8EOqe52Svp7faYKT4ZNGM=;
        b=lKL2H2f6NiNC4P18q03a++A2ynwvi1BWwGLT2AS86hRpSYRJna3ne5s3liyuTNAZfH
         YYVFs52SdjgqmFcDE8rOPRfAIsl8akZujgAmKuVQJ+pU+TkYwrEwghR2TihOEcLaXreO
         B9yFE/wKOzbUfhK7YOtKeU2EaTz+NlEgFX6nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H817kb+TRBD1h4LUB3Ukky8EOqe52Svp7faYKT4ZNGM=;
        b=laAGH3u8U4p582KV0Gs9+2uSjfisq6qJ+s/l3rjebFLvdCphorRWCBWPWW1g4NpVt2
         STqiFIUdGcPDR2N2cmKZVgEpN4koml+zxZ6Yy1c8S6L5Ag7C/iIhD8qW3IyqRE/ymgRq
         TnPbMcUbGfkW2JQBOZNvWHfRgpYHG04gfMHa5JlBVBGTfSRNQrZLW3We0b62EgX4dXXb
         jcg5StfTxDhc6qh42FFPFqJaUIgOuxvJo7AexgLyVeDndGx9BBUWK1FMDXZ1s6NGGRHs
         mZ7irVVBvEXpuZt7WmuxRch82p+YajQ7+WUwhs1i8fa4Au8NAj3SM7qsamIcM9yd7nRr
         W2rA==
X-Gm-Message-State: APjAAAXMQKjwJyNrEQZJbHbRoXLB2bWcMmmaFkdyBS2SDIxemsTB8cLi
        UIcJGXDpjhY/tV9ke8tdMUT8RVbs1Vc=
X-Google-Smtp-Source: APXvYqxUL9SPLvB0TOFVD0s5Y5kreD3TX10WVwr6kk46lWJzMfAqYdDA4AlNLctlvc+Uh6qqCz49OQ==
X-Received: by 2002:a67:fa1a:: with SMTP id i26mr417968vsq.169.1581101958648;
        Fri, 07 Feb 2020 10:59:18 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id l193sm1346040vki.42.2020.02.07.10.59.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 10:59:18 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id y23so238564ual.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:59:17 -0800 (PST)
X-Received: by 2002:ab0:690a:: with SMTP id b10mr106978uas.120.1581101957368;
 Fri, 07 Feb 2020 10:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20200206191521.94559-1-swboyd@chromium.org> <20200206195752.GA8107@codeaurora.org>
In-Reply-To: <20200206195752.GA8107@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Feb 2020 10:59:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VX1Kh0UhJBX2JcSjSo7KaSQggicnVFYV8M31ocx3PYpg@mail.gmail.com>
Message-ID: <CAD=FV=VX1Kh0UhJBX2JcSjSo7KaSQggicnVFYV8M31ocx3PYpg@mail.gmail.com>
Subject: Re: [PATCH v2] genirq: Clarify that irq wake state is orthogonal to enable/disable
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 6, 2020 at 11:57 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Thu, Feb 06 2020 at 12:15 -0700, Stephen Boyd wrote:
> >There's some confusion around if an irq that's disabled with
> >disable_irq() can still wake the system from sleep states such as
> >"suspend to RAM". Let's clarify this in the kernel documentation for
> >irq_set_irq_wake() so that it's clear that an irq can be disabled and
> >still wake the system if it has been marked for wakeup.
> >
> Thomas also mentioned that hardware could work either way and probably
> should not be assumed to work one way or the other.

Right...

...and then (paraphrasing) Stephen pointed out that policy makes it
really hard for clients of the API to work properly.

...and then (paraphrasing) Thomas said "Good point.  As long as you
document that not all drivers _actually_ behave the way you describe,
it's fine to add a comment saying that drivers _should_ behave the way
you describe".

Or, said another way: if a driver doesn't behave the way Stephen
describes then it should be fixed unless there is some reason why
there is no possible way to make it happen.

(Thomas / Stephen: please correct if I got my paraphrasing incorrect).


-Doug
