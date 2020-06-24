Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A407C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E04720707
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbgFXD0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgFXD0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:26:30 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A883C061573;
        Tue, 23 Jun 2020 20:26:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EAF5B12985777;
        Tue, 23 Jun 2020 20:26:29 -0700 (PDT)
Date:   Tue, 23 Jun 2020 20:26:29 -0700 (PDT)
Message-Id: <20200623.202629.352077396302165327.davem@davemloft.net>
To:     cjhuang@codeaurora.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH] net: qrtr: free flow in __qrtr_node_release
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1592882523-12870-1-git-send-email-cjhuang@codeaurora.org>
References: <1592882523-12870-1-git-send-email-cjhuang@codeaurora.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Jun 2020 20:26:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>
Date: Tue, 23 Jun 2020 11:22:03 +0800

> @@ -168,6 +168,7 @@ static void __qrtr_node_release(struct kref *kref)
>  	struct radix_tree_iter iter;
>  	unsigned long flags;
>  	void __rcu **slot;
> +	struct qrtr_tx_flow *flow;

Please retain the reverse christmas tree ordering of local variables here.

Thanks.
