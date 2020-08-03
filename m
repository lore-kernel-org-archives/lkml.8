Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A4C2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgHCWqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHCWqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:46:02 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EA7C06174A;
        Mon,  3 Aug 2020 15:46:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 585BA12777A27;
        Mon,  3 Aug 2020 15:29:16 -0700 (PDT)
Date:   Mon, 03 Aug 2020 15:46:01 -0700 (PDT)
Message-Id: <20200803.154601.1933025293559830967.davem@davemloft.net>
To:     noodles@earth.li
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, kuba@kernel.org, linux@armlinux.org.uk,
        mnhagan88@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: dsa: qca8k: Add 802.1q VLAN
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <ec320e8e5a9691b85ee79f6ef03f1b0b6a562655.1596301468.git.noodles@earth.li>
References: <20200721171624.GK23489@earth.li>
        <ec320e8e5a9691b85ee79f6ef03f1b0b6a562655.1596301468.git.noodles@earth.li>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 15:29:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan McDowell <noodles@earth.li>
Date: Sat, 1 Aug 2020 18:06:46 +0100

> This adds full 802.1q VLAN support to the qca8k, allowing the use of
> vlan_filtering and more complicated bridging setups than allowed by
> basic port VLAN support.
> 
> Tested with a number of untagged ports with separate VLANs and then a
> trunk port with all the VLANs tagged on it.
> 
> v3:
> - Pull QCA8K_PORT_VID_DEF changes into separate cleanup patch
> - Reverse Christmas tree notation for variable definitions
> - Use untagged instead of tagged for consistency
> v2:
> - Return sensible errnos on failure rather than -1 (rmk)
> - Style cleanups based on Florian's feedback
> - Silently allow VLAN 0 as device correctly treats this as no tag
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>

Applied.
