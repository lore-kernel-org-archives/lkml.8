Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A976120738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgHXR0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgHXRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:25:51 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95CC061573;
        Mon, 24 Aug 2020 10:25:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 14DB3128885BD;
        Mon, 24 Aug 2020 10:09:02 -0700 (PDT)
Date:   Mon, 24 Aug 2020 10:25:45 -0700 (PDT)
Message-Id: <20200824.102545.1450838041398463071.davem@davemloft.net>
To:     aranea@aixah.de
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] veth: Initialize dev->perm_addr
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200824143828.5964-1-aranea@aixah.de>
References: <20200824143828.5964-1-aranea@aixah.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Aug 2020 10:09:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mira Ressel <aranea@aixah.de>
Date: Mon, 24 Aug 2020 14:38:26 +0000

> Set the perm_addr of veth devices to whatever MAC has been assigned to
> the device. Otherwise, it remains all zero, with the consequence that
> ipv6_generate_stable_address() (which is used if the sysctl
> net.ipv6.conf.DEV.addr_gen_mode is set to 2 or 3) assigns every veth
> interface on a host the same link-local address.
> 
> The new behaviour matches that of several other virtual interface types
> (such as gre), and as far as I can tell, perm_addr isn't used by any
> other code sites that are relevant to veth.
> 
> Signed-off-by: Mira Ressel <aranea@aixah.de>
 ...
> @@ -1342,6 +1342,8 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
>  	if (!ifmp || !tbp[IFLA_ADDRESS])
>  		eth_hw_addr_random(peer);
>  
> +	memcpy(peer->perm_addr, peer->dev_addr, peer->addr_len);

Semantically don't you want to copy over the peer->perm_addr?

Otherwise this loses the entire point of the permanent address, and
what the ipv6 address generation facility expects.
