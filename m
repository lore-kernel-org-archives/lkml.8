Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD00C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CF521744
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swKUvLLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHTIG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgHTIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:06:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1A7C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:06:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m20so873414eds.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OwhNfFCbhYDQLA4/dccOD7L7141WZ9ATtkpH6xUNMc=;
        b=swKUvLLnAQdFPDLye2jyXh2prjZtgQAcVoLnNhc7qsmp4y6k0yNkEfsA5FufOZ56X8
         pymAO2W/n81MdoV+Uo3zfbU64TjgEKIkSmaKZMhdY/6q87jaNSn0K2bGDXXzd6L8DiTZ
         7ii1ra03DhVoia2KQzGGhqhQJpCxGL0UeVwPbAJivnYhHgc5JH0TK09/6+PMDp/ggC2K
         DSUnx2mgfsZUpWFQDB3efdz27VUZtITNnPOHIQrp92tQt0Hzj0K7AGZu1MTgO6480SEz
         ePiYPyT3Ysh5+oprallpD6gif3mMAjj1m2n/zuPrMwunpU1bm/ojeO7YfIBLznybOQFJ
         cGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OwhNfFCbhYDQLA4/dccOD7L7141WZ9ATtkpH6xUNMc=;
        b=UsShGassfWBbDXYx2G/1d/2UspB3mFQiLk+DtYOiJ/kCd8Re0e+q5R9woLC9IXdCxR
         CzPhrYzXfs8gVpXEA0FjC2P2qm/ZMD+PbD8TJub8Z9WSUIR6aDuYjkiy4dLHDFgmH8Na
         54hMkmz8St6H0T41awS6JKca8AVuBY5pOzD0fEj1pzj440HpovhCcSD8J6r9MtKTdqlv
         Ih5va3aZreT4eB97iwTi8yEYDdcDn0M0cGQPWT4COpLQ1ePBB29OsUh624qjVDPMMe7G
         wibQyP5jlq0JaeTGJ2w2qgWKDTKw9KrKBiAZvSkZNJrvmeRArGafaLQH+SxzHF5Gwl0I
         FVIw==
X-Gm-Message-State: AOAM532xd9P8vL4ZZpiZpARZnRTlC1V//JwbLkY0oufRZ1+SXiOa7chL
        8cMO51mtOghvNSfryL1PqsnHEQIi/0WvLFuPXFlRcQ==
X-Google-Smtp-Source: ABdhPJxedwVOjuhOGa+YZ2VRQ5JC/KBODV2K/n3WXxs7L+MCk4FOrvdgSwNrpgvPVRF3DiAgVdCepfeUVHJ0icaTZOY=
X-Received: by 2002:aa7:c395:: with SMTP id k21mr1797517edq.386.1597910798048;
 Thu, 20 Aug 2020 01:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200818111057.19755-1-tingwei@codeaurora.org> <20200818111057.19755-3-tingwei@codeaurora.org>
In-Reply-To: <20200818111057.19755-3-tingwei@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 20 Aug 2020 09:06:27 +0100
Message-ID: <CAJ9a7VjoKZnztndjAZKKsAj1-QJhWDHZN6e3hyp8dj7EerJF=A@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: write regsiters directly in cti_enable_hw()
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tingwei

On Tue, 18 Aug 2020 at 12:11, Tingwei Zhang <tingwei@codeaurora.org> wrote:
>
> Deadlock as below is triggered by one CPU holds drvdata->spinlock
> and calls cti_enable_hw(). Smp_call_function_single() is called
> in cti_enable_hw() and tries to let another CPU write CTI registers.
> That CPU is trying to get drvdata->spinlock in cti_cpu_pm_notify()
> and doesn't response to IPI from smp_call_function_single().
>
> [  988.335937] CPU: 6 PID: 10258 Comm: sh Tainted: G        W    L
> 5.8.0-rc6-mainline-16783-gc38daa79b26b-dirty #1
> [  988.346364] Hardware name: Thundercomm Dragonboard 845c (DT)
> [  988.352073] pstate: 20400005 (nzCv daif +PAN -UAO BTYPE=--)
> [  988.357689] pc : smp_call_function_single+0x158/0x1b8
> [  988.362782] lr : smp_call_function_single+0x124/0x1b8
> ...
> [  988.451638] Call trace:
> [  988.454119]  smp_call_function_single+0x158/0x1b8
> [  988.458866]  cti_enable+0xb4/0xf8 [coresight_cti]
> [  988.463618]  coresight_control_assoc_ectdev+0x6c/0x128 [coresight]
> [  988.469855]  coresight_enable+0x1f0/0x364 [coresight]
> [  988.474957]  enable_source_store+0x5c/0x9c [coresight]
> [  988.480140]  dev_attr_store+0x14/0x28
> [  988.483839]  sysfs_kf_write+0x38/0x4c
> [  988.487532]  kernfs_fop_write+0x1c0/0x2b0
> [  988.491585]  vfs_write+0xfc/0x300
> [  988.494931]  ksys_write+0x78/0xe0
> [  988.498283]  __arm64_sys_write+0x18/0x20
> [  988.502240]  el0_svc_common+0x98/0x160
> [  988.506024]  do_el0_svc+0x78/0x80
> [  988.509377]  el0_sync_handler+0xd4/0x270
> [  988.513337]  el0_sync+0x164/0x180
>
> This change write CTI registers directly in cti_enable_hw().
> Config->hw_powered has been checked to be true with spinlock holded.
> CTI is powered and can be programmed until spinlock is released.
>

Agreed.

Reviewed-by Mike Leach <mike.leach@linaro.org>

> Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI devices")
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-cti.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 3ccc703dc940..869569eb8c7f 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -86,13 +86,6 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
>         CS_LOCK(drvdata->base);
>  }
>
> -static void cti_enable_hw_smp_call(void *info)
> -{
> -       struct cti_drvdata *drvdata = info;
> -
> -       cti_write_all_hw_regs(drvdata);
> -}
> -
>  /* write regs to hardware and enable */
>  static int cti_enable_hw(struct cti_drvdata *drvdata)
>  {
> @@ -112,15 +105,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>         if (rc)
>                 goto cti_err_not_enabled;
>
> -       if (drvdata->ctidev.cpu >= 0) {
> -               rc = smp_call_function_single(drvdata->ctidev.cpu,
> -                                             cti_enable_hw_smp_call,
> -                                             drvdata, 1);
> -               if (rc)
> -                       goto cti_err_not_enabled;
> -       } else {
> -               cti_write_all_hw_regs(drvdata);
> -       }
> +       cti_write_all_hw_regs(drvdata);
>
>         config->hw_enabled = true;
>         atomic_inc(&drvdata->config.enable_req_count);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
