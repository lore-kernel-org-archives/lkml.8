Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29060C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3CF20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY8eZFv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1MhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:37:17 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38306 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1MhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:37:17 -0400
Received: by mail-il1-f194.google.com with SMTP id n13so4012063ilm.5;
        Sat, 28 Mar 2020 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/8yHh9a7PftoLLUSkGnNnfodolyFPpd9WhHKOKDPIA=;
        b=CY8eZFv7KVbtrEKXF0M8rb3igcjdETQPtrZ4ZnFKlcfLnduiyC36E1ZgohJf95wvmX
         p52eU0pxQVlFCQeSq3G6rsdkLILNCl34UO8f7yJRZglOun2Bdf4Zga+evMfYR2dU8s5P
         Zd6TvAFNOu/tiXas5A8aYH5NxdrMAntPGczoEXjpX94OngWN4dyR3nLiZqyyIshMlnx/
         gb8PZ6+IxUxNNng0uBuSXmhOK5M5o5f3Oel0hcJMguTUgQejUHwYwdUM3zPkS/sHA7rU
         3/R2SOB5aQ9incRSZUHje8qqACLlXMMvnxiMhWsJE0Yq/rx8/07OkUPXFjONFKKS+DPU
         pu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/8yHh9a7PftoLLUSkGnNnfodolyFPpd9WhHKOKDPIA=;
        b=AIQAUPHaatJoGbWOBmK4NuIbRQfPk28099ooz/kW774gBbF104NkiYJ4Z0dpg3y1ML
         v1+Ikp48cNRho3Trn+M8ipjfLyOWBchwb/MhtVnb26Gw4SuhnGjynGi/+wdvr6uEKXI1
         t/nW4+ZBxWudV6RxCq/GN0yp5LXpnWmTOAcXVZG1h6WVCS/PVPNreEL5Q6QYfdaiPSbx
         R7bMlWclpv+U1Bl0kKmM59hE+Cp5MlCeQD9klWouDPN90JjTHF/B+/fx2RlH5mjrL25v
         FbTgGdOpVgl3NiWMaIds63Ga9o874vmoz9pe/v3r8kqmTUuLbFQ920O1HcRA+cjUQG8P
         j/KA==
X-Gm-Message-State: ANhLgQ2JNLda8It9uOfIW2AIxrk/D2qcxm+4xEhvveGKUQFbP0mfc5BO
        lenTMy46LQq3hn7bBtWzjYZDfu4/uDtsSFKLTD8=
X-Google-Smtp-Source: ADFU+vu+FX/31Esa4oReLjE2l+HEqXJ0WmQE/QmsqlRjAHIQis3eJkgh0I/03U+PImxYEHaV+/7e3sBg1ZxBNUmLpX4=
X-Received: by 2002:a92:5dc7:: with SMTP id e68mr3547084ilg.205.1585399035789;
 Sat, 28 Mar 2020 05:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJSKH-gXA5ncFS3h6_2R28rn70O3HfT=ActS1XVgCFSeg@mail.gmail.com>
 <DB3PR0402MB39160D3F0D03B968B7CBE25AF5CD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39160D3F0D03B968B7CBE25AF5CD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 28 Mar 2020 07:37:04 -0500
Message-ID: <CAHCN7xJ2m3LRB3oGBb5QKbacYyTBQK1CdzGcTh3w=hj18H=4Pw@mail.gmail.com>
Subject: Re: i.MX8MN Errors on 5.6-RC7
To:     Anson Huang <anson.huang@nxp.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 7:07 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Adam
>
> > Subject: i.MX8MN Errors on 5.6-RC7
> >
> > I am getting a few errors on the i.MX8MN:
> >
> > [    0.000368] Failed to get clock for /timer@306a0000
> > [    0.000380] Failed to initialize '/timer@306a0000': -22
> > [    7.203447] caam 30900000.caam: Failed to get clk 'ipg': -2
> > [    7.334741] caam 30900000.caam: Failed to request all necessary clocks
> > [    7.438651] caam: probe of 30900000.caam failed with error -2
> > [    7.854193] imx-cpufreq-dt: probe of imx-cpufreq-dt failed with error -2
> >
> > I was curious to know if anyone else is seeing similar errors.  I already
> > submitted a proposed fix for a DMA timeout (not shown here) which
> > matched work already done on i.MX8MQ and i.MX8MM.
> >
> > I am not seeing huge differences between 8MM and 8MN in the nodes which
> > address the timer, caam or imx-cpufreq-dt.
> >
> > If anyone has any suggestions, I'd love to try them.
>

Fabio,

I tried your ATF suggestion, and it fixed some issues and introduced others:

