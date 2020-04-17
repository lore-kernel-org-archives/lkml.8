Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D886522246
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4M0Zv8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgDQXiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDQXiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 19:38:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8271C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 16:37:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so3783348ljl.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 16:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OwtuK/s6W98pXxiI5acjuuYp0wvirEHlnDfF8kmK+I=;
        b=C4M0Zv8sLVnF9ulFyhcznLXWxGiTaYgZW51iES3GQdizUFcn6DfTol8hhu8eBD0if2
         nt3ABj66Ryz5Jalpcr78fBgxogNhpWvUEJTyFJcUcooFo1Agap8Sa4NBmGTXVil4//DN
         oPtjBiTsFhAQ7gRcxRK6QzC+Jv6AkDvsFtAnSEKL48TTpJrrFc32cxt5UaqeoWaZzvy2
         /+Qez1aSinQ63IEHqPNWduOhyry3/XnErGULSg2TPduZdNU6QV1h6dJq46No4fWDtFPz
         suqC6/Xx0a/rKXRy+f70HWmlahTkTkQnvuLiTF6BnW0S9EFdGF4lX0Z67yXTHWFtiPKv
         3YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OwtuK/s6W98pXxiI5acjuuYp0wvirEHlnDfF8kmK+I=;
        b=oyjF7FqJA56rnSuDhrt3h6FO+lF3IgLtJDxgJWlaldtxNhBIIXs6XK973emHsLQaNX
         68038ZjbwIK5kmaF9vjrFYXW9X6vzlGWw+BeM6SBs+sbVoH7JUnPa4qn8vzyANs8neoJ
         2tmlR/0QJHjbJ3pa3YjQHyjZNySXfOF3TDCLeMb+8sgBjKEJDW6Tr8ndjiZudLkB/ssV
         hy1Mp1RY6kpuePszZ7UtJRLOnWspnNgqJwJktEjj46cs5mF3gf4xTpduieK50UYIZy5B
         vZOftTcNdUysE47kf6StCGwnQh51pNEPI5G/fckGKyhq/lIYNTSrNHx6//8zEw/+n+So
         5Kmw==
X-Gm-Message-State: AGi0PubdV9bZDnI4xcbfEcZxVXTUwrA0xmNBwmtSSE/WNp8FM6F5jQoR
        HuzbK7qadyODjaud7WybDoEuS/Tybsrc23M1HxlW1w==
X-Google-Smtp-Source: APiQypLR6SXkGBE9agdmWjxJ0FAGrwnz8sWQpv0qDFlgkLQzOGFVtZmQFGeel4Dhem1fG+IDjHQB7l2DwUWhPvhdsBQ=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr1681220ljg.99.1587166677983;
 Fri, 17 Apr 2020 16:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200417212045.16917-1-robh@kernel.org>
In-Reply-To: <20200417212045.16917-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 18 Apr 2020 01:37:46 +0200
Message-ID: <CACRpkdau0X1y3N6ryJaTA7BK2MdCHVsG_X2bpQKp0mP5VQTucA@mail.gmail.com>
Subject: Re: [PATCH] clocksource: versatile: Allow CONFIG_CLKSRC_VERSATILE to
 be disabled
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:20 PM Rob Herring <robh@kernel.org> wrote:

> The timer-versatile driver provides a sched_clock for certain Arm Ltd.
> reference platforms. Specifically, it is used on Versatile and 32-bit
> VExpress. It is not needed for those platforms with an arch timer (all
> the 64-bit ones) yet CONFIG_MFD_VEXPRESS_SYSREG does still need to be
> enabled. In that case, the timer-versatile can only be disabled when
> COMPILE_TEST is enabled which is not desirable. Let's use the sub-arch
> kconfig symbols instead.
>
> Realview platforms don't have the sysregs that this driver uses so
> correct the help text.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Linus Walleij
