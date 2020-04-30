Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52224C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A59F2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db2wOVRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgD3M5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgD3M5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:57:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7ABC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:57:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i19so1299758ioh.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=32Ie0CFZa4w7jy8u6Af0i0FQe2RQGOdlna//yylL010=;
        b=Db2wOVRM6wq6WjwTe2GyRTgEA3gAzKo9xOJ3EI6bcu3CI3py4vNQqtzb5w+44IJO1B
         vj5k778s77uOhlRcbMkOF2Plp1VYelVbHLysl34rR3coKJpt8T9Lk2J+SWfgSJ9B8nV0
         ejOeSRboLtL/jpnYqifB4zD428L6OGbu6LO07QcpTLpYMAsBS74hv4vOy0e//LzdQgWG
         yBNTJlM8EcXXqPW5b99I3Y49a5mF22lccuKAdgHL//cFO4NcF/HdnST6B2O1w5E4MLNP
         OP20Aoo4coti56uUkTJfooPr5K22CK8ICCq7O7EelOcNGGx+VicpC60037oib3btKXAH
         b2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=32Ie0CFZa4w7jy8u6Af0i0FQe2RQGOdlna//yylL010=;
        b=AuzuW/veZ7623U1EvSAGpiFS2NXe/5ckP5cBbH7utXYTxoII3PuAdmbj5wbNgz3tEF
         cM5MDDHx2rwUQgd8ek5UtdEkjfTyrc1ehWsJEXGIjZjEnB4ilzrjSgOk3Xpg5WAsoz1Z
         7qlL1T5yyBYJBcoYbNnDksKrI/AVx1dioxb3HJfbPepcyEYg0skiDn9f1xAQuNwh07Hq
         aZWuN5Mc7MrCnEwZxa2TyprirYtpsvAdlWLix4GfnTFcp8di6KCaPXnamrGnHoEylSQg
         2WFIEcOszYAIsnmKvjaDCWg1mMT2uHkOV/z2X3/qgIauYZzNKLwHDrUnpZoncf30vM+u
         P+bQ==
X-Gm-Message-State: AGi0Pua98O5NHvauTc65GTd6VVFVTDNFP9dhDh8NOgXwC/wv7eBCZDjU
        qRFaXCL1qf97+SQ3+IEi7gfuN96i4nVNNhJ7HWk=
X-Google-Smtp-Source: APiQypL43U+5ZrdQUp6UhVbjM1hwmbIoO+QNHU6doG77mRuyvvaTwXisnRd7DAEhpCw2I7x7uI0ynBTeF+DJTyYxbf4=
X-Received: by 2002:a02:6983:: with SMTP id e125mr1665634jac.47.1588251469289;
 Thu, 30 Apr 2020 05:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <1587999532-30006-1-git-send-email-abel.vesa@nxp.com>
 <0d301ed303faea4895d30b682133ec5c9d44bd8b.camel@pengutronix.de> <AM6PR04MB504745F6EB1FB17F6DBDD9A387AF0@AM6PR04MB5047.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB504745F6EB1FB17F6DBDD9A387AF0@AM6PR04MB5047.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 30 Apr 2020 07:57:34 -0500
Message-ID: <CAHCN7xJhp7BMxOW4VAUxxDL4-Gjy0QMvX+AKj+-fi-mkAS=J7w@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Add power domain driver support for i.mx8m family
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:37 AM Jacky Bai <ping.bai@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: Monday, April 27, 2020 11:11 PM
> > To: Abel Vesa <abel.vesa@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Shawn
> > Guo <shawnguo@kernel.org>; Sascha Hauer <kernel@pengutronix.de>; Liam
> > Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>
> > Cc: Aisheng Dong <aisheng.dong@nxp.com>; dl-linux-imx
> > <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org; Linux Kernel
> > Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] soc: imx: Add power domain driver support for i.mx=
8m
> > family
> >
> > Am Montag, den 27.04.2020, 17:58 +0300 schrieb Abel Vesa:
> > > From: Jacky Bai <ping.bai@nxp.com>
> > >
> > > The i.MX8M family is a set of NXP product focus on delivering the
> > > latest and greatest video and audio experience combining
> > > state-of-the-art media-specific features with high-performance
> > > processing while optimized for lowest power consumption.
> > >
> > > i.MX8MQ, i.MX8MM, i.MX8MN, even the furture i.MX8MP are all belong to
> > > this family. A GPC module is used to manage all the PU power domain
> > > on/off. But the situation is that the number of power domains & the
> > > power up sequence has significate difference on those SoCs. Even on
> > > the same SoC. The power up sequence still has big difference. It make=
s
> > > us hard to reuse the GPCv2 driver to cover the whole i.MX8M family.
> > > Each time a new SoC is supported in the mainline kernel, we need to
> > > modify the GPCv2 driver to support it. We need to add or modify
> > > hundred lines of code in worst case.
> > > It is a bad practice for the driver maintainability.
> > >
> > > This driver add a more generic power domain driver that the actual
> > > power on/off is done by TF-A code. the abstraction give us the
> > > possibility that using one driver to cover the whole i.MX8M family in
> > > kernel side.
> > >
> >
> > Again: what does this driver bring to the table, other than moving a fr=
action of
> > the power domain functionality into the firmware?
> >
> > The discussions on the last submissions of this driver already establis=
hed that
> > we can't move all functionality for the power domains into the firmware=
, as
> > controlling regulators is probably not easy to do from this context. Al=
so the
> > TF-A side implementation of this driver is "interesting" IMHO, it does =
stuff like
> > accessing the clock controller registers without any locking or other m=
eans of
> > mutual exclusion with the Linux kernel clock controller driver.
> >
>
> The clock handling is in kernel side through CCF, not in ATF. See the pat=
ch below.
>
> > Why can't we just extend the existing GPCv2 driver with support for the=
 other
