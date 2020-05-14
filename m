Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC906C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C866A205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0p70ta2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgENBd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725952AbgENBd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:33:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814F5C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:33:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so540601plt.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uPBv13YNIpnE01+FufDIxIvgCXATu26iJwo4yyFvn0Q=;
        b=H0p70ta2nD/CM2VktcBAYj5W/87vh9d/jR7kSWR0Ns+CnQObtj6mvujb5YOmLzks+A
         S/hLpWlf3NTnFD/DsKfCXW4hwT7HqOmESANJbkIKtqEPLKBBvG+/G+r/EiLm/ooSI9mG
         Rcba8yR1zyQYKog1d1mW2pv0504zhUvB+W4CQuQ+CV4AZlVUwwfF1vUBJROvF13cPB/v
         EYSkrsGTpnmxBC/9aDlShtha70OZiy0FU6ySYjD+xs/ePHk1eG/iqem6FLzQGEUQT+nf
         jD7av9in8Xeo7kcWJUTZneUNS4KaI9IUkV+/uQawBb1FuO8x96pkSSypsVASX6girqId
         moNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uPBv13YNIpnE01+FufDIxIvgCXATu26iJwo4yyFvn0Q=;
        b=hN1u2u+mwmajrFLTkNVruGg591s78G+QEnIUs5qNr30o+0IaDB2tSz+2zfdv8EPweA
         /foB9Bb4SkxbmYBimlXFYEWF8tbEV6suMQ9e/sMcwzM92P3lfM7TbLIC4/haHZqaY7nP
         AZQoKAm1r/sqDUljkODf4pzEwZ7+rhvE/FVqEx4J8X23BHJj1RaPTERIali2EV7QIKB4
         m/Y+WLbQAlxoxuim0jC8qct7IMqubjmfHorZpSfkxNGse/wkdhDxX/S2HTNu9oVS3dP1
         i2+m9AJxA6qOImDkgvQl5SmZ1tiirdLdfUj5CYFiRK1vY1ZVWpDpjLfPMXpzEh8UIgLt
         Gujw==
X-Gm-Message-State: AGi0PuaXM19HcXbHjG/cUk6v9wQKzKmapK/rwVIqxOvvuQ55FP74Zz1w
        vDna6BCSJ/7YI+MSn78a/flg9Q==
X-Google-Smtp-Source: APiQypKItvF68HLkOi+03zbaMK25OwHB3hndmE3AWEMAT0aJnkyQd/Qif7ujyHQkH172I/bkZVmdHg==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr36950089pjb.211.1589420035718;
        Wed, 13 May 2020 18:33:55 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c124sm677638pfb.187.2020.05.13.18.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 18:33:54 -0700 (PDT)
Date:   Wed, 13 May 2020 18:32:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, loic.pallardy@st.com, arnaud.pouliquen@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] remoteproc: Add new operation and flags for
 synchronistation
Message-ID: <20200514013224.GE16107@builder.lan>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-4-mathieu.poirier@linaro.org>
 <20200506002253.GC2329931@builder.lan>
 <20200508210123.GA5650@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508210123.GA5650@xps15>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 May 14:01 PDT 2020, Mathieu Poirier wrote:

> On Tue, May 05, 2020 at 05:22:53PM -0700, Bjorn Andersson wrote:
> > On Fri 24 Apr 13:01 PDT 2020, Mathieu Poirier wrote:
> > 
> > > Add a new sync_ops to support use cases where the remoteproc
> > > core is synchronising with the remote processor.  Exactly when to use
> > > the synchronisation operations is directed by the flags in structure
> > > rproc_sync_flags.
> > > 
> > 
> > I'm sorry, but no matter how many times I read these patches I have to
> > translate "synchronising" to "remote controlled", and given the number
> > of comments clarifying this makes me feel that we could perhaps come up
> > with a better name?
> 
> "remote controlled" as in "someone else is managing the remote processor" ?
> It could also mean the remoteproc core is "remote controlling" the
> remote processor, exactly what it currently does today...
> 

You're right and this would certainly not help the confusion.

