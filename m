Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E6AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB4D2072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGK7OWOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgESUkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:40:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952AFC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:40:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f6so381891pgm.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lnv8x2SVuDgdJgRoSASJVXMFFfVWFg9TrxU4jmpqEAw=;
        b=GGK7OWOUBbIqXRAGSKeormKoGZKfaKF9d0TAqQIp7R6+kx9urHwyEz/s7OMB0q1z+G
         pOTEXjj262ccGVmm+cqiMaBDjlfMkDU+IP2u3HxHzj2GFVDOCY4xoJstbKZMP+VF9Gba
         c+8Wn7l9+TM4yGCjDzqi6vmFgl86vQj+svCPTqG77zulc6dcJKEXythwwOYprHFUNXLV
         R8lZZcoJ4TWSng5OwUL6JpcxPAh4sRFi9G8/U9OL33e3O668nYRyCMBgi+66glwoHz+4
         ec/imTW0u1+bzVYVHlqQz0EvVz8/hRpK+0PpndavUHSwSTCl/0GVZr0LvKtLfJuJyOVI
         fYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lnv8x2SVuDgdJgRoSASJVXMFFfVWFg9TrxU4jmpqEAw=;
        b=FGCXBvmoaccnk157aLJXRg03FNrCy7C8tGErzvQj94D5nuYwIrzCjU5D1eOjoztR5W
         6qwSSLPbImz5Eo+8aj04YQyRChmuC5n31+HiyPDIC6Ms/8zvc2+PRjyKSnIpa+wxRFwk
         9CfsPzMPzPUvyrLvwooC5XVZT2t7wTNCy5g1qIheQTG045kJKXmh3zxsCSV1Th2yLqx3
         CBXjveM1n+vFFxvHf1fQ/TnR0aL/wkA2fwlSgdKk/ei+GdPj91oxlL0SeInCsZT8Y8Bq
         yp/UesEtyGAJGbg5gwbb6G2WYVqrSQLiavoJoI1Y34UDDMuTQ6yINBoa47/485vCc1S0
         Ab7w==
X-Gm-Message-State: AOAM533tfsh8mwF7v2B7vYyJWw6jCsGjKi7M9qHC9ZfyPoBiYUfFDKXA
        1/RzogEILV3UDd87+7Qc6q5RBruM3dc=
X-Google-Smtp-Source: ABdhPJyRsbE7axPumrAiW0r3//jy0qgA/bTjSk7Fcd/4vdAvuSj5Unxqnv70vSFHX0qbzg7gPLgdeQ==
X-Received: by 2002:a62:16d5:: with SMTP id 204mr873203pfw.10.1589920814881;
        Tue, 19 May 2020 13:40:14 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q25sm305934pff.69.2020.05.19.13.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:40:13 -0700 (PDT)
Date:   Tue, 19 May 2020 13:38:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v3 1/2] remoteproc: qcom: Add per subsystem SSR
 notification
Message-ID: <20200519203852.GC408178@builder.lan>
References: <1588112169-29447-1-git-send-email-rishabhb@codeaurora.org>
 <1588112169-29447-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588112169-29447-2-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Apr 15:16 PDT 2020, Rishabh Bhatnagar wrote:

> Currently there is a single notification chain which is called whenever any
> remoteproc shuts down. This leads to all the listeners being notified, and
> is not an optimal design as kernel drivers might only be interested in
> listening to notifications from a particular remoteproc. Create a global
> list of remoteproc notification info data structures. This will hold the
> name and notifier_list information for a particular remoteproc. The API
> to register for notifications will use name argument to retrieve the
> notification info data structure and the notifier block will be added to
> that data structure's notification chain.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>

Thanks Rishabh, design wise I think this looks good now, just some code
style things below.

> ---
>  drivers/remoteproc/qcom_common.c      | 89 ++++++++++++++++++++++++++++++-----
>  drivers/remoteproc/qcom_common.h      | 10 +++-
>  include/linux/remoteproc/qcom_rproc.h | 20 ++++++--
>  3 files changed, 99 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 60650bc..7cd17be 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -15,16 +15,18 @@
>  #include <linux/rpmsg/qcom_glink.h>
>  #include <linux/rpmsg/qcom_smd.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/remoteproc/qcom_rproc.h>

Please maintain alphabetical sort order.

>  
>  #include "remoteproc_internal.h"
>  #include "qcom_common.h"
>  
> +#define MAX_NAME_LEN	20
> +DEFINE_MUTEX(rproc_notif_lock);

