Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E6AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59820207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgESTDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgESTDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:03:53 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B372C08C5C0;
        Tue, 19 May 2020 12:03:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8D934128B3862;
        Tue, 19 May 2020 12:03:52 -0700 (PDT)
Date:   Tue, 19 May 2020 12:03:51 -0700 (PDT)
Message-Id: <20200519.120351.1307026516427954350.davem@davemloft.net>
To:     jk@ozlabs.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org,
        fthain@telegraphics.com.au, userm57@yahoo.com
Subject: Re: [PATCH] net: bmac: Fix read of MAC address from ROM
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200519010558.24805-1-jk@ozlabs.org>
References: <4863b7d34cf23d269921ad133dc585ec83a0bb63.camel@ozlabs.org>
        <20200519010558.24805-1-jk@ozlabs.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 May 2020 12:03:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 19 May 2020 09:05:58 +0800

> In bmac_get_station_address, We're reading two bytes at a time from ROM,
> but we do that six times, resulting in 12 bytes of read & writes. This
> means we will write off the end of the six-byte destination buffer.
> 
> This change fixes the for-loop to only read/write six bytes.
> 
> Based on a proposed fix from Finn Thain <fthain@telegraphics.com.au>.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Reported-by: Stan Johnson <userm57@yahoo.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Reported-by: Finn Thain <fthain@telegraphics.com.au>

Applied, thanks.
