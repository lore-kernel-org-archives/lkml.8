Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B228DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D310204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/q6amQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgEUPcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgEUPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:32:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97829C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:32:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p21so3315533pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+L6yMgj6SF412wxBrlIvpshzc4kgoWA+VMhfhRUlVRs=;
        b=p/q6amQYHbeWvUMuWV8BWlNvYitmVYExKiYUbdqWdS/RIHPFjC0D7KSnjAQ3Vsiuot
         pAo9OHxUXoiEjwGn/Qa8YsiYl8QbK4R0jl4q6MN00xn4PPsooPgrFs/DIkxaiKR6Oaw+
         QggFTCvHrCfhpzbed8BBeB0vy3Ewtvau7CeGec4qF13qB3K3WeSx7Jiw+JjKQM1ArCdj
         j2Tdw7TPFVfOTcriqkuIc5Hvcb+6qQuog8h2umBG3WsexWEpEvdF887dDCmn7ecCbj8U
         pN/RPtImXVEQCrGRYkXUrMp4y2HH5AWxGyH86aa6kKS/+bu0uD2JkZfdttVNu6gk0Ako
         CFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+L6yMgj6SF412wxBrlIvpshzc4kgoWA+VMhfhRUlVRs=;
        b=rJ24dE942oo/G9Qz79Ol8hTrAfMP+Jbaf/nbNBonXPbNVyhapj8LuigxXGYZRngW3Q
         fhuHWqKm5bMJqD5gROl3uQJI+h6lkeDjonkq+WjYAnOIDR4YAVqAgnTVIIIQg8vjjeCo
         OoFZzvibsuuFQLXoYE22FUxVbrzkvUjwUolZAy4ecozAro1lJIQBS2JjTKOoPaSwMca4
         rlaTCkUlPz1WIOkPsTW4sUJ6FcINUXoo3743FZseSvbgh63fI+X5sb0KVMAImO5B0wCW
         2z5w4R+u57Uz/V6+04M9B2tIJuCNhJDKxh+JP3PgjAU9P8wn8eiEOlXFZVMvM0TUnYgK
         IrWg==
X-Gm-Message-State: AOAM530AflzuEdBO1+Ytxt6ggItMccmmE6OVKkn2ut0UDIlnu0dAeMqR
        QsD6K1pUEUQ3isp8Llm2jbfY
X-Google-Smtp-Source: ABdhPJxVBBy9yBW/WE8YGP4H2DxszJRV6L7CHDKqB4fy5/Z98hD7jA8/4zKVUuYdSmtOCG2J8BXsmQ==
X-Received: by 2002:a62:4e88:: with SMTP id c130mr10082114pfb.122.1590075134984;
        Thu, 21 May 2020 08:32:14 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id g27sm5034156pfr.51.2020.05.21.08.32.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 08:32:14 -0700 (PDT)
Date:   Thu, 21 May 2020 21:02:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Introduce features and debugfs/sysfs entries for
 MHI
Message-ID: <20200521153208.GB16101@Mani-XPS-13-9360>
References: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
 <20200521132318.GA3797@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521132318.GA3797@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 06:53:18PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Mon, May 18, 2020 at 01:03:54PM -0700, Bhaumik Bhatt wrote:
> > Introduce independent bus and device voting mechanism for clients and save
> > hardware information from BHI.
> > Allow reading and modifying some MHI variables for debug, test, and
> > informational purposes using debugfs.
> > Read values for device specific hardware information to be used by OEMs in
> > factory testing such as serial number and PK hash using sysfs.
> > 
> 
> I think this series is not yet ready. So will not merge any patches in this
> series for 5.8.
> 
> Or let me know if there are any independent patches which should get merged.
> I'm planning to send the final 5.8 series to Greg by Friday.
> 

Sorry. I just realised that we are running out of time as we are ending rc6. So
I've sent the 5.8 series to Greg.

Thanks,
Mani

> Thanks,
> Mani
> 
> > This set of patches was tested on arm64 and x86.
> > 
> > v3:
> > -Add patch to check for pending packets in suspend as a dependency for the
> > independent voting mechanism introduction
> > -Include register dump entry for debugfs to dump MHI, BHI, and BHIe registers
> > -Update commit message for the debugfs patch
> > -Updated Documentation/ABI with the required info for sysfs
> > -Updated debugfs patch to include a new KConfig entry and dependencies
> > -Updated reviewed-by for some patches
> > 
> > v2:
> > -Added a new debugfs.c file for specific debugfs entries and code
> > -Updated commit text and addressed some comments for voting change
> > -Made sure sysfs is only used for serial number and OEM PK hash usage
> > 
> > Bhaumik Bhatt (7):
> >   bus: mhi: core: Abort suspends due to outgoing pending packets
> >   bus: mhi: core: Introduce independent voting mechanism
> >   bus: mhi: core: Use generic name field for an MHI device
> >   bus: mhi: core: Introduce helper function to check device state
> >   bus: mhi: core: Introduce debugfs entries and counters for MHI
> >   bus: mhi: core: Read and save device hardware information from BHI
> >   bus: mhi: core: Introduce sysfs entries for MHI
> > 
> >  Documentation/ABI/stable/sysfs-bus-mhi |  25 ++
> >  MAINTAINERS                            |   1 +
> >  drivers/bus/mhi/Kconfig                |   8 +
> >  drivers/bus/mhi/core/Makefile          |   5 +-
> >  drivers/bus/mhi/core/boot.c            |  17 +-
> >  drivers/bus/mhi/core/debugfs.c         | 501 +++++++++++++++++++++++++++++++++
> >  drivers/bus/mhi/core/init.c            |  80 +++++-
> >  drivers/bus/mhi/core/internal.h        |  29 ++
> >  drivers/bus/mhi/core/main.c            |   6 +-
> >  drivers/bus/mhi/core/pm.c              |  79 ++++--
> >  include/linux/mhi.h                    |  39 ++-
> >  11 files changed, 745 insertions(+), 45 deletions(-)
> >  create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
> >  create mode 100644 drivers/bus/mhi/core/debugfs.c
> > 
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
