Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D68620EDD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598599429;
	bh=5VtJwAIqjRo8m3/A3PqgyBtUrnGNzj2MdnY7GmNZzkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=113Sf/+yhuMZVi9NZjmix3kLoWBCpGRbZKsxhsfyQjCJjtkFWyEcPVRtCIX6tbwKD
	 tJORO3p0kPmLpRwO6V2XlPWpcIO02ZDskAiC2udLWVAM8qeUajPr0C7dzxQHlRSrOD
	 HmOl0zGLCb8r3o+Jq9FEw5f+xnlTg6URhdB6eiag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgH1HXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgH1HXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:23:46 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A4420DD4;
        Fri, 28 Aug 2020 07:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598599426;
        bh=5VtJwAIqjRo8m3/A3PqgyBtUrnGNzj2MdnY7GmNZzkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNN/QFPjKawKCVc1KEdQSFVrMU+dMWopIxw033y4WIIekyPMNFmP4dpLBZxDDSvqF
         ImIyBpxdq0uwaKkQZa4wc44w7bvUwxHKOB5iILNl4enoLGHfOPqc+5x6N3TUKF6CDN
         fgnH294NFFT9jv6tZ1f30CiUxDEmjFCX2U1U7F5w=
Date:   Fri, 28 Aug 2020 12:53:42 +0530
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
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/4] regmap: sdw: add support for SoundWire 1.2 MBQ
Message-ID: <20200828072342.GK2639@vkoul-mobl>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
 <20200826090542.GZ2639@vkoul-mobl>
 <c5119781-bee0-f11b-eb73-cd2da6ab09f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5119781-bee0-f11b-eb73-cd2da6ab09f5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-20, 11:57, Pierre-Louis Bossart wrote:
> 
> > > +#include <linux/device.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/mod_devicetable.h>
> > 
> > Curious why do you need this header?
> 
> I'll return the question back to you, since you added this header for
> regmap-sdw.c:
> 
> 7c22ce6e21840 (Vinod Koul           2018-01-08 15:50:59 +0530  6) #include
> <linux/mod_devicetable.h>

Looks like it should be removed :)

I could compile it without any issues on few archs I do. let me push the
patch on my tree and see if bots are happy, will send the patch

> 
> so I assumed it was needed here as well.
> 
> > > +MODULE_DESCRIPTION("Regmap SoundWire Module");
> > 
> > This is same of sdw module, pls make this one a bit different.
> 
> yes, fixed.

-- 
~Vinod
