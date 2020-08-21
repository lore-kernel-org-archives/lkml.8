Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF29DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB5B207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amMeqn6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgHUNEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgHUNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:04:02 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC4DC061387
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:04:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id e20so511259uav.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnDW6llQiq63EFCJkVzXUzpg/vhNfgZSeuWupJPba2k=;
        b=amMeqn6McxsW9H4NO/zZ0Pb6Eri6A3hNoEchjDZnuAUewx5ku9PhXwwnoQth9vHp1f
         TMkmg7I90iD79l1oHaYDV6QvA6oZE4PAZF2h7NljHZ0tGjkOMlG1AMFdoQkqzfVWj1Zx
         eaa/JoPXiBcKKJ81CpQxYwwhKiI/lL6/MhRhK3wjGrrevWMyowenQyVMF7GXFHJIV0HS
         E5i2Jo1aR1RQHyiHsT8C3ImbQXLKI4Yn0xssjWKCcVEN9lZlFwAL+FuZqPQDECySk+5H
         qXxyN82zE415KM+azojrn33wRmo54AoRQ5RzgIdOB6Z/3BViWqJETPAXxIhGfIXKiXh+
         J+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnDW6llQiq63EFCJkVzXUzpg/vhNfgZSeuWupJPba2k=;
        b=fFAOqZabPMJQsz4uRTxx2R4FfTjNJ2cdqP9J3d0g8LC3d+yXGCfsl0xLNGGzo82ieF
         Os96Ru6i/ey7UQyREiD7NsiruZ4AlDJQvrPdv6dSHAfNHw5tASLRTxEZQpuy/wo/BuMJ
         t1fWexi7lntcndcdmq16v3tABpCL8sFu0BjGCgDdG84y6FN3en4PyyIn1BHlXUqjNBXz
         EMrLO2vFJBWE4io9Rpf9hw9+6YojFAAD4tbKXfGoavpTnewO1TGdD2UwugQEdrMcKu9I
         y789/2aliQTmDB3W10NQ8zApgQWC1qQYYzAMnrElBbpcrRbGVeOKbGVW5XiBAjuTcMNA
         9mdA==
X-Gm-Message-State: AOAM5326TInE1z1O6uP2yh0QcsykBi//ImB9Ig6kV+sS1rbRfWGJiuhJ
        VdtEijcRbhZZBMpv44xY8Idutx39wQfCcb5C1vOYpg==
X-Google-Smtp-Source: ABdhPJxYz1Bdm75WVJtCJBiqXNkdHyyC+9S/ilWhmuwkmkOMDXcKiZPrxqZmT9vVbW6PxuHSOTTLxtnagEQRkiuWcps=
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr1306910uay.15.1598015041353;
 Fri, 21 Aug 2020 06:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200804151345.28005-1-krzk@kernel.org>
In-Reply-To: <20200804151345.28005-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:22 +0200
Message-ID: <CAPDyKFqRq9u_w0AwhKELK11yetGj5nc9-bM9+-AOsQZVpVmZig@mail.gmail.com>
Subject: Re: [PATCH] mmc: s3cmci: remove empty kerneldoc comment
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 at 17:14, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Remove empty comment to fix W=1 compile warning:
>
>     drivers/mmc/host/s3cmci.c:400: warning: Cannot understand  *
>      on line 400 - I thought it was a doc line
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 444b2769ae2c..b5df948f8155 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -396,9 +396,6 @@ static void s3cmci_enable_irq(struct s3cmci_host *host, bool more)
>         local_irq_restore(flags);
>  }
>
> -/**
> - *
> - */
>  static void s3cmci_disable_irq(struct s3cmci_host *host, bool transfer)
>  {
>         unsigned long flags;
> --
> 2.17.1
>
