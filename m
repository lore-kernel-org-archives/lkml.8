Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52986C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9F5246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582875153;
	bh=ukpzQuPACt86ecHriGB09MDbTJzAHcm8p3pyeHuvKPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B0BDUUGsrniNCFCxaEHdv3YKW67ng/W6+0OlWbyQS+9hTRqfT5tNmcMZvMeNzacJF
	 RWQAnBGxBdEI4lo2oWPwWUd/P7UX7UBA0NyE5V71GkvhWn4pZi6e26YY9Rx5a+k38R
	 pBZ+ky8zHIFutf1dYBP0wmRRzSq6CsFhd8VinbHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgB1Hcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgB1Hcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:32:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7FAB246A3;
        Fri, 28 Feb 2020 07:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582875150;
        bh=ukpzQuPACt86ecHriGB09MDbTJzAHcm8p3pyeHuvKPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0vxosIcJPXo2eYYCb2J3fg3pRmM5fuOsjosH8tiaM3cqRx5kOJip8SrNNohEcJOBa
         IuNa24L0q9XLQnKHHUJq8ASPltYSBAo4C0klNTqmBop234UBdumVNmmU8qwUoJYVL3
         WK6svDGEmppjv3ZWyNWPbRIjnJkDT7UTmm2asL1E=
Date:   Fri, 28 Feb 2020 08:32:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
Message-ID: <20200228073227.GA2898712@kroah.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227223206.5020-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:31:59PM -0600, Pierre-Louis Bossart wrote:
> In the existing SoundWire code, Master Devices are not explicitly
> represented - only SoundWire Slave Devices are exposed (the use of
> capital letters follows the SoundWire specification conventions).
> 
> The SoundWire Master Device provides the clock, synchronization
> information and command/control channels. When multiple links are
> supported, a Controller may expose more than one Master Device; they
> are typically embedded inside a larger audio cluster (be it in an
> SOC/chipset or an external audio codec), and we need to describe it
> using the Linux device and driver model.  This will allow for
> configuration functions to account for external dependencies such as
> power rails, clock sources or wake-up mechanisms. This transition will
> also allow for better sysfs support without the reference count issues
> mentioned in the initial reviews.
> 
> In this patch, we convert the existing code to use an explicit
> sdw_slave_type, then define new objects (sdw_master_device and
> sdw_master_driver).
> 
> A parent (such as the Intel audio controller or its equivalent on
> Qualcomm devices) would use sdw_master_device_add() to create the
> device, passing a driver name as a parameter. The master device would
> be released when device_unregister() is invoked by the parent.
> 
> Note that since there is no standard for the Master host-facing
> interface, so the bus matching relies on a simple string matching (as
> previously done with platform devices).
> 
> The 'Master Device' driver exposes callbacks for
> probe/startup/shutdown/remove/process_wake. The startup and process
> wake need to be called by the parent directly (using wrappers), while
> the probe/shutdown/remove are handled by the SoundWire bus core upon
> device creation and release.
> 
> Additional callbacks will be added in the future for e.g. autonomous
> clock stop modes.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Makefile         |   2 +-
>  drivers/soundwire/bus_type.c       | 141 +++++++++++++++++++++++++++--
>  drivers/soundwire/master.c         | 100 ++++++++++++++++++++
>  drivers/soundwire/slave.c          |   7 +-
>  include/linux/soundwire/sdw.h      |  76 ++++++++++++++++
>  include/linux/soundwire/sdw_type.h |  36 +++++++-
>  6 files changed, 351 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/soundwire/master.c

As you are adding new sysfs files here, is there a follow-on patch for
Documentation/ABI/ updates?

thanks,

greg k-h
