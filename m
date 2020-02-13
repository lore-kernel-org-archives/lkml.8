Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17242C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF74B217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Of24hL8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgBMUIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:08:19 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39815 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgBMUIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:08:18 -0500
Received: by mail-yb1-f196.google.com with SMTP id l75so3602065ybf.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJxkwq8/D+o8z2hOcO4GUN34L77pUJGhVsXqvKjTQDQ=;
        b=Of24hL8aXheNsVDZUzZ55pcCK7OV3KGqYupe+ZmKgcaybTpcTuLLCFOBzep889PXDx
         J+eAybQltBvRNx+rC00KxKZ6Y43l2FU3nKu+C/RnUCK3ddDYM9vVTy+bMBkWpY5vu5WF
         QlfAxAfK47jlmX+uMTeg2ejqopLS8w++OdbPVQA9N6DBNmm9LTfnm+opqtV/Qo8c6X0k
         HAwlNxDZOg9MuRnC6QClbINsPO6ujRAyIEGWd7jUkv7Ts3JOuFGo5OjdfXRPEvaZ0gau
         4adIDoTsbq5Si9VYH0hwR723QfUMHdk8RNUp6oH6SKMhjMMdUNhtQrq2loUk0lhPOAVZ
         RJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJxkwq8/D+o8z2hOcO4GUN34L77pUJGhVsXqvKjTQDQ=;
        b=N7pHGITNpxwljLOgL4tTq9UHKG3MFYT20mimxDBw+vh+oIWh5eBKXblakJF3Hl7Qt5
         R/Eagb3cObevtHlFW84hFfuq21KXRq3WR7Y2yuxY7th6bYO3MTHr8S0qhL0/0skVFCPR
         RpC9IZN94ELPCRwrVHzv1dfTgX0Bm5HLbHiTrQfJQkXVSupt16y+0wMfy7cYy4btz70L
         FXdq9XHTjJdFyb30zsUO+RevAoFv/19SYtfyddiRejZeZFiZhR9DHkZCey6Wn7PlnQgf
         Dy78GzIHvxmNgtCfzDIjVFIDujqF/xMcUO0yx61gjSNNR9jwDq/QxAcxIEQln2t0OpPs
         yHag==
X-Gm-Message-State: APjAAAXcA9ihiwfQ8rj3qIVMe6t4XCI7ae5hFQ15GfDOyR/r2dsXzzov
        XeSREaKKwAFdU3AWiXTodfxHMQ==
X-Google-Smtp-Source: APXvYqwlrZYVi0V2hI3T0AESbnztZSJUg9sdbeYCbuUGNhwLIhR6i/8KC0vw9CwxnN8O7tJmwxSwVg==
X-Received: by 2002:a25:d9cc:: with SMTP id q195mr8640124ybg.126.1581624497107;
        Thu, 13 Feb 2020 12:08:17 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w132sm1424354ywc.51.2020.02.13.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:08:16 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:08:13 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 1/3] remoteproc: add support for co-processor loaded
 and booted before kernel
Message-ID: <20200213200813.GA14415@xps15>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-2-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211174205.22247-2-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

