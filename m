Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C08C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4D220748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIjgkqpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgCaGye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:54:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39239 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCaGyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:54:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so20791658ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9loUHqcNcd90NK2/m8vbfLtxRqvUnhXKgLBg3C+Bxs=;
        b=OIjgkqpSthyzQoQAnxzj5NIvlbP71kKJ0P/CkJE7eBmPcfcL2FeLivaWEHhqPU1Sz/
         k2xaHecJYgvq6cwCG0/cvQnWgbNZ5asEUHtIIyeaoJEy7NhwlDlTP5igNIztW3tYp7J4
         wG2bJTibUG9rnb0/05JnFFGzHMYnbAdc5IEl7u75eYslxXhWiJn7IGHXfpdk1PGpB0J7
         sZXy7TaJfc10PwrW6nkR9boV4LI1zDQNx+XvT2KkiBSRBvInIX0Mz9imcw3pWw+RnnBz
         lXGiGz9nENZTTibTr8HKGg5t2Rox/QJMhuO4q22QLh8f4eoDkEc1iR0xYPHYFTBQvFng
         wcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9loUHqcNcd90NK2/m8vbfLtxRqvUnhXKgLBg3C+Bxs=;
        b=eMn+PiCa6RS6x5+zrWu8AYenmqiIMYKcTLymWCFzV07X9LANsBMyfKC9iUors4sqHa
         7jK8v7t6EHiijyQCMvZBYQaoBe1Sey0r0cejwtwHItUs/yw6x3Qmf2mcFW+VsGiA1+kD
         s/23xLrHYqu1/NqkGx7d0sEgKp/UUPl91HGAVZ5mQIwUIhb4kYwxTR+uxRdN546os1QU
         xBKC368WnFhgVgYJnxyi2LC2KxMedzTgyvDBkf/jW8rihq3q5cJzdh3EpEmOzxkOLffO
         IkOSPrFtlqmZP9bAJmqKG0gblOgdy8GnKQ8xVlMjmCsjFrOZlsZtJjsHcSh2XipV1ANH
         A5Lw==
X-Gm-Message-State: AGi0PuYNaXVcoRTVwyJZYANgZ/kzNTpw042N+J+mpRxJxQzYsyBBsIQz
        vOvuYl+VKPFvr+r7YvNnQveDycaT5Awk63WsyexouKo9iTs=
X-Google-Smtp-Source: APiQypKsSaliE6Q6PoMK/k8TNUZpVdg/0QBfIOIvD0et75bjcVTZNgiB84VQ4eWX321HspPPq7LK26pobWEkQYVxQDA=
X-Received: by 2002:a2e:a495:: with SMTP id h21mr9218182lji.123.1585637669144;
 Mon, 30 Mar 2020 23:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200330202715.86609-1-john.stultz@linaro.org>
In-Reply-To: <20200330202715.86609-1-john.stultz@linaro.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 31 Mar 2020 12:24:17 +0530
Message-ID: <CA+G9fYv7XRm2ObuBQQy=iiOAj6rj_JX=8PBTt53JtDBwe5W=_Q@mail.gmail.com>
Subject: Re: [PATCH] driver core: Use dev_warn() instead of dev_WARN() for
 deferred_probe_timeout warnings
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 at 01:57, John Stultz <john.stultz@linaro.org> wrote:
>
> In commit c8c43cee29f6 ("driver core: Fix
> driver_deferred_probe_check_state() logic") and following
> changes the logic was changes slightly so that if there is no
> driver to match whats found in the dtb, we wait 30 seconds
> for modules to be loaded by userland, and then timeout, where
> as previously we'd print "ignoring dependency for device,
> assuming no driver" and immediately return -ENODEV after
> initcall_done.
>
> However, in the timeout case (which previously existed but was
> practicaly un-used without a boot argument), the timeout message
> uses dev_WARN(). This means folks are now seeing a big backtrace
> in their boot logs if there a entry in their dts that doesn't
> have a driver.
>
> To fix this, lets use dev_warn(), instead of dev_WARN() to match
> the previous error path.
>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Basil Eljuse <Basil.Eljuse@arm.com>
> Cc: Ferry Toth <fntoth@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Fixes: c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state() logic")
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

I have applied this patch and tested.
The reported problem is fixed by patch on arm64 Juno-r2 device.
https://lkft.validation.linaro.org/scheduler/job/1323860#L556

- Naresh
