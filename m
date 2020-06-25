Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF3EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F082081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZUaAsN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405107AbgFYNsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404888AbgFYNsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:48:19 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B79C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:48:18 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n137so1422952vkf.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcjptYLlu8YiX/3FPEXIl1WOzbmhaUe5lplH8CkoFv4=;
        b=YZUaAsN3Cfoe4wVRvvlXqZvom5U/mXmUVhgRgW0RrvQ5RwkdVPOaUeSi4rqPeCKG0G
         k9kKuXiXjkKCeUymnoUjqf3I3TRhDXpxecMXGOOg6DTr5vJXkLQTFjY8iGvl+JMBW6lV
         ZA5unte6LgSFrrEua1UonyayueBsmqg7utHt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcjptYLlu8YiX/3FPEXIl1WOzbmhaUe5lplH8CkoFv4=;
        b=hV3ufFqtLUbcra06AKF0IolCslwUIh/T6hlc6TTrOR2IInqRQGomdzg6dAkKGLhMW7
         T6jnibHhA7k4aEvjvDQXTug8i+jugbY2wxsbyPZeupUIpZ3uMJu/idB1/iNB+nI8G9IZ
         ep+LsUuIMdrSOnTFuEH7krfY+eiVE79tuspzL2rRjDJ0UupLODIjJ57SGAkoIaL4Acbh
         0WHM9xNzhM2VSsuEoEoIDZM59joBW7SZdhpdsrk5P3/hq6j3yoZfQ9HQ1sPxkLVvtfBi
         qO+W87I/sinstCGOH0DHsE1vf14p6mgD5YimdarN93StNGr0dRjq5kQkAhsz1T5RE57j
         Xc7Q==
X-Gm-Message-State: AOAM531kEYFGh/BZf0g4Z3uhKTrt7K8W6t3AdGCLwUzgo6QS1bHk2ivR
        W/FJ4RT85xip3ryCTEC/ISDeT2HByRs=
X-Google-Smtp-Source: ABdhPJzHtDagdn29lXFA9d+DxgCHpZ2E6Fxm+0smYlNbGHUsyBZ03mw0wmKOKJs8VLlkHwSfSgd7oQ==
X-Received: by 2002:a1f:a297:: with SMTP id l145mr26513452vke.10.1593092896775;
        Thu, 25 Jun 2020 06:48:16 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id q7sm344190vsp.14.2020.06.25.06.48.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:48:15 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id o2so3588699vsr.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:48:15 -0700 (PDT)
X-Received: by 2002:a67:62c4:: with SMTP id w187mr25684156vsb.109.1593092894920;
 Thu, 25 Jun 2020 06:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200625103123.7240-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200625103123.7240-1-saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Jun 2020 06:48:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WONg5C0Twm7b=aED21VLb6GLk4K6DMmYcSXVLAtdkUZg@mail.gmail.com>
Message-ID: <CAD=FV=WONg5C0Twm7b=aED21VLb6GLk4K6DMmYcSXVLAtdkUZg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Add KRYO{3,4}XX silver CPU cores to SSB safelist
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 25, 2020 at 3:31 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> QCOM KRYO{3,4}XX silver/LITTLE CPU cores are based on
> Cortex-A55 and are SSB safe, hence add them to SSB
> safelist -> arm64_ssb_cpus[].
>
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/kernel/cpu_errata.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index ad06d6802d2e..cf50c53e9357 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -460,6 +460,8 @@ static const struct midr_range arm64_ssb_cpus[] = {
>         MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
>         MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
>         MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
> +       MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
> +       MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),

Reviewed-by: Douglas Anderson <dianders@chromium.org>
