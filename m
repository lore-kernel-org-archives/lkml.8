Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3FC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D520753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="JFG/6gMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgEFJ5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729279AbgEFJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:57:41 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87DBC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:57:40 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a5so614422vsm.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Buw+MRcQ/TMHCg5u1SbCiAvrUY4sRNw1ytiAhiL2nxQ=;
        b=JFG/6gMw96I4OtBP7mT0SdebEFiB73YHV7/jx8jGV+JjncYz81weZJ+htIfm7ahMMU
         ZmPYVGNjrrksKhRj0UNzgqkqe4eYIDOq1+LC85KDEBinEsmpY0ciYbRpOExCqEltBFi/
         Ol96M+un3BF89xXTVngcPVvcMbgGo5gd4ZtkNUwU02rxULYsOk735fejD+4Q7gm90eeb
         XX59VN6V8BTw+hg8sOPDtixg/0ppbbDKUsv3CB1GWsrjZeO2jopImKuuWTib2AS1hJTf
         FwMtlyZP4JTPfPoCZ/dORiU0KyTuNJiRims4xWjtlhaeRVPjQmd9XM0qzyn02AfEqykv
         I+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Buw+MRcQ/TMHCg5u1SbCiAvrUY4sRNw1ytiAhiL2nxQ=;
        b=KO++TqFpEvhLa8d449v48kYComQBqXj5LHBEbMk/x0PczDNCwXQFkjG4JtNNHRfCK9
         OeEjE6/lurJdxTF1bsK+1Z6JpubrmldMrblqJ2dOndjtI2xiURKdRhCIiInitSFCLyzZ
         jCoxVSRKYMN2TopSWE5k5B52TLTh51/upKlA4x36qgKNaKRBXITYhMKhPNInFizyXyBh
         UMMtJkOUvgC1bhAJMmKbue/CcUHKvWGG8RCr+mBCWPkrXpims4uLc2vH6LpsA6TgMGDO
         jmlUlzqhW05XoyjSiwVcK7HogVtp8xqOMjqH48s44BXoKvBKRT/671SSaKhphMHOXGo2
         X6WA==
X-Gm-Message-State: AGi0PuasI3Rwc0Nxy0xPzrpFRRPZtle1M0xb3MvJzuoOgGoxn4apDcYQ
        I+Tk43wScI50xhKoF0aLdZTKqqcr78afmIbQCHR7mg==
X-Google-Smtp-Source: APiQypLzp92cR3MqkWyfyHChtPN79QxkSNPP9jZiJbWN9gmgX2AmstXUfN8XUmeAWnRh4k+bMR+L8JLU5RTtTiVupk0=
X-Received: by 2002:a05:6102:2e4:: with SMTP id j4mr6571309vsj.182.1588759059766;
 Wed, 06 May 2020 02:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200429103644.5492-1-daniel.lezcano@linaro.org> <20200429103644.5492-3-daniel.lezcano@linaro.org>
In-Reply-To: <20200429103644.5492-3-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 6 May 2020 15:27:05 +0530
Message-ID: <CAHLCerN-O=CfV=-rJ6q+GVXy49Kja9ABE-U0wa_H-TnRYrHZ9Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] thermal/drivers/cpuidle_cooling: Change the
 registration function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 4:07 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Today, there is no user for the cpuidle cooling device. The targetted
