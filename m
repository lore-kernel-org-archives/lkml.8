Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB9AC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B07A207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598698868;
	bh=WGE/Ni8OgdnjEaI12x6E3/36gjTN5CWhg+VbB/qhaqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=UetL+gANcifllBzVyXxx3TzAtxY/lsJVQ2DhTxpenedqj83wHZnmgfvJbLJFCfGvH
	 H/xQaUTulc6IFAWPzL+PC5grMYZF8fLZfdeDQ9mKfhcLJ0XA5ERUaS9Z2jvZKnK3ES
	 WcpAkFIOr9kLAB4qPO6+7wAtNQHp7DtrNza9MVsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH2LA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgH2LAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:00:51 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581F4207DF;
        Sat, 29 Aug 2020 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598698851;
        bh=WGE/Ni8OgdnjEaI12x6E3/36gjTN5CWhg+VbB/qhaqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bJnOvrmEP3qQTbfhE1/jw5kbaTMAOYtleMdzUUT9cIxQMOjn8Lq4dVhAkOnXeTBe6
         O8LO8m0Bx55WrC11vqnNdsdNgnHwCGsUBTLE326hyT/40/2POv3i/v3US8LT0hMYH/
         SKGboRGHLqFc9fsyw21UAySMuQUwNNecQzpVHVVs=
Date:   Sat, 29 Aug 2020 16:30:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 09/11] soundwire: intel: add dynamic debug trace for
 clock-stop invalid configs
Message-ID: <20200829110047.GC2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d8a731-d753-060a-f224-63de3b29b7d2@linux.intel.com>
 <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 09:54, Pierre-Louis Bossart wrote:
> 
> > > > > Detect cases where the clock is assumed to be stopped but the IP is
> > > > > not in the relevant state, and add a dynamic debug trace.
> > > > 
> > > > you meant a debug print..and it looks like error print below (also in title).
> > > 
> > > I don't understand the comment. Is the 'trace' confusing and are you asking
> > > to e.g. change the commit message to 'add dynamic debug log'?
> > 
> > Question is what is dynamic about this?
> dev_dbg() is part of the kernel dynamic debug capability...
> 
> https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
> 
> Not sure what you are asking here?

:-| where is dev_dbg() ?

See [1]

On 18-08-20, 10:41, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Detect cases where the clock is assumed to be stopped but the IP is
> not in the relevant state, and add a dynamic debug trace.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 7c63581270fd..b82d02af3c4f 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1964,6 +1964,11 @@ static int intel_resume_runtime(struct device *dev)
>  			}
>  		}
>  	} else if (!clock_stop_quirks) {
> +
> +		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
> +		if (!clock_stop0)

[1]

> +			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);

                        ^^^^^^^

> +
>  		ret = intel_init(sdw);
>  		if (ret) {
>  			dev_err(dev, "%s failed: %d", __func__, ret);
> -- 
> 2.17.1


-- 
~Vinod
