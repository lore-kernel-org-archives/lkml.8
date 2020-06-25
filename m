Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C323C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E58206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEUUQsja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406451AbgFYTGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403908AbgFYTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:06:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:06:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so3743815pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QLiUDjyRjbtezmhzDIhIITecHBNzPti/u3K7zuZBCw=;
        b=sEUUQsjapz5Roh9lSUjaeoBk5mUNa31LMBO2mrMKUsq0FooNGmVCgzbavUiejb6eM4
         OD4CrxLu6OBjhiP/2FU8MMlB1bL6WZ+jTTJ8PpOOqDKn29veWC2vJSzSqksxC0e4rK1c
         uVO91JD1yL5/6BzQYI2+z2alkiQ6fFDMeSwp0NDZoT0GytvuaDYN8FcYapSqLKrZIaGI
         CxRJF1zo+H6NtJu47XtujaFNW3FIjnRxqhql3zg2Q50gL19hnkGKIG/Hn1QmCEIkxexR
         qZK1nb4JtndAPgFrNo+TuK9gzE+kbPSO56KCvO8TPR5SJEiy/pqj+QiptTYz7ZzZPMDS
         7Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QLiUDjyRjbtezmhzDIhIITecHBNzPti/u3K7zuZBCw=;
        b=oxcE4BjdfkVtpySHmW7VtHaXgoAtenuHXBlT8bc3JSoVGfzmQdYjsXZ0f53BzkdTwt
         C6CthOkXzevCojadGjSSDnaAkELeKUb4xz3Y3P1GKAIR83tKMQ99qYx2yrb5/jBOXz6d
         /G68DGU127hz5FwMYWyLPU0pP1eoV7KTMfMl6bEPFWE+K7Jw/TJOjeYyIuCGxlRte2VO
         +72UAqbqoaVDzzbXBNQuIZ0lSlkCLrIjvl3xcMaxPMBkoeI0d20YvR4MuHNjeSGW25i4
         lUh5ij9EQDKWtDv17BCniPVi2ObXV5YcdD8k72nsAsvIhAW7qKWG57Wd4pNa80j7kiL7
         khsw==
X-Gm-Message-State: AOAM530nbixSbO9Pi4PpV+x6cnJ1w6NDwlFKPMXvyGFU2Np4mDUirWKH
        bTmoDXyKPChhlOcfymBqBijVi1fr/qzDW8ZoOBQ=
X-Google-Smtp-Source: ABdhPJxC42xl1gZSD4Z2Wwe+sdCuqAt7K0R4haIDbc4F77hFwy4oG9wqg0KaNnTB64qWqsoVwqnMgdAYIxIr33ble3M=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr5016134pjq.228.1593111979958;
 Thu, 25 Jun 2020 12:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
In-Reply-To: <20200625170356.225136-1-enric.balletbo@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jun 2020 22:06:03 +0300
Message-ID: <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Crews <ncrews@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yicheng Li <yichengli@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> tag.

Is there any? Last time IIRC Greg told me that in the kernel the old
and new variants are okay.

...

>  28 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 41baccba033f7..b3242f7007886 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-2.0-only

...

-- 
With Best Regards,
Andy Shevchenko
