Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9961C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76716207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMUXwido"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgETWG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgETWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:06:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D62C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:06:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so1921223plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uZfJAZrkS+LUqWoQw9Wh6148nuH0pMlTX9eBAdFKM/o=;
        b=wMUXwidohFjhSfL7r5sfVVV/7BKhcoGea5+7ePC8f3E5Hf26XWrTm3GnpyyKIhgb4F
         VYTQSjkszOh9YSpLu6eBiJQ3Wwbwb0tfZfc3vh1hwE+PhXn4ywGsZhwG4lRn44OkwAQA
         PVWlXspACVNM5qgX+0Io0EuMaTxneBk10X+Be2IUu/T3pdPGgGQXHbLKjbjRfgpucTeI
         0RjySQP8VJoPMRSslQvAT2YNOI/YB73l/WqPcRrX1VdH0ugk6pJqMSU5wPZS0xTZqCj0
         P1MGD7ZnYdxITF/RkBNow7zgzycrg7+8061lJdGObvF00I60NkdNiFAHWmf93jSBcbC0
         yMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZfJAZrkS+LUqWoQw9Wh6148nuH0pMlTX9eBAdFKM/o=;
        b=ODAWHa7uakGtCoeq1z4o74jgn1CYtZArGXonfdFgqLZ8vM2HN3MQANCq6bd1mTmpz5
         JdwTfGpbQaBEbpd1+U+DxMjoimwuklhcxjXD5IwJQimVzH2/E4lgdPyaRvKL6dT61i87
         sI7LngcfqY/1xNgOoXMhMHP5jg74J2AOF2vX9qAfXs/VDEJe2HhSpM7NtNZTxnA2IgSS
         fc/82lI2PGHKjXOxT5O/1PKoKeJqRCC4Faf7I/CR4qRWrtj2HYg3Gl7R4PNUitQB5qwO
         TZ0SA/4a+GZHgS8Fgyfxgi74SXGKqv8sxNeU7fjT4TeTz2GGlvsTyyZ97OvHw05BqIuV
         nz4A==
X-Gm-Message-State: AOAM533AYk//ZhEWvTulDnU2gXCg1j9bdvIQ54jaZfur0mAoCO1GtzX7
        dKjc9qUI/aijcw/d/BxZpIB1CA==
X-Google-Smtp-Source: ABdhPJzSpfWzRqhnYyFL8gkypSvwou92xCBd4ZKO5bHZ6d3YbMuKha8Dej71qGKUpLY4My9yBPyzTQ==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr6035427plo.289.1590012416752;
        Wed, 20 May 2020 15:06:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z5sm2544409pfj.29.2020.05.20.15.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:06:56 -0700 (PDT)
Date:   Wed, 20 May 2020 16:06:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, loic.pallardy@st.com, arnaud.pouliquen@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] remoteproc: Add new operation and flags for
 synchronistation
Message-ID: <20200520220653.GA23552@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-4-mathieu.poirier@linaro.org>
 <20200506002253.GC2329931@builder.lan>
 <20200508210123.GA5650@xps15>
 <20200514013224.GE16107@builder.lan>
 <20200515192443.GA24201@xps15>
 <20200519005500.GR2165@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519005500.GR2165@builder.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 05:55:00PM -0700, Bjorn Andersson wrote:
