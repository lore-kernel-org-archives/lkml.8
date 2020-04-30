Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E34DC47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293C6206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnwCazAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgD3Umh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgD3Umg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:42:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86881C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:42:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so462059pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=evUox8r8uOfR78fNszPqbiwnmrlMrEI2BAyh4m9Yv54=;
        b=QnwCazAp4MOubStUqIoXrdVbndInaGvYqm9yAaq+2LiIH7lUYJvFvWi1Ba/heC47yu
         PfRRYw6MWYQzz7EQJ/5zhK2gMU8eyXOYUJRquyq2VdIzuwuvHJ0hvm8Fn4scql6CsgnK
         9gcgwi3EAnpJCWQ59vqp2dqQi4jjJuPpvHsxE7tVate+P+qx2w5gHIAZj5ZJgMQa9Cck
         EyVA8/A5pIG7rGnXJGm7THue8rw54QYlvteMEgHaAn3krbpyQknON++KmRwa9DoSciZl
         umMmNps2ULLkKxdZ4PghSFurtJZjM4BMIr3S+cVNggThE0MjBlsQ6WOSEhFaIcTIYS/3
         SGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=evUox8r8uOfR78fNszPqbiwnmrlMrEI2BAyh4m9Yv54=;
        b=gHM0j1NRFkgAnQaEHNDCvC/+wJoQ28qPqt0b3xboj3XQI0i/QLmXvhfh5CaOKGdqJ8
         NMJ8EkYzH1C/31WkpqNwgO2Z/dHxPwQK/pt/WPUZD7R2CuwlPXeIrMopEvnwurf1RloS
         CHJ15xR+tn9dWQfhhpWkG/YLB9EuWtx6Ak5ArCfjYSgKcfQ8RdqbaA56kgzUrRpNqcck
         6nrpHYw36vLric9hLGMYx75LdadFCqLzBol6Hn6cMXOBp1oxhMEBJdnTzTcMC13oNoYq
         cSgW2CqZqMufnUNDYDxNbcxy3/tlSOQj5SZql1SSkbM90IGuv7LJMy8XiDpjLqUrxbqp
         WOfA==
X-Gm-Message-State: AGi0PuYU7b/F7NiZrXyNfgbhAKrkM2XZzUj56nDyjop/VAi/H+FX8vyM
        DHUGHI6YCYC/rnzIqQK4z/wCRQ==
X-Google-Smtp-Source: APiQypIVxRDWynefJ2VPD1kCDmu4nsDPWzoEfoK7vamMy+pYmOBr2ZPqWddqsb9vSzzIhcLrnPtRcg==
X-Received: by 2002:a63:175c:: with SMTP id 28mr764713pgx.44.1588279355955;
        Thu, 30 Apr 2020 13:42:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i185sm564158pfg.14.2020.04.30.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:42:35 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:42:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com, loic.pallardy@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/14] remoteproc: Introducing function
 rproc_set_state_machine()
Message-ID: <20200430204233.GB18004@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-13-mathieu.poirier@linaro.org>
 <d297aeab-4f7e-95e0-04c0-266e0f08b2d0@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d297aeab-4f7e-95e0-04c0-266e0f08b2d0@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:22:28AM +0200, Arnaud POULIQUEN wrote:
> 
> 
> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> > Introducting function rproc_set_state_machine() to add
> > operations and a set of flags to use when synchronising with
> > a remote processor.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c     | 54 ++++++++++++++++++++++++
> >  drivers/remoteproc/remoteproc_internal.h |  6 +++
> >  include/linux/remoteproc.h               |  3 ++
> >  3 files changed, 63 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 48afa1f80a8f..5c48714e8702 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -2065,6 +2065,59 @@ int devm_rproc_add(struct device *dev, struct rproc *rproc)
> >  }
> >  EXPORT_SYMBOL(devm_rproc_add);
> >  
> > +/**
> > + * rproc_set_state_machine() - Set a synchronisation ops and set of flags
> > + *			       to use with a remote processor
> > + * @rproc:	The remote processor to work with
> > + * @sync_ops:	The operations to use when synchronising with a remote
> > + *		processor
> > + * @sync_flags:	The flags to use when deciding if the remoteproc core
> > + *		should be synchronising with a remote processor
> > + *
> > + * Returns 0 on success, an error code otherwise.
> > + */
> > +int rproc_set_state_machine(struct rproc *rproc,
> > +			    const struct rproc_ops *sync_ops,
> > +			    struct rproc_sync_flags sync_flags)
> 
> So this API should be called by platform driver only in case of synchronization
> support, right?

Correct

