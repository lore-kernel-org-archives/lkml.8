Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01844C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C432076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9xyhmok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgD3UXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgD3UXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:23:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01571C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:23:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h69so3417739pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+EXLo77FO0FCstOJWIqw46dT5RN3P9qVwTC8ymt4pXU=;
        b=v9xyhmokdUP9iLunCKhKlBteYYCW/21dKhqqwUN8LT4nCGAntjTL3aGEVV24cPb+wb
         IU2hqYMDOE79mcijFHDTwIDF2BbJXRC/FaWWO3L08S88Jo7uSHlNHOESaOumaZgL86Nx
         MJx8jKXcYe7MrrTKF4tCTLrY1HSZhYEmXG7iSQlGc5B4VfbeiMkv48b669YxXZB41Vtr
         cRbeYg0KeQj1TPHX8qKLe/6swvh00amTo7cCJXC2HHLiHbh6jDtT/yTHjfvJtZSQV7ZD
         7ndTidaqoEuSjLTlZ6PGEH+RqKYBxgZXPHrzD3OrFMG6zg1iPSE2AeS4qg/hGuY//eSk
         cRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+EXLo77FO0FCstOJWIqw46dT5RN3P9qVwTC8ymt4pXU=;
        b=taU/IhpwLem1br4KaoNCxN1bUih/r5BuQyIbNiV2bvzB6HjUOH1NdoUQRTn/Jd/qcz
         Zm8SWNma3Mg0vUzWoDLRak4V7F+wq3hsdaQfI+PISrT/W6Mum45+Z/dcu0KJYBBljRFc
         a24QT9F7evzcL/a5CkW/bHU2mekTgZti3EF0WRxoSGNAlDUucFethuT9nqytJebzkroY
         Ef2ksbTIqTBbyG+QY7CxOgkmLOGvritxk6so01vgdgJ00sYFJNC35tso7/bCkcS+XAYW
         CZLEyK5JZqlYbnoBJklepNWBAEgxUkQWaaEw++hy8+afzM9YQFjicPypWBYYunV9N186
         PSsQ==
X-Gm-Message-State: AGi0PubfvkLe1zeJhHC6RKibDXBkDwW08P3bDUxmaS7rTiepkOsSRbzn
        wN9PNlLf6vo1qXkJ6AS79lu0+wKH3Q0=
X-Google-Smtp-Source: APiQypLCzp1UvLPHamlNDOHkwo+m25p0nBRJ348rvZzSdq4jr8HJoS2AUyyXr5jUM3WZDq1+Gvkibw==
X-Received: by 2002:a63:ef4e:: with SMTP id c14mr712517pgk.84.1588278195381;
        Thu, 30 Apr 2020 13:23:15 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o18sm531940pjw.15.2020.04.30.13.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:23:14 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:23:12 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com, loic.pallardy@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/14] remoteproc: Deal with synchronisation when
 shutting down
Message-ID: <20200430202312.GE17031@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-11-mathieu.poirier@linaro.org>
 <d2eeb480-6ba1-de12-53ba-cdf9c61b94b0@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2eeb480-6ba1-de12-53ba-cdf9c61b94b0@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:19:49AM +0200, Arnaud POULIQUEN wrote:
> 
> 
> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> > The remoteproc core must not allow function rproc_shutdown() to
> > proceed if currently synchronising with a remote processor and
> > the synchronisation operations of that remote processor does not
> > support it.  Also part of the process is to set the synchronisation
> > flag so that the remoteproc core can make the right decisions when
> > restarting the system.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c     | 32 ++++++++++++++++++++++++
> >  drivers/remoteproc/remoteproc_internal.h |  7 ++++++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 3a84a38ba37b..48afa1f80a8f 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1849,6 +1849,27 @@ int rproc_boot(struct rproc *rproc)
> >  }
> >  EXPORT_SYMBOL(rproc_boot);
> >  
> > +static bool rproc_can_shutdown(struct rproc *rproc)
> > +{
> > +	/*
> > +	 * The remoteproc core is the lifecycle manager, no problem
> > +	 * calling for a shutdown.
> > +	 */
> > +	if (!rproc_needs_syncing(rproc))
> > +		return true;
> > +
> > +	/*
> > +	 * The remoteproc has been loaded by another entity (as per above
> > +	 * condition) and the platform code has given us the capability
> > +	 * of stopping it.
> > +	 */
> > +	if (rproc->sync_ops->stop)
> > +		return true;
> 
> This means that if rproc->sync_ops->stop is null rproc_stop_subdevices will not
> be called? seems not symmetric with the start sequence.

If rproc->sync_ops->stop is not provided then the remoteproc core can't stop the
remote processor at all after it has synchronised with it.  If a usecase
requires some kind of soft reset then a stop() function that uses a mailbox
notification or some other mechanism can be provided to tell the remote
processor to put itself back in startup mode again.

Is this fine with you or there is still something I don't get?

> Probably not useful to test it here as condition is already handled in rproc_stop_device...
> 
> Regards
> Arnaud
> > +
> > +	/* Any other condition should not be allowed */
> > +	return false;
> > +}
> > +
> >  /**
> >   * rproc_shutdown() - power off the remote processor
> >   * @rproc: the remote processor
> > @@ -1879,6 +1900,9 @@ void rproc_shutdown(struct rproc *rproc)
> >  		return;
> >  	}
> >  
> > +	if (!rproc_can_shutdown(rproc))
> > +		goto out;
> > +
> >  	/* if the remote proc is still needed, bail out */
> >  	if (!atomic_dec_and_test(&rproc->power))
> >  		goto out;
> > @@ -1898,6 +1922,14 @@ void rproc_shutdown(struct rproc *rproc)
> >  	kfree(rproc->cached_table);
> >  	rproc->cached_table = NULL;
> >  	rproc->table_ptr = NULL;
> > +
> > +	/*
> > +	 * The remote processor has been switched off - tell the core what
> > +	 * operation to use from hereon, i.e whether an external entity will
> > +	 * reboot the remote processor or it is now the remoteproc core's
> > +	 * responsability.
> > +	 */
> > +	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_SHUTDOWN);
> >  out:
> >  	mutex_unlock(&rproc->lock);
> >  }
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index 61500981155c..7dcc0a26892b 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -27,6 +27,9 @@ struct rproc_debug_trace {
> >  /*
> >   * enum rproc_sync_states - remote processsor sync states
> >   *
> > + * @RPROC_SYNC_STATE_SHUTDOWN	state to use after the remoteproc core
> > + *				has shutdown (rproc_shutdown()) the
> > + *				remote processor.
> >   * @RPROC_SYNC_STATE_CRASHED	state to use after the remote processor
> >   *				has crashed but has not been recovered by
> >   *				the remoteproc core yet.
> > @@ -36,6 +39,7 @@ struct rproc_debug_trace {
> >   * operation to use.
> >   */
> >  enum rproc_sync_states {
> > +	RPROC_SYNC_STATE_SHUTDOWN,
> >  	RPROC_SYNC_STATE_CRASHED,
> >  };
> >  
> > @@ -43,6 +47,9 @@ static inline void rproc_set_sync_flag(struct rproc *rproc,
> >  				       enum rproc_sync_states state)
> >  {
> >  	switch (state) {
> > +	case RPROC_SYNC_STATE_SHUTDOWN:
> > +		rproc->sync_with_rproc = rproc->sync_flags.after_stop;
> > +		break;
> >  	case RPROC_SYNC_STATE_CRASHED:
> >  		rproc->sync_with_rproc = rproc->sync_flags.after_crash;
> >  		break;
> > 
