Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D11C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C0220CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1KPVfsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgFQKta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQKt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:49:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C9C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 03:49:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so1812742ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0YiZR/0JogxadNuaaf1uQ0iU9Zfr56Svwi+PMNymt4=;
        b=K1KPVfsxzHMmy9fFx5TCa+VwhEgU/e8ZBg2F3UkpgXxdN5XZqlTjHnmP38cJpaM0oY
         W/XxM/SF1mHgF1ecLbATLqlovmJ8QclxKXduTR7uKbSGd5qEXkthT9/KKJgBCpaSAi3l
         ppGRHB2k7Cfn/C65Urk2ph0mzzE6zxisuUsVD1HHrfO7/+4q4Do1plJ/3AKshuwxysMx
         LCwik5506H0V9e4rlgKqdTVXuPQd7EmwoXMrADuXRrFLnYYhKA6EkWC8+f1sYSGgb6TH
         RdO0Vu27zk8c0bhS9RzaaOQRhYHwwd5A8B+ZQSDn9s66b9bjlwEehWDTkbtGOIpHNMYC
         Sj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0YiZR/0JogxadNuaaf1uQ0iU9Zfr56Svwi+PMNymt4=;
        b=NCIw9pnNf+HyxIm9f1pTWBqbbhPvQSQMZyDU/dVDg2M3sjeNN65XVKffyj9l+jjBtw
         YFY1k+kX8NV6U85lkJkfHnY3+71Z6pFxjuDPtgLP73uA5sR43W9qhlKyKWoZFD/qmWSb
         JgqzHBNKo/4woBtoGccNDM7+OFeFE7mujyd8DQNlib+Dz9lsINCRyyTNYY+PCJMuWaBB
         pnByXEUqCtjW9ed53COMsh3yr8yYlMrRK1S04jqFW5h+uqoufFCz6jbsMqRWPFDyvccB
         +xRDdoDq3R9o1ILa1KerXI4kSdE7zgEgjRV064Yxa0LU7V2/mxhBIIUb5lA2P1/ZxU5R
         pBhw==
X-Gm-Message-State: AOAM5300YQo5iCzvPRneuon0di7X/3e6iIsat0DkUQGLbpU5a3YUnTIy
        5HIkOGzSAmF9as9lD8lihoQoKTN9fyeTGmnN+2zeUw==
X-Google-Smtp-Source: ABdhPJxDwEr5BsQAWQrAu//fxP1TYSqxwr9HgBkoD24SU35NquqXv8kuCkH1hQYja/PGg7/nkg+18AREK64cWzXXCQY=
X-Received: by 2002:a17:907:9484:: with SMTP id dm4mr7298323ejc.56.1592390964917;
 Wed, 17 Jun 2020 03:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200612121047.GF4282@kadam> <20200612121133.GA1139533@mwanda>
In-Reply-To: <20200612121133.GA1139533@mwanda>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 17 Jun 2020 11:49:14 +0100
Message-ID: <CAJ9a7Vjn-1gvOY0h5eiffXgqiNu4rz=Z18hgV33WExGnLEV-nA@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: Fix error handling in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for looking at this. I agree with the patch, other than the one
change below.
I have compiled and run on my DB410 system, against 5.8-rc1.

