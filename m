Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648FDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F72621841
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x62ukxN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632958AbgDPLZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633024AbgDPLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:22:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F74C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:22:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z26so7332897ljz.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jD1AYUXHP206GaKlRMZxnMBYwEQ2X8qjzb2HhhYNTqs=;
        b=x62ukxN+n8Qv4MX7jge+8oGRbA3SvBvHRYMCTqRMEuaWVF6QRNsqmoyaKT+erSHjEu
         WGs1fbbXWGTXJL+8ty/h9eYpXqPQWIccl9mnEQm8XIuWWTjvCCpW72h11tVxEcl6jP+g
         DCVBQkchGYN4GcZ1WL4GIh+YETEdlWFKXWBqdrAifVm13YxGFqYQkpby/YG2wSzDT1uT
         wOm6OE/3tA94BoxRfcxXEdoV+65rjYAGVRqAKedDvU16egHhvynyRhMihZiPqBmuy74W
         zjZ4kxB5uzRngQOICftxq7vejQXlduE8xLp5QyHJEuPPv6h4rioZlg/cfqkTJV0Z+e/u
         mXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jD1AYUXHP206GaKlRMZxnMBYwEQ2X8qjzb2HhhYNTqs=;
        b=BlElFoV8TYIqJTA8zvtkBG+adWtIA3TIfqLt6ddWgipwUS8TFz/RAZYKWBRFFNkw50
         pwKR2EqCN4BBwjZUnwUMqiBw0Plty3xJoBZuplcDQFdiQ7gBT4SE0hSOiF/Nc134t+c4
         5t2seTG7TrV6CF9FDBBfWdbt0omCvq4pb/ltIVFtOecceQIHwjVqW3bCXh43Vzdgm4PN
         CD1BNa+ntaiSnAAS9gV2EAx08yYuvpibp8dUd7y0IYj3pGoTiKX2n2kHxYA/w1lZ874g
         kLM8PFJKLtWG5cQF56KGxFclNDUUhGaSWjh300Gphho7B+KioXHzhB47YAIp/c1ZFhB8
         BpPg==
X-Gm-Message-State: AGi0Puaeka/2XCEmsFtVupcfLCT+R5ENMJ8Ve3zc9A8lFQ6YI+qxklBy
        cGh+ozPDuy2t90283Q6wK8RpuBuxCJX4gcnDslG4IA==
X-Google-Smtp-Source: APiQypIpKnyMQdCPwOkrU4XHmJGqGQzCTuqSu9dtAHs40Ji7eqg7X+BO8MRm5FUsUlc9uL65iAVZwfc0K19OPhETeAY=
X-Received: by 2002:a2e:9ad9:: with SMTP id p25mr6305274ljj.39.1587036154321;
 Thu, 16 Apr 2020 04:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200414152843.32129-1-pthomas8589@gmail.com>
In-Reply-To: <20200414152843.32129-1-pthomas8589@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 13:22:23 +0200
Message-ID: <CACRpkdaPc-rxNmdq7KFKZ-Qi7Tqy2RJ5Lkcv-8bTAh0GX7VygQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: gpio-pca953x, Add get_multiple function
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:30 PM Paul Thomas <pthomas8589@gmail.com> wrote:

> Implement a get_multiple function for gpio-pca953x. If a driver
> leaves get_multiple unimplemented then gpio_chip_get_multiple()
> in gpiolib.c takes care of it by calling chip->get() as needed.
> For i2c chips this is very inefficient. For example if you do an
> 8-bit read then instead of a single i2c transaction there are
> 8 transactions reading the same byte!
>
> This has been tested with max7312 chips on a 5.2 kernel.
>
> Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
> ---
>  changes from v1: rebased to 5.7-rc1

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Since I know Bartosz is queueing other patches for this driver I
let him pick it up.

Yours,
Linus Walleij
