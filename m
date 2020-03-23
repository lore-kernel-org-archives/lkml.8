Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7AEC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A627320787
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584966512;
	bh=AexYx5wOc1U061eltXUm1TbpFydE45ePZ/s/WCxM2RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vwoRUe8UryrRCo2BQf/dC1BK5Nb5+w+X/glKaJiFlEnaXT5QnGw2uScfCaFaSC6zX
	 nNi5vDDghA68CBRvvprnHg38tOtf2T1kTpBthkmVCC3vwkQcEG0YiyWy8hzpBKzkJ+
	 Z3d/89rqmIuITMK3xl80jIGR/DJNE3JfW5RMtePw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgCWM2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbgCWM2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:28:31 -0400
Received: from localhost (unknown [122.178.205.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163262076A;
        Mon, 23 Mar 2020 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584966510;
        bh=AexYx5wOc1U061eltXUm1TbpFydE45ePZ/s/WCxM2RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkCzc8kP3xbTKjWOGHgTW58ayOwIG6rpOGVwZ/LzBxVOavqRcL+6GE2Mnw6TUk3Dl
         JOS765Ghx8YoEAP2AQ3Pg75nUErlfZzcO+IkMIiqXwX267yNeCRZ2Iige1pkNoP3um
         nenJh5yv5aLPtJqOHMczXQVWvhLbOCfgo7ncwbG4=
Date:   Mon, 23 Mar 2020 17:58:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 4/7] soundwire: intel: add definitions for shim_mask
Message-ID: <20200323122826.GL72691@vkoul-mobl>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-5-pierre-louis.bossart@linux.intel.com>
 <20200320134257.GD4885@vkoul-mobl>
 <deeb3af8-e950-651c-50d6-6223e75801e9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deeb3af8-e950-651c-50d6-6223e75801e9@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-20, 09:13, Pierre-Louis Bossart wrote:
> 
> > > diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
> > > index 568c84a80d79..cfc83120b8f9 100644
> > > --- a/drivers/soundwire/intel.h
> > > +++ b/drivers/soundwire/intel.h
> > > @@ -16,6 +16,7 @@
> > >    * @ops: Shim callback ops
> > >    * @dev: device implementing hw_params and free callbacks
> > >    * @shim_lock: mutex to handle access to shared SHIM registers
> > > + * @shim_mask: global pointer to check SHIM register initialization
> > >    */
> > >   struct sdw_intel_link_res {
> > >   	struct platform_device *pdev;
> > > @@ -27,6 +28,7 @@ struct sdw_intel_link_res {
> > >   	const struct sdw_intel_ops *ops;
> > >   	struct device *dev;
> > >   	struct mutex *shim_lock; /* protect shared registers */
> > > +	u32 *shim_mask;
> > 
> > You have a pointer, okay where is it initialized
> 
> same answer as shim_lock, it's initialized at the higher level
> 
> https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L252

Why can't it be done here, what stops you?

You really need to keep initialzation and usage in same patch :(

-- 
~Vinod
