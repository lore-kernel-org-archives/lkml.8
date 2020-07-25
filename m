Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A909C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18C32067D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGYA2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGYA2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:28:16 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2F4C0619D3;
        Fri, 24 Jul 2020 17:28:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3495D12763AD5;
        Fri, 24 Jul 2020 17:11:30 -0700 (PDT)
Date:   Fri, 24 Jul 2020 17:28:14 -0700 (PDT)
Message-Id: <20200724.172814.1839512305996345802.davem@davemloft.net>
To:     vadym.kochan@plvision.eu
Cc:     kuba@kernel.org, jiri@mellanox.com, idosch@mellanox.com,
        andrew@lunn.ch, oleksandr.mazur@plvision.eu,
        serhiy.boiko@plvision.eu, serhiy.pshyk@plvision.eu,
        volodymyr.mytnyk@plvision.eu, taras.chornyi@plvision.eu,
        andrii.savka@plvision.eu, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mickeyr@marvell.com
Subject: Re: [net-next v2 1/6] net: marvell: prestera: Add driver for
 Prestera family ASIC devices
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200724141957.29698-2-vadym.kochan@plvision.eu>
References: <20200724141957.29698-1-vadym.kochan@plvision.eu>
        <20200724141957.29698-2-vadym.kochan@plvision.eu>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 Jul 2020 17:11:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadym Kochan <vadym.kochan@plvision.eu>
Date: Fri, 24 Jul 2020 17:19:52 +0300

> +int prestera_dsa_parse(struct prestera_dsa *dsa, const u8 *dsa_buf)
> +{
> +	u32 *dsa_words = (u32 *)dsa_buf;
 ...
> +	words[0] = ntohl((__force __be32)dsa_words[0]);
> +	words[1] = ntohl((__force __be32)dsa_words[1]);
> +	words[2] = ntohl((__force __be32)dsa_words[2]);
> +	words[3] = ntohl((__force __be32)dsa_words[3]);

Isn't is much easier to declare dsa_words as a "__be32 *" instead of
cast after cast after cast?

> +int prestera_dsa_build(const struct prestera_dsa *dsa, u8 *dsa_buf)
> +{
> +	__be32 *dsa_words = (__be32 *)dsa_buf;

Which you did properly here.