> platform is ARM and ARM64.
>
> The cpuidle and the cpufreq cooling device are based on the device tree.
>
> As the cpuidle cooling device can have its own configuration depending
> on the platform and the available idle states. The DT node description
> will give the optional properties to set the cooling device up.
>
> Do no longer rely on the CPU node which is prone to error and will
> lead to a confusion in the DT because the cpufreq cooling device is
> also using it. Let initialize the cpuidle cooling device with the DT
> binding.
>
> This was tested on:
>  - hikey960
>  - hikey6220
>  - rock960
>  - db845c
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  - V4:
>    - Changed message from pr_info to pr_debug
>    - Fixed of properties to comply with the binding
>    - Add a debug message int case the thermal-idle node is not found
>    - Do not return an error as the caller won't care
> ---
>  drivers/thermal/cpuidle_cooling.c | 63 +++++++++++++++++++++++++------
>  include/linux/cpu_cooling.h       | 12 +-----
>  2 files changed, 53 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> index 0bb843246f59..78e3e8238116 100644
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -5,11 +5,14 @@
>   *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>   *
>   */
> +#define pr_fmt(fmt) "cpuidle cooling: " fmt
> +
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/err.h>
>  #include <linux/idle_inject.h>
>  #include <linux/idr.h>
> +#include <linux/of_device.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>
> @@ -154,22 +157,25 @@ static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
>  };
>
>  /**
> - * cpuidle_of_cooling_register - Idle cooling device initialization function
> + * __cpuidle_cooling_register: register the cooling device
>   * @drv: a cpuidle driver structure pointer
> - * @np: a node pointer to a device tree cooling device node
> + * @np: a device node structure pointer used for the thermal binding
>   *
> - * This function is in charge of creating a cooling device per cpuidle
> - * driver and register it to thermal framework.
> + * This function is in charge of allocating the cpuidle cooling device
> + * structure, the idle injection, initialize them and register the
> + * cooling device to the thermal framework.
>   *
> - * Return: zero on success, or negative value corresponding to the
> - * error detected in the underlying subsystems.
> + * Return: zero on success, a negative value returned by one of the
> + * underlying subsystem in case of error
>   */
> -int cpuidle_of_cooling_register(struct device_node *np,
> -                               struct cpuidle_driver *drv)
> +static int __cpuidle_cooling_register(struct device_node *np,
> +                                     struct cpuidle_driver *drv)
>  {
>         struct idle_inject_device *ii_dev;
>         struct cpuidle_cooling_device *idle_cdev;
>         struct thermal_cooling_device *cdev;
> +       unsigned int idle_duration_us = TICK_USEC;
> +       unsigned int latency_us = UINT_MAX;
>         char dev_name[THERMAL_NAME_LENGTH];
>         int id, ret;
>
> @@ -191,7 +197,11 @@ int cpuidle_of_cooling_register(struct device_node *np,
>                 goto out_id;
>         }
>
> -       idle_inject_set_duration(ii_dev, TICK_USEC, TICK_USEC);
> +       of_property_read_u32(np, "duration-us", &idle_duration_us);
> +       of_property_read_u32(np, "exit-latency-us", &latency_us);
> +
> +       idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
> +       idle_inject_set_latency(ii_dev, latency_us);
>
>         idle_cdev->ii_dev = ii_dev;
>
> @@ -204,6 +214,9 @@ int cpuidle_of_cooling_register(struct device_node *np,
>                 goto out_unregister;
>         }
>
> +       pr_debug("%s: Idle injection set with idle duration=%u, latency=%u\n",
> +                dev_name, idle_duration_us, latency_us);
> +
>         return 0;
>
>  out_unregister:
> @@ -221,12 +234,38 @@ int cpuidle_of_cooling_register(struct device_node *np,
>   * @drv: a cpuidle driver structure pointer
>   *
>   * This function is in charge of creating a cooling device per cpuidle
> - * driver and register it to thermal framework.
> + * driver and register it to the thermal framework.
>   *
>   * Return: zero on success, or negative value corresponding to the
>   * error detected in the underlying subsystems.
>   */
> -int cpuidle_cooling_register(struct cpuidle_driver *drv)
> +void cpuidle_cooling_register(struct cpuidle_driver *drv)
>  {
> -       return cpuidle_of_cooling_register(NULL, drv);
> +       struct device_node *cooling_node;
> +       struct device_node *cpu_node;
> +       int cpu, ret;
> +
> +       for_each_cpu(cpu, drv->cpumask) {
> +
> +               cpu_node = of_cpu_device_node_get(cpu);
> +
> +               cooling_node = of_get_child_by_name(cpu_node, "thermal-idle");
> +
> +               of_node_put(cpu_node);
> +
> +               if (!cooling_node) {
> +                       pr_debug("'thermal-idle' node not found for cpu%d\n", cpu);
> +                       continue;
> +               }
> +
> +               ret = __cpuidle_cooling_register(cooling_node, drv);
> +
> +               of_node_put(cooling_node);
> +
> +               if (ret) {
> +                       pr_err("Failed to register the cpuidle cooling device" \
> +                              "for cpu%d: %d\n", cpu, ret);
> +                       break;
> +               }
> +       }
>  }
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 65501d8f9778..a3bdc8a98f2c 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -63,18 +63,10 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  struct cpuidle_driver;
>
>  #ifdef CONFIG_CPU_IDLE_THERMAL
> -int cpuidle_cooling_register(struct cpuidle_driver *drv);
> -int cpuidle_of_cooling_register(struct device_node *np,
> -                               struct cpuidle_driver *drv);
> +void cpuidle_cooling_register(struct cpuidle_driver *drv);
>  #else /* CONFIG_CPU_IDLE_THERMAL */
> -static inline int cpuidle_cooling_register(struct cpuidle_driver *drv)
> +static inline void cpuidle_cooling_register(struct cpuidle_driver *drv)
>  {
> -       return 0;
> -}
> -static inline int cpuidle_of_cooling_register(struct device_node *np,
> -                                             struct cpuidle_driver *drv)
> -{
> -       return 0;
>  }
>  #endif /* CONFIG_CPU_IDLE_THERMAL */
>
> --
> 2.17.1
>
