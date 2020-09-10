Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FCFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C46206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBGwJrY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgIJXAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgIJXAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:00:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E47C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:00:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so5134721pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AEJBmoX8WsfyyVQZBwLDrC1Z1HfJ9zE1C+dj3rnnLIA=;
        b=QBGwJrY226Z2o5SR7+/ZaEJqS00GKWQY5BKwSDFCSxgV7VBDWfvP0IzhD6bQkcfbvQ
         n5AhvvNI1zc7+yi7+k8O3/331t8W2e7zPfNgtJQ3gRPNPzdl2C0YO4Ad8Woj9sadt+Yh
         wZewRr7qJvofHUUEj9yW60BCenG37z02ElHuJBHKcESbEwPRA50yT2/u8pjpT4DWMaOp
         e4jTXqTzf+le1cai3EdqtuJhebsq6KHSTxYnh8JGD5VAcIF0sWnxtTWl78EyS+XC3JvE
         kFp3eXqCZjdWuWVdT9xTzK1/Am3AkHqKzZUzWOYGYGWBog6YRxtMIDBWQqc6v1YktMDl
         g7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AEJBmoX8WsfyyVQZBwLDrC1Z1HfJ9zE1C+dj3rnnLIA=;
        b=tkPsaFDC9f13vrHBf5OLSMcFQayJ06ZUiv7JPt25gsSloNYCwaoRtWUpAHY3HdjHJm
         US6Vywo71B2ML+Qa/7pkR/R/Q3471lgK/nfs22jLUuWnph1ZKsntzXHACN/3cyRBSJqy
         C8y91vS3AYpPSPcJk4ZK2z4fe29sPeeSTL1fQyQvXd/PqPYQJ0Frq3ql+vBNeFsS3+ZH
         FNt25WmlA4Nin3aU0zTd8/2FVP8b8QE1IrbF+usFGwDQu+nzwesogLFkl+Xhcrs9xB21
         WoVfPCeUignLwcXlbbjtsE0uUkBA8VJP3TXC0P5FA8zKb4I4+X0soAEAoKNEO8YQTnh+
         u8KQ==
X-Gm-Message-State: AOAM530V3VyJb7+Vkmjk26j3Bt7XkVGTVA7B9zLh42u8L/X5EZcM5stc
        ZUvqTxPLOjpnofsoLIQRjLUhOA==
X-Google-Smtp-Source: ABdhPJzNBLPVWj1zi8MRD98x0w6/LGAgHbOrzn9dJrEC77bm4p349/phdk9vOTEIZTR4dZ1bJwyE3Q==
X-Received: by 2002:a63:384b:: with SMTP id h11mr6430377pgn.113.1599778845655;
        Thu, 10 Sep 2020 16:00:45 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t20sm70364pgj.27.2020.09.10.16.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:00:45 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:00:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 18/24] coresight: cti: Fix bug clearing sysfs links
 on callback
Message-ID: <20200910230043.GD590446@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-19-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034445.967-19-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:44:39AM +0800, Tingwei Zhang wrote:
> From: Mike Leach <mike.leach@linaro.org>
> 
> During module unload, a coresight driver module will call back into
> the CTI driver to remove any links between the two devices.
> 
> The current code has 2 issues:-
> 1) in the CTI driver the matching code is matching to the wrong device
> so misses all the links.
> 2) The callback is called too late in the unload process resulting in a
> crash.
> 
> This fixes both the issues.
> 
> Fixes: 177af8285b59 ("coresight: cti: Enable CTI associated with devices")
> Reported-by: Tingwei Zhang <tingwei@codeaurora.org>
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  drivers/hwtracing/coresight/coresight-cti.c | 2 +-
>  drivers/hwtracing/coresight/coresight.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 73304374a155..ec286d617b73 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -608,7 +608,7 @@ static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
>  		ctidrv = csdev_to_cti_drvdata(csdev->ect_dev);
>  		ctidev = &ctidrv->ctidev;
>  		list_for_each_entry(tc, &ctidev->trig_cons, node) {
> -			if (tc->con_dev == csdev->ect_dev) {
> +			if (tc->con_dev == csdev) {
>  				cti_remove_sysfs_link(ctidrv, tc);
>  				tc->con_dev = NULL;
>  				break;
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index c2174fed263b..6c09be15d60c 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1254,8 +1254,6 @@ static void coresight_device_release(struct device *dev)
>  {
>  	struct coresight_device *csdev = to_coresight_device(dev);
>  
> -	if (cti_assoc_ops && cti_assoc_ops->remove)
> -		cti_assoc_ops->remove(csdev);
>  	fwnode_handle_put(csdev->dev.fwnode);
>  	kfree(csdev->refcnt);
>  	kfree(csdev);
> @@ -1590,6 +1588,8 @@ void coresight_unregister(struct coresight_device *csdev)
>  {
>  	etm_perf_del_symlink_sink(csdev);
>  	/* Remove references of that device in the topology */
> +	if (cti_assoc_ops && cti_assoc_ops->remove)
> +		cti_assoc_ops->remove(csdev);
>  	coresight_remove_conns(csdev);
>  	coresight_clear_default_sink(csdev);
>  	coresight_release_platform_data(csdev, csdev->pdata);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
