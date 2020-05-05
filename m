Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E1C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954C9206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVPsMi8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgEEVnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728737AbgEEVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:43:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24165C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 14:43:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l25so132146pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pf3OGyvxXrPZnXFB/2MEXlwg2ZDNjnO29EdVXCpCctQ=;
        b=KVPsMi8GkEwuvj1zl8ORXHUt3mtJDmb8kLiNVodPH6XGOGDcGuTpID+MOWLoMjRH9W
         9LDo85l9GLu9E9Y2nXA5/dj6aHcyNsj8EGKqsb55f2Y6vRqNQ8ILpIe39+PcL5uhhfSE
         mpBtth8w0l6GmueR+7VnCQtJNSAR0ukz3cJOR0/1/+gOZ91QDbrQwEfM2LbkFbayXYBI
         UaPNcg3wZ2336NYpnxyb+FU5vqYm3OOtZE4cfJYT7SZhGKUC9x98axUqnoOSNhNmekCA
         S50H/z0Lwz8iOI4n4nDuRm0xSqTjw2StmN1Se5vxaqvfntovSbW/x/UTIyc0bTUSSuGw
         mEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pf3OGyvxXrPZnXFB/2MEXlwg2ZDNjnO29EdVXCpCctQ=;
        b=LpuQLhJieDqWXUHZ5eXYrvRZkjr87GQWDotiOnPYKQrCRi0KDcJtFIoD5eyzxiSNgl
         5KQTxeMpwJ6DWxvRsWXwqOmBlj9wBJ8BaLUhWqy8h1ngqvfg+nRbuFeI8BRXV1Zy4AAn
         pvvcAVKcvYBx8toZpLGit4iPO4uQ+ywi6IlWUrCwH9IMo4vll8zS0UvV765cmbym8wQi
         yV8rh3vJ2hGS0FHauvcK1Oykb23IByAjKuu5PekgEtKPTnur/Krj4wMirv+fbKuBvoU5
         JluHfwxcdvkKo1J/6ojAXAJF+m7MEGrTutmJJ7mfUvcx/EpMD4t9++n7Du/Z+TtGgHSt
         c/bA==
X-Gm-Message-State: AGi0Publk0UbNkd78nvQR08yEL6pgl3CdiHPG63SeP2mOf5m8Cfb+cjk
        xzRT0mFaWkTdIrBaPTJnjUGhoA==
X-Google-Smtp-Source: APiQypLU8Nlro8oVApJV6AXwJSe3YjxxPUPjzaJ4kl+N3esGkpKg/OGatRL8UY05whX3arrkhfe6Pg==
X-Received: by 2002:a63:f11:: with SMTP id e17mr4586948pgl.412.1588715001286;
        Tue, 05 May 2020 14:43:21 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h6sm2890341pje.37.2020.05.05.14.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 14:43:20 -0700 (PDT)
Date:   Tue, 5 May 2020 15:43:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com, loic.pallardy@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/14] remoteproc: Introducing function
 rproc_set_state_machine()
Message-ID: <20200505214318.GA18333@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-13-mathieu.poirier@linaro.org>
 <d297aeab-4f7e-95e0-04c0-266e0f08b2d0@st.com>
 <20200430204233.GB18004@xps15>
 <842d64d8-832a-cc4c-cbe1-dbd4654fcdd5@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842d64d8-832a-cc4c-cbe1-dbd4654fcdd5@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 01:57:59PM +0200, Arnaud POULIQUEN wrote:
