Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EFCC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DD82083B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xm4SHKHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgIDWCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 18:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgIDWCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 18:02:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602DC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 15:02:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so1789294plr.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TJu4hbBaYN0fi17S3gHLZgQt0xhO8lnMJk2eVNy9rRY=;
        b=xm4SHKHcs5OTps9YwEDUFiZqLP5/3f+P5Bc0jNuZ9Buy75ErsodNkIzCF9I46RUr9J
         Sv1uM3pMg5I/fDMW7EzxKgv2N7c0xRilXUCRE8oKnlMHO+lj3e6hfvztekNBR4Lfssy+
         iJijBWjfnJtTJcsIxr/7HC6y7E1BY6NP00c9tRnr+gx3PzLgYp900giLu/bUXv9aNWYI
         ze8hY1rcocm8vp2jsR8tEcUq1SfL8nL5DI1bpODnzYg2KWolNj59acWXg/apL6kDlA2N
         zFTPO2v6F3qQigK/L/eUoh2X9KexIjlxkBcfHlb5f10xu+uqsekCfVW8CpDTzwSPSv0F
         5HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJu4hbBaYN0fi17S3gHLZgQt0xhO8lnMJk2eVNy9rRY=;
        b=H/PmaQc/VtjgVkQCcNfDES/MBmzOsKNjzMkdkZOw5WuxPjFIjGqqL1mEF1whEH4MEk
         x/WTa1sELE6JNpwWuQ/QCTNN2ZPEibAkWSvcgGtLhuxRlg00YeKSTivGHpxaLYRzs3gT
         PsPsZw8A8dMl3RdTPwWlFtP/IHC2rf7hTfk8SWpgXwlpjDkn172kSX0kh+b+INsaVdFx
         sNK/sQ9C0tYdK4BIRQdPckdO6mxNI0CjLvLtE80mvE8srRPQerJPkXh1yb8F3CJp6bvS
         oSUh450uv5Zqhwz3coy0LP/9Dgt+0B9UpZmx+IPotQsWyYFmIsy3QRYzuMFix0WPt0js
         T++w==
X-Gm-Message-State: AOAM530TlB8HFVSf/fZ9twix/jDiEQydJP5sCq+8E8/vqaLOCTNcSDR5
        dWFNkd6MzST09h8ruoSKZMNUGQ==
X-Google-Smtp-Source: ABdhPJxXK91RixKyneR+dtJRUZSuREyo90wO7etZORTKckhxfePNygh2V29/+O/A/wMi0eiDBMtA7A==
X-Received: by 2002:a17:90a:ccd:: with SMTP id 13mr9885025pjt.123.1599256935610;
        Fri, 04 Sep 2020 15:02:15 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b203sm7364406pfb.205.2020.09.04.15.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 15:02:14 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:02:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v2 0/3] Expose recovery/coredump configuration from sysfs
Message-ID: <20200904220213.GA404035@xps15>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
 <20200901220542.GA121362@xps15>
 <20200903235944.GC3715@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903235944.GC3715@yoga>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 06:59:44PM -0500, Bjorn Andersson wrote:
> On Tue 01 Sep 17:05 CDT 2020, Mathieu Poirier wrote:
> 
> > Hi Rishabh,
> > 
> > On Thu, Aug 27, 2020 at 12:48:48PM -0700, Rishabh Bhatnagar wrote:
> > > From Android R onwards Google has restricted access to debugfs in user
> > > and user-debug builds. This restricts access to most of the features
> > > exposed through debugfs. This patch series adds a configurable option
> > > to move the recovery/coredump interfaces to sysfs. If the feature
> > > flag is selected it would move these interfaces to sysfs and remove
> > > the equivalent debugfs interface.
> > 
> > What I meant wast to move the coredump entry from debugfs to sysfs and from
> > there make it available to user space using a kernel config.
> 
> Why would we not always make this available in sysfs?

At this time the options are in debugfs and vendors can decide to make that
available on products if they want to.  The idea behind using a kernel
configuration once moved to sysfs was to give the same kind of options.

> 
> > But thinking further on this it may be better to simply provide an API
> > to set the coredump mode from the platform driver, the same way
> > rproc_coredump_set_elf_info() works.
> 
> Being able to invoke these from the platform drivers sounds like a new
> feature. What would trigger the platform drivers to call this? Or are
> you perhaps asking for the means of the drivers to be able to select the
> default mode?

My ultimate goal is to avoid needlessly stuffing things in sysfs.  My hope in
suggesting a new API was that platform drivers could recognise the kind of
build/environment they operate in and setup the coredump mode accordingly.  That
would have allowed us to leave debugfs options alone.

> 
> Regarding the default mode, I think it would make sense to make the
> default "disabled", because this is the most sensible configuration in a
> "production" environment. And the sysfs means we have a convenient
> mechanism to configure it, even on production environments.
>

I am weary of changing something that hasn't been requested.  
 
> > That will prevent breaking a fair amount of user space code...
> > 
> 
> We typically don't guarantee that the debugfs interfaces are stable and
> if I understand the beginning of you reply you still want to move it
> from debugfs to sysfs - which I presume would break such scripts in the
> first place?

Correct - I am sure that moving coredump and recovery options to sysfs will
break user space scripts.  Even if debugfs is not part of the ABI it would be
nice to avoid disrupting people as much as possible.

> 
> 
> I would prefer to see that we don't introduce config options for every
> little thing, unless there's good reason for it.

I totally agree.  It is with great reluctance that I asked Rishab to proceed
the way he did in V3.  His usecase makes sense... On the flip side this is
pushed down on the kernel community and I really like Christoph's position about
fixing Android and leaving the kernel alone.

> 
> Regards,
> Bjorn
> 
> > Let me know if that can work for you.
> > 
> > Thanks,
> > Mathieu
> > 
> > > 'Coredump' and 'Recovery' are critical
> > > interfaces that are required for remoteproc to work on Qualcomm Chipsets.
> > > Coredump configuration needs to be set to "inline" in debug/test build
> > > and "disabled" in production builds. Whereas recovery needs to be
> > > "disabled" for debugging purposes and "enabled" on production builds.
> > > 
> > > Changelog:
> > > 
> > > v1 -> v2:
> > > - Correct the contact name in the sysfs documentation.
> > > - Remove the redundant write documentation for coredump/recovery sysfs
> > > - Add a feature flag to make this interface switch configurable.
> > > 
> > > Rishabh Bhatnagar (3):
> > >   remoteproc: Expose remoteproc configuration through sysfs
> > >   remoteproc: Add coredump configuration to sysfs
> > >   remoteproc: Add recovery configuration to sysfs
> > > 
> > >  Documentation/ABI/testing/sysfs-class-remoteproc |  44 ++++++++
> > >  drivers/remoteproc/Kconfig                       |  12 +++
> > >  drivers/remoteproc/remoteproc_debugfs.c          |  10 +-
> > >  drivers/remoteproc/remoteproc_sysfs.c            | 126 +++++++++++++++++++++++
> > >  4 files changed, 190 insertions(+), 2 deletions(-)
> > > 
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > > a Linux Foundation Collaborative Project
> > > 
