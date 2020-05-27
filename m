Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EEAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA772073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgE0Swj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgE0Swg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:52:36 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70DC08C5D1;
        Wed, 27 May 2020 11:35:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 95D78128B3528;
        Wed, 27 May 2020 11:35:25 -0700 (PDT)
Date:   Wed, 27 May 2020 11:35:24 -0700 (PDT)
Message-Id: <20200527.113524.946608619523725892.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        kuba@kernel.org, tglx@linutronix.de,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] bridge: multicast: work around clang bug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200527135124.1082844-1-arnd@arndb.de>
References: <20200527135124.1082844-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 May 2020 11:35:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 May 2020 15:51:13 +0200

> Clang-10 and clang-11 run into a corner case of the register
> allocator on 32-bit ARM, leading to excessive stack usage from
> register spilling:
> 
> net/bridge/br_multicast.c:2422:6: error: stack frame size of 1472 bytes in function 'br_multicast_get_stats' [-Werror,-Wframe-larger-than=]
> 
> Work around this by marking one of the internal functions as
> noinline_for_stack.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=45802#c9
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
