Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA84C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC9120663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIIEk3jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgFOLZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbgFOLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:25:38 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 04:25:38 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id b13so5535105uav.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrKmkhg+c1u0kB4U6Q0PfBV1XmTvqqdQ8hWTNkN5v2k=;
        b=XIIEk3jhhCjnXxJTApUX1KsztsSHxmkhzNIzJiVbqEHf7zAn0F9ATFYCTcxehIn7Db
         PSo6AK16Dk/Mq2bHaFCNXJPKhXFfIyKWlZ64UGJVCrZI5POsNEiNmiXtK4/nrUoQyxE7
         QHFnkyTx7Mf1Cjrktsn7BMYv521Nzaa/sKvQWydv/s1Sx4G5vEEGEzjGrqvH0ubiDc45
         oBYNVXzgJF6M5MhYQLfXHAaZnaB+ow+dxNe5MRjqhZkkny1Gytj8LuYB8sxhWldVtsrz
         jrDMHgw3N8/IG4Ozcd3vnUA3fApwh05lTSBFjbz5aKHtOvycqlLUQb87pFCTW7Ocp/gA
         +uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrKmkhg+c1u0kB4U6Q0PfBV1XmTvqqdQ8hWTNkN5v2k=;
        b=e9m8ysudpoMS7yL4ZOx+VoGM3SXuIKl7oIGgCAEHe5scl142TZPRB77eoMY5U5cZ++
         LbIjx33a0Z49xlsNEfZ+Q5xiNoE3MT6Gawr+B6dBVxTn1zocmP6TIuDxY/UNysZhr6/E
         /z9HUrb430GkYJghSg3ARDaNseYYUnryS3K8FHU+JBnzhwXRyKTNw/+tSLEi+M+PYceO
         Yr+EXNI/pxu7Dq5/xc9QUPlsybXVanoF37lLEMAIS4XrZn9sm3t5FZ7EQR382402cnJl
         gQ9jmdoYi7iUjBQ6NHhKz00flAF6L4MQhwU2El65gYHFSxI3RlPRSCbBWe+FQFggTn3J
         qOBA==
X-Gm-Message-State: AOAM532gEhWTn1VCjCm+xvZm9aDsVEJxdViJUYppACzKss6mX86UyyOi
        boXomTFDlnJg7QEjZFeQdUawwHxcIxuVpTcqCVMPJQ==
X-Google-Smtp-Source: ABdhPJzqNGqsG+5owbRVG/KlqJGvlwwJKZq02aq94CP4ikq3550XKb+IM6Rhtt+J/C/aq6FLjSiLs0/JETpwhEPnOTc=
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr18170672uan.19.1592220336997;
 Mon, 15 Jun 2020 04:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200429103644.5492-1-daniel.lezcano@linaro.org> <20200429103644.5492-4-daniel.lezcano@linaro.org>
In-Reply-To: <20200429103644.5492-4-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Jun 2020 13:25:00 +0200
Message-ID: <CAPDyKFrdzcf5e98EM0VvwxnR0zDFQ851PDLOZ9wpe-LO6n4Abw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, lukasz.luba@arm.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 at 12:37, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The cpuidle driver can be used as a cooling device by injecting idle
> cycles. The DT binding for the idle state added an optional
>
> When the property is set, register the cpuidle driver with the idle
> state node pointer as a cooling device. The thermal framework will do
> the association automatically with the thermal zone via the
> cooling-device defined in the device tree cooling-maps section.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  - V4:
>    - Do not check the return value as the function does no longer return one
> ---
>  drivers/cpuidle/cpuidle-arm.c  | 3 +++
>  drivers/cpuidle/cpuidle-psci.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 9e5156d39627..8c758920d699 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -124,6 +125,8 @@ static int __init arm_idle_init_cpu(int cpu)
>         if (ret)
>                 goto out_kfree_drv;
>
> +       cpuidle_cooling_register(drv);
> +
>         return 0;
>
>  out_kfree_drv:
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index bae9140a65a5..1f38e0dfc9b2 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>
>  #include <linux/cpuhotplug.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -313,6 +314,8 @@ static int __init psci_idle_init_cpu(int cpu)
>         if (ret)
>                 goto out_kfree_drv;
>
> +       cpuidle_cooling_register(drv);
> +

Apologies for the late reply, but just noticed this change in v5.8-rc1.

Don't you need a cpuidle_cooling_unregister function? For example,
cpuidle-psci may fail and then calls cpuidle_unregister() to cleans up
things.

Is that okay?

Kind regards
Uffe