Please rename this qcom_ssr_subsystem_lock

> +
>  #define to_glink_subdev(d) container_of(d, struct qcom_rproc_glink, subdev)
>  #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
>  #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>  
> -static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);

Move the definition of rproc_notif_info, the new rproc_notif_info list
head and move the two lines above here as well.

> -
>  static int glink_subdev_start(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
> @@ -174,39 +176,81 @@ void qcom_remove_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
>  }
>  EXPORT_SYMBOL_GPL(qcom_remove_smd_subdev);
>  
> +struct rproc_notif_info *find_notif_info(const char *name)

Please make this qcom_ssr_get_subsystem(const char *name)

> +{
> +	struct rproc_notif_info *info;
> +
> +	/* Match in the global rproc_notif_list with name */
> +	list_for_each_entry(info, &rproc_notif_list, list) {
> +		if (!strncmp(info->name, name, strlen(name)))

strncmp(a, b, strlen(b)) is the same thing as strcmp(a, b), unless a is
shorted than b and not NUL terminated.

> +			return info;
> +	}
> +	return NULL;

Both callers of this function will if NULL is returned allocate a new
subsystem object and attach to the list. If you do that here you can
remove the duplication between these.

> +}
> +
>  /**
>   * qcom_register_ssr_notifier() - register SSR notification handler
> + * @name:	pointer to name which will be searched in the global notif_list
>   * @nb:		notifier_block to notify for restart notifications
>   *
> - * Returns 0 on success, negative errno on failure.
> + * Returns pointer to srcu notifier head on success, ERR_PTR on failure.

This shouldn't mention that the opaque pointer is of a type standard to
the kernel. Better just say that it returns a "subsystem cookie".

>   *
> - * This register the @notify function as handler for restart notifications. As
> - * remote processors are stopped this function will be called, with the SSR
> - * name passed as a parameter.
> + * This registers the @nb notifier block as part the notifier chain for a
> + * remoteproc associated with @name. The notifier block's callback
> + * will be invoked when the particular remote processor is stopped.
>   */
> -int qcom_register_ssr_notifier(struct notifier_block *nb)
> +void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb)
>  {
> -	return blocking_notifier_chain_register(&ssr_notifiers, nb);
> +	struct rproc_notif_info *info;
> +
> +	mutex_lock(&rproc_notif_lock);
> +	info = find_notif_info(name);
> +	if (!info) {
> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
> +		if (!info) {
> +			mutex_unlock(&rproc_notif_lock);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +		info->name = kstrndup(name, MAX_NAME_LEN, GFP_KERNEL);

This is going to be a constant in a lot of cases, so please use
kstrdup_const(). Also what's the purpose of limiting the length of this?

> +		srcu_init_notifier_head(&info->notifier_list);
> +
> +		/* Add to global notif list */
> +		INIT_LIST_HEAD(&info->list);
> +		list_add_tail(&info->list, &rproc_notif_list);
> +	}
> +
> +	srcu_notifier_chain_register(&info->notifier_list, nb);
> +	mutex_unlock(&rproc_notif_lock);
> +	return &info->notifier_list;
>  }
>  EXPORT_SYMBOL_GPL(qcom_register_ssr_notifier);
>  
>  /**
>   * qcom_unregister_ssr_notifier() - unregister SSR notification handler
> + * @notify:	pointer to srcu notifier head

      @subsystem: subsystem cookie returned from qcom_register_ssr_notifier

>   * @nb:		notifier_block to unregister
>   */
> -void qcom_unregister_ssr_notifier(struct notifier_block *nb)
> +int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
>  {
> -	blocking_notifier_chain_unregister(&ssr_notifiers, nb);
> +	if (!notify)
> +		return -EINVAL;

qcom_register_ssr_notifier() will return a valid cookie or a ERR_PTR()
so if someone passes NULL here they did something wrong during
development...

So it's better to just remove this check and give the developer a nice
callstack directly pointing out their mistake, than forcing them to
chase where this -EINVAL comes from.

> +
> +	return srcu_notifier_chain_unregister(notify, nb);
>  }
>  EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
>  
>  static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> +	struct rproc_notif_data data = {
> +		.name = ssr->info->name,
> +		.crashed = false,
> +	};
>  
> -	blocking_notifier_call_chain(&ssr_notifiers, 0, (void *)ssr->name);
> +	srcu_notifier_call_chain(&ssr->info->notifier_list, 0, &data);

Did we conclude on why you change blocking to srcu? Can we do it in a
separate patch?

>  }
>  
> +
>  /**
>   * qcom_add_ssr_subdev() - register subdevice as restart notification source
>   * @rproc:	rproc handle
> @@ -214,12 +258,30 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>   * @ssr_name:	identifier to use for notifications originating from @rproc
>   *
>   * As the @ssr is registered with the @rproc SSR events will be sent to all
> - * registered listeners in the system as the remoteproc is shut down.
> + * registered listeners for the particular remoteproc when it is shutdown.
>   */
>  void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
>  			 const char *ssr_name)
>  {
> -	ssr->name = ssr_name;
> +	struct rproc_notif_info *info;
> +
> +	mutex_lock(&rproc_notif_lock);
> +	info = find_notif_info(ssr_name);
> +	if (!info) {
> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
> +		if (!info) {
> +			mutex_unlock(&rproc_notif_lock);
> +			return;
> +		}
> +		info->name = ssr_name;
> +		srcu_init_notifier_head(&info->notifier_list);
> +
> +		/* Add to global notif_list */
> +		INIT_LIST_HEAD(&info->list);
> +		list_add_tail(&info->list, &rproc_notif_list);
> +	}
> +	mutex_unlock(&rproc_notif_lock);
> +	ssr->info = info;
>  	ssr->subdev.unprepare = ssr_notify_unprepare;
>  
>  	rproc_add_subdev(rproc, &ssr->subdev);
> @@ -233,6 +295,7 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
>   */
>  void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
>  {
> +	ssr->info = NULL;

Move this after rproc_remove_subdev() and rely on the core for this not
to race with the ssr_notify_unprepare().

>  	rproc_remove_subdev(rproc, &ssr->subdev);
>  }
>  EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);

