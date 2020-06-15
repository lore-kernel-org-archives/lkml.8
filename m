Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5D5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDD62067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbTr3728"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgFOLiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:38:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B1C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 04:38:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d27so4753024lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 04:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vMHg+Ylhsphqjn4gUXoftnjcXS/LUuG+Lo5gPl1+kVo=;
        b=BbTr3728/DwOBbhItC/6sHoC6MIAWqNCevMtCSvKxx2lYMiqAso2o7PRvxI0V0lr0/
         czbgb/Otn2PBm3YWRm44rHhukYppHwsa06LNximpGPzajrW2KsINi2Wq7cb7/stfL6+5
         0TbDF63KyEK3yTgI7C/mXV9H+TK5FVNvKwtb4I3VTT6/tmBZjny3Kfl7s6h7TO18ZCC+
         0UYWUepm3FlvTfjHbE3xGRfCY4Ue/hVaRcOAM7AarW1YOyd/4PCcafzgVcDiUil77ACu
         zAuXzr9tVCRI1IWw9B32g9mVuY7SCwmtVhd8EsA1mC7oGYZQSYUIhjM4BxohXAEVWJbn
         G4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vMHg+Ylhsphqjn4gUXoftnjcXS/LUuG+Lo5gPl1+kVo=;
        b=AAGSOoAENhk7i+t+gOSxRZZyIky1yAD4gS4KRM0bcd4Vv8HUOj7BavjVNDCXNv6yTb
         +Xhx4FhiyWblLCV5eO5ETFiMUuM9fwvMFS6DBhdbt6ADUW8y2TqZSk2rBf/vyPbNE48U
         5SW0L9z1KU1vZtmD3SZy1fE+laSpIXTBrHSrveaMhHuD+RIGfsShB/1A6Q3L3A9gkeS7
         Q2zBXjvledhSv3Jm2aXL70u/iLRkMoejgw5KvwKhbdRQsWtId5gf6/Yv5GjTD7ME8ykA
         eagh/r2Z4or/P1/IYDF7ZqhJMqwE2xmAvwkEIM2kEtIqKStCG1EKp37WbbwB6TQCX+UB
         Owzg==
X-Gm-Message-State: AOAM5313iRZUIAvfA5Yxl6e7lzzXPMgIWk1AbOdtZQQwSPkQ0qDUhJLs
        c7wY6hGc8E6G2F76zxdTgNrME5PVI9MJxA==
X-Google-Smtp-Source: ABdhPJw40VZB+Irh1ggpg21MubQ0lHR2ONbXH3h/ifQyHuno/K6xFnAmXx/co1rjzQAAMqRyaEDD9Q==
X-Received: by 2002:ac2:5de1:: with SMTP id z1mr13329029lfq.183.1592221126550;
        Mon, 15 Jun 2020 04:38:46 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id n10sm398660lfb.82.2020.06.15.04.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:38:45 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:38:43 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, tabba@google.com,
        qwandor@google.com, ardb@kernel.org
Subject: Re: [RFC PATCH 0/3] firmware: Add support for PSA FF-A interface
Message-ID: <20200615113843.GA2269951@jade>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200604133746.GA2951@willie-the-truck>
 <20200609174123.GA5732@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200609174123.GA5732@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 09, 2020 at 06:41:23PM +0100, Sudeep Holla wrote:
