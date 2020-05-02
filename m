Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAB0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991E3218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588420147;
	bh=uMv+2UC/Gh5aBns97kmJripvBbFHSheuufd2R8jE5AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D5fIMXcJQz7n+H6p/IhDgb8GBAu8CdTSRaNxngvQV2zG7bAzBT2EDlrNZRmKg4BP9
	 nVrXxn3llw3MWra/6R7l8giyt7erwNuwuwJlJR/GgZlScf/C5lGawbg8ReyYjfaHW9
	 6grMPQuhaG10+MTfjeLP1vB5lu+BaKOVE2KPvBTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgEBLtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgEBLtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:49:06 -0400
Received: from localhost (unknown [117.99.89.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0CE32137B;
        Sat,  2 May 2020 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588420145;
        bh=uMv+2UC/Gh5aBns97kmJripvBbFHSheuufd2R8jE5AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zaNzzcIJZekE55qR4qcPl8uM0I/yxOtLwKOo7ccXViqlYebU6GbJ+ycUCkQSRvJ/o
         ZWPt1Qa5S90xYU/D4UwoAYAS/0EPyHnCF8lNuYkApUo4NL+cAXB6zAbxs4t5W7GQpV
         JVRySLLBDt+8GFmFlEIQCAd4Hm7wMkHEkMAa8ZQw=
Date:   Sat, 2 May 2020 17:18:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: qcom: fix error handling in probe
Message-ID: <20200502114852.GQ948789@vkoul-mobl.Dlink>
References: <20200429185057.12810-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429185057.12810-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-04-20, 02:50, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Make sure all error cases are properly handled and all resources freed.

Applied, thanks

-- 
~Vinod
