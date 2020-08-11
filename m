Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7441FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBE020756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oabY19Z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHKVlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgHKVk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:40:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0084C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:40:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so7343869pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AJOup3ZxW54qYpiONuV0+CKv0qJfDDqSyRIaH9fvcgU=;
        b=oabY19Z8jrN9tbam2Saghz+d5donMjhVeBr2VG0ucXKln8tacmJ6U2fHEXrbwClVfi
         /XVS3onQtw4sRLzR2r/GUqnJSRhId+snFz5WAfTAKhhqQKwCQjfws1/PHUfj5Aw1SGsT
         Z6D9H5RSNFgg8Ggkb3tfSlUE+vud7XnV1CdyXCaWBgb0HoIRLOKNOpoEliHa3Jpn243B
         wtBRRT/RDcBuW0e5TVq6LJ+hRNEfJ4gRfVWtu+6Esx8VkoiCoHZ1iiFBf3q16KEmId4r
         LLVIWomgmuIOBdhpqEKJHzJErvWC/pXlR7O4n69fpxp6x5PNulx1dGZboywDm/IDaoyx
         n+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AJOup3ZxW54qYpiONuV0+CKv0qJfDDqSyRIaH9fvcgU=;
        b=oLAgXCcJ6e5M0muH3TxEfN64HNZ+0glH+exALF0smajJw23wJZlzZwZuX/iDjZkk0z
         5RmkamKQ0SAYherctWL/AFbJHNCs+PKWEt1JiT2x63Vuig3Egr3AGunJZO8zN4qf3uHH
         /M6y/s+0LuZwyoH+V3wNN2+NYso+VSI+B1uRuAn8vvp0B1RaAJO/xHugCMVfzy1AFwNs
         czvJ2AZLrCj3KCOUrM19kBKWXeeAgZ58DTdtsvjn6UKCBCS7C0hi/XEfcP9mgF2h68fw
         zt23hQ/JTalM4Tc86jzBUYpSytUJ2by/ohZGBkw+lnbk4l1GWTLomC7gpjX7JjyNxQsB
         chQw==
X-Gm-Message-State: AOAM5300wXhzhsQWEDkx+zjkOk5X9fuwTJqEPJxecKmfP0YULvhmOl4W
        Iqix3TlLFKHjKYiCLFnkj/z4/g==
X-Google-Smtp-Source: ABdhPJy6Xr/1mRIVs7VW6TlfxTPSMX2OXN4iKwfeu39RchR7ERZonklTRn+qTmONTxMzHGfC86pXlQ==
X-Received: by 2002:a63:e118:: with SMTP id z24mr2321982pgh.230.1597182059092;
        Tue, 11 Aug 2020 14:40:59 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c2sm104077pgb.52.2020.08.11.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:40:58 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:40:56 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     bjorn.andersson@linaro.org, o.rempel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 06/10] remoteproc: imx_rproc: add load hook
Message-ID: <20200811214056.GB3370567@xps15>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-7-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724080813.24884-7-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 04:08:09PM +0800, Peng Fan wrote:
> To i.MX8, we not able to see the correct data written into TCM when
> using ioremap_wc, so use ioremap.
> 
> However common elf loader using memset.
> 
> To arm64, "dc      zva, dst" is used in memset.
> Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,
> 
> "If the memory region being zeroed is any type of Device memory,
> this instruction can give an alignment fault which is prioritized
> in the same way as other alignment faults that are determined
> by the memory type."
> 
> On i.MX platforms, when elf is loaded to onchip TCM area, the region
> is ioremapped, so "dc zva, dst" will trigger abort.
> 
> So add i.MX specific loader to address the TCM write issue.
> 
> The change not impact i.MX6/7 function.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index aee790efbf7b..c23726091228 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/elf.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -15,6 +16,9 @@
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
>  
> +#include "remoteproc_internal.h"
> +#include "remoteproc_elf_helpers.h"
> +
>  #define IMX7D_SRC_SCR			0x0C
>  #define IMX7D_ENABLE_M4			BIT(3)
>  #define IMX7D_SW_M4P_RST		BIT(2)
> @@ -247,10 +251,82 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
>  	return va;
>  }
>  
> +static int imx_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct device *dev = &rproc->dev;
> +	const void *ehdr, *phdr;
> +	int i, ret = 0;
> +	u16 phnum;
> +	const u8 *elf_data = fw->data;
> +	u8 class = fw_elf_get_class(fw);
> +	u32 elf_phdr_get_size = elf_size_of_phdr(class);
> +
> +	ehdr = elf_data;
> +	phnum = elf_hdr_get_e_phnum(class, ehdr);
> +	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
> +
> +	/* go through the available ELF segments */
> +	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
> +		u64 da = elf_phdr_get_p_paddr(class, phdr);
> +		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
> +		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
> +		u64 offset = elf_phdr_get_p_offset(class, phdr);
> +		u32 type = elf_phdr_get_p_type(class, phdr);
> +		void *ptr;
> +
> +		if (type != PT_LOAD)
> +			continue;
> +
> +		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
> +			type, da, memsz, filesz);
> +
> +		if (filesz > memsz) {
> +			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
> +				filesz, memsz);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (offset + filesz > fw->size) {
> +			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
> +				offset + filesz, fw->size);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (!rproc_u64_fit_in_size_t(memsz)) {
> +			dev_err(dev, "size (%llx) does not fit in size_t type\n",
> +				memsz);
> +			ret = -EOVERFLOW;
> +			break;
> +		}
> +
> +		/* grab the kernel address for this device address */
> +		ptr = rproc_da_to_va(rproc, da, memsz);
> +		if (!ptr) {
> +			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> +				memsz);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		/* put the segment where the remote processor expects it */
> +		if (filesz)
> +			memcpy_toio(ptr, elf_data + offset, filesz);
> +	}
> +
> +	return ret;
> +}

This is clearly the wrong approach.  What you came up with in [1] is far better,
though I would call the the operations elf_memcpy() and elf_memset().

That being said I don't know how [1] fits with this patchset.  From where I
stand a new revision is needed.

[1]. https://patchwork.kernel.org/patch/11688751/

> +
>  static const struct rproc_ops imx_rproc_ops = {
>  	.start		= imx_rproc_start,
>  	.stop		= imx_rproc_stop,
>  	.da_to_va       = imx_rproc_da_to_va,
> +	.load		= imx_rproc_elf_load_segments,
> +	.parse_fw	= rproc_elf_load_rsc_table,
> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> +	.sanity_check	= rproc_elf_sanity_check,
> +	.get_boot_addr	= rproc_elf_get_boot_addr,
>  };
>  
>  static int imx_rproc_addr_init(struct imx_rproc *priv,
> -- 
> 2.16.4
> 
