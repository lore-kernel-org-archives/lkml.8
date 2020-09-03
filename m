Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E631C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0DC205CB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgICVz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgICVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:55:50 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDE3C061244;
        Thu,  3 Sep 2020 14:55:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 405C31278A41E;
        Thu,  3 Sep 2020 14:39:02 -0700 (PDT)
Date:   Thu, 03 Sep 2020 14:55:48 -0700 (PDT)
Message-Id: <20200903.145548.158854976353984242.davem@davemloft.net>
To:     geert+renesas@glider.be
Cc:     ayush.sawal@chelsio.com, vinay.yadav@chelsio.com,
        rohitm@chelsio.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chelsio/chtls: CHELSIO_INLINE_CRYPTO should depend on
 CHELSIO_T4
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200901145841.14893-1-geert+renesas@glider.be>
References: <20200901145841.14893-1-geert+renesas@glider.be>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 03 Sep 2020 14:39:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue,  1 Sep 2020 16:58:41 +0200

> While CHELSIO_INLINE_CRYPTO is a guard symbol, and just enabling it does
> not cause any additional code to be compiled in, all configuration
> options protected by it depend on CONFIG_CHELSIO_T4.  Hence it doesn't
> make much sense to bother the user with the guard symbol question when
> CONFIG_CHELSIO_T4 is disabled.
> 
> Fix this by moving the dependency from the individual config options to
> the guard symbol.
> 
> Fixes: 44fd1c1fd8219551 ("chelsio/chtls: separate chelsio tls driver from crypto driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to net-next, thank you.

Please clearly state the target tree in your future submissions,
f.e. "Subject: [PATCH net-next] ..."

Thanks again.
