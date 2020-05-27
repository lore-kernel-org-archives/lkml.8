Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA964C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B335620787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YU6Jfn0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgE0G3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgE0G3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:29:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD856C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:29:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v2so6321808pfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=fxu5dk7RwUA8dpHbFW3pd+nyeTF1vd8Gc7FoHjS2Hsg=;
        b=YU6Jfn0IShLyAgTnfgnKMV3lHdFpIbLyNsA7yG/oL+kJmPzMoEbI1SBG04cuw2sMtg
         pSb8nDqJPl6TpiZOEgn3Guezb23/WRWb/EvKTR+lYVYGxh2te7bD6hwDEXnt8jR5HMWC
         U865RObLU5LvQCy0/grgdrFP3jdGUpi6W24xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=fxu5dk7RwUA8dpHbFW3pd+nyeTF1vd8Gc7FoHjS2Hsg=;
        b=Q64QYmb6izzSBgsoPiS6DGdvPqDGpNt1vnLOVuRgecVuwFXW4NrHjac9e8D8iL6Xls
         6VsGvlkDSsw4UIJGb5crpbYh6/1Y/o3VGTp0tnJCJfMADjvc2bD03WsLEhED2zHMS6W8
         DFYkwM1BZwe+OrMCvJT6mtSu5Cy/6gz8E4qsKlUHuysadx4/4Yrc8wEY6dMHXnkLrXYo
         ndS8Tk8YRd/NHLYd8vFeJQS+zJl9H2n0APCQiN1CKRWiTpQysT+NpNQ6CK6kq1W8rwm3
         GbBDdGa1+ALZSDrPpamqBTp/27KOkUNpet48ouz78FiC5ms+grKT4L8ga5NR/msBBmuy
         9eGg==
X-Gm-Message-State: AOAM531hqNkTeJXHjWUyByEXooBfPxIeM67zrFh0pX5lsrNDTi0Pvw/7
        b8mARczuRBZkoLgfhdyLCB+ZYg==
X-Google-Smtp-Source: ABdhPJyhkfa5KlK1RTabR8GhRJivCy04mKqYuT1GUxseSgs3O4T4NkBUkhxqItF2iiDCVu8ltYliHA==
X-Received: by 2002:a62:1407:: with SMTP id 7mr2536858pfu.103.1590560979100;
        Tue, 26 May 2020 23:29:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u69sm1290044pjb.40.2020.05.26.23.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 23:29:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527054850.2067032-3-bjorn.andersson@linaro.org>
References: <20200527054850.2067032-1-bjorn.andersson@linaro.org> <20200527054850.2067032-3-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v6 2/5] remoteproc: qcom: Introduce helper to store pil info in IMEM
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Date:   Tue, 26 May 2020 23:29:37 -0700
Message-ID: <159056097743.88029.16084555679084078794@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-05-26 22:48:46)
> diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom=
_pil_info.c
> new file mode 100644
> index 000000000000..0785c7cde2d3
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_pil_info.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020 Linaro Ltd.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_address.h>
> +
> +#define PIL_RELOC_NAME_LEN     8
> +
> +struct pil_reloc_entry {
> +       char name[PIL_RELOC_NAME_LEN];
> +       __le64 base;
> +       __le32 size;
> +} __packed;
> +
> +struct pil_reloc {
> +       struct device *dev;

This isn't assigned. Remove it?

> +       void __iomem *base;
> +       size_t num_entries;
> +};
> +
> +static struct pil_reloc _reloc __read_mostly;
> +static DEFINE_MUTEX(reloc_mutex);

reloc_mutex is a little generic. Maybe pil_reloc_lock or
qcom_pil_reloc_lock?

> +
> +static int qcom_pil_info_init(void)
> +{
> +       struct device_node *np;
> +       struct resource imem;
> +       void __iomem *base;
> +       int ret;
> +
> +       /* Already initialized? */
> +       if (_reloc.base)
> +               return 0;
> +
> +       np =3D of_find_compatible_node(NULL, NULL, "qcom,pil-reloc-info");
> +       if (!np)
> +               return -ENOENT;
> +
> +       ret =3D of_address_to_resource(np, 0, &imem);
> +       of_node_put(np);
> +       if (ret < 0)
> +               return ret;
> +
> +       base =3D ioremap(imem.start, resource_size(&imem));
> +       if (!base) {
> +               pr_err("failed to map PIL relocation info region\n");
> +               return -ENOMEM;
> +       }
> +
> +       memset_io(base, 0, resource_size(&imem));
> +
> +       _reloc.base =3D base;
> +       _reloc.num_entries =3D resource_size(&imem) / sizeof(struct pil_r=
eloc_entry);
> +
> +       return 0;
> +}
> +
> +/**
> + * qcom_pil_info_store() - store PIL information of image in IMEM
> + * @image:     name of the image
> + * @base:      base address of the loaded image
> + * @size:      size of the loaded image
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
> +{
> +       char buf[PIL_RELOC_NAME_LEN];
> +       void __iomem *entry;
> +       int ret;
> +       int i;
> +
> +       mutex_lock(&reloc_mutex);
> +       ret =3D qcom_pil_info_init();
> +       if (ret < 0) {
> +               mutex_unlock(&reloc_mutex);
> +               return ret;
> +       }
> +
> +       for (i =3D 0; i < _reloc.num_entries; i++) {
> +               entry =3D _reloc.base + i * sizeof(struct pil_reloc_entry=
);
> +
> +               memcpy_fromio(buf, entry, PIL_RELOC_NAME_LEN);
> +
> +               /*
> +                * An empty record means we didn't find it, given that the
> +                * records are packed.
> +                */
> +               if (!buf[0])
> +                       goto found_unused;
> +
> +               if (!strncmp(buf, image, PIL_RELOC_NAME_LEN))
> +                       goto found_existing;
> +       }
> +
> +       pr_warn("insufficient PIL info slots\n");
> +       mutex_unlock(&reloc_mutex);
> +       return -ENOMEM;
> +
> +found_unused:
> +       memcpy_toio(entry, image, PIL_RELOC_NAME_LEN);
> +found_existing:
> +       writel(base, entry + offsetof(struct pil_reloc_entry, base));
> +       writel(size, entry + offsetof(struct pil_reloc_entry, size));

It makes me nervous to see offsetof() used in the same line as writel()
because who knows what the compiler does, even with __packed and stuff.
I guess I tried and failed to convince you earlier to change this code
to use fixed offsets instead of structs to describe the memory layout
but that must have failed!

> +       mutex_unlock(&reloc_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pil_info_store);
> +
> +static void __exit pil_reloc_exit(void)
> +{
> +       mutex_lock(&reloc_mutex);
> +       iounmap(_reloc.base);
> +       _reloc.base =3D NULL;
> +       mutex_unlock(&reloc_mutex);
> +}
> +module_exit(pil_reloc_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm PIL relocation info");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/remoteproc/qcom_pil_info.h b/drivers/remoteproc/qcom=
_pil_info.h
> new file mode 100644
> index 000000000000..1b89a63ba82f
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_pil_info.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __QCOM_PIL_INFO_H__
> +#define __QCOM_PIL_INFO_H__

Probably need <linux/types.h> here for phys_addr_t definition to make
this header self-contained.

> +
> +int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size=
);
> +
> +#endif