> 
> 
> On 4/30/20 10:42 PM, Mathieu Poirier wrote:
> > On Wed, Apr 29, 2020 at 11:22:28AM +0200, Arnaud POULIQUEN wrote:
> >>
> >>
> >> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> >>> Introducting function rproc_set_state_machine() to add
> >>> operations and a set of flags to use when synchronising with
> >>> a remote processor.
> >>>
> >>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> ---
> >>>  drivers/remoteproc/remoteproc_core.c     | 54 ++++++++++++++++++++++++
> >>>  drivers/remoteproc/remoteproc_internal.h |  6 +++
> >>>  include/linux/remoteproc.h               |  3 ++
> >>>  3 files changed, 63 insertions(+)
> >>>
> >>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> >>> index 48afa1f80a8f..5c48714e8702 100644
> >>> --- a/drivers/remoteproc/remoteproc_core.c
> >>> +++ b/drivers/remoteproc/remoteproc_core.c
> >>> @@ -2065,6 +2065,59 @@ int devm_rproc_add(struct device *dev, struct rproc *rproc)
> >>>  }
> >>>  EXPORT_SYMBOL(devm_rproc_add);
> >>>  
> >>> +/**
> >>> + * rproc_set_state_machine() - Set a synchronisation ops and set of flags
> >>> + *			       to use with a remote processor
> >>> + * @rproc:	The remote processor to work with
> >>> + * @sync_ops:	The operations to use when synchronising with a remote
> >>> + *		processor
> >>> + * @sync_flags:	The flags to use when deciding if the remoteproc core
> >>> + *		should be synchronising with a remote processor
> >>> + *
> >>> + * Returns 0 on success, an error code otherwise.
> >>> + */
> >>> +int rproc_set_state_machine(struct rproc *rproc,
> >>> +			    const struct rproc_ops *sync_ops,
> >>> +			    struct rproc_sync_flags sync_flags)
> >>
> >> So this API should be called by platform driver only in case of synchronization
> >> support, right?
> > 
> > Correct
> > 
> >> In this case i would rename it as there is also a state machine in "normal" boot
> >> proposal: rproc_set_sync_machine or rproc_set_sync_state_machine
> > 
> > That is a valid observation - rproc_set_sync_state_machine() sounds descriptive
> > enough for me.
> > 
> >>
> >>> +{
> >>> +	if (!rproc || !sync_ops)
> >>> +		return -EINVAL;
> >>> +
> >>> +	/*
> >>> +	 * No point in going further if we never have to synchronise with
> >>> +	 * the remote processor.
> >>> +	 */
> >>> +	if (!sync_flags.on_init &&
> >>> +	    !sync_flags.after_stop && !sync_flags.after_crash)
> >>> +		return 0;
> >>> +
> >>> +	/*
> >>> +	 * Refuse to go further if remoteproc operations have been allocated
> >>> +	 * but they will never be used.
> >>> +	 */
> >>> +	if (rproc->ops && sync_flags.on_init &&
> >>> +	    sync_flags.after_stop && sync_flags.after_crash)
> >>> +		return -EINVAL;
> >>> +
> >>> +	/*
> >>> +	 * Don't allow users to set this more than once to avoid situations
> >>> +	 * where the remote processor can't be recovered.
> >>> +	 */
> >>> +	if (rproc->sync_ops)
> >>> +		return -EINVAL;
> >>> +
> >>> +	rproc->sync_ops = kmemdup(sync_ops, sizeof(*sync_ops), GFP_KERNEL);
> >>> +	if (!rproc->sync_ops)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	rproc->sync_flags = sync_flags;
> >>> +	/* Tell the core what to do when initialising */
> >>> +	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_INIT);
> >>
> >> Is there a use case where sync_flags.on_init is false and other flags are true?
> > 
> > I haven't seen one yet, which doesn't mean it doesn't exist or won't in the
> > future.  I wanted to make this as flexible as possible.  I started with the idea
> > of making synchronisation at initialisation time implicit if
> > rproc_set_state_machine() is called but I know it is only a matter of time
> > before people come up with some exotic use case where .on_init is false.
> 
> So having on_init false but after_crash && after_stop true, means loading the
> firmware on first start, and the synchronize with it, right?
> Yes probably could be an exotic valid use case. :) 
> 
> > 
> >>
> >> Look like on_init is useless and should not be exposed to the platform driver.
> >> Or comments are missing to explain the usage of it vs the other flags.
> > 
> > Comments added in remoteproc_internal.h and the new section in
> > Documentation/remoteproc.txt aren't sufficient?  Can you give me a hint as to
> > what you think is missing?
> 
> IMO something is quite confusing...
> On one side on_init can be set to false.
> But on the other side the flag is set  by call rproc_set_state_machine.
> In Documentation/remoteproc.txt rproc_set_state_machine description is:
> 
> "This function should be called for cases where the remote processor has
> been started by another entity, be it a boot loader or trusted environment,
> and the remoteproc core is to synchronise with the remote processor rather
> then boot it."
> 
> So how on_init could be false if "the remote processor has
> been started by another entity"?

