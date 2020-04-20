Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E65C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053682073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEatlmJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDTGgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725812AbgDTGgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:36:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708FC061A10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 23:36:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so203996pfa.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L27HBU83hEal+N26VFwHycUX9XOfAyoXkB2huIPsA9k=;
        b=XEatlmJeITPpwD3f0SlRiEBIQL07PhR1eF9mmHF/OhduyMH5V6X1Wn6a71K6iBByQx
         HK60nJ8BGPYHQWgoZ09buq/ukO0+LJY/fabEE8x2W1HnykDWV61JUWBdy/AJsDfWZz+e
         KIr2OC0fti5A4PxK6X+n4UwWOSiR6J9LYe5r9lmmUfwY7+rx17ImZsmMnUNgJUEN2fs7
         gNbRmCztcAR+ox2Q9zFikSPdyd8Ytqo5ZqZojKUU0EnWwFjJ/QCQCaUds8MyM+uqLCjG
         llSaH06R8wN18FFgBYinwz9/7HqCHuVcH4briVvomSNNW774Skr7R/pazfzRa+N0xLmX
         xmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L27HBU83hEal+N26VFwHycUX9XOfAyoXkB2huIPsA9k=;
        b=rvz+1p3IikmAjCF1gzFNzrKe2tBIqgTrrpHC9bkDEMNFIU+B91LvQimWXEkfu3uxrt
         artQYgJTFl4M+fL4javlXtKXtSy1b731BjdjJ21sBdkQSVBAVd5wb53hvrlYQsf0xGV4
         XcBQFTUjkFP7doGPDgd0arFpp78Rq4zmkva62wEPN2knvqar3nBbL/TmYUfho/J6SW3L
         ZsQ5rwGJKReMYlgDYEfC/iMpOzIcur0eaaukNVnhJENMzpuaoE/Q/loGLxgSPvctPiw4
         7drb707XNjHphdwgHu9KQf8FAD+HEzKvHs//Ldku/1tbTzoGioE0bnJ1H4RwFNGRkzvq
         3VNA==
X-Gm-Message-State: AGi0PuZ28G0BNRPMe7P72FV6Roj41JOVcmHQlz2rU8N6EbWoIMd2DU1r
        zp3uFmC8KnwtgJLlbDMRdmYYTQ==
X-Google-Smtp-Source: APiQypIyskZupogxs8R5S2FQG0PhO1AvaANwpsKWLHsPifS9+YKjOFR/4CCknIWpq8eAAm9OOA7gNA==
X-Received: by 2002:aa7:96cf:: with SMTP id h15mr10987919pfq.319.1587364611618;
        Sun, 19 Apr 2020 23:36:51 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h9sm96070pfo.129.2020.04.19.23.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 23:36:50 -0700 (PDT)
Date:   Sun, 19 Apr 2020 23:37:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 4/5] remoteproc: ingenic: Added remoteproc driver
Message-ID: <20200420063714.GA1868936@builder.lan>
References: <20200417170040.174319-1-paul@crapouillou.net>
 <20200417170040.174319-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417170040.174319-4-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Apr 10:00 PDT 2020, Paul Cercueil wrote:

> This driver is used to boot, communicate with and load firmwares to the
> MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
> Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>

Please read Documentation/process/submitting-patches.rst about
"Developer's Certificate of Origin".

I suspect that you incorporated review feedback on previous revisions
from kbuild and Julia, this is generally omitted from the actual commit
message.

> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> 
> Notes:
>     v2: Remove exception for always-mapped memories
>     v3: - Use clk_bulk API
>     	- Move device-managed code to its own patch [3/4]
>     	- Move devicetree table right above ingenic_rproc_driver
>     	- Removed #ifdef CONFIG_OF around devicetree table
>     	- Removed .owner = THIS_MODULE in ingenic_rproc_driver
>     	- Removed useless platform_set_drvdata()
>     v4: - Add fix reported by Julia
>     	- Change Kconfig symbol to INGENIC_VPU_RPROC
>     	- Add documentation to struct vpu
>     	- disable_irq_nosync() -> disable_irq()
>     v5: No change
>     v6: Instead of prepare/unprepare callbacks, use PM runtime callbacks
> 
>  drivers/remoteproc/Kconfig         |   8 +
>  drivers/remoteproc/Makefile        |   1 +
>  drivers/remoteproc/ingenic_rproc.c | 282 +++++++++++++++++++++++++++++
>  3 files changed, 291 insertions(+)
>  create mode 100644 drivers/remoteproc/ingenic_rproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index fbaed079b299..31da3e6c6281 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -240,6 +240,14 @@ config STM32_RPROC
>  
>  	  This can be either built-in or a loadable module.
>  
> +config INGENIC_VPU_RPROC

Please try to keep things alphabetically ordered.

> +	tristate "Ingenic JZ47xx VPU remoteproc support"
> +	depends on MIPS || COMPILE_TEST
> +	help
> +	  Say y or m here to support the VPU in the JZ47xx SoCs from Ingenic.
> +	  This can be either built-in or a loadable module.
> +	  If unsure say N.
> +
>  endif # REMOTEPROC
>  
>  endmenu
[..]
> diff --git a/drivers/remoteproc/ingenic_rproc.c b/drivers/remoteproc/ingenic_rproc.c
[..]
> +/**
> + * struct vpu - Ingenic VPU remoteproc private structure
> + * @irq: interrupt number
> + * @clks: pointers to the VPU and AUX clocks

aux_base is missing

> + * @mem_info: array of struct vpu_mem_info, which contain the mapping info of
> + *            each of the external memories
> + * @dev: private pointer to the device
> + */
> +struct vpu {
> +	int irq;
> +	struct clk_bulk_data clks[2];
> +	void __iomem *aux_base;
> +	struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
> +	struct device *dev;
> +};
[..]
> +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
> +{
> +	struct vpu *vpu = rproc->priv;
> +	void __iomem *va = NULL;
> +	unsigned int i;
> +
> +	if (len <= 0)

len can't be negative (also, does it add value to check for and fail len
== 0?)

> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
> +		const struct vpu_mem_info *info = &vpu->mem_info[i];
> +		const struct vpu_mem_map *map = info->map;
> +
> +		if (da >= map->da && (da + len) < (map->da + info->len)) {
> +			va = info->base + (da - map->da);
> +			break;
> +		}
> +	}
> +
> +	return (__force void *)va;
> +}
[..]
> +static struct platform_driver ingenic_rproc_driver = {
> +	.probe = ingenic_rproc_probe,
> +	.driver = {
> +		.name = "ingenic-vpu",
> +#ifdef CONFIG_PM

Please omit the #ifdef here.

> +		.pm = &ingenic_rproc_pm,
> +#endif
> +		.of_match_table = of_match_ptr(ingenic_rproc_of_matches),

Please omit the of_match_ptr()

Regards,
Bjorn

> +	},
> +};
> +module_platform_driver(ingenic_rproc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control driver");
> -- 
> 2.25.1
> 
