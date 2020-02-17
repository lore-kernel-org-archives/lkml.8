Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459BAC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239B62070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBQDTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:19:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48184 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgBQDTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:19:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EE5D9155A048B;
        Sun, 16 Feb 2020 19:19:47 -0800 (PST)
Date:   Sun, 16 Feb 2020 19:19:47 -0800 (PST)
Message-Id: <20200216.191947.1749689417990170918.davem@davemloft.net>
To:     scott.branden@broadcom.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, rjui@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arun.parameswaran@broadcom.com
Subject: Re: [PATCH v2] net: phy: restore mdio regs in the iproc mdio driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200214214746.10153-1-scott.branden@broadcom.com>
References: <20200214214746.10153-1-scott.branden@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Feb 2020 19:19:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>
Date: Fri, 14 Feb 2020 13:47:46 -0800

> From: Arun Parameswaran <arun.parameswaran@broadcom.com>
> 
> The mii management register in iproc mdio block
> does not have a retention register so it is lost on suspend.
> Save and restore value of register while resuming from suspend.
> 
> Fixes: bb1a619735b4 ("net: phy: Initialize mdio clock at probe function")
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Applied and queued up for -stable.
