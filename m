Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19768C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B1E20709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZQK34WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgEPJTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgEPJTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:19:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7ECC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:19:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so4732262lje.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dM0BobC3wqwwN5Q62CTiPLWvoTQfJfVxspTP6P93S94=;
        b=pZQK34WNGorGczQnl0DhCAuNv+Ko3oHeoxq97133u78ttw6KkKUz5JG3BdEFjBdl0U
         gOkPnmS+0c4v/Svk8DbaPYwObFHrup4O7Xrk80LncQCwq0TmwDWe1CE+Wk3dq5akGq4C
         H9eYezfkKEx7XSFayQP9jA3ppXkqtnkLz3jy4D18seAYonHNfF52rjyw+LGp7FvSFwvn
         dR1N2wFEI3OrfNOY9vAsesdywjuFrTrgYmXHTB86SHCo1HX7eqJmG/iF7bGi665RxxBl
         E8yURub0SF4yjZsEXNWvTUfil/fmkIbjnrC/jLB2qiQ5WdNqjBr5sEgwue+7YlRpJ0jL
         Q/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dM0BobC3wqwwN5Q62CTiPLWvoTQfJfVxspTP6P93S94=;
        b=k6tHyoNNGZCCUACi7Gzm7xgps5+rcxWK4WbSLAR4Xwoc/vvN7S92wJaEYOH+WqYLyH
         dLe3OFP6X/KoxFHnOX1BfkTYfSzecxwYBLpvJvSs5Hj5V+B81ReXJXZznkrsxPUxA2z5
         p9qecCnYGuKiEE5WosLy+p4sWMbqiu0N/kyx0dhxjBajmpw6TGIluuY9VQsrAgvMCbM3
         UO2Cm0Nj8oERXJMLJYEHhJOYqAfG1jZ+kaH786QFyaHs0XD35aDYpjdnB1+Y/DqTlSiW
         10uHK5xA/9U4OBDf+cTkd31iyVXgG3KpKBIvyk8Cc2jYWC+Ukz3q6xzuiXLPch7vL2KO
         MnnA==
X-Gm-Message-State: AOAM53172txRkdm8zODu9N/tin3tx32GtQf51yFswoZ1196xvEe5k5WB
        kn4nckb37txvcqxyHkNcYguq/b7gKkxN92Sif+JwKw==
X-Google-Smtp-Source: ABdhPJy0Il41Z0E9+Cc0Hy32EKCZqCdlt5D62mardObqBJZHA2MVu2Tw48zNe8Vs8DJ9kCtTHDIhOCL/MGDsAb7dryM=
X-Received: by 2002:a2e:9d5:: with SMTP id 204mr3708900ljj.168.1589620792399;
 Sat, 16 May 2020 02:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <e973f8f194ce4cb2639121572e8621b5efa5bfbe.1588823152.git.baolin.wang7@gmail.com>
In-Reply-To: <e973f8f194ce4cb2639121572e8621b5efa5bfbe.1588823152.git.baolin.wang7@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 May 2020 11:19:41 +0200
Message-ID: <CACRpkdYzZO_PaQu3gZ4SkyF1zWSrC+b5VjJmZfTuSVYgj=CGsA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sprd: Fix the incorrect pull-up definition
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 5:47 AM Baolin Wang <baolin.wang7@gmail.com> wrote:

> The bits of pull up resistor selection were defined mistakenly,
> thus fix them.
>
> Fixes: 41d32cfce1ae ("pinctrl: sprd: Add Spreadtrum pin control driver")
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Patch applied.

Yours,
Linus Walleij
