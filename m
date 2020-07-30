Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64021C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5182074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096341;
	bh=VFgmhmkbSeTjSX7A6aEEUHSsr6kFAzZugtm0t3ZldB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZyObA8EhQCa3L1Bwy6VWC3X9M4PPMmSunwjp7SMErhN0zJoeblbqEkklIp3nTakKe
	 ZAiYEHO/Xr3WlwukseDiPMdQF4dO6yA+te28ftiiVezSArHrM+Wb9jIZGowt6bdehh
	 sC18Y6PeB9alS74qnoqgxWQdv0ZVDaXg8JnoBFJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgG3IFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgG3IFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:05:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65BD620656;
        Thu, 30 Jul 2020 08:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096323;
        bh=VFgmhmkbSeTjSX7A6aEEUHSsr6kFAzZugtm0t3ZldB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMEpaV4KdFLHY8c3DmBvD9/itdMG8GtiiMjR8EugbLO1WHCwYiZ9/vHUGW3yPe7c2
         YHuZw/lSgWUdAPVvWyZUwEreK1NxqWkROl4H3s3tbuRqkxlo2uSNGdEoY1XOpDbw5b
         Jq9pqH/k7UdluaoKOlUstHLPY1SblaZddYOWEpdw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 07/20] net-sysfs: add a newline when printing tx_timeout by sysfs
Date:   Thu, 30 Jul 2020 10:03:57 +0200
Message-Id: <20200730074420.887929074@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.533211699@linuxfoundation.org>
References: <20200730074420.533211699@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

[ Upstream commit 9bb5fbea59f36a589ef886292549ca4052fe676c ]

When I cat 'tx_timeout' by sysfs, it displays as follows. It's better to
add a newline for easy reading.

root@syzkaller:~# cat /sys/devices/virtual/net/lo/queues/tx-0/tx_timeout
0root@syzkaller:~#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/net-sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1077,7 +1077,7 @@ static ssize_t tx_timeout_show(struct ne
 	trans_timeout = queue->trans_timeout;
 	spin_unlock_irq(&queue->_xmit_lock);
 
-	return sprintf(buf, "%lu", trans_timeout);
+	return sprintf(buf, fmt_ulong, trans_timeout);
 }
 
 static unsigned int get_netdev_queue_index(struct netdev_queue *queue)


