Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A53CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC682075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097165;
	bh=ZTLZ7x964K0lSCQDLEUcLWhEgUCEQdt1aw8v7T48axw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iplInBlowWr5LWB7H8Kv7hL0MSIEPBCNNyvvp0gMDAgFzAbuhaxdAgjmMTzAqhIDF
	 DAlMDzsOLUgT5zKsh+n6qqGHsJuYLD9FNq2mRVnGE6kv4MNYIKRwvmIE+uMjUgw1Cl
	 TqCAgXceEdPbWVvapOVgzpJus+GAko6OsEeYfZXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgG3ITY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgG3IIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:08:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422C12070B;
        Thu, 30 Jul 2020 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096479;
        bh=ZTLZ7x964K0lSCQDLEUcLWhEgUCEQdt1aw8v7T48axw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkHJE0W2kPBAEIcmflRrcsX0ljW+1yNagQml7ku6osFKgrKjb/K/M8XPoj3/79dPT
         jyBiD+X8bOo8pfuLs4Zr49s3fVQLp68cPMKD/TCb60bQceIma25n6FbWdfs73Oeu5A
         Vb02NwOqznuCPNFKKDn0gZYls0DbJDGW7DJRAXuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/14] net-sysfs: add a newline when printing tx_timeout by sysfs
Date:   Thu, 30 Jul 2020 10:04:48 +0200
Message-Id: <20200730074419.158162647@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074418.882736401@linuxfoundation.org>
References: <20200730074418.882736401@linuxfoundation.org>
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
@@ -1028,7 +1028,7 @@ static ssize_t tx_timeout_show(struct ne
 	trans_timeout = queue->trans_timeout;
 	spin_unlock_irq(&queue->_xmit_lock);
 
-	return sprintf(buf, "%lu", trans_timeout);
+	return sprintf(buf, fmt_ulong, trans_timeout);
 }
 
 static unsigned int get_netdev_queue_index(struct netdev_queue *queue)


