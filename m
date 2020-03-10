Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A3C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE42121927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCJUaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:30:19 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37684 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJUaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:30:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id w13so4848452oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 13:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tF7x8Aibti92fovkYnnZZKnXJErpPthfEAyaWN2U91o=;
        b=Psa9WKpp66ETP8MqfX4UidDoqaygrr2Vrkc1OfqApI+egYfQrNgMSWQwcy/q7h3FIh
         /OkvLpGpp7hde/V1JpoHzp2Xn47XXBDIa99UkCFX9YooQlUEq7Yvego/bShaKDuBRxDn
         eVpEVFlmEXjccmUbTinOQfI0JD8y+xgQ8OgA6lfCL1RYADX4xHk1WKBCpVLE8G97jvic
         ZjcNqpOiJwwVDHCmZ5nejvCmH95C/VHJ7j1LPxIOCaEku2e3++qK+497iXcGrV6C1DmO
         Poxl6pZG8+Ey1HDj5rDQsHbH2Nttm8qv4lm/cbSRar2ZE4HEKDLIsvZ8m1oVRoWOm4Tm
         8e8g==
X-Gm-Message-State: ANhLgQ3eJOyQ89mjTC4TpP8K0ZK/KKntVD/hlKJOUyklSuj8GWjFXp+G
        QZZ1ExRu1q1WFUHDIpBsbKONnn24
X-Google-Smtp-Source: ADFU+vsPdhCOSnJOSud1NtyHNBXdVF+e5Z9MUXSG9vigWwzHoZFo2/t6gON7gEuFYwPuvYt1rZKSfg==
X-Received: by 2002:a05:6808:a9c:: with SMTP id q28mr2627245oij.34.1583872214420;
        Tue, 10 Mar 2020 13:30:14 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id b26sm14120090oti.3.2020.03.10.13.30.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 13:30:14 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id i1so15293680oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 13:30:13 -0700 (PDT)
X-Received: by 2002:aca:c488:: with SMTP id u130mr2551679oif.154.1583872211277;
 Tue, 10 Mar 2020 13:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200310120719.2480-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20200310120719.2480-1-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 10 Mar 2020 15:30:00 -0500