> How about "autonomous", as in the remote processor doesn't need us to boot or
> switch it off.  I'm open to any other suggestions.
> 
> > 
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >  include/linux/remoteproc.h | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > > index ac4082f12e8b..ceb3b2bba824 100644
> > > --- a/include/linux/remoteproc.h
> > > +++ b/include/linux/remoteproc.h
> > > @@ -353,6 +353,23 @@ enum rsc_handling_status {
> > >  	RSC_IGNORED	= 1,
> > >  };
> > >  
> > > +/**
> > > + * struct rproc_sync_flags - platform specific flags indicating which
> > > + *			      rproc_ops to use at specific times during
> > > + *			      the rproc lifecycle.
> > > + * @on_init: true if synchronising with the remote processor at
> > > + *	     initialisation time
> > > + * @after_stop: true if synchronising with the remote processor after it was
> > > + *		stopped from the cmmand line
> > > + * @after_crash: true if synchronising with the remote processor after
> > > + *		 it has crashed
> > > + */
> > > +struct rproc_sync_flags {
> > > +	bool on_init;
> > 
> > This indirectly splits the RPROC_OFFLINE state in an "offline" and
> > "already-booted" state. Wouldn't it be clearer to represent this with a
> > new RPROC_ALREADY_BOOTED state?
> > 
> 
> I suggested that at some point in the past but it was in a different context.  I
> will revisit to see how doing so could apply here.
> 

How about we introduce a new state named DETACHED and make the platform
drivers specify that the remote processor is in either OFFLINE (as
today) or DETACHED during initialization.

Then on_init = true would be the action of going from DETACHED to
RUNNING, which would involve the following actions:

1) find resource table
2) prepare device (?)
3) handle resources
4) allocate carveouts (?)
5) prepare subdevices
6) "attach"
7) start subdevices

on_init = false would represent the transition from OFFLINE to RUNNING,
which today involve the following actions:

1) request firmware
2) prepare device
3) parse fw
4) handle resources
5) allocate carveouts
6) load segments
7) find resource table
8) prepare subdevices
9) "boot"
10) start subdevices

> > > +	bool after_stop;
> > 
> > What does it mean when this is true? That Linux can shut the remote core
> > down, but someone else will start it?
> 
> It tells the remoteproc core how to interact with the remote processor after the
> latter has been switched off.

Understood.

> For example, we could want to boot the remote
> processor from the boot loader so that minimal functionality can be provided
> while the kernel boots.  Once the kernel and user space are in place, the remote
> processor is explicitly stopped and booted once again, but this time with a
> firmware image that offers full functionality.
> 

This would be the { on_init = true, after_stop = false } use case, with
the new state would relate to the journey of DETACHED -> RUNNING ->
OFFLINE.

As such the next boot would represent above OFFLINE -> RUNNING case,
which we already support today.

> It could also be that the remoteproc core can stop the remote processor, but the
> remote processor will automatically reboot itself.  In that case the remoteproc
> core will simply synchronise with the remote processor, as it does when .on_init
> == true.
> 

I've not been able to come up with a reasonable use case for the {
on_init = ture, after_stop = true } scenario.

But Wendy previously talked about the need to "detach" Linux from a
running remote processor, by somehow just letting it know that the
communication is down - to allow Linux to be rebooted while the remote
was running. So if we support a transition from RUNNING to DETACHED
using a sequence of something like:

1) stop subdevices
2) "detach"
3) unprepare subdevices
4) release carveouts (?)
5) unprepare device (?)

Then perhaps the after_stop could naturally be the transition from
DETACHED to RUNNING, either with or without a reboot of the system
in between?

> > 
> > > +	bool after_crash;
> > 
> > Similarly what is the expected steps to be taken by the core when this
> > is true? Should rproc_report_crash() simply stop/start the subdevices
> > and upon one of the ops somehow tell the remote controller that it can
> > proceed with the recovery?
> 
> The exact same sequence of steps will be carried out as they are today, except
> that if after_crash == true, the remoteproc core won't be switching the remote
> processor on, exactly as it would do when on_init == true.
> 

Just to make sure we're on the same page:

after_crash = false is what we have today, and would mean:

1) stop subdevices
2) power off
3) unprepare subdevices
4) generate coredump
5) request firmware
6) load segments
7) find resource table
8) prepare subdevices
9) "boot"
10) start subdevices

