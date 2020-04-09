Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900F7C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8132075E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDIJJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:09:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIJJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:09:57 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUXlG-1jmlTI2gaG-00QULS for <linux-kernel@vger.kernel.org>; Thu, 09 Apr
 2020 11:09:56 +0200
Received: by mail-qt1-f177.google.com with SMTP id g7so2161495qtj.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:09:56 -0700 (PDT)
X-Gm-Message-State: AGi0Pua3BSSRzC3wsJ8ON4U/Klr2IjX7j8SQT2lb8bVWovQawD6w0OhW
        Qia4y1Cj3tjRFIdrwLy7koFA92KR+g/OJW7n3lA=
X-Google-Smtp-Source: APiQypLuQYJYCKPcCisV3XCZoYysZpIygpIYahJxiMvd/247uxOlTutqw6XoUwrh8HjfKn/RqyjJRpObO3F17rqWLAA=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr3504312qtb.142.1586423395512;
 Thu, 09 Apr 2020 02:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200408155224.2070880-1-arnd@arndb.de> <69e8b684-c314-d356-bf3e-e38676d07853@xilinx.com>
In-Reply-To: <69e8b684-c314-d356-bf3e-e38676d07853@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Apr 2020 11:09:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3j7BLJZGsNFU2XLsnnBiP0x+qkPVxD0-L9Faq7+m2=BQ@mail.gmail.com>
Message-ID: <CAK8P3a3j7BLJZGsNFU2XLsnnBiP0x+qkPVxD0-L9Faq7+m2=BQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: soc: xilinx: fix firmware driver Kconfig dependency
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     arm-soc <arm@kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zeoMr5eTY/BtgveUI0iOb5s5hG1F2ivh8eLs1c4nYWSeVmvwHtB
 AgqqNe7DcTIaqLehhFeNYFKV/v1Gsh8h1vNdx46cALcfc0QRRsUEXZbYkdnCvRP+apwKVek
 Y1Wm3q7ArI35iO+3KjCTKhiCk5wvnGX8wT5tA8Jl/TACH5Z6mEDxklX3HcOBYK3lWQAp0aB
 +a83uLOf2TdFVUc9Lib9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vl/eOXQPH6U=:2Q73tvGrE8l0mNpRems0Ro
 gsGh0dr1FwM292B1i3+jdlSwXSK6AdiKXAy4tSYRUSePulzDEa2BIYgwh6DJWUwEmHbzlcJDV
 5T/p+YW/hht/kyuXa7RhCpMRapsxL3UnLeZaJEmOHUYFVLJPmoLIdUy507gkOz0tem9vLLlNK
 LhRKqr+Uw+kTA9iAtwT9kaNW56v3EGStggIwpPgmgtnVqx6haW2q6D4VGTclzPEXUgsdVPE1b
 BN1AOBstUZ2KyAKFIb9zh6+wpuH7FWmIyBcU+obzmD5bVKILm+JaPZ+uaXn0ItGrUPraJrYz9
 z/Oy9dRYW0lUK1fa1DJFNJ4a/26HhBT9F33h0g4Tpnvs11XBSmdzsbRwtESXm9yPC6fgJ5Q+R
 TYwZtQIg1l5tyTOT3YylLm7jKegdDn/J7jUEXgyIgha8ES9rV85niJNXPT4rP8uPQKOIsF++j
 WBPlCJn+3kem545p8YgabN2av0Cdl48fTBnzpJYuGpyvE2Fob5NpSTA589VC4CKO89Rf2qkML
 kEhy7VuV1NXHfLThMR91fHeaQHuj+mshA5LxaDDi9l6YnpKq478/nw53mSg/+Or/vsP5I7NNn
 V56Lga5Vh0fjDfqYroStwWQVUCaOWRNRBE3s81g+IQD7PDnQ3THAoB/Vz0IhxVJbG7JhEIKT6
 J2dcxa/UP0SmBFaA8Y5f2pciqb8LlVElU4fFaBnk2ZB7YzaECmMV3zazIx79e0Q4P/YrLNBjY
 lVWT/pMJ5BEY9e9xyNI5X+O85tvRmynxX+bxaelGdv+7CZlWEdqkPPL/AYcTGvo2Pps2w3cCO
 le3y3vo5H+3r4mTLKT8TH2y1ZGblWyldcKa1VjEIGDte/9Aemo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 8:37 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 08. 04. 20 17:52, Arnd Bergmann wrote:
> > The firmware driver is optional, but the power driver depends on it,
> > which needs to be reflected in Kconfig to avoid link errors:
> >
> > aarch64-linux-ld: drivers/soc/xilinx/zynqmp_power.o: in function `zynqmp_pm_isr':
> > zynqmp_power.c:(.text+0x284): undefined reference to `zynqmp_pm_invoke_fn'
> >
> > The firmware driver can probably be allowed for compile-testing as
> > well, so it's best to drop the dependency on the ZYNQ platform
> > here and allow building as long as the firmware code is built-in.
> >
> > Fixes: ab272643d723 ("drivers: soc: xilinx: Add ZynqMP PM driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/soc/xilinx/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
> > index 223f1f9d0922..646512d7276f 100644
> > --- a/drivers/soc/xilinx/Kconfig
> > +++ b/drivers/soc/xilinx/Kconfig
> > @@ -19,7 +19,7 @@ config XILINX_VCU
> >
> >  config ZYNQMP_POWER
> >       bool "Enable Xilinx Zynq MPSoC Power Management driver"
> > -     depends on PM && ARCH_ZYNQMP
> > +     depends on PM && ZYNQMP_FIRMWARE
> >       default y
> >       select MAILBOX
> >       select ZYNQMP_IPI_MBOX
> > @@ -35,7 +35,7 @@ config ZYNQMP_POWER
> >  config ZYNQMP_PM_DOMAINS
> >       bool "Enable Zynq MPSoC generic PM domains"
> >       default y
> > -     depends on PM && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
> > +     depends on PM && ZYNQMP_FIRMWARE
> >       select PM_GENERIC_DOMAINS
> >       help
> >         Say yes to enable device power management through PM domains
> >
>
> The same issue is likely with others drivers dependencies too which
> depends on ARCH_ZYNQMP.
>
> It means all drivers which includes "linux/firmware/xlnx-zynqmp.h" and
> call zynqmp_pm_get_eemi_ops() should depend on ZYNQMP_FIRMWARE instead
> of ARCH_ZYNQMP.

The only one I see that has a hard dependency on ARCH_ZYNQMP
without allowing compile-testing at the moment is drivers/edac/synopsys_edac.c
but that doesn't use the firmware interface.

What I see in the header are declarations for exported functions:

int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
                        u32 arg2, u32 arg3, u32 *ret_payload);
#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
#else
static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
{
        return ERR_PTR(-ENODEV);
}
#endif

The second one already allows compile-testing by turning into an
inline stub, but zynqmp_pm_invoke_fn() does not, and this is the
one causing the problem here.

I still think my patch is a good fix for that issue, but if you want to
handle both interfaces the same way, we can also do that, either
removing the stub and using a proper dependency, or using
the same stub trick for both.

      Arnd