It would be nice with a module_exit() that walks the rproc_notif_list
and free all the elements, if qcom_common.ko is rmmod'ed. Given that
this is uncommon I wouldn't mind to take that as a separate patch
though.

> diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> index 58de71e..0c1d288 100644
> --- a/drivers/remoteproc/qcom_common.h
> +++ b/drivers/remoteproc/qcom_common.h
> @@ -24,10 +24,16 @@ struct qcom_rproc_subdev {
>  	struct qcom_smd_edge *edge;
>  };
>  
> +struct rproc_notif_info {

Please rename this struct qcom_ssr_subsystem

> +	const char *name;
> +	struct srcu_notifier_head notifier_list;
> +	struct list_head list;
> +};
> +static LIST_HEAD(rproc_notif_list);

Please rename this list qcom_ssr_subsystem_list and as stated above move
it into qcom_common.c.


To allow using qcom_ssr_subsystem in the struct below simply forward
declare it here as:

struct qcom_ssr_subsystem;

> +
>  struct qcom_rproc_ssr {
>  	struct rproc_subdev subdev;
> -
> -	const char *name;
> +	struct rproc_notif_info *info;
>  };
>  

Regards,
Bjorn

>  void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink);
> diff --git a/include/linux/remoteproc/qcom_rproc.h b/include/linux/remoteproc/qcom_rproc.h
> index fa8e386..3dc65c0 100644
> --- a/include/linux/remoteproc/qcom_rproc.h
> +++ b/include/linux/remoteproc/qcom_rproc.h
> @@ -5,17 +5,27 @@
>  
>  #if IS_ENABLED(CONFIG_QCOM_RPROC_COMMON)
>  
> -int qcom_register_ssr_notifier(struct notifier_block *nb);
> -void qcom_unregister_ssr_notifier(struct notifier_block *nb);
> +struct rproc_notif_data {
> +	const char *name;
> +	bool crashed;
> +};
> +
> +void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb);
> +int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb);
>  
>  #else
>  
> -static inline int qcom_register_ssr_notifier(struct notifier_block *nb)
> +static inline void *qcom_register_ssr_notifier(const char *name,
> +						struct notifier_block *nb)
>  {
> -	return 0;
> +	return NULL;
>  }
>  
> -static inline void qcom_unregister_ssr_notifier(struct notifier_block *nb) {}
> +static inline int qcom_unregister_ssr_notifier(void *notify,
> +						struct notifier_block *nb)
> +{
> +	return 0;
> +}
>  
>  #endif
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
