Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFAEC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DF224682
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kX2dO2lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbgBNP6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:58:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46915 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbgBNP6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so9551637otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bOcfoQZl3F8fqHPhjMMAa503NpXfsD6HMvBw5tSP8s=;
        b=kX2dO2lu3E8rOEoTVvCGYM8nPGoKdlDT8ZvHPHxRs3BzVhUSkxcCw6K24Y5aTtU5si
         +Ux5zL5Msjyx4lSZ/GeC2SApmABaIF5o7Wc2sn5Qi37BFA3bS/8cI9O/dAX9zoVOw6Rk
         tP7Ie6F3omocpszOy7JJPoqv8s7Mr+IYE6Wtf30DD3zw87++2OcYkknPGZLTjz6pIeyc
         jWc2ZI6heV1WH6u0CHC2nW2yYe1YZ/yK4yHg2FP1KqVlCiLhi1MXjQlr6h4I0ICE9pM2
         8I357YnqPF2jqYz8P+jqGhFPLOfuRB8FXsCmq4Xm+moi+nt0eu0jnuhQMyhQeELq3wWP
         GUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bOcfoQZl3F8fqHPhjMMAa503NpXfsD6HMvBw5tSP8s=;
        b=BMDqB6nx/2LIsEKDDkkCXY6iePLWQjeyUUsxjdND8njtU5aMqSPNlCqB/7QmSwhds7
         JOtYflerzb/b5sJh84SQNAkIIjUgdgXQBFFzkpdhOQzXvE8vlBNRRTTx7qpn5VwwwK7V
         uZ5vqlRGv7V7wPkpU+YmYM/Vx9P+ozLuQk23JoHoLfmK1xwmWl6JhuntgOYROZqyxLwU
         m87zo1uhVRaCrVZ+odWdIDh7iXciIl62cRPuU2YCDXu/oB4/bK5duPlIeNQiZJ+KDBhr
         bwMyTkaPiERPiFrh6pEQXyZk+n0VKgskQKyGagKRA862aEwxkyOUAUvtcgAeNMWGyQMN
         H3lQ==
X-Gm-Message-State: APjAAAUwQYJWWA2axRAT+hNOJbfAENUW+40dw06sQG1R1uLNxcLkqkY2
        1nzBxQpeMKD2G/5ljsx9NsUH0AiaghVYM0vUNCUgRQ==
X-Google-Smtp-Source: APXvYqx/d2a81Pp+Cm6kjutLv1Fu5WDfEbx7fVbqijNpFcOhTEbMgyI36CNkD4gkBX+WP0IRrYbqgpVyWl7QA1EJGT0=
X-Received: by 2002:a05:6830:13d3:: with SMTP id e19mr2830279otq.135.1581695904754;
 Fri, 14 Feb 2020 07:58:24 -0800 (PST)
MIME-Version: 1.0
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com> <45ce930c-81b3-3161-ced6-34a8c8623ac8@arm.com>
In-Reply-To: <45ce930c-81b3-3161-ced6-34a8c8623ac8@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 14 Feb 2020 15:58:13 +0000
Message-ID: <CAFEAcA_yZ55rOD1x+FE9wYO8HXx9seK72ZCmnWjtDVr_95-whg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 at 04:23, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 01/28/2020 06:09 PM, Anshuman Khandual wrote:
> > This series is primarily motivated from an adhoc list from Mark Rutland
> > during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
> > which does macro replacement for various open bits shift encodings in
> > various CPU ID registers. This series is based on linux-next 20200124.
> >
> > [1] https://patchwork.kernel.org/patch/11287805/
> >
> > Is there anything else apart from these changes which can be accommodated
> > in this series, please do let me know. Thank you.
>
> Just a gentle ping. Any updates, does this series looks okay ? Is there
> anything else related to CPU ID register feature bits, which can be added
> up here. FWIW, the series still applies on v5.6-rc1.

I just ran into some "32-bit KVM doesn't expose all the ID
registers to userspace via the ONE_REG API" issues today.
I don't know if they'd be reasonable as something to include
in this patchset or if they're unrelated.

Anyway, missing stuff I have noticed specifically:
 * MVFR2
 * ID_MMFR4
 * ID_ISAR6

More generally I would have expected all these 32-bit registers
to exist and read-as-zero for the purpose of the ONE_REG APIs,
because that's what the architecture says is supposed to happen
and it means we have compatibility and QEMU doesn't gradually
build up lots of "kernel doesn't support this yet" conditionals...
I think we get this right for 64-bit KVM, but can we do it for
32-bit as well?

thanks
-- PMM
