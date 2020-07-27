Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AF6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E432075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l78o4thx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgG0MGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgG0MGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:06:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:06:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so6844923wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5UvigPasIrEc+VPwUEGBhdkiXGZn95eI7wd8yU/NXHk=;
        b=l78o4thxdBd3295c7pq1uvaxXqQTXHoIQBDLzkseo8M7LFVeKFainbABNhEmZapKRT
         P5oJ4Vup4dtsW/3gtAbTrXJDdAlShl6zK2tUyzN4TfvHhxQ3Y8ZGBRjs6AZFYJJGdAfm
         dwiY3NQxeS41hV5vvXoSrW6GPkCDFlVn4D4kODRAQ3qCN0cfix/c/oOLgYtyBDc3NpM5
         BZR2gyEtU8S5oFQbmcwpHagAGPNAyCjf2Df7FoOj1rkV+7XyHn6aUY3StpbafKoaM0el
         i5ke21itLgICKDUfYFWS9C2nWnpHfoKub8TU5N+gFSHLKtawF4HM1QcXrYDdVlQutv0M
         8Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5UvigPasIrEc+VPwUEGBhdkiXGZn95eI7wd8yU/NXHk=;
        b=KerTUslPoPTFdLxkVMA+RxXGakc6+kwrBO/GUwLAa+GheL9HcGFoEjU7rxiuPcCdI9
         qzjVprncAc1ZH0eBull2VmVRl/+TF8BCHi4TqNZ/WODXdjJ5v1dHQ9tWwuL5M2eCkLjp
         STb1yE9+gJGhSZqEceQpXcaFntXeMtNH7CMRG1wBC4h0n2OBVhS5mz6NKuwhHtkcuWhW
         kEE9FjQgNTPwKGvAgqO9xUwg/FCfcW0Duiqj/Ht6r197w2o0uaL/qjE5RhEot1AYOUMo
         aGv99AU6eyjT946UrVzSn/sYz9d2HZL8nmItqrg2zw6anCthR0Yi427hqS+RcjlIxbGU
         B4VQ==
X-Gm-Message-State: AOAM5335dFeVWSuDWnvsGAtZ3Ct7AcqGjodg9RK9GtnvxNcrj6gcahI9
        ZlvD2uEL1oC3MC28jllu/0/vlQ==
X-Google-Smtp-Source: ABdhPJyuQ01S7wwBQxUL+QMuwikPrDGYc6VGrJ4m7+PH/d8swh6Q30/Gg3VIPA0xLk3rSz+BtA3rQg==
X-Received: by 2002:a1c:98c1:: with SMTP id a184mr20475238wme.116.1595851603333;
        Mon, 27 Jul 2020 05:06:43 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id k4sm13177909wrd.72.2020.07.27.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 05:06:42 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:06:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 5/9] mfd: mt6360: Rename mt6360_pmu_data by mt6360_data
Message-ID: <20200727120641.GL1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-6-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594983811-25908-6-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Rename mt6360_pmu_data by mt6360_data because of including
> not only PMU part, but also entire MT6360 IC.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c  | 44 ++++++++++++++++++++++----------------------
>  include/linux/mfd/mt6360.h |  2 +-
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 665e26f..62bae1a 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -210,9 +210,9 @@ static const struct regmap_irq mt6360_pmu_irqs[] =  {
>  
>  static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
>  {
> -	struct mt6360_pmu_data *mpd = irq_drv_data;
> +	struct mt6360_data *data = irq_drv_data;

'data' is a terrible variable name.

Could you rename this 'ddata' please?

[...]

> -struct mt6360_pmu_data {
> +struct mt6360_data {

Same here, 'mt6360_ddata'.

Once you make these changes, you can add my:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
