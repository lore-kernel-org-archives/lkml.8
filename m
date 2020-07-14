Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20778C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070AE217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGNAyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGNAyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:54:55 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2CDC061755;
        Mon, 13 Jul 2020 17:54:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EDF2B129877C4;
        Mon, 13 Jul 2020 17:54:54 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:54:54 -0700 (PDT)
Message-Id: <20200713.175454.2187017553694804805.davem@davemloft.net>
To:     christophe.jaillet@wanadoo.fr
Cc:     pcnet32@frontier.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pcnet32: switch from 'pci_' to 'dma_' API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200713201846.282847-1-christophe.jaillet@wanadoo.fr>
References: <20200713201846.282847-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Jul 2020 17:54:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 13 Jul 2020 22:18:45 +0200

> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below and has been
> hand modified to replace GPF_ with a correct flag.
> It has been compile tested.
> 
> When memory is allocated in 'pcnet32_realloc_tx_ring()' and
> 'pcnet32_realloc_rx_ring()', GFP_ATOMIC must be used because a spin_lock is
> hold.
> The call chain is:
>    pcnet32_set_ringparam
>    ** spin_lock_irqsave(&lp->lock, flags);
>    --> pcnet32_realloc_tx_ring
>    --> pcnet32_realloc_rx_ring
>    ** spin_unlock_irqrestore(&lp->lock, flags);
> 
> When memory is in 'pcnet32_probe1()' and 'pcnet32_alloc_ring()', GFP_KERNEL
> can be used.
> 
> While at it, update a few comments and pr_err messages to be more in line
> with the new function names.
 ...
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.
