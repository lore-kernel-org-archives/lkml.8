Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C0EC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F6C2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgA2Q6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:58:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34528 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgA2Q6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:58:48 -0500
Received: from localhost (dhcp-077-249-119-090.chello.nl [77.249.119.90])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7A0AA14F0D680;
        Wed, 29 Jan 2020 08:58:46 -0800 (PST)
Date:   Tue, 28 Jan 2020 11:00:35 +0100 (CET)
Message-Id: <20200128.110035.1287294869237249484.davem@davemloft.net>
To:     scott.branden@broadcom.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: add default ARCH_BCM_IPROC for
 MDIO_BCM_IPROC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200128003828.20439-1-scott.branden@broadcom.com>
References: <20200128003828.20439-1-scott.branden@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Jan 2020 08:58:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>
Date: Mon, 27 Jan 2020 16:38:28 -0800

> Add default MDIO_BCM_IPROC Kconfig setting such that it is default
> on for IPROC family of devices.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Applied, thanks.
