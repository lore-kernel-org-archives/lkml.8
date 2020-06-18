Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0404DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF68B20888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0FxSHPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgFRXfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgFRXfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:35:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ACEC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:35:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so3650199pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qZfxLmBGAievziX6gJaS4ebcoQZDwyGR0jkA3ahTGNU=;
        b=Q0FxSHPY+KBoNwKXqBHQmbfF4poUQ5awQM8TRTUM6WF80HUEmw5FcX7vuXZoiIjjLr
         elpLQBB6F/KFm/NbBJpe6d4kOPPJda1Zn2Ng9kfpwi82RvkSiCFkJdw6k/UE38XiHapL
         rkwfeKSK26XbD78YG9o9vewdQC89wag/c7Ph4cz27TFrsMBF9IsJMTSFn5TgiEcjKg3B
         GhUaHZsMK+oWxzlsVL/g0C8T2hnyfJzN0chHvsJ1A2Us0wDz/RpI83xQYnehKWFtNp8U
         oKfwYww1KDDUYoEWuBZ3pCEGAOlTwBcpi41nmPF7R8kn3T6RVc/QGMdeVuOH1v5gfq2N
         SZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qZfxLmBGAievziX6gJaS4ebcoQZDwyGR0jkA3ahTGNU=;
        b=Cz7HRQxa8/rvufh/Ut0jpTya05M+7GP/9FsGHHzih92Tba5taJCEZP89aIXsxQCCzW
         /HgsVBJGk13KRroOL5qpd18WQAh8m1Mrh1jGFETxw5gOt6DGUzX2A5/O/AgajPXR9EnQ
         RJusU7VnZCQgufPQC5Q51+Xicl3H9MawJ4Cdmesm/NQwHVF939GHj8e84zNkzEyEkSa4
         O487WLFpBvwuydquJDP43dovDY2iEUF4BOV/QbT8ITtHz0JAJlJFdNHMOAdr8xMjEAOs
         loCEdUP1skqn8u/YN8nl/GyKYrIvOffh9k8I12TtgpLO9WXgjRU+L5HfUQaEaoVoIR6M
         qBsw==
X-Gm-Message-State: AOAM531aVb+HNrBNTovTj/UWUGGcT1O7sOart5YZ5G6EPN9MIdDcCl9X
        5CuAmTWVGMjI3CNC7xXwRSu18g==
X-Google-Smtp-Source: ABdhPJxLYFCzq87qjz8fvBJTOSdZjVJfh97T0bJqGg132bXd40LDDkapBqEo5vH1GkyR6Un/5Sjm2w==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr778165pgp.160.1592523320805;
        Thu, 18 Jun 2020 16:35:20 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z1sm3417733pjz.10.2020.06.18.16.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:35:20 -0700 (PDT)
Date:   Thu, 18 Jun 2020 16:35:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@ieee.org>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v4 1/2] remoteproc: qcom: Add per subsystem SSR
 notification
Message-ID: <20200618233517.GH11847@yoga>
References: <1590636883-30866-1-git-send-email-rishabhb@codeaurora.org>
 <1590636883-30866-2-git-send-email-rishabhb@codeaurora.org>
 <5f258ccc-46db-50fe-61fd-d7959deb4989@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f258ccc-46db-50fe-61fd-d7959deb4989@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18 Jun 16:00 PDT 2020, Alex Elder wrote:

> On 5/27/20 10:34 PM, Rishabh Bhatnagar wrote:
> > Currently there is a single notification chain which is called whenever any
> > remoteproc shuts down. This leads to all the listeners being notified, and
> > is not an optimal design as kernel drivers might only be interested in
> > listening to notifications from a particular remoteproc. Create a global
> > list of remoteproc notification info data structures. This will hold the
> > name and notifier_list information for a particular remoteproc. The API
> > to register for notifications will use name argument to retrieve the
> > notification info data structure and the notifier block will be added to
> > that data structure's notification chain. Also move from blocking notifier
> > to srcu notifer based implementation to support dynamic notifier head
> > creation.
> 
> I'm looking at these patches now, without having reviewed the
> previous versions.  Forgive me if I contradict or duplicate
> previous feedback.
> 
> I have a number of suggestions, below.
> 
> 					-Alex
> 

Thanks for your review Alex, some feedback on the patch and your
response below.

> > Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > ---
> >   drivers/remoteproc/qcom_common.c      | 84 ++++++++++++++++++++++++++++++-----
> >   drivers/remoteproc/qcom_common.h      |  5 ++-
> >   include/linux/remoteproc/qcom_rproc.h | 20 ++++++---
> >   3 files changed, 90 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> > index 9028cea..61ff2dd 100644
> > --- a/drivers/remoteproc/qcom_common.c
> > +++ b/drivers/remoteproc/qcom_common.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/module.h>
> >   #include <linux/notifier.h>
> >   #include <linux/remoteproc.h>
> > +#include <linux/remoteproc/qcom_rproc.h>
> >   #include <linux/rpmsg/qcom_glink.h>
> >   #include <linux/rpmsg/qcom_smd.h>
> >   #include <linux/soc/qcom/mdt_loader.h>
> > @@ -23,7 +24,14 @@
> >   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
> >   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
> > -static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
> > +struct qcom_ssr_subsystem {
> > +	const char *name;
> > +	struct srcu_notifier_head notifier_list;
> > +	struct list_head list;
> > +};
> > +
> > +static LIST_HEAD(qcom_ssr_subsystem_list);
> > +DEFINE_MUTEX(qcom_ssr_subsys_lock);
> 
> There is no need for this mutex to be global.
> 
> >   static int glink_subdev_start(struct rproc_subdev *subdev)
> >   {
> > @@ -189,39 +197,79 @@ void qcom_remove_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_remove_smd_subdev);
> > +struct qcom_ssr_subsystem *qcom_ssr_get_subsys(const char *name)
> 
> This function should be made private (static).
> 

Yes.

> I think the mutex should be taken in this function rather than
> the caller (more on this below).  But if you leave it this way,
> please mention something in a comment that indicates the caller
> must hold the qcom_ssr_subsys_lock mutex.
> 

I agree, that would simplify reasoning about the lock.

