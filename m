Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E532C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B63B205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239096;
	bh=PG8ONfwbNIWRFQWv4oK7dPOCnqVwMfGzzAEvdN+LO3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wK3pZZqoAyA65J62aQYgdHl2m/7L0G9hWEQNi+XTR78jzLZaLZ/A5NuBIySn3uGlk
	 IWr/CzUlTSNJDtXoXaomwtevcCvnDgRvOZoopbmjVXvXY+WwZXfZ3sfbpZSGu36s8+
	 JPHqXCNQxhl68L9xUlq1/pyMggwlE+xuoU6iCb+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgCOCYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgCOCYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:14 -0400
Received: from localhost (unknown [122.167.115.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53C9420752;
        Sat, 14 Mar 2020 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584179428;
        bh=PG8ONfwbNIWRFQWv4oK7dPOCnqVwMfGzzAEvdN+LO3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ir4zF9+pvZAZ/J+1AxyFqo1b036riCM3vscJfbL/WizEfB8/vYi+ZB3U9rL2Fur2Z
         DmH+xQmT9F4WQImtm4/e5aO3kf0mVXaipMohN0g9iOujAVug2SGdGPrZhsxYx6Y04q
         sKbbsmezewvgvZIIseJi5ZP/2RxX1A61TzVrIkV0=
Date:   Sat, 14 Mar 2020 15:20:19 +0530
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
Subject: Re: [PATCH 03/16] soundwire: cadence: add interface to check clock
 status
Message-ID: <20200314095019.GQ4885@vkoul-mobl>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-4-pierre-louis.bossart@linux.intel.com>
 <20200313120607.GE4885@vkoul-mobl>
 <816cc363-5b49-9b04-54a4-be4f53001cc5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <816cc363-5b49-9b04-54a4-be4f53001cc5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-20, 11:31, Pierre-Louis Bossart wrote:
> 
> 
> > > +/**
> > > + * sdw_cdns_is_clock_stop: Check clock status
> > > + *
> > > + * @cdns: Cadence instance
> > > + */
> > > +bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns)
> > > +{
> > > +	u32 status;
> > > +
> > > +	status = cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP;
> > > +	if (status) {
> > > +		dev_dbg(cdns->dev, "Clock is stopped\n");
> > > +		return true;
> > > +	}
> > 
> > This can be further optimized to:
> > 
> >          return !!(cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP);
> 
> The logs are very useful for debug.

You have this log also in caller function.

-- 
~Vinod
