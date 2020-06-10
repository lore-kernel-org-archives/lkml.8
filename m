Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEC7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4CF204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzcvXjPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgFJLkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgFJLkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:40:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F2C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:40:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so2030195ljm.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3P0Ka1wCVHz8nfABo8/AoWh2f1DQKtjek9OpIbSue2I=;
        b=gzcvXjPk5e0YMFO3Jy4DiLzAkEDMQySBBtwQJ8Uzc42Be3vEID2pDEDnBxPYixeQ92
         L+N1gvZM3Xdm0LkG/0Lr0Dut0WjUMA5oF37M55+taHomm/uWMs1R2DMi/p1xH0ntMAWP
         Gvgrufw+IrNhqtGaLmBXRLHyqwHf8MIxPA5VE7SvU6v+IcGKM5Rlmmi803WrRIwT7b4B
         aPJFyGnsKr4NORap1bXoGC0707OyZil2lChJPTc9GORY53Zp2EKRjQst8YJs6S6RZhZC
         QNd04C+HwGPkr4fhcy76mPnQB9WQOCMYW4N2aLm3vvE0ssBTWXJqRtmM9hU2RZXMQ1GR
         UXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3P0Ka1wCVHz8nfABo8/AoWh2f1DQKtjek9OpIbSue2I=;
        b=ltZGAGTWnVOcEzVLvMIWD6MMq3NARAuchwuRXoCrQ+8DgAhn4fK2Gz1x2JwkJkStBT
         HVEvR5bLr0ag0jOlB7XCS/cM7hs51DELMrMP6lAUUv+s3G6+lb4+J03++qwLj4JJm9lm
         s2zu5nGGfFQTM4DCF6kyQ7nwFuDGOF+hdBbBku3paqA1pttCxLd5mS4GMsGC8Ug7Qitb
         XLBZo8hV4hOM8mjUOH4X8j9a7e9Diz6r+BeJb9irnBw1T31zcSx6xRZX0SnuZEGlNOhp
         dVhiJbwrzuV9HBudN10RrzTSvfcdZytRgt4LHuzR9z5dFebpw2kj5dzZ4FtqGAoGVN8g
         Fz+Q==
X-Gm-Message-State: AOAM530ath5OYxgay/8762Rd/26Y+3AcN5JRvmF/an9qYNyQXIEhxZmI
        M36JpatV+vlsKhQ3lRCzgOW6iu3DoS7BKZAgNVg0JQhW
X-Google-Smtp-Source: ABdhPJyaRhe8qpw1XZQ5sLwkKEMtvfKW20PZmltb0nNky9zkl90NlOBwZes/InaXRy8KomtNSv5QivttnLFVEvz1dL4=
X-Received: by 2002:a2e:880c:: with SMTP id x12mr736369ljh.293.1591789201394;
 Wed, 10 Jun 2020 04:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200608134300.76091-1-andriy.shevchenko@linux.intel.com> <20200608134300.76091-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200608134300.76091-6-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 13:39:50 +0200
Message-ID: <CACRpkdY5wAAVmsbi3UgJR4j_oofX5sDp=x0Pmag+w=L0XfRNoQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] gpio: dwapb: Get rid of legacy platform data
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 3:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Platform data is a legacy interface to supply device properties
> to the driver. In this case we don't have anymore in-kernel users
> for it. Just remove it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I really like where this series takes us so I hope we can still apply all of
this in some form!

Yours,
Linus Walleij
