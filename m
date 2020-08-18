Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634EEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC5620706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHHSzarw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHRMrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHRMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:47:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD812C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:47:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so21871664eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMDbLvcB25l+0rawk4vmc0yRtmJgi9WjSy4299BGbcs=;
        b=GHHSzarwU/3M7mBfkeWifUOEbKaiJJm9fviyvqJU+b34aCmyCR7vk8L3t9fzMMJOzd
         +m8lYUb98ryzLIxU9REN8lNS+fme8lBBvYvZAYaXl3kJucpQTOnC/0cFFwf7Aqr4nyt1
         DoFon7sfFVbBK/ZZeSHeVgFgsDdMicF+IVE4qxamw62AhfAVhDYJ2PP+tObbJNBuYmia
         5HzIYLLAaDjSelBVqoGZ3uHhW2kDZKr4TIDECKiRBav21VYF1nnJkGwgkCCj7Ctk4WNM
         rrLz4Dz4GdjsruFY5DHyW8uu5oUjX1corCHzLwQHVBUIF+3vn9hmKbgebX722Ph0xRvz
         Z1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMDbLvcB25l+0rawk4vmc0yRtmJgi9WjSy4299BGbcs=;
        b=FiKews39EASpn/yprvOvjI2gCDcPdOg3NEt+BmMmhMSvOEnR26mtxnozodZZJW8GkX
         8reneLQVqbkhZAUGPlTlCv5+zT3T3nR7+lHDHBQtV1p8ddq5FruB6sd2hdb8Su5vTG2h
         zVM/BcmDhLC8w4mQ4taE5DeGTK5dWkW3Sjp/wivp0YSyBCG+B1TuSx5FNlpO0GFeL/Iz
         0ZkGgMnMUlzTiTBHzQMf/Zn+8ek9IeL+WMhZC5mmkK+En0x55r5hiNFkn5bZ7JvVUby8
         O1vYOUj5VUkPi3dDRff38cVywxvjpcpx/xTEvifqV/8eIz0JVJSb7i3kJQ8O0cmOnh/p
         NlbA==
X-Gm-Message-State: AOAM530uoXb/VSG7Bnh4ERDlVq+rE9T0sD1wGMWkMiVlGAYw6s6eDVFq
        kttOPV1FIZTcie96viA5ytCX+gfeDs2vFfNb5KH5tw==
X-Google-Smtp-Source: ABdhPJyCXGzUrpykW6o7qNDpvOmpZd7kJApCJVeHdCXodWCK1pgP9UjtxjcXF2XWViRFQ2DXBQSuQ6Wdofmt/4fcd44=
X-Received: by 2002:a17:906:3911:: with SMTP id f17mr20823127eje.56.1597754858249;
 Tue, 18 Aug 2020 05:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200818111057.19755-1-tingwei@codeaurora.org> <20200818111057.19755-2-tingwei@codeaurora.org>
In-Reply-To: <20200818111057.19755-2-tingwei@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 18 Aug 2020 13:47:27 +0100
Message-ID: <CAJ9a7VjatuzAJw8Bp6T7vkh8bCTwoNa1kve5exsedgy++Wys0g@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: remove pm_runtime_get_sync() from CPU hotplug
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 at 12:11, Tingwei Zhang <tingwei@codeaurora.org> wrote:
>
> Below BUG is triggered by call pm_runtime_get_sync() in
> cti_cpuhp_enable_hw(). It's in CPU hotplug callback with interrupt
> disabled. Pm_runtime_get_sync() calls clock driver to enable clock
> which could sleep. Remove pm_runtime_get_sync() in cti_cpuhp_enable_hw()
> since pm_runtime_get_sync() is called in cti_enabld and pm_runtime_put()
> is called in cti_disabled. No need to increase pm count when CPU gets
> online since it's not decreased when CPU is offline.
>
> [  105.800279] BUG: scheduling while atomic: swapper/1/0/0x00000002
> [  105.800290] Modules linked in:
> [  105.800327] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 5.9.0-rc1-gff1304be0a05-dirty #21
> [  105.800337] Hardware name: Thundercomm Dragonboard 845c (DT)
> [  105.800353] Call trace:
> [  105.800414]  dump_backtrace+0x0/0x1d4
> [  105.800439]  show_stack+0x14/0x1c
> [  105.800462]  dump_stack+0xc0/0x100
> [  105.800490]  __schedule_bug+0x58/0x74
> [  105.800523]  __schedule+0x590/0x65c
> [  105.800538]  schedule+0x78/0x10c
> [  105.800553]  schedule_timeout+0x188/0x250
> [  105.800585]  qmp_send.constprop.10+0x12c/0x1b0
> [  105.800599]  qmp_qdss_clk_prepare+0x18/0x20
> [  105.800622]  clk_core_prepare+0x48/0xd4
> [  105.800639]  clk_prepare+0x20/0x34
> [  105.800663]  amba_pm_runtime_resume+0x54/0x90
> [  105.800695]  __rpm_callback+0xdc/0x138
> [  105.800709]  rpm_callback+0x24/0x78
> [  105.800724]  rpm_resume+0x328/0x47c
> [  105.800739]  __pm_runtime_resume+0x50/0x74
> [  105.800768]  cti_starting_cpu+0x40/0xa4
> [  105.800795]  cpuhp_invoke_callback+0x84/0x1e0
> [  105.800814]  notify_cpu_starting+0x9c/0xb8
> [  105.800834]  secondary_start_kernel+0xd8/0x164
> [  105.800933] CPU1: Booted secondary processor 0x0000000100 [0x517f803c]
>
> Fixes: e9b880581d55 ("coresight: cti: Add CPU Hotplug handling to CTI driver")
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-cti.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 869569eb8c7f..baba6af83440 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -126,9 +126,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>  static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
>  {
>         struct cti_config *config = &drvdata->config;
> -       struct device *dev = &drvdata->csdev->dev;
>
> -       pm_runtime_get_sync(dev->parent);
>         spin_lock(&drvdata->spinlock);
>         config->hw_powered = true;
>
> @@ -148,7 +146,6 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
>         /* did not re-enable due to no claim / no request */
>  cti_hp_not_enabled:
>         spin_unlock(&drvdata->spinlock);
> -       pm_runtime_put(dev->parent);
>  }
>
>  /* disable hardware */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
Reviewed-by Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
