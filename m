Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E445EC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FFF2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfhiyP3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgGUTwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGUTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:52:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481CEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:52:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so10705786pld.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WWOGUf1kHIiZX7y4u7rmFiomLqHyARFcqwJuvoXcMNk=;
        b=rfhiyP3u6vwY/JZIYnypfUnHTIqtwwe0z1tGlVlsZYJXQrTca4FpjajkOPoqP4MBv4
         YJaWhaTlZqZ50d5lttvcLHmPJjQDFitAbxzuLwcueiVHMb5W0HeejC6sLTrw7SGnTSEb
         jJYvL3b+j1bFcKvRuI/eAub9OVnexXHZUK2usbF7mC6hoyve352osdA7+2f0qQLm7HjH
         h8JyYVESjmyookj0wVyt9cDE+vpH9DqQ8VIdU7AVCSPqVmTjQQbphenjFVRPVmgLYqGy
         QTlZ2MbykLgbMb2sHCpKUOe/ASzYv9r5MTyEvQCJx9ovgdse47eBGNFbI7A+fUaJw8vz
         +p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WWOGUf1kHIiZX7y4u7rmFiomLqHyARFcqwJuvoXcMNk=;
        b=Cx8FU97mPt0Z68f6MPM7J12rw9DCvJjWMVAisrnuH/jPxPop+wzqEFhcTDTohWRMW9
         4dIenOQZN/BnPUmXqOyFsCgegsJNSnd1rGyJ8ijUPV2NN7u3m4eKtISg4j9otkSMipC7
         +dPukRb90KHh+BTZD/G7mwsqURIhZShRiO+5muGIgJTxUGbCmRvYZpZtx6cgpCfvouJk
         i+gCNnlRXH6J42loJxnVa4JFpXH8wvF4GMudJ27PlEydXMzD4epTQFpvINEDmz00NU5N
         hE/nN8SCZVvjouDoGoW5Zi5T+oD1m/dslEkb2RVhbrvC00gvneC6j7KiFCLqWdV+yFGH
         4sew==
X-Gm-Message-State: AOAM5338wG0Ws1rdXAag3M0dKRZPL3g41ShCEatPVryw7tAsrWtx7016
        iTul04XwnFLZPcQypXAVYZBwIw==
X-Google-Smtp-Source: ABdhPJxSpHhoC0P/xl32RjvhmPPxC24UmOEw2dw+81HzbqPJfi4ZAFLQim072r+FaSNw8gBd7wcetA==
X-Received: by 2002:a17:90a:f014:: with SMTP id bt20mr6510921pjb.135.1595361154719;
        Tue, 21 Jul 2020 12:52:34 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o10sm3875159pjs.27.2020.07.21.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 12:52:33 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:52:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] remoteproc: mtk_vpu_rproc: Add support of JTAG
Message-ID: <20200721195231.GA1227776@xps15>
References: <20200713132927.24925-1-abailon@baylibre.com>
 <20200713132927.24925-4-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713132927.24925-4-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:29:24PM +0200, Alexandre Bailon wrote:
