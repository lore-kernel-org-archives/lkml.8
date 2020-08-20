Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033FDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A022078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgHTX3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgHTX3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:29:07 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1573C061385;
        Thu, 20 Aug 2020 16:29:06 -0700 (PDT)
Received: from localhost (c-76-104-128-192.hsd1.wa.comcast.net [76.104.128.192])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 52C6D12879A36;
        Thu, 20 Aug 2020 16:12:20 -0700 (PDT)
Date:   Thu, 20 Aug 2020 16:29:05 -0700 (PDT)
Message-Id: <20200820.162905.221555195371922950.davem@davemloft.net>
To:     mark.tomlinson@alliedtelesis.co.nz
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gre6: Fix reception with IP6_TNL_F_RCV_DSCP_COPY
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200819015358.18559-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20200819015358.18559-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 20 Aug 2020 16:12:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Date: Wed, 19 Aug 2020 13:53:58 +1200

> When receiving an IPv4 packet inside an IPv6 GRE packet, and the
> IP6_TNL_F_RCV_DSCP_COPY flag is set on the tunnel, the IPv4 header would
> get corrupted. This is due to the common ip6_tnl_rcv() function assuming
> that the inner header is always IPv6. This patch checks the tunnel
> protocol for IPv4 inner packets, but still defaults to IPv6.
> 
> Fixes: 308edfdf1563 ("gre6: Cleanup GREv6 receive path, call common GRE functions")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>

Applied and queued up for -stable, thank you.
