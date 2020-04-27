Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E6EC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C7D20728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD0Swd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgD0Swc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:52:32 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2087C0610D5;
        Mon, 27 Apr 2020 11:52:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DA3DB15D586BD;
        Mon, 27 Apr 2020 11:52:31 -0700 (PDT)
Date:   Mon, 27 Apr 2020 11:52:31 -0700 (PDT)
Message-Id: <20200427.115231.1873814851542756574.davem@davemloft.net>
To:     tony.felice@timesys.com
Cc:     akshay.bhat@timesys.com, hkallweit1@gmail.com,
        srinivas.kandagatla@linaro.org, natechancellor@gmail.com,
        robh@kernel.org, suzuki.poulose@arm.com, mst@redhat.com,
        andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tc35815: Fix phydev supported/advertising mask
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200427020101.3059-1-tony.felice@timesys.com>
References: <20200427020101.3059-1-tony.felice@timesys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Apr 2020 11:52:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Felice <tony.felice@timesys.com>
Date: Sun, 26 Apr 2020 22:00:59 -0400

> Commit 3c1bcc8614db ("net: ethernet: Convert phydev advertize and
> supported from u32 to link mode") updated ethernet drivers to use a
> linkmode bitmap. It mistakenly dropped a bitwise negation in the
> tc35815 ethernet driver on a bitmask to set the supported/advertising
> flags.
> 
> Found by Anthony via code inspection, not tested as I do not have the
> required hardware.
> 
> Fixes: 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")
> Signed-off-by: Anthony Felice <tony.felice@timesys.com>
> Reviewed-by: Akshay Bhat <akshay.bhat@timesys.com>

Applied.
