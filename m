Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97695C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AA920720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtWyJuBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgGHNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgGHNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:33:48 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE26C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:33:48 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id p6so7301275uaq.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1GTsvB1sENuLYTitDg+4KJVrg9ZAbmGFqqoF3A8ork=;
        b=dtWyJuBqyJLR1bSeZKeSipNjWrOFaLi6Et+BtwiwCKDNFw0+FIShvW+J/3Zd9/eNMQ
         9YJVXSlhQXbXA8jaAqde+sMEJLnyaXWSUoidNhNR+NmVMmPmxA6kF+JBBmh2Ydq8HuEy
         EmKgvmg8Qjh3GVaZ2Rtl+p2ZbohNCy71uE5htKD2NCCSgiOetnmxfHQyjUYCx3sCvxRe
         rRoeYQMCKVqz8JnhgKN41bBr3vjWxhJMH0t5Pc0xkEPmQ+UQ+B6D5GMLvfs5XjyqLtt2
         VnRcoB7+ZHiUYClGpfXYVVTCNBLDg5LARAre3p2R55W91wq/SbA6N2DIn0D5j6l9XqoZ
         /Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1GTsvB1sENuLYTitDg+4KJVrg9ZAbmGFqqoF3A8ork=;
        b=FPYSIbMh+DpTIYUipnpqcL6GvonHsKczUM+ZmWpz4hTUxHJ1q3QYzzKqiCk5dL+UNS
         YYtZrzLs2wTgYBCDP5d7JVPARFiZZx0LuM7lw84Lx9FBKDkXrKFiS1LdYhm/gLV9i/sz
         CTK3TfROPh4PL2+hUc57JNmaay3Uz2v10Tvk0HrqDAVgRZV2yBvrfJBWcZJtwV2DQWXI
         rVZ7efjZGMgXTAeokuXxy+alb7pLuF2o55lYcAP+6SCX+VaYLqS1if7w2Z4AW4L0Uq+5
         QO8k8yNZdUFKduYzKA/THEmc50pz0gTCeNoUYUIhj1VQ43j2d1SVDeNbz1bQKxHT+o30
         B+BQ==
X-Gm-Message-State: AOAM533yXulT6/9F5IqxGUoqSzKWCY+gWGci5JiFKF1urVTs5gGVMvlQ
        90IOXrJ4uuuQObs6niDYd9qWCGNhMIGIO3WhY8QQVA==
X-Google-Smtp-Source: ABdhPJw+0z3dQW3AcfspoIM8itefwk3QY2ggPT+DFUkCpMKHpkWyXEKW3t8CCIUcJ8Mn3muqMEBQNOiJv4qt/ZeKuu8=
X-Received: by 2002:ab0:6f0a:: with SMTP id r10mr49334442uah.100.1594215227202;
 Wed, 08 Jul 2020 06:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Jul 2020 15:33:10 +0200
Message-ID: <CAPDyKFqiAeQYcqkb=Wv2stgTb9yvGwFfHv-BGtd5VuyJxfJXAA@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Override DLL_CONFIG only if the valid
 value is supplied
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>,
        Sarthak Garg <sartgarg@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 15:12, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> During DLL initialization, the DLL_CONFIG register value would be
> updated with the value supplied from the device-tree.
>
> Override this register only if a valid value is supplied.
>
> Fixes: 03591160ca19 ("mmc: sdhci-msm: Read and use DLL Config property from device tree file")
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index efd2bae1430c..93d67a3a899f 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -626,8 +626,9 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>         config &= ~CORE_CLK_PWRSAVE;
>         writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec);
>
> -       config = msm_host->dll_config;
> -       writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config);
> +       if (msm_host->dll_config)
> +               writel_relaxed(msm_host->dll_config,
> +                               host->ioaddr + msm_offset->core_dll_config);
>
>         if (msm_host->use_14lpp_dll_reset) {
>                 config = readl_relaxed(host->ioaddr +
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
