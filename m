Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40641C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BCA2071C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgEADyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgEADya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 23:54:30 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB06C035494;
        Thu, 30 Apr 2020 20:54:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7BE4912777A88;
        Thu, 30 Apr 2020 20:54:30 -0700 (PDT)
Date:   Thu, 30 Apr 2020 20:54:29 -0700 (PDT)
Message-Id: <20200430.205429.1968774502632115295.davem@davemloft.net>
To:     michael@walle.cc
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk
Subject: Re: [PATCH net-next] net: phy: at803x: add downshift support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200428211502.1290-1-michael@walle.cc>
References: <20200428211502.1290-1-michael@walle.cc>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Apr 2020 20:54:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>
Date: Tue, 28 Apr 2020 23:15:02 +0200

> The AR8031 and AR8035 support the link speed downshift. Add driver
> support for it. One peculiarity of these PHYs is that it needs a
> software reset after changing the setting, thus add the .soft_reset()
> op and do a phy_init_hw() if necessary.
> 
> This was tested on a custom board with the AR8031.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thank you.
