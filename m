Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 20:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA42920727
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 20:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgEPUxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbgEPUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 16:53:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9346DC061A0C;
        Sat, 16 May 2020 13:53:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CAA94119445C7;
        Sat, 16 May 2020 13:53:37 -0700 (PDT)
Date:   Sat, 16 May 2020 13:53:36 -0700 (PDT)
Message-Id: <20200516.135336.2032300090729040507.davem@davemloft.net>
To:     xulin.sun@windriver.com
Cc:     alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xulinsun@gmail.com
Subject: Re: [PATCH] net: mscc: ocelot: replace readx_poll_timeout with
 readx_poll_timeout_atomic
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200515031813.30283-1-xulin.sun@windriver.com>
References: <20200515031813.30283-1-xulin.sun@windriver.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 16 May 2020 13:53:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xulin Sun <xulin.sun@windriver.com>
Date: Fri, 15 May 2020 11:18:13 +0800

> BUG: sleeping function called from invalid context at drivers/net/ethernet/mscc/ocelot.c:59
> in_atomic(): 1, irqs_disabled(): 0, pid: 3778, name: ifconfig
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<ffff2b163c83b78c>] dev_set_rx_mode+0x24/0x40
> Hardware name: LS1028A RDB Board (DT)
> Call trace:
> dump_backtrace+0x0/0x140
> show_stack+0x24/0x30
> dump_stack+0xc4/0x10c
> ___might_sleep+0x194/0x230
> __might_sleep+0x58/0x90
> ocelot_mact_forget+0x74/0xf8
> ocelot_mc_unsync+0x2c/0x38
> __hw_addr_sync_dev+0x6c/0x130
> ocelot_set_rx_mode+0x8c/0xa0

Vladimir states that this call chain is not possible in mainline.

I'm not applying this.
