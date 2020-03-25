Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA49C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083CA206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxOLDXKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgCYR5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:57:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45861 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:57:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id o26so1497457pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v8BBQ/NBtZ7/svHHcq03U0gLUqYdrhj6Lz0G3zU1PZk=;
        b=xxOLDXKqmlAPgVZPURyhUio7imVBwD48q3OcN7j2P85LUP3lxGm5Mk/Tm8pPHw10eI
         vbE5+pkVsEppVEfULBlRPczZdcqip6pa+PKdUp9igsoq+5a+x9Vg7AF8uwSzEMV9WIuu
         bzxDrrftAq5zBAsmX1uNJQhCv0KtcyQeFMNx9gWi0itxl3d+EURtNZ6qixJHcW5ryHVg
         HKqdhtMKs6j5MZMeplB52sstUwEhrd9cHd2ul0nwwq51EQVcasu1PUNSVT++oIcUnFy6
         2ajhKjYZHCUqtKf5CQw6slx2CA8ilZPX6MWLIPYZ5InxiQEidt7990CHj9B1wf/jADud
         1Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v8BBQ/NBtZ7/svHHcq03U0gLUqYdrhj6Lz0G3zU1PZk=;
        b=YfBiXNfXV4WiAKO/8PUq73YGN0R/dtrBo581U6cumroe6nwkMq15V+Hk2YRuwSvpsm
         svX+P8tfDti5meMCUr7vFnils0WuJq+aMLG+LIZOA8NkSQ+eqRGGNJWQQbMmo+wFgUxC
         H0jYziMcFQCKwWoPUjPr+mPterZzrqQGAHc+xL9cHJd9V89E+fEBbIJg13gjpfkOKv0/
         dVmYr50YcOishqnF8yAOkdyMpN9cf7jRKpXXl9PShWkOliPSg3MJe3XJJh0CltTIkjS4
         EZ1mjyQVPQA1Kyl/9Jro3Prls7aA+g/+iIN7ChV22LLq11O+OrZQkQb9bg1kyWfUroOJ
         Hu2w==
X-Gm-Message-State: ANhLgQ19Z9xxZkJ5TGqIrA9+iLltjGbGDkeui/xULAnn4B+jKRKCWAKM
        uZgRQmzjbr50SrSbHqB2jtvftw==
X-Google-Smtp-Source: ADFU+vtV4WUFtlIPFuBfmrUAdAu0jGk7d8jlvipZz8y0G5/pXyJQR3Ta7TXq2tr5swRu+s2P+IRGSg==
X-Received: by 2002:a63:3d06:: with SMTP id k6mr4118268pga.418.1585159069695;
        Wed, 25 Mar 2020 10:57:49 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l15sm7213709pgk.59.2020.03.25.10.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 10:57:48 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:57:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org,
        fabien.dessenne@st.com, s-anna@ti.com
Subject: Re: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when rproc
 is crashed
Message-ID: <20200325175746.GA6227@xps15>
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
 <1583924072-20648-2-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583924072-20648-2-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On Wed, Mar 11, 2020 at 11:54:31AM +0100, Loic Pallardy wrote:
> When remoteproc recovery is disabled and rproc crashed, user space
> client has no way to reboot co-processor except by a complete platform
> reboot.
> Indeed rproc_shutdown() is called by sysfs state_store() only is rproc
> state is RPROC_RUNNING.
> 
> This patch offers the possibility to shutdown the co-processor if
> it is in RPROC_CRASHED state and so to restart properly co-processor
> from sysfs interface.

If recovery is disabled on an rproc the platform likely intended to have a hard
reboot and as such we should not be concerned about this case.

Where I think we have a problem, something that is asserted by looking at your 2
patches, is cases where rproc_trigger_recovery() fails.  That leaves the system
in a state where it can't be recovered, something the remoteproc core should not
allow. 

> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c  | 2 +-
>  drivers/remoteproc/remoteproc_sysfs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 097f33e4f1f3..7ac87a75cd1b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1812,7 +1812,7 @@ void rproc_shutdown(struct rproc *rproc)
>  	if (!atomic_dec_and_test(&rproc->power))
>  		goto out;
>  
> -	ret = rproc_stop(rproc, false);
> +	ret = rproc_stop(rproc, rproc->state == RPROC_CRASHED);

Please add a comment that explains how we can be in rproc_shutdown() when the
processor has crashed and point to rproc_trigger_recovery().  See below for more
details. 

>  	if (ret) {
>  		atomic_inc(&rproc->power);
>  		goto out;
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 7f8536b73295..1029458a4678 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -101,7 +101,7 @@ static ssize_t state_store(struct device *dev,
>  		if (ret)
>  			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
>  	} else if (sysfs_streq(buf, "stop")) {
> -		if (rproc->state != RPROC_RUNNING)
> +		if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_CRASHED)
>  			return -EINVAL;

Wouldn't it be better to just prevent the MCU to stay in a crashed state (when
recovery is not disabled)?

I like what you did in the next patch where the state of the MCU is set to
RPROC_CRASHED in case of failure, so that we keep.  I also think the hunk
above is correct.  All that is left is to call rproc_shutdown() directly in
rproc_trigger_recovery() when something goes wrong.  I would also add a
dev_err() so that users have a clue of what happened.

That would leave the system in a stable state without having to add intelligence
to state_store().

Let me know that you think...

Mathieu

>  
>  		rproc_shutdown(rproc);
> -- 
> 2.7.4
> 
