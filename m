Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EB0C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3079220749
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbgCLGH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:07:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56064 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgCLGH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:07:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 07D5014CD0E81;
        Wed, 11 Mar 2020 23:07:58 -0700 (PDT)
Date:   Wed, 11 Mar 2020 23:07:58 -0700 (PDT)
Message-Id: <20200311.230758.1550551446954210579.davem@davemloft.net>
To:     dominik.b.czarnota@gmail.com
Cc:     bh74.an@samsung.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix off by one in samsung driver strncpy size arg
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200309152250.5686-1-dominik.b.czarnota@gmail.com>
References: <20200309152250.5686-1-dominik.b.czarnota@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Mar 2020 23:07:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik 'disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Date: Mon,  9 Mar 2020 16:22:50 +0100

> From: disconnect3d <dominik.b.czarnota@gmail.com>
> 
> This patch fixes an off-by-one error in strncpy size argument in
> drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c. The issue is that in:
> 
>         strncmp(opt, "eee_timer:", 6)
> 
> the passed string literal: "eee_timer:" has 10 bytes (without the NULL
> byte) and the passed size argument is 6. As a result, the logic will
> also accept other, malformed strings, e.g. "eee_tiXXX:".
> 
> This bug doesn't seem to have any security impact since its present in
> module's cmdline parsing code.
> 
> Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>

Applied, thank you.
