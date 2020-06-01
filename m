Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9103BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6365E206F1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ewJmtPxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFAJ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:57:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59356 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFAJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:57:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601095726euoutp01f8c07462f2c746186ac3db586e7fdf2a~UYwYaYwfW1826318263euoutp01l
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:57:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601095726euoutp01f8c07462f2c746186ac3db586e7fdf2a~UYwYaYwfW1826318263euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591005446;
        bh=LDsE6ueEvdyKUE8C0+haZDqtol2UPCrU5c/+LQ6QjUo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ewJmtPxubrylQzVaOps95939CnJvAKtgHH4KmFk3Dq4VpXTlAD8aUccXUykc0Kfpb
         RpIPAEQ1QrreaZ+ICPq+1FhD+AtXMcJC22iZe9brJTdU0Aq1vJR8YhdA1CYmgcjfcn
         4xlm47ZlilpXw58LKMjIBymD+7+705qYmUWOynyw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601095725eucas1p2d9d3f678f9c1340ace3b2f775146ceb8~UYwX0hiOb0963209632eucas1p2i;
        Mon,  1 Jun 2020 09:57:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 26.0C.61286.501D4DE5; Mon,  1
        Jun 2020 10:57:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601095725eucas1p1b5ce46c20440a17fa07a3b0ea2ff121b~UYwXdQ2OM2993329933eucas1p1S;
        Mon,  1 Jun 2020 09:57:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601095725eusmtrp1df4478bc8899b9e2b44e218d480bdd21~UYwXcWUP71915919159eusmtrp1g;
        Mon,  1 Jun 2020 09:57:25 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-3b-5ed4d105af31
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.75.08375.501D4DE5; Mon,  1
        Jun 2020 10:57:25 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200601095723eusmtip1c0a076a941c487545e63c4f6f4eca432~UYwWKjuys1285612856eusmtip1J;
        Mon,  1 Jun 2020 09:57:23 +0000 (GMT)
Subject: Re: [RFC PATCH v5 2/6] interconnect: Add generic interconnect
 driver for Exynos SoCs
To:     Chanwoo Choi <chanwoo@kernel.org>
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <396329f7-a8e9-79da-9187-d5fd61c2bf4e@samsung.com>
Date:   Mon, 1 Jun 2020 11:57:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAGTfZH3zvgOtME0U2hKjtqO49e0-Nw6MRxhw+z6Mfio-=FUwcQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZe9k6aPi7Tk4bVMMiozIp6oLCbxKA+FBKh4WXlm1q6Yq9a
        9kVLlLxUpoTzshQvuVbzMi26WnhFLM0LM0ob5sq0MrJVWGK1vUV++51z/uc55394OEoxwnhz
        cZpEXqtRxytZF/p2x0zPGqZvMGJdaddyYr2agUiDro4hl58P0mTIPs6QsrYehgx+/cSSwodm
        luRb82jS21svJeYxC0MG7pWyRNfbLCGmthEpeXnWwJKMh21SoiuYYLdjldmYxaqGLQ9YlTWn
        U6JqrEpVXWwyItUXs+8+NsxlazQfH5fMawOColxic8wN1ElL2OnS4TQ6DRUEZyMZB3gjzN1v
        p7ORC6fABgSjukkkBnYEXVPtrBh8QVB9c+aPjHO2nK/SiPkaBJa5wr8dnxE0N43RjncX4ki4
        cv2u1MEeeAXUT3cwDhGFqxnoyrQhR4HFgXCh/aKT5TgIfmVNO5nGfjDyRu/kRTgccq2TlKhx
        h64im3OADO+H2hs1TqawF7ywlUlEXgrpt0ooxzDAZzm4++iSRHQaDO+NE5TIC2Gys0kq8hLo
        LsilxYZ0BLn3X0rFIA+BtbMciaotMNzzg3UcgML+UHcvQEzvgMdvTRLxLq7w/KO7uIQr5N8u
        pMS0HM5nKkS1H/w0Fv5dxxtybL/oPKQsnmeteJ6d4nl2iv/PLUe0EXnxSUJCDC8EavhTawV1
        gpCkiVl75ESCGf35dN1zndN30Nf+wy0Ic0i5QL6yfyBCwaiThZSEFgQcpfSQ73zaHaGQR6tT
        zvDaE5HapHheaEE+HK30km+omAhX4Bh1In+c50/y2n9VCSfzTkN73FKCjo6/Klm9K8DXcPCb
        wVRByOLK70XN9IH6dYy+1m7N26TTVzdFPlnWOOtjKnG1e76eyprqk0UdBmFVcsXuMmko52a3
        1aZ0VPmHbvP4sN7NU996TN9qiUgNwZ+OVe4VZns3nztkuhYyWU6O75ORZzvT2tJrK4e9tg+9
        Gz2qpIVYdeAqSiuofwO/0X+IcAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7qsF6/EGRyaw2Vxf14ro8XGGetZ
        LSbeuMJicf3Lc1aL+UfOsVpc+fqezWL63k1sFpPuT2CxOH9+A7vFpsfXWC0u75rDZjHj/D4m
        i7VH7rJb3G5cwWbRuvcIu8WMyS/ZHAQ8Nq3qZPO4c20Pm8f97uNMHpuX1Hv0bVnF6PF5k1wA
        W5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRvem
        jcwF16Iq5txpYGlgnOzSxcjBISFgItGxJK+LkYtDSGApo8TUS7PYIOJSEvNblLoYOYFMYYk/
        17rYIGreM0qs37+RGSQhLBAvcXTKATBbREBVYsOnY6wgRcwCy1kljh1azwaSEBLoYJKY8oIP
        xGYTMJToPdrHCGLzCthJ/O/8BGazCKhI3H06F8wWFYiV6F78gx2iRlDi5MwnLCA2p0CgxLrV
        y8FsZgF1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFu
        em6xoV5xYm5xaV66XnJ+7iZGYFRvO/Zz8w7GSxuDDzEKcDAq8fBeOH85Tog1say4MvcQowQH
        s5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MOHkl8YamhuYWlobmxubGZhZK
        4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhj1auZNsag9IBaqHD+x1P47r3CK+DQDhpa1gZdl
        RU6W7wgQrwh4u8Tsc9019slSPT66NbF7a9q7t7l/y/p0UqqgaqrGK+NHK355aC5SbTuhu/P9
        pCVv7i8yuO/4uDv+zJXbxydv35uYv1ch99Pr/rsRy6MEqw5mbzTMbvwmfzvP5MfnvdPTuDiU
        WIozEg21mIuKEwE0gh5lAAMAAA==
