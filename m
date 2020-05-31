Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02339C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB28E208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590884058;
	bh=4n7xLjDfmWJy7cEzQOlVj3OGl5xGSGF7KDFQyddTsFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QaAR5K02H0/0ysCMYXuCoZxmIzrsv+puOE5k/Xt3yPJZGZnplez2FbMK2OtV+ebRU
	 PZHQPPmFVTpugQK+Aa45KCgjOHS5YLmm3JU4VLpBcKH4KxGCqGtxit2dtFgKtJibsN
	 7jHb5stfrmJIgXFyyIlHm1GmAtkQngm1WkXe2mRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgEaAOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 20:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbgEaAOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 20:14:18 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FCC207BC;
        Sun, 31 May 2020 00:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590884056;
        bh=4n7xLjDfmWJy7cEzQOlVj3OGl5xGSGF7KDFQyddTsFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rVIWM9zdmkW/djHLs4fi/TvKDLvxI169DCHYP6+1kQLYCcid0Pqs6nf93HNfTTzzg
         nslHxKYR7ciL2ZJW4sZ08vw9sPi1CANrCOkK1XHu3TEDaoq/XbYGy1bU59LpDYd5t5
         HIulCBdZuAPlLwgHI6YDjpigvZb91ziiN+cY8m00=
Received: by mail-lf1-f42.google.com with SMTP id 82so1869438lfh.2;
        Sat, 30 May 2020 17:14:16 -0700 (PDT)
X-Gm-Message-State: AOAM533iVRl5VHLDIOOY3y+78Vef0cw7jL/9GI3d9NLWHxTko6bnWXnU
        k9wPVvvS4oc1ow4dC+rGr9lREWzmnOUBleBTCOg=
X-Google-Smtp-Source: ABdhPJwJsr06uJnzfnjvjQX/rYRN9Ngp7XOU3puMFisFW3c+wxvlfArxpab0i3PmK4xjzDVioqwCsCQX9QsbhnIXjE0=
X-Received: by 2002:a19:550e:: with SMTP id n14mr7963650lfe.81.1590884054566;
 Sat, 30 May 2020 17:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5@eucas1p2.samsung.com>
 <20200529163200.18031-1-s.nawrocki@samsung.com> <20200529163200.18031-3-s.nawrocki@samsung.com>
