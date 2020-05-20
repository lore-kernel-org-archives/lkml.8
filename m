Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2596C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AAFC2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+3hd/H6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgETSA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:00:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F6C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:00:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z26so1928150pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jbOZ6D8UTJXl2g3NkTVmgRiYB3vWrX+7ScIEamM0pxE=;
        b=C+3hd/H6VNSiOnCHNaf2tFnIe28+ZlX7ZWZ5ah/VYYu8bxzJWyQ5NUspA6oUJKfzt8
         +CkG4WYbZAoPwsOBiWjwoY/lTtMlu7FNjIR886drIQaEY/Hogdt74kZKYWn/IbtoqhVi
         m/5JVgN3sQRBgcu7WZRFwN5AL/NfRGDK2vlEyhdGIzAJYflRdKr9+3FugjdBqwb87vu1
         4PvM8wclivNL1NxZpec+5QkppNH9YZSLRj0iVZiZvFUjtpf2BOjKK9Ac5CsMdG1llsbZ
         30xcVdA0CB6U2ogwMrmN44R8mJexRh0TbbpDLrcBnVEFsT4FwotNRZMD4DV72+vYZN4c
         khPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbOZ6D8UTJXl2g3NkTVmgRiYB3vWrX+7ScIEamM0pxE=;
        b=nlOlb0f1s7Y9lJ3mya8ywN6e1BXVd+NQFxUwGciiDtPdMBRKfcP+HI3Vomdl2Lises
         CoZg0533SWdBQ5PHKUIhxR+Empq2jT3e0gUig1Or3YN/ow8qu5T7QuPKSZ0D5//KYfC/
         jLV23ftPrLFAV6vGDlJz3aW9Vrfowh4txLTB+cFN2bmQICukzs7LobVfCm9VlE6EAIC4
         dYh43g7zav5fM7FhKrreXGREGV12OH4xP9D5wZPI4PT8hSACYXH2NiL0o0SJY7foBXDE
         c+R4qS5If4yKh8JtVvz2ShZFl2lln2p070hWDBKGJbEc3m1feATY9V5Q/VNn86b/11by
         nZFw==
X-Gm-Message-State: AOAM532FwmJJhwElj85yyu+BQQT/p8FPLuIl/HQ6146fXcUVbbnJwQ+y
        9W2QXbeTPZOxce7bWE47vJZ1iQ==
X-Google-Smtp-Source: ABdhPJxsVRglCD+mh5RlR8l37ekhasxQ09hW8TJ5bATFwGCIGezHMiIwZlfnmWFLaxDjKSUY+ltFBA==
X-Received: by 2002:a63:4911:: with SMTP id w17mr5085225pga.13.1589997653643;
        Wed, 20 May 2020 11:00:53 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w69sm2800880pff.168.2020.05.20.11.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:00:53 -0700 (PDT)
Date:   Wed, 20 May 2020 12:00:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] remoteproc: qcom: Introduce helper to store pil
 info in IMEM
Message-ID: <20200520180051.GB13884@xps15>
References: <20200513055641.1413100-1-bjorn.andersson@linaro.org>
 <20200513055641.1413100-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513055641.1413100-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:56:38PM -0700, Bjorn Andersson wrote:
