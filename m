Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3A9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5303C20691
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgFISgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgFISgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:36:47 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35AC05BD1E;
        Tue,  9 Jun 2020 11:36:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E8ECD1275613D;
        Tue,  9 Jun 2020 11:36:36 -0700 (PDT)
Date:   Tue, 09 Jun 2020 11:36:33 -0700 (PDT)
Message-Id: <20200609.113633.1866761141966326637.davem@davemloft.net>
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
In-Reply-To: <20200609101935.5716b3bd@hermes.lan>
References: <20200607153019.3c8d6650@hermes.lan>
        <20200607.164532.964293508393444353.davem@davemloft.net>
        <20200609101935.5716b3bd@hermes.lan>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 09 Jun 2020 11:36:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 9 Jun 2020 10:19:35 -0700

> Yes, words do matter and convey a lot of implied connotation and
> meaning.

What is your long term plan?  Will you change all of the UAPI for
bonding for example?

Or will we have a partial solution to the problem?
