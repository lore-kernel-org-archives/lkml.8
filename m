Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBA42081A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591088544;
	bh=ucs42Iz/kbBKflFW6zvQpMzG7SBqBXdVeSGNEUXuRjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fvx6NiRdMGEnIshuyF6Xzoev+yVrE7M0+jhTcb5RL+dvF2yP5YC8h20hN2rjInuYu
	 yPphDh0DKKXKO/d9MoUHZ4R4L8+XIl3l/iF+2FD53vlNEdDonEcK1oBoRJlcMDCZh9
	 C6QkHskSfoL+gUPJrqP/mVjCzMsExKt4iafNCQ1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFBJCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBJCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:02:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7127420679;
        Tue,  2 Jun 2020 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591088540;
        bh=ucs42Iz/kbBKflFW6zvQpMzG7SBqBXdVeSGNEUXuRjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAhc4Vyah8ojoJC/K/dVBlgtd+tylzqZgMP2YfVjSv703EoXR6n22eBNdP1ZBrX0L
         eE+GlAf6OnOM2oGHfv0/3+sCTgf/hI8pYhr6Bmcs2du4Jh2//d1GrKfhT6nQ46TTPc
         HLt5of1DzQOFQCljjHP0qNHK9lVwe32MosM+n3+o=
Date:   Tue, 2 Jun 2020 11:02:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vinod.koul@linaro.org, tiwai@suse.de,
        mengdong.lin@intel.com, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: clarify SPDX use of GPL-2.0
Message-ID: <20200602090219.GB2735864@kroah.com>
References: <20200531172807.27042-1-yung-chuan.liao@linux.intel.com>
 <20200601053809.GA1420218@kroah.com>
 <686345af-4fda-4bc1-c3bf-da31406e806b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686345af-4fda-4bc1-c3bf-da31406e806b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 03:50:13PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 6/1/20 12:38 AM, Greg KH wrote:
> > On Mon, Jun 01, 2020 at 01:28:07AM +0800, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > Change SPDX from GPL-2.0 to GPL-2.0-only for Intel-contributed
> > > code. This was explicit before the transition to SPDX and lost in
> > > translation.
> > 
> > It is also explicit in the "GPL-2.0" lines as well, did you read the
> > LICENSES/preferred/GPL-2.0 file for the allowed tags to be used for this
> > license?
> > 
> > So this doesn't change anything, and we are trying to cut down on this
> > type of churn until, maybe, after the whole kernel has proper SPDX
> > lines.
> 
> My commit message was misleading, sorry. For SoundWire, we recently added
> new files with GPL-2.0-only (master + sysfs), as recommended since the short
> GPL-2.0 identifier is deprecated (https://spdx.org/licenses/GPL-2.0.html
> https://spdx.org/licenses/).

Again, that is the SPDX new list, of course they want to depreciate
older versions.  But we started the kernel conversion _before_ the newer
version was there, let's not worry about changing anything at this point
in time as that is unneeded churn.

For new files, fine, pick which ever tag you want to use as documented
in the LICENSES/* files, but do not change existing ones please.

thanks,

greg k-h