I see your point and I think it is a question of documentation.  I will rephrase
this to be more accurate.

> 
> Regards,
> Arnaud
> 
> > 
> >>
> >> Regards,
> >> Arnaud
> >>  
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +EXPORT_SYMBOL(rproc_set_state_machine);
> >>> +
> >>>  /**
> >>>   * rproc_type_release() - release a remote processor instance
> >>>   * @dev: the rproc's device
> >>> @@ -2088,6 +2141,7 @@ static void rproc_type_release(struct device *dev)
> >>>  	kfree_const(rproc->firmware);
> >>>  	kfree_const(rproc->name);
> >>>  	kfree(rproc->ops);
> >>> +	kfree(rproc->sync_ops);
> >>>  	kfree(rproc);
> >>>  }
> >>>  
> >>> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> >>> index 7dcc0a26892b..c1a293a37c78 100644
> >>> --- a/drivers/remoteproc/remoteproc_internal.h
> >>> +++ b/drivers/remoteproc/remoteproc_internal.h
> >>> @@ -27,6 +27,8 @@ struct rproc_debug_trace {
> >>>  /*
> >>>   * enum rproc_sync_states - remote processsor sync states
> >>>   *
> >>> + * @RPROC_SYNC_STATE_INIT	state to use when the remoteproc core
> >>> + *				is initialising.
> >>>   * @RPROC_SYNC_STATE_SHUTDOWN	state to use after the remoteproc core
> >>>   *				has shutdown (rproc_shutdown()) the
> >>>   *				remote processor.
> >>> @@ -39,6 +41,7 @@ struct rproc_debug_trace {
> >>>   * operation to use.
> >>>   */
> >>>  enum rproc_sync_states {
> >>> +	RPROC_SYNC_STATE_INIT,
> >>>  	RPROC_SYNC_STATE_SHUTDOWN,
> >>>  	RPROC_SYNC_STATE_CRASHED,
> >>>  };
> >>> @@ -47,6 +50,9 @@ static inline void rproc_set_sync_flag(struct rproc *rproc,
> >>>  				       enum rproc_sync_states state)
> >>>  {
> >>>  	switch (state) {
> >>> +	case RPROC_SYNC_STATE_INIT:
> >>> +		rproc->sync_with_rproc = rproc->sync_flags.on_init;
> >>> +		break;
> >>>  	case RPROC_SYNC_STATE_SHUTDOWN:
> >>>  		rproc->sync_with_rproc = rproc->sync_flags.after_stop;
> >>>  		break;
> >>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> >>> index ceb3b2bba824..a75ed92b3de6 100644
> >>> --- a/include/linux/remoteproc.h
> >>> +++ b/include/linux/remoteproc.h
> >>> @@ -619,6 +619,9 @@ struct rproc *rproc_get_by_child(struct device *dev);
> >>>  struct rproc *rproc_alloc(struct device *dev, const char *name,
> >>>  			  const struct rproc_ops *ops,
> >>>  			  const char *firmware, int len);
> >>> +int rproc_set_state_machine(struct rproc *rproc,
> >>> +			    const struct rproc_ops *sync_ops,
> >>> +			    struct rproc_sync_flags sync_flags);
> >>>  void rproc_put(struct rproc *rproc);
> >>>  int rproc_add(struct rproc *rproc);
> >>>  int rproc_del(struct rproc *rproc);
> >>>
