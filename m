Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8A0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6694E20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E+2UXLkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgAaNhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:37:48 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59908 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgAaNhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bIL6s2tX20+CxxGQWJaV4RM/8y4pIfyAI9ZZqon5Vnw=; b=E+2UXLkAfhDVjyx79E0W5Yy+kM
        ivc9G26et7iRj2QkOXbpbz13uvKT9wn1zaNL1LXL51O3Idl1v+7ssyR9LMzPt66jrN3djYAO9+EDV
        z+rgCDIUJ7NkrPxrotASSbQvL/QFN96xnbf07fQ2fPjnnMSGnK6IXHotJ9wv7PB4m9uI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ixWUR-0007Iw-4I; Fri, 31 Jan 2020 14:37:43 +0100
Date:   Fri, 31 Jan 2020 14:37:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, anirudha.sarangi@xilinx.com,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, john.linn@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 -next 3/4] net: emaclite: Fix arm64 compilation
 warnings
Message-ID: <20200131133742.GD9639@lunn.ch>
References: <1580471270-16262-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1580471270-16262-4-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580471270-16262-4-git-send-email-radhey.shyam.pandey@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 05:17:49PM +0530, Radhey Shyam Pandey wrote:
>  
>  /* BUFFER_ALIGN(adr) calculates the number of bytes to the next alignment. */
> -#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32)adr)) % ALIGNMENT)
> +#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((ulong)adr)) % ALIGNMENT)

Hi Radhey

linux/kernel.h has a few interesting macros, like

#define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))

These are more likely to be correct across all architectures than
anything you role yourself.

	 Andrew
