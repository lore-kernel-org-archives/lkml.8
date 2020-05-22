Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F0DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BB3206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgEVXLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:11:48 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:46683 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731161AbgEVXLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:11:47 -0400
Received: by mail-il1-f175.google.com with SMTP id w18so12358106ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 16:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtCZ0bOQ8dVl/wcwOWZuf6hM21Yr4PMWRA6hQoilBR4=;
        b=ssKCViwGI10xMFimejxaLm2JwV6AocTCVbzRTJ0QFSBgxSJF9udN23Ax5MH4f5XTS5
         5UH8LdzYojpfdrM0emN0rD8RrW+WNnx4OFFVXhU4SNJQo3tMYU/+i3V4wMA9byQlsD06
         UPK21Orx/syhLmbjk1zMV76gkkhqXNe3ZoTcInz4fioca25QnXOODo0IJsv5B3aQrV1B
         corWD4JE0n4SrkFDaESYxkia0hNnqWoopD/31qNrezQ7GnpuMGE1g0FyfAEvclSErWAO
         9x54mRoVkeuPkzkbUEyFddiWpVIGr28MVDOjCaxJOBHvuKL2uNknSXIFEPxgx/Qjx0qn
         rXqg==
X-Gm-Message-State: AOAM531vqLbj4yA1z0KyLQHf/3J1g8eoBRgM2mJbGAWWSe4mnAB7hkuA
        1n1ELsLTw9ZfAbCiWxAp+slxaqao6bs=
X-Google-Smtp-Source: ABdhPJxmPpgG43M6EuaNhJAGmDeek45laGM9UoGXlEwRvSw1vk/2cqdxuTIQab8X0DKV8GeMTtSXfQ==
X-Received: by 2002:a92:b001:: with SMTP id x1mr14298920ilh.18.1590189105903;
        Fri, 22 May 2020 16:11:45 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id v13sm5377183ili.15.2020.05.22.16.11.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 16:11:45 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id r2so2925316ioo.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 16:11:45 -0700 (PDT)
X-Received: by 2002:a6b:1505:: with SMTP id 5mr5062071iov.198.1590189105156;
 Fri, 22 May 2020 16:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200508140947.28712-1-yuehaibing@huawei.com>
In-Reply-To: <20200508140947.28712-1-yuehaibing@huawei.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 18:11:21 -0500
X-Gmail-Original-Message-ID: <CADRPPNRfS1LTeCPtyfMzDUBvf871v=Vs2rpYGCevvX08OuN-Mw@mail.gmail.com>
Message-ID: <CADRPPNRfS1LTeCPtyfMzDUBvf871v=Vs2rpYGCevvX08OuN-Mw@mail.gmail.com>
Subject: Re: [PATCH -next] soc: fsl: dpio: Remove unused inline function qbman_write_eqcr_am_rt_register
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Roy Pledge <Roy.Pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 9:13 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> There's no callers in-tree anymore since commit
> 3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array mode with ring mode enqueue")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to next.  Thanks.

Regards,
Leo
> ---
>  drivers/soc/fsl/dpio/qbman-portal.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
> index 804b8ba9bf5c..e2e9fbb58a72 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.c
> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> @@ -572,18 +572,6 @@ void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32 qdid,
>  #define EQAR_VB(eqar)      ((eqar) & 0x80)
>  #define EQAR_SUCCESS(eqar) ((eqar) & 0x100)
>
> -static inline void qbman_write_eqcr_am_rt_register(struct qbman_swp *p,
> -                                                  u8 idx)
> -{
> -       if (idx < 16)
> -               qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT + idx * 4,
> -                                    QMAN_RT_MODE);
> -       else
> -               qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT2 +
> -                                    (idx - 16) * 4,
> -                                    QMAN_RT_MODE);
> -}
> -
>  #define QB_RT_BIT ((u32)0x100)
>  /**
>   * qbman_swp_enqueue_direct() - Issue an enqueue command
> --
> 2.17.1
>
>
