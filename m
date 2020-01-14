Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2961C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37DE2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578983058;
	bh=ZUoD3INw3Cu1YQ8pRQNik1wtXlHt3I/Pl/C+78OpQ9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+nSux1pM3Gkd+wG0663EGTY7ukmHY34XxZDC1R2uArT+MsoCNfBulailNz9aXgsb
	 Geutz02Pl+LQ/wKNnD81rbWqqjrbY3/VvGhPXb1En0L2Xu0twHNLGapOKmNI6RMNi0
	 PvyOp+GpwCcIWDebLLsn3Tp/e94syefoFesJao/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgANGYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgANGYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:24:17 -0500
Received: from localhost (unknown [49.207.51.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A71D2075B;
        Tue, 14 Jan 2020 06:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578983057;
        bh=ZUoD3INw3Cu1YQ8pRQNik1wtXlHt3I/Pl/C+78OpQ9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNJnEb9sJbszhRJ/LdyyK39ZrDf0LsrzhzRwCROpsPaA0jJlq4nSgSTe8JWNKk0Ix
         PCgFJR9EPtFyQ8KstpowsaTpMTXiAsVMG7n4oP+oEFw9dz3sR4OcjelGRIbPRDkh9Q
         CwR8ehwUqeqeT0690lxuYbkAC0zlVZk1yxFAUKAQ=
Date:   Tue, 14 Jan 2020 11:54:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 0/6] soundwire: cadence: better logs and error handling
Message-ID: <20200114062412.GC2818@vkoul-mobl>
References: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-20, 15:57, Pierre-Louis Bossart wrote:
> This is a stand-alone set of patches to improve error handling and
> provide better information to the platform integrator.
> 
> As suggested by Vinod, these patches are shared first - with the risk
> that they are separated from the actual steps where they are needed.
> 
> For reference, the complete set of 100+ patches required for SoundWire
> on Intel platforms is available here:

Applied all, thanks

-- 
~Vinod