after_crash = true would mean:

1) stop subdevices
2) "detach"
3) unprepare subdevices
4) prepare subdevices
5) "attach"
6) start subdevices

State diagram wise both of these would represent the transition RUNNING
-> CRASHED -> RUNNING, but somehow the platform driver needs to be able
to specify which of these sequences to perform. Per your naming
suggestion above, this does sound like a "autonomous_recovery" boolean
to me.

> These flags are there to indicate how to set rproc::sync_with_rproc after
> different events, that is when the remoteproc core boots, when the remoteproc
> has been stopped or when it has crashed.
> 

Right, that was clear from your patches. Sorry that my reply didn't
convey the information that I had understood this.

> > 
> > > +};
> > > +
> > >  /**
> > >   * struct rproc_ops - platform-specific device handlers
> > >   * @start:	power on the device and boot it
> > > @@ -459,6 +476,9 @@ struct rproc_dump_segment {
> > >   * @firmware: name of firmware file to be loaded
> > >   * @priv: private data which belongs to the platform-specific rproc module
> > >   * @ops: platform-specific start/stop rproc handlers
> > > + * @sync_ops: platform-specific start/stop rproc handlers when
> > > + *	      synchronising with a remote processor.
> > > + * @sync_flags: Determine the rproc_ops to choose in specific states.
> > >   * @dev: virtual device for refcounting and common remoteproc behavior
> > >   * @power: refcount of users who need this rproc powered up
> > >   * @state: state of the device
> > > @@ -482,6 +502,7 @@ struct rproc_dump_segment {
> > >   * @table_sz: size of @cached_table
> > >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> > >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > > + * @sync_with_rproc: true if currently synchronising with the rproc
> > >   * @dump_segments: list of segments in the firmware
> > >   * @nb_vdev: number of vdev currently handled by rproc
> > >   */
> > > @@ -492,6 +513,8 @@ struct rproc {
> > >  	const char *firmware;
> > >  	void *priv;
> > >  	struct rproc_ops *ops;
> > > +	struct rproc_ops *sync_ops;
> > 
> > Do we really need two rproc_ops, given that both are coming from the
> > platform driver and the sync_flags will define which one to look at?
> > 
> > Can't the platform driver just provide an ops table that works with the
> > flags it passes?
> 
> That is the approach Loic took in a previous patchset [1] and that was rejected.
> It also lead to all of the platform drivers testing rproc->flag before carring
> different actions, something you indicated could be done in the core.  This
> patch does exactly that, i.e move the testing of rproc->flag to the core and
> calls the right function based on that.
> 

I think I see what you mean, as we use "start" for both syncing and
starting the core, a { on_init = true, after_stop = false } setup either
needs two tables or force conditionals on the platform driver.

> The end result is the same and I'm happy with one or the other, I will need to
> know which one.
> 

How about adding a new ops named "attach" to rproc_ops, which the
platform driver can specify if it supports attaching an already running
processor?

> The advantage with the approach I'm proposing is that everything is controlled
> in the core, i.e what ops is called and when to set rproc->flag based on
> different states the remote processor transitions through.
> 

I still think keeping things in the core is the right thing to do.


Please let me know what you think!

PS. If we agree on this the three transitions becomes somewhat
independent, so I think it makes sense to first land support for the
DETACHED -> RUNNING transition (and the stm32 series), then follow up
with RUNNING -> DETACHED and autonomous recovery separately.

Regards,
Bjorn

> Thanks,
> Mathieu
> 
> 
> [1]. https://patchwork.kernel.org/patch/11265869/
> 
> > 
> > Regards,
> > Bjorn
> > 
> > > +	struct rproc_sync_flags sync_flags;
> > >  	struct device dev;
> > >  	atomic_t power;
> > >  	unsigned int state;
> > > @@ -515,6 +538,7 @@ struct rproc {
> > >  	size_t table_sz;
> > >  	bool has_iommu;
> > >  	bool auto_boot;
> > > +	bool sync_with_rproc;
> > >  	struct list_head dump_segments;
> > >  	int nb_vdev;
> > >  	u8 elf_class;
> > > -- 
> > > 2.20.1
> > > 
