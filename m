Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDE3C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9F9206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gs45V7ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898295AbgDOSLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406366AbgDOSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:11:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BD9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:11:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b72so333732pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hv4Gb+XU8mOj8xMFdipxFcMjlc532U8U6KOUpsFhxqY=;
        b=Gs45V7acM1Gg+IDEQIa8efTGGg+FVai47wUYfRNm7sgC8M3235Wdfd627OlVlKHree
         G/JPIqjAQoOF8XLyehNauDN4H23NKVUyIa4c6e++RGuOQusJlK5JVxRWbw3QRuUGoJqO
         TaD/89qJ+j7tYxgDCu/WtVuv5G/ZLBCfX9gl+AgCJXpWsj6YuJ4VaeuSXBhTKmAO2OF8
         i/i5RsHx4X/GnRoq77MHKt2Ec/hYDX2QbLJFxEcAkm3pUQ/j8effzI8hR3pvnsPIcAWX
         Azhy1QdjR5nkInSATS1UlDa1H4dG83YYu8+8hdn/wBWZeCVW5myrBWGYSUoyIhqYnw3g
         qmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hv4Gb+XU8mOj8xMFdipxFcMjlc532U8U6KOUpsFhxqY=;
        b=XASczk4o+e4SkC9IgETU8Wbw5aJLW+wrXMEIriu2pRBclygc3/D5GduGLqp6C32YiS
         h8NUewp9bHYZZcpAtWmNIH6XmDnaF7JfhdMi+XP0gfe5Ptf5kE5NEdx59l34dYZeKZ6X
         vR3QmiDnfBSQSACkCZzkaT4fjE1tLG2rzq6ggoZf9eJTMEwoeRJZoy9aul8bqE0++oIr
         hvengndFyk9lBFbyn3b8MaZW9zrAkZOHwsjs1LQZTrOsK0kixZ758vbTIJHOEMXbg8JA
         OyhaimLNAYtS0mLeP8XoLbNnKiT7JG0ruTJ37Xd6STY3bF2s7plnPMor//OotKlK84f7
         pYng==
X-Gm-Message-State: AGi0PuZgmzje4C2t0Tu6sJAovkcK/1r5DghLzBOSsiRBvlKxLxZAWE5Y
        f5JyoiNcfE4LqzA9GC8EY/mmWA==
X-Google-Smtp-Source: APiQypIjo5joNUHWhj8LYjKyMfT+ubnd1PrqS6lJmTvfS1amP7RXRU6Uzmg8PU7h9tURc3cv4RxdgQ==
X-Received: by 2002:aa7:9625:: with SMTP id r5mr7532605pfg.256.1586974302516;
        Wed, 15 Apr 2020 11:11:42 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 65sm9606185pfz.211.2020.04.15.11.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:11:42 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:11:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org
Subject: Re: [PATCH v2 4/6] remoteproc: qcom: Add name field for every
 subdevice
Message-ID: <20200415181140.GF16583@xps15>
References: <1586389003-26675-1-git-send-email-sidgup@codeaurora.org>
 <1586389003-26675-5-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586389003-26675-5-git-send-email-sidgup@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 04:36:41PM -0700, Siddharth Gupta wrote:
> From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> 
> When a client driver wishes to utilize functionality from a particular
> subdevice of a remoteproc, it cannot differentiate between the subdevices
> that have been added. This patch allows the client driver to distinguish
> between subdevices and thus utilize their functionality.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  drivers/remoteproc/qcom_common.c | 6 ++++++
>  include/linux/remoteproc.h       | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 60650bc..1d2351b 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -56,6 +56,7 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink)
>  		return;
>  
>  	glink->dev = dev;
> +	glink->subdev.name = kstrdup("glink", GFP_KERNEL);
>  	glink->subdev.start = glink_subdev_start;
>  	glink->subdev.stop = glink_subdev_stop;
>  
> @@ -73,6 +74,7 @@ void qcom_remove_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glin
>  	if (!glink->node)
>  		return;
>  
> +	kfree(glink->subdev.name);
>  	rproc_remove_subdev(rproc, &glink->subdev);
>  	of_node_put(glink->node);
>  }
> @@ -152,6 +154,7 @@ void qcom_add_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
>  		return;
>  
>  	smd->dev = dev;
> +	smd->subdev.name = kstrdup("smd", GFP_KERNEL);
>  	smd->subdev.start = smd_subdev_start;
>  	smd->subdev.stop = smd_subdev_stop;
>  
> @@ -169,6 +172,7 @@ void qcom_remove_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
>  	if (!smd->node)
>  		return;
>  
> +	kfree(smd->subdev.name);
>  	rproc_remove_subdev(rproc, &smd->subdev);
>  	of_node_put(smd->node);
>  }
> @@ -220,6 +224,7 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
>  			 const char *ssr_name)
>  {
>  	ssr->name = ssr_name;
> +	ssr->subdev.name = kstrdup("ssr_notifs", GFP_KERNEL);
>  	ssr->subdev.unprepare = ssr_notify_unprepare;
>  
>  	rproc_add_subdev(rproc, &ssr->subdev);
> @@ -233,6 +238,7 @@ EXPORT_SYMBOL_GPL(qcom_add_ssr_subdev);
>   */
>  void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
>  {
> +	kfree(ssr->subdev.name);
>  	rproc_remove_subdev(rproc, &ssr->subdev);
>  }
>  EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index c5d36e6..687e1eb 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -523,6 +523,7 @@ struct rproc {
>  /**
>   * struct rproc_subdev - subdevice tied to a remoteproc
>   * @node: list node related to the rproc subdevs list
> + * @name: name of the subdevice
>   * @prepare: prepare function, called before the rproc is started
>   * @start: start function, called after the rproc has been started
>   * @stop: stop function, called before the rproc is stopped; the @crashed
> @@ -531,6 +532,7 @@ struct rproc {
>   */
>  struct rproc_subdev {
>  	struct list_head node;
> +	char *name;
>  
>  	int (*prepare)(struct rproc_subdev *subdev);
>  	int (*start)(struct rproc_subdev *subdev);
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
