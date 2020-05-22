Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F27C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F1920823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgEVPh3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:37:29 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36321 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgEVPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:37:29 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0C8B040008;
        Fri, 22 May 2020 15:37:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200521.173105.157572657643183117.davem@davemloft.net>
References: <20200520100355.587686-1-antoine.tenart@bootlin.com> <20200521.173105.157572657643183117.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>
From:   Antoine Tenart <antoine.tenart@bootlin.com>
Subject: Re: [PATCH net-next] net: phy: mscc: fix initialization of the MACsec protocol mode
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <159016184520.3358.1393218293274400010@kwain>
Date:   Fri, 22 May 2020 17:37:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Miller (2020-05-22 02:31:05)
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Date: Wed, 20 May 2020 12:03:55 +0200
> 
> > What's the best way to handle this? I can provide all the patches.
> 
> Resubmit this against 'net' please, then I'll deal with the fallout
> when I merge net into net-next.

OK, I'll resubmit against net.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
