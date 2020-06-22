Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5DEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEE72073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbgFVWnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbgFVWn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:29 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28317C061573;
        Mon, 22 Jun 2020 15:43:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D52F31296C074;
        Mon, 22 Jun 2020 15:43:28 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:43:28 -0700 (PDT)
Message-Id: <20200622.154328.664862561349747570.davem@davemloft.net>
To:     gustavoars@kernel.org
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com
Subject: Re: [PATCH][next] sparc64: viohs: Use struct_size() helper
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200620011406.GA3260@embeddedor>
References: <20200620011406.GA3260@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jun 2020 15:43:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Fri, 19 Jun 2020 20:14:06 -0500

> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes. Also, remove unnecessary
> variable _len_.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thank you.
