Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E6EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 23:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56CD20732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 23:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbgDOXVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 19:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388747AbgDOXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 19:21:27 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BE6C061A0C;
        Wed, 15 Apr 2020 16:21:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8C67E120ED569;
        Wed, 15 Apr 2020 16:21:26 -0700 (PDT)
Date:   Wed, 15 Apr 2020 16:21:25 -0700 (PDT)
Message-Id: <20200415.162125.2094896562695820757.davem@davemloft.net>
To:     jbx6244@gmail.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: ethernet-phy: add desciption for
 ethernet-phy-id1234.d400
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200415200149.16986-1-jbx6244@gmail.com>
References: <20200415200149.16986-1-jbx6244@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 15 Apr 2020 16:21:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>
Date: Wed, 15 Apr 2020 22:01:49 +0200

> The description below is already in use in
> 'rk3228-evb.dts', 'rk3229-xms6.dts' and 'rk3328.dtsi'
> but somehow never added to a document, so add
> "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
> for ethernet-phy nodes on Rockchip platforms to
> 'ethernet-phy.yaml'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

I'll take this via my net tree, thanks.
