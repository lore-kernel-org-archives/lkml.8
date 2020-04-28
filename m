Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0DDC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F19E206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588060311;
	bh=fYRsuc0Ae0dKiL0d6kjd3W201rSLRhC7uULkGPtVblQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dwISWytJBpGiPaZHZVvuiTN42NAF/pxjnyjGCFzKHVDdjOlD/rn7BOizrRMHUjHSc
	 xE09Ewy81XSH7C4udYoNvnnk5lw75q2U66ZEe/1C2+h355XigWahdux1BXeVAaJF8j
	 S/TnqfNPll3nMbcGom9v1o5c3PAiZSkTAZoFum2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgD1Hvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD1Hvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:51:50 -0400
Received: from localhost (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0172053B;
        Tue, 28 Apr 2020 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588060309;
        bh=fYRsuc0Ae0dKiL0d6kjd3W201rSLRhC7uULkGPtVblQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xa4C6Ee2WJE5lMYYAI6Nn3sH1L9ucDYkdIzacdVf5sF2lXs9EdxQBqTlbSeNaTlFO
         OXnkLbdkGycxF4puebuZ8D/zeB464DqRdApxT3eSB0bZ/K1AXLolmE+WP5TcVhS0n+
         JqxDs7oVxp95HZcQ7ugMPro7yxFItSwuXSZE4ITU=
Date:   Tue, 28 Apr 2020 13:21:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com
Subject: Re: [RFC 1/5] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200428075145.GB56386@vkoul-mobl.Dlink>
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
 <20200416205524.2043-2-yung-chuan.liao@linux.intel.com>
 <20200420072631.GW72691@vkoul-mobl>
 <20200423142451.GA4181720@kroah.com>
 <20200428043144.GU56386@vkoul-mobl.Dlink>
 <20200428063736.GB990431@kroah.com>
 <20200428064951.GA56386@vkoul-mobl.Dlink>
 <20200428065524.GA992087@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428065524.GA992087@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-20, 08:55, Greg KH wrote:
> On Tue, Apr 28, 2020 at 12:19:51PM +0530, Vinod Koul wrote:
> > On 28-04-20, 08:37, Greg KH wrote:
> > > On Tue, Apr 28, 2020 at 10:01:44AM +0530, Vinod Koul wrote:
> > > > > > That is not true for everyone, it is only true for Intel, pls call that
> > > > > > out as well...
> > > > > 
> > > > > Why is it not true for everyone?  How else do you get the pm stuff back
> > > > > to your hardware?
> > > > 
> > > > The rest of the world would do using the real controller device. For
> > > > example the soundwire controller on Qualcomm devices is enumerated as a
> > > > DT device and is using these...
> > > > 
> > > > If Intel had a standalone controller or enumerated as individual
> > > > functions, it would have been a PCI device and would manage as such
> > > 
> > > If it is not a standalone controller, what exactly is it?  I thought it
> > > was an acpi device, am I mistaken?
> > > 
> > > What is the device that the proper soundwire controller driver binds to
> > > on an Intel-based system?
> > 
> > The HDA controller which is a PCI device. The device represent HDA
> > function, DSP and Soundwire controller instances (yes it is typically
> > more than one instance)
> 
> Then those "instances" should be split up into individual devices that a
> driver can bind to.  See the work happening on the "virtual" bus for
> examples of how that can be done.

Yes removing platform devices is the goal for Intel now :) Pierre & Bard
have been diligently trying to solve this.

Only difference is the means to end goal. I am not convinced that this
should be in soundwire subsystem.

Looks like folks are trying to review and port to use this bus. Makes
sense to me..
https://lore.kernel.org/netdev/c5197d2f-3840-d304-6b09-d334cae81294@linux.intel.com/

> A platform device better not be being used here, I'm afraid to look at
> the code now...

Well if the plan for 'virtual-bus' goes well, it should be  a simple
replacement of platform->virtual for Intel driver. Rest of the driver
should not be impacted :)

Thanks
-- 
~Vinod
