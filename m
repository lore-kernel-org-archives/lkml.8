Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F08520706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHXXNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:13:50 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43370C061574;
        Mon, 24 Aug 2020 16:13:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5BC41129242A0;
        Mon, 24 Aug 2020 15:57:01 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:13:46 -0700 (PDT)
Message-Id: <20200824.161346.1009201417411312987.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     olteanv@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] net: dsa: sja1105: Do not use address of compatible
 member in sja1105_check_device_id
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200821222515.414167-1-natechancellor@gmail.com>
References: <20200821222515.414167-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Aug 2020 15:57:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Fri, 21 Aug 2020 15:25:16 -0700

> Clang warns:
> 
> drivers/net/dsa/sja1105/sja1105_main.c:3418:38: warning: address of
> array 'match->compatible' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         for (match = sja1105_dt_ids; match->compatible; match++) {
>         ~~~                          ~~~~~~~^~~~~~~~~~
> 1 warning generated.
> 
> We should check the value of the first character in compatible to see if
> it is empty or not. This matches how the rest of the tree iterates over
> IDs.
> 
> Fixes: 0b0e299720bb ("net: dsa: sja1105: use detected device id instead of DT one on mismatch")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1139
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, thanks.
