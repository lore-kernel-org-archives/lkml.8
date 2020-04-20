Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6DFC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220E8206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386915;
	bh=cGSnqVk3XEiivt42E5/JP8PziBdXoNJf7P8/UlVSRX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LjTRCQa8OkY1NgAK4qHR4Y3mkAuY2X1larWBJ0FRu12h8VoeWwyffiygVZlaVCn6Z
	 sJ5Ls50Al5lZsd+cg645rMNO8uZhRyO7yZEpprfMF9JgTZqFiKYY4Skyca65MEek/2
	 CaX/+HdF0SIQV+e4YiNdcjmMvlsuzihgDHChsiXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgDTMse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgDTMs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:48:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FA92072B;
        Mon, 20 Apr 2020 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386906;
        bh=cGSnqVk3XEiivt42E5/JP8PziBdXoNJf7P8/UlVSRX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiZe7byB0hu95WBg1OY03bkT0TwftMNBSUFq4C/XcjFMkUHcQh0zpF6yIDgX/UDt/
         D/QrDoiY94E8BeaA3R5JifKAW+uog3fRvca3jspI2mfNvew613Eeq+Rrcx1UiHU8cE
         O/xkuXPlmRch4roxr4OR0sF+YD9ooewHHl0SMquY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Yakunin <zeil@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 06/40] net: revert default NAPI poll timeout to 2 jiffies
Date:   Mon, 20 Apr 2020 14:39:16 +0200
Message-Id: <20200420121452.817040909@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit a4837980fd9fa4c70a821d11831698901baef56b ]

For HZ < 1000 timeout 2000us rounds up to 1 jiffy but expires randomly
because next timer interrupt could come shortly after starting softirq.

For commonly used CONFIG_HZ=1000 nothing changes.

Fixes: 7acf8a1e8a28 ("Replace 2 jiffies with sysctl netdev_budget_usecs to enable softirq tuning")
Reported-by: Dmitry Yakunin <zeil@yandex-team.ru>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3934,7 +3934,8 @@ EXPORT_SYMBOL(netdev_max_backlog);
 
 int netdev_tstamp_prequeue __read_mostly = 1;
 int netdev_budget __read_mostly = 300;
-unsigned int __read_mostly netdev_budget_usecs = 2000;
+/* Must be at least 2 jiffes to guarantee 1 jiffy timeout */
+unsigned int __read_mostly netdev_budget_usecs = 2 * USEC_PER_SEC / HZ;
 int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
 int dev_weight_tx_bias __read_mostly = 1;  /* bias for output_queue quota */


