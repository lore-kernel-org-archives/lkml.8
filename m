Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C06C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1CC2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixKbXKSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGQF53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGQF52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:57:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB90C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:57:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so5872429pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6BvaYxlPaEzfbJxa7HeuVPOR6VcjT21nlFS9PSH5TvY=;
        b=ixKbXKSFOHjOPR5hwIwoLZlmyj8nlkDWC0XqQvRTvknrrJkDVs+Lhkz6jL5AYf/a64
         ddbFr2jR2VZBmjQhQK+yPYBkdXD20xPcvZy5MRMk1dfICI7O/TFRDBcjvmYmlKv/duOx
         B3zxAeYVXYUiI334WSPlCcjZy0SI8cliDTICbwesLrW4K3RkbUgzNvp2EQEJ6crWPREK
         +iYikWvc1moQx8V5/V1TkQ4/g3L+ky9hV77KROebd0qdlhM9LFpV/j+p7MmdUIE7HNFY
         Vzqw7Jwhn/wCaZ2rkqoJojALJK7Y4LYt4wycorX89P6ng2B/Ae4b9Ssyh/C51M8iI5lN
         cXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6BvaYxlPaEzfbJxa7HeuVPOR6VcjT21nlFS9PSH5TvY=;
        b=UVJelVZEo24kPqBv17iP3vqr9enX94ZXloGqXZ0+laE9ITAxQmx+OW+MbPjcLar7A+
         GcsSISRlO6uErLQgcrsKHX7XUb09nXMIhbi55kFqBFhXw1COiWnOdFTXCVs3LfmJMZv1
         0/sDrypFxnywA9Ch5zNlhl4TQYLS2fWXwmLKOExdhsiy7QhHiVscyteNnDzKrYQEH6Z7
         eLRDT2vkjazDWUpH5puY2zMRwqYeXbHYCM2jdtIgZ7CWgd5lvfrI5AiX8H0toFASP5ul
         EcLjL8wwDAwU4UxJFdc6kkLXrS+EZ1pOzYfVJCaDTjW9Vc6q8Q5yoe/ZqxvO6WXG+FBS
         1Lfg==
X-Gm-Message-State: AOAM532tQ/oMrdKb7w8IRe395IPacjQfH7R6G6zcdtcZsyPUfdt0ILTE
        1cUSSoDfq2mrL847OhBcUnUtpA==
X-Google-Smtp-Source: ABdhPJx8XQ92Qc9HsG8QCY1PkldZNJEIGF+DKt2D9fkveAABH6+YtbX5CR+44p+onSVlDGBhoMBf1g==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr6375510plm.72.1594965447854;
        Thu, 16 Jul 2020 22:57:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x7sm6220568pfq.197.2020.07.16.22.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 22:57:27 -0700 (PDT)
Date:   Thu, 16 Jul 2020 22:55:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] remoteproc: Properly handle firmware name when
 attaching
Message-ID: <20200717055525.GL2922385@builder.lan>
References: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
 <20200714195035.1426873-10-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714195035.1426873-10-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14 Jul 12:50 PDT 2020, Mathieu Poirier wrote:

> This patch prevents the firmware image name from being displayed when
> the remoteproc core is attaching to a remote processor. This is needed
> needed since there is no guarantee about the nature of the firmware
> image that is loaded by the external entity.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/remoteproc_core.c  | 18 ++++++++++++++++++
>  drivers/remoteproc/remoteproc_sysfs.c | 16 ++++++++++++++--
>  include/linux/remoteproc.h            |  2 ++
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 6b6e4ec8cf3a..099c76ab198f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1624,6 +1624,14 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  
>  	rproc->state = RPROC_OFFLINE;
>  
> +	/*
> +	 * The remote processor has been stopped and is now offline, which means
> +	 * that the next time it is brought back online the remoteproc core will
> +	 * be responsible to load its firmware.  As such it is no longer
> +	 * autonomous.
> +	 */
> +	rproc->autonomous = false;
> +
>  	dev_info(dev, "stopped remote processor %s\n", rproc->name);
>  
>  	return 0;
> @@ -2142,6 +2150,16 @@ int rproc_add(struct rproc *rproc)
>  	/* create debugfs entries */
>  	rproc_create_debug_dir(rproc);
>  
> +	/*
> +	 * Remind ourselves the remote processor has been attached to rather
> +	 * than booted by the remoteproc core.  This is important because the
> +	 * RPROC_DETACHED state will be lost as soon as the remote processor
> +	 * has been attached to.  Used in firmware_show() and reset in
> +	 * rproc_stop().
> +	 */
> +	if (rproc->state == RPROC_DETACHED)
> +		rproc->autonomous = true;
> +
>  	/* if rproc is marked always-on, request it to boot */
>  	if (rproc->auto_boot) {
>  		ret = rproc_trigger_auto_boot(rproc);
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 264759713934..eea514cec50e 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -15,8 +15,20 @@ static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
>  	struct rproc *rproc = to_rproc(dev);
> -
> -	return sprintf(buf, "%s\n", rproc->firmware);
> +	const char *firmware = rproc->firmware;
> +
> +	/*
> +	 * If the remote processor has been started by an external
> +	 * entity we have no idea of what image it is running.  As such
> +	 * simply display a generic string rather then rproc->firmware.
> +	 *
> +	 * Here we rely on the autonomous flag because a remote processor
> +	 * may have been attached to and currently in a running state.
> +	 */
> +	if (rproc->autonomous)
> +		firmware = "unknown";
> +
> +	return sprintf(buf, "%s\n", firmware);
>  }
>  
>  /* Change firmware name via sysfs */
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index bf6a310ba870..cf5e31556780 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -491,6 +491,7 @@ struct rproc_dump_segment {
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
> + * @autonomous: true if an external entity has booted the remote processor
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   */
> @@ -524,6 +525,7 @@ struct rproc {
>  	size_t table_sz;
>  	bool has_iommu;
>  	bool auto_boot;
> +	bool autonomous;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  	u8 elf_class;
> -- 
> 2.25.1
> 
