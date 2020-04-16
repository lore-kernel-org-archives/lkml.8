Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C3C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B6E2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emw+j18j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504261AbgDPJwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504196AbgDPJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:51:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50333C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:51:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 131so5067562lfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=paRo5UDnOEg7qB4hHSdBgPIcs6LdtLmC5yNkL7Ll0CA=;
        b=emw+j18jwjwelvCaDl9OIoc00snNDkHMEg3SXQYKMmCQE8QeCaRjaWItbj118CrGKd
         Q3wu2BjhEOoJmsb3xVTGfQyUaIMlfRWf6u4AStboFovGsr5VA6SQqdkLT712SB5nBYpI
         2CPA8ALmU9t43tc3pp2TWDfo3ZwzWNho918zPcG3W3SeqAnox1dbYlkjJTnJsmXJLZxq
         9zHi22Od8Xv5w4Q6BhzAOO20ZzW6ahmgTk9CHh3K9OA+8KZC+c0VFwMpPl2tg/CuS4zl
         /Og7doXYQjPOVy0m7uOJfbCmrch/C6KJl2bYJ3fo+N0SEh/n5mSmrvb5czViS/wpPFs3
         Uf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=paRo5UDnOEg7qB4hHSdBgPIcs6LdtLmC5yNkL7Ll0CA=;
        b=Z/ZdXOCwV7pcRKebJxUrGVxyB3F1/vmud1OmF3QaAw++nakylEFlJSw/eURDDoSj5C
         LLndJgnSZadyNXz8fvEJHwIFh+Q3ovitCK+N0SMGwZaAON2VW1VsDlb/tjz4VKsT2rZA
         e1N9m/gve7aD9wE3Lms8hTGbhdGewvXvsIztMoN3t/KFADv6qk9ukJs+jYBB4oiDl1XY
         5LSstKQsdlwDOgP+vq7Q9p7GWIPdFuPuSe+vS0FpQNqGEQMDi9TGF3HCm5YgOhrVFGCU
         nqt5beWv8aI4iTUYdfFSmq2Z9TtpQzApPp3hwEhVrMpV33Z2Lt0QYNQ4aDm0yEpxq8gg
         nwJA==
X-Gm-Message-State: AGi0PuYx83ic4C7MUcUBmYGDPo33TRNjYDkhPtr5OEmhiEzCAbPCOTX0
        tBa1ZcQnoK6Q1p6cXSlgRzWf718g+8D/fSEblOd2tg==
X-Google-Smtp-Source: APiQypKKiyFtcyG49CuIMjXwPUlmjO8yWBg30XZ6TNDLdtPi+jH4lYkPRe9MwqKLwhMwG2r9RcsdRpSpO8JCJTCwiMY=
X-Received: by 2002:ac2:5c4e:: with SMTP id s14mr5643988lfp.77.1587030709790;
 Thu, 16 Apr 2020 02:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200406160914.14698-1-rminnich@google.com>
In-Reply-To: <20200406160914.14698-1-rminnich@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 11:51:38 +0200
Message-ID: <CACRpkdYVwFiCf5MJGLEyhxL8omxr9Tav=8Le_zEX-D89SXjV1Q@mail.gmail.com>
Subject: Re: [PATCH] mtd: parsers: Support '[]' for id in mtdparts
To:     "Ronald G. Minnich" <rminnich@gmail.com>
Cc:     =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        rminnich@google.com, Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 6:10 PM Ronald G. Minnich <rminnich@gmail.com> wrote:

> The MTD subsystem can support command-line defined partitions
> for one or more MTD devices.
>
> The format is:
>  * mtdparts=<mtddef>[;<mtddef]
>  * <mtddef>  := <mtd-id>:<partdef>[,<partdef>]
>
> The ':' separates the id from the partdef.
>
> On PCI MTD devices, the name can be the PCI slot name,
> e.g. 0000:00:1f.5. There are two ':' in the name alone.
>
> Change the definition of <mtd-id> so it can be bracketed
> with '[]' and hence contain any number of ':'.
> An opening '[' must be matched with a closing ']'.
> The ':' continues to separate the mtd-id from the <partdef>.
>
> Signed-off-by: Ronald G. Minnich <rminnich@google.com>

It's a reasonable approach, I was a bit confused for a while
because [] is both used as literals and as meta-characters in the
syntax description which becomes a bit terse.

But it's no big deal so:
Reviewed- by: Linus Walleij <linus.walleij@linaro.org>

> Change-Id: I17a757e65f532b11606c7bb104f08837bcd444b9

Upstream don't like Gerrit IDs but surely the maintainer can drop
this when applying.

I suppose the use case is using PCI-based MTD devices for testing
something android images on desktops? I'm surprised it didn't
come up earlier.

Yours,
Linus Walleij
