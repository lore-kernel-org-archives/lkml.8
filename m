Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29373C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 05:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0269620738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 05:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAgGtVkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEUFWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 01:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgEUFWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 01:22:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878DAC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 22:22:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so2627704pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 22:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cbk5lZhqlis2bxujLFznrj+UfeuImdmjl57S359SPKM=;
        b=eAgGtVkdJ67nciA39cs7Yp+PyWJrz58wtO1dsmQm6jSARIVTwNLOCyIynXeWThDTAo
         82dQwhRxqU1SHB3rDy5SiUKGrMCgS6NuMksvA5oFZ5LonY+4EkkQrH/Px6EP3cUtQG5p
         LasLP+Aa+XWKKb0/aF97GMd6grIxoQ6NgGPPxc/Gg/Z+jRket13JseLV9GSvbfOROHht
         R1tM0iBMb3HCb+7247q1Y3wcF08c4uZ2CgMhn1DWm6frgm32+Hcl5WRhfAAAbkZLbW2h
         8RF4DZGqP8bQRoOjIBX1D0fmeubTW+7ZTY6hFlGco7hZ2iGuTD64UapIrvpMQvWtwykx
         1QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cbk5lZhqlis2bxujLFznrj+UfeuImdmjl57S359SPKM=;
        b=DwwvAXSPS29ngFCaxaBlXYoTZs4OTFMSNHDvCen41IF4CUzRJNtpxCWTHWi3gt13Lu
         cGa1fsenFISq15f2DSuyB5zi2DcyBnJ/tUUWZlyg6Bjk7ygT2ai/zTrApo57gewU0uiz
         aEK2iP2NZ0UNuCOiXCmpgHfToDVizXdJF+0AkieZI16R9sbE8HUXt+8Yvn36gAF0hb64
         OyBdXZvasVTKIikPrhqUxaytswpdO9y04FqA9uqZzKWCWapWMfkjcBg0NasFk3F1S3vM
         fgeKmCnJpdVyl/l7wV9iNn1OR5OiACY9T2db0gBNZCRBehH/5PIc18hUtYkXyArMmc9X
         kc3w==
X-Gm-Message-State: AOAM530RPYhjepK5Tf9V3tepdTdeRalnj5AJVO7n9v6NkJv9MjYibB1P
        0cQ8zyEyPP5UedMmqYg16Zmxkw==
X-Google-Smtp-Source: ABdhPJz7tnpBAEZ9DxFPVHAAwuDfWN/hSeGwCJDIO1eltL+fVJ7Z5N370p19CthavsG5/ULZO1dSJg==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr7578503pff.95.1590038519568;
        Wed, 20 May 2020 22:21:59 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 10sm3381218pfx.138.2020.05.20.22.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 22:21:58 -0700 (PDT)
Date:   Wed, 20 May 2020 22:21:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, loic.pallardy@st.com, arnaud.pouliquen@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] remoteproc: Add new operation and flags for
 synchronistation
Message-ID: <20200521052155.GE11847@yoga>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-4-mathieu.poirier@linaro.org>
 <20200506002253.GC2329931@builder.lan>
 <20200508210123.GA5650@xps15>
 <20200514013224.GE16107@builder.lan>
 <20200515192443.GA24201@xps15>
 <20200519005500.GR2165@builder.lan>
 <20200520220653.GA23552@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520220653.GA23552@xps15>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 May 15:06 PDT 2020, Mathieu Poirier wrote:

