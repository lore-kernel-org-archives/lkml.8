Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0208DC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9EE20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sqy4Qf7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBDAVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:21:22 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41394 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgBDAVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:21:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so15468824otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPuXmrJI40A2Un1MmFXL7OHrwiIKEbtwiS4nTQZEtlw=;
        b=Sqy4Qf7TbtVRb9AKX7R0QHMGO6MbjHFjRhrNLCVULzUn/tmym5SloAoPUq1SLwktqL
         YfDK2SvCgqu1fkHcx0lbvUks2URnH9G99ch0qldrHccgrrXWifX1cpgNKWL3di2+l5qG
         Iwa5jrVHUpE4EDrYxjMPzWGaWAWHjMLWl631queL7ztP48d4tpQc/xVcRzYnMe81w7uC
         4hxAPoC0OgBYxmSUgZWTss5WoM88w5zWJpgZGqSN5GUyK+Gqf6JeoJvJ0WVhmy55jGIu
         VOwXEJfrLuQ1xyydF5FCEOXUqw/PKDYZA6sbjwFeJXBDWoNWiF1G1cD7YnRP7AONLW+P
         e5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPuXmrJI40A2Un1MmFXL7OHrwiIKEbtwiS4nTQZEtlw=;
        b=I1F+/hsPoOhiK8lod6NjoiMxJED+u4PLBi7d25idyyAhzAM12JyQeJFtBw1Vf2FQ5P
         B42f1B+6pMGp8HrvPOclThKrh+sfqFAG8lwFzZcSLSVPlc6DBKyLUEgBpg+GZrQt1st/
         6tie0ZSHAFdRUp8iLrof9vbFCgVCoF62+h3ricYp7dOMGNONIPjRfwN5HgWn9MxfKyXL
         wKytJgLz5WlLmiGvWUnVtSyOJ5XQz/TSxniTfX1bJP9Q8X7nBk4XXxDQkHCmoTGraHeY
         33+DaIxsdDNEEWip6Ui8FMdxQAvewwAii2oW/FbOuSKkm3amqpPljV4swPmtHNlqOYb+
         PSaA==
X-Gm-Message-State: APjAAAWogaSDY2mpQ0toD4stSI6V4Z3RsLv41JlgyB9WVMw9My9s1+CW
        xGY3r5AYSPw940bvcPyqFenYpHe15kyqsGi+zFjJhw==
X-Google-Smtp-Source: APXvYqz/YSe/X4e5btHvwVXt9j0h9vzKao0F/dYt5ZLOc7r211EAvVVKoCb8baK3UiKvJDxzD5l048nUmNuGreHgVVI=
X-Received: by 2002:a05:6830:1094:: with SMTP id y20mr19728104oto.12.1580775680897;
 Mon, 03 Feb 2020 16:21:20 -0800 (PST)
MIME-Version: 1.0
References: <1579763945-10478-1-git-send-email-smasetty@codeaurora.org> <1579763945-10478-2-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1579763945-10478-2-git-send-email-smasetty@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 3 Feb 2020 16:21:09 -0800
Message-ID: <CALAqxLU9-4YEF8mTjuPF+LBJH8fFw_OfrdT7JtTqib127RRaEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: msm: a6xx: Add support for A618
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@freedesktop.org, lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:19 PM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> This patch adds support for enabling Graphics Bus Interface(GBIF)
> used in multiple A6xx series chipets. Also makes changes to the
> PDC/RSC sequencing specifically required for A618. This is needed
> for proper interfacing with RPMH.
>
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index dc8ec2c..2ac9a51 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -378,6 +378,18 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>         struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>         int ret;
>
> +       /*
> +        * During a previous slumber, GBIF halt is asserted to ensure
> +        * no further transaction can go through GPU before GPU
> +        * headswitch is turned off.
> +        *
> +        * This halt is deasserted once headswitch goes off but
> +        * incase headswitch doesn't goes off clear GBIF halt
> +        * here to ensure GPU wake-up doesn't fail because of
> +        * halted GPU transactions.
> +        */
> +       gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
> +
>         /* Make sure the GMU keeps the GPU on while we set it up */
>         a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
>

So I already brought this up on #freedreno but figured I'd follow up
on the list.

With linus/master, I'm seeing hard crashes (into usb crash mode) with
the db845c, which I isolated down to this patch, and then to the chunk
above.

Dropping the gpu_write line above gets things booting again for me.

Let me know if there are any follow on patches I can help validate.

thanks
-john
