Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F55C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767102053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgHOV7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgHOVvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA73C0612EE;
        Fri, 14 Aug 2020 20:40:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E202127C1BB6;
        Fri, 14 Aug 2020 20:23:36 -0700 (PDT)
Date:   Fri, 14 Aug 2020 20:40:19 -0700 (PDT)
Message-Id: <20200814.204019.24901697728238188.davem@davemloft.net>
To:     jarod@redhat.com
Cc:     linux-kernel@vger.kernel.org, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net, netdev@vger.kernel.org,
        jay.vosburgh@canonical.com
Subject: Re: [PATCH net v2] bonding: show saner speed for broadcast mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200813140900.7246-1-jarod@redhat.com>
References: <20200813035509.739-1-jarod@redhat.com>
        <20200813140900.7246-1-jarod@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Aug 2020 20:23:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarod Wilson <jarod@redhat.com>
Date: Thu, 13 Aug 2020 10:09:00 -0400

> Broadcast mode bonds transmit a copy of all traffic simultaneously out of
> all interfaces, so the "speed" of the bond isn't really the aggregate of
> all interfaces, but rather, the speed of the slowest active interface.
> 
> Also, the type of the speed field is u32, not unsigned long, so adjust
> that accordingly, as required to make min() function here without
> complaining about mismatching types.
> 
> Fixes: bb5b052f751b ("bond: add support to read speed and duplex via ethtool")
> CC: Jay Vosburgh <j.vosburgh@gmail.com>
> CC: Veaceslav Falico <vfalico@gmail.com>
> CC: Andy Gospodarek <andy@greyhouse.net>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
> v2: fix description to clarify speed == that of slowest active interface

Applied, thank you.