> The DSP could be debugged using JTAG.
> The support of JTAG could enabled at build time and it could be enabled
> using debugfs.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/remoteproc/Kconfig         |   9 ++
>  drivers/remoteproc/mtk_apu_rproc.c | 156 ++++++++++++++++++++++++++++-
>  2 files changed, 162 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index e116d4a12ac3..e1158563e2e8 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -52,6 +52,15 @@ config MTK_APU
>  
>  	  It's safe to say N here.
>  
> +config MTK_APU_JTAG
> +	bool "Enable support of JTAG"
> +	depends on MTK_APU
> +	help
> +	  Say y to enable support of JTAG.
> +	  By default, JTAG will remain disabled until it is enabled using
> +	  debugfs: remoteproc/remoteproc0/jtag. Write 1 to enable it and
> +	  0 to disable it.
> +
>  config OMAP_REMOTEPROC
>  	tristate "OMAP remoteproc support"
>  	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
> diff --git a/drivers/remoteproc/mtk_apu_rproc.c b/drivers/remoteproc/mtk_apu_rproc.c
> index fb416a817ef3..f2342b747a35 100644
> --- a/drivers/remoteproc/mtk_apu_rproc.c
> +++ b/drivers/remoteproc/mtk_apu_rproc.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -14,6 +15,7 @@
>  #include <linux/highmem.h>
>  #include <linux/module.h>
>  #include <linux/of_reserved_mem.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  
> @@ -48,6 +50,11 @@
>  #define CORE_DEFAULT1				(0x00000140)
>  #define  CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU	(0x10 << 0)
>  #define  CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU	(0x10 << 5)
> +#define CORE_DEFAULT2				(0x00000144)
> +#define CORE_DEFAULT2_DBG_EN			BIT(3)
> +#define CORE_DEFAULT2_NIDEN			BIT(2)
> +#define CORE_DEFAULT2_SPNIDEN			BIT(1)
> +#define CORE_DEFAULT2_SPIDEN			BIT(0)
>  #define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
>  
>  struct mtk_vpu_rproc {
> @@ -59,6 +66,13 @@ struct mtk_vpu_rproc {
>  	struct clk *axi;
>  	struct clk *ipu;
>  	struct clk *jtag;
> +
> +#ifdef CONFIG_MTK_APU_JTAG
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_default;
> +	struct pinctrl_state *pinctrl_jtag;
> +	bool jtag_enabled;
> +#endif
>  };
>  
>  static u32 vpu_read32(struct mtk_vpu_rproc *vpu_rproc, u32 off)
> @@ -149,6 +163,133 @@ static irqreturn_t handle_event(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_MTK_APU_JTAG
> +
> +static int vpu_enable_jtag(struct mtk_vpu_rproc *vpu_rproc)
> +{
> +	int ret = 0;
> +
> +	if (vpu_rproc->jtag_enabled)
> +		return -EINVAL;
> +
> +	ret = pinctrl_select_state(vpu_rproc->pinctrl,
> +				   vpu_rproc->pinctrl_jtag);
> +	if (ret < 0) {
> +		dev_err(vpu_rproc->dev, "Failed to configure pins for JTAG\n");
> +		return ret;
> +	}
> +
> +	vpu_write32(vpu_rproc, CORE_DEFAULT2,
> +		    CORE_DEFAULT2_SPNIDEN | CORE_DEFAULT2_SPIDEN |
> +		    CORE_DEFAULT2_NIDEN | CORE_DEFAULT2_DBG_EN);
> +
> +	vpu_rproc->jtag_enabled = 1;

There should be mutex that gets taken at the beginning and released at the end of
this function.

> +
> +	return ret;
> +}
> +
> +static int vpu_disable_jtag(struct mtk_vpu_rproc *vpu_rproc)
> +{
> +	int ret = 0;
> +
> +	if (!vpu_rproc->jtag_enabled)
> +		return -EINVAL;
> +
> +	vpu_write32(vpu_rproc, CORE_DEFAULT2, 0);
> +
> +	ret = pinctrl_select_state(vpu_rproc->pinctrl,
> +				   vpu_rproc->pinctrl_default);
> +	if (ret < 0) {
> +		dev_err(vpu_rproc->dev,
> +			"Failed to configure pins to default\n");
> +		return ret;
> +	}
> +
> +	vpu_rproc->jtag_enabled = 0;

Same comment as above.

> +
> +	return ret;
> +}
> +
> +static ssize_t rproc_jtag_read(struct file *filp, char __user *userbuf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	struct mtk_vpu_rproc *vpu_rproc = (struct mtk_vpu_rproc *)rproc->priv;
> +	char *buf = vpu_rproc->jtag_enabled ? "enabled\n" : "disabled\n";
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
> +}
> +
> +static ssize_t rproc_jtag_write(struct file *filp, const char __user *user_buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	struct mtk_vpu_rproc *vpu_rproc = (struct mtk_vpu_rproc *)rproc->priv;
> +	char buf[10];
> +	int ret;
> +
> +	if (count < 1 || count > sizeof(buf))
> +		return -EINVAL;
> +
> +	ret = copy_from_user(buf, user_buf, count);
> +	if (ret)
> +		return -EFAULT;
> +
> +	/* remove end of line */
> +	if (buf[count - 1] == '\n')
> +		buf[count - 1] = '\0';
> +
> +	if (!strncmp(buf, "1", count) || !strncmp(buf, "enabled", count))
> +		ret = vpu_enable_jtag(vpu_rproc);
> +	else if (!strncmp(buf, "0", count) || !strncmp(buf, "disabled", count))
> +		ret = vpu_disable_jtag(vpu_rproc);
> +	else
> +		return -EINVAL;

I think we should simply stick with "enabled" and "disabled" to be in line with
what is done in rproc_recovery_write().

> +
> +	return ret ? ret : count;
> +}
> +
> +static const struct file_operations rproc_jtag_ops = {
> +	.read = rproc_jtag_read,
> +	.write = rproc_jtag_write,
> +	.open = simple_open,
> +};
> +
> +static int vpu_jtag_probe(struct mtk_vpu_rproc *vpu_rproc)
> +{
> +	int ret;
> +
> +	if (!vpu_rproc->rproc->dbg_dir)
> +		return -ENODEV;
> +
> +	vpu_rproc->pinctrl = devm_pinctrl_get(vpu_rproc->dev);
> +	if (IS_ERR(vpu_rproc->pinctrl)) {
> +		dev_warn(vpu_rproc->dev, "Failed to find JTAG pinctrl\n");
> +		return PTR_ERR(vpu_rproc->pinctrl);
> +	}
> +
> +	vpu_rproc->pinctrl_default = pinctrl_lookup_state(vpu_rproc->pinctrl,
> +							PINCTRL_STATE_DEFAULT);

Indentation problem.

> +	if (IS_ERR(vpu_rproc->pinctrl_default))
> +		return PTR_ERR(vpu_rproc->pinctrl_default);
> +
> +	vpu_rproc->pinctrl_jtag = pinctrl_lookup_state(vpu_rproc->pinctrl,
> +						       "jtag");
> +	if (IS_ERR(vpu_rproc->pinctrl_jtag))
> +		return PTR_ERR(vpu_rproc->pinctrl_jtag);
> +
> +	ret = pinctrl_select_state(vpu_rproc->pinctrl,
> +				   vpu_rproc->pinctrl_default);

What is the default configuration for?  It does not seem to be needed to
properly boot the remote processor since it is not part of the example in the
bindings or dts patch included in this set.   Moreover it is part of a
configuration option so I really don't understand what it does.



> +	if (ret < 0)
> +		return ret;
> +
> +	debugfs_create_file("jtag", 0600, vpu_rproc->rproc->dbg_dir,
> +			    vpu_rproc->rproc, &rproc_jtag_ops);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_MTK_APU_JTAG */
> +
>  static int mtk_vpu_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -228,16 +369,16 @@ static int mtk_vpu_rproc_probe(struct platform_device *pdev)
>  		goto clk_disable_ipu;
>  	}
>  
> -	vpu_rproc->jtag = devm_clk_get_optional(dev, "jtag");
> +	vpu_rproc->jtag = devm_clk_get(vpu_rproc->dev, "jtag");

As I remarked in my comments on the previous patch, this should have been
devm_clk_get() from the start.  Either that or the bindings are wrong.

>  	if (IS_ERR(vpu_rproc->jtag)) {
> -		dev_err(dev, "Failed to enable jtag clock\n");
> +		dev_err(vpu_rproc->dev, "Failed to get jtag clock\n");

Why go from dev to vpu_rproc->dev?

>  		ret = PTR_ERR(vpu_rproc->jtag);
>  		goto clk_disable_axi;
>  	}
>  
>  	ret = clk_prepare_enable(vpu_rproc->jtag);
>  	if (ret) {
> -		dev_err(dev, "Failed to enable jtag clock\n");
> +		dev_err(vpu_rproc->dev, "Failed to enable jtag clock\n");

Same here.

>  		goto clk_disable_axi;
>  	}
>  
> @@ -253,6 +394,12 @@ static int mtk_vpu_rproc_probe(struct platform_device *pdev)
>  		goto free_mem;
>  	}
>  
> +#ifdef CONFIG_MTK_APU_JTAG
> +	ret = vpu_jtag_probe(vpu_rproc);
> +	if (ret)
> +		dev_warn(dev, "Failed to configure jtag\n");
> +#endif

Please don't use #ifdefs in the code like that.  It is better to introduce a
#else (above) with stubs that don't do anything.  

> +
>  	return 0;
>  
>  free_mem:
> @@ -277,6 +424,9 @@ static int mtk_vpu_rproc_remove(struct platform_device *pdev)
>  
>  	disable_irq(vpu_rproc->irq);
>  
> +#ifdef CONFIG_MTK_APU_JTAG
> +	vpu_disable_jtag(vpu_rproc);
> +#endif
>  	rproc_del(rproc);
>  	of_reserved_mem_device_release(dev);
>  	clk_disable_unprepare(vpu_rproc->jtag);
> -- 
> 2.26.2
> 
