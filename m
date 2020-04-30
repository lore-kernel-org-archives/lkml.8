Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA674C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3EE20774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHJYH8V1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3ULO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgD3ULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:11:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E4C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:11:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so1354919pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wQDXEDWulo/QimvcAuTek4hsKx1Ft5Eqi7DzlmxTYAE=;
        b=dHJYH8V1KS7XMRkIk7UCjoCujABCzXT3VvBcthJLyCU32cSGH3S+9errkdNRwRTMEz
         c5jpkn1t3F0VVYcnxcGgfDbIteaCAki9LCSBhJQzOUQE1HxR07CoJ8RYD3b6MTRO/jRj
         AOsG3MGnzZ1MXS8W3IuGmKM/cK4WIN6ErR2fzaSP3VYbMMCnXS0CMwFSE7OewqbUIlyj
         DGXcHLqrPgJyBn3wFO/jwykKiyFlOxEWRdbV+cYd9BztgE57iW9xoYVIRH2XGnWIAFG2
         l0hfGHqrjn9jf0p7oGcqDf5snI4ZOONuq3t13WIE57re6nfAlplgqm5hmo9KxuL213FP
         2f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wQDXEDWulo/QimvcAuTek4hsKx1Ft5Eqi7DzlmxTYAE=;
        b=C7/T48t0UP29XMnfj7Ot/8R/fjFIQ/5lFVx++Zo/OImblE9IvGBKglzDpIEzSrnUuE
         bdRwkHRcOvhOAQfi+sZB3FcWO7F2YQkxi2GdZh5qsrn2d2r7ubJUwHw/jnsi6cBFiJ5l
         PwBrJWo/slGfXWBkhnnfAnKiHat+rKA8D0bI4WGRrkl7cFOlJJGY34JGl1ZxfYoARioP
         aI+0qvdYwSEm6I6tFxDoMCNzUMRr4qlguTXkAJPllfojZmXVfWUvZgY+9WjZwRqPgf+H
         h2xRG6aTqUPAg7iyGYaEEMY/FRu9TNjsH7EzjwhSUGUvIVFooUH82P04P5+2evg2sMUf
         f5ug==
X-Gm-Message-State: AGi0PuaxAmAHNFlsKRnHJPamLCa3HMTrSFnEBix0fvUNtAhD+DXbrg3H
        ExVR2N3ZhgFs8o3+7NQ73Mv3yrJQXgo=
X-Google-Smtp-Source: APiQypL6EqI9FZZIHPIXTfhE8LlwPrLFeY0DjiK4shgSSOuk2VEOSjMNEeufPu16gcaTJg5Uvbte0A==
X-Received: by 2002:a17:90a:9f92:: with SMTP id o18mr600754pjp.180.1588277473266;
        Thu, 30 Apr 2020 13:11:13 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w186sm529784pff.83.2020.04.30.13.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:11:12 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:11:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com, loic.pallardy@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] remoteproc: Deal with synchronisation when
 crashing
Message-ID: <20200430201110.GD17031@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-10-mathieu.poirier@linaro.org>
 <d9df5905-ad8b-881c-5950-481722bd0f3b@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9df5905-ad8b-881c-5950-481722bd0f3b@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 09:44:02AM +0200, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 
> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> > Refactor function rproc_trigger_recovery() in order to avoid
> > reloading the firmware image when synchronising with a remote
> > processor rather than booting it.  Also part of the process,
> > properly set the synchronisation flag in order to properly
> > recover the system.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c     | 23 ++++++++++++++------
> >  drivers/remoteproc/remoteproc_internal.h | 27 ++++++++++++++++++++++++
> >  2 files changed, 43 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index ef88d3e84bfb..3a84a38ba37b 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1697,7 +1697,7 @@ static void rproc_coredump(struct rproc *rproc)
> >   */
> >  int rproc_trigger_recovery(struct rproc *rproc)
> >  {
> > -	const struct firmware *firmware_p;
> > +	const struct firmware *firmware_p = NULL;
> >  	struct device *dev = &rproc->dev;
> >  	int ret;
> >  
> > @@ -1718,14 +1718,16 @@ int rproc_trigger_recovery(struct rproc *rproc)
> >  	/* generate coredump */
> >  	rproc_coredump(rproc);
> >  
> > -	/* load firmware */
> > -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > -		goto unlock_mutex;
> > +	/* load firmware if need be */
> > +	if (!rproc_needs_syncing(rproc)) {
> > +		ret = request_firmware(&firmware_p, rproc->firmware, dev);
> > +		if (ret < 0) {
> > +			dev_err(dev, "request_firmware failed: %d\n", ret);
> > +			goto unlock_mutex;
> > +		}
> 
> If we started in syncing mode then rpoc->firmware is null
> rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_CRASHED) can make rproc_needs_syncing(rproc)
> false. 

You are correct, I will add an additional check in rproc_set_machine() to
prevent a situation where rproc_alloc() has been called without an ops and any
of the synchronisation flags are set to false.

It is also possible that someone would call proc_alloc() without an ops and
doesn't call rproc_set_state_machine(), in which case both ops and sync_ops
would be NULL.  Adding a check in rproc_add() is probably the best location to
catch such a condition.


> In this case here we fail the recovery an leave in RPROC_STOP state.
> As you proposed in Loic RFC[1], what about adding a more explicit message to inform that the recovery
> failed. 

Right, that's a different problem.

> 
> [1]https://lkml.org/lkml/2020/3/11/402
> 
> Regards,
> Arnaud
> >  	}
> >  
> > -	/* boot the remote processor up again */
> > +	/* boot up or synchronise with the remote processor again */
> >  	ret = rproc_start(rproc, firmware_p);
> >  
> >  	release_firmware(firmware_p);
> > @@ -1761,6 +1763,13 @@ static void rproc_crash_handler_work(struct work_struct *work)
> >  	dev_err(dev, "handling crash #%u in %s\n", ++rproc->crash_cnt,
> >  		rproc->name);
> >  
> > +	/*
> > +	 * The remote processor has crashed - tell the core what operation
> > +	 * to use from hereon, i.e whether an external entity will reboot
> > +	 * the MCU or it is now the remoteproc core's responsability.
> > +	 */
> > +	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_CRASHED);
> > +
> >  	mutex_unlock(&rproc->lock);
> >  
> >  	if (!rproc->recovery_disabled)
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index 3985c084b184..61500981155c 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -24,6 +24,33 @@ struct rproc_debug_trace {
> >  	struct rproc_mem_entry trace_mem;
> >  };
> >  
> > +/*
> > + * enum rproc_sync_states - remote processsor sync states
> > + *
> > + * @RPROC_SYNC_STATE_CRASHED	state to use after the remote processor
> > + *				has crashed but has not been recovered by
> > + *				the remoteproc core yet.
> > + *
> > + * Keeping these separate from the enum rproc_state in order to avoid
> > + * introducing coupling between the state of the MCU and the synchronisation
> > + * operation to use.
> > + */
> > +enum rproc_sync_states {
> > +	RPROC_SYNC_STATE_CRASHED,
> > +};
> > +
> > +static inline void rproc_set_sync_flag(struct rproc *rproc,
> > +				       enum rproc_sync_states state)
> > +{
> > +	switch (state) {
> > +	case RPROC_SYNC_STATE_CRASHED:
> > +		rproc->sync_with_rproc = rproc->sync_flags.after_crash;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> >  /* from remoteproc_core.c */
> >  void rproc_release(struct kref *kref);
> >  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> > 
