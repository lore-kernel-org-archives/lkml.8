Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF64CC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85981206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgASPHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 10:07:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49078 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgASPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 10:07:04 -0500
Received: from localhost (unknown [62.21.130.100])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 36F7B14EC31F9;
        Sun, 19 Jan 2020 07:07:02 -0800 (PST)
Date:   Sun, 19 Jan 2020 16:07:00 +0100 (CET)
Message-Id: <20200119.160700.794476737800658293.davem@davemloft.net>
To:     zhengdejin5@gmail.com
Cc:     alexaundru.ardelean@analog.com, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin: fix a warning about msleep
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200117151042.28742-1-zhengdejin5@gmail.com>
References: <20200117151042.28742-1-zhengdejin5@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Jan 2020 07:07:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Fri, 17 Jan 2020 23:10:42 +0800

> found a warning by the following command:
> ./scripts/checkpatch.pl -f drivers/net/phy/adin.c
> 
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst
>  #628: FILE: drivers/net/phy/adin.c:628:
> +	msleep(10);
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Not critical, so applied to net-next.

Thanks.
