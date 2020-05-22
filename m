Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABD32073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgEVWwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:52:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36681 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVWwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:52:08 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so13209429iol.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uexahIfrZLo1jpnIRsbB+Nwjv1OAdXGD5qQT3+o+NlA=;
        b=JiZgeZnRXwnJKdphzmTGw3f2hbl70ilRh3mSMGtFItWtXewZc0KIJfenhAIHQ1tImo
         EDlmpKd0JOpC39ZA7Iq1q8c/KcmIJVSs/xlwH3nhVEe/wYTpfA5kdk6yKV1/BmBLOkm7
         mzIH1jyg2P7iaKprvtubCybXFCPTt3fpkcMAwsw2R7qR9RnsudlvxpEBfwupHTEWSBl1
         izyldGWo8MPmqFpgOoI4HINN4eZVGUTcNwfUkbzFSdOFqt3nfcg0ZBhsV1T8n2IIcn1d
         6zh9D5yzhB2GrdCKyFYesi/L4CX0LuMZiIpLyNnImEb840lsPpET0QHrEb6psYrtObWy
         cBoA==
X-Gm-Message-State: AOAM533PNlIKrBmjhef0JzDBvLLBI6qsGpu4fn5dw5D7efJwrIvAKEVM
        zIolKAo6csdYZl0SwTJf80OLRhvXZ30=
X-Google-Smtp-Source: ABdhPJz3mNLbeaPEjcaL/bT7ZdZiT930CNrg8YpncGTaKfrHvz8iTqvMI1NyVN/bCeYKpwvTH2SGsA==
X-Received: by 2002:a5e:8413:: with SMTP id h19mr5188110ioj.140.1590187927312;
        Fri, 22 May 2020 15:52:07 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id t189sm1064640iod.16.2020.05.22.15.52.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:52:07 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id f4so13147441iov.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:52:07 -0700 (PDT)
X-Received: by 2002:a05:6602:1616:: with SMTP id x22mr5149773iow.70.1590187926885;
 Fri, 22 May 2020 15:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200424115112.22437-1-ioana.ciornei@nxp.com>
In-Reply-To: <20200424115112.22437-1-ioana.ciornei@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 17:51:43 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ28r188FFfrJXBUTiGnFh43Y8Z-vi_dJKg3WLh0cr7rA@mail.gmail.com>
Message-ID: <CADRPPNQ28r188FFfrJXBUTiGnFh43Y8Z-vi_dJKg3WLh0cr7rA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: Prefer the CPU affine DPIO
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 6:52 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> From: Roy Pledge <roy.pledge@nxp.com>
>
> Use the cpu affine DPIO unless there isn't one which can happen
> if less DPIOs than cores are assign to the kernel.
>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Applied for next.  Thanks.

Regards,
Leo

> ---
>  drivers/soc/fsl/dpio/dpio-service.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index cd4f6410e8c2..f1080c7a3fe1 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -58,7 +58,7 @@ static inline struct dpaa2_io *service_select_by_cpu(struct dpaa2_io *d,
>          * If cpu == -1, choose the current cpu, with no guarantees about
>          * potentially being migrated away.
>          */
> -       if (unlikely(cpu < 0))
> +       if (cpu < 0)
>                 cpu = smp_processor_id();
>
>         /* If a specific cpu was requested, pick it up immediately */
> @@ -70,6 +70,10 @@ static inline struct dpaa2_io *service_select(struct dpaa2_io *d)
>         if (d)
>                 return d;
>
> +       d = service_select_by_cpu(d, -1);
> +       if (d)
> +               return d;
> +
>         spin_lock(&dpio_list_lock);
>         d = list_entry(dpio_list.next, struct dpaa2_io, node);
>         list_del(&d->node);
> --
> 2.17.1
>
