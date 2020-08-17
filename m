Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440BBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1105A2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mu5RMyAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgHQVFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHQVFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:05:25 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06A7C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:05:24 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id n25so9009855vsq.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9PmqgIYzOOImZZLBY3kQUVlBb5GYyirm8BR71dJiqw=;
        b=Mu5RMyAB30MGUDbsENNdXuRiV4xyLY//ASCMKcHhT9b9pGdREc4oXNbsUG5hi805D4
         rgj+nxZBF8TrqjPsyn+0qTpc1hJHy6OSRmvOr5sp2Wrt+vSwYI9sp+9kyolCkSWUAuCT
         2J8ztk9CcxehsHLwobsEvxlggS0Lv/GmrU8xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9PmqgIYzOOImZZLBY3kQUVlBb5GYyirm8BR71dJiqw=;
        b=H9CTErZFce13uqJv3kZOwx7eD3AGJDzyVrFBzL9hcA+469i0wW3peIF33iPNtKP2Ek
         j0S7yD5guXpRroSxK2c/7u6FXlLV9NMqhgHKjyH8jgZtm2cr8znri/oaNKKyUAcAJgmE
         j2g1l5nuQYyUHSGdmQR1CJVCrjxmZHVl5GGIRvzulSlgTLN9Lz42XF8xudl1cR4GaQDo
         Ypd1ZE1k6aWDVEK6Ao0Z/4KHk5TAllvePv5c/zNxwy3NFMy3VWSLI51n3VJ8GhXNc955
         yd2GT/7yJ9q5hWUemljDFF9sP99Dkiflxyt6/Fgur7EGHfZHROYN06kaKgZzt0v3jbO7
         1Nqg==
X-Gm-Message-State: AOAM531e0ovgMKygDKD2hY4OjaPMm92Z+BGpQSdzmNaefjxMzoXAvWL3
        fqbsheMrOls8D7POow96/vvoo8WLJzCmww==
X-Google-Smtp-Source: ABdhPJykiOcAjnfL/F5gI54Xqrt+yjuN0P8bJGJxyrOACqvu07ojpRpiQuZHiBzNBZL8C9+fcH1SOQ==
X-Received: by 2002:a67:cd0c:: with SMTP id u12mr9426804vsl.15.1597698323155;
        Mon, 17 Aug 2020 14:05:23 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id n123sm3693375vkf.41.2020.08.17.14.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 14:05:22 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id g11so5179048ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:05:22 -0700 (PDT)
X-Received: by 2002:a9f:2b89:: with SMTP id y9mr9057188uai.0.1597698321704;
 Mon, 17 Aug 2020 14:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200817144722.6665-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200817144722.6665-1-saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Aug 2020 14:05:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VE6vCPjDvvP0e73tnd8u5rPuMUa-mwvDazrfUpXP+bKQ@mail.gmail.com>
Message-ID: <CAD=FV=VE6vCPjDvvP0e73tnd8u5rPuMUa-mwvDazrfUpXP+bKQ@mail.gmail.com>
Subject: Re: [PATCHv2] soc: qcom: llcc: Support chipsets that can write to
 llcc registers
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 17, 2020 at 7:47 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
>
> Older chipsets may not be allowed to configure certain LLCC registers
> as that is handled by the secure side software. However, this is not
> the case for newer chipsets and they must configure these registers
> according to the contents of the SCT table, while keeping in mind that
> older targets may not have these capabilities. So add support to allow
> such configuration of registers to enable capacity based allocation
> and power collapse retention for capable chipsets.

I have very little idea about what the above means.  That being said,
what's broken that this patch fixes?  Please include this in the CL
description.  It should answer, in the very least, the following two
questions:

a) Were existing attempts to do capacity based allocation failing, or
is capacity based allocation a new whizbang feature that a future
patch will add and you need this one to land first?

b) Why was it bad not to enable power collapse retention?  Was this
causing things to get corrupted after resume?  Was this causing us to
fail to suspend?  Were we burning too little power in S3 and the
battery vendors are looking for an excuse to sell bigger batteries?

I'm not very smart and am also lacking documentation for what the heck
all this is, so I'm looking for the "why" of your patch.


> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> (sai: use table instead of dt property and minor commit msg change)
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>
> Changes in v2:
>  * Fix build errors reported by kernel test robot.
>
> ---
>  drivers/soc/qcom/llcc-qcom.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 429b5a60a1ba..865f607cf502 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -45,6 +45,9 @@
>  #define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
>  #define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
>
> +#define LLCC_TRP_SCID_DIS_CAP_ALLOC   0x21F00
> +#define LLCC_TRP_PCB_ACT              0x21F04
> +
>  #define BANK_OFFSET_STRIDE           0x80000
>
>  /**
> @@ -318,6 +321,11 @@ size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(llcc_get_slice_size);
>
> +static const struct of_device_id __maybe_unused qcom_llcc_configure_of_match[] = {
> +       { .compatible = "qcom,sc7180-llcc" },
> +       { }
> +};

Why are you introducing a whole second table?  Shouldn't you just add
a field to "struct qcom_llcc_config" ?


> +
>  static int qcom_llcc_cfg_program(struct platform_device *pdev)
>  {
>         int i;
> @@ -327,13 +335,17 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev)
>         u32 attr0_val;
>         u32 max_cap_cacheline;
>         u32 sz;
> +       u32 disable_cap_alloc = 0, retain_pc = 0;

Don't init to 0.  See below.


>         int ret = 0;
>         const struct llcc_slice_config *llcc_table;
>         struct llcc_slice_desc desc;
> +       const struct of_device_id *llcc_configure;
>
>         sz = drv_data->cfg_size;
>         llcc_table = drv_data->cfg;
>
> +       llcc_configure = of_match_node(qcom_llcc_configure_of_match, pdev->dev.of_node);
> +

As per above, just use the existing config.


>         for (i = 0; i < sz; i++) {
>                 attr1_cfg = LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
>                 attr0_cfg = LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
> @@ -369,6 +381,21 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev)
>                                         attr0_val);
>                 if (ret)
>                         return ret;
> +
> +               if (llcc_configure) {
> +                       disable_cap_alloc |= llcc_table[i].dis_cap_alloc << llcc_table[i].slice_id;

Don't "|=".  You're the only place touching this variable.  Just set it.


> +                       ret = regmap_write(drv_data->bcast_regmap,
> +                                               LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
> +                       if (ret)
> +                               return ret;
> +
> +                       retain_pc |= llcc_table[i].retain_on_pc << llcc_table[i].slice_id;

Don't "|=".  You're the only place touching this variable.  Just set it.


-Doug
