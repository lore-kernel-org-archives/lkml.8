Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBA720776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIkaLL9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgE1KQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbgE1KPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:15:03 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54EEC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:15:02 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id d22so3573787vkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFpDBbrHEeT5xAI+qYBx9rcH60UUN2udEsNMOSyFQ7M=;
        b=RIkaLL9VqsXXK1DHiTafAsYpzTRa0aIHMBATB83QXKiWmXmFatDm6fRrBRPe76rlvT
         Dwr9cm3HrMFlp0Y6/cjmzbQb4qRKsuVWnVre09ea8X3RQh/lfPZx7WFtUREXt3Fmo31s
         GzD7atxAtpLEqIMLweIlNFnpeAIuHQf6Y91JhXIabRlTW8FQFd+tOSYDa8S2i70qslLo
         8y8PfetflXzmIhltE4AIzd3QqJjU84cJTuEl51YsH/FZMdvQWPV8V8BphrgQLkCoRjle
         tufz7VAftw3Yu2ULboRGcmfof7SCqWa3kHQlSyqdNL3dWofLne0S94MHuVyyDGhEEQUi
         /bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFpDBbrHEeT5xAI+qYBx9rcH60UUN2udEsNMOSyFQ7M=;
        b=OtMshDQYFlM8Zz6oMQJUnoAQjjvQZn0JZ3cKDi644ZGOjroFF6ccYNwGqMhX/haiRn
         Cf78YuN/H9ohItZY2R5lQNBeCTJ7ZaD9qns1B8ioflwc7vHaUN+wMRMsfn0s6Qrp4hTa
         O3lGZQJcj/oF0zHYmcM4vnXADPzkRcsQ8smZtJuVH7Z80i/z8AiP1MTrceIhGwCmN0sa
         m4vvMGoCEw7oNbZi7KF4vgVI1zc8skepnDwouzcjgPIpIJhNBdLYukvomFqTnRTAK6L3
         kIp7fJKG+4sk3EQAR3jxvm46H0SLFfyaki7LYQk3HywgvwlIWIpxXjNfhR36uhq60w4q
         5P4A==
X-Gm-Message-State: AOAM532vkAnDhx8HamknZK1MYr2F62RMk2T8ZVjV1FYMUpWxymqSsEAL
        oB/6eo3WF9/UdkgkbLWW/XOlr7TrTPprMMizGwkhZg==
X-Google-Smtp-Source: ABdhPJz8enCJHhd0jfdJ+DBmNgKKBHckVDKWeCVKVJF6gzV7WcLLPi1FCACEAj6Hvns2GZzF5yYelsjvOCKbyjqzjTc=
X-Received: by 2002:a1f:4845:: with SMTP id v66mr1493594vka.43.1590660902066;
 Thu, 28 May 2020 03:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200526155103.12514-1-ludovic.barre@st.com> <20200526155103.12514-2-ludovic.barre@st.com>
In-Reply-To: <20200526155103.12514-2-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:25 +0200
Message-ID: <CAPDyKFosrfuZGHZhDyVmst67_-RT6G6R4h=M4qedTzdOiB+HaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci_sdmmc: fix DMA API warning overlapping mappings
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 at 17:51, Ludovic Barre <ludovic.barre@st.com> wrote:
>
> Turning on CONFIG_DMA_API_DEBUG_SG results in the following warning:
> WARNING: CPU: 1 PID: 20 at kernel/dma/debug.c:500 add_dma_entry+0x16c/0x17c
> DMA-API: exceeded 7 overlapping mappings of cacheline 0x031d2645
> Modules linked in:
> CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted 5.5.0-rc2-00021-gdeda30999c2b-dirty #49
> Hardware name: STM32 (Device Tree Support)
> Workqueue: events_freezable mmc_rescan
> [<c03138c0>] (unwind_backtrace) from [<c030d760>] (show_stack+0x10/0x14)
> [<c030d760>] (show_stack) from [<c0f2eb28>] (dump_stack+0xc0/0xd4)
> [<c0f2eb28>] (dump_stack) from [<c034a14c>] (__warn+0xd0/0xf8)
> [<c034a14c>] (__warn) from [<c034a530>] (warn_slowpath_fmt+0x94/0xb8)
> [<c034a530>] (warn_slowpath_fmt) from [<c03bca0c>] (add_dma_entry+0x16c/0x17c)
> [<c03bca0c>] (add_dma_entry) from [<c03bdf54>] (debug_dma_map_sg+0xe4/0x3d4)
> [<c03bdf54>] (debug_dma_map_sg) from [<c0d09244>] (sdmmc_idma_prep_data+0x94/0xf8)
> [<c0d09244>] (sdmmc_idma_prep_data) from [<c0d05a2c>] (mmci_prep_data+0x2c/0xb0)
> [<c0d05a2c>] (mmci_prep_data) from [<c0d073ec>] (mmci_start_data+0x134/0x2f0)
> [<c0d073ec>] (mmci_start_data) from [<c0d078d0>] (mmci_request+0xe8/0x154)
> [<c0d078d0>] (mmci_request) from [<c0cecb44>] (mmc_start_request+0x94/0xbc)
>
> DMA api debug brings to light leaking dma-mappings, dma_map_sg and
> dma_unmap_sg are not correctly balanced.
>
> If a request is prepared, the dma_map/unmap are done in asynchronous
> call pre_req (prep_data) and post_req (unprep_data). In this case
> the dma-mapping is right balanced.
>
> But if the request was not prepared, the data->host_cookie is
> define to zero and the dma_map/unmap must be done in the request.
> The dma_map is called by mmci_dma_start (prep_data), but there is
> no dma_unmap in this case.
>
> This patch adds dma_unmap_sg when the dma is finalized and
> the data cookie is zero (request not prepared).
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next by adding a fixes tag and a stable tag, thanks!

Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 14f99d8aa3f0..2965b1c062e1 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -188,6 +188,9 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
>  static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
>  {
>         writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
> +
> +       if (!data->host_cookie)
> +               sdmmc_idma_unprep_data(host, data, 0);
>  }
>
>  static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
> --
> 2.17.1
>
