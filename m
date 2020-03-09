Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD2C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDB124649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCIWeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:34:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38362 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:34:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id i14so11312020otp.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLnP9gGfDbqjzLs0w/R1F12ZQEp2IKQhsRrBYCzbdX4=;
        b=dt0UCkTrmuGNjUMVDamP5m7H98LNatafdhLnvnBe9ZHcBBP8Bi59/HG+IFoDVu6T9a
         CqiE+AMmka5JYYgTMOOS1UAv93V0LTq368frruy0mNCPrcwNd1p6ME6M6IYRkYUX3u/t
         7WcdK4X5GDM1+1UQHTPXLXQkfSovibGV7f2IoaWGmxUz1k6XwZyBkUujIVvFxgcsg/6X
         qcRpa+v/IZBaUcrlvz/O3ntnNPsU2cRpfm1mO5A8HkND9FDfSuFnpEfnSZ7QnQ+7EYrn
         SMAFw7HiphCQ7BGcP6/S3NYpsWax4IkAnQBEj+tzYMOUeoh1YrcBzjURa2t1KmQzED+Z
         m/rA==
X-Gm-Message-State: ANhLgQ20v5GqNnMTOSRMVd85zGJ5ewZtiFuRPHwfMQY8LiI4VA6jbPNG
        pQCZrdESusjB6xbnZ3yglO9SumDV
X-Google-Smtp-Source: ADFU+vuukqKD5c8WG/QW975iAe/FzFyzJnWIErWpmtXJOaHsMgc4DB1D0O1V0tAs0nn6+iMYwuAB7w==
X-Received: by 2002:a9d:76d6:: with SMTP id p22mr15130125otl.37.1583793240855;
        Mon, 09 Mar 2020 15:34:00 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id s12sm3562887oic.31.2020.03.09.15.34.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 15:34:00 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id a9so5095865otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:34:00 -0700 (PDT)
X-Received: by 2002:a05:6830:104a:: with SMTP id b10mr14900892otp.63.1583793240222;
 Mon, 09 Mar 2020 15:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200221083637.13392-1-yuehaibing@huawei.com>
In-Reply-To: <20200221083637.13392-1-yuehaibing@huawei.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 9 Mar 2020 17:33:49 -0500
X-Gmail-Original-Message-ID: <CADRPPNTb2_-0QpD=iuP-W-Tk6n-a3rHKp-M38xw5kf+BXXrbPg@mail.gmail.com>
Message-ID: <CADRPPNTb2_-0QpD=iuP-W-Tk6n-a3rHKp-M38xw5kf+BXXrbPg@mail.gmail.com>
Subject: Re: [PATCH -next] soc: fsl: dpio: remove set but not used variable 'addr_cena'
To:     YueHaibing <yuehaibing@huawei.com>,
        Youri Querry <youri.querry_1@nxp.com>
Cc:     Roy Pledge <Roy.Pledge@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:38 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> commit 3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array
> mode with ring mode enqueue") introduced this, but not
> used, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/soc/fsl/dpio/qbman-portal.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
> index 740ee0d..350de56 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.c
> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> @@ -658,7 +658,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
>         const uint32_t *cl = (uint32_t *)d;
>         uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
>         int i, num_enqueued = 0;
> -       uint64_t addr_cena;
>
>         spin_lock(&s->access_spinlock);
>         half_mask = (s->eqcr.pi_ci_mask>>1);
> @@ -711,7 +710,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
>
>         /* Flush all the cacheline without load/store in between */
>         eqcr_pi = s->eqcr.pi;
> -       addr_cena = (size_t)s->addr_cena;
>         for (i = 0; i < num_enqueued; i++)
>                 eqcr_pi++;
>         s->eqcr.pi = eqcr_pi & full_mask;
> @@ -822,7 +820,6 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
>         const uint32_t *cl;
>         uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
>         int i, num_enqueued = 0;
> -       uint64_t addr_cena;
>
>         half_mask = (s->eqcr.pi_ci_mask>>1);
>         full_mask = s->eqcr.pi_ci_mask;
> @@ -866,7 +863,6 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
>
>         /* Flush all the cacheline without load/store in between */
>         eqcr_pi = s->eqcr.pi;
> -       addr_cena = (uint64_t)s->addr_cena;

Hi Youri,

Looks like this problem exposed another issue that you removed the
cacheline related code in the upstream version.  Then the comment /*
Flush all the cacheline without load/store in between */ is no longer
true now, and probably the whole block can be replaced with a single
line to increase s->eqcr.pi?   The same for the block above.  Can you
provide a better fix for this issue?

Regards,
Leo

>         for (i = 0; i < num_enqueued; i++)
>                 eqcr_pi++;
>         s->eqcr.pi = eqcr_pi & full_mask;
> --
> 2.7.4
>
>
