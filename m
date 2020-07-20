Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D9CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E233422482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCpPDtGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGTOtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgGTOtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:49:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F2BC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:49:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so180155wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dCQF7F+ay5jXE+ml8xQtj+pq5cdYa6gArESdvwR7ETA=;
        b=HCpPDtGbcoFu+VD6Wp0+UWsSaib1LLMOPAAH4BUmA1Yz7X0dQNyvDQ9rWYEuePSte9
         B91h1832zv4KK0ge7rlwQsZRq0Ijb1vdkCnMGYPABjJkRF+7azS45vDNaGY0EuEkf/O7
         UvIRSgaPcW0FfCCDVvSjr3jrbRlnnc1aNJIbNzsXgz2ijnsAfQ+18iRUAu9MRaCn421/
         YSTaVs9FcR5tu8yP50Ad9fRaVIb6iem9fc4RAcWhFsKhA4UM+suBwZ9JwdIXtgKiPsYt
         xtBOa9SzisvkTY7p8kLd9MV38jsjAdDlnFL38A29RCUu2BAooDorG9o2FEXmEf4qAKPw
         Xyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dCQF7F+ay5jXE+ml8xQtj+pq5cdYa6gArESdvwR7ETA=;
        b=JpOt+yN4Owa8szzJ0uFqgigDdCXYYgGcDxMaOWqe/+9hciAZ9SzMhBuEw7oC58Te1V
         tKbhZFXTewMAANnKzlcYwhkgjLO80KpnwHp/mxvkqSJHD/uHQZFwSVVlMqEtIB/gbzIB
         EN9oGfuBzwpOhWvdVnQceH/3rfbEg/TWTfO1ws8E/Tl/e+kQ+BXB10tW+5Fpvp5YY/lY
         V4B2QbubTO4hViJyjk3JcFlmE/IbT5e0os11oXwuWkEkt15SiUxbi1QntInAhTxvKOS4
         TFZZzXJEgdQJoONOhzLZVXAtI+Sx3vzvFcJ68r2fXOcR37JGqzhg7HXRBkkKJ+NsBeMB
         loOg==
X-Gm-Message-State: AOAM530g6vu16gKg3djSILbo5Y9CMquXpA2i6ZBMbaBx149PKPDpEtNG
        4iCVU609M3Oy4t6d4nkd4H2yMSrxGpM=
X-Google-Smtp-Source: ABdhPJzxdQKiviMvc7XJrEXZImwhFkzx66E/hxLhzoh7GRWAPmpapWv7ZiBJ3X3FKjDayEJTMuNq/g==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr21565244wmn.123.1595256555699;
        Mon, 20 Jul 2020 07:49:15 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id b8sm2591228wrv.4.2020.07.20.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:49:15 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:49:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 07/25] pinctrl: samsung: pinctrl-s3c24xx: Fix formatting
 issues
Message-ID: <20200720144913.GC3368211@dell>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-8-lee.jones@linaro.org>
 <20200720142727.GB6747@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200720142727.GB6747@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020, Krzysztof Kozlowski wrote:

> On Mon, Jul 13, 2020 at 03:49:12PM +0100, Lee Jones wrote:
> > Kerneldoc struct titles must be followed by whitespace.  Also attributes
> > need to be in the format '@.*: ' else the checker gets confused.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/pinctrl/samsung/pinctrl-s3c24xx.c:100: warning: cannot understand function prototype: 'struct s3c24xx_eint_domain_data '
> > 
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Tomasz Figa <tomasz.figa@gmail.com>
> > Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: linux-samsung-soc@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 6 +++---
> 
> Thanks, applied.

This has already been applied and resides in -next.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
