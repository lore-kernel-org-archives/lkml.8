Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC15C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08FF20720
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4LPEAHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgGPGIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPGIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:08:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625C1C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:08:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so4300627pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D4RopI2SK+VrJEt5Anwxfc4A31dj9pQyiM4Ej3RP8gk=;
        b=Z4LPEAHLdCtydXYwHy5cU2hsfvFcR5JZLRy085J5GiJJX1s8CFicrMFC3sfVPq82iA
         S2gTAcNRx0z7pigJVhpFAZY/SMoNlmmokLMMb+NQpHw0E/iM55ch/lGZvz1Bkjn2nTIq
         OsHUkpcep1ZQ8SLY+kskWFbRRi3v7mY8mY+NopAHN6/N1OJFJDi7MLRtV2vfsOINfkFi
         lsn1yQaTDs1D8GtgLFesxH5GmUoAWVXjmEv/WJUcX/MaUzmFog3cHE7j8z+Foz5bNOx7
         LPYArLeNaOsMs5xOf1+QgAhIHLLl0vRfNp1uZAVZnwYvE0vqDnwlyRihhP4O6CiPuFRu
         wwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D4RopI2SK+VrJEt5Anwxfc4A31dj9pQyiM4Ej3RP8gk=;
        b=gK+hv1baH5aXpnq0YLrAauijSHGS94G8McMY1Q9oY8stiYeAC6nUSLRe514nKQdiXG
         44OvzPaIPqFHab+L2ryz499DaIX5dcamDUkAeO3Uo3Mzq6nJLbaqiN5289x3eWU12IAk
         d5U4MCHcHPTGcKwn8uVhd3+fmQYNCozrdMTV5BMOGeYnrw0uarYVHZaa3kt+VXtCFc4p
         AXC229FTDrFl0nBTGgPGucfzeIpRgc5EvW+RL4tyGCbqXSXxCn9pYFYey/PexQHs0u4V
         8TSbgoVfA78YlJEyO5Xf3o/Mg8xcrDlrCEScsCWFoctPoipvmKEYhieJU5ii11dy+Ky0
         UzXw==
X-Gm-Message-State: AOAM53108EkFJv1HKE9+Bq92OIdTUIaQOwwBMkNtXduAvZ8Fw+qx8oPt
        wistx2oM7I3jKje0F9cbqi+l
X-Google-Smtp-Source: ABdhPJzWa1JbitsW/hnOb4MBqiXITtCsWCUmRQVBbs5jud0hn6mZskzEN3d0CKaYGXLBuLVYHqcNpA==
X-Received: by 2002:aa7:860f:: with SMTP id p15mr2360915pfn.59.1594879719659;
        Wed, 15 Jul 2020 23:08:39 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d89:fed1:8431:5b69:9df5:ad9f])
        by smtp.gmail.com with ESMTPSA id j8sm3854003pfd.145.2020.07.15.23.08.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 23:08:38 -0700 (PDT)
Date:   Thu, 16 Jul 2020 11:38:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bbhatt@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v4 3/9] bus: mhi: core: Use helper API to trigger a
 non-blocking host resume
Message-ID: <20200716060833.GE3271@Mani-XPS-13-9360>
References: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
 <1593448782-8385-4-git-send-email-bbhatt@codeaurora.org>
 <20200704144714.GC3066@Mani-XPS-13-9360>
 <ed30fd4330863c9743a019b6bd89aabd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed30fd4330863c9743a019b6bd89aabd@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 01:53:49PM -0700, bbhatt@codeaurora.org wrote:
> On 2020-07-04 07:47, Manivannan Sadhasivam wrote:
> > On Mon, Jun 29, 2020 at 09:39:36AM -0700, Bhaumik Bhatt wrote:
> > > Autonomous low power mode support requires the MHI host to resume from
> > > multiple places and post a wakeup source to exit system suspend. This
> > > needs to be done in a non-blocking manner. Introduce a helper API to
> > > trigger the host resume for data transfers and other non-blocking use
> > > cases while supporting implementation of autonomous low power modes.
> > > 
> > 
> > Why can't you use pm_wakeup_event() as done in __mhi_device_get_sync()?
> > 
> > Thanks,
> > Mani
> > 
> 
> I forgot to address the __mhi_device_get_sync() function. Thanks for
> pointing out.
> 
> Is it preferable to always post wakeup source with hard boolean set?

A quick grep shows that this routine is not used extensively as compared to
the other one and hence the question.

For a bus driver like this I think we can just live without the hard wakeup.
I don't see a specific usecase where we would need a hard wakeup from suspend.

Thanks,
Mani

> We do want to wakeup from Suspend-to-Idle if system suspend happens to go
> that route.
> 
> As of now, we just by default do regular wakeup event and not hard.
> I figured at some point we might need to distinguish between hard vs
> regular, hence the option but
> it can be eliminated in favor of one or another.
> 



