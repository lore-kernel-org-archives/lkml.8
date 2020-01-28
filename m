Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E3C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296CC24685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580215451;
	bh=uKTAUZDjKUwxebo4v8hWYH0ksqT6ZERmpWj9YNS4ylY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GQhWd5se+/QDe2Wt0sNOhqTlu5ne94S6hh70S5xtpefPzxchOXay5F3XtSp1DVqvB
	 qP4UnhmYtlrtgV2QTTNdaAZAHuwQSpsg92Z/7Rd/d+sepf4R+atkLZufRrVsf6PMeI
	 3zLnIOuqZc9j6qA5hyPcrDqmFilKljNbrfmTSeUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgA1MoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:44:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgA1MoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:44:10 -0500
Received: from localhost (unknown [223.226.101.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27690206A2;
        Tue, 28 Jan 2020 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580215450;
        bh=uKTAUZDjKUwxebo4v8hWYH0ksqT6ZERmpWj9YNS4ylY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ZoJyQPS/SeO7O+nmQsuEE54zWfhEDBWIEBSYmbImypPSxRhjK5iDMoBau/mWaEU3
         UqvF53mj3rEDZf8IZJhVt951W4BJDXnyuw3VJD7eHj+USLlgJaTL6A5C3Sj4/wq4HQ
         GXqNkctDThbtk8WPPQzEVHev/kTQ4bsc6jY/dQz0=
Date:   Tue, 28 Jan 2020 18:14:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        grygorii.strashko@ti.com
Subject: Re: [PATCH for-next 1/4] dmaengine: ti: k3-udma: Use
 ktime/usleep_range based TX completion check
Message-ID: <20200128124403.GV2841@vkoul-mobl>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
 <20200127132111.20464-2-peter.ujfalusi@ti.com>
 <20200128114820.GS2841@vkoul-mobl>
 <d968f32d-dc5f-0567-5aa4-faf318025c23@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d968f32d-dc5f-0567-5aa4-faf318025c23@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-20, 17:35, Vignesh Raghavendra wrote:

> >> +	/* Transfer is incomplete, store current residue and time stamp */
> >>  	if (peer_bcnt < bcnt) {
> >>  		uc->tx_drain.residue = bcnt - peer_bcnt;
> >> -		uc->tx_drain.jiffie = jiffies;
> >> +		uc->tx_drain.tstamp = ktime_get();
> > 
> > Any reason why ktime_get() is better than jiffies..?
> 
> Resolution of jiffies is 4ms. ktime_t is has better resolution (upto ns
> scale). With jiffies, I observed that code was either always polling DMA
> progress counters (which affects HW data transfer speed) or sleeping too
> long, both causing performance loss. Switching to ktime_t provides
> better prediction of how long transfer takes to complete.

Thanks for explanation, i think it is good info to add in changelog.

-- 
~Vinod
