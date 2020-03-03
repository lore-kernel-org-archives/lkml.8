Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3954AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D8220870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgCCWya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:54:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36938 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgCCWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:54:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AD12A15A0CF86;
        Tue,  3 Mar 2020 14:54:28 -0800 (PST)
Date:   Tue, 03 Mar 2020 14:54:28 -0800 (PST)
Message-Id: <20200303.145428.1341062818121267356.davem@davemloft.net>
To:     o.rempel@pengutronix.de
Cc:     mkl@pengutronix.de, olteanv@gmail.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        kernel@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl
Subject: Re: [PATCH v1] net: dsa: sja1105: add 100baseT1_Full support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200303074414.30693-1-o.rempel@pengutronix.de>
References: <20200303074414.30693-1-o.rempel@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 03 Mar 2020 14:54:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Tue,  3 Mar 2020 08:44:14 +0100

> Validate 100baseT1_Full to make this driver work with TJA1102 PHY.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied to net-next, thank you.