> On Fri 15 May 12:24 PDT 2020, Mathieu Poirier wrote:
> 
> > Good day Bjorn,
> > 
> > On Wed, May 13, 2020 at 06:32:24PM -0700, Bjorn Andersson wrote:
> > > On Fri 08 May 14:01 PDT 2020, Mathieu Poirier wrote:
> > > 
> > > > On Tue, May 05, 2020 at 05:22:53PM -0700, Bjorn Andersson wrote:
> > > > > On Fri 24 Apr 13:01 PDT 2020, Mathieu Poirier wrote:
> > > > > 
> > > > > > Add a new sync_ops to support use cases where the remoteproc
> > > > > > core is synchronising with the remote processor.  Exactly when to use
> > > > > > the synchronisation operations is directed by the flags in structure
> > > > > > rproc_sync_flags.
> > > > > > 
> > > > > 
> > > > > I'm sorry, but no matter how many times I read these patches I have to
> > > > > translate "synchronising" to "remote controlled", and given the number
> > > > > of comments clarifying this makes me feel that we could perhaps come up
> > > > > with a better name?
> > > > 
> > > > "remote controlled" as in "someone else is managing the remote processor" ?
> > > > It could also mean the remoteproc core is "remote controlling" the
> > > > remote processor, exactly what it currently does today...
> > > > 
> > > 
> > > You're right and this would certainly not help the confusion.
> > > 
> > > > How about "autonomous", as in the remote processor doesn't need us to boot or
> > > > switch it off.  I'm open to any other suggestions.
> > > > 
> > > > > 
> > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > ---
> > > > > >  include/linux/remoteproc.h | 24 ++++++++++++++++++++++++
> > > > > >  1 file changed, 24 insertions(+)
> > > > > > 
> > > > > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > > > > > index ac4082f12e8b..ceb3b2bba824 100644
> > > > > > --- a/include/linux/remoteproc.h
> > > > > > +++ b/include/linux/remoteproc.h
> > > > > > @@ -353,6 +353,23 @@ enum rsc_handling_status {
> > > > > >  	RSC_IGNORED	= 1,
> > > > > >  };
> > > > > >  
> > > > > > +/**
> > > > > > + * struct rproc_sync_flags - platform specific flags indicating which
> > > > > > + *			      rproc_ops to use at specific times during
> > > > > > + *			      the rproc lifecycle.
> > > > > > + * @on_init: true if synchronising with the remote processor at
> > > > > > + *	     initialisation time
> > > > > > + * @after_stop: true if synchronising with the remote processor after it was
> > > > > > + *		stopped from the cmmand line
> > > > > > + * @after_crash: true if synchronising with the remote processor after
> > > > > > + *		 it has crashed
> > > > > > + */
> > > > > > +struct rproc_sync_flags {
> > > > > > +	bool on_init;
> > > > > 
> > > > > This indirectly splits the RPROC_OFFLINE state in an "offline" and
> > > > > "already-booted" state. Wouldn't it be clearer to represent this with a
> > > > > new RPROC_ALREADY_BOOTED state?
> > > > > 
> > > > 
> > > > I suggested that at some point in the past but it was in a different context.  I
> > > > will revisit to see how doing so could apply here.
> > > > 
> > > 
> > > How about we introduce a new state named DETACHED and make the platform
> > > drivers specify that the remote processor is in either OFFLINE (as
> > > today) or DETACHED during initialization.
> > 
> > That is certainly an idea that is growing on me.  Up to now I used the on_init
> > flag to express duality in the OFFLINE state.  But based on the comments that came
> > back from yourself, Arnaud and Suman it is clear that my approach is anything
> > but clear.  As such I am eager to try something else.
> > 
> > > 
> > > Then on_init = true would be the action of going from DETACHED to
> > > RUNNING, which would involve the following actions:
> > > 
> > > 1) find resource table
> > > 2) prepare device (?)
> > > 3) handle resources
> > > 4) allocate carveouts (?)
> > > 5) prepare subdevices
> > > 6) "attach"
> > > 7) start subdevices
> > > 
> > > on_init = false would represent the transition from OFFLINE to RUNNING,
> > > which today involve the following actions:
> > > 
> > > 1) request firmware
> > > 2) prepare device
> > > 3) parse fw
> > > 4) handle resources
> > > 5) allocate carveouts
> > > 6) load segments
> > > 7) find resource table
> > > 8) prepare subdevices
> > > 9) "boot"
> > > 10) start subdevices
> > 
> > If we add a DETACHED state I don't see a scenario where we need the on_init
> > variable.  When DETACHED is set by the platform we know the MCU is running and
> > it becomes a matter of when the core attach to it, i.e at initialisation time or
> > once the kernel has finished booting, and that is already taken care of by the
> > auto_boot variable.  
> > 
> > The steps you have outlined above to describe the transitions are accurate.
> > 
> 
> Thanks for confirming.
> 
> I think it would be helpful if we had this properly documented in the
> driver, to facilitate reasoning about the various transitions. I'll try
> to write down my notes in a patch and send it out.
> 
> > > 
> > > > > > +	bool after_stop;
> > > > > 
> > > > > What does it mean when this is true? That Linux can shut the remote core
> > > > > down, but someone else will start it?
> > > > 
> > > > It tells the remoteproc core how to interact with the remote processor after the
> > > > latter has been switched off.
> > > 
> > > Understood.
> > > 
> > > > For example, we could want to boot the remote
> > > > processor from the boot loader so that minimal functionality can be provided
> > > > while the kernel boots.  Once the kernel and user space are in place, the remote
> > > > processor is explicitly stopped and booted once again, but this time with a
> > > > firmware image that offers full functionality.
> > > > 
> > > 
> > > This would be the { on_init = true, after_stop = false } use case, with
> > > the new state would relate to the journey of DETACHED -> RUNNING ->
> > > OFFLINE.
> > 
> > Yes
> > 
> > > 
> > > As such the next boot would represent above OFFLINE -> RUNNING case,
> > > which we already support today.
> > 
> > Correct.  This is the level of functionality sought by ST and TI.  Xilinx seems to
> > have the same requirements as well.
> > 
> 
> Good.
> 
> > > 
> > > > It could also be that the remoteproc core can stop the remote processor, but the
> > > > remote processor will automatically reboot itself.  In that case the remoteproc
> > > > core will simply synchronise with the remote processor, as it does when .on_init
> > > > == true.
> > > > 
> > > 
> > > I've not been able to come up with a reasonable use case for the {
> > > on_init = ture, after_stop = true } scenario.
> > 
> > That one is a little trickier - see the next comment.
> > 
> > > 
> > > But Wendy previously talked about the need to "detach" Linux from a
> > > running remote processor, by somehow just letting it know that the
> > > communication is down - to allow Linux to be rebooted while the remote
> > > was running. So if we support a transition from RUNNING to DETACHED
> > > using a sequence of something like:
> > > 
> > > 1) stop subdevices
> > > 2) "detach"
> > > 3) unprepare subdevices
> > > 4) release carveouts (?)
> > > 5) unprepare device (?)
> > > 
> > > Then perhaps the after_stop could naturally be the transition from
> > > DETACHED to RUNNING, either with or without a reboot of the system
> > > in between?
> > 
> > I see two scenarios for after_stop == true:
> > 
> > 1) A "detach" scenario as you mentioned above.  In this case the stop() function
> > would inform (using a mechanism that is platform specific) the MCU that the core
> > is shutting down.  In this case the MCU would put itself back in "waiting mode",
> > waiting for the core to show signs of life again.  On the core side this would
> > be a DETACHED to RUNNING transition.  Wheter the application processor reboots
> > or not should not be relevant to the MCU.
> > 
> 
> Right and after reading the stm32 patches, for drivers with a way to
> "detach" the remote, i.e. put it back in DETACHED state, a
> rmmod/modprobe should conceptually fit very well.
> 
> > 2) An "MCU reboot in autonomous mode" scenario.  Here the stop() function would
> > switch off the MCU.  From there the MCU could automatically restarts itself or
> > be restarted by some other entity.  In this scenario I would expect the start()
> > function to block until the MCU is ready to proceed with the rest of the
> > remoteproc core initialisation steps.
> > 
> 
> Presumably though the NXP driver wouldn't have a mechanism to "start"
> the core, only to "attach" to it. And that would wait for it to be up
> and running again.
> 
> > From a remoteproc core perspective, both are handled by a DETACHED -> RUNNING
> > transition.  This is the functionality NXP is looking for.   
> > 
> 
> Agreed.
> 
> > > 
> > > > > 
> > > > > > +	bool after_crash;
> > > > > 
> > > > > Similarly what is the expected steps to be taken by the core when this
> > > > > is true? Should rproc_report_crash() simply stop/start the subdevices
> > > > > and upon one of the ops somehow tell the remote controller that it can
> > > > > proceed with the recovery?
> > > > 
> > > > The exact same sequence of steps will be carried out as they are today, except
> > > > that if after_crash == true, the remoteproc core won't be switching the remote
> > > > processor on, exactly as it would do when on_init == true.
> > > > 
> > > 
> > > Just to make sure we're on the same page:
> > > 
> > > after_crash = false is what we have today, and would mean:
> > > 
> > > 1) stop subdevices
> > > 2) power off
> > > 3) unprepare subdevices
> > > 4) generate coredump
> > > 5) request firmware
> > > 6) load segments
> > > 7) find resource table
> > > 8) prepare subdevices
> > > 9) "boot"
> > > 10) start subdevices
> > 
> > Exactly
> > 
> > > 
> > > after_crash = true would mean:
> > > 
> > > 1) stop subdevices
> > > 2) "detach"
> > > 3) unprepare subdevices
> > > 4) prepare subdevices
> > > 5) "attach"
> > > 6) start subdevices
> > >
> > 
> > Yes
> >  
> > > State diagram wise both of these would represent the transition RUNNING
> > > -> CRASHED -> RUNNING, but somehow the platform driver needs to be able
> > > to specify which of these sequences to perform. Per your naming
> > > suggestion above, this does sound like a "autonomous_recovery" boolean
> > > to me.
> > 
> > Right, semantically "rproc->autonomous" would apply quite well.
> > 
> > In function rproc_crash_handler_work(), a call to rproc_set_sync_flag() has been
> > strategically placed to set the value of rproc->autonomous based on
> > "after_crash".  From there the core knows which rproc_ops to use.  Here too we
> > have to rely on the rproc_ops provided by the platform to do the right thing
> > based on the scenario to enact.
> > 
> 
> Do you think that autonomous_recovery would be something that changes
> for a given remoteproc instance? I envisioned it as something that you
> know at registration time, but perhaps I'm missing some details here.