> > i.MX8M family members?
> >
>
> The reason that why I don=E2=80=99t like to extend the GPCv2 is that when=
 doing domain on/off,
> We need to access some special control register in each domain & do some =
special flow,
> These control register(mediamix block control, vpumix block control) is n=
ot in GPC
> module's address range. No benefit to reuse the GPCv2. Only bring complex=
ity to the
> GPCv2 driver each time a new SoC is added.
>
> Yes, the i.MX8M power domain support has been pending for a while. ARM gu=
ys rejected this patchset
> because they suggest us to use SCMI rather than SiP. But SCMI is only par=
tial suitable for our
> case.

I have been anxiously waiting for this.  If I want to test this, what
ATF do we need to use?  I know for some of the DDRC stuff, we couldn't
use upstream ATF or U-Boot, so I had to use a custom version from
NXP's repo.  Ideally, it would be nice to have everything play nicely
together so we don't have to depend on external repos like the NXP
repo on Code Auroroa.  I am not complaining, but when I attempted to
push U-Boot, I mentioned that I needed a specific branch of ATF.  I
wanted that version of U-Boot for DDRC in the kernel, and now I'd like
to make sure I understand the requirements of this, so we can easily
build and test your patch.  You mention that that ARM rejected the
patch set, so I just want to make sure I know what I need to do.

thanks,

adam