> In this case i would rename it as there is also a state machine in "normal" boot
> proposal: rproc_set_sync_machine or rproc_set_sync_state_machine

That is a valid observation - rproc_set_sync_state_machine() sounds descriptive
enough for me.

> 
> > +{
> > +	if (!rproc || !sync_ops)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * No point in going further if we never have to synchronise with
> > +	 * the remote processor.
> > +	 */
> > +	if (!sync_flags.on_init &&
> > +	    !sync_flags.after_stop && !sync_flags.after_crash)
> > +		return 0;
> > +
> > +	/*
> > +	 * Refuse to go further if remoteproc operations have been allocated
> > +	 * but they will never be used.
> > +	 */
> > +	if (rproc->ops && sync_flags.on_init &&
> > +	    sync_flags.after_stop && sync_flags.after_crash)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Don't allow users to set this more than once to avoid situations
> > +	 * where the remote processor can't be recovered.
> > +	 */
> > +	if (rproc->sync_ops)
> > +		return -EINVAL;
> > +
> > +	rproc->sync_ops = kmemdup(sync_ops, sizeof(*sync_ops), GFP_KERNEL);
> > +	if (!rproc->sync_ops)
> > +		return -ENOMEM;
> > +
> > +	rproc->sync_flags = sync_flags;
> > +	/* Tell the core what to do when initialising */
> > +	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_INIT);
> 
> Is there a use case where sync_flags.on_init is false and other flags are true?

I haven't seen one yet, which doesn't mean it doesn't exist or won't in the
future.  I wanted to make this as flexible as possible.  I started with the idea
of making synchronisation at initialisation time implicit if
rproc_set_state_machine() is called but I know it is only a matter of time
before people come up with some exotic use case where .on_init is false.

> 
> Look like on_init is useless and should not be exposed to the platform driver.
> Or comments are missing to explain the usage of it vs the other flags.

Comments added in remoteproc_internal.h and the new section in
Documentation/remoteproc.txt aren't sufficient?  Can you give me a hint as to
what you think is missing?

> 
> Regards,
> Arnaud
>  
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(rproc_set_state_machine);
> > +
> >  /**
> >   * rproc_type_release() - release a remote processor instance
> >   * @dev: the rproc's device
> > @@ -2088,6 +2141,7 @@ static void rproc_type_release(struct device *dev)
> >  	kfree_const(rproc->firmware);
> >  	kfree_const(rproc->name);
> >  	kfree(rproc->ops);
> > +	kfree(rproc->sync_ops);
> >  	kfree(rproc);
> >  }
> >  
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index 7dcc0a26892b..c1a293a37c78 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -27,6 +27,8 @@ struct rproc_debug_trace {
> >  /*
> >   * enum rproc_sync_states - remote processsor sync states
> >   *
> > + * @RPROC_SYNC_STATE_INIT	state to use when the remoteproc core
> > + *				is initialising.
> >   * @RPROC_SYNC_STATE_SHUTDOWN	state to use after the remoteproc core
> >   *				has shutdown (rproc_shutdown()) the
> >   *				remote processor.
> > @@ -39,6 +41,7 @@ struct rproc_debug_trace {
> >   * operation to use.
> >   */
> >  enum rproc_sync_states {
> > +	RPROC_SYNC_STATE_INIT,
> >  	RPROC_SYNC_STATE_SHUTDOWN,
> >  	RPROC_SYNC_STATE_CRASHED,
> >  };
> > @@ -47,6 +50,9 @@ static inline void rproc_set_sync_flag(struct rproc *rproc,
> >  				       enum rproc_sync_states state)
> >  {
> >  	switch (state) {
> > +	case RPROC_SYNC_STATE_INIT:
> > +		rproc->sync_with_rproc = rproc->sync_flags.on_init;
> > +		break;
> >  	case RPROC_SYNC_STATE_SHUTDOWN:
> >  		rproc->sync_with_rproc = rproc->sync_flags.after_stop;
> >  		break;
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index ceb3b2bba824..a75ed92b3de6 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -619,6 +619,9 @@ struct rproc *rproc_get_by_child(struct device *dev);
> >  struct rproc *rproc_alloc(struct device *dev, const char *name,
> >  			  const struct rproc_ops *ops,
> >  			  const char *firmware, int len);
> > +int rproc_set_state_machine(struct rproc *rproc,
> > +			    const struct rproc_ops *sync_ops,
> > +			    struct rproc_sync_flags sync_flags);
> >  void rproc_put(struct rproc *rproc);
> >  int rproc_add(struct rproc *rproc);
> >  int rproc_del(struct rproc *rproc);
> > 
