Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ECAC2D0EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDAE20786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgC3Eoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:44:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33028 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgC3Eoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 00:44:39 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8164D15C5482A;
        Sun, 29 Mar 2020 21:44:37 -0700 (PDT)
Date:   Sun, 29 Mar 2020 21:44:36 -0700 (PDT)
Message-Id: <20200329.214436.1632842454034665578.davem@davemloft.net>
To:     philippe.schenker@toradex.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        silvan.murer@gmail.com, a.fatoum@pengutronix.de,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Subject: Re: [PATCH net-next v2 1/2] net: phy: micrel.c: add rgmii
 interface delay possibility to ksz9131
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200325173425.306802-1-philippe.schenker@toradex.com>
References: <20200325173425.306802-1-philippe.schenker@toradex.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Mar 2020 21:44:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>
Date: Wed, 25 Mar 2020 18:34:24 +0100

> The KSZ9131 provides DLL controlled delays on RXC and TXC lines. This
> patch makes use of those delays. The information which delays should
> be enabled or disabled comes from the interface names, documented in
> ethernet-controller.yaml:
> 
> rgmii:      Disable RXC and TXC delays
> rgmii-id:   Enable RXC and TXC delays
> rgmii-txid: Enable only TXC delay, disable RXC delay
> rgmii-rxid: Enable onlx RXC delay, disable TXC delay
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied.
