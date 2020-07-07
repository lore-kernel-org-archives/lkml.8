Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149FDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CB620702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbMMReVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGGLPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgGGLPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:15:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE17C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:15:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t25so44827492lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IME/GKmb03RMGZjHJLw9fB5q2hWSVThgD6kxOkSv7K4=;
        b=MbMMReVhvU1Ziovve/YFlmTeUU52Pj/orKnR7kX0NlykcVik8u67E66OxRylvX4Oaz
         EklcD2sTe2vWnBBM/OrMJN9XhiXGr9KnB3NO0SaKVMbMRzzmQv0mpSIU3l8usw++6Di/
         YATzyor3V8fa3yajhQQ0JvV+5UyJ2t4+EWpgJquP7iad6/KuBlQkef3UOB+wgdDGi+zi
         M7tRYg96icGx5VqDZulWFiw/mEN+gdLBERSj5VsUwT3xllZrYNq5/vXaDf2h70MBnUa3
         G61L17PrwXwrz72aXhT8lIDpbDP8M5nEucOcfgujb4xoACysDuy4vpC1krs7qL1xDlzN
         BhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IME/GKmb03RMGZjHJLw9fB5q2hWSVThgD6kxOkSv7K4=;
        b=dlpl+5tqjHQrJ6N0WkhrxAIKkgvoJb3HGKdkTqdY6DVaLkBq7RSDDa9E/bRiXrx2Jg
         hnVUSV/pY3fGsZslyphaQw/wmnIy8k82kA5lTy/VEFeLIeC4qPGUJ0hx1AKitOAjLJPl
         Q0Yvs8OXXnquGTGgSGDea6aXYu+RDQzC69C7BsebZ/3NBq2yt0j6EFUEacxlxQSW/PL3
         s2GP4mAMgofsBnGPk0c7FOwHi0GuO7p/1QGyo8eGLuL92Mbg1uqYx1HkmC00UTdaTILn
         CwemyJLS/OmLokQNdbHmA0hal2VpOwr/WJw7H5wTNNyeZ+eFNBRY3zet+Mz9CdGMI9Qw
         71Pg==
X-Gm-Message-State: AOAM530fUmdVhWZFRgPZAEh6kGTA1p4oqeBxnOX+nT1Qej5XA8B/j/py
        VDLFnz/gbAE4nw/nEYflIwsPxWBVEfwQ4jdLnO/kRA==
X-Google-Smtp-Source: ABdhPJwbsoWVmqeN0/WQZpQJHIRzq9HpNh3Mx3xudoIWyjVcuG5GzzrQ0ViAG5GTTFplqmcdl8EFB/wvQqzTDo1sta8=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr8480046ljj.283.1594120550675;
 Tue, 07 Jul 2020 04:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200618025916.GA19368@home-desktop>
In-Reply-To: <20200618025916.GA19368@home-desktop>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 13:15:39 +0200
Message-ID: <CACRpkdZqkAXpH83H88=phtVcJRhqh-1865X8gJun_oOqBwzxrw@mail.gmail.com>
Subject: Re: [PATCH] [v2] pinctrl: meson: fix drive strength register and bit calculation
To:     Hyeonki Hong <hhk7734@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 4:59 AM Hyeonki Hong <hhk7734@gmail.com> wrote:

> If a GPIO bank has greater than 16 pins, PAD_DS_REG is split into two
> or more registers. However, when register and bit were calculated, the
> first register defined in the bank was used, and the bit was calculated
> based on the first pin. This causes problems in setting the driving
> strength.
>
> The following method was used to solve this problem:
> A bit is calculated first using predefined strides. Then, If the bit is
> 32 or more, the register is changed by the quotient of the bit divided
> by 32. And the bit is set to the remainder.
>
> Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>

Patch applied.

Yours,
Linus Walleij
