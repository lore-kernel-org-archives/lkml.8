Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E6EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C922075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgGGWYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgGGWYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:24:19 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00977C061755;
        Tue,  7 Jul 2020 15:24:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 86C6B120F19F2;
        Tue,  7 Jul 2020 15:24:18 -0700 (PDT)
Date:   Tue, 07 Jul 2020 15:24:17 -0700 (PDT)
Message-Id: <20200707.152417.1518177240219672343.davem@davemloft.net>
To:     trix@redhat.com
Cc:     mlindner@marvell.com, stephen@networkplumber.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sky2: initialize return of gm_phy_read
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200703133359.22723-1-trix@redhat.com>
References: <20200703133359.22723-1-trix@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Jul 2020 15:24:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: trix@redhat.com
Date: Fri,  3 Jul 2020 06:33:59 -0700

> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this garbage return
> 
> drivers/net/ethernet/marvell/sky2.c:208:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
>         return v;
>         ^~~~~~~~
> 
> static inline u16 gm_phy_read( ...
> {
> 	u16 v;
> 	__gm_phy_read(hw, port, reg, &v);
> 	return v;
> }
> 
> __gm_phy_read can return without setting v.
> 
> So handle similar to skge.c's gm_phy_read, initialize v.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied, thank you.
