Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AC3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CBA22B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753345;
	bh=L8OkVoVGT5bSyOPmDkekneAoeoWXuGso5pB0olpykmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cw4OvwSeFyBrjPiVQKrcOveWqwZVlF7ACYAkmxipysyfB8uz3LlSbFTzpfeX9cvZv
	 tvLub7kiWe/EWcAt9OqXd68bOCaAulkYofSISjTTAIcqsT8yjbYZ06MyQjIt+VEqVi
	 aWi2vc/Z1JXjjJ2CikY32t/ctFaFewyMtfrHAN6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgGNTCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730615AbgGNS6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:58:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159DB229CA;
        Tue, 14 Jul 2020 18:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753126;
        bh=L8OkVoVGT5bSyOPmDkekneAoeoWXuGso5pB0olpykmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hh/7SzZbARk1I0QHt/U3wUSeVehZGnl3gSkVYQtnONIJDS7FqjMWPVpHXj4mETZJz
         eYTbT99lUyYoHDCOroTV7pe0kC8Pn3epJKYsNXmqqPE9oVXo9Y0tY9xxss9ORdGGdo
         dB1Bqojb9GUVrZdaoSVegYZN9IETow0YQ4IGV4X4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+934037347002901b8d2a@syzkaller.appspotmail.com,
        Zheng Bin <zhengbin13@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 089/166] nbd: Fix memory leak in nbd_add_socket
Date:   Tue, 14 Jul 2020 20:44:14 +0200
Message-Id: <20200714184120.106462903@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Bin <zhengbin13@huawei.com>

[ Upstream commit 579dd91ab3a5446b148e7f179b6596b270dace46 ]

When adding first socket to nbd, if nsock's allocation failed, the data
structure member "config->socks" was reallocated, but the data structure
member "config->num_connections" was not updated. A memory leak will occur
then because the function "nbd_config_put" will free "config->socks" only
when "config->num_connections" is not zero.

Fixes: 03bf73c315ed ("nbd: prevent memory leak")
Reported-by: syzbot+934037347002901b8d2a@syzkaller.appspotmail.com
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a675..ce7e9f223b20b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1033,25 +1033,26 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	     test_bit(NBD_RT_BOUND, &config->runtime_flags))) {
 		dev_err(disk_to_dev(nbd->disk),
 			"Device being setup by another task");
-		sockfd_put(sock);
-		return -EBUSY;
+		err = -EBUSY;
+		goto put_socket;
+	}
+
+	nsock = kzalloc(sizeof(*nsock), GFP_KERNEL);
+	if (!nsock) {
+		err = -ENOMEM;
+		goto put_socket;
 	}
 
 	socks = krealloc(config->socks, (config->num_connections + 1) *
 			 sizeof(struct nbd_sock *), GFP_KERNEL);
 	if (!socks) {
-		sockfd_put(sock);
-		return -ENOMEM;
+		kfree(nsock);
+		err = -ENOMEM;
+		goto put_socket;
 	}
 
 	config->socks = socks;
 
-	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
-	if (!nsock) {
-		sockfd_put(sock);
-		return -ENOMEM;
-	}
-
 	nsock->fallback_index = -1;
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
@@ -1063,6 +1064,10 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	atomic_inc(&config->live_connections);
 
 	return 0;
+
+put_socket:
+	sockfd_put(sock);
+	return err;
 }
 
 static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
-- 
2.25.1