> On Mon, May 18, 2020 at 05:55:00PM -0700, Bjorn Andersson wrote:
> > On Fri 15 May 12:24 PDT 2020, Mathieu Poirier wrote:
> > 
> > > Good day Bjorn,
> > > 
> > > On Wed, May 13, 2020 at 06:32:24PM -0700, Bjorn Andersson wrote:
> > > > On Fri 08 May 14:01 PDT 2020, Mathieu Poirier wrote:
> > > > 
> > > > > On Tue, May 05, 2020 at 05:22:53PM -0700, Bjorn Andersson wrote:
> > > > > > On Fri 24 Apr 13:01 PDT 2020, Mathieu Poirier wrote:
[..]
> > > > > > > +	bool after_crash;
> > > > > > 
> > > > > > Similarly what is the expected steps to be taken by the core when this
> > > > > > is true? Should rproc_report_crash() simply stop/start the subdevices
> > > > > > and upon one of the ops somehow tell the remote controller that it can
> > > > > > proceed with the recovery?
> > > > > 
> > > > > The exact same sequence of steps will be carried out as they are today, except
> > > > > that if after_crash == true, the remoteproc core won't be switching the remote
> > > > > processor on, exactly as it would do when on_init == true.
> > > > > 
> > > > 
> > > > Just to make sure we're on the same page:
> > > > 
> > > > after_crash = false is what we have today, and would mean:
> > > > 
> > > > 1) stop subdevices
> > > > 2) power off
> > > > 3) unprepare subdevices
> > > > 4) generate coredump
> > > > 5) request firmware
> > > > 6) load segments
> > > > 7) find resource table
> > > > 8) prepare subdevices
> > > > 9) "boot"
> > > > 10) start subdevices
> > > 
> > > Exactly
> > > 
> > > > 
> > > > after_crash = true would mean:
> > > > 
> > > > 1) stop subdevices
> > > > 2) "detach"
> > > > 3) unprepare subdevices
> > > > 4) prepare subdevices
> > > > 5) "attach"
> > > > 6) start subdevices
> > > >
> > > 
> > > Yes
> > >  
> > > > State diagram wise both of these would represent the transition RUNNING
> > > > -> CRASHED -> RUNNING, but somehow the platform driver needs to be able
> > > > to specify which of these sequences to perform. Per your naming
> > > > suggestion above, this does sound like a "autonomous_recovery" boolean
> > > > to me.
> > > 
> > > Right, semantically "rproc->autonomous" would apply quite well.
> > > 
> > > In function rproc_crash_handler_work(), a call to rproc_set_sync_flag() has been
> > > strategically placed to set the value of rproc->autonomous based on
> > > "after_crash".  From there the core knows which rproc_ops to use.  Here too we
> > > have to rely on the rproc_ops provided by the platform to do the right thing
> > > based on the scenario to enact.
> > > 
> > 
> > Do you think that autonomous_recovery would be something that changes
> > for a given remoteproc instance? I envisioned it as something that you
> > know at registration time, but perhaps I'm missing some details here.
> 
> I don't envision any of the transision flags to change once they are set by the
> platform.   The same applies to the new rproc_ops, it can be set only once.
> Otherwise combination of possible scenarios becomes too hard to manage, leading
> to situations where the core and MCU get out of sync and can't talk to each
> other.
> 

Sounds good, I share this expectation, just wanted to check with you.

