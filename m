Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC428C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2CC206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgF3UhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgF3UhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:37:14 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C8C061755;
        Tue, 30 Jun 2020 13:37:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EC9631277ED77;
        Tue, 30 Jun 2020 13:37:12 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:37:12 -0700 (PDT)
Message-Id: <20200630.133712.641790280086952744.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     borisp@mellanox.com, aviadye@mellanox.com,
        john.fastabend@gmail.com, daniel@iogearbox.net, kuba@kernel.org,
        tariqt@mellanox.com, saeedm@mellanox.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net/tls: fix sign extension issue when left
 shifting u16 value
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200630142746.516188-1-colin.king@canonical.com>
References: <20200630142746.516188-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jun 2020 13:37:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 30 Jun 2020 15:27:46 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Left shifting the u16 value promotes it to a int and then it
> gets sign extended to a u64.  If len << 16 is greater than 0x7fffffff
> then the upper bits get set to 1 because of the implicit sign extension.
> Fix this by casting len to u64 before shifting it.
> 
> Addresses-Coverity: ("integer handling issues")
> Fixes: ed9b7646b06a ("net/tls: Add asynchronous resync")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks Colin.
