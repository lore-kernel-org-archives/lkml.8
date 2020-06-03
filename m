Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2421C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECFE206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nuyqM0oH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgFCP7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:59:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35132 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgFCP7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Hz2CzfspI6I+mnUYK0O9Xklgh1cB34aPkPjqGjCgtqM=; b=nuyqM0oHGPeGG/1ZKNyPlKWTIk
        U2XE/VQqnR452AqIWqC6jqOS8MHzybsCbs94VnIy2uPYSSSMon6hrbX4KmFd6hvTS49uBscg7EdZ3
        ksSTBLeQGHT2URR/g8PI4N6t+VrOYIQZtRuJTREm//GOUxIQcqn3OjzrykUt8o/mlETo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jgVnb-0044H2-4D; Wed, 03 Jun 2020 17:59:27 +0200
Date:   Wed, 3 Jun 2020 17:59:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Roelof Berg <rberg@berg-solutions.de>
Cc:     David Miller <davem@davemloft.net>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lan743x: Added fixed link and RGMII support / BROKEN
 PATCH
Message-ID: <20200603155927.GC869823@lunn.ch>
References: <20200529193003.3717-1-rberg@berg-solutions.de>
 <20200601.115136.1314501977250032604.davem@davemloft.net>
 <D784BC1B-D14C-4FE4-8FD8-76BEBE60A39D@berg-solutions.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D784BC1B-D14C-4FE4-8FD8-76BEBE60A39D@berg-solutions.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:52:32PM +0200, Roelof Berg wrote:
> TEST REPORT: BROKEN PATCH
> 
> Thanks to everyone for working on the fixed link feature of lan743x eth driver.
> 

> I received more test hardware today, and one piece of hardware
> (EVBlan7430) becomes incompatible by the patch. We need to roll back
> for now. Sorry.

Hi Roelof

We have a bit of time to fix this, before it becomes too critical.
So lets try to fix it.

How did it break?

    Thanks
	Andrew
