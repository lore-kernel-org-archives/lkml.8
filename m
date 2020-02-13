Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78616C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FD7222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581589758;
	bh=C+n8gkGa1BrkuFQo4Be8BYQ2BPP8MlNxfJQPsD8YUac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O9IzVv9cMcJnmpffjJe1LVLzjBdxtbIe8L/01gVlgGnedJ4P/cTp07HDY1W7dq76u
	 7ZpTCOoq8bf7oszWa/0ZllXD4/9Q0GSgc3um7mO1g88acULJATGci6YboVfp/U2K6H
	 zlVzlO5dh8kxBFizHEfk9a3DxXMuUfKOqdb+MzU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgBMK3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMK3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:29:17 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83E320873;
        Thu, 13 Feb 2020 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581589756;
        bh=C+n8gkGa1BrkuFQo4Be8BYQ2BPP8MlNxfJQPsD8YUac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIgwxVl4CVgxmncvBodw4ff3mLXhjEUUoiQZEiL1ht9+bdPeXNFToVgf2/tACq4rS
         9QAciZqn5Ck6g0vX0Z6SVQwpaspLdGNybti1ZfXSFQMchWKJjkh3pf8F0/nnt1pKc2
         3wsb8b0VfSa6Vi97kLXZmyeGg+MLpn8sye+RApRY=
Date:   Thu, 13 Feb 2020 15:59:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH v2 0/5] soundwire: stream: fix state machines and
 transitions
Message-ID: <20200213102911.GE2618@vkoul-mobl>
References: <20200114235227.14502-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114235227.14502-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 17:52, Pierre-Louis Bossart wrote:
> The existing stream support works fine with simple cases, but does not
> map well with ALSA transitions for underflows/resume where prepare()
> can be called multiple times. Concurrency with multiple devices per
> links or multiple streams enabled on the same link also needs to be
> fixed.
> 
> These patches are the result of hours of validation on the Intel side
> and should benefit other implementations since there is nothing
> hardware-specific. The Intel-specific changes being reviewed do depend
> on those stream changes though to be functional.

Applied, thanks

-- 
~Vinod
