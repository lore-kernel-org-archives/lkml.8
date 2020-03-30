Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4652C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861352073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585575744;
	bh=K1ockVl39gLdCpYbJ/oumXMVl7UViARe6VaNnMLxqQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LhQ8AwT6ZqmsdQ2QUOunWvV9cYhUTK8E3uKcz4IcQfz4syDSmnkc0+3hd/vqM0Q7n
	 2Ixw6Ts2c9jpy0tG+ZK5Jj2BbRjippuJFo7ngfuuJXqn/lC9eWkaUzCykQaVUXK/Ru
	 56NDrcGG+yBh5fYs/pu21bLX7jTtUs6idu+S7+JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgC3NmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbgC3NmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:42:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE23F20716;
        Mon, 30 Mar 2020 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585575742;
        bh=K1ockVl39gLdCpYbJ/oumXMVl7UViARe6VaNnMLxqQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y+WW+flNgwBuY4vM8P2peunT13HsbPj9+bVg64Dt3LiH5tYdg0HURnKiVRM2WEUip
         f0QlWIfFPWVK5vDpokgaphtYQchufagDj5lljP672VWezTcGBAVZHHRp5HGnsTkRbL
         iPJDJaaWrbYP5EfzjYyIS3hdjUDuVhrkQ/ftk3EY=
Date:   Mon, 30 Mar 2020 14:42:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: don't clear debug registers in
 halt mode
Message-ID: <20200330134218.GB10633@willie-the-truck>
References: <20200328083209.21793-1-tingwei@codeaurora.org>
 <20200330123946.GH1309@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330123946.GH1309@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 01:39:46PM +0100, Mark Rutland wrote:
> On Sat, Mar 28, 2020 at 04:32:09PM +0800, Tingwei Zhang wrote:
> > If external debugger sets a breakpoint for one Kernel function
> > when device is in bootloader mode and loads Kernel, this breakpoint
> > will be wiped out in hw_breakpoint_reset(). To fix this, check
> > MDSCR_EL1.HDE in hw_breakpoint_reset(). When MDSCR_EL1.HDE is
> > 0b1, halting debug is enabled. Don't reset debug registers in this case.
> 
> I don't think this is sufficient, because the kernel can still
> subsequently mess with breakpoints, and the HW debugger might not be
> attached at this point in time anyhow.
> 
> I reckon this should hang off the existing "nodebumon" command line
> option, and we shouldn't use HW breakpoints at all when that is passed.
> Then you can pass that to prevent the kernel stomping on the external
> debugger.
> 
> Will, thoughts?

I was going to suggest the same thing, although we will also need to take
care to reset the registers if "nodebugmon" is toggled at runtime via the
"debug_enabled" file in debugfs.

Will