> > 
> > > > 
> > > > > These flags are there to indicate how to set rproc::sync_with_rproc after
> > > > > different events, that is when the remoteproc core boots, when the remoteproc
> > > > > has been stopped or when it has crashed.
> > > > > 
> > > > 
> > > > Right, that was clear from your patches. Sorry that my reply didn't
> > > > convey the information that I had understood this.
> > > > 
> > > > > > 
> > > > > > > +};
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * struct rproc_ops - platform-specific device handlers
> > > > > > >   * @start:	power on the device and boot it
> > > > > > > @@ -459,6 +476,9 @@ struct rproc_dump_segment {
> > > > > > >   * @firmware: name of firmware file to be loaded
> > > > > > >   * @priv: private data which belongs to the platform-specific rproc module
> > > > > > >   * @ops: platform-specific start/stop rproc handlers
> > > > > > > + * @sync_ops: platform-specific start/stop rproc handlers when
> > > > > > > + *	      synchronising with a remote processor.
> > > > > > > + * @sync_flags: Determine the rproc_ops to choose in specific states.
> > > > > > >   * @dev: virtual device for refcounting and common remoteproc behavior
> > > > > > >   * @power: refcount of users who need this rproc powered up
> > > > > > >   * @state: state of the device
> > > > > > > @@ -482,6 +502,7 @@ struct rproc_dump_segment {
> > > > > > >   * @table_sz: size of @cached_table
> > > > > > >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> > > > > > >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > > > > > > + * @sync_with_rproc: true if currently synchronising with the rproc
> > > > > > >   * @dump_segments: list of segments in the firmware
> > > > > > >   * @nb_vdev: number of vdev currently handled by rproc
> > > > > > >   */
> > > > > > > @@ -492,6 +513,8 @@ struct rproc {
> > > > > > >  	const char *firmware;
> > > > > > >  	void *priv;
> > > > > > >  	struct rproc_ops *ops;
> > > > > > > +	struct rproc_ops *sync_ops;
> > > > > > 
> > > > > > Do we really need two rproc_ops, given that both are coming from the
> > > > > > platform driver and the sync_flags will define which one to look at?
> > > > > > 
> > > > > > Can't the platform driver just provide an ops table that works with the
> > > > > > flags it passes?
> > > > > 
> > > > > That is the approach Loic took in a previous patchset [1] and that was rejected.
> > > > > It also lead to all of the platform drivers testing rproc->flag before carring
> > > > > different actions, something you indicated could be done in the core.  This
> > > > > patch does exactly that, i.e move the testing of rproc->flag to the core and
> > > > > calls the right function based on that.
> > > > > 
> > > > 
> > > > I think I see what you mean, as we use "start" for both syncing and
> > > > starting the core, a { on_init = true, after_stop = false } setup either
> > > > needs two tables or force conditionals on the platform driver.
> > > > 
> > > > > The end result is the same and I'm happy with one or the other, I will need to
> > > > > know which one.
> > > > > 
> > > > 
> > > > How about adding a new ops named "attach" to rproc_ops, which the
> > > > platform driver can specify if it supports attaching an already running
> > > > processor?
> > > 
> > > Using "attach_ops" works for me.  But would "autonomous_ops", to correlate with
> > > rproc::autonomous, add clarity?  Either way work equally well for me. 
> > > 
> > 
> > What I meant was that we add a function "attach" to the existing
> > rproc_ops. In the case of OFFLINE->RUNNING we continue to call
> > rproc->ops->start() and DETACHED->RUNNING we call this
> > rproc->ops->attach().
> 
> If I read the above properly we'd end up with:
> 
> struct rproc_ops {
> 	int (*start)(struct rproc *rproc);
> 	int (*stop)(struct rproc *rproc);
> 	int (*attach)(struct rproc *rproc);
> 	int (*detach)(struct rproc *rproc);
>         ...
>         ...
> };

Yes, that's what I meant.

> 
> But wed'd have to deal with other operations that are common to both scenarios
> such as parse_fw() and find_loaded_rsc_table().  
> 

I would prefer that we don't parse_fw(NULL), perhaps we can turn that
upside down and have the platform_driver just provide the information to
the core as it learns about it during probe?

> So far lot of improvement have already been suggested on this revision.  I
> suggest to spin off a new patchset that only handles the DETACHED->RUNNING
> scenario and split common functions such as rproc_fw_boot().  From there we can
> see if other refinements (such as what you suggest above) are mandated.
> 

As far as I can see, if we take the approach of introducing the DETACHED
state we can add the various transitions piecemeal. So I'm definitely in
favour of starting off with DETACHED->RUNNING, then figure out
"autonomous recovery" and RUNNING->DETACHED in two subsequent series.

> One last thing...  Upon reflecting on all this I think using "attach" is better
> than "autonomous", the latter is heavy to drag around.
> 

For the action of going from DETACHED->RUNNING I too find "attach" to
better represent what's going on. The part where I think we need
something more is to communicate if it's Linux that's in charge or not
for taking the remote processor through RUNNING->CRASHED->RUNNING. For
that the word "autonomous" makes sense to me, but let's bring that up
again after landing this first piece(s).

Regards,
Bjorn
