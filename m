Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D17C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6120D2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbgCQB1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:27:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50596 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733017AbgCQB1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:27:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A7B60157A5E89;
        Mon, 16 Mar 2020 18:27:09 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:27:08 -0700 (PDT)
Message-Id: <20200316.182708.2275968776439275159.davem@davemloft.net>
To:     yangpc@wangsu.com
Cc:     edumazet@google.com, ncardwell@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next v2 0/5] tcp: fix stretch ACK bugs in
 congestion control modules
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1584340511-9870-1-git-send-email-yangpc@wangsu.com>
References: <1584340511-9870-1-git-send-email-yangpc@wangsu.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Mar 2020 18:27:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pengcheng Yang <yangpc@wangsu.com>
Date: Mon, 16 Mar 2020 14:35:06 +0800

> "stretch ACKs" (caused by LRO, GRO, delayed ACKs or middleboxes)
> can cause serious performance shortfalls in common congestion
> control algorithms. Neal Cardwell submitted a series of patches
> starting with commit e73ebb0881ea ("tcp: stretch ACK fixes prep")
> to handle stretch ACKs and fixed stretch ACK bugs in Reno and
> CUBIC congestion control algorithms.
> 
> This patch series continues to fix bic, scalable, veno and yeah
> congestion control algorithms to handle stretch ACKs.
> 
> Changes in v2:
> - Provide [PATCH 0/N] to describe the modifications of this patch series

Series applied, thanks.
