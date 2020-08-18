Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371F7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A6B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597732056;
	bh=JSK9ci9WhE9/2a+BcV+RJI/GZdayBc/8ZdvTiCoeTGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ga9A7WICeBOmghp21z9zp/SwPBGSAstFyFCsjYxWKLw7t/obExHMe+OQICtQGH3zs
	 lTcIs7o0Qt0WIkk4FZki6M5KYo8uU1YDpIyq0lVunqzEuM0PEzdrlovsiNfJ5SRIrW
	 EBtWjVhdyVyXUT4Sb1LBmtVRJTFcHPVbnb5WJWCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRG1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgHRG1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:27:34 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B66B20825;
        Tue, 18 Aug 2020 06:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597732053;
        bh=JSK9ci9WhE9/2a+BcV+RJI/GZdayBc/8ZdvTiCoeTGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wGw3PcUkzKlVCGYV8eKWpkIal8/JUgTDCMtBdO7CCK31U/1VWTvCMAuy5BlpYJM1s
         ZKEEwXShBPr8QzhBWt6npd96Ftf4aS0BGnD/aGbueLot1Sqnwy9ehLXW1UwdYu1rFk
         iivNWMnAt4cQVMj3Ks84ZeiibfC1L3ZhkH2m4ask=
Date:   Tue, 18 Aug 2020 11:57:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 09/13] soundwire: intel: add CLK_STOP_BUS_RESET support
Message-ID: <20200818062729.GS2639@vkoul-mobl>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
 <20200721203723.18305-10-yung-chuan.liao@linux.intel.com>
 <20200817114729.GP2639@vkoul-mobl>
 <8aac898f-92d3-c907-ebb8-4642a618645b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aac898f-92d3-c907-ebb8-4642a618645b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-20, 09:30, Pierre-Louis Bossart wrote:
> 
> 
> 
> > > +	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
> > > +		ret = sdw_cdns_clock_stop(cdns, true);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "cannot enable clock stop on suspend\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		ret = sdw_cdns_enable_interrupt(cdns, false);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "cannot disable interrupts on suspend\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		ret = intel_link_power_down(sdw);
> > > +		if (ret) {
> > > +			dev_err(dev, "Link power down failed: %d", ret);
> > > +			return ret;
> > > +		}
> > 
> > no cleanup on all the error cases here?
> 
> See above the 'else if' test, the clock stop on suspend will be followed by
> a bus reset on resume. this is essentially a complete bus restart.

ok

> The only open here is whether we should actually return an error while
> suspending, or just log the error and squelch it. We decided to return the
> status so that the pm_runtime suspend does not proceed: the state remains
> active which is easier to detect than a single line in a dmesg log.

right, returning makes sense and is done correctly above

-- 
~Vinod
