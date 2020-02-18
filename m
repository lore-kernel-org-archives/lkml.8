Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697E5C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4B722527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582015218;
	bh=oysnfDeX+x37pbSVDy8ym3/f1dM48yvStIkICrht8fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=COO20BFaTzP/1KWsj5O14q/5Ps7xff7zD3xicRHly6WVrGuy3LwyO9O1tU4nibrU5
	 XpJkdjRXYVI8iu3apiNkRd2OKTjuZ4dKNb4Xen78kgSKJDUTAeE0h38WiZ2QwxZ8Si
	 8Hgkai24ArwqXOTj6ABUYJwHd2rz7KBI8H2e7h8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgBRIkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:40:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgBRIkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:40:16 -0500
Received: from localhost (unknown [223.226.112.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A8F2176D;
        Tue, 18 Feb 2020 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582015216;
        bh=oysnfDeX+x37pbSVDy8ym3/f1dM48yvStIkICrht8fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OegWfWUaDQ+DilRbLi4I3DgfqefHkndDBkc2qS4uVtyDCtj4GgsERaSS/3m/XjJmd
         6mDF02v/dEK98bqSLBdVDmnp9tyMYtDRjAlNMgK+H9AU9A555DJUBVgJnamLM+pQcN
         UrExk2BTtl2iAFIi7aVwUFPuTF/EN2MmuRgTawz8=
Date:   Tue, 18 Feb 2020 14:10:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH v3 0/5] soundwire: intel: add DAI callbacks
Message-ID: <20200218084011.GB2618@vkoul-mobl>
References: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-20, 19:47, Pierre-Louis Bossart wrote:
> The existing mainline code is missing most of the DAI callbacks needed
> for a functional implementation, and the existing ones need to be
> modified to provide the relevant information to ASoC/SOF drivers.
> 
> As suggested by Vinod, these patches are shared first - with the risk
> that they are separated from the actual DAI enablement, so reviewers
> might wonder why they are needed in the first place.
> 
> For reference, the complete set of 90+ patches required for SoundWire
> on Intel platforms is available here:

Applied, thanks

-- 
~Vinod
