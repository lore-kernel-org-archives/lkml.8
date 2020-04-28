Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCDCC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52591206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588055861;
	bh=J5sc6sunmD92913nrTHNqH6Af9xPttC4VRECMigtMA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1sfOXanCtGCR4tpA5e9ONtA5OJkFTQG1QqqMT+LoghO+G/WQOPZ07NG1YhOnN6iPR
	 Ojd7Un1ZS5b3t6xajYrislsL/RoRMZ9UZuzSL7R+dcKFWc/8JzWQsW5DeWqH2dMuod
	 TxaaFKlxlmv8jQtrSI28MSPoB07GPyvAfPE4uwtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgD1Ghk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgD1Ghk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:37:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3216C2051A;
        Tue, 28 Apr 2020 06:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588055858;
        bh=J5sc6sunmD92913nrTHNqH6Af9xPttC4VRECMigtMA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiW/F/Nk2hmias7r+BSEcyWFKZ3nfW6y2j80kJ4wfEb2N03HnmupJ5uFjM/s92/g8
         7jBVP4anXU306ARFglFItaTs/GkIhm0rttpYOmauNTvAoyyVw+ig0kxoRB3XczE20B
         gP2kLOa8V21kGuadBRQWhGxl+lZyC8QlTmV5hY1U=
Date:   Tue, 28 Apr 2020 08:37:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com
Subject: Re: [RFC 1/5] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200428063736.GB990431@kroah.com>
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
 <20200416205524.2043-2-yung-chuan.liao@linux.intel.com>
 <20200420072631.GW72691@vkoul-mobl>
 <20200423142451.GA4181720@kroah.com>
 <20200428043144.GU56386@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428043144.GU56386@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:01:44AM +0530, Vinod Koul wrote:
> > > That is not true for everyone, it is only true for Intel, pls call that
> > > out as well...
> > 
> > Why is it not true for everyone?  How else do you get the pm stuff back
> > to your hardware?
> 
> The rest of the world would do using the real controller device. For
> example the soundwire controller on Qualcomm devices is enumerated as a
> DT device and is using these...
> 
> If Intel had a standalone controller or enumerated as individual
> functions, it would have been a PCI device and would manage as such

If it is not a standalone controller, what exactly is it?  I thought it
was an acpi device, am I mistaken?

What is the device that the proper soundwire controller driver binds to
on an Intel-based system?

thanks,

greg k-h
