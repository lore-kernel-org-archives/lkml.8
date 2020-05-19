Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A57C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537972075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLlqk4yK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgESG5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgESG5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:57:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038F6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:57:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cx22so915816pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3k3pm7bc95OtlK+4qc5xKy1dT08jG4ekT2Q6wrr2Yew=;
        b=oLlqk4yKsI5pouNfFyO3TCKhQUhfUfnnXhvo8XShsuxHRAAlEydd/Yv+OWHGjSIo5t
         DK1JkFpVgHDXCoHe1piwRH8nRp3QMSlC/JZ8a8b808yi/ZejaXJmtVVO2bMmFyTz7xHs
         PNcOTeeqgZqPeu7MDr+TBmbAGeRtcktGypivyAAYjaBwKseQhcu8+5qyVzATuDmIWKd4
         IiMvN1fLHTHjF+pZkoBG8O2zxGLe1vNkJBZWeGeYJa+N6jlNF8Hnmklu3/5ConV/2ye3
         BPWLDnbtMVB5RbAiDHslOENU2876IwRZJdjZKgvB6zRIRlMW+f8JqcJgRAM0HObgdrXB
         LeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3k3pm7bc95OtlK+4qc5xKy1dT08jG4ekT2Q6wrr2Yew=;
        b=ZorjE6lza6r/c7Oj+SRXHpflJtyygGlD1OX3e+5dyHdwfmpuw3Xky/UwXz+YrOhFcv
         1sxhjVX7f5/C2fp2Aj3ASLbOPPXyPMLNqJtsWGPAK5M+lExU28sK1Cqeq5953pVtIJGu
         /teogLrDdVVtq+lRbYQ/Q7cd65TvlwuukWtCISfq5VLPtUthFSsOCezuugCb8gbsvaUY
         lUfL5VITCOTLerpJPdZZDWO8ollINGbmZ/be26fMm9c9fZmPCL07xpN270pZsWWd1JR0
         b8y2/bjXeG7khHmE2bNiXrGgMQUYHuZd4IQE/gmoHHt/s7oli7F8SrnPgQ3F34yu+sJp
         +Vmg==
X-Gm-Message-State: AOAM533dAgZnwnkNx0npCyPJvVxzTq/L1yigbfpaFC+vAdly47/UUIul
        Ny51TGKUWj1wqVlG/ynPMvzRE5gLeODn
X-Google-Smtp-Source: ABdhPJwzXyQAXPKveijIwRy0I/80xUPng7i6cgPaf/og8iB/EzXKDZWO4ZjfM97hgA+GA1b7Bk6GSg==
X-Received: by 2002:a17:90a:20cf:: with SMTP id f73mr3591995pjg.86.1589871436254;
        Mon, 18 May 2020 23:57:16 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:908:98af:c582:b01f:2bea:3281])
        by smtp.gmail.com with ESMTPSA id e16sm9280385pgg.8.2020.05.18.23.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 23:57:15 -0700 (PDT)
Date:   Tue, 19 May 2020 12:27:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, wufan@codeaurora.org,
        pratanan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Qualcomm Cloud AI 100 driver
Message-ID: <20200519065707.GA8114@Mani-XPS-13-9360>
References: <1589465266-20056-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589465266-20056-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Thu, May 14, 2020 at 08:07:38AM -0600, Jeffrey Hugo wrote:
> Introduction:
> Qualcomm Cloud AI 100 is a PCIe adapter card which contains a dedicated
> SoC ASIC for the purpose of efficently running Deep Learning inference
> workloads in a data center environment.
> 
> The offical press release can be found at -
> https://www.qualcomm.com/news/releases/2019/04/09/qualcomm-brings-power-efficient-artificial-intelligence-inference
> 
> The offical product website is -
> https://www.qualcomm.com/products/datacenter-artificial-intelligence
> 
> At the time of the offical press release, numerious technology news sites
> also covered the product.  Doing a search of your favorite site is likely
> to find their coverage of it.
> 
> It is our goal to have the kernel driver for the product fully upstream.
> The purpose of this RFC is to start that process.  We are still doing
> development (see below), and thus not quite looking to gain acceptance quite
> yet, but now that we have a working driver we beleive we are at the stage
> where meaningful conversation with the community can occur.
> 
> Design:

Can you add documentation in next revision with all this information (or more)?
In restructured text ofc. Eventhough it is an RFC series, adding documentation
doesn't hurt and it will help reviewers to understand the hardware better.

Thanks,
Mani