> Thanks,
> Bhaumik
> 
> > > Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > > ---
> > >  drivers/bus/mhi/core/internal.h |  8 ++++++++
> > >  drivers/bus/mhi/core/main.c     | 21 +++++++--------------
> > >  drivers/bus/mhi/core/pm.c       |  6 ++----
> > >  3 files changed, 17 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/bus/mhi/core/internal.h
> > > b/drivers/bus/mhi/core/internal.h
> > > index bcfa7b6..cb32eaf 100644
> > > --- a/drivers/bus/mhi/core/internal.h
> > > +++ b/drivers/bus/mhi/core/internal.h
> > > @@ -599,6 +599,14 @@ int mhi_queue_state_transition(struct
> > > mhi_controller *mhi_cntrl,
> > >  int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan
> > > *mhi_chan,
> > >  		 enum mhi_cmd_type cmd);
> > > 
> > > +static inline void mhi_trigger_resume(struct mhi_controller
> > > *mhi_cntrl,
> > > +				      bool hard_wakeup)
> > > +{
> > > +	pm_wakeup_dev_event(&mhi_cntrl->mhi_dev->dev, 0, hard_wakeup);
> > > +	mhi_cntrl->runtime_get(mhi_cntrl);
> > > +	mhi_cntrl->runtime_put(mhi_cntrl);
> > > +}
> > > +
> > >  /* Register access methods */
> > >  void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct
> > > db_cfg *db_cfg,
> > >  		     void __iomem *db_addr, dma_addr_t db_val);
> > > diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> > > index 1f622ce..8d6ec34 100644
> > > --- a/drivers/bus/mhi/core/main.c
> > > +++ b/drivers/bus/mhi/core/main.c
> > > @@ -909,8 +909,7 @@ void mhi_ctrl_ev_task(unsigned long data)
> > >  		 * process it since we are probably in a suspended state,
> > >  		 * so trigger a resume.
> > >  		 */
> > > -		mhi_cntrl->runtime_get(mhi_cntrl);
> > > -		mhi_cntrl->runtime_put(mhi_cntrl);
> > > +		mhi_trigger_resume(mhi_cntrl, false);
> > > 
> > >  		return;
> > >  	}
> > > @@ -971,10 +970,8 @@ int mhi_queue_skb(struct mhi_device *mhi_dev,
> > > enum dma_data_direction dir,
> > >  	}
> > > 
> > >  	/* we're in M3 or transitioning to M3 */
> > > -	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
> > > -		mhi_cntrl->runtime_get(mhi_cntrl);
> > > -		mhi_cntrl->runtime_put(mhi_cntrl);
> > > -	}
> > > +	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
> > > +		mhi_trigger_resume(mhi_cntrl, false);
> > > 
> > >  	/* Toggle wake to exit out of M2 */
> > >  	mhi_cntrl->wake_toggle(mhi_cntrl);
> > > @@ -1032,10 +1029,8 @@ int mhi_queue_dma(struct mhi_device *mhi_dev,
> > > enum dma_data_direction dir,
> > >  	}
> > > 
> > >  	/* we're in M3 or transitioning to M3 */
> > > -	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
> > > -		mhi_cntrl->runtime_get(mhi_cntrl);
> > > -		mhi_cntrl->runtime_put(mhi_cntrl);
> > > -	}
> > > +	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
> > > +		mhi_trigger_resume(mhi_cntrl, false);
> > > 
> > >  	/* Toggle wake to exit out of M2 */
> > >  	mhi_cntrl->wake_toggle(mhi_cntrl);
> > > @@ -1147,10 +1142,8 @@ int mhi_queue_buf(struct mhi_device *mhi_dev,
> > > enum dma_data_direction dir,
> > >  	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
> > > 
> > >  	/* we're in M3 or transitioning to M3 */
> > > -	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
> > > -		mhi_cntrl->runtime_get(mhi_cntrl);
> > > -		mhi_cntrl->runtime_put(mhi_cntrl);
> > > -	}
> > > +	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
> > > +		mhi_trigger_resume(mhi_cntrl, false);
> > > 
> > >  	/* Toggle wake to exit out of M2 */
> > >  	mhi_cntrl->wake_toggle(mhi_cntrl);
> > > diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> > > index 661d704..5e3994e 100644
> > > --- a/drivers/bus/mhi/core/pm.c
> > > +++ b/drivers/bus/mhi/core/pm.c
> > > @@ -1139,10 +1139,8 @@ void mhi_device_put(struct mhi_device *mhi_dev)
> > > 
> > >  	mhi_dev->dev_wake--;
> > >  	read_lock_bh(&mhi_cntrl->pm_lock);
> > > -	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
> > > -		mhi_cntrl->runtime_get(mhi_cntrl);
> > > -		mhi_cntrl->runtime_put(mhi_cntrl);
> > > -	}
> > > +	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
> > > +		mhi_trigger_resume(mhi_cntrl, false);
> > > 
> > >  	mhi_cntrl->wake_put(mhi_cntrl, false);
> > >  	read_unlock_bh(&mhi_cntrl->pm_lock);
> > > --
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > > Forum,
> > > a Linux Foundation Collaborative Project
> > > 