On Fri, 12 Jun 2020 at 14:46, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> There were a couple problems with error handling in the probe function:
> 1)  If the "drvdata" allocation failed then it lead to a NULL
>     dereference.
> 2)  On several error paths we decremented "nr_cti_cpu" before it was
>     incremented which lead to a reference counting bug.
>
> There were also some parts of the error handling which were not bugs but
> were messy.  The error handling was confusing to read.  It printed some
> unnecessary error messages.
>
> The simplest way to fix these problems was to create a cti_pm_setup()
> function that did all the power management setup in one go.  That way
> when we call cti_pm_release() we don't have to deal with the
> complications of a partially configured power management config.
>
> I reversed the "if (drvdata->ctidev.cpu >= 0)" condition in cti_pm_release()
> so that it mirros the new cti_pm_setup() function.
>
> Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Please note!!!  I cannot compile this patch.  Mike can you review it?
>
>  drivers/hwtracing/coresight/coresight-cti.c | 96 ++++++++++++---------
>  1 file changed, 54 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 40387d58c8e7..d2da5bf9f552 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -747,17 +747,50 @@ static int cti_dying_cpu(unsigned int cpu)
>         return 0;
>  }
>
> +static int cti_pm_setup(struct cti_drvdata *drvdata)
> +{
> +       int ret;
> +
> +       if (drvdata->ctidev.cpu == -1)
> +               return 0;
> +
> +       if (nr_cti_cpu)
> +               goto done;
> +
> +       cpus_read_lock();
> +       ret = cpuhp_setup_state_nocalls_cpuslocked(
> +                       CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
> +                       "arm/coresight_cti:starting",
> +                       cti_starting_cpu, cti_dying_cpu);
> +       if (ret) {
> +               cpus_read_unlock();
> +               return ret;
> +       }
> +
> +       ret = cpu_pm_register_notifier(&cti_cpu_pm_nb);
> +       cpus_read_unlock();
> +       if (ret) {
> +               cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> +               return ret;
> +       }
> +
> +done:
> +       nr_cti_cpu++;
> +       cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> +
> +       return 0;
> +}
> +
>  /* release PM registrations */
>  static void cti_pm_release(struct cti_drvdata *drvdata)
>  {
> -       if (drvdata->ctidev.cpu >= 0) {
> -               if (--nr_cti_cpu == 0) {
> -                       cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
> +       if (drvdata->ctidev.cpu == -1)
> +               return;
>
> -                       cpuhp_remove_state_nocalls(
> -                               CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> -               }
> -               cti_cpu_drvdata[drvdata->ctidev.cpu] = NULL;
> +       cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;

This should remain as  cti_cpu_drvdata[drvdata->ctidev.cpu] = NULL;
here. We are reversing the assignment in cti_pm_setup().

> +       if (--nr_cti_cpu == 0) {
> +               cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
> +               cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
>         }
>  }
>
> @@ -823,19 +856,14 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>
>         /* driver data*/
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> -       if (!drvdata) {
> -               ret = -ENOMEM;
> -               dev_info(dev, "%s, mem err\n", __func__);
> -               goto err_out;
> -       }
> +       if (!drvdata)
> +               return -ENOMEM;
>
>         /* Validity for the resource is already checked by the AMBA core */
>         base = devm_ioremap_resource(dev, res);
> -       if (IS_ERR(base)) {
> -               ret = PTR_ERR(base);
> -               dev_err(dev, "%s, remap err\n", __func__);
> -               goto err_out;
> -       }
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
>         drvdata->base = base;
>
>         dev_set_drvdata(dev, drvdata);
> @@ -854,8 +882,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>         pdata = coresight_cti_get_platform_data(dev);
>         if (IS_ERR(pdata)) {
>                 dev_err(dev, "coresight_cti_get_platform_data err\n");
> -               ret =  PTR_ERR(pdata);
> -               goto err_out;
> +               return  PTR_ERR(pdata);
>         }
>
>         /* default to powered - could change on PM notifications */
> @@ -867,35 +894,20 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>                                                drvdata->ctidev.cpu);
>         else
>                 cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
> -       if (!cti_desc.name) {
> -               ret = -ENOMEM;
> -               goto err_out;
> -       }
> +       if (!cti_desc.name)
> +               return -ENOMEM;
>
>         /* setup CPU power management handling for CPU bound CTI devices. */
> -       if (drvdata->ctidev.cpu >= 0) {
> -               cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> -               if (!nr_cti_cpu++) {
> -                       cpus_read_lock();
> -                       ret = cpuhp_setup_state_nocalls_cpuslocked(
> -                               CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
> -                               "arm/coresight_cti:starting",
> -                               cti_starting_cpu, cti_dying_cpu);
> -
> -                       if (!ret)
> -                               ret = cpu_pm_register_notifier(&cti_cpu_pm_nb);
> -                       cpus_read_unlock();
> -                       if (ret)
> -                               goto err_out;
> -               }
> -       }
> +       ret = cti_pm_setup(drvdata);
> +       if (ret)
> +               return ret;
>
>         /* create dynamic attributes for connections */
>         ret = cti_create_cons_sysfs(dev, drvdata);
>         if (ret) {
>                 dev_err(dev, "%s: create dynamic sysfs entries failed\n",
>                         cti_desc.name);
> -               goto err_out;
> +               goto pm_release;
>         }
>
>         /* set up coresight component description */
> @@ -908,7 +920,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>         drvdata->csdev = coresight_register(&cti_desc);
>         if (IS_ERR(drvdata->csdev)) {
>                 ret = PTR_ERR(drvdata->csdev);
> -               goto err_out;
> +               goto pm_release;
>         }
>
>         /* add to list of CTI devices */
> @@ -927,7 +939,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>         dev_info(&drvdata->csdev->dev, "CTI initialized\n");
>         return 0;
>
> -err_out:
> +pm_release:
>         cti_pm_release(drvdata);
>         return ret;
>  }
> --
> 2.27.0
>

Reviewed-by Mike Leach <mike.leach@linaro.org>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
