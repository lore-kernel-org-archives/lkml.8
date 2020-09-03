Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA706C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 23:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9E4206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 23:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRZ5Q6Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgICX7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICX7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 19:59:52 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8BDC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 16:59:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x14so4895996oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HbFeH7Kr65gMcI3nAyJpajL84/34MsWWi87x3HSbhKM=;
        b=PRZ5Q6CsRACk5tktaPlcFqFodMxuLOGNl5QUC0QD7bgZNaI77FaR8UVX/KFg5hNA37
         pIZbZvUssGGuv0PNWAlPH3PpjjC6Ln2AmVQvBMThffL40Fic4jStXXrtwdJXXc6mQA0y
         cIzdM+plvkqKnov7Y19zfjVx2wwgGG6Ero5SJ9f+v4z+PyWlz6OTtp3B5CxnwzuUDQ5G
         nMyXcn8DZqsnc5quT0oAQxlMUSnEhudfi4in8ZL5f+2gL3vl9Z45WQ/S0DiuNjUtJdle
         1qCnAHzZpBQFtKFIicjekwtyVAoX3qgdrLjPTshjeT7jZZ86Axw0CMw+B1TKvZXIJbnv
         YapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HbFeH7Kr65gMcI3nAyJpajL84/34MsWWi87x3HSbhKM=;
        b=MrqAL+6oNU6aw+GZTF7Evb8LWbRIXRmQK5PwBvWpzuNpPPvAa94LP/2ozL0vysSkqW
         sNYEkN++zrrgXk4U48d3IMSvFYQeoFUCa+5Htn1vzLPJitji46ka3uC7SmZz/B9ZEVJm
         XzP4GY40hcHtN0zNZN6mNdBKmU9frSUphj5mVoVQMYXTG28tjK+qmA07R4wL98HHZyLw
         NKi78ElFHdsL6qDWXxPchcc1WoOJnkz/KFzVzmZiIYen+pa6Tom9W0Vjj/NluY/y37i9
         TkGUx5E5J9sYSietQagjtEquDryWbSbtkKyFFMjwSzRiYzSviViRbf6xJ7DnPxCusTAM
         DUOw==
X-Gm-Message-State: AOAM5335eXXWSvm3irbtQ6Qzr/PVlT8+QnpCvmt6VNh67UNRxLfNFL5g
        CFCmC/znTvpdmUI6hA+5qJkP71u17mWohg==
X-Google-Smtp-Source: ABdhPJyrkmld54fAK4IHmqg9WE4SP//92cyIN4lV49RWtkwafdKluWWpFXYaw6jIL8j3692/P/5Wug==
X-Received: by 2002:aca:7503:: with SMTP id q3mr3824895oic.179.1599177587001;
        Thu, 03 Sep 2020 16:59:47 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id x8sm929232oom.25.2020.09.03.16.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:59:46 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:59:44 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v2 0/3] Expose recovery/coredump configuration from sysfs
Message-ID: <20200903235944.GC3715@yoga>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
 <20200901220542.GA121362@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901220542.GA121362@xps15>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01 Sep 17:05 CDT 2020, Mathieu Poirier wrote:

> Hi Rishabh,
> 
> On Thu, Aug 27, 2020 at 12:48:48PM -0700, Rishabh Bhatnagar wrote:
> > From Android R onwards Google has restricted access to debugfs in user
> > and user-debug builds. This restricts access to most of the features
> > exposed through debugfs. This patch series adds a configurable option
> > to move the recovery/coredump interfaces to sysfs. If the feature
> > flag is selected it would move these interfaces to sysfs and remove
> > the equivalent debugfs interface.
> 
> What I meant wast to move the coredump entry from debugfs to sysfs and from
> there make it available to user space using a kernel config.

Why would we not always make this available in sysfs?

> But thinking further on this it may be better to simply provide an API
> to set the coredump mode from the platform driver, the same way
> rproc_coredump_set_elf_info() works.

Being able to invoke these from the platform drivers sounds like a new
feature. What would trigger the platform drivers to call this? Or are
you perhaps asking for the means of the drivers to be able to select the
default mode?

Regarding the default mode, I think it would make sense to make the
default "disabled", because this is the most sensible configuration in a
"production" environment. And the sysfs means we have a convenient
mechanism to configure it, even on production environments.

> That will prevent breaking a fair amount of user space code...
> 

We typically don't guarantee that the debugfs interfaces are stable and
if I understand the beginning of you reply you still want to move it
from debugfs to sysfs - which I presume would break such scripts in the
first place?


I would prefer to see that we don't introduce config options for every
little thing, unless there's good reason for it.

Regards,
Bjorn

> Let me know if that can work for you.
> 
> Thanks,
> Mathieu
> 
> > 'Coredump' and 'Recovery' are critical
> > interfaces that are required for remoteproc to work on Qualcomm Chipsets.
> > Coredump configuration needs to be set to "inline" in debug/test build
> > and "disabled" in production builds. Whereas recovery needs to be
> > "disabled" for debugging purposes and "enabled" on production builds.
> > 
> > Changelog:
> > 
> > v1 -> v2:
> > - Correct the contact name in the sysfs documentation.
> > - Remove the redundant write documentation for coredump/recovery sysfs
> > - Add a feature flag to make this interface switch configurable.
> > 
> > Rishabh Bhatnagar (3):
> >   remoteproc: Expose remoteproc configuration through sysfs
> >   remoteproc: Add coredump configuration to sysfs
> >   remoteproc: Add recovery configuration to sysfs
> > 
> >  Documentation/ABI/testing/sysfs-class-remoteproc |  44 ++++++++
> >  drivers/remoteproc/Kconfig                       |  12 +++
> >  drivers/remoteproc/remoteproc_debugfs.c          |  10 +-
> >  drivers/remoteproc/remoteproc_sysfs.c            | 126 +++++++++++++++++++++++
> >  4 files changed, 190 insertions(+), 2 deletions(-)
> > 
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