On Tue, Feb 11, 2020 at 06:42:03PM +0100, Arnaud Pouliquen wrote:
> From: Loic Pallardy <loic.pallardy@st.com>
> 
> Remote processor could boot independently or be loaded/started before
> Linux kernel by bootloader or any firmware.
> This patch introduces a new property in rproc core, named skip_fw_load,
> to be able to allocate resources and sub-devices like vdev and to
> synchronize with current state without loading firmware from file system.
> It is platform driver responsibility to implement the right firmware
> load ops according to HW specificities.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++------
>  include/linux/remoteproc.h           |  2 +
>  2 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 097f33e4f1f3..876b5420a32b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1358,8 +1358,19 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> -/*
> - * take a firmware and boot a remote processor with it.
> +/**
> + * rproc_fw_boot() - boot specified remote processor according to specified
> + * firmware
> + * @rproc: handle of a remote processor
> + * @fw: pointer on firmware to handle
> + *
> + * Handle resources defined in resource table, load firmware and
> + * start remote processor.
> + *
> + * If firmware pointer fw is NULL, firmware is not handled by remoteproc
> + * core, but under the responsibility of platform driver.
> + *
> + * Returns 0 on success, and an appropriate error value otherwise.
>   */
>  static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  {
> @@ -1371,7 +1382,11 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	if (ret)
>  		return ret;
>  
> -	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> +	if (fw)
> +		dev_info(dev, "Booting fw image %s, size %zd\n", name,
> +			 fw->size);
> +	else
> +		dev_info(dev, "Synchronizing with preloaded co-processor\n");
>  
>  	/*
>  	 * if enabling an IOMMU isn't relevant for this rproc, this is
> @@ -1718,16 +1733,22 @@ static void rproc_crash_handler_work(struct work_struct *work)
>   * rproc_boot() - boot a remote processor
>   * @rproc: handle of a remote processor
>   *
> - * Boot a remote processor (i.e. load its firmware, power it on, ...).
> + * Boot a remote processor (i.e. load its firmware, power it on, ...) from
> + * different contexts:
> + * - power off
> + * - preloaded firmware
> + * - started before kernel execution
> + * The different operations are selected thanks to properties defined by
> + * platform driver.
>   *
> - * If the remote processor is already powered on, this function immediately
> - * returns (successfully).
> + * If the remote processor is already powered on at rproc level, this function
> + * immediately returns (successfully).
>   *
>   * Returns 0 on success, and an appropriate error value otherwise.
>   */
>  int rproc_boot(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
> +	const struct firmware *firmware_p = NULL;
>  	struct device *dev;
>  	int ret;
>  
> @@ -1758,11 +1779,20 @@ int rproc_boot(struct rproc *rproc)
>  
>  	dev_info(dev, "powering up %s\n", rproc->name);
>  
> -	/* load firmware */
> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto downref_rproc;
> +	if (!rproc->skip_fw_load) {
> +		/* load firmware */
> +		ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +		if (ret < 0) {
> +			dev_err(dev, "request_firmware failed: %d\n", ret);
> +			goto downref_rproc;
> +		}
> +	} else {
> +		/*
> +		 * Set firmware name pointer to null as remoteproc core is not
> +		 * in charge of firmware loading
> +		 */
> +		kfree(rproc->firmware);
> +		rproc->firmware = NULL;

If the MCU with pre-loaded FW crashes request_firmware() in
rproc_trigger_recovery() will return an error and rproc_start()
never called.

>  	}
>  
>  	ret = rproc_fw_boot(rproc, firmware_p);
> @@ -1916,8 +1946,17 @@ int rproc_add(struct rproc *rproc)
>  	/* create debugfs entries */
>  	rproc_create_debug_dir(rproc);
>  
> -	/* if rproc is marked always-on, request it to boot */
> -	if (rproc->auto_boot) {
> +	if (rproc->skip_fw_load) {
> +		/*
> +		 * If rproc is marked already booted, no need to wait
> +		 * for firmware.
> +		 * Just handle associated resources and start sub devices
> +		 */
> +		ret = rproc_boot(rproc);
> +		if (ret < 0)
> +			return ret;
> +	} else if (rproc->auto_boot) {
> +		/* if rproc is marked always-on, request it to boot */

I spent way too much time staring at this modification...  I can't decide if a
system where the FW has been pre-loaded should be considered "auto_boot".
Indeed the result is the same, i.e the MCU is started at boot time without user
intervention.

I'd welcome other people's opinion on this.

>  		ret = rproc_trigger_auto_boot(rproc);
>  		if (ret < 0)
>  			return ret;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad66683ad0..4fd5bedab4fa 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -479,6 +479,7 @@ struct rproc_dump_segment {
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
> + * @skip_fw_load: remote processor has been preloaded before start sequence
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   */
> @@ -512,6 +513,7 @@ struct rproc {
>  	size_t table_sz;
>  	bool has_iommu;
>  	bool auto_boot;
> +	bool skip_fw_load;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  };
> -- 
> 2.17.1
> 