>
> BR
> Jacky Bai
> > Regards,
> > Lucas
> >
> > > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > ---
> > >  drivers/soc/imx/Kconfig            |   6 +
> > >  drivers/soc/imx/Makefile           |   1 +
> > >  drivers/soc/imx/imx8m_pm_domains.c | 224
> > +++++++++++++++++++++++++++++++++++++
> > >  include/soc/imx/imx_sip.h          |  12 ++
> > >  4 files changed, 243 insertions(+)
> > >  create mode 100644 drivers/soc/imx/imx8m_pm_domains.c
> > >  create mode 100644 include/soc/imx/imx_sip.h
> > >
> > > diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> > > d515d2c..7837199 100644
> > > --- a/drivers/soc/imx/Kconfig
> > > +++ b/drivers/soc/imx/Kconfig
> > > @@ -27,4 +27,10 @@ config SOC_IMX8M
> > >       support, it will provide the SoC info like SoC family,
> > >       ID and revision etc.
> > >
> > > +config IMX8M_PM_DOMAINS
> > > +   bool "i.MX8M PM domains"
> > > +   depends on ARCH_MXC || (COMPILE_TEST && OF)
> > > +   depends on PM
> > > +   select PM_GENERIC_DOMAINS
> > > +
> > >  endmenu
> > > diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile inde=
x
> > > 103e2c9..a22e24b 100644
> > > --- a/drivers/soc/imx/Makefile
> > > +++ b/drivers/soc/imx/Makefile
> > > @@ -3,3 +3,4 @@ obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
> > >  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
> > >  obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
> > >  obj-$(CONFIG_IMX_SCU_SOC) +=3D soc-imx-scu.o
> > > +obj-$(CONFIG_IMX8M_PM_DOMAINS) +=3D imx8m_pm_domains.o
> > > diff --git a/drivers/soc/imx/imx8m_pm_domains.c
> > > b/drivers/soc/imx/imx8m_pm_domains.c
> > > new file mode 100644
> > > index 00000000..ce06a05
> > > --- /dev/null
> > > +++ b/drivers/soc/imx/imx8m_pm_domains.c
> > > @@ -0,0 +1,224 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright 2019 NXP.
> > > + */
> > > +
> > > +#include <linux/arm-smccc.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_domain.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#include <soc/imx/imx_sip.h>
> > > +
> > > +#define MAX_CLK_NUM        6
> > > +#define to_imx8m_pm_domain(_genpd) container_of(_genpd, struct
> > > +imx8m_pm_domain, pd)
> > > +
> > > +
> > > +struct imx8m_pm_domain {
> > > +   struct device *dev;
> > > +   struct generic_pm_domain pd;
> > > +   u32 domain_index;
> > > +   struct clk *clk[MAX_CLK_NUM];
> > > +   unsigned int num_clks;
> > > +   struct regulator *reg;
> > > +};
> > > +
> > > +enum imx8m_pm_domain_state {
> > > +   PD_STATE_OFF,
> > > +   PD_STATE_ON,
> > > +};
> > > +
> > > +static DEFINE_MUTEX(gpc_pd_mutex);
> > > +
> > > +static int imx8m_pd_power_on(struct generic_pm_domain *genpd) {
> > > +   struct imx8m_pm_domain *domain =3D to_imx8m_pm_domain(genpd);
> > > +   struct arm_smccc_res res;
> > > +   int index, ret =3D 0;
> > > +
> > > +   /* power on the external supply */
> > > +   if (!IS_ERR(domain->reg)) {
> > > +           ret =3D regulator_enable(domain->reg);
> > > +           if (ret) {
> > > +                   dev_warn(domain->dev, "failed to power up the reg=
%d\n", ret);
> > > +                   return ret;
> > > +           }
> > > +   }
> > > +
> > > +   /* enable the necessary clks needed by the power domain */
> > > +   if (domain->num_clks) {
> > > +           for (index =3D 0; index < domain->num_clks; index++)
> > > +                   clk_prepare_enable(domain->clk[index]);
> > > +   }
> > > +
> > > +   mutex_lock(&gpc_pd_mutex);
> > > +   arm_smccc_smc(IMX_SIP_GPC, IMX_SIP_CONFIG_GPC_PM_DOMAIN,
> > domain->domain_index,
> > > +                 PD_STATE_ON, 0, 0, 0, 0, &res);
> > > +   mutex_unlock(&gpc_pd_mutex);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int imx8m_pd_power_off(struct generic_pm_domain *genpd) {
> > > +   struct imx8m_pm_domain *domain =3D to_imx8m_pm_domain(genpd);
> > > +   struct arm_smccc_res res;
> > > +   int index, ret =3D 0;
> > > +
> > > +   mutex_lock(&gpc_pd_mutex);
> > > +   arm_smccc_smc(IMX_SIP_GPC, IMX_SIP_CONFIG_GPC_PM_DOMAIN,
> > domain->domain_index,
> > > +                 PD_STATE_OFF, 0, 0, 0, 0, &res);
> > > +   mutex_unlock(&gpc_pd_mutex);
> > > +
> > > +   /* power off the external supply */
> > > +   if (!IS_ERR(domain->reg)) {
> > > +           ret =3D regulator_disable(domain->reg);
> > > +           if (ret) {
> > > +                   dev_warn(domain->dev, "failed to power off the re=
g%d\n",
> > ret);
> > > +                   return ret;
> > > +           }
> > > +   }
> > > +
> > > +   /* disable clks when power domain is off */
> > > +   if (domain->num_clks) {
> > > +           for (index =3D 0; index < domain->num_clks; index++)
> > > +                   clk_disable_unprepare(domain->clk[index]);
> > > +   }
> > > +
> > > +   return ret;
> > > +};
> > > +
> > > +static int imx8m_pd_get_clocks(struct imx8m_pm_domain *domain) {
> > > +   int i, ret;
> > > +
> > > +   for (i =3D 0; ; i++) {
> > > +           struct clk *clk =3D of_clk_get(domain->dev->of_node, i);
> > > +           if (IS_ERR(clk))
> > > +                   break;
> > > +           if (i >=3D MAX_CLK_NUM) {
> > > +                   dev_err(domain->dev, "more than %d clocks\n",
> > > +                           MAX_CLK_NUM);
> > > +                   ret =3D -EINVAL;
> > > +                   goto clk_err;
> > > +           }
> > > +           domain->clk[i] =3D clk;
> > > +   }
> > > +   domain->num_clks =3D i;
> > > +
> > > +   return 0;
> > > +
> > > +clk_err:
> > > +   while (i--)
> > > +           clk_put(domain->clk[i]);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +static void imx8m_pd_put_clocks(struct imx8m_pm_domain *domain) {
> > > +   int i;
> > > +
> > > +   for (i =3D domain->num_clks - 1; i >=3D 0; i--)
> > > +           clk_put(domain->clk[i]);
> > > +}
> > > +
> > > +static const struct of_device_id imx8m_pm_domain_ids[] =3D {
> > > +   {.compatible =3D "fsl,imx8m-pm-domain"},
> > > +   {},
> > > +};
> > > +
> > > +static int imx8m_pm_domain_probe(struct platform_device *pdev) {
> > > +   struct device *dev =3D &pdev->dev;
> > > +   struct device_node *np =3D dev->of_node;
> > > +   struct imx8m_pm_domain *domain;
> > > +   struct of_phandle_args parent, child;
> > > +   int ret;
> > > +
> > > +   domain =3D devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
> > > +   if (!domain)
> > > +           return -ENOMEM;
> > > +
> > > +   child.np =3D np;
> > > +   domain->dev =3D dev;
> > > +
> > > +   ret =3D of_property_read_string(np, "domain-name", &domain->pd.na=
me);
> > > +   if (ret) {
> > > +           dev_err(dev, "failed to get the domain name\n");
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   ret =3D of_property_read_u32(np, "domain-index",
> > &domain->domain_index);
> > > +   if (ret) {
> > > +           dev_err(dev, "failed to get the domain index\n");
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   domain->reg =3D devm_regulator_get_optional(dev, "power");
> > > +   if (IS_ERR(domain->reg)) {
> > > +           if (PTR_ERR(domain->reg) !=3D -ENODEV) {
> > > +                   if (PTR_ERR(domain->reg) !=3D -EPROBE_DEFER)
> > > +                           dev_err(dev, "failed to get domain's regu=
lator\n");
> > > +                   return PTR_ERR(domain->reg);
> > > +           }
> > > +   }
> > > +
> > > +   ret =3D imx8m_pd_get_clocks(domain);
> > > +   if (ret) {
> > > +           if (ret !=3D -EPROBE_DEFER)
> > > +                   dev_err(dev, "failed to get domain's clocks\n");
> > > +           return ret;
> > > +   }
> > > +
> > > +   domain->pd.power_off =3D imx8m_pd_power_off;
> > > +   domain->pd.power_on =3D imx8m_pd_power_on;
> > > +
> > > +   pm_genpd_init(&domain->pd, NULL, true);
> > > +
> > > +   ret =3D of_genpd_add_provider_simple(np, &domain->pd);
> > > +   if (ret) {
> > > +           dev_err(dev, "failed to add the domain provider\n");
> > > +           pm_genpd_remove(&domain->pd);
> > > +           imx8m_pd_put_clocks(domain);
> > > +           return ret;
> > > +   }
> > > +
> > > +   /* add it as subdomain if necessary */
> > > +   if (!of_parse_phandle_with_args(np, "parent-domains",
> > > +                   "#power-domain-cells", 0, &parent)) {
> > > +           ret =3D of_genpd_add_subdomain(&parent, &child);
> > > +           of_node_put(parent.np);
> > > +
> > > +           if (ret < 0) {
> > > +                   dev_dbg(dev, "failed to add the subdomain: %s: %d=
",
> > > +                           domain->pd.name, ret);
> > > +                   of_genpd_del_provider(np);
> > > +                   pm_genpd_remove(&domain->pd);
> > > +                   imx8m_pd_put_clocks(domain);
> > > +                   return driver_deferred_probe_check_state(dev);
> > > +           }
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static struct platform_driver imx8m_pm_domain_driver =3D {
> > > +   .driver =3D {
> > > +           .name   =3D "imx8m_pm_domain",
> > > +           .owner  =3D THIS_MODULE,
> > > +           .of_match_table =3D imx8m_pm_domain_ids,
> > > +   },
> > > +   .probe =3D imx8m_pm_domain_probe,
> > > +};
> > > +module_platform_driver(imx8m_pm_domain_driver);
> > > +
> > > +MODULE_AUTHOR("NXP");
> > > +MODULE_DESCRIPTION("NXP i.MX8M power domain driver");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/include/soc/imx/imx_sip.h b/include/soc/imx/imx_sip.h ne=
w
> > > file mode 100644 index 00000000..6b96b33
> > > --- /dev/null
> > > +++ b/include/soc/imx/imx_sip.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright 2019 NXP
> > > + */
> > > +
> > > +#ifndef __IMX_SIP_H__
> > > +#define __IMX_SIP_H__
> > > +
> > > +#define IMX_SIP_GPC                        0xC2000000
> > > +#define IMX_SIP_CONFIG_GPC_PM_DOMAIN       0x03
> > > +
> > > +#endif /* __IMX_SIP_H__ */
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
