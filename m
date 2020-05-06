Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755ECC47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A0D206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H10ahALK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgEFBJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 21:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728512AbgEFBJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 21:09:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF91C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 18:09:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so51964pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SktkFFCj6f5QA03u6t+h6bT244ONZZg07FZfFSbGQhc=;
        b=H10ahALKAILI5hqGa0yUV3fGKJx7fOYUI3kdCvO9CKjzq0DjSQls8eqmbGwkVib2Xm
         dojReo/MPYuk223jIb2yrYbONKsFs6Jf1z9RFFXSq+kbIZZdoYQWJgaRPhXCH9fByaJM
         JqvN+hOaafbetujtMcCDyU6B41olAdP/afunlknFk4lCEXNfdZX4l8OE+vBaXAMR70FP
         j+az0m32y2Aag4eLNUwd9Bw/Lla6jgYC9l7DwxF+1iBhqWaqFnf9dRtGRWu5YG9QpY03
         4A7VEynqH1/s4jBeuM+qCnhIKUzoZVdHcBQLgzMCcVtMpgz7hMJxNrQYUkOUkFLc+kmX
         dc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SktkFFCj6f5QA03u6t+h6bT244ONZZg07FZfFSbGQhc=;
        b=HxIn4Zcz+CikYXH8kuW09TbVgta6ZwkEAcuO6YlN6K6HHblXZ3+aTr9LDjTnBn8GbK
         3TrGNFKyS+C/rfqrjYP4SxPqp81drooIccvIIL6FPnRE9/NR2HmnOh1ewIBy+vQx508c
         H9of58E9wU5kCEfxnFe+vQnTzrB8tnrUuJCDkDXcdnvIxhUs0Vz/ZRdiIJiUF52K5aFl
         DggwwC5z+Emt5VUhS56+/6iaxIfjAEy9zpbpB+0dPeY2FcCaMXF/QQ4eK8w7g74Qo+zh
         yHaFQAVwaEYPDOmrNEw1QWFlaoF6laxxcA+a7RkKXRY1jT5CD/T2eFV/Dxn6NpeVp2XC
         FiwQ==
X-Gm-Message-State: AGi0PubhwPyPbw+qz/kOgCq9MdwsiYTpdc/N/j1qjTj9QJMR7w/69/49
        a+5sfGLxvIWXPJZ1nVyqAiit9Q==
X-Google-Smtp-Source: APiQypL0Ju3ryEjQ9NLdLf6LuWnZdN59jgzn1SiCq0inOcOVQWyKRROKMfb5JSWo+gUzf0+0pN9Efw==
X-Received: by 2002:a17:90a:30a5:: with SMTP id h34mr6135410pjb.171.1588727372890;
        Tue, 05 May 2020 18:09:32 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s76sm274303pgc.85.2020.05.05.18.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 18:09:32 -0700 (PDT)
Date:   Tue, 5 May 2020 18:10:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, loic.pallardy@st.com, arnaud.pouliquen@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/14] remoteproc: Deal with synchronisation when
 shutting down
Message-ID: <20200506011017.GG2329931@builder.lan>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-11-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424200135.28825-11-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Apr 13:01 PDT 2020, Mathieu Poirier wrote:

> The remoteproc core must not allow function rproc_shutdown() to
> proceed if currently synchronising with a remote processor and
> the synchronisation operations of that remote processor does not
> support it.  Also part of the process is to set the synchronisation
> flag so that the remoteproc core can make the right decisions when
> restarting the system.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 32 ++++++++++++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h |  7 ++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 3a84a38ba37b..48afa1f80a8f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1849,6 +1849,27 @@ int rproc_boot(struct rproc *rproc)
>  }
>  EXPORT_SYMBOL(rproc_boot);
>  
> +static bool rproc_can_shutdown(struct rproc *rproc)
> +{
> +	/*
> +	 * The remoteproc core is the lifecycle manager, no problem
> +	 * calling for a shutdown.
> +	 */
> +	if (!rproc_needs_syncing(rproc))
> +		return true;
> +
> +	/*
> +	 * The remoteproc has been loaded by another entity (as per above
> +	 * condition) and the platform code has given us the capability
> +	 * of stopping it.
> +	 */
> +	if (rproc->sync_ops->stop)
> +		return true;
> +
> +	/* Any other condition should not be allowed */
> +	return false;
> +}
> +
>  /**
>   * rproc_shutdown() - power off the remote processor
>   * @rproc: the remote processor
> @@ -1879,6 +1900,9 @@ void rproc_shutdown(struct rproc *rproc)
>  		return;
>  	}
>  
> +	if (!rproc_can_shutdown(rproc))
> +		goto out;

There's been a request mentioned of it being possible to shut down Linux
and having the remote processor keep running.

By skipping the rest of shutdown we will not stop or unprepare
subdevices, so presumably the remote processor won't know that
virtio/rpmsg is down. Is that ok?

> +
>  	/* if the remote proc is still needed, bail out */
>  	if (!atomic_dec_and_test(&rproc->power))
>  		goto out;
> @@ -1898,6 +1922,14 @@ void rproc_shutdown(struct rproc *rproc)
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
>  	rproc->table_ptr = NULL;
> +
> +	/*
> +	 * The remote processor has been switched off - tell the core what
> +	 * operation to use from hereon, i.e whether an external entity will
> +	 * reboot the remote processor or it is now the remoteproc core's
> +	 * responsability.
> +	 */
> +	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_SHUTDOWN);

As asked on a previous patch, what would it mean if after_stop is true?

It seems like this state would be similar to the "already-booted" state
that we might encounter at probe time.

Regards,
Bjorn

>  out:
>  	mutex_unlock(&rproc->lock);
>  }
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 61500981155c..7dcc0a26892b 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -27,6 +27,9 @@ struct rproc_debug_trace {
>  /*
>   * enum rproc_sync_states - remote processsor sync states
>   *
> + * @RPROC_SYNC_STATE_SHUTDOWN	state to use after the remoteproc core
> + *				has shutdown (rproc_shutdown()) the
> + *				remote processor.
>   * @RPROC_SYNC_STATE_CRASHED	state to use after the remote processor
>   *				has crashed but has not been recovered by
>   *				the remoteproc core yet.
> @@ -36,6 +39,7 @@ struct rproc_debug_trace {
>   * operation to use.
>   */
>  enum rproc_sync_states {
> +	RPROC_SYNC_STATE_SHUTDOWN,
>  	RPROC_SYNC_STATE_CRASHED,
>  };
>  
> @@ -43,6 +47,9 @@ static inline void rproc_set_sync_flag(struct rproc *rproc,
>  				       enum rproc_sync_states state)
>  {
>  	switch (state) {
> +	case RPROC_SYNC_STATE_SHUTDOWN:
> +		rproc->sync_with_rproc = rproc->sync_flags.after_stop;
> +		break;
>  	case RPROC_SYNC_STATE_CRASHED:
>  		rproc->sync_with_rproc = rproc->sync_flags.after_crash;
>  		break;
> -- 
> 2.20.1
> 
