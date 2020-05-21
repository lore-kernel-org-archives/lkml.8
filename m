Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F42C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBEE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYeLrq91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgEUQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgEUQIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:08:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E5DC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:08:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s21so9513201ejd.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/lJE4jLHbbeHy9SYo6zuw/2TSWZ5aZ/0UMTVBF2YCM=;
        b=fYeLrq91quQesoERuZPsz/Ps4qkrIkmowKFI0B/ZhRqAPrmHO09OkSYMD+RAZDQixU
         aCGCKMDpEKVKJq1rw9auco0YbvpR8PVNmqjyAiHjQ6SISqoIhFkyPRFDzPGtB4wv1Uo6
         kvbd8g0VtMRObCORqfbMnoYv5I6nvtChcWU5QL6xNLxtxcKYV/eSpZxSMmA0kJx2q2qP
         ZKCXqP6d5rANy6v6jOZ6W4lLTEvDciRdWBmOcOdCtmZk4oC2tfo7zN2Dz8sl2mmu7lXD
         hTnADtxtYPH21HlpduhXIqTiyo+L4o8QnW03GDu0/+HPK97bwNao3CfHROyeGCiaGMoK
         np/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/lJE4jLHbbeHy9SYo6zuw/2TSWZ5aZ/0UMTVBF2YCM=;
        b=e/DN8kM/sTA/zuqJad0PjKabBdazXoS0O8JACxES+GvsTZ8BBl067nr4YEmPdg8tGI
         tKeTvHnEGUY7f5kZeRY16+AC89OvEUppxDNokwjyKJ7kgppU+TV4dnhl+coZC2fIB53z
         rnnezK57zWENfBPKsc/4WGy1oqYWBDOBzb5E08YXIO+g7oDOd+dUuF4ZrywPLD+j3SoO
         1hU+brq1cHcvrHmKjEvyw8zU0Kq4B30ueHDY/4MPHOpvCEPFCue22e7i93J/8DMww77E
         sYw4RfUXnJp49dMXl95wPXgpXVb165iXHZcil80z5l0OqKBak7nkuLME52eV6EjOlJWF
         6zqg==
X-Gm-Message-State: AOAM533eAuoJ+yRVc4qmjaAuxwYhImEBgGNgosipxXLwvUVMlOqIeXzo
        JzJCo21qO4lMJwebJoOcz2SRGsKZX8QJAC50fP+us+bzjqc=
X-Google-Smtp-Source: ABdhPJyFdE5SlV3DmqLLNA1YVjp8NUcII49o3lvYKjNS94r0EBsgKE8zBb0qyErcyZhYRXTzs5T/bifZ5hpPmMcacow=
X-Received: by 2002:a17:906:ce39:: with SMTP id sd25mr4333973ejb.477.1590077300428;
 Thu, 21 May 2020 09:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589894597.git.saiprakash.ranjan@codeaurora.org> <c2e02d0c92b081c05b91d07ec17e648c40af3897.1589894597.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <c2e02d0c92b081c05b91d07ec17e648c40af3897.1589894597.git.saiprakash.ranjan@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 21 May 2020 17:08:09 +0100
Message-ID: <CAJ9a7ViRLzicR3tu8q4X5dEnYUCo-Tz6fi=baU0CVQTofvMV+w@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] coresight: replicator: Reset replicator if context
 is lost
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On Tue, 19 May 2020 at 14:36, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On some QCOM SoCs, replicators in Always-On domain loses its
> context as soon as the clock is disabled. Currently as a part
> of pm_runtime workqueue, clock is disabled after the replicator
> is initialized by amba_pm_runtime_suspend assuming that context
> is not lost which is not true for replicators with such
> limitations. So add a new property "qcom,replicator-loses-context"
> to identify such replicators and reset them.
>
> Suggested-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>
> Added Mike's suggested by for parts other than the DT property.
> Perhaps I should add Co-developed-by Mike since the full skeletal
> was given by Mike. I can add that if required on the next version.
>
> ---
>  .../coresight/coresight-replicator.c          | 53 +++++++++++++------
>  1 file changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index c619b456f55a..ba66160c8140 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -38,6 +38,7 @@ struct replicator_drvdata {
>         struct clk              *atclk;
>         struct coresight_device *csdev;
>         spinlock_t              spinlock;
> +       bool                    check_idfilter_val;
>  };
>
>  static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
> @@ -66,29 +67,43 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
>                                      int inport, int outport)
>  {
>         int rc = 0;
> -       u32 reg;
> -
> -       switch (outport) {
> -       case 0:
> -               reg = REPLICATOR_IDFILTER0;
> -               break;
> -       case 1:
> -               reg = REPLICATOR_IDFILTER1;
> -               break;
> -       default:
> -               WARN_ON(1);
> -               return -EINVAL;
> -       }
> +       u32 id0val, id1val;
>
>         CS_UNLOCK(drvdata->base);
>
> -       if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
> -           (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
> +       id0val = readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0);
> +       id1val = readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1);
> +
> +       /*
> +        * Some replicator designs lose context when AMBA clocks are removed,
> +        * so have a check for this.
> +        */
> +       if (drvdata->check_idfilter_val && id0val == 0x0 && id1val == 0x0)
> +               id0val = id1val = 0xff;
> +
> +       if (id0val == 0xff && id1val == 0xff)
>                 rc = coresight_claim_device_unlocked(drvdata->base);
>
> +       if (!rc) {
> +               switch (outport) {
> +               case 0:
> +                       id0val = 0x0;
> +                       break;
> +               case 1:
> +                       id1val = 0x0;
> +                       break;
> +               default:
> +                       WARN_ON(1);
> +                       rc = -EINVAL;
> +               }
> +       }
> +
>         /* Ensure that the outport is enabled. */
> -       if (!rc)
> -               writel_relaxed(0x00, drvdata->base + reg);
> +       if (!rc) {
> +               writel_relaxed(id0val, drvdata->base + REPLICATOR_IDFILTER0);
> +               writel_relaxed(id1val, drvdata->base + REPLICATOR_IDFILTER1);
> +       }
> +
>         CS_LOCK(drvdata->base);
>
>         return rc;
> @@ -239,6 +254,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
>                 desc.groups = replicator_groups;On HolidayOn Holiday
>         }
>
> +       if (fwnode_property_present(dev_fwnode(dev),
> +                                   "qcom,replicator-loses-context"))
> +               drvdata->check_idfilter_val = true;
> +
>         dev_set_drvdata(dev, drvdata);
>
>         pdata = coresight_get_platform_data(dev);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Suggested-by is just fine - I didn't actually try out my suggested
code after all!

Reviewed-by Mike Leach <mike.leach@linaro.org>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
