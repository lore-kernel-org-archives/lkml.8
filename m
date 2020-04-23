Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1729FC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF2520781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587622782;
	bh=iFjJ7P8tBt9jHw5u95JP/ux+NUoop1lg0l7BJRMhoB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DWb+aMI7saWEtyLp+9GYZTVN2m64aezNWqf1/BQracqL8OgzdUGB7H04TeZvIyDhq
	 BzYMaA5KzG3vHHTNhlll0aodLspfO2RYnZRDERTlCBygGl6bjJDAD5/AtAlxxV+X8U
	 i/8/QYsxBYugO4dxfxXrI5PPYt6FuknsA6Cqp6TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDWGTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgDWGTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:19:40 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FEE920724;
        Thu, 23 Apr 2020 06:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587622780;
        bh=iFjJ7P8tBt9jHw5u95JP/ux+NUoop1lg0l7BJRMhoB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cICEJ7bT3GN1L4+ipzn26G1bBSKBzZkqsDQKXBSIaQEJnTkROEOozheAlJxp+NaCE
         BjyzuOFtZXd3jSUsW+ZAC5lAv0QZjIMf0LaCP1+f0/F1cQJqdWe2UH/7Ok5Ynshqjc
         9XMxUTVgT9BGMCusZTVu5t0kD50JmTSx4+UM/4zk=
Date:   Thu, 23 Apr 2020 11:49:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] drivers: dma: pch_dma.c: Avoid data race between probe
 and irq handler
Message-ID: <20200423061935.GV72691@vkoul-mobl>
References: <20200416062335.29223-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416062335.29223-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-04-20, 11:53, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> pd->dma.dev is read in irq handler pd_irq().
> However, it is set to pdev->dev after request_irq().
> Therefore, set pd->dma.dev to pdev->dev before request_irq() to
> avoid data race between pch_dma_probe() and pd_irq().

Please use the right subsystem tag for patch. You can find that using
git log on the respective subsystem, in this case it would have told you
that it is dmaengine.

I have fixed that up and applied it, thanks for the patch

-- 
~Vinod
