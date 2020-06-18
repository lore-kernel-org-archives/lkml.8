Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5435C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921C720706
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3MwnKPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgFRIMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgFRIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:12:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8WLntUDK1QrdTrtcYEKpz3qz/VsDSn22rJQznhsWmU0=; b=e3MwnKPyFxHRL5O429eXq+MBeb
        V99twzBHr2ZXWFY2ynglX6gSFx36uKpjd+0ghXzeWdf0xh2c8LctMz+VtELXUOcNHtz9XzjU8fUCr
        l8CkSq1+PCFiYMhidXjLG1bJ5mmQfdYW5M9R7EtvGSPXG/yJFPaHK2jp8Y4bF0piLT+UoiNL7ynuj
        Z11k3keHfxpXLobhqyoreaHbJEfFh3hYOuFNAzAig5DQnpVAPzPfHBKqxfNtgI0ibbUbbi0aN9NPv
        5T9Rfw7VLV+IYFZNDXTnx6Qr4fb7bP+SBltVUTpaxTYa4LfhzntaknHQWJeRPCmhXI7dDHCxW7V1s
        fhhWC9TQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlpej-0001PE-74; Thu, 18 Jun 2020 08:12:17 +0000
Date:   Thu, 18 Jun 2020 01:12:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     JaeHun Jung <jh0801.jung@samsung.com>
Cc:     tiwai@suse.de, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ANDROID: sound: usb: Add vendor's hooking interface
Message-ID: <20200618081217.GA25552@infradead.org>
References: <CGME20200617022554epcas2p214a49f03a15e504d8faa28148e06e796@epcas2p2.samsung.com>
 <1592360304-29621-1-git-send-email-jh0801.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592360304-29621-1-git-send-email-jh0801.jung@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:18:24AM +0900, JaeHun Jung wrote:
> In mobile, a co-processor is used when using USB audio
> to improve power consumption.
> hooking is required for sync-up when operating
> the co-processor. So register call-back function.
> The main operation of the call-back function is as follows:
> - Initialize the co-processor by transmitting data
>   when initializing.
> - Change the co-processor setting value through
>   the interface function.
> - Configure sampling rate
> - pcm open/close
> 
> Bug: 156315379

None of that is acceptable without an in-tree user.  Never mind that
the interface just seems horrible.  I'm pretty sure we could do
somehting much better and more specific based on the actual needs of
the user, so please post it.
