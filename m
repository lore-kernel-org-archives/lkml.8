Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC37C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666092074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHZAUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHZAUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:20:11 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F675C061574;
        Tue, 25 Aug 2020 17:20:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5FE9811E44280;
        Tue, 25 Aug 2020 17:03:20 -0700 (PDT)
Date:   Tue, 25 Aug 2020 17:20:03 -0700 (PDT)
Message-Id: <20200825.172003.1417643181819895272.davem@davemloft.net>
To:     vadym.kochan@plvision.eu
Cc:     kuba@kernel.org, jiri@mellanox.com, idosch@mellanox.com,
        andrew@lunn.ch, oleksandr.mazur@plvision.eu,
        serhiy.boiko@plvision.eu, serhiy.pshyk@plvision.eu,
        volodymyr.mytnyk@plvision.eu, taras.chornyi@plvision.eu,
        andrii.savka@plvision.eu, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        mickeyr@marvell.com
Subject: Re: [net-next v5 1/6] net: marvell: prestera: Add driver for
 Prestera family ASIC devices
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200825122013.2844-2-vadym.kochan@plvision.eu>
References: <20200825122013.2844-1-vadym.kochan@plvision.eu>
        <20200825122013.2844-2-vadym.kochan@plvision.eu>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Aug 2020 17:03:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadym Kochan <vadym.kochan@plvision.eu>
Date: Tue, 25 Aug 2020 15:20:08 +0300

> +int prestera_dsa_parse(struct prestera_dsa *dsa, const u8 *dsa_buf)
> +{
> +	__be32 *dsa_words = (__be32 *)dsa_buf;
> +	enum prestera_dsa_cmd cmd;
> +	u32 words[4] = { 0 };
> +	u32 field;
> +
> +	words[0] = ntohl(dsa_words[0]);
> +	words[1] = ntohl(dsa_words[1]);
> +	words[2] = ntohl(dsa_words[2]);
> +	words[3] = ntohl(dsa_words[3]);

All 4 elements of words[] are explicitly and unconditionally set to something,
so you don't need the "= { 0 }" initializer.

> +	INIT_LIST_HEAD(&sw->port_list);

What locking protects this list?

> +	new_skb = alloc_skb(len, GFP_ATOMIC | GFP_DMA);
> +	if (!new_skb)
> +		goto err_alloc_skb;

This seems very costly to do copies on every packet.  There should be
something in the dma_*() API that would allow you to avoid this.

And since you just need the buffer to DMA map it into the device,
allocating an entire SKB object is overkill.  You can instead just
allocate a ring of TX bounce buffers once, and then you just copy
each packet there.  No allocations per packet.
