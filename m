Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4550C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE3F20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sa8FUH+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgIJRrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgIJRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:46:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0FDC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:46:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r24so1289008pls.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Img1KzooL/0uw/TzN7CSt9+/3Anz+BBtQvOoTrPDO/c=;
        b=sa8FUH+TyHn1LT08LmZVVzYkEj6m8scM9uznkSPJkY8DQYC3XpPecN2tPHo9i2qLKJ
         OVqEU55jB89UwP3muSCwhanobHmtOsG04VehhJNko16cKAqMk1LRawfkrfmtvDaOcTtl
         ixQpaT8XAQaP0VrNrTw7qTYaW0O8zQ90WCsElVL38DUeLZkFcW0zfc9b2a4zGYKg9fPq
         tZZw92QTXI9vekGgewMX85jo0GQrCPLqeyexKf0Gt1rUsnZQGO+GsplCLMDLFvKnQjNJ
         DxadhteQcokzOmd9htszj531SD/WeG8AmgO4tUUMpRNnTTfuccxbMCPzNMkoJqTGvSg1
         1pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Img1KzooL/0uw/TzN7CSt9+/3Anz+BBtQvOoTrPDO/c=;
        b=IiN5pbqRRiN8nMhct3XeniZ8iVbuwhnehwMQFm/l24Cn0o94mYUNiuH/7B7pIZhKox
         1CLbDw2Clrqu6f/m1Upi3grh6C5slSLClerrhoGfWgSFQxoPz/u7tVfsQenCTpldo86C
         0Kr4tHNRecofphba4tqABvUl/Dvxbqp/PO+z6gc0vdXJodGSUgQXMOCYuugijcFsUNn2
         EQJwXsfW94sKRR10yDFPKgzDW0sswUkxqYpIUmf+5LA1QA7HTSZAlnjWSuol/dVIL1yJ
         urLS3Pdd55BYYGdG5EITs+A/B1iZG/4btEVtQkX9t0XmusHSav4IBVAwvRNi5rSRCjGU
         AnOg==
X-Gm-Message-State: AOAM530RHKT+KZwVygI8uOLulJWT78sruGFDb+m2kdEFUgiq9BwvNCN6
        hrEiGY60casTZtIiu6UuNN8Q/wpfAZz9Tw==
X-Google-Smtp-Source: ABdhPJyPfxCAP02uftHPin+MIdD2ql9mo6CDvRNbbyWOWZ/qtmNAl81aYdESqQalgc6J8mQDdG86Mw==
X-Received: by 2002:a17:902:ee02:b029:d1:8c50:aa73 with SMTP id z2-20020a170902ee02b02900d18c50aa73mr3617978plb.42.1599759973690;
        Thu, 10 Sep 2020 10:46:13 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q13sm2615391pjj.14.2020.09.10.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:46:13 -0700 (PDT)
Date:   Thu, 10 Sep 2020 11:46:11 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     rishabhb@codeaurora.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, linux-remoteproc-owner@vger.kernel.org,
        arnaud.pouliquen@st.com
Subject: Re: [PATCH v2 0/3] Expose recovery/coredump configuration from sysfs
Message-ID: <20200910174611.GC579940@xps15>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
 <20200901220542.GA121362@xps15>
 <20200903235944.GC3715@yoga>
 <20200904220213.GA404035@xps15>
 <0101017473e8b9f1-9c800bfd-d724-473f-96b8-c43920cc8967-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101017473e8b9f1-9c800bfd-d724-473f-96b8-c43920cc8967-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 05:27:46PM +0000, rishabhb@codeaurora.org wrote:
> On 2020-09-04 15:02, Mathieu Poirier wrote:
> > On Thu, Sep 03, 2020 at 06:59:44PM -0500, Bjorn Andersson wrote:
> > > On Tue 01 Sep 17:05 CDT 2020, Mathieu Poirier wrote:
> > > 
> > > > Hi Rishabh,
> > > >
> > > > On Thu, Aug 27, 2020 at 12:48:48PM -0700, Rishabh Bhatnagar wrote:
> > > > > From Android R onwards Google has restricted access to debugfs in user
> > > > > and user-debug builds. This restricts access to most of the features
> > > > > exposed through debugfs. This patch series adds a configurable option
> > > > > to move the recovery/coredump interfaces to sysfs. If the feature
> > > > > flag is selected it would move these interfaces to sysfs and remove
> > > > > the equivalent debugfs interface.
> > > >
> > > > What I meant wast to move the coredump entry from debugfs to sysfs and from
> > > > there make it available to user space using a kernel config.
> > > 
> > > Why would we not always make this available in sysfs?
> > 
> > At this time the options are in debugfs and vendors can decide to make
> > that
> > available on products if they want to.  The idea behind using a kernel
> > configuration once moved to sysfs was to give the same kind of options.
> > 
> > > 
> > > > But thinking further on this it may be better to simply provide an API
> > > > to set the coredump mode from the platform driver, the same way
> > > > rproc_coredump_set_elf_info() works.
> > > 
> > > Being able to invoke these from the platform drivers sounds like a new
> > > feature. What would trigger the platform drivers to call this? Or are
> > > you perhaps asking for the means of the drivers to be able to select
> > > the
> > > default mode?
> > 
> > My ultimate goal is to avoid needlessly stuffing things in sysfs.  My
> > hope in
> > suggesting a new API was that platform drivers could recognise the kind
> > of
> > build/environment they operate in and setup the coredump mode
> > accordingly.  That
> > would have allowed us to leave debugfs options alone.
> > 
> > > 
> > > Regarding the default mode, I think it would make sense to make the
> > > default "disabled", because this is the most sensible configuration
> > > in a
> > > "production" environment. And the sysfs means we have a convenient
> > > mechanism to configure it, even on production environments.
> > > 
> > 
> > I am weary of changing something that hasn't been requested.
> > 
> > > > That will prevent breaking a fair amount of user space code...
> > > >
> > > 
> > > We typically don't guarantee that the debugfs interfaces are stable
> > > and
> > > if I understand the beginning of you reply you still want to move it
> > > from debugfs to sysfs - which I presume would break such scripts in
> > > the
> > > first place?
> > 
> > Correct - I am sure that moving coredump and recovery options to sysfs
> > will
> > break user space scripts.  Even if debugfs is not part of the ABI it
> > would be
> > nice to avoid disrupting people as much as possible.
> > 
> > > 
> > > 
> > > I would prefer to see that we don't introduce config options for every
> > > little thing, unless there's good reason for it.
> > 
> > I totally agree.  It is with great reluctance that I asked Rishab to
> > proceed
> > the way he did in V3.  His usecase makes sense... On the flip side this
> > is
> > pushed down on the kernel community and I really like Christoph's
> > position about
> > fixing Android and leaving the kernel alone.
> > 
> Well, removing debugfs is conscious decision taken by android due to
> security
> concerns and there is not we can fix there.
> Would it be a terrible idea to have recovery and coredump exposed from both
> sysfs and debugfs instead of choosing one and breaking userspace code?

Yes, two interfaces to do the same thing is not acceptable.

That being said Arnaud Pouliquen had the excellent idea of using the newly added
remoteproc character device.   

> > > 
> > > Regards,
> > > Bjorn
> > > 
> > > > Let me know if that can work for you.
> > > >
> > > > Thanks,
> > > > Mathieu
> > > >
> > > > > 'Coredump' and 'Recovery' are critical
> > > > > interfaces that are required for remoteproc to work on Qualcomm Chipsets.
> > > > > Coredump configuration needs to be set to "inline" in debug/test build
> > > > > and "disabled" in production builds. Whereas recovery needs to be
> > > > > "disabled" for debugging purposes and "enabled" on production builds.
> > > > >
> > > > > Changelog:
> > > > >
> > > > > v1 -> v2:
> > > > > - Correct the contact name in the sysfs documentation.
> > > > > - Remove the redundant write documentation for coredump/recovery sysfs
> > > > > - Add a feature flag to make this interface switch configurable.
> > > > >
> > > > > Rishabh Bhatnagar (3):
> > > > >   remoteproc: Expose remoteproc configuration through sysfs
> > > > >   remoteproc: Add coredump configuration to sysfs
> > > > >   remoteproc: Add recovery configuration to sysfs
> > > > >
> > > > >  Documentation/ABI/testing/sysfs-class-remoteproc |  44 ++++++++
> > > > >  drivers/remoteproc/Kconfig                       |  12 +++
> > > > >  drivers/remoteproc/remoteproc_debugfs.c          |  10 +-
> > > > >  drivers/remoteproc/remoteproc_sysfs.c            | 126 +++++++++++++++++++++++
> > > > >  4 files changed, 190 insertions(+), 2 deletions(-)
> > > > >
> > > > > --
> > > > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > > > > a Linux Foundation Collaborative Project
> > > > >