In-Reply-To: <20200529163200.18031-3-s.nawrocki@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 31 May 2020 09:13:38 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3zvgOtME0U2hKjtqO49e0-Nw6MRxhw+z6Mfio-=FUwcQ@mail.gmail.com>
Message-ID: <CAGTfZH3zvgOtME0U2hKjtqO49e0-Nw6MRxhw+z6Mfio-=FUwcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On Sat, May 30, 2020 at 1:34 AM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> This patch adds a generic interconnect driver for Exynos SoCs in order
> to provide interconnect functionality for each "samsung,exynos-bus"
> compatible device.
>
> The SoC topology is a graph (or more specifically, a tree) and its
> edges are specified using the 'samsung,interconnect-parent' in the
> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
> propagated to ensure that the parent is probed before its children.
>
> Each bus is now an interconnect provider and an interconnect node as
> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
> registers itself as a node. Node IDs are not hardcoded but rather
> assigned dynamically at runtime. This approach allows for using this
> driver with various Exynos SoCs.
>
> Frequencies requested via the interconnect API for a given node are
> propagated to devfreq using dev_pm_qos_update_request(). Please note
> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
> case all interconnect API functions are no-op.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> Changes for v5:
>  - adjust to renamed exynos,interconnect-parent-node property,
>  - use automatically generated platform device id as the interconect
>    node id instead of a now unavailable devfreq->id field,
>  - add icc_ prefix to some variables to make the code more self-commentin=
g,
>  - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
>  - adjust to exynos,interconnect-parent-node property rename to
>    samsung,interconnect-parent,
>  - converted to a separate platform driver in drivers/interconnect.
> ---
>  drivers/interconnect/Kconfig         |   1 +
>  drivers/interconnect/Makefile        |   1 +
>  drivers/interconnect/exynos/Kconfig  |   6 ++
>  drivers/interconnect/exynos/Makefile |   4 +
>  drivers/interconnect/exynos/exynos.c | 185 +++++++++++++++++++++++++++++=
++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 drivers/interconnect/exynos/Kconfig
>  create mode 100644 drivers/interconnect/exynos/Makefile
>  create mode 100644 drivers/interconnect/exynos/exynos.c
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 5b7204e..eca6eda 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -11,6 +11,7 @@ menuconfig INTERCONNECT
>
>  if INTERCONNECT
>
> +source "drivers/interconnect/exynos/Kconfig"
>  source "drivers/interconnect/imx/Kconfig"
>  source "drivers/interconnect/qcom/Kconfig"
>
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefil=
e
> index 4825c28..2ba1de6 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -4,5 +4,6 @@ CFLAGS_core.o                           :=3D -I$(src)
>  icc-core-objs                          :=3D core.o
>
>  obj-$(CONFIG_INTERCONNECT)             +=3D icc-core.o
> +obj-$(CONFIG_INTERCONNECT_EXYNOS)      +=3D exynos/
>  obj-$(CONFIG_INTERCONNECT_IMX)         +=3D imx/
>  obj-$(CONFIG_INTERCONNECT_QCOM)                +=3D qcom/
> diff --git a/drivers/interconnect/exynos/Kconfig b/drivers/interconnect/e=
xynos/Kconfig
> new file mode 100644
> index 0000000..e51e52e
> --- /dev/null
> +++ b/drivers/interconnect/exynos/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INTERCONNECT_EXYNOS
> +       tristate "Exynos generic interconnect driver"
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       help
> +         Generic interconnect driver for Exynos SoCs.
> diff --git a/drivers/interconnect/exynos/Makefile b/drivers/interconnect/=
exynos/Makefile
> new file mode 100644
> index 0000000..e19d1df
> --- /dev/null
> +++ b/drivers/interconnect/exynos/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +exynos-interconnect-objs               :=3D exynos.o
> +
> +obj-$(CONFIG_INTERCONNECT_EXYNOS)      +=3D exynos-interconnect.o
> diff --git a/drivers/interconnect/exynos/exynos.c b/drivers/interconnect/=
exynos/exynos.c
> new file mode 100644
> index 0000000..8278194
> --- /dev/null
> +++ b/drivers/interconnect/exynos/exynos.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Exynos generic interconnect provider driver
> + *
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *
> + * Authors: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> + *          Sylwester Nawrocki <s.nawrocki@samsung.com>
> + */
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
> +
> +#define kbps_to_khz(x) ((x) / 8)
> +
> +struct exynos_icc_priv {
> +       struct device *dev;
> +
> +       /* One interconnect node per provider */
> +       struct icc_provider provider;
> +       struct icc_node *node;
> +
> +       struct dev_pm_qos_request qos_req;
> +};
> +
> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
> +{
> +       struct of_phandle_args args;
> +       int num, ret;
> +
> +       num =3D of_count_phandle_with_args(np, "samsung,interconnect-pare=
nt",
> +                                       "#interconnect-cells");
> +       if (num !=3D 1)
> +               return NULL; /* parent nodes are optional */
> +
> +       ret =3D of_parse_phandle_with_args(np, "samsung,interconnect-pare=
nt",
> +                                       "#interconnect-cells", 0, &args);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +
> +       of_node_put(args.np);
> +
> +       return of_icc_get_from_provider(&args);
> +}
> +
> +
> +static int exynos_generic_icc_set(struct icc_node *src, struct icc_node =
*dst)
> +{
> +       struct exynos_icc_priv *src_priv =3D src->data, *dst_priv =3D dst=
->data;
> +       s32 src_freq =3D kbps_to_khz(max(src->avg_bw, src->peak_bw));
> +       s32 dst_freq =3D kbps_to_khz(max(dst->avg_bw, dst->peak_bw));
> +       int ret;
> +
> +       ret =3D dev_pm_qos_update_request(&src_priv->qos_req, src_freq);
> +       if (ret < 0) {
> +               dev_err(src_priv->dev, "failed to update PM QoS of %s\n",
> +                       src->name);
> +               return ret;
> +       }
> +
> +       ret =3D dev_pm_qos_update_request(&dst_priv->qos_req, dst_freq);
> +       if (ret < 0) {
> +               dev_err(dst_priv->dev, "failed to update PM QoS of %s\n",
> +                       dst->name);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args =
*spec,
> +                                                void *data)
> +{
> +       struct exynos_icc_priv *priv =3D data;
> +
> +       if (spec->np !=3D priv->dev->parent->of_node)
> +               return ERR_PTR(-EINVAL);
> +
> +       return priv->node;
> +}
> +
> +static int exynos_generic_icc_remove(struct platform_device *pdev)
> +{
> +       struct exynos_icc_priv *priv =3D platform_get_drvdata(pdev);
> +       struct icc_node *parent_node, *node =3D priv->node;
> +
> +       parent_node =3D exynos_icc_get_parent(priv->dev->parent->of_node)=
;
> +       if (parent_node && !IS_ERR(parent_node))
> +               icc_link_destroy(node, parent_node);
> +
> +       icc_nodes_remove(&priv->provider);
> +       icc_provider_del(&priv->provider);
> +
> +       return 0;
> +}
> +
> +static int exynos_generic_icc_probe(struct platform_device *pdev)
> +{
> +       struct device *bus_dev =3D pdev->dev.parent;
> +       struct exynos_icc_priv *priv;
> +       struct icc_provider *provider;
> +       struct icc_node *icc_node, *icc_parent_node;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev =3D &pdev->dev;
> +       platform_set_drvdata(pdev, priv);
> +
> +       provider =3D &priv->provider;
> +
> +       provider->set =3D exynos_generic_icc_set;
> +       provider->aggregate =3D icc_std_aggregate;
> +       provider->xlate =3D exynos_generic_icc_xlate;
> +       provider->dev =3D bus_dev;
> +       provider->inter_set =3D true;
> +       provider->data =3D priv;
> +
> +       ret =3D icc_provider_add(provider);
> +       if (ret < 0)
> +               return ret;
> +
> +       icc_node =3D icc_node_create(pdev->id);
> +       if (IS_ERR(icc_node)) {
> +               ret =3D PTR_ERR(icc_node);
> +               goto err_prov_del;
> +       }
> +
> +       priv->node =3D icc_node;
> +       icc_node->name =3D bus_dev->of_node->name;
> +       icc_node->data =3D priv;
> +       icc_node_add(icc_node, provider);
> +
> +       icc_parent_node =3D exynos_icc_get_parent(bus_dev->of_node);
> +       if (IS_ERR(icc_parent_node)) {
> +               ret =3D PTR_ERR(icc_parent_node);
> +               goto err_node_del;
> +       }
> +       if (icc_parent_node) {
> +               ret =3D icc_link_create(icc_node, icc_parent_node->id);
> +               if (ret < 0)
> +                       goto err_node_del;
> +       }
> +
> +       /*
> +        * Register a PM QoS request for the bus device for which also de=
vfreq
> +        * functionality is registered.
> +        */
> +       ret =3D dev_pm_qos_add_request(bus_dev, &priv->qos_req,
> +                                    DEV_PM_QOS_MIN_FREQUENCY, 0);
> +       if (ret < 0)
> +               goto err_link_destroy;
> +
> +       return 0;
> +
> +err_link_destroy:
> +       if (icc_parent_node)
> +               icc_link_destroy(icc_node, icc_parent_node);
> +err_node_del:
> +       icc_nodes_remove(provider);
> +err_prov_del:
> +       icc_provider_del(provider);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver exynos_generic_icc_driver =3D {
> +       .driver =3D {
> +               .name =3D "exynos-generic-icc",
> +       },
> +       .probe =3D exynos_generic_icc_probe,
> +       .remove =3D exynos_generic_icc_remove,
> +};
> +module_platform_driver(exynos_generic_icc_driver);
> +
> +MODULE_DESCRIPTION("Exynos generic interconnect driver");
> +MODULE_AUTHOR("Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>");
> +MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:exynos-generic-icc");
> --
> 2.7.4
>

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

As I commented, How about changing the compatible name 'exynos-icc'
without 'generic'?
The 'exynos-icc' doesn't have the any specific version of Exynos SoC,
it think that it already contain the 'generic' meaning for Exynos SoC.

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
