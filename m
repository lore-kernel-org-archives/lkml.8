Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19DFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 23:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75312206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 23:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFGXpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 19:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgFGXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 19:45:35 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF0C061A0E;
        Sun,  7 Jun 2020 16:45:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 44FBC12738C25;
        Sun,  7 Jun 2020 16:45:33 -0700 (PDT)
Date:   Sun, 07 Jun 2020 16:45:32 -0700 (PDT)
Message-Id: <20200607.164532.964293508393444353.davem@davemloft.net>
To:     stephen@networkplumber.org
Cc:     o.rempel@pengutronix.de, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, kuba@kernel.org, corbet@lwn.net,
        mkubecek@suse.cz, linville@tuxdriver.com, david@protonic.nl,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@armlinux.org.uk, mkl@pengutronix.de,
        marex@denx.de, christian.herber@nxp.com, amitc@mellanox.com,
        petrm@mellanox.com
Subject: Re: [PATCH ethtool v1] netlink: add master/slave configuration
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200607153019.3c8d6650@hermes.lan>
References: <20200526091025.25243-1-o.rempel@pengutronix.de>
        <20200607153019.3c8d6650@hermes.lan>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Jun 2020 16:45:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sun, 7 Jun 2020 15:30:19 -0700

> Open source projects have been working hard to remove the terms master and slave
> in API's and documentation. Apparently, Linux hasn't gotten the message.
> It would make sense not to introduce new instances.

Would you also be against, for example, the use of the terminology
expressing the "death" of allocated registers in a compiler backend,
for example?

How far do you plan take this resistence of terminology when it
clearly has a well defined usage and meaning in a specific technical
realm which is entirely disconnected to what the terms might imply,
meaning wise, in other realms?

And if you are going to say not to use this terminology, you must
suggest a reasonable (and I do mean _reasonable_) well understood
and _specific_ replacement.

Thank you.
