Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB647C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC98F20719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcItzKpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgHaWNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHaWNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:13:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44588C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:13:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so1514042pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OsB0+xID7oLnByPKGikaL5GpMK2tq4cGfEM+JfvYOfA=;
        b=rcItzKpJ6kGcusDrjj5tEjrcPDpKZJuKNC3qVbn+huXNj0hprkL4hzkw//gQUghe/+
         QrE42Bdxd+tkNp2j/hJTGP4AKVHVeEdPTckoxVKENYZ/WNtxrLWZrklvpaCPG1ShWeq5
         CTm5OBw1kYHEZionMh6FPIMcxUqXhI7FZTtBold/uQfcFfTapiSvOfYo8i6uDR6HT/Yc
         M89D2Wn5FjxfvYzRo6cILSz9K9zOWir0QZsy6PIIKl9s+CYZDd8SXUka9H8HLBqLgiCg
         8srDQRAeHY7INlYI8KixSU0kVcgs7RI2KL0NhA2XoWSvUlKEeYb5ExdN5ZiO3hiF6pKU
         jlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OsB0+xID7oLnByPKGikaL5GpMK2tq4cGfEM+JfvYOfA=;
        b=tKJ/i6kMO1yNduAKJeyLCmMQBT8/rB5EjRab/gs5mwVAYy+dbtt1tdtg7oJjzBfJxv
         JApylUlEGF9WK0TFfiN1Z4JgPigb/s9cNVsIHF/skaNGlM+5g9Gs5mUXkKWe31zOXd3b
         N7Tic0LSHEP1OUKA7c5hsVrZK4OrFUBCP8hDcktSrfaQrqkQ6DWL8zhUjNNr9rbQu5ec
         WkaBv4C/2RmvzFgSA9Hz4s5g461vGVTsZg9oemt39Z/ciGEWRU/hdpvzfnNGJaQ22gwf
         qFF87GtMAOVUvnuvZw8Qf2lVaGcG960fxYFAvt4J9m5hhNgIXonI3pyujsOWedgRjUA3
         7gnw==
X-Gm-Message-State: AOAM532hrLzwmEr4dHbXvXuLWEl/cFOv5Rr7UZ8UL+qG/IS793hc0JkH
        bLn7rVbj8hkDgKMRlGzaQecrow==
X-Google-Smtp-Source: ABdhPJwG0rvhgiFa0CN73SSPorANwv6KsspHeQ6jNuuGKBjibSw0NduJgGDQ904RduL9W+4nVunm8Q==
X-Received: by 2002:a65:4787:: with SMTP id e7mr2648696pgs.402.1598911990583;
        Mon, 31 Aug 2020 15:13:10 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h65sm9245245pfb.210.2020.08.31.15.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 15:13:10 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:13:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
Message-ID: <20200831221308.GB207013@xps15>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following Al's comment I have the following recommendations...

On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
> When too much trace information is generated on-chip, the ETM will
> overflow, and cause data loss. This is a common phenomenon on ETM
> devices.
> 
> But sometimes we do not want to lose performance trace data, so we
> suppress the speed of instructions sent from CPU core to ETM to
> avoid the overflow of ETM.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
> 
> Changes since v1:
> - ETM on HiSilicon Hip09 platform supports backpressure, so does
> not need to modify core commit.
> 
>  drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 7797a57..7641f89 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
>  #define PARAM_PM_SAVE_NEVER	  1 /* never save any state */
>  #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
> 
> +#define CORE_COMMIT_CLEAR	0x3000
> +#define CORE_COMMIT_SHIFT	12
> +#define HISI_ETM_AMBA_ID_V1	0x000b6d01

Do you have a name for the SoC that can be added so that other HiSilicon SoC can
be added?  I suggest something like:

#define HISI_NAME_CORE_COMMIT_CLEAR
#define HISI_NAME_CORE_COMMIT_SHIFT
#define HISI_NAME_ETM_ID

Moreover I don't see an entry for 0x000b6d01 in the amba id table - is your
devices upstream?  Needless to day that is mandatory in order to move forward
with this work.

> +
>  static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
>  module_param(pm_save_enable, int, 0444);
>  MODULE_PARM_DESC(pm_save_enable,
> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
>  	int rc;
>  };
> 
> +static void etm4_cpu_actlr1_cfg(void *info)
> +{
> +	struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
> +	u64 val;
> +
> +	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
> +	val &= ~CORE_COMMIT_CLEAR;
> +	val |= arg->rc << CORE_COMMIT_SHIFT;
> +	asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
> +}
> +
> +static void etm4_config_core_commit(int cpu, int val)
> +{
> +	struct etm4_enable_arg arg = {0};
> +
> +	arg.rc = val;
> +	smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
> +}
> +
>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  {
>  	int i, rc;
> +	struct amba_device *adev;
>  	struct etmv4_config *config = &drvdata->config;
>  	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct device *dev = drvdata->csdev->dev.parent;
> +
> +	adev = container_of(dev, struct amba_device, dev);
> +	/*
> +	 * If ETM device is HiSilicon ETM device, reduce the
> +	 * core-commit to avoid ETM overflow.
> +	 */
> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> +		etm4_config_core_commit(drvdata->cpu, 1);

I susggest to add a function like etm4_enable_arch_specific() and do the above
in there.  The same goes for the disable path.

Thanks,
Mathieu

> 
>  	CS_UNLOCK(drvdata->base);
> 
> @@ -472,10 +505,20 @@ static void etm4_disable_hw(void *info)
>  {
>  	u32 control;
>  	struct etmv4_drvdata *drvdata = info;
> +	struct device *dev = drvdata->csdev->dev.parent;
>  	struct etmv4_config *config = &drvdata->config;
>  	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct amba_device *adev;
>  	int i;
> 
> +	adev = container_of(dev, struct amba_device, dev);
> +	/*
> +	 * If ETM device is HiSilicon ETM device, resume the
> +	 * core-commit after ETM trace is complete.
> +	 */
> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> +		etm4_config_core_commit(drvdata->cpu, 0);
> +
>  	CS_UNLOCK(drvdata->base);
> 
>  	if (!drvdata->skip_power_up) {
> --
> 2.8.1
> 
