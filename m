Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B646FC47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FEC20721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDLL52ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgEFCE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgEFCE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:04:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC9C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 19:04:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so1871189pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 19:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ht95Y5DjjEWAS3PdPXq8jInYuLKlRYa1OvzAB7rfXKA=;
        b=YDLL52ja6DlRYr7kxury5BlE7hlHp6IvThNZlrhOOKPhIs7amATKN8AhQJZ6Xx+N1n
         9XUDcArWyJ/NG+eBmDQJzhRjaaJmKoBWmZQKMts7g8znUJ5ydCXBa4N5rc4WD4Cv44Ep
         D2AIw+jhCdVoQxjjBY/f4JpRrFDmCexsqtTUMdbL7thGd/zHFiRRWndLWoEZIt6xroep
         NTxHEQA+Rg9byhCU7FNjvs960dCxx73C2wxA0ynXC0/txDeX2oikyI1YB4aQxq1gq0gu
         +YAnwA/8n7l12K4iW2aky/6FDajYFUNWQwrjMH6rqrLBsJ05UkO5t5FxtblKMvXx6Uyn
         k++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ht95Y5DjjEWAS3PdPXq8jInYuLKlRYa1OvzAB7rfXKA=;
        b=Ck9KIOGx+IuPtfkpFwsOX0OVVdf2nPrUqIMOhSlEIsHf8wOCMGDGfagVU+4FdMLX9x
         3gWmiOQhWl7Z9sPqELRMplRGnglugVf+U487oo6ZgGvPPUyKXNK6LEzk1++Zq5kViSsN
         ddL5IDbLUlMiW4hQMSh8j/4lxaDYScJ02r4jqDeyhGTaKtv2l4mxYZWJ5uJmRKC20Znm
         qzxezBhRcl54zZfAXC54ru2rUSBexAzr0bNN3fVkHpabgPhJV8yBSC3StZMoL87tZ0oS
         PV0IRMQ9CiKLBN2g+vHLvOU6P8WuJVCjmwUAdrIkkPmgt0aXXHIVsGWnXkUX/1p9aAXm
         rDkg==
X-Gm-Message-State: AGi0PuarseuYaxTSSHv1ujMmWlNWIAdE78TmPYfADt9gZMgFoDYj3KqV
        EuXhCItqCVjdk7ClchasiFS2vA==
X-Google-Smtp-Source: APiQypI9MX7UhCr6QqN1BJuKksDqwAV4+LkKvwM2GRK6+2aqm/NTUGedzZOi/WZ+8mxBZespeC9iDg==
X-Received: by 2002:a17:90a:23cd:: with SMTP id g71mr6599102pje.174.1588730695459;
        Tue, 05 May 2020 19:04:55 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t188sm354926pgc.3.2020.05.05.19.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 19:04:54 -0700 (PDT)
Date:   Tue, 5 May 2020 19:05:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org,
        fabien.dessenne@st.com, s-anna@ti.com
Subject: Re: [RFC 2/2] remoteproc: core: keep rproc in crash state in case of
 recovery failure
Message-ID: <20200506020540.GI2329931@builder.lan>
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
 <1583924072-20648-3-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583924072-20648-3-git-send-email-loic.pallardy@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11 Mar 03:54 PDT 2020, Loic Pallardy wrote:

> When an error occurs during recovery procedure, internal rproc
> variables may be unaligned:
> - state is set to RPROC_OFFLINE
> - power atomic not equal to 0
> which is normal as only rproc_stop() has been executed and not
> rproc_shutdown()
> 
> In such case, rproc_boot() can be re-executed by client to
> reboot co-processor.
> 
> This patch proposes to keep rproc in RPROC_CRASHED state in case
> of recovery failure to be coherent with recovery disabled mode.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 7ac87a75cd1b..def4f9fc881d 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1679,6 +1679,12 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  	release_firmware(firmware_p);
>  
>  unlock_mutex:
> +	/*
> +	 * In case of error during recovery sequence restore rproc
> +	 * state in CRASHED
> +	 */
> +	if (ret)
> +		rproc->state = RPROC_CRASHED;

Got back to this after looking at Mathieu's synchronization series, I
think it would be cleaner if we move the rproc->state update out of
rproc_start() and rproc_stop().

That way we would leave the state in CRASHED state throughout the
recovery process, which I think makes it easier to reason about the
various states and their transitions.

Regards,
Bjorn

>  	mutex_unlock(&rproc->lock);
>  	return ret;
>  }
> -- 
> 2.7.4
> 
