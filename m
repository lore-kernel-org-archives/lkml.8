Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3836C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3680206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594632292;
	bh=EH5TrWdmq6I1jgYbH1HZ5kpFdNMmEWTWCUX1Y6ss3iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1mmXv8yuwIdgYf1zhAd38PRUu9sleJrPRFZlRVvpnGzq1ealtm4/2KEGBX9zeaqU3
	 fXiKG49XmnaWP6tLoJ1hw/cdYzM2SKge8LXJM27vNJw7QVI3i+iAMvCKhzaNPESpBa
	 QCV+46sFOfFI8eAj14wVprLenkDWhvPM1f3Na6SA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgGMJYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgGMJYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:24:51 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377CC2076D;
        Mon, 13 Jul 2020 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594632290;
        bh=EH5TrWdmq6I1jgYbH1HZ5kpFdNMmEWTWCUX1Y6ss3iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaaK99rF2HP7TKwycgbM63GKNl3Q3bd18O4sRxKaBGhqzmtguyP756uJYsXv7c3lt
         g6l9QbunOWXoxLu5ZAd8eWU74L36C/pXJikzoJRfP7CVMRt5V0+gWNHWOA+aLXEUIQ
         UUk/ZMIhSIyYdmd2XuMc7q+1K9VKM/4dybY1l//c=
Date:   Mon, 13 Jul 2020 14:54:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Swathi Kovvuri <swathi.kovvuri@intel.com>,
        peter.ujfalusi@ti.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: check device and channel list for empty
Message-ID: <20200713092445.GH34333@vkoul-mobl>
References: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
 <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
 <b9e8f171-6961-b483-c698-18a89e58f361@intel.com>
 <852318ec-9e18-3dee-a91d-1cf4dddb8906@kernel.org>
 <83932426-d52a-2e62-9d4b-5abb134a64df@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83932426-d52a-2e62-9d4b-5abb134a64df@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-20, 08:23, Dave Jiang wrote:
> 
> 
> On 7/8/2020 10:35 PM, Jiri Slaby wrote:
> > On 07. 07. 20, 17:42, Dave Jiang wrote:
> > > On 7/6/2020 11:05 PM, Jiri Slaby wrote:
> > > > On 26. 06. 20, 20:09, Dave Jiang wrote:
> > > > > Check dma device list and channel list for empty before iterate as the
> > > > > iteration function assume the list to be not empty. With devices and
> > > > > channels now being hot pluggable this is a condition that needs to be
> > > > > checked. Otherwise it can cause the iterator to spin forever.
> > > > 
> > > > Could you be a little bit more specific how this can spin forever? I.e.
> > > > can you attach a stacktrace of such a behaviour?
> > > 
> > > I can't seem to find the original splat that lead me to the conclusion
> > > of it's spinning forever. As I recall, the issue seems to produce
> > > different splats and not always consistent in being reproduced. Here's a
> > > partial splat that was tracked by the internal bug database. Since with
> > > the dma device and channel list being are hot added and removed, the
> > > device and channel lists can be empty. The list_entry() and friends
> > > expect the list to not be empty (according to header comment), I added
> > > the check to ensure that isn't the case before using them in dmaengine.
> > 
> > Yes, the comment states that as it is true: you receive a
> > wild/non-checkable pointer if you do list_entry on an empty list. BUT
> > have you actually read what I wrote:
> > 
> > > > As in the empty case, "&pos->member" is "head" (look into
> > > > list_for_each_entry) and the for loop should loop exactly zero times.
> > 
> > HERE ^^^^
> > 
> > > With the fix, we can no longer produce any of the splats. So maybe the
> > > above was a bad description of the issue.
> > 
> > No, not only the description, worse, the patch proper looks wrong.
> > 
> > > [ 4216.048375]  ? dma_channel_rebalance+0x7b/0x250
> > > [ 4216.056360]  dma_async_device_register+0x349/0x3a0
> > > [ 4216.064604]  idxd_register_dma_device+0x90/0xc0 [idxd]
> > > [ 4216.073175]  idxd_config_bus_probe.cold+0x7d/0x1fc [idxd]
> > 
> > So, the good part in the patch is the fixed locking in
> > dma_async_device_register. Otherwise it adds nonsense checks. So you
> > fixed the issue only by a chance, by a side effect as Peter pointed out.
> > Leaving aside that you broke dma_request_chan -- that could happen to
> > anybody.
> > 
> > Vinod, please drop/revert this patch. Then start over only with
> > dma_async_device_register fixed locking.
> 
> I'll start on the proper fix.

Dropped

-- 
~Vinod
