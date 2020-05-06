Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26198C38A24
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0076720753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="QvHcHNJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgEFJ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729299AbgEFJ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:57:47 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2935C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:57:46 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id x136so621412vsx.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLVRESBoKPDQJtZ+ThuiAcYI3TdQCvmpu5N5ap/84vg=;
        b=QvHcHNJv4TLk4yeHfEs21Cb+swsgc5BqyQVaDr8vGh+oOkIyjdNVK6vBnsXKt1Ro9p
         lrbWbY9rsYAi6JYMsF181p9daiS8QWD+IGymftoG3EZHH7QOWQ8B704TB8nGmamk5N0/
         UcjaM/2y/cqADBsPMReZoS3BUAf7j50WZZo6mRAVi2C3JyeTqzjhgNLISHmn+Wi7wSZ9
         DmFgpjYKj+Iq8cdZyHzkwPUNn9cl+6zFjGKtkD2UE4xcQ70GFSHB9M1QyCPFzHABYV57
         ZnRi4yBgQdUQelQh1HBHv32p1LwaKnuyUf7AfoAPkacmfXnsltTrRNejAN8HBeSPOuaF
         5Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLVRESBoKPDQJtZ+ThuiAcYI3TdQCvmpu5N5ap/84vg=;
        b=KUPHPNIpGu2TA6hMlDn79q6B3XcrrpP70bcoWkouU+fYeF73H4QYcNXxIuTGGGmveY
         htPQe93LfOctD9c1eOa8qZX1eHUU3p2zq88y69ETyDn22uLL6Xb6QfFbTrC8eTdIfidt
         czPeQPhmtpCqIffnTKKS+WvmJyYNbci4WNXMoDK251UuMALc/Qm0DBHG2mbR1VxB2pEl
         m1DrCoLR1yUMvWbHldJVTa74Gjm2udPB2Y4YgN15rD/IKqhO4pPsyD6zM0L3F+fUzI7X
         B0GmRALiH6aBNA7aLrcdB7MTpy6OosRA5OOec4bhXV+jWuYuEnHkKkvWYIa00qhShgW7
         dYRw==
X-Gm-Message-State: AGi0PuZ3YLwZaxcBO4c7iMgb6guRVGHLj7GfLr5TCV8QyTDsZLDLAdDs
        SJj+D6qKTda3Y8/NhF3pf7BxQAsPyDX6Bme0aj9EtQ==
X-Google-Smtp-Source: APiQypKLOZf+1q8lOTy5vDVF1evQNddQakrlqUF5XgociHzpoFintL/zhnSsv06HVF3oEHG2Eb1/X7JPOcMW2F7Qklo=
X-Received: by 2002:a05:6102:407:: with SMTP id d7mr6020126vsq.159.1588759065941;
 Wed, 06 May 2020 02:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200429103644.5492-1-daniel.lezcano@linaro.org> <20200429103644.5492-4-daniel.lezcano@linaro.org>
In-Reply-To: <20200429103644.5492-4-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 6 May 2020 15:27:10 +0530
Message-ID: <CAHLCerPJkwi9o5p6UheC+bkdkSYu1fZu5jjWrOjWeSk8+R75ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
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

On Wed, Apr 29, 2020 at 4:07 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The cpuidle driver can be used as a cooling device by injecting idle
> cycles. The DT binding for the idle state added an optional

Incomplete sentence.

> When the property is set, register the cpuidle driver with the idle
> state node pointer as a cooling device. The thermal framework will do
> the association automatically with the thermal zone via the
> cooling-device defined in the device tree cooling-maps section.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Conditionally,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


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
>         return 0;
>
>  out_kfree_drv:
> --
> 2.17.1
>
