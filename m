Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4368AC55185
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF2320656
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySUaw2hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDWAxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbgDWAxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:53:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A9C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 17:53:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x26so1997724pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 17:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zaMslWpZYQE1cPZBGYasv3MNuzEHzc5rvrYAj1cFoUo=;
        b=ySUaw2hGK318opjQ7onBQV22y1HgRSTjLRyOzUlAEquw0O+gd8L1YWex6Qgpe+AdcQ
         46stp24stM2UJ92PQ1FL+2dS5s6HuekSdS3LbXGvEsAu2B/hI5BfLUeIHQn31LMgfChK
         AUGpnLVyyJUsDKwIe3p2HH2kw/bcJpJJ4lcCSTw32V5b/E5emMlu2UHA5w0d1O/M4Rkz
         fSt9z71hSkp0izZGC0kHNGEjs78AeWMHD2YZQ/zjXIKDt8FBHnLAkCiTs4wFE5lYQ6Do
         w5gxXcg6jH3F369W/tTqbYCcekwqbh5iK7F6O6BIoDiIJ068LnPJuieSQBQfSDmKNZhq
         UJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zaMslWpZYQE1cPZBGYasv3MNuzEHzc5rvrYAj1cFoUo=;
        b=Wx20Y5jlsVHhD+GuvFBX3JX61gAKVDoBJJuDyZjlYe7h2+if9dpLLc7KBHgA7kxGSE
         GqhUjjEm9HzaWaSRHigd4wytAqxx0nO5poUSEdpzwJgDHEQuW+dFtDw9PweDLs30ypdu
         H5htt6jBmyqZ9KZ2AsyHtQmw/o/AfYQA+41+u/JqSoiyiuW7DCz71UWKrA3zugmQyphA
         M634yPVaF9NCSSLuEklnhg4+EmlR3f4cb3zwxaTBnfHbZVV+cBG8xFJYJVmij0M9TVNK
         dmrECWHdhN88evDd1zxlrKqxT0CCYUbJuDGhekggShA7/U0afV3Pcq8YsDDXR/yr4cy/
         B6CQ==
X-Gm-Message-State: AGi0PuYt5yRuox7/idnx357TNktTM/s9zVsuix56QYmPxM+Mp/GFvGHy
        4Gm2/rlODjuzJvV5ltZXR6CFDg==
X-Google-Smtp-Source: APiQypJKqfkEySumffvFRj+2CM+bSCQ6VLwZF4WDXzR4yhTUrBP6wD8QX9LvzHwkW1lbKYzs+jBYEg==
X-Received: by 2002:aa7:9904:: with SMTP id z4mr1271870pff.38.1587603209814;
        Wed, 22 Apr 2020 17:53:29 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e7sm727392pfh.161.2020.04.22.17.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 17:53:29 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:53:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH v2 5/6] remoteproc: qcom: Add per subsystem SSR
 notification
Message-ID: <20200423005356.GL1868936@builder.lan>
References: <1586389003-26675-1-git-send-email-sidgup@codeaurora.org>
 <1586389003-26675-6-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586389003-26675-6-git-send-email-sidgup@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 Apr 16:36 PDT 2020, Siddharth Gupta wrote:

