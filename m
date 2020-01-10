Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B4C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD7E2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0q6/1S+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgAJVXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:23:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43382 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAJVXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:23:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id p27so1304800pli.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VST9xLJ8WnLxxccbOuFlca0tJzmP4xh6QpIGCCsCQ1M=;
        b=C0q6/1S+66Udbo7b16QlqaOUBiiXfZJEXD/A7UQbu9o6ULFUyTZPlVw9L1EjIrNhJr
         0YdYz/Cezy8UdgHxeRfOmck7ZZy/ejXKcWtYnHSfVfrV+9hHVoXQEl96dm+s5mm2AHua
         soPbjtsPXohCZMOYYpXEGtpXgwVbvP8NkrdaciNAND3G8SCdaMQPyQYawiStu1iboaDF
         jW2Uha8Mn9QilVBwKXJuJr+J9pe1GdwCdJEbs9x2bbwoW8hneBUoyROpsMnvTHrQhDKu
         RzceI6f/45xe4nO/tINacflU7WNtL2bIBeWkBmr0vPPotUWoqFyVsq64Ff+escs6mWWv
         Vt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VST9xLJ8WnLxxccbOuFlca0tJzmP4xh6QpIGCCsCQ1M=;
        b=aYbQEzTlgIT/5067z4RNplS5j2iNnZDNaFeWyU89Lk5yqq/Aq4r/p1aiNaJgUMbaLX
         xD0qJbq+Dh1f9tWmpKJyT3ip9ciRpIlc/0Oh53JzyUZC8SRvybx501HFsdDAKO0RXObS
         EM1tQrPBHMFpcNScZA+aOSE8J0U4BqquhJunSPFfCUx4rpwPUOWU/2MsP1x4jJ41fv3H
         ln3EVTNWMH6y/B13uIlJwIMhOUEJ9m6gG9Up12rh1fGN9VD3BARcXeI4Ua4orfR4Z7Uq
         H/WyPYOM2NypfuO3DL3sOuUQxjU6cpiQK7SUCd3cxB+vYOwTdD240QiSxSFX3hpUUXrm
         nWqw==
X-Gm-Message-State: APjAAAVdntz3MeqYtNKeI4BgKKnZ24U4ltgjhzTPAPh8Eqss1H7ICE8W
        qsZ+iNGPT0Ku1JmQKP0z05pgOQ==
X-Google-Smtp-Source: APXvYqyohTo62l6sHxhZmJoPUXlZqFbswgZNCb+vVQd/xONNCazHsQ0Do7KLPCPNOHA/rE7z94OZ+Q==
X-Received: by 2002:a17:902:16a:: with SMTP id 97mr601827plb.163.1578691389688;
        Fri, 10 Jan 2020 13:23:09 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i68sm4207847pfe.173.2020.01.10.13.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:23:09 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:23:07 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v2 6/8] remoteproc: Introduce "panic" callback in ops
Message-ID: <20200110212307.GC11555@xps15>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
 <20191227053215.423811-7-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227053215.423811-7-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 09:32:13PM -0800, Bjorn Andersson wrote:
> Introduce a "panic" function in the remoteproc ops table, to allow
> remoteproc instances to perform operations needed in order to aid in
> post mortem system debugging, such as flushing caches etc, when the
> kernel panics.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - None
> 
>  drivers/remoteproc/remoteproc_core.c | 17 +++++++++++++++++
>  include/linux/remoteproc.h           |  4 ++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 307df98347ba..779f19d6d8e7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1832,6 +1832,17 @@ void rproc_shutdown(struct rproc *rproc)
>  }
>  EXPORT_SYMBOL(rproc_shutdown);
>  
> +static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
> +			       void *ptr)
> +{
> +	struct rproc *rproc = container_of(nb, struct rproc, panic_nb);
> +
> +	if (rproc->state == RPROC_RUNNING)
> +		rproc->ops->panic(rproc);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  /**
>   * rproc_get_by_phandle() - find a remote processor by phandle
>   * @phandle: phandle to the rproc
> @@ -2057,6 +2068,12 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  		rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
>  	}
>  
> +	/* Register panic notifier for remoteprocs with "panic" callback */
> +	if (rproc->ops->panic) {
> +		rproc->panic_nb.notifier_call = rproc_panic_handler;
> +		atomic_notifier_chain_register(&panic_notifier_list, &rproc->panic_nb);

Line over 80 characters.

> +	}
> +
>  	mutex_init(&rproc->lock);
>  
>  	idr_init(&rproc->notifyids);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad66683ad0..7836c528d309 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -369,6 +369,7 @@ enum rsc_handling_status {
>   *			expects to find it
>   * @sanity_check:	sanity check the fw image
>   * @get_boot_addr:	get boot address to entry point specified in firmware
> + * @panic:	optional callback to react to system panic
>   */
>  struct rproc_ops {
>  	int (*start)(struct rproc *rproc);
> @@ -383,6 +384,7 @@ struct rproc_ops {
>  	int (*load)(struct rproc *rproc, const struct firmware *fw);
>  	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
>  	u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
> +	void (*panic)(struct rproc *rproc);
>  };
>  
>  /**
> @@ -481,6 +483,7 @@ struct rproc_dump_segment {
>   * @auto_boot: flag to indicate if remote processor should be auto-started
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
> + * @panic_nb: notifier_block for remoteproc's panic handler
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -514,6 +517,7 @@ struct rproc {
>  	bool auto_boot;
>  	struct list_head dump_segments;
>  	int nb_vdev;
> +	struct notifier_block panic_nb;
>  };
>  
>  /**
> -- 
> 2.24.0
> 
