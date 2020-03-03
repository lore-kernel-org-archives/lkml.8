Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0AEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD48C215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583211565;
	bh=1QbMXScDoBHGeiga9CbK0y7yvrt3pgJfz3o3lM15WeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dz4kG3FkA+qsNmzx3fF0r+gJ5iPPYliJbG4QdCq9iktwqCbJVWuFLDU9bys1KL6x+
	 oMBQZn1Y7Nf1T64acsjHi2YC9R54HlZN/bPAyc/Bk+x+DDLWlezORZgZn5erIVteSV
	 IxABOQKPUGdR8BKPXQz3HJJyAaSGzJ1Z6kzf7kD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCCE7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgCCE7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:59:24 -0500
Received: from localhost (unknown [122.167.124.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62FBA20848;
        Tue,  3 Mar 2020 04:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583211564;
        bh=1QbMXScDoBHGeiga9CbK0y7yvrt3pgJfz3o3lM15WeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGXFKyNd0xOUOZVcL95og+gk5DsbSRDV98jHlAbr/pwL4wZSa5tYC1aQT7unaX2mC
         AhnHjlS4f7eXV0apaW4Ucv1qlh7BaL1UX1oo1xayKvQyDBsBtie2U2RGuOAOD+z85r
         cnIekMp/w3nWweFfCpusqx1pBheDxZSeeeqHHMxo=
Date:   Tue, 3 Mar 2020 10:29:19 +0530
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
Subject: Re: [PATCH v2] soundwire: bus: provide correct return value on error
Message-ID: <20200303045919.GO4148@vkoul-mobl>
References: <20200227220949.4013-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227220949.4013-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-02-20, 16:09, Pierre-Louis Bossart wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> It seems to be a typo. It makes more sense to return the return value
> of sdw_update() instead of the value we want to update.

Applied, thanks

-- 
~Vinod