> (Sorry for the delay, got distracted with some other bug fix.)
> 
> On Thu, Jun 04, 2020 at 02:37:46PM +0100, Will Deacon wrote:
> > Hi Sudeep, [+Fuad, Andrew and Ard]
> >
> > (To other interested readers: if you haven't seen it, the FF-A spec is here:
> >  https://static.docs.arm.com/den0077/a/DEN0077A_PSA_Firmware_Framework_Arm_v8-A_1.0_EAC.pdf
> >  since this discussion makes no sense without that, and a tiny bit of sense
> >  with it. It used to be called "SPCI" but it was recently renamed.)
> >
> 
> Thanks for adding all interested parties.
> 
> > On Mon, Jun 01, 2020 at 10:45:09AM +0100, Sudeep Holla wrote:
> > > Sorry for posting in the middle of merge window and I must have done
> > > this last week itself. This is not the driver I had thought about posting
> > > last week. After I started cleaning up and looking at Will's KVM prototype[1]
> > > for PSA FF-A (previously known as SPCI),
> >
> > Yes, I need to do the Big Rename at some point. Joy.
> >
> 
> 😁 
> 
> > > I got more doubts on alignment and dropped huge chunk of interface APIs in
> > > the driver in order to keep it simple, and get aligned more with that
> > > prototype and avoid scanning lots of code unnecessary.
> >
> > You also dropped most of the code, so this doesn't really do anything in
> > its current form ;)
> >
> 
> Yes, it was intentional 😉 
> 
> > > Here are few things to clarify:
> > >
> > > 1. DT bindings
> > > ---------------
> > > 	I was initially against adding bindings for Tx/Rx buffers for
> > > 	partitions. As per the spec, an endpoint could allocate the
> > > 	buffer pair and use the FFA_RXTX_MAP interface to map it with the
> > > 	Hypervisor(KVM here). However looking at the prototype and also
> > > 	I remember you mentioning that it is not possible to manage buffers
> > > 	in that way. Please confirm if you plan to add the buffer details
> > > 	fetcthing them through ioctls in KVM and adding them to VM DT nodes
> > > 	in KVM userspace. I will update the bindings accordingly.
> >
> > I think it's useful to have a mode of operation where the hypervisor
> > allocates the RX/TX buffers and advertises them in the DT. However, we
> > can always add this later, so there's no need to have it in the binding
> > from the start. Best start as simple as possible, I reckon.
> >
> 
> OK
> 
> > Setting the static RX/TX buffer allocation aside, why is a DT node needed
> > at all for the case where Linux is running purely as an FF-A client? I
> > thought everything should be discoverable via FFA_VERSION, FFA_FEATURES,
> > FFA_PARTITION_INFO_GET and FFA_ID_GET? That should mean we can get away
> > without a binding at all for the client case.
> >
> 
> Agreed, I added for RxTx buffers and initially to build the parent/child
> hierarchy for all users of the driver. Initially I was assuming only
> in-kernel users and now I agree we should avoid any in kernel users if
> possible.
> 
> One thing to note FFA_PARTITION_INFO_GET relies on Rx buffers to send the
> information to the caller. So we need to have established buffers before
> that and one of the reason you don't find that in this RFC. I dropped that
> too which I wanted initially.
> 
> > > 2. Driver
> > > ---------
> > > a. Support for multiple partitions in a VM
> > > ------------------------------------------
> > > 	I am not sure if there is need for supporting multiple partitions
> > > 	within a VM. It should be possible to do so as I expect to create
> > > 	device for each partition entry under arm-psa-ffa devicetree node.
> > > 	However, I don't want to assume something that will never be a
> > > 	usecase. However I don't think this will change must of the
> > > 	abstraction as we need to keep the interface API implementation
> > > 	separate to support different partitions on various platforms.
> >
> > I think Ard has a case for something like this, where a VM actually consists
> > of multiple partitions so that S-EL0 services can be provided from NS-EL0.
> > However, he probably wants that for a dynamically created VM, so we'd
> > need a way to instantiate an FFA namespace for the VM. Maybe that can be
> > done entirely in userspace by the VMM...
> >
> 
> Interesting...
> 
> > > b. SMCCC interface
> > > ------------------
> > > 	This is something I messed up completely while trying to add
> > > 	support for SMCCC v1.2. It now supports x0-x17 as parameter
> > > 	registers(input) and return registers(output). I started simple
> > > 	with x0-x7 as both input and output as PSA FF-A needs that at
> > > 	most. But extending to x0-x17 then became with messy in my
> > > 	implementation. That's the reason I dropped it completely
> > > 	here and thought of checking it first.
> > >
> > > 	Do we need to extend the optimisations that were done to handle
> > > 	ARCH_WORKAROUND_{1,2}. Or should be just use a version with x0-x7
> > > 	as both input and ouput. Hyper-V guys need full x0-x17 support.
> > >
> > > 	I need some guidance as what is the approach preferred ?
> >
> > I think we can start off with x0-x7 and extend if later if we need to.
> >
> 
> Sure
> 
> > > 3. Partitions
> > > -------------
> > > 	I am not sure if we have a full define partition that we plan to
> > > 	push upstream. Without one, we can have a sample/example partition
> > > 	to test all the interface APIs, but is that fine with respect to
> > > 	what we want upstream ? Any other thoughts that helps to test the
> > > 	driver ?
> >
> > I think that's the best you can do for now. We can probably help with
> > testing as our stuff gets off the ground.
> >
> 
> OK
> 
> > > Sorry for long email and too many questions, but I thought it is easier
> > > this way to begin with than throwing huge code implementing loads of APIs
> > > with no users(expect example partition) especially that I am posting this
> > > during merge window.
> >
> > No problem. Maybe it would help if I described roughly what we were thinking
> > of doing for KVM (this is open for discussion, of course):
> >
> >  1. Describe KVM-managed partitions in the DT, along the lines of [1]
> >  2. Expose each partition as a file to userspace. E.g.:
> >
> >     /dev/spci/:
> >
> > 	self
> > 	e3a48fa5-dc54-4a8b-898b-bdc4dfeeb7b8
> > 	49f65057-d002-4ae2-b4ee-d31c7940a13d
> >
> >     Here, self would be a symlink to the host uuid. The host uuid file
> >     would implement FFA_MEM operations using an ioctl(), so you could,
> >     for example, share a user buffer with multiple partitions by issuing
> >     a MEM_SHARE ioctl() on self, passing the fds for the borrower partitions
> >     as arguments. Messaging would be implemented as ioctl()s on the
> >     partition uuid files themselves.
> >
> 
> OK, IIUC that covers mostly KVM implementation. We still need a way to
> share the RxTx buffer info to the partitions and DT/ACPI(?) is one
> possible way. Based on you comment about not needing DT node, do you have
> any other way to communicate the buffer info to the partitions ?
> 
> >  3. We'll need some (all?) of these patches to unmap memory from the host
> >     when necessary:
> >
> >     https://lwn.net/Articles/821215/
> >
> >     (for nVHE, we'll have a stage-2 for the host so we can unmap there as
> >     well)
> >
> 
> Sounds more fun.
> 
> > For communicating with partitions that are not managed by KVM (e.g. trusted
> > applications), it's not clear to me how much of that will be handled in
> > kernel or user. I think it would still be worth exposing the partitions as
> > files, but perhaps having them root only or just returning -EPERM for the
> > ioctl() if a kernel driver has claimed the partition as its own? Ideally,
> > FF-A would allow us to transition some of the Trusted OS interfacing code
> > out to userspace, but I don't know how realistic that is.
> >
> 
> Ah good, so we can still manage in-kernel users this way but we need to
> provide interface to such a driver which I agree that we need to avoid
> if possible.

The OP-TEE driver is an in-kernel user, I don't see that we can migrate
that to user space in the nearest future. In fact I'm not sure it would
make sense since we have a kernel internal interface which is used by
some drivers.

Cheers,
Jens
