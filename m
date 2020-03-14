Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD849C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FADD20578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239114;
	bh=+pW3YzUyH0cg/KHykqp6AOMoambL+e3V8FJ78cxYe98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ipM+rb6H/k4GV3r0vcamiSnbI0SOoJKP7qZF+zWlkDlX4AER3qiylhRhHzxMGhM/0
	 SYLbLaX5u0ZQDi6n0QVD8tByszCuzbbo5CHBuyi1oFiavqVdEnwYKqOY0sDsr+L3Fq
	 BvsfZrXKiHsxYKLSpmmxSCzjDpOOfucWC8omm0Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCOCZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgCOCYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:13 -0400
Received: from localhost (unknown [122.167.115.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A8120753;
        Sat, 14 Mar 2020 09:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584179537;
        bh=+pW3YzUyH0cg/KHykqp6AOMoambL+e3V8FJ78cxYe98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UI4gKwVbJiR+VoSLoyLynOf8+KRReIEuPsKxngmstltQhAlnUa/Ilta/1JSx1Y9TY
         ZFv+yJHLGutB2tkbph8fpenwAHqWFlGPf7GbxDzVsHgGStSQSgcG4VF3n4sw6MbG5n
         pDh07RrXWdCrpKcmXEyEFIJG/OL+zEunNP8WR1Ew=
Date:   Sat, 14 Mar 2020 15:22:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 05/16] soundwire: cadence: add clock_stop/restart routines
Message-ID: <20200314095206.GR4885@vkoul-mobl>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-6-pierre-louis.bossart@linux.intel.com>
 <20200313122156.GG4885@vkoul-mobl>
 <6d38a58a-a840-169a-1078-e10c278c11fd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d38a58a-a840-169a-1078-e10c278c11fd@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-20, 12:07, Pierre-Louis Bossart wrote:
> 
> 
> On 3/13/20 7:21 AM, Vinod Koul wrote:
> > On 11-03-20, 13:41, Pierre-Louis Bossart wrote:
> > 
> > > @@ -225,12 +225,30 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
> > >   			return 0;
> > >   		timeout--;
> > > -		udelay(50);
> > > +		usleep_range(50, 100);
> > 
> > this seems okay change, but unrelated to this patch
> 
> ok. It doesn't really matter anyway, this function is removed in Patch 8

Ok pls drop from here.

> > > +int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
> > > +{
> > > +	bool slave_present = false;
> > > +	struct sdw_slave *slave;
> > > +	u32 status;
> > > +	int ret;
> > > +
> > > +	/* Check suspend status */
> > > +	status = cdns_readl(cdns, CDNS_MCP_STAT);
> > > +	if (status & CDNS_MCP_STAT_CLK_STOP) {
> > > +		dev_dbg(cdns->dev, "Clock is already stopped\n");
> > > +		return 1;
> > 
> > return of 1..? Does that indicate success/fail..?
> 
> success. I guess it could be moved as 0.

That would be better. We use 0 for success everywhere and -ve error
codes.

-- 
~Vinod
