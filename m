Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D458C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE12E2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbgFWVxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWVxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:53:03 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20430C061573;
        Tue, 23 Jun 2020 14:53:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8257512944A9D;
        Tue, 23 Jun 2020 14:53:02 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:53:01 -0700 (PDT)
Message-Id: <20200623.145301.492643975758571231.davem@davemloft.net>
To:     alobakin@pm.me
Cc:     kuba@kernel.org, mkubecek@suse.cz, f.fainelli@gmail.com,
        andrew@lunn.ch, jiri@mellanox.com, antoine.tenart@bootlin.com,
        steffen.klassert@secunet.com, ayal@mellanox.com,
        therbert@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] net: ethtool: add missing string for
 NETIF_F_GSO_TUNNEL_REMCSUM
From:   David Miller <davem@davemloft.net>
In-Reply-To: <C_D5pdWhThP15fmS3ndY6GxGStCPm5YVuBeR2FoVIEv4_kEoTSW-8gQ7W04kSxy0WCoIAvtjyeF_PERcT6IGj8KAmOn3EY7jrXVxVC0Wqhs=@pm.me>
References: <C_D5pdWhThP15fmS3ndY6GxGStCPm5YVuBeR2FoVIEv4_kEoTSW-8gQ7W04kSxy0WCoIAvtjyeF_PERcT6IGj8KAmOn3EY7jrXVxVC0Wqhs=@pm.me>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Jun 2020 14:53:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>
Date: Tue, 23 Jun 2020 10:43:48 +0000

> Commit e585f2363637 ("udp: Changes to udp_offload to support remote
> checksum offload") added new GSO type and a corresponding netdev
> feature, but missed Ethtool's 'netdev_features_strings' table.
> Give it a name so it will be exposed to userspace and become available
> for manual configuration.
> 
> v3:
>  - decouple from "netdev_features_strings[] cleanup" series;
>  - no functional changes.
> 
> v2:
>  - don't split the "Fixes:" tag across lines;
>  - no functional changes.
> 
> Fixes: e585f2363637 ("udp: Changes to udp_offload to support remote checksum offload")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Applied and queued up for -stable, thanks.