X-CMS-MailID: 20200601095725eucas1p1b5ce46c20440a17fa07a3b0ea2ff121b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5
References: <CGME20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5@eucas1p2.samsung.com>
        <20200529163200.18031-1-s.nawrocki@samsung.com>
        <20200529163200.18031-3-s.nawrocki@samsung.com>
        <CAGTfZH3zvgOtME0U2hKjtqO49e0-Nw6MRxhw+z6Mfio-=FUwcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Rob, devicetree ML

On 31.05.2020 02:13, Chanwoo Choi wrote:
> On Sat, May 30, 2020 at 1:34 AM Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>>
>> This patch adds a generic interconnect driver for Exynos SoCs in order
>> to provide interconnect functionality for each "samsung,exynos-bus"
>> compatible device.
>>
>> The SoC topology is a graph (or more specifically, a tree) and its
>> edges are specified using the 'samsung,interconnect-parent' in the
>> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
>> propagated to ensure that the parent is probed before its children.
>>
>> Each bus is now an interconnect provider and an interconnect node as
>> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
>> registers itself as a node. Node IDs are not hardcoded but rather
>> assigned dynamically at runtime. This approach allows for using this
>> driver with various Exynos SoCs.
>>
>> Frequencies requested via the interconnect API for a given node are
>> propagated to devfreq using dev_pm_qos_update_request(). Please note
>> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
>> case all interconnect API functions are no-op.
>>
>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>
>> Changes for v5:
>>  - adjust to renamed exynos,interconnect-parent-node property,
>>  - use automatically generated platform device id as the interconect
>>    node id instead of a now unavailable devfreq->id field,
>>  - add icc_ prefix to some variables to make the code more self-commenting,
>>  - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
>>  - adjust to exynos,interconnect-parent-node property rename to
>>    samsung,interconnect-parent,
>>  - converted to a separate platform driver in drivers/interconnect.
>> ---
>>  drivers/interconnect/Kconfig         |   1 +
>>  drivers/interconnect/Makefile        |   1 +
>>  drivers/interconnect/exynos/Kconfig  |   6 ++
>>  drivers/interconnect/exynos/Makefile |   4 +
>>  drivers/interconnect/exynos/exynos.c | 185 +++++++++++++++++++++++++++++++++++
>>  5 files changed, 197 insertions(+)
>>  create mode 100644 drivers/interconnect/exynos/Kconfig
>>  create mode 100644 drivers/interconnect/exynos/Makefile
>>  create mode 100644 drivers/interconnect/exynos/exynos.c
>>
>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
>> index 5b7204e..eca6eda 100644
>> --- a/drivers/interconnect/Kconfig
>> +++ b/drivers/interconnect/Kconfig
>> @@ -11,6 +11,7 @@ menuconfig INTERCONNECT
>>
>>  if INTERCONNECT
>>
>> +source "drivers/interconnect/exynos/Kconfig"
>>  source "drivers/interconnect/imx/Kconfig"
>>  source "drivers/interconnect/qcom/Kconfig"
>>
>> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
>> index 4825c28..2ba1de6 100644
>> --- a/drivers/interconnect/Makefile
>> +++ b/drivers/interconnect/Makefile
>> @@ -4,5 +4,6 @@ CFLAGS_core.o                           := -I$(src)
>>  icc-core-objs                          := core.o
>>
>>  obj-$(CONFIG_INTERCONNECT)             += icc-core.o
>> +obj-$(CONFIG_INTERCONNECT_EXYNOS)      += exynos/
>>  obj-$(CONFIG_INTERCONNECT_IMX)         += imx/
>>  obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
>> diff --git a/drivers/interconnect/exynos/Kconfig b/drivers/interconnect/exynos/Kconfig
>> new file mode 100644
>> index 0000000..e51e52e
>> --- /dev/null
>> +++ b/drivers/interconnect/exynos/Kconfig
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config INTERCONNECT_EXYNOS
>> +       tristate "Exynos generic interconnect driver"
>> +       depends on ARCH_EXYNOS || COMPILE_TEST
>> +       help
>> +         Generic interconnect driver for Exynos SoCs.
>> diff --git a/drivers/interconnect/exynos/Makefile b/drivers/interconnect/exynos/Makefile
>> new file mode 100644
>> index 0000000..e19d1df
>> --- /dev/null
>> +++ b/drivers/interconnect/exynos/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +exynos-interconnect-objs               := exynos.o
>> +
>> +obj-$(CONFIG_INTERCONNECT_EXYNOS)      += exynos-interconnect.o
>> diff --git a/drivers/interconnect/exynos/exynos.c b/drivers/interconnect/exynos/exynos.c
>> new file mode 100644
>> index 0000000..8278194
>> --- /dev/null
>> +++ b/drivers/interconnect/exynos/exynos.c
>> @@ -0,0 +1,185 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Exynos generic interconnect provider driver
>> + *
>> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
>> + *
>> + * Authors: Artur Świgoń <a.swigon@samsung.com>
>> + *          Sylwester Nawrocki <s.nawrocki@samsung.com>
>> + */
>> +#include <linux/device.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_qos.h>
>> +
>> +#define kbps_to_khz(x) ((x) / 8)
>> +
>> +struct exynos_icc_priv {
>> +       struct device *dev;
>> +
>> +       /* One interconnect node per provider */
>> +       struct icc_provider provider;
>> +       struct icc_node *node;
>> +
>> +       struct dev_pm_qos_request qos_req;
>> +};
>> +
>> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
>> +{
>> +       struct of_phandle_args args;
>> +       int num, ret;
>> +
>> +       num = of_count_phandle_with_args(np, "samsung,interconnect-parent",
>> +                                       "#interconnect-cells");
>> +       if (num != 1)
>> +               return NULL; /* parent nodes are optional */
>> +
>> +       ret = of_parse_phandle_with_args(np, "samsung,interconnect-parent",
>> +                                       "#interconnect-cells", 0, &args);
>> +       if (ret < 0)
>> +               return ERR_PTR(ret);
>> +
>> +       of_node_put(args.np);
>> +
>> +       return of_icc_get_from_provider(&args);
>> +}
>> +
>> +
>> +static int exynos_generic_icc_set(struct icc_node *src, struct icc_node *dst)
>> +{
>> +       struct exynos_icc_priv *src_priv = src->data, *dst_priv = dst->data;
>> +       s32 src_freq = kbps_to_khz(max(src->avg_bw, src->peak_bw));
>> +       s32 dst_freq = kbps_to_khz(max(dst->avg_bw, dst->peak_bw));
>> +       int ret;
>> +
>> +       ret = dev_pm_qos_update_request(&src_priv->qos_req, src_freq);
>> +       if (ret < 0) {
>> +               dev_err(src_priv->dev, "failed to update PM QoS of %s\n",
>> +                       src->name);
>> +               return ret;
>> +       }
>> +
>> +       ret = dev_pm_qos_update_request(&dst_priv->qos_req, dst_freq);
>> +       if (ret < 0) {
>> +               dev_err(dst_priv->dev, "failed to update PM QoS of %s\n",
>> +                       dst->name);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
>> +                                                void *data)
>> +{
>> +       struct exynos_icc_priv *priv = data;
>> +
>> +       if (spec->np != priv->dev->parent->of_node)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       return priv->node;
>> +}
>> +
>> +static int exynos_generic_icc_remove(struct platform_device *pdev)
>> +{
>> +       struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
>> +       struct icc_node *parent_node, *node = priv->node;
>> +
>> +       parent_node = exynos_icc_get_parent(priv->dev->parent->of_node);
>> +       if (parent_node && !IS_ERR(parent_node))
>> +               icc_link_destroy(node, parent_node);
>> +
>> +       icc_nodes_remove(&priv->provider);
>> +       icc_provider_del(&priv->provider);
>> +
>> +       return 0;
>> +}
>> +
>> +static int exynos_generic_icc_probe(struct platform_device *pdev)
>> +{
>> +       struct device *bus_dev = pdev->dev.parent;
>> +       struct exynos_icc_priv *priv;
>> +       struct icc_provider *provider;
>> +       struct icc_node *icc_node, *icc_parent_node;
>> +       int ret;
>> +
>> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       priv->dev = &pdev->dev;
>> +       platform_set_drvdata(pdev, priv);
>> +
>> +       provider = &priv->provider;
>> +
>> +       provider->set = exynos_generic_icc_set;
>> +       provider->aggregate = icc_std_aggregate;
>> +       provider->xlate = exynos_generic_icc_xlate;
>> +       provider->dev = bus_dev;
>> +       provider->inter_set = true;
>> +       provider->data = priv;
>> +
>> +       ret = icc_provider_add(provider);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       icc_node = icc_node_create(pdev->id);
>> +       if (IS_ERR(icc_node)) {
>> +               ret = PTR_ERR(icc_node);
>> +               goto err_prov_del;
>> +       }
>> +
>> +       priv->node = icc_node;
>> +       icc_node->name = bus_dev->of_node->name;
>> +       icc_node->data = priv;
>> +       icc_node_add(icc_node, provider);
>> +
>> +       icc_parent_node = exynos_icc_get_parent(bus_dev->of_node);
>> +       if (IS_ERR(icc_parent_node)) {
>> +               ret = PTR_ERR(icc_parent_node);
>> +               goto err_node_del;
>> +       }
>> +       if (icc_parent_node) {
>> +               ret = icc_link_create(icc_node, icc_parent_node->id);
>> +               if (ret < 0)
>> +                       goto err_node_del;
>> +       }
>> +
>> +       /*
>> +        * Register a PM QoS request for the bus device for which also devfreq
>> +        * functionality is registered.
>> +        */
>> +       ret = dev_pm_qos_add_request(bus_dev, &priv->qos_req,
>> +                                    DEV_PM_QOS_MIN_FREQUENCY, 0);
>> +       if (ret < 0)
>> +               goto err_link_destroy;
>> +
>> +       return 0;
>> +
>> +err_link_destroy:
>> +       if (icc_parent_node)
>> +               icc_link_destroy(icc_node, icc_parent_node);
>> +err_node_del:
>> +       icc_nodes_remove(provider);
>> +err_prov_del:
>> +       icc_provider_del(provider);
>> +
>> +       return ret;
>> +}
>> +
>> +static struct platform_driver exynos_generic_icc_driver = {
>> +       .driver = {
>> +               .name = "exynos-generic-icc",
>> +       },
>> +       .probe = exynos_generic_icc_probe,
>> +       .remove = exynos_generic_icc_remove,
>> +};
>> +module_platform_driver(exynos_generic_icc_driver);
>> +
>> +MODULE_DESCRIPTION("Exynos generic interconnect driver");
>> +MODULE_AUTHOR("Artur Świgoń <a.swigon@samsung.com>");
>> +MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:exynos-generic-icc");
>> --
>> 2.7.4
>>
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> As I commented, How about changing the compatible name 'exynos-icc'
> without 'generic'?
> The 'exynos-icc' doesn't have the any specific version of Exynos SoC,
> it think that it already contain the 'generic' meaning for Exynos SoC.
 
Sure, I can change it to "exynos-icc". However please note it is just 
a name for the driver and its related virtual platform (sub)device that 
is created in the devfreq driver, which matches on the "samsung,exynos-bus"
compatible. Of course we could add any specific DT compatible to this driver
in future if needed.

-- 
Thanks,
Sylwester