> Currently there is a global notification chain which is called whenever any
> remoteproc shuts down. This leads to all the listeners being notified, and
> is not an optimal design as kernel drivers might only be interested in
> listening to notifications from a particular remoteproc. Create an
> individual notifier chain for every SSR subdevice, and modify the
> notification registration API to include the remoteproc struct as an
> argument. Update the existing user of the registration API to get the
> phandle of the remoteproc dt node to register for SSR notifications.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_common.c      | 49 +++++++++++++++++++++++++++--------
>  drivers/remoteproc/qcom_common.h      |  1 +
>  drivers/soc/qcom/glink_ssr.c          | 20 ++++++++++++--
>  include/linux/remoteproc/qcom_rproc.h | 17 ++++++++----
>  4 files changed, 69 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 1d2351b..56b0c3e 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -23,8 +23,6 @@
>  #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
>  #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>  
> -static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
> -
>  static int glink_subdev_start(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
> @@ -180,27 +178,52 @@ EXPORT_SYMBOL_GPL(qcom_remove_smd_subdev);
>  
>  /**
>   * qcom_register_ssr_notifier() - register SSR notification handler
> + * @rproc:	pointer to the remoteproc structure
>   * @nb:		notifier_block to notify for restart notifications
>   *
> - * Returns 0 on success, negative errno on failure.
> + * Returns pointer to srcu notifier head on success, ERR_PTR on failure.
>   *
> - * This register the @notify function as handler for restart notifications. As
> - * remote processors are stopped this function will be called, with the SSR
> - * name passed as a parameter.
> + * This registers the @notify function as handler for restart notifications. As
> + * remote processors are stopped this function will be called, with the rproc
> + * pointer passed as a parameter.
>   */
> -int qcom_register_ssr_notifier(struct notifier_block *nb)
> +void *qcom_register_ssr_notifier(struct rproc *rproc, struct notifier_block *nb)
>  {
> -	return blocking_notifier_chain_register(&ssr_notifiers, nb);
> +	struct rproc_subdev *subdev;
> +	struct qcom_rproc_ssr *ssr;
> +	int ret;
> +
> +	if (!rproc)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&rproc->lock);
> +	list_for_each_entry(subdev, &rproc->subdevs, node) {

I would prefer that we don't touch the lock or subdevs list outside of
the remoteproc core.

> +		ret = strcmp(subdev->name, "ssr_notifs");
> +		if (!ret)
> +			break;
> +	}
> +	mutex_unlock(&rproc->lock);
> +	if (ret)
> +		return ERR_PTR(-ENOENT);
> +
> +	ssr = to_ssr_subdev(subdev);
> +	srcu_notifier_chain_register(ssr->rproc_notif_list, nb);

Adding the notifier to an existing ssr_subdev means that any client
driver that is interested in notification about a remoteproc coming and
going will need to be registered (typically probed) after the remoteproc
driver.

I presume this would be handled by probe deferring on
rproc_get_by_phandle(), but I'm concerned that this will cause
unnecessary probe deferral. But more importantly, it wouldn't allow for
the remoteproc driver to be unloaded and loaded again (as that would be
a new notifier list).

So I think you should carry a global list of "watchers" and upon subdev
events you can match entries in this list based on either struct
of_node or perhaps by ssr_name?

> +
> +	return ssr->rproc_notif_list;
>  }
>  EXPORT_SYMBOL_GPL(qcom_register_ssr_notifier);
>  
>  /**
>   * qcom_unregister_ssr_notifier() - unregister SSR notification handler
> + * @notify:	pointer to srcu notifier head
>   * @nb:		notifier_block to unregister
>   */
> -void qcom_unregister_ssr_notifier(struct notifier_block *nb)
> +int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
>  {
> -	blocking_notifier_chain_unregister(&ssr_notifiers, nb);
> +	if (!notify)
> +		return -EINVAL;
> +
> +	return srcu_notifier_chain_unregister(notify, nb);
>  }
>  EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
>  
> @@ -208,7 +231,7 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
>  
> -	blocking_notifier_call_chain(&ssr_notifiers, 0, (void *)ssr->name);
> +	srcu_notifier_call_chain(ssr->rproc_notif_list, 0, (void *)ssr->name);
>  }
>  
>  /**
> @@ -226,6 +249,9 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
>  	ssr->name = ssr_name;
>  	ssr->subdev.name = kstrdup("ssr_notifs", GFP_KERNEL);
>  	ssr->subdev.unprepare = ssr_notify_unprepare;
> +	ssr->rproc_notif_list = kzalloc(sizeof(struct srcu_notifier_head),
> +								GFP_KERNEL);
> +	srcu_init_notifier_head(ssr->rproc_notif_list);
>  
>  	rproc_add_subdev(rproc, &ssr->subdev);
>  }
> @@ -239,6 +265,7 @@ EXPORT_SYMBOL_GPL(qcom_add_ssr_subdev);
>  void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
>  {
>  	kfree(ssr->subdev.name);
> +	kfree(ssr->rproc_notif_list);
>  	rproc_remove_subdev(rproc, &ssr->subdev);
>  }
>  EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
> diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> index 58de71e..7792691 100644
> --- a/drivers/remoteproc/qcom_common.h
> +++ b/drivers/remoteproc/qcom_common.h
> @@ -27,6 +27,7 @@ struct qcom_rproc_subdev {
>  struct qcom_rproc_ssr {
>  	struct rproc_subdev subdev;
>  
> +	struct srcu_notifier_head *rproc_notif_list;
>  	const char *name;
>  };
>  
> diff --git a/drivers/soc/qcom/glink_ssr.c b/drivers/soc/qcom/glink_ssr.c
> index d7babe3..2b39683 100644
> --- a/drivers/soc/qcom/glink_ssr.c
> +++ b/drivers/soc/qcom/glink_ssr.c
> @@ -7,6 +7,7 @@
>  #include <linux/completion.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> +#include <linux/remoteproc.h>
>  #include <linux/rpmsg.h>
>  #include <linux/remoteproc/qcom_rproc.h>
>  
> @@ -49,6 +50,7 @@ struct glink_ssr {
>  	struct rpmsg_endpoint *ept;
>  
>  	struct notifier_block nb;
> +	void *notifier_head;
>  
>  	u32 seq_num;
>  	struct completion completion;
> @@ -112,6 +114,7 @@ static int qcom_glink_ssr_notify(struct notifier_block *nb, unsigned long event,
>  static int qcom_glink_ssr_probe(struct rpmsg_device *rpdev)
>  {
>  	struct glink_ssr *ssr;
> +	struct rproc *rproc;
>  
>  	ssr = devm_kzalloc(&rpdev->dev, sizeof(*ssr), GFP_KERNEL);
>  	if (!ssr)
> @@ -125,14 +128,27 @@ static int qcom_glink_ssr_probe(struct rpmsg_device *rpdev)
>  
>  	dev_set_drvdata(&rpdev->dev, ssr);
>  
> -	return qcom_register_ssr_notifier(&ssr->nb);
> +	rproc = rproc_get_by_child(&rpdev->dev);

As we discussed in our meeting offline earlier today, not all glink_ssr
instances has a remoteproc ancestor. After going back and forth on how
to handle this I posted below series:

https://lore.kernel.org/linux-arm-msm/20200423003736.2027371-1-bjorn.andersson@linaro.org/T/#t

With this we are flexible to tie the ssr_subdev API to remoteproc
instances...

Regards,
Bjorn
