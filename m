Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03C0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEA920717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aplCMKmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgGUUng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgGUUng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:43:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8CCC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:43:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n5so14380pgf.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6b3oA4UL1L2pl7xC9XCpGfPbFXbX6ZR3mQ/aH6nN3aM=;
        b=aplCMKmLtk1FND72f9eTw2pW0XV235w2d7abx0+nAqdK+5QHFUZUtqiXP3Y/5NfWwQ
         OP0koBCszYM3OjbRoWGb9J2n5jEHmqZ6iZvMjrdhubqs08gi7J2ZJm0AvaheIAChdgVe
         7MEKxT+pv82gNj/QbYrQIrC+ws3wQQ1yxdP7oGdDW+0Vgl/fKppwh3+V150QjFW7B0sR
         pfuiSebY5wKyIuGmulwut1717V7STCbyNn4pXsUhj1rO3Uw2IJGLCqE9RK2xBIl74F49
         isMNRqNjvPF38ITyYEMgKk4pMSMMY5Hw3R+VLWqG+e65UZgP/9R7FHaVotrNczHhVufX
         vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6b3oA4UL1L2pl7xC9XCpGfPbFXbX6ZR3mQ/aH6nN3aM=;
        b=Fmq0ZoxR2olCr0hcYrfz4QzBR7NHMoDFhHFIASF8nBXQrI8aX9tbzGSxQ95aakNv7B
         0AngvccGr4Cjp1v3iE7kJ5rsN956rLKHnwyBiwIEwP4G6UZOem85D/SDJKTXIsdmfoYV
         41HGZPHlTMoc0funzbSLLiuam77g87rfSFrFDG1IlxRE4IqM4oU6bz28WLcODAn/Ghjk
         IJAMkR38Et2Zz0/XkA+d5OjX1ylmSldkabgR47IyY5rv2jSn3DtV44CFXQW7GtRN8HDq
         NCvtRGOpqZKXf1wd/BG8pi4LqC2QqCRSWMgIN1NgBF4I0mMfkdaTIrmPIIKPT4gT9Q5b
         cLQw==
X-Gm-Message-State: AOAM532ct5RHzi3Zz70cNWOj4IifEHxvP72/2f9MOAH70Q1Q/ludqFoD
        TLzqCwzXMq82C3wqpffLY/JMWw==
X-Google-Smtp-Source: ABdhPJwuyrOyVT4KOawwJEajBAoNJgJsEKfBbYSabaXT83Sv4Y4Gqw+HTJiZ3dzR4rMofwR9hrMHZA==
X-Received: by 2002:aa7:9906:: with SMTP id z6mr26338877pff.60.1595364215284;
        Tue, 21 Jul 2020 13:43:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z10sm21858949pfr.90.2020.07.21.13.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 13:43:34 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:43:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] remoteproc: mtk_apu: Don't try to use the APU local
 RAM
Message-ID: <20200721204332.GC1227776@xps15>
References: <20200713132927.24925-1-abailon@baylibre.com>
 <20200713132927.24925-6-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713132927.24925-6-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:29:26PM +0200, Alexandre Bailon wrote:
> Currently, this local RAM is not accessible from the CPU.
> If the CPU tries to access it, then the CPU will hang.
> 
> Remoteproc may try to use it when it load a firmware
> that has some sections in the local RAM.
> This workarounds the issue by skiping this section.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/remoteproc/mtk_apu_rproc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_apu_rproc.c b/drivers/remoteproc/mtk_apu_rproc.c
> index 565b3adca5de..e16d3258a785 100644
> --- a/drivers/remoteproc/mtk_apu_rproc.c
> +++ b/drivers/remoteproc/mtk_apu_rproc.c
> @@ -57,6 +57,9 @@
>  #define CORE_DEFAULT2_SPIDEN			BIT(0)
>  #define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
>  
> +#define DRAM0_START				(0x7ff00000)
> +#define IRAM0_END				(0x7ff80000)
> +
>  struct mtk_vpu_rproc {
>  	struct device *dev;
>  	struct rproc *rproc;
> @@ -139,6 +142,7 @@ static void mtk_vpu_rproc_kick(struct rproc *rproc, int vqid)
>  
>  int mtk_vpu_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  {
> +	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
>  	const u8 *elf_data = fw->data;
>  	struct elf32_hdr *ehdr;
>  	struct elf32_phdr *phdr;
> @@ -156,6 +160,16 @@ int mtk_vpu_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  		/* Remove empty PT_LOAD section */
>  		if (phdr->p_type == PT_LOAD && !phdr->p_paddr)
>  			phdr->p_type = PT_NULL;
> +		/*
> +		 * Workaround: Currently, the CPU can't access to the APU
> +		 * local RAM. This removes the local RAM section from the
> +		 * firmware. Please note that may cause some issues.
> +		 */
> +		if (phdr->p_paddr >= DRAM0_START && phdr->p_paddr < IRAM0_END) {
> +			dev_warn_once(vpu_rproc->dev,
> +				      "Skipping the APU local RAM section\n");
> +			phdr->p_type = PT_NULL;

We can't selectively decide to not load sections of a program due to a platform
driver shortcoming.  Either a real solution is found or booting the remote
processor is interrupted, with a strong incline toward the former.

I guess you're dealing with tightly coupled memory or on-chip RAM areas -
both are accessed on other platform using ioremap_wc() or devm_ioremap_wc().
You might want to try doing what Suman has done in this patchset [1], with
specific attention to TCMs and SRAM.

Thanks,
Mathieu

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=310325

> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.26.2
> 