> 
> +--------------------------------+
> |       AI application           |
> |       (userspace)              |
> +-------------+------------------+
>               |
>               | Char dev interface
>               |
>               |
> +-------------+------------------+
> |       QAIC driver              |
> |       (kernel space)           |
> |                                |
> +----+------------------+--------+
>      |                  |
>      |                  |
>      |                  |
>      |                  |
>      |Control path      | Data path
>      |(MHI bus)         |
>      |                  |
>      |                  |
>      |                  |
>      |                  |
> +--------------------------------+
> | +--------+      +------------+ |
> | | MHI HW |      |DMA Bridge  | |
> | +--------+      |(DMA engine)| |
> |                 +------------+ |
> |                                |
> |                                |
> |                                |
> |  Qualcomm Cloud AI 100 device  |
> |                                |
> |                                |
> +--------------------------------+
> 
> A Qualcomm Cloud AI 100 device (QAIC device from here on) is a PCIe hardware
> accelerator for AI inference workloads.  Over the PCIe bus fabric, a QAIC
> device exposes two interfaces via PCI BARs - a MHI hardware region and a
> DMA engine hardware region.
> 
> Before workloads can be run, a QAIC device needs to be initialized.  Similar
> to other Qualcomm products with incorperate MHI, device firmware needs to be
> loaded onto the device from the host.  This occurs in two stages.  First,
> a secondary bootloader (SBL) needs to be loaded onto the device.  This occurs
> via the BHI protocol, and is handled by the MHI bus.  Once the SBL loaded
> and running, it activates the Sahara protocol.  The Sahara protocol is used
> with a userspace application to load and initialize the remaining firmware.
> The Sahara protocol and associated userspace application are outside the
> scope of this series as they have no direct interaction with the QAIC driver.
> 
> Once a QAIC device is fully initialized, workloads can be sent to the device
> and run.  This involves a per-device instance char dev that the QAIC driver
> exposes to userspace.  Running a workload involves two phases - configuring the
> device, and interacting with the workload.
> 
> To configure the device, commands are sent via a MHI channel.  This is referred
> to as the control path.  A command is a single message.  A message contains
> one or more transactions.  Transactions are operations that the device
> is requested to perform.  Most commands are opaque to the kernel driver, however
> some are not.  For example, if the user application wishes to DMA data to the
> device, it requires the assistance of the kernel driver to translate the data
> addresses to an address space that the device can understand.  In this instance
> the transaction for DMAing the data is visible to the kernel driver, and the
> driver will do the required transformation when encoding the message.
> 
> To interact with the workload, the workload is assigned a DMA Bridge Channel
> (dbc).  This is dedicated hardware within the DMA engine.  Interacting with the
> workload consists of sending it input data, and receiving output data.  The
> user application requests appropiate buffers from the kernel driver, prepares
> the buffers, and directs the kernel driver to queue them to the hardware.
> 
> The kernel driver is required to support multiple QAIC devices, and also N
> users per device.
> 
> Status:
> This series introduces the driver for QAIC devices, and builds up the minimum
> functionality for running workloads.  Several features which have been omitted
> or are still planned are indicated in the future work section.
> 
> Before exiting the RFC phase, and attempting full acceptance, we wish to
> complete two features which are currently under development as we expect there
> to be userspace interface changes as a result.
> 
> The first feature is a variable length control message between the kernel driver
> and the device.  This allows us to support the total number of DMA transactions
> we require for certain platforms, while minimizing memory usage.  The interface
> impact of this would be to allow us to drop the size of the manage buffer
> between userspace and the kernel driver from the current 16k, much of which is
> wasted.
> 
> The second feature is an optimization and extension of the data path interface.
> We plan to move the bulk of the data in the qaic_execute structure to the
> qaic_mem_req structure, which optimized our critical path processing.  We also
> plan to extend the qaic_execute structure to allow for a batch submit of
> multiple buffers as an optimization and convenience for userspace.  
> 
> Future work:
> For simplicity, we have omitted work related to the following features, and
> intend to submit in future series:
> 
> -debugfs
> -trace points
> -hwmon (device telemetry)
> 
> We are also investigating what it might mean to support dma_bufs.  We expect
> that such support would come as an extension of the interface.
> 
> Jeffrey Hugo (8):
>   qaic: Add skeleton driver
>   qaic: Add and init a basic mhi controller
>   qaic: Create char dev
>   qaic: Implement control path
>   qaic: Implement data path
>   qaic: Implement PCI link status error handlers
>   qaic: Implement MHI error status handler
>   MAINTAINERS: Add entry for QAIC driver
> 
>  MAINTAINERS                        |    7 +
>  drivers/misc/Kconfig               |    1 +
>  drivers/misc/Makefile              |    1 +
>  drivers/misc/qaic/Kconfig          |   20 +
>  drivers/misc/qaic/Makefile         |   12 +
>  drivers/misc/qaic/mhi_controller.c |  538 +++++++++++++++++++
>  drivers/misc/qaic/mhi_controller.h |   20 +
>  drivers/misc/qaic/qaic.h           |  111 ++++
>  drivers/misc/qaic/qaic_control.c   | 1015 ++++++++++++++++++++++++++++++++++++
>  drivers/misc/qaic/qaic_data.c      |  952 +++++++++++++++++++++++++++++++++
>  drivers/misc/qaic/qaic_drv.c       |  699 +++++++++++++++++++++++++
>  include/uapi/misc/qaic.h           |  246 +++++++++
>  12 files changed, 3622 insertions(+)
>  create mode 100644 drivers/misc/qaic/Kconfig
>  create mode 100644 drivers/misc/qaic/Makefile
>  create mode 100644 drivers/misc/qaic/mhi_controller.c
>  create mode 100644 drivers/misc/qaic/mhi_controller.h
>  create mode 100644 drivers/misc/qaic/qaic.h
>  create mode 100644 drivers/misc/qaic/qaic_control.c
>  create mode 100644 drivers/misc/qaic/qaic_data.c
>  create mode 100644 drivers/misc/qaic/qaic_drv.c
>  create mode 100644 include/uapi/misc/qaic.h
> 
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
