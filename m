Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9B5C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 06:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400EE2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 06:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579846445;
	bh=hPxhx/xkr883zKOO/zMMfJPW/taB/rLS1YKC4mlh6lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vLCFmTVRSh6zKF5ldwQnarQlhqGIVulC6yEK+OhYCaMuwvwWA5gT73FHY/PVTFE2H
	 eMXBu/rdST8nT3WgZiJyHTPBdRMguIqJBZFEGv89jEkIOF6+jqlcMkysVYCTwAd/vq
	 IlYHvWqn60+TFPW459JnZIFG/BKLdBzXgMBHIXG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgAXGOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 01:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgAXGOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 01:14:04 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554BE20718;
        Fri, 24 Jan 2020 06:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579846443;
        bh=hPxhx/xkr883zKOO/zMMfJPW/taB/rLS1YKC4mlh6lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9WGunnW/1R9rfdy6tqpXM3FIhxOtgH53RKUV4kOIwE7qw21RWr4WNvLEmi6T+Lu0
         hns2Zb6wxzSlK1jGqgXWZKDYuDC3W/VRRVQWrId8EaMw1SwM/u/h4gNrbk3FarxVYJ
         RdVMCrC9YLXeog6o6MqvIr7oah0xGyVQyLc35NnE=
Date:   Fri, 24 Jan 2020 11:43:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
Message-ID: <20200124061359.GF2841@vkoul-mobl>
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
 <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
 <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com>
 <CAMuHMdU=-Eo29=DQmq96OegdYAvW7Vw9PpgNWSTfjDWVF5jd-A@mail.gmail.com>
 <f7bbb132-1278-7030-7f40-b89733bcbd83@ti.com>
 <CAMuHMdXDiwTomiKp8Kaw0NvMNpg78-M88F0mNTWBOz5MLE4LtQ@mail.gmail.com>
 <20200122094002.GS2841@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122094002.GS2841@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-20, 15:10, Vinod Koul wrote:

> I like the idea of adding this in debugfs and giving more info, I would
> actually love to add bytes_transferred and few more info (descriptors
> submitted etc) to it...
> 
> > > This way we will have all the information in one place, easy to look up
> > > and you don't need to manage symlinks dynamically, just check all
> > > channels if they have slave_device/name when they are in_use (in_use w/o
> > > slave_device is 'non slave')
> > >
> > > Some drivers are requesting and releasing the DMA channel per transfer
> > > or when they are opened/closed or other variations.
> > >
> > > > What do other people think?
> > 
> > Vinod: do you have some guidance for your minions? ;-)
> 
> 
> That said, I am not against merging this patch while we add more
> (debugfs)... So do my minions agree or they have better ideas :-)

So no new ideas, I am going to apply this and queue for 5.6, something
is better than nothing.

And I am looking forward for debugfs to give better picture, volunteers?

-- 
~Vinod