X-Gmail-Original-Message-ID: <CADRPPNT4diVa3gYv=t174=vmZZ3qRX2QmtXto9hLEnjQvv5SwQ@mail.gmail.com>
Message-ID: <CADRPPNT4diVa3gYv=t174=vmZZ3qRX2QmtXto9hLEnjQvv5SwQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: register dpio irq handlers after dpio create
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Grigore Popescu <grigore.popescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 7:09 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
> From: Grigore Popescu <grigore.popescu@nxp.com>
>
> The dpio irqs must be registered when you can actually
> receive interrupts, ie when the dpios are created.
> Kernel goes through NULL pointer dereference errors
> followed by kernel panic [1] because the dpio irqs are
> enabled before the dpio is created.
>
> [1]
> Unable to handle kernel NULL pointer dereference at virtual address 0040
> fsl_mc_dpio dpio.14: probed
> fsl_mc_dpio dpio.13: Adding to iommu group 11
>   ISV = 0, ISS = 0x00000004
> Unable to handle kernel NULL pointer dereference at virtual address 0040
> Mem abort info:
>   ESR = 0x96000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> [0000000000000040] user address but active_mm is swapper
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 2 PID: 151 Comm: kworker/2:1 Not tainted 5.6.0-rc4-next-20200304 #1
> Hardware name: NXP Layerscape LX2160ARDB (DT)
> Workqueue: events deferred_probe_work_func
> pstate: 00000085 (nzcv daIf -PAN -UAO)
> pc : dpaa2_io_irq+0x18/0xe0
> lr : dpio_irq_handler+0x1c/0x28
> sp : ffff800010013e20
> x29: ffff800010013e20 x28: ffff0026d9b4c140
> x27: ffffa1d38a142018 x26: ffff0026d2953400
> x25: ffffa1d38a142018 x24: ffffa1d38a7ba1d8
> x23: ffff800010013f24 x22: 0000000000000000
> x21: 0000000000000072 x20: ffff0026d2953400
> x19: ffff0026d2a68b80 x18: 0000000000000001
> x17: 000000002fb37f3d x16: 0000000035eafadd
> x15: ffff0026d9b4c5b8 x14: ffffffffffffffff
> x13: ff00000000000000 x12: 0000000000000038
> x11: 0101010101010101 x10: 0000000000000040
> x9 : ffffa1d388db11e4 x8 : ffffa1d38a7e40f0
> x7 : ffff0026da414f38 x6 : 0000000000000000
> x5 : ffff0026da414d80 x4 : ffff5e5353d0c000
> x3 : ffff800010013f60 x2 : ffffa1d388db11c8
> x1 : ffff0026d2a67c00 x0 : 0000000000000000
> Call trace:
>  dpaa2_io_irq+0x18/0xe0
>  dpio_irq_handler+0x1c/0x28
>  __handle_irq_event_percpu+0x78/0x2c0
>  handle_irq_event_percpu+0x38/0x90
>  handle_irq_event+0x4c/0xd0
>  handle_fasteoi_irq+0xbc/0x168
>  generic_handle_irq+0x2c/0x40
>  __handle_domain_irq+0x68/0xc0
>  gic_handle_irq+0x64/0x150
>  el1_irq+0xb8/0x180
>  _raw_spin_unlock_irqrestore+0x14/0x48
>  irq_set_affinity_hint+0x6c/0xa0
>  dpaa2_dpio_probe+0x2a4/0x518
>  fsl_mc_driver_probe+0x28/0x70
>  really_probe+0xdc/0x320
>  driver_probe_device+0x5c/0xf0
>  __device_attach_driver+0x88/0xc0
>  bus_for_each_drv+0x7c/0xc8
>  __device_attach+0xe4/0x140
>  device_initial_probe+0x18/0x20
>  bus_probe_device+0x98/0xa0
>  device_add+0x41c/0x758
>  fsl_mc_device_add+0x184/0x530
>  dprc_scan_objects+0x280/0x370
>  dprc_probe+0x124/0x3b0
>  fsl_mc_driver_probe+0x28/0x70
>  really_probe+0xdc/0x320
>  driver_probe_device+0x5c/0xf0
>  __device_attach_driver+0x88/0xc0
>  bus_for_each_drv+0x7c/0xc8
>  __device_attach+0xe4/0x140
>  device_initial_probe+0x18/0x20
>  bus_probe_device+0x98/0xa0
>  deferred_probe_work_func+0x74/0xa8
>  process_one_work+0x1c8/0x470
>  worker_thread+0x1f8/0x428
>  kthread+0x124/0x128
>  ret_from_fork+0x10/0x18
> Code: a9bc7bfd 910003fd a9025bf5 a90363f7 (f9402015)
> ---[ end trace 38298e1a29e7a570 ]---
> Kernel panic - not syncing: Fatal exception in interrupt
> SMP: stopping secondary CPUs
> Mem abort info:
>   ESR = 0x96000004
>   CM = 0, WnR = 0
>   EC = 0x25: DABT (current EL), IL = 32 bits
> [0000000000000040] user address but active_mm is swapper
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> [0000000000000040] user address but active_mm is swapper
> SMP: failed to stop secondary CPUs 0-2
> Kernel Offset: 0x21d378600000 from 0xffff800010000000
> PHYS_OFFSET: 0xffffe92180000000
> CPU features: 0x10002,21806008
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Grigore Popescu <grigore.popescu@nxp.com>

Applied for fix.  Thanks.  Does this fix apply to stable kernels?

> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index 70014ecce2a7..7b642c330977 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -233,10 +233,6 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>                 goto err_allocate_irqs;
>         }
>
> -       err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
> -       if (err)
> -               goto err_register_dpio_irq;
> -
>         priv->io = dpaa2_io_create(&desc, dev);
>         if (!priv->io) {
>                 dev_err(dev, "dpaa2_io_create failed\n");
> @@ -244,6 +240,10 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>                 goto err_dpaa2_io_create;
>         }
>
> +       err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
> +       if (err)
> +               goto err_register_dpio_irq;
> +
>         dev_info(dev, "probed\n");
>         dev_dbg(dev, "   receives_notifications = %d\n",
>                 desc.receives_notifications);
> --
> 2.17.1
>
