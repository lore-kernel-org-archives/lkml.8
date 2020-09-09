Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20816C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27C5216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tFSCEFZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgIIJep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgIIJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:34:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43370C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:34:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i1so1974179edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUQTv0UwcEAnnVIsbVlIPVNHF0/vxHu+weScX6eEMtQ=;
        b=tFSCEFZP3KHzbou/mPsbn1mzHp2NXTkmke31/SYSdOb0XcDRuVh3fAvvEu5gUijjBP
         0opI7TeH1UjoTSGwrtdgLGbddFfGlH+C7IqU+sgS8V+1FISSEZba0FS6XeYY/l+MbWU+
         4BI/T5Vx+O2KpAGzfL4Sc78I1xtdXQKpl9YWNm9myelO8L/P5bXmvMiscO7/8kv4lNFo
         cgpBuEMc8zdzsY8BbbO+IywssO1sCUeDIOedqw+IYxDuxaX4Vpd4lgdpE+cPoIQd2wdT
         eKVeyurIT1D+h74BvRJgVNonw7nPcNr15Y7abxXNHWLGtD3CPNNoLGKMeyqaVAa8a1hV
         V+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUQTv0UwcEAnnVIsbVlIPVNHF0/vxHu+weScX6eEMtQ=;
        b=FV5eFrFV75ZsY4ufLozbroLkx51uhFtOVUJB6oNnZBccw7RJA0ZIwWjaJWVjD4j60J
         dxFFiP4rbcZO8DEEOTbCS5m58GjIov/G+2iZJ7KP31TFUlQZ5naCOEhqwUQOQ8xjluGh
         gwpkTBRGWoUglwBb+07mFNcQyLLCTPqysxQyCtqBGB/84gzxxsZIE/okMM91BNXadA6K
         gqSfyYHelLvhsjD35GaxAAtz7j53BRMwgvRg11nRuMycRGggTfdUYR48RQmb2o60oT+n
         qRTMwEzSx6JtyD7CSRUElfd7OMQQ3xrMmqwEgNh23E2qp/h8zil9Kwln1y+CHqVTWeYK
         IWBA==
X-Gm-Message-State: AOAM530xnB7B/00AzObMmmKrs7KvS6plpwIgQbQyx1dA8wOaFmLXCXRJ
        fqh+1q5QElgp97CEj5k0+P4Lpji71ZaVLL+/tYsKbg==
X-Google-Smtp-Source: ABdhPJxNOSpau3trpVx/Rn+BectgwP2FY5BAAVC9ES7q0huam5mochHXxJCz6o9zOPMUI+uPUhYb+LtyekLKBrta8Os=
X-Received: by 2002:a05:6402:615:: with SMTP id n21mr3029737edv.59.1599644068361;
 Wed, 09 Sep 2020 02:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <1599118222-18990-1-git-send-email-dillon.minfei@gmail.com> <1599118222-18990-2-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1599118222-18990-2-git-send-email-dillon.minfei@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 9 Sep 2020 11:34:17 +0200
Message-ID: <CAMpxmJVcyq_QQsKzA6z-Qz24OL2tjgxo8vUUODnayQWa9D0F2Q@mail.gmail.com>
Subject: Re: [PATCH: V2 1/2] gpio: tc35894: fix up tc35894 interrupt configuration
To:     dillon.minfei@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 9:30 AM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
> The offset of regmap is incorrect, j * 8 is move to the
> wrong register.
>
> for example:
>
> asume i = 0, j = 1. we want to set KPY5 as interrupt
> falling edge mode, regmap[0][1] should be TC3589x_GPIOIBE1 0xcd
> but, regmap[i] + j * 8 = TC3589x_GPIOIBE0 + 8 ,point to 0xd4,
> this is TC3589x_GPIOIE2 not TC3589x_GPIOIBE1.
>
> Fixes: d88b25be3584 ("gpio: Add TC35892 GPIO driver")
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>

Queued for fixes.

Thanks!
Bartosz
