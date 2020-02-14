Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9738CC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5461124650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710566;
	bh=QcIJ80cSrTLbc0ijPcYyAEl69PScjRPdVxZgDXvJ9xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oMG02mgtMBcuJx7wQ35d5hA7KxgbGpuTVD/qGXeneDH9nZMT1CmgoHGp/jZITduNE
	 Db/xFW4iydUnreL5ZXSlHlT2GZ7c5IYTExnRqjWuXB9pGolXD2V/ylaQpEAoLALCjs
	 PkxMMcBZnWvy0W50slTE2OAWQmR4LCcG9hEHv5ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbgBNUCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389136AbgBNUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:44 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE68B22314;
        Fri, 14 Feb 2020 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710564;
        bh=QcIJ80cSrTLbc0ijPcYyAEl69PScjRPdVxZgDXvJ9xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcAQT7b3UsozO8tgtKaqo0+sV/Y3pR/4in8pvPvVbfeyVmmGtiURftnAz3sPr0ADO
         ubEZXiZVhn4f/gAdDv5P9tSLslG6flQmBhk/2bmHUxK65O6y7mKiZjppO0tRApp+0C
         AK1LIajBj0wi4Mzq5Uy5O3d4BI9UqXf+PHT/T/28=
Date:   Fri, 14 Feb 2020 08:49:19 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] soundwire: add master_device/driver support
Message-ID: <20200214164919.GB4016987@kroah.com>
References: <20200201042011.5781-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201042011.5781-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:20:09PM -0600, Pierre-Louis Bossart wrote:
> The SoundWire master representation needs to evolve to take into account:
> 
> a) a May 2019 recommendation from Greg KH to remove platform devices
> 
> b) the need on Intel platforms to support hardware startup only once
> the power rail dependencies are settled. The SoundWire master is not
> an independent IP at all.
> 
> c) the need to deal with external wakes handled by the PCI subsystem
> in specific low-power modes
> 
> In case it wasn't clear, the SoundWire subsystem is currently unusable
> with v5.5 on devices hitting the shelves very soon (race conditions,
> power management, suspend/resume, etc). v5.6 will only provide
> interface changes and no functional improvement. We've circled on the
> same concepts since September 2019, and I hope this direction is now
> aligned with the suggestions from Vinod Koul and that we can target
> v5.7 as the 'SoundWire just works(tm)' version.
> 
> This series is provided as an RFC since it depends on patches already
> for review.

Both of these look sane to me, nice work!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