I don't envision any of the transision flags to change once they are set by the
platform.   The same applies to the new rproc_ops, it can be set only once.
Otherwise combination of possible scenarios becomes too hard to manage, leading
to situations where the core and MCU get out of sync and can't talk to each
other.

> 
> > > 
> > > > These flags are there to indicate how to set rproc::sync_with_rproc after
> > > > different events, that is when the remoteproc core boots, when the remoteproc
> > > > has been stopped or when it has crashed.
> > > > 
> > > 
> > > Right, that was clear from your patches. Sorry that my reply didn't
> > > convey the information that I had understood this.
> > > 
> > > > > 
> > > > > > +};
> > > > > > +
> > > > > >  /**
> > > > > >   * struct rproc_ops - platform-specific device handlers
> > > > > >   * @start:	power on the device and boot it
> > > > > > @@ -459,6 +476,9 @@ struct rproc_dump_segment {
> > > > > >   * @firmware: name of firmware file to be loaded
> > > > > >   * @priv: private data which belongs to the platform-specific rproc module
> > > > > >   * @ops: platform-specific start/stop rproc handlers
> > > > > > + * @sync_ops: platform-specific start/stop rproc handlers when
> > > > > > + *	      synchronising with a remote processor.
> > > > > > + * @sync_flags: Determine the rproc_ops to choose in specific states.
> > > > > >   * @dev: virtual device for refcounting and common remoteproc behavior
> > > > > >   * @power: refcount of users who need this rproc powered up
> > > > > >   * @state: state of the device
> > > > > > @@ -482,6 +502,7 @@ struct rproc_dump_segment {
> > > > > >   * @table_sz: size of @cached_table
> > > > > >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> > > > > >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > > > > > + * @sync_with_rproc: true if currently synchronising with the rproc
> > > > > >   * @dump_segments: list of segments in the firmware
> > > > > >   * @nb_vdev: number of vdev currently handled by rproc
> > > > > >   */
> > > > > > @@ -492,6 +513,8 @@ struct rproc {
> > > > > >  	const char *firmware;
> > > > > >  	void *priv;
> > > > > >  	struct rproc_ops *ops;
> > > > > > +	struct rproc_ops *sync_ops;
> > > > > 
> > > > > Do we really need two rproc_ops, given that both are coming from the
> > > > > platform driver and the sync_flags will define which one to look at?
> > > > > 
> > > > > Can't the platform driver just provide an ops table that works with the
> > > > > flags it passes?
> > > > 
> > > > That is the approach Loic took in a previous patchset [1] and that was rejected.
> > > > It also lead to all of the platform drivers testing rproc->flag before carring
> > > > different actions, something you indicated could be done in the core.  This
> > > > patch does exactly that, i.e move the testing of rproc->flag to the core and
> > > > calls the right function based on that.
> > > > 
> > > 
> > > I think I see what you mean, as we use "start" for both syncing and
> > > starting the core, a { on_init = true, after_stop = false } setup either
> > > needs two tables or force conditionals on the platform driver.
> > > 
> > > > The end result is the same and I'm happy with one or the other, I will need to
> > > > know which one.
> > > > 
> > > 
> > > How about adding a new ops named "attach" to rproc_ops, which the
> > > platform driver can specify if it supports attaching an already running
> > > processor?
> > 
> > Using "attach_ops" works for me.  But would "autonomous_ops", to correlate with
> > rproc::autonomous, add clarity?  Either way work equally well for me. 
> > 
> 
> What I meant was that we add a function "attach" to the existing
> rproc_ops. In the case of OFFLINE->RUNNING we continue to call
> rproc->ops->start() and DETACHED->RUNNING we call this
> rproc->ops->attach().

If I read the above properly we'd end up with:

struct rproc_ops {
	int (*start)(struct rproc *rproc);
	int (*stop)(struct rproc *rproc);
	int (*attach)(struct rproc *rproc);
	int (*detach)(struct rproc *rproc);
        ...
        ...
};

But wed'd have to deal with other operations that are common to both scenarios
such as parse_fw() and find_loaded_rsc_table().  

So far lot of improvement have already been suggested on this revision.  I
suggest to spin off a new patchset that only handles the DETACHED->RUNNING
scenario and split common functions such as rproc_fw_boot().  From there we can
see if other refinements (such as what you suggest above) are mandated.

One last thing...  Upon reflecting on all this I think using "attach" is better
than "autonomous", the latter is heavy to drag around.

Thanks,
Mathieu

> 
> As I thought about this I saw that the "autonomous" part would only
> apply to the scenario where the remote recovers from crashes by itself
> (and we just need to be in sync with that). But I've not yet fully
> thought through the NXP case of a stopped remote processor restarting by
> itself.
> 
> > > 
> > > > The advantage with the approach I'm proposing is that everything is controlled
> > > > in the core, i.e what ops is called and when to set rproc->flag based on
> > > > different states the remote processor transitions through.
> > > > 
> > > 
> > > I still think keeping things in the core is the right thing to do.
> > >
> > 
> > Let's continue down that path then.
> >  
> > > 
> > > Please let me know what you think!
> > 
> > From the above conversion I believe our views are pretty much aligned.
> > 
> 
> I share this belief and am looking forward to v4.
> 
> Regards,
> Bjorn
> 
> > > 
> > > PS. If we agree on this the three transitions becomes somewhat
> > > independent, so I think it makes sense to first land support for the
> > > DETACHED -> RUNNING transition (and the stm32 series), then follow up
> > > with RUNNING -> DETACHED and autonomous recovery separately.
> > 
> > We can certainly proceed that way.
> > 
> > Thanks for the time,
> > Mathieu
> > 
> > > 
> > > Regards,
> > > Bjorn
> > > 
> > > > Thanks,
> > > > Mathieu
> > > > 
> > > > 
> > > > [1]. https://patchwork.kernel.org/patch/11265869/
> > > > 
> > > > > 
> > > > > Regards,
> > > > > Bjorn
> > > > > 
> > > > > > +	struct rproc_sync_flags sync_flags;
> > > > > >  	struct device dev;
> > > > > >  	atomic_t power;
> > > > > >  	unsigned int state;
> > > > > > @@ -515,6 +538,7 @@ struct rproc {
> > > > > >  	size_t table_sz;
> > > > > >  	bool has_iommu;
> > > > > >  	bool auto_boot;
> > > > > > +	bool sync_with_rproc;
> > > > > >  	struct list_head dump_segments;
> > > > > >  	int nb_vdev;
> > > > > >  	u8 elf_class;
> > > > > > -- 
> > > > > > 2.20.1
> > > > > > 
