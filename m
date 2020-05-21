Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0754EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA53220671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaoWV6h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgEUNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgEUNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:23:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A36AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:23:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so2825777plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZgiiCf7yV4gJL0wD1WfzajtZUs2YRbHU0t+q3osVJy8=;
        b=vaoWV6h9teezEjE8jpwOZzf737B2YusTXEr+g5naQ5F87EBzTy7uBhoHJKRwu6Nq4x
         5ux/fJ0DKBM0h84GWOxHMk9pfzkcqmI1WSNvdNwKYsL1K9RGyLs9jRR0r4UjzudwQOA6
         xH+MblwTsZZ5PbXmI2gOU4ijseeRPku0L01zskhMufuc/eJVAXnlhS9zjlN1fc50HHJq
         CRT3EjpO8oRlzgCdj3hA2Nuk0Yd43DI1ARm5EaJLGkv4GDQ7jiGByJEE6NG9VH0NRmVr
         QdHn5sFAv1iJZJc3cTEYmxLLT/rGfWXsO6pICQ59KxbEQJ3DlSwf6/c3Ikye1Gdu3th8
         xVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZgiiCf7yV4gJL0wD1WfzajtZUs2YRbHU0t+q3osVJy8=;
        b=oR3V/HSD4NjNz1k47ZiqEIjDbwxsmOibr/PViSuM6Zt/i1NaS6E+K2PA6/Ry6vl979
         QkUNhqluROp4V3FMtJk8EowFWfz2sMy8amT+Oue8jHbIiOgBWR9KyKLGaL67QrpUEjJe
         Wk/96Td606I9yDHgZY3VsESxj4P+o1bxV8lkmW+YAx8JbY4CaDPfA6Un0u+hfbMJLAx1
         cxXr3Z/34A6qa/PV3Q3BPnM8UCSu6LBsGGIKDDLGxq9HM6SNdKog9gEInWxrnonm6lnF
         cxAoJ/7C0WJYyUm6L+0kPDwvQCduoMMIhRZHMSvfcN2qtOCdCS8dq5rjLRuWnotNjFzi
         65EQ==
X-Gm-Message-State: AOAM53246HN+mgTfLhD8jzJ7xzZYmX9TyrII3OwNcGnAdrGF0u8fNGi4
        4S7R+BEPaOK66GfPktfQ1Tb/
X-Google-Smtp-Source: ABdhPJzZknrCmqHksqP0ZNN+k3e4gCQYdBl1AO8/5OuOf+emaewf1h+5P102mD65RpzDvZoUCrsD7A==
X-Received: by 2002:a17:90a:e30e:: with SMTP id x14mr11666354pjy.141.1590067404391;
        Thu, 21 May 2020 06:23:24 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id q17sm3973037pfq.117.2020.05.21.06.23.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 06:23:22 -0700 (PDT)
Date:   Thu, 21 May 2020 18:53:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Introduce features and debugfs/sysfs entries for
 MHI
Message-ID: <20200521132318.GA3797@Mani-XPS-13-9360>
References: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 18, 2020 at 01:03:54PM -0700, Bhaumik Bhatt wrote:
> Introduce independent bus and device voting mechanism for clients and save
> hardware information from BHI.
> Allow reading and modifying some MHI variables for debug, test, and
> informational purposes using debugfs.
> Read values for device specific hardware information to be used by OEMs in
> factory testing such as serial number and PK hash using sysfs.
> 

I think this series is not yet ready. So will not merge any patches in this
series for 5.8.

Or let me know if there are any independent patches which should get merged.
I'm planning to send the final 5.8 series to Greg by Friday.

Thanks,
Mani

> This set of patches was tested on arm64 and x86.
> 
> v3:
> -Add patch to check for pending packets in suspend as a dependency for the
> independent voting mechanism introduction
> -Include register dump entry for debugfs to dump MHI, BHI, and BHIe registers
> -Update commit message for the debugfs patch
> -Updated Documentation/ABI with the required info for sysfs
> -Updated debugfs patch to include a new KConfig entry and dependencies
> -Updated reviewed-by for some patches
> 
> v2:
> -Added a new debugfs.c file for specific debugfs entries and code
> -Updated commit text and addressed some comments for voting change
> -Made sure sysfs is only used for serial number and OEM PK hash usage
> 
> Bhaumik Bhatt (7):
>   bus: mhi: core: Abort suspends due to outgoing pending packets
>   bus: mhi: core: Introduce independent voting mechanism
>   bus: mhi: core: Use generic name field for an MHI device
>   bus: mhi: core: Introduce helper function to check device state
>   bus: mhi: core: Introduce debugfs entries and counters for MHI
>   bus: mhi: core: Read and save device hardware information from BHI
>   bus: mhi: core: Introduce sysfs entries for MHI
> 
>  Documentation/ABI/stable/sysfs-bus-mhi |  25 ++
>  MAINTAINERS                            |   1 +
>  drivers/bus/mhi/Kconfig                |   8 +
>  drivers/bus/mhi/core/Makefile          |   5 +-
>  drivers/bus/mhi/core/boot.c            |  17 +-
>  drivers/bus/mhi/core/debugfs.c         | 501 +++++++++++++++++++++++++++++++++
>  drivers/bus/mhi/core/init.c            |  80 +++++-
>  drivers/bus/mhi/core/internal.h        |  29 ++
>  drivers/bus/mhi/core/main.c            |   6 +-
>  drivers/bus/mhi/core/pm.c              |  79 ++++--
>  include/linux/mhi.h                    |  39 ++-
>  11 files changed, 745 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
>  create mode 100644 drivers/bus/mhi/core/debugfs.c
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