> A region in IMEM is used to communicate load addresses of remoteproc to
> post mortem debug tools. Implement a helper function that can be used to
> store this information in order to enable these tools to process
> collected ramdumps.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v4:
> - Replaced platform_driver by just a single helper function
> - Lazy initialization of mapping
> - Cleaned up search loop
> - Replaced regmap access of IMEM with ioremap and normal accessors
> 
>  drivers/remoteproc/Kconfig         |   3 +
>  drivers/remoteproc/Makefile        |   1 +
>  drivers/remoteproc/qcom_pil_info.c | 124 +++++++++++++++++++++++++++++
>  drivers/remoteproc/qcom_pil_info.h |   7 ++
>  4 files changed, 135 insertions(+)
>  create mode 100644 drivers/remoteproc/qcom_pil_info.c
>  create mode 100644 drivers/remoteproc/qcom_pil_info.h
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index fbaed079b299..8088ca4dd6dc 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -107,6 +107,9 @@ config KEYSTONE_REMOTEPROC
>  	  It's safe to say N here if you're not interested in the Keystone
>  	  DSPs or just want to use a bare minimum kernel.
>  
> +config QCOM_PIL_INFO
> +	tristate
> +
>  config QCOM_RPROC_COMMON
>  	tristate
>  
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 0effd3825035..cc0f631adb3b 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>  obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
> +obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
>  obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>  obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
>  obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
> diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom_pil_info.c
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
> +#define PIL_RELOC_NAME_LEN	8
> +
> +struct pil_reloc_entry {
> +	char name[PIL_RELOC_NAME_LEN];
> +	__le64 base;
> +	__le32 size;
> +} __packed;
> +
> +struct pil_reloc {
> +	struct device *dev;
> +	void __iomem *base;
> +	size_t num_entries;
> +};
> +
> +static struct pil_reloc _reloc __read_mostly;
> +static DEFINE_MUTEX(reloc_mutex);
> +
> +static int qcom_pil_info_init(void)
> +{
> +	struct device_node *np;
> +	struct resource imem;
> +	void __iomem *base;
> +	int ret;
> +
> +	/* Already initialized? */
> +	if (_reloc.base)
> +		return 0;
> +
> +	np = of_find_compatible_node(NULL, NULL, "qcom,pil-reloc-info");
> +	if (!np)
> +		return -ENOENT;
> +
> +	ret = of_address_to_resource(np, 0, &imem);
> +	of_node_put(np);
> +	if (ret < 0)
> +		return ret;
> +
> +	base = ioremap(imem.start, resource_size(&imem));
> +	if (!base) {
> +		pr_err("failed to map PIL relocation info region\n");
> +		return -ENOMEM;
> +	}
> +
> +	memset_io(base, 0, resource_size(&imem));
> +
> +	_reloc.base = base;
> +	_reloc.num_entries = resource_size(&imem) / sizeof(struct pil_reloc_entry);
> +
> +	return 0;
> +}
> +
> +/**
> + * qcom_pil_info_store() - store PIL information of image in IMEM
> + * @image:	name of the image
> + * @base:	base address of the loaded image
> + * @size:	size of the loaded image
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
> +{
> +	char buf[PIL_RELOC_NAME_LEN];
> +	void __iomem *entry;
> +	int ret;
> +	int i;
> +
> +	mutex_lock(&reloc_mutex);
> +	ret = qcom_pil_info_init();
> +	if (ret < 0) {
> +		mutex_unlock(&reloc_mutex);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < _reloc.num_entries; i++) {
> +		entry = _reloc.base + i * sizeof(struct pil_reloc_entry);
> +
> +		memcpy_fromio(buf, entry, PIL_RELOC_NAME_LEN);
> +
> +		/*
> +		 * An empty record means we didn't find it, given that the
> +		 * records are packed.
> +		 */
> +		if (!buf[0])
> +			goto found_unused;
> +
> +		if (!strncmp(buf, image, PIL_RELOC_NAME_LEN))
> +			goto found_existing;
> +	}
> +
> +	pr_warn("insufficient PIL info slots\n");
> +	mutex_unlock(&reloc_mutex);
> +	return -ENOMEM;
> +
> +found_unused:
> +	memcpy_toio(entry, image, PIL_RELOC_NAME_LEN);
> +found_existing:
> +	writel(base, entry + offsetof(struct pil_reloc_entry, base));
> +	writel(size, entry + offsetof(struct pil_reloc_entry, size));
> +	mutex_unlock(&reloc_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pil_info_store);
> +
> +static void __exit pil_reloc_exit(void)
> +{
> +	mutex_lock(&reloc_mutex);
> +	iounmap(_reloc.base);
> +	_reloc.base = NULL;
> +	mutex_unlock(&reloc_mutex);
> +}
> +module_exit(pil_reloc_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm PIL relocation info");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/remoteproc/qcom_pil_info.h b/drivers/remoteproc/qcom_pil_info.h
> new file mode 100644
> index 000000000000..1b89a63ba82f
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_pil_info.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __QCOM_PIL_INFO_H__
> +#define __QCOM_PIL_INFO_H__
> +
> +int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size);
> +
> +#endif

Very clean an easy to understand.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.26.2
> 
