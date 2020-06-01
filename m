Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DFBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F00F72077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mky9fRdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFAN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFAN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:27:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF6C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 06:27:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id k11so9187949ejr.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JJuCOOH8RdyowotzK9kI82M2Yj9yM7F/os1HkdyKYM=;
        b=Mky9fRdd7XLKQsd9lAv/YYGG/0o9TrtEeTojVwvK2dc5yWW2Tt+ptZTvz+0raNcp3M
         N34NJbhALxjTn1xcG9PeaznZExXVDJk2DJDRzS8IrmFpsPySRJuYPID1abcv4z8xiK/E
         bTy8cqD/U1IIgPIuf7UNrSebyBB0d/n4VWz/XJyXRmhQZaRKKuOWJKxAzrVK+XrdZTpv
         KIJQexh/L/HOnwvrlawKrL/Ed4VF6/tZSr76+RAd+B9/u47f21ZVSrr7DTXvxTitDuno
         HJeZ7isPxmCj3XmC29WEf67wXdWpczUeBQeZgviFjDg76RhEbW9hrMKZBg+S7fzV5jP3
         RWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JJuCOOH8RdyowotzK9kI82M2Yj9yM7F/os1HkdyKYM=;
        b=IItEBuqq8DHtg7ZSujGzixC9EqQJkYhG6c6n+w1+zTsR9T441SUZAVPWlXUrhTkdT7
         fxBr2y2LIzwoSjgRskt5PW5dmmF7/2wYnLYEFPIyIGdidv7lVij0RfftHRBHfkJ6VYmn
         TACumioPj2ZFUaPpMaR4bvIhNREdT23vVVcUbcfYOMgUTQB13e72aOXLXAZ4hk2vLOBq
         mAmNdjBjeo6NE40OIFC/SsyRU9TVwSfxsqfqaaD+rap1PZBk8fIb6Dzbu6aBItTzrFbx
         MnhsL8Qk2vdVXdgdwaNIXjZn/0R6M9WiymJwom+0m/ag7bN8ZwJB153c2PNP+60T8ey0
         wI8Q==
X-Gm-Message-State: AOAM532gEXXFpVTHlsfJcDsg4W/vFX5j+rQ0KvyuvVujOwTVBeAsMTr6
        Eb86K/HokpxEiVd5rm5jUtnenQp5xEoKgGUpiRha7g==
X-Google-Smtp-Source: ABdhPJzYZICWrmW4FMgFWWqrndKLW4lZTBdMdQDXaf6oGPoMqEtnHDTYcLJCGbJRQSohmSn3AKpRofu5ADkRfevPb3I=
X-Received: by 2002:a17:907:9484:: with SMTP id dm4mr20655143ejc.56.1591018067462;
 Mon, 01 Jun 2020 06:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590947174.git.saiprakash.ranjan@codeaurora.org> <6e62147c36c76b9485d14960dced4f6acda17591.1590947174.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <6e62147c36c76b9485d14960dced4f6acda17591.1590947174.git.saiprakash.ranjan@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 1 Jun 2020 14:27:36 +0100
Message-ID: <CAJ9a7Vh=GPKdYcX3aiJfaAVQ3j8rEmoSvP0CDeF-mfPpV4DMaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] coresight: tmc: Add enable flag to indicate the
 status of ETR/ETF
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
> Add a flag to check whether TMC ETR/ETF is enabled or not.
> This is later used in shutdown callback to determine if
> we require to disable ETR/ETF.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc.c | 2 ++
>  drivers/hwtracing/coresight/coresight-tmc.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 39fba1d16e6e..5a271ebc4585 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -62,11 +62,13 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>
>  void tmc_enable_hw(struct tmc_drvdata *drvdata)
>  {
> +       drvdata->enable = true;
>         writel_relaxed(TMC_CTL_CAPT_EN, drvdata->base + TMC_CTL);
>  }
>
>  void tmc_disable_hw(struct tmc_drvdata *drvdata)
>  {
> +       drvdata->enable = false;
>         writel_relaxed(0x0, drvdata->base + TMC_CTL);
>  }
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 71de978575f3..d156860495c7 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -184,6 +184,7 @@ struct etr_buf {
>   * @idr_mutex: Access serialisation for idr.
>   * @sysfs_buf: SYSFS buffer for ETR.
>   * @perf_buf:  PERF buffer for ETR.
> + * @enable:    Indicates whether ETR/ETF is enabled.
>   */
>  struct tmc_drvdata {
>         void __iomem            *base;
> @@ -207,6 +208,7 @@ struct tmc_drvdata {
>         struct mutex            idr_mutex;
>         struct etr_buf          *sysfs_buf;
>         struct etr_buf          *perf_buf;
> +       bool                    enable;

Is this flag needed?
For TMC, drvdata->mode indicates if the device is in use.

Regards

Mike
>  };
>
>  struct etr_buf_operations {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