[    0.767679] ------------[ cut here ]------------
[    0.767687] coherent pool not initialised!
[    0.767714] WARNING: CPU: 3 PID: 1 at kernel/dma/remap.c:190
dma_alloc_from_pool+0x94/0xa0
[    0.767718] Modules linked in:
[    0.767728] CPU: 3 PID: 1 Comm: swapper/0 Not tainted
5.6.0-rc7-00471-g97c33f1ada5c-dirty #5
[    0.767732] Hardware name: Beacon EmbeddedWorks i.MX8M Nano
Development Kit (DT)
[    0.767738] pstate: 60000005 (nZCv daif -PAN -UAO)
[    0.767744] pc : dma_alloc_from_pool+0x94/0xa0
[    0.767749] lr : dma_alloc_from_pool+0x94/0xa0
[    0.767753] sp : ffff80001003ba10
[    0.767756] x29: ffff80001003ba10 x28: ffff00007c868080
[    0.767762] x27: 0000000fffffffe0 x26: ffff00007fbdd080
[    0.767768] x25: 0000000000000000 x24: ffff800010161b3c
[    0.767774] x23: 0000000000001000 x22: ffff00007c86bd38
[    0.767780] x21: ffff8000112ba000 x20: ffff00007f6ed410
[    0.767785] x19: 0000000000000000 x18: 0000000000000010
[    0.767791] x17: 00000000000045e0 x16: 00000000000045d0
[    0.767796] x15: ffff00007f470470 x14: ffffffffffffffff
[    0.767802] x13: ffff80009003b777 x12: ffff80001003b77f
[    0.767807] x11: ffff8000118e1000 x10: ffff800011abc658
[    0.767813] x9 : 0000000000000000 x8 : 6573696c61697469
[    0.767818] x7 : 6e6920746f6e206c x6 : 00000000000000a9
[    0.767824] x5 : 0000000000000000 x4 : 0000000000000000
[    0.767829] x3 : 00000000ffffffff x2 : ffff8000118e1b80
[    0.767835] x1 : 3a4437124c5a6b00 x0 : 0000000000000000
[    0.767840] Call trace:
[    0.767847]  dma_alloc_from_pool+0x94/0xa0
[    0.767853]  dma_direct_alloc_pages+0x1a4/0x1e0
[    0.767858]  dma_direct_alloc+0xc/0x20
[    0.767863]  dma_alloc_attrs+0x7c/0xf0
[    0.767870]  sdma_probe+0x3d4/0x7f0
[    0.767877]  platform_drv_probe+0x50/0xa0
[    0.767885]  really_probe+0xd4/0x320
[    0.767891]  driver_probe_device+0x54/0xf0
[    0.767897]  device_driver_attach+0x6c/0x80
[    0.767903]  __driver_attach+0x54/0xd0
[    0.767908]  bus_for_each_dev+0x6c/0xc0
[    0.767914]  driver_attach+0x20/0x30
[    0.767919]  bus_add_driver+0x140/0x1f0
[    0.767925]  driver_register+0x60/0x110
[    0.767930]  __platform_driver_register+0x44/0x50
[    0.767938]  sdma_driver_init+0x18/0x20
[    0.767944]  do_one_initcall+0x50/0x190
[    0.767950]  kernel_init_freeable+0x1cc/0x23c
[    0.767958]  kernel_init+0x10/0x100
[    0.767963]  ret_from_fork+0x10/0x18
[    0.767972] ---[ end trace 796b8d949d96f5f6 ]---


Anson,

> Which board did you try? I just run it on i.MX8MN-EVK board, no such failure:
I have a board from Beacon EmbeddedWorks based on the i.MX8MN which is
nearly identical to the i.MX8MM which doesn't exhibit any of these
errors.

I tried Fabio's suggestion of switching the version of ATF which did
fix the Bluetooth communication errors I was getting, but I didn't
show them before.

Unfortunately, I don't have the i.MX8MN-EVK right now, I'm working on
trying to get one.

Can I ask which version of U-Boot and ATF you're using?  I am
wondering if I need to update something else.

adam
>
> root@imx8mnevk:~# uname -a
> Linux imx8mnevk 5.6.0-rc7 #621 SMP PREEMPT Sat Mar 28 19:56:30 CST 2020 aarch64 aarch64 aarch64 GNU/Linux
> root@imx8mnevk:~# dmesg | grep fail
> [    0.719353] imx-sdma 302b0000.dma-controller: Direct firmware load for imx/sdma/sdma-imx7d.bin failed with error -2
> [    0.941304] calling  net_failover_init+0x0/0x8 @ 1
> [    0.941310] initcall net_failover_init+0x0/0x8 returned 0 after 0 usecs
> [    1.135885] calling  failover_init+0x0/0x24 @ 1
> [    1.135897] initcall failover_init+0x0/0x24 returned 0 after 6 usecs
> root@imx8mnevk:~#
>
> Thanks,
> Anson
