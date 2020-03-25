Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB809C2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD27D2076F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585169030;
	bh=T6327siDwkSjwKtOzgPrqLAlLzoOEv2d9CmcijfXG+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h6awoy/rUJ3fI2txay+rO7YzCX9edGGrgpSuGJAoBSgmrXatjRod3T4ZoLVmmCOoj
	 hH7XFBIWNbaqqithzRg0ySG8gk3ycVG8s9lK30cu4ZkdS+EdPlJ8Qhcyph8h9s0kmZ
	 PnxyHGa0DUT1mR/cEwee8zVavcZ3yXBRKK5OA9tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCYUnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbgCYUnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:43:49 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20E420719;
        Wed, 25 Mar 2020 20:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585169028;
        bh=T6327siDwkSjwKtOzgPrqLAlLzoOEv2d9CmcijfXG+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqKJLHrdgND8zJ7x0P6RqLnlP29rB29a2aTwVY9TjVgg91wWiXqM6DOYSN4EpXBWt
         3NgAfNYb20cmTVrchfsW2lwKVzIR5xdVQpLTPkBYvtQZHkthbNTRXk8BapOg3ktUjh
         6KyHnpUjxlcA3ecrCjtV8bYAXZgl6JN1cLhxQaxI=
Date:   Thu, 26 Mar 2020 05:43:43 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Nick Bowler <nbowler@draconx.ca>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
Message-ID: <20200325204343.GB4960@redsun51.ssa.fujisawa.hgst.com>
References: <20200325002847.2140-1-nbowler@draconx.ca>
 <20200325191103.GA6495@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325191103.GA6495@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:11:03PM -0700, Christoph Hellwig wrote:
> A couple of comments:
> 
> No need for the "." the end of the subject line.
> 
> I also think you should just talk of the nvme_user_cmd function,
> as that also is used for the NVME_IOCTL_IO_CMD ioctl.  Also there now
> is a nvme_user_cmd64 variant that needs the same fix, can you also
> include that?

Yes, this patch should get those cases too.

I unstaged this patch for now, could you send a v2 with the suggestions?
