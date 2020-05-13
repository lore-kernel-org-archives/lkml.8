Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09F7CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC3120740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589374881;
	bh=m8GZsqelm6lKhj1/vT9jlMCK7f8Uw381Kw8/Ni5D3SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dmRvBGkqWK13zZABtZ4u/bYqFDNumf4cK99fcJlQI25/+JxymZUq3QRQww516bgas
	 jFWVHlyMvIbBR9KH6FyRRnDdTRqMy9yONlJjVxGXTbw0ESPArsIi7n1+uoECwXRjfD
	 MZtS6W3oLLWNAXwSsufATqjF3K+mIveCcvuheSYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgEMNBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731915AbgEMNBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:01:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B34205ED;
        Wed, 13 May 2020 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589374880;
        bh=m8GZsqelm6lKhj1/vT9jlMCK7f8Uw381Kw8/Ni5D3SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnc+GvTzNPW18mO7QUiUOBrXXrokRnBxI2VA+MOZYmC6mgLH/Jk9FbFAyvfu2czrq
         S+IFMqHEoqDbxs+ZPhruWFvRRHKfO7JTQkG/5IPjDEgmSMu2R7OxFxbzgx3+Kr5pRG
         PoIAZJj1qKtp2lnGhDiqltUfAv6G6rNokODR8ePo=
Date:   Wed, 13 May 2020 15:01:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] USB: host: ehci: Add error handling in
 ehci_mxc_drv_probe()
Message-ID: <20200513130117.GA1085323@kroah.com>
References: <Pine.LNX.4.44L0.2005080950180.19653-100000@netrider.rowland.org>
 <9f88b0fd-28e9-2fa8-2deb-73652eb53fd4@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f88b0fd-28e9-2fa8-2deb-73652eb53fd4@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 08:55:59PM +0800, Tang Bin wrote:
> Hi gregkh:
> 
> On 2020/5/8 21:51, Alan Stern wrote:
> > On Fri, 8 May 2020, Tang Bin wrote:
> > 
> > > The function ehci_mxc_drv_probe() does not perform sufficient error
> > > checking after executing platform_get_irq(), thus fix it.
> > Aside from the "irq <= 0" issue, the Subject: line should say
> > "ehci-mxc", not "ehci".
> > 
> I know this patch need v2, whether just fix the subject?

0 is an invalid irq.

