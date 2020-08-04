Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E3FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029B52086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgHDXOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgHDXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:14:16 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79419C06174A;
        Tue,  4 Aug 2020 16:14:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC56E12896E76;
        Tue,  4 Aug 2020 15:57:29 -0700 (PDT)
Date:   Tue, 04 Aug 2020 16:14:14 -0700 (PDT)
Message-Id: <20200804.161414.149428114422381017.davem@davemloft.net>
To:     izabela.bakollari@gmail.com
Cc:     nhorman@tuxdriver.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCHv2 net-next] dropwatch: Support monitoring of dropped
 frames
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200804160908.46193-1-izabela.bakollari@gmail.com>
References: <20200707171515.110818-1-izabela.bakollari@gmail.com>
        <20200804160908.46193-1-izabela.bakollari@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Aug 2020 15:57:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: izabela.bakollari@gmail.com
Date: Tue,  4 Aug 2020 18:09:08 +0200

> @@ -1315,6 +1334,53 @@ static int net_dm_cmd_trace(struct sk_buff *skb,
>  	return -EOPNOTSUPP;
>  }
>  
> +static int net_dm_interface_start(struct net *net, const char *ifname)
> +{
> +	struct net_device *nd = dev_get_by_name(net, ifname);
> +
> +	if (nd)
> +		interface = nd;
> +	else
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int net_dm_interface_stop(struct net *net, const char *ifname)
> +{
> +	dev_put(interface);
> +	interface = NULL;
> +
> +	return 0;
> +}

Where is the netdev notifier that will drop this reference if the network
device is unregistered?
