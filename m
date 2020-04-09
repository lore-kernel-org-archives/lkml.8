Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E394720692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO1DuASq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgDIOM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:12:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45430 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgDIOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:12:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id f8so7969368lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Abtnmf2H4GjmeY7U38ZZMYXg4SwR9zyb96tOPx6/7Mc=;
        b=YO1DuASqxyD8T6jRCEoTkDPIGIizldoTg6W3xyVx6PUTVg6wT2Q6ddzlZ3Cpv99Q4b
         v26wRvuWJeGhBRJqhnsG3mc7cokRyt3/lrs0pJ9KYkDNIbaqHqft7lXb5S5K+T5+b9EO
         l7X9Qyi1xi0nm2KRYST4v8kGSXv28UegtQn5c5o+bG19HcRlOioe1VYgUNxgohpcx0s5
         Ym1USnQ2NgvKR6/FuYgzT115oVhiCZXAn9EZMEBnNBZfuYBPaa9dSBn7PkbOshltmcJG
         ZwEo7BZq6qjJwPuQpeD+7v/TvTDK7s8vvz/nhpUMF0YUWrB6cB7oTC0dtDX03KPeVDar
         LphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Abtnmf2H4GjmeY7U38ZZMYXg4SwR9zyb96tOPx6/7Mc=;
        b=NyOhliEsDH8dRQ5b3Xo9fFPsEwjA0E5UBhKJJWuhcmHAuPoraFGbdagV9Spf/buQul
         kLKODvZakttrbTlKBaluIbWagC7+g+PmBn1nu+PzHf4ztBsk32F1pOanP/GaDHLVJ/q4
         guj8MsUNmOLpyWvYjXdlrR0fDODCETjKw/N6bHSvqYyaGO9snqhFaCUljgafqRRe1lN6
         O1iU6BGrpgLxs14OKTUE2qKxU1fGqzaYjiCzUchKFFRAw2ge6PDCgQPJ5QChRyyZVKtJ
         DuPpvjTHlX92rdozqk45ljtzyJLGqZcNDbKey4coXosrKfYctxOqQgQuO5BQTdgSHLD0
         ua6Q==
X-Gm-Message-State: AGi0PuaxmI8FVgHGIZAg8Nyo/ew1ND298VkYVhsEW5ztt0Vca7W8BJBc
        ilL68ZnXDqrppozs7y/JGhS2LB7SLpDFP0NM5Hw=
X-Google-Smtp-Source: APiQypLPRfQADqALj4xrcoYDpTJKqlpVpYxFW6TD9eufyqdGlNTFvOBTDdeSt6pWxHv2niiQr+3Igr/2Ptd6d3vrOHk=
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr7908135lfo.19.1586441575243;
 Thu, 09 Apr 2020 07:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586422035.git.baolin.wang7@gmail.com> <f48d3b98debe5b2c1cc9a384874d6032b051a4c5.1586422035.git.baolin.wang7@gmail.com>
 <20200409104546.GA5399@sirena.org.uk>
In-Reply-To: <20200409104546.GA5399@sirena.org.uk>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 9 Apr 2020 22:12:44 +0800
Message-ID: <CADBw62p0O6dfiMF_r0SaN3cvrmcUdmnLm55gv_c=pywwzpTjoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] regmap: Add reg_update_bits() support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Apr 9, 2020 at 6:45 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Apr 09, 2020 at 04:57:58PM +0800, Baolin Wang wrote:
> > Add reg_update_bits() support in case some platforms use a special method
> > to update bits of registers.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  drivers/base/regmap/regmap-mmio.c | 29 ++++++++++++++++++++++++++++-
> >  drivers/base/regmap/regmap.c      |  1 +
>
> MMIO devices clearly don't physically have an update_bits() operation so
> this should be implemented further up the stack where it applies to all
> buses without physical support.

I understood your concern. But the syscon driver need use the MMIO
devices' resources (such as address mapping, clock management and so
on), if move this to further up stack, I am afraid the update_bits()
can not use the resources in 'struct regmap_mmio_context'. Do you have
any good suggestion? Thanks.

-- 
Baolin Wang
