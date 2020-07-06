Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52475C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312902070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAf3TrUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgGFOtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgGFOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:49:49 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0AC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:49:49 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id j21so284720ual.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJansEGmPdeGOGXnqzYZzxjZ76Z/vpZoEqZEVdL7ZJw=;
        b=jAf3TrUasdW4EPNpi+PhMii3nsGn4wqlWpuseKVDJQ+tR69z9Bja0hwcuPuE4GxKok
         HZLd2OpbLRn2p+uWbmIIajaMBEXykLH3KdhV4uGMUgzy6wLDS421i/Cphfn9OhH3PC2+
         64Ep9+YYeFK/g2JgQscYuu/FexYq9D+3nfnv2zn8KTQ33S6TM8guDdOy+AwEYP08wtrS
         aNkq3DYht/YS1K9+dpvUpF/6g0/lSLNw/9BeiFBFiSJX7iM/W/LJi+Ag8OyZUBSJ8lNI
         kkPN+M6tUNY+Gv55A9RKniDz+3bmZ3BWPJlXZoZFQD2kfOy4xgmDcXWkrBERoNv6r82T
         EaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJansEGmPdeGOGXnqzYZzxjZ76Z/vpZoEqZEVdL7ZJw=;
        b=B9agq43UMxWFW+4QuuzowvMO7wQLghof8AsQPGpZcU0oZRpHL3dL23Dg5ecN4wgVVH
         wQrC11sg+GtWVTS7tDUPhf9G7vvWzgJwkvqr12nWVJ2KFCvxjrzvepgepvVQNuE3Endg
         9XQSWLhqCLsCQ6nZdDt4ujBxut4Yd+olt8Z9rVvFdaBdApzQupZNK6bNUXo/xw9rjHN9
         SM5+Vpwv6JrqwyIHdewuXJbRDrK/hQckoaFRYP7hp/B+O3GFYfzV2/UpKf6w4wNDn8Yc
         4Mc4Uw3P+De+ZxmQhm2WWFqngb4IgLFQFtSrdpRluwvEQJ5kFqsomKLDOqsSBvXc4ilX
         nCsg==
X-Gm-Message-State: AOAM531ai/E1olVQ0P8jnEv4nvQMnxmboSXIYysL98WGb+R/z++FvgwC
        7CeY6stDQXefhXZCVRc4ivSpwEAfwyr8NZKSbotBIQ==
X-Google-Smtp-Source: ABdhPJy72u3CpM6RLtUQ6iqGATk2GoTxo0fagGN1UKNvQ4nHU/ra/+dEuPRZdsJK6pqbi+duJvZ/U9n4kKqsB9qmIQA=
X-Received: by 2002:ab0:4e98:: with SMTP id l24mr3487632uah.15.1594046988524;
 Mon, 06 Jul 2020 07:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200623133347.4598-1-akshu.agrawal@amd.com>
In-Reply-To: <20200623133347.4598-1-akshu.agrawal@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:49:11 +0200
Message-ID: <CAPDyKFrV9vn1jFEzCWZ-5aDHSyTz9+m9MM_CWLp9iA86YCGTwg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: For amd device set driver type as MMC_SET_DRIVER_TYPE_A
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     rrangel@google.com,
        "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 15:34, Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> HS400/HS200/eMMC HS doesn't have Preset Value register.
> Hence, sdhci_set_ios function overrides the value set by fmw to
> SDHCI_CTRL_DRV_TYPE_B.
> This patch sets drv_type to MMC_SET_DRIVER_TYPE_A
> so that host_control2 register gets updated with the required
> strength value.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index d8b76cb8698a..48ecbd0b180d 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -542,6 +542,7 @@ static int amd_select_drive_strength(struct mmc_card *card,
>                                      unsigned int max_dtr, int host_drv,
>                                      int card_drv, int *drv_type)
>  {
> +       *drv_type = MMC_SET_DRIVER_TYPE_A;
>         return MMC_SET_DRIVER_TYPE_A;
>  }
>
> --
> 2.20.1
>
