Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0755C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA0A2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599196246;
	bh=JL5hlEqAO1CvuAIi2Pmv3JSHZEXfeYK3TlK8ZhEqdLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XWy/hojbpCrJWJc8+JI3y9DLfXSINqsuk0OGIxJdbGn1mMj0dU8f5We1NjQkzft55
	 IrNWp5gESLCLahatF1JmCvF7du3WAzZI8Rlk9MRh5DRYx3cr/iy/aTMx0jBSj9IbMx
	 c2D7PNfuE0lPjvL5n0tjTZBT1MlDu2V4JXI6Mz3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIDFKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgIDFKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:10:43 -0400
Received: from localhost (unknown [122.182.253.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F03206B7;
        Fri,  4 Sep 2020 05:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599196242;
        bh=JL5hlEqAO1CvuAIi2Pmv3JSHZEXfeYK3TlK8ZhEqdLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKR4i72o6KurMdZKZBFgw9SN1ygVPqUQod9OmNx6AroxLoah11kRndIyyZuBZ8tR/
         WxkEwUIA5KCTCRsY0FLc41Dm8DmaWLdTrB2iXL0771wVVenKdh7rennjUhJJgNxx3P
         bWAPnrmMAwIrXqFx4iihi+34VI324MCDcGPro+mU=
Date:   Fri, 4 Sep 2020 10:40:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/7] ASoC: soundwire: Move sdw stream operations to
Message-ID: <20200904051036.GU2639@vkoul-mobl>
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
 <20200903104248.GQ2639@vkoul-mobl>
 <033ea005-e948-c2c6-9bd4-e074d3effde0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033ea005-e948-c2c6-9bd4-e074d3effde0@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-20, 09:05, Pierre-Louis Bossart wrote:
> 
> 
> On 9/3/20 5:42 AM, Vinod Koul wrote:
> > On 01-09-20, 23:02, Bard Liao wrote:
> > > sdw stream operation APIs can be called once per stream. dailink
> > > callbacks are good places to call these APIs.
> > 
> > Again, please mention here if this is to be merged thru sdw tree or ASoC
> > tree
> 
> Good point, I thought it wouldn't matter but it does. I just gave it a try
> and there seems to be a conflict on Mark's tree w/ drivers/soundwire/intel.c
> (likely due to missing patches already added to Vinod's tree).
> 
> So this should go to Vinod's tree with Mark's Acked-by tag on the ASoC
> changes.
> 
> Alternatively we can also split this in two, with ASoC-only and
> SoundWire-only patches in separate series if it's easier for maintainers. We
> would lose the rationale for the changes but that's not essential.

If there are no dependencies on each other, that is best preferred
option. One should mention in cover-letter about the linked series
though.

> 
> > > Pierre-Louis Bossart (7):
> > >    ASoC: soc-dai: clarify return value for get_sdw_stream()
> > >    soundwire: stream: fix NULL/IS_ERR confusion
> > >    soundwire: intel: fix NULL/ERR_PTR confusion
> > >    ASOC: Intel: sof_sdw: add dailink .trigger callback
> > >    ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
> > 
> > These should be ASoC
> 
> Right. if you are fine with the content and this goes in your tree, can this
> be modified while applying? Or do want a v2?
> 
> > >    soundwire: intel: remove .trigger operation
> > >    soundwire: intel: remove stream handling from .prepare and .hw_free
> > > 
> > >   drivers/soundwire/intel.c        | 60 ++++-------------------
> > >   drivers/soundwire/stream.c       |  2 +-
> > >   include/sound/soc-dai.h          |  3 +-
> > >   sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
> > >   4 files changed, 92 insertions(+), 54 deletions(-)
> > > 
> > > -- 
> > > 2.17.1
> > 

-- 
~Vinod
