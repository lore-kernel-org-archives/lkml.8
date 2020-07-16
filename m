Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B1C20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLXRrw/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgGPMgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:36:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:36:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so6986865ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drk9hGfz7z8AP1xpL2RwueoIRFxJVbcmxPnhyhYlKqA=;
        b=VLXRrw/Qy62IqgJu0+kWErLUMk7/RiboeWpuWq93NzrX74UvhwUPaBDd/tXbDAOSKk
         hacoDUHy4onMkkhJGlFadU1T+49FQCUzD1MTZobO0v6oiOucurymWCQKj8MKXEb4SB8Y
         1rrRiQKAYJ9TkaEciOTc/FuW4b1Fu7G6ckFGmWwXwBsHiNI4UOYKSLgokBSp5st9VFzY
         P1cH2ekmkXuj4tnjQ0WSDEdFmc7Wu7dHh9ChbENYh9o1GLQBqzjOHyr81KaVEEyDZ9v3
         OLoS7jsU62cGSwQQmiquLZyL5glCbaD+HZhwrw75WwOMXyxmKvnIoPwA/pfWH1BC1eUa
         +Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drk9hGfz7z8AP1xpL2RwueoIRFxJVbcmxPnhyhYlKqA=;
        b=l3Oq7+x7NB3LosPjkfild5ZQXtLNJHxvtldLhhoshLSpQukbYiZp1o731RQ1f6NVF5
         pps40lP7UNDh9o5VRElMocuONQcxL6TH4bGAVRSc2lYYeivzEPTwY2v54wRxFOrAYenp
         BDeot9OZ0ksUUG/fn5yULs1MtJizVOJ5E8uagjbaQSsoBoI3h5fL4QTV/SHcigwRqRZj
         VU4ZhbveT28X4J6lTYeavC/5dyMUDLAdJ2Z5LHOthW6J65ZXEBbchrrR7n5ZZCf/BRAV
         WBRNyu2zxSe5oU32nc2yhbidf9U4vxkMKZ+CjPSt+Lj9PlPYWQ7yl6wcM+lDr8TAZxLD
         uJdA==
X-Gm-Message-State: AOAM533MX8IJt+t7UKTyhyBGo+/QH0bKeDMzEkdVlmM8eoF4GmIHmKcM
        RmkvPzpz7G5UKwbyzpfCgzVmGgbt3R2PeN6HMm+lh+gkBGs=
X-Google-Smtp-Source: ABdhPJxT8CYQTjkttRKbrnf85+UEHQbpzRI3gp2UWZ4rwDp4lUHT9pdGOu2aN3TDinzHO647HRInpwijqm/N8SwtkIA=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr2021800ljj.283.1594902969210;
 Thu, 16 Jul 2020 05:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200709134829.216393-1-mans0n@gorani.run>
In-Reply-To: <20200709134829.216393-1-mans0n@gorani.run>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 14:35:58 +0200
Message-ID: <CACRpkdZhd6UoHQ8gJKXHAAtdsbt1=2K5TGc-hKT7uS+SfDOR5Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: add GPO driver for PCA9570
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Walle <michael@walle.cc>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 3:48 PM Sungbo Eo <mans0n@gorani.run> wrote:

> NXP PCA9570 is a 4-bit I2C GPO expander without interrupt functionality.
> Its ports are controlled only by a data byte without register address.
>
> Datasheet: https://www.nxp.com/docs/en/data-sheet/PCA9570.pdf
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> ---
> v6:
> * removed client
> * re-added mutex
> * removed template_chip

This v6 version applied, thanks to everyone who helped out
reviewing this driver!!

Yours,
Linus Walleij
