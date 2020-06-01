Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D112068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpxeSmw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFANfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgFANfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:35:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9925C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 06:35:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a25so2030180ejg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ogBD788sO7PXIvbKDdkf5UaxzA6PdTnNLJCyLo4Unw=;
        b=cpxeSmw+TKgz5ekToV2e2NrqfhrTVxweE4Lb9avE/k7fngAV7Aou2Lzwa4NnciRi0X
         8GYyYP0jy75m998wmGumju2ImFM2cEuV8/YrQEA+eb/oMpAwXESrpNTzQlIrB917RYGT
         Sj13uJL3DE6Fy+iXCbu75k8uOBv9hMUmnVIRwuEM9ylLogvM8EIQJAjxayttoPo2q9fA
         1laUMVDPWTQgaIil3zDdJwbEAZag7RLqrqm594f46jd9xqWYvT+lSAwrM6ijFto0AwS8
         mlMpfxhrp1ZkbpPfqGJ6gTssdzwSvDisu+G/YNveliOcuMYZHLxtAOUwoj+yXlnICrTS
         AYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ogBD788sO7PXIvbKDdkf5UaxzA6PdTnNLJCyLo4Unw=;
        b=ajdgOtAsfPwMkSYpLsmKfBhPffR6cng6BQV/ciEiUls7Sbm+ng6DcAY57XGwRxCrex
         D00l7EMvBXJLprPDwQKYT7dYbzEdhvNiyLeHQtv6UNUkOIo/oMmYLMwuNqCteCEihbZB
         hATdHL2yxu8SnkMsvo4VgTyJ9TSOGaDrikawQsipvnZp3dWbe4bugO0uFX/FW6w2x9WH
         ntoqPFl1qrO84nYUQKMGmHQk2BiK1cJmcU4y95KOYnlYT1OZr/V0BXYYWdAmDTVh9hxL
         FGe/2/zwhfPT5eDJzYoLyrQ5LSKdAMrWn2miDIK2sJHQgPYs/sGnI5jqtz0HejypJVSb
         hM9A==
X-Gm-Message-State: AOAM530KLkqFiGI04YK72AxUnAqPxuEVtWSzS7YR72/K4Oba7fcwDJ00
        pDWuisj0RLHuGWiVK5Oqi363vZulNzYoSfl9voIm8A==
X-Google-Smtp-Source: ABdhPJx3KgSuOzGQ7ksbxukLUvEy6AWgfcT6Iivkp+bKnjl7KBwaSasw0hwhYNOWhoomEqA8Lld0Spfx1yDdQx0D80Y=
X-Received: by 2002:a17:906:3603:: with SMTP id q3mr9251366ejb.477.1591018548300;
 Mon, 01 Jun 2020 06:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590947174.git.saiprakash.ranjan@codeaurora.org> <28123d1e19f235f97555ee36a5ed8b52d20cbdea.1590947174.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <28123d1e19f235f97555ee36a5ed8b52d20cbdea.1590947174.git.saiprakash.ranjan@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 1 Jun 2020 14:35:37 +0100
Message-ID: <CAJ9a7VgxDru8P_RXE2ewGkSA2mfCNvOp+hMuNLB4AszXBOUp1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] coresight: tmc: Add shutdown callback for TMC ETR/ETF
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 1 Jun 2020 at 09:02, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Implement a shutdown callback to ensure ETR/ETF hardware is
> properly shutdown in reboot/shutdown path. This is required
> for ETR/ETF which has SMMU address translation enabled like
> on SC7180 SoC and few others. If the hardware is still accessing
> memory after SMMU translation is disabled as part of SMMU
> shutdown callback in system reboot or shutdown path, then
> IOVAs(I/O virtual address) which it was using will go on the bus
> as the physical addresses which might result in unknown crashes
> (NoC/interconnect errors). So we make sure from this shutdown
> callback that the ETR/ETF is shutdown before SMMU translation is
> disabled and device_link in SMMU driver will take care of ordering
> of shutdown callbacks such that SMMU shutdown callback is not
> called before any of its consumer shutdown callbacks.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  .../hwtracing/coresight/coresight-tmc-etf.c   |  4 +--
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
>  drivers/hwtracing/coresight/coresight-tmc.c   | 29 +++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tmc.h   |  3 ++
>  4 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 36cce2bfb744..cba3e7592820 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -85,7 +85,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>         CS_LOCK(drvdata->base);
>  }
>
> -static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
> +void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>  {
>         __tmc_etb_disable_hw(drvdata);
>         coresight_disclaim_device(drvdata->base);
> @@ -118,7 +118,7 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>         return 0;
>  }
>
> -static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
> +void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
>  {
>         CS_UNLOCK(drvdata->base);
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 625882bc8b08..b29c2db94d96 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1110,7 +1110,7 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>
>  }
>
> -static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
> +void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  {
>         __tmc_etr_disable_hw(drvdata);
>         /* Disable CATU device if this ETR is connected to one */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 5a271ebc4585..7e687a356fe0 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -540,6 +540,34 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>         return ret;
>  }
>
> +static void tmc_shutdown(struct amba_device *adev)
> +{
> +       struct tmc_drvdata *drvdata = amba_get_drvdata(adev);
> +

Take drvdata->spinlock here? The tmc_xxx_disable_hw functions are
normally called with the spinlock claimed.

> +       if (!drvdata->enable)

As per previous patch drvdata->mode can be used here.

Regards

Mike

> +               goto out;
> +
> +       /*
> +        * We do not care about the active trace sessions here
> +        * since the system is going down unlike remove callback,
> +        * just make sure that the hardware is shutdown.
> +        */
> +       switch (drvdata->config_type) {
> +       case TMC_CONFIG_TYPE_ETB:
> +               tmc_etb_disable_hw(drvdata);
> +               break;
> +       case TMC_CONFIG_TYPE_ETF:
> +               tmc_etf_disable_hw(drvdata);
> +               break;
> +       case TMC_CONFIG_TYPE_ETR:
> +               tmc_etr_disable_hw(drvdata);
> +       }
> +
> +out:
> +       misc_deregister(&drvdata->miscdev);
> +       coresight_unregister(drvdata->csdev);
> +}
> +
>  static const struct amba_id tmc_ids[] = {
>         CS_AMBA_ID(0x000bb961),
>         /* Coresight SoC 600 TMC-ETR/ETS */
> @@ -558,6 +586,7 @@ static struct amba_driver tmc_driver = {
>                 .suppress_bind_attrs = true,
>         },
>         .probe          = tmc_probe,
> +       .shutdown       = tmc_shutdown,
>         .id_table       = tmc_ids,
>  };
>  builtin_amba_driver(tmc_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index d156860495c7..f4f56c474e58 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -262,6 +262,8 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
>  /* ETB/ETF functions */
>  int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
>  int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata);
> +void tmc_etb_disable_hw(struct tmc_drvdata *drvdata);
> +void tmc_etf_disable_hw(struct tmc_drvdata *drvdata);
>  extern const struct coresight_ops tmc_etb_cs_ops;
>  extern const struct coresight_ops tmc_etf_cs_ops;
>
> @@ -270,6 +272,7 @@ ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
>  /* ETR functions */
>  int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
>  int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
> +void tmc_etr_disable_hw(struct tmc_drvdata *drvdata);
>  extern const struct coresight_ops tmc_etr_cs_ops;
>  ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
>                                 loff_t pos, size_t len, char **bufpp);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
