Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC4EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C2D20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598599670;
	bh=ZKgBgkPLZoJc/kStyrmzO8ZmcG3Mtvo7x+SL2dAs6h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SCvpRLXt+x7fmq9lBA3uH22hvFGxIhBeJKKYBGs/Bl9YdoVsRl+OJYkYpRc5asEeI
	 FXtnW5pZLu1FL9LKI0VJgwYsEOlfrpXFN0FDy3E7G6ALNMD95mej0tkLdmfhc1wm16
	 Ij5X6R/w39tOaADQ4Jj5/9Icqfjc4Ezcd5vBNky8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgH1H1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgH1H1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:27:47 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4A1208CA;
        Fri, 28 Aug 2020 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598599667;
        bh=ZKgBgkPLZoJc/kStyrmzO8ZmcG3Mtvo7x+SL2dAs6h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAD8CL0Erh/teDxbTuuqQKHrcaC4IOjBehDT+dOCTzkSzWeRm6aLY/L0GxdYa0VnE
         umaTSwvQm7Jz3t9C7KjMKDt1NSAEiLqpHxe2pHdHW/GGem0ordiP4IKnZlBnVwoZOC
         G6rH4GRVGr2R2TSr3mFocrivVjQ7KYGo09mAQc94=
Date:   Fri, 28 Aug 2020 12:57:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 05/11] soundwire: bus: update multi-link definition with
 hw sync details
Message-ID: <20200828072742.GL2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-6-yung-chuan.liao@linux.intel.com>
 <20200826094420.GA2639@vkoul-mobl>
 <d534afc3-3c38-275e-2f62-0432ffd91a36@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d534afc3-3c38-275e-2f62-0432ffd91a36@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-20, 09:09, Pierre-Louis Bossart wrote:
> 
> 
> > > + * @hw_sync_min_links: Number of links used by a stream above which
> > > + * hardware-based synchronization is required. This value is only
> > > + * meaningful if multi_link is set. If set to 1, hardware-based
> > > + * synchronization will be used even if a stream only uses a single
> > > + * SoundWire segment.
> > 
> > Soundwire spec does not say anything about multi-link so this is left to
> > implementer. Assuming that value of 1 would mean hw based sync will
> > be used even for single stream does not make sense in generic terms.
> > Maybe yes for Intel but may not be true for everyone?
> 
> hw-based sync is required for Intel even for single stream. It's been part
> of the recommended programming flows since the beginning but ignored so far.
> 
> That said, this value is set by each master implementation, no one forces
> non-Intel users to implement an Intel-specific requirement.
> 
> > We already use m_rt_count in code for this, so the question is why is
> > that not sufficient?
> 
> Because as you rightly said above, Intel requires the hw_sync to be used
> even for single stream, but we didn't want others to be forced to use the
> hw-sync for single stream. the m_rt_count is not sufficient for Intel.
> 
> I think we are in agreement on not forcing everyone to follow what is
> required by Intel, and that's precisely why we added this setting. If you
> set it to two you would only use hw_sync when two masters are used.

Okay, it would be better if we move it to intel driver, but I see it may
not be trivial, so lets go with this approach.

-- 
~Vinod
