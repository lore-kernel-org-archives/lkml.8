Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33347C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BD7218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581567832;
	bh=oFuIKIBbpfNJBIKi9hk26HAIHYBy5AhoYQE6BtbHQ9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DYEHVEIpLZeXDM1uzpwp0UxadsKO8L3/xL3DgM1dV03dmtQMk9+JKXNrwGT5nqvzU
	 3L4iIJ+MuCRnJJsb/mg+YHDrXAWHjSPkLYOiKZ9vSO8HvqWxMjhyAzYjkyLG1Y6d+e
	 DABSkkqnlfikkb8xTACpNQ6XMDEq8JvrLntig1gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgBMEXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgBMEXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:23:50 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A87206ED;
        Thu, 13 Feb 2020 04:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581567830;
        bh=oFuIKIBbpfNJBIKi9hk26HAIHYBy5AhoYQE6BtbHQ9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMpVF6tIkzuSqTk30LsQb7Tf+42ncsEE9P1Dn7O+0GWQ/HLAEtHpecBJaBseE/iJJ
         7UsYE+9ClL8TrQAnSG+ARtHxSvTfTVEhLF7sz5s2dfMHW/FhSS/CSc1S0niFxNkY/e
         nVZTLYtnEYnA+2Vf0pq9rbPMp+hhNwYPr3oHdD2Q=
Date:   Thu, 13 Feb 2020 09:53:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH v2 5/5] soundwire: intel: free all resources
 on hw_free()
Message-ID: <20200213042344.GC2618@vkoul-mobl>
References: <20200114234257.14336-1-pierre-louis.bossart@linux.intel.com>
 <20200114234257.14336-6-pierre-louis.bossart@linux.intel.com>
 <20200212101554.GB2618@vkoul-mobl>
 <c8219635-30be-9695-a3f5-cd649aa6fab7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8219635-30be-9695-a3f5-cd649aa6fab7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-02-20, 09:37, Pierre-Louis Bossart wrote:
> Hi Vinod,
> 
> > > +static int intel_free_stream(struct sdw_intel *sdw,
> > > +			     struct snd_pcm_substream *substream,
> > > +			     struct snd_soc_dai *dai,
> > > +			     int link_id)
> > > +{
> > > +	struct sdw_intel_link_res *res = sdw->link_res;
> > > +	struct sdw_intel_stream_free_data free_data;
> > 
> > where is this struct sdw_intel_stream_free_data defined. I dont see it
> > in this patch or this series..
> 
> the definition is already upstream :-)

Oops did i look at wrong branch, sorry!

> > > +	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
> > > +	if (ret < 0) {
> > > +		dev_err(dai->dev, "intel_free_stream: failed %d", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	sdw_release_stream(dma->stream);
> > 
> > I think, free the 'name' here would be apt
> 
> Right, this is something we discussed with Rander shortly before Chinese New
> Year and we wanted to handle this with a follow-up patch, would that work
> for you? if not I can send a v3, your choice.

It would be better if we fix this up in this series :)

-- 
~Vinod