> > +{
> > +	struct qcom_ssr_subsystem *info;
> > +
> > +	/* Match in the global qcom_ssr_subsystem_list with name */
> > +	list_for_each_entry(info, &qcom_ssr_subsystem_list, list) {
> > +		if (!strcmp(info->name, name))
> > +			return info;
> 
> This probably isn't strictly necessary, because you are
> returning a void pointer, but you could do this here:
> 			return ERR_CAST(info);

Info is a struct qcom_ssr_subsystem * and that's the function's return
type as well, so Rishabh's approach looks correct to me.

> 
> > +	}
> 
> This is purely a style thing, but the curly braces around
> the loop body aren't necessary.
> 
> > +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return ERR_PTR(-ENOMEM);
> > +	info->name = kstrdup_const(name, GFP_KERNEL);
> > +	srcu_init_notifier_head(&info->notifier_list);
> > +
> > +	/* Add to global notif list */
> 
> s/notif/notification/
> 
> > +	INIT_LIST_HEAD(&info->list);
> 
> No need to initialize the list element when adding it
> to a list.  Both uts fields will be overwritten anyway.
> 
> > +	list_add_tail(&info->list, &qcom_ssr_subsystem_list);
> > +
> > +	return info;
> > +}
> > +
> >   /**
> >    * qcom_register_ssr_notifier() - register SSR notification handler
> > + * @name:	name that will be searched in global ssr subsystem list
> 
> Maybe just "SSR subsystem name".
> 
> >    * @nb:		notifier_block to notify for restart notifications
> 
> Drop or modify "restart" in the comment line above.
> 
> >    *
> > - * Returns 0 on success, negative errno on failure.
> > + * Returns a subsystem cookie on success, ERR_PTR on failure.
> 
> Maybe make the above a @Return: comment.
> 

No @ in that, but "Return: foo" is the appropriate format.

> >    *
> > - * This register the @notify function as handler for restart notifications. As
> > - * remote processors are stopped this function will be called, with the SSR
> > - * name passed as a parameter.
> > + * This registers the @nb notifier block as part the notifier chain for a
> > + * remoteproc associated with @name. The notifier block's callback
> > + * will be invoked when the particular remote processor is stopped.
> 
> It's not just for stopping, right?  Maybe something
> more like:
>   Register to receive notification callbacks when
>   remoteproc SSR events occur (pre- and post-startup
>   and pre- and post-shutdown).
> 

And this description of the function should go above the Return:

See https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

> >    */
> > -int qcom_register_ssr_notifier(struct notifier_block *nb)
> > +void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb)
> >   {
> > -	return blocking_notifier_chain_register(&ssr_notifiers, nb);
> > +	struct qcom_ssr_subsystem *info;
> > +
> > +	mutex_lock(&qcom_ssr_subsys_lock);
> 
> Can you explain why the mutex is taken here (and in
> qcom_add_ssr_subdev()), rather than having the mutex
> logic be isolated in qcom_ssr_get_subsys()?
> 
> > +	info = qcom_ssr_get_subsys(name);
> > +	if (IS_ERR(info)) {
> > +		mutex_unlock(&qcom_ssr_subsys_lock);
> > +		return info;
> > +	}
> 
> I don't think there's any need to have the next function
> call be protected by the mutex, but maybe I'm mistaken.
> 
> > +	srcu_notifier_chain_register(&info->notifier_list, nb);
> > +	mutex_unlock(&qcom_ssr_subsys_lock);
> > +	return &info->notifier_list;
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_register_ssr_notifier);
> >   /**
> >    * qcom_unregister_ssr_notifier() - unregister SSR notification handler
> > + * @notify:	subsystem coookie returned from qcom_register_ssr_notifier
> >    * @nb:		notifier_block to unregister
> 
> Add a @Return comment (0 on success, %ENOENT otherwise).
> 
> >    */
> > -void qcom_unregister_ssr_notifier(struct notifier_block *nb)
> > +int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
> >   {
> > -	blocking_notifier_chain_unregister(&ssr_notifiers, nb);
> > +	return srcu_notifier_chain_unregister(notify, nb);
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
> >   static void ssr_notify_unprepare(struct rproc_subdev *subdev)
> >   {
> >   	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> > +	struct qcom_ssr_notif_data data = {
> > +		.name = ssr->info->name,
> > +		.crashed = false,
> > +	};
> > -	blocking_notifier_call_chain(&ssr_notifiers, 0, (void *)ssr->name);
> > +	srcu_notifier_call_chain(&ssr->info->notifier_list, 0, &data);
> >   }
> > +
> >   /**
> >    * qcom_add_ssr_subdev() - register subdevice as restart notification source
> >    * @rproc:	rproc handle
> > @@ -229,12 +277,23 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
> >    * @ssr_name:	identifier to use for notifications originating from @rproc
> >    *
> >    * As the @ssr is registered with the @rproc SSR events will be sent to all
> > - * registered listeners in the system as the remoteproc is shut down.
> > + * registered listeners for the particular remoteproc when it is shutdown.
> >    */
> >   void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
> >   			 const char *ssr_name)
> >   {
> > -	ssr->name = ssr_name;
> > +	struct qcom_ssr_subsystem *info;
> > +
> > +	mutex_lock(&qcom_ssr_subsys_lock);
> > +	info = qcom_ssr_get_subsys(ssr_name);
> 
> If there already exists an SSR subsystem having the given
> name, its info structure is returned here.  Is that OK?
> In practice, I don't expect this to be a problem, but it
> would be better to return an error if
> 

You're right...that shouldn't happen. So a WARN_ON() and early return
would be in order.

> > +	if (IS_ERR(info)) {
> > +		dev_err(&rproc->dev, "Failed to add ssr subdevice\n");
> > +		mutex_unlock(&qcom_ssr_subsys_lock);
> > +		return;
> > +	}
> > +
> > +	mutex_unlock(&qcom_ssr_subsys_lock);
> > +	ssr->info = info;
> >   	ssr->subdev.unprepare = ssr_notify_unprepare;
> >   	rproc_add_subdev(rproc, &ssr->subdev);
> > @@ -249,6 +308,7 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
> >   void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
> >   {
> >   	rproc_remove_subdev(rproc, &ssr->subdev);
> > +	ssr->info = NULL;
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
> > diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> > index 34e5188..dfc641c 100644
> > --- a/drivers/remoteproc/qcom_common.h
> > +++ b/drivers/remoteproc/qcom_common.h
> > @@ -26,10 +26,11 @@ struct qcom_rproc_subdev {
> >   	struct qcom_smd_edge *edge;
> >   };
> > +struct qcom_ssr_subsystem;
> > +
> >   struct qcom_rproc_ssr {
> >   	struct rproc_subdev subdev;
> > -
> > -	const char *name;
> > +	struct qcom_ssr_subsystem *info;
> >   };
> >   void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
> > diff --git a/include/linux/remoteproc/qcom_rproc.h b/include/linux/remoteproc/qcom_rproc.h
> > index fa8e386..58422b1 100644
> > --- a/include/linux/remoteproc/qcom_rproc.h
> > +++ b/include/linux/remoteproc/qcom_rproc.h
> > @@ -5,17 +5,27 @@
> >   #if IS_ENABLED(CONFIG_QCOM_RPROC_COMMON)
> > -int qcom_register_ssr_notifier(struct notifier_block *nb);
> > -void qcom_unregister_ssr_notifier(struct notifier_block *nb);
> > +struct qcom_ssr_notif_data {
> > +	const char *name;
> > +	bool crashed;
> 
> Is the crashed field strictly necessary?  Could we instead have
> a QCOM_SSR_CRASHED event (in place of QCOM_SSR_BEFORE_SHUTDOWN)?
> I don't know, it's possible doing it the way you do ultimately
> simplifies the logic...  So I'm asking, but not suggesting.
> 

I looked at something similar for the subdev callbacks, but concluded
that most cases I could find was cleaner if I just passed a bool crashed
than having two separate functions to deal with in the client drivers.

So I'm okay with this.

Regards,
Bjorn

> > +};
> > +
> > +void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb);
> > +int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb);
> >   #else
> > -static inline int qcom_register_ssr_notifier(struct notifier_block *nb)
> > +static inline void *qcom_register_ssr_notifier(const char *name,
> > +					       struct notifier_block *nb)
> >   {
> > -	return 0;
> > +	return NULL;
> >   }
> > -static inline void qcom_unregister_ssr_notifier(struct notifier_block *nb) {}
> > +static inline int qcom_unregister_ssr_notifier(void *notify,
> > +					       struct notifier_block *nb)
> > +{
> > +	return 0;
> > +}
> >   #endif
> > 
> 
