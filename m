Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D23C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46263208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271254;
	bh=3IvopkT27FOsq+8sijVVp9M6p5tv3XeeY25VMCYj45M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVoc+Hm8phNGN23EsgoTXic4eRncxNIVPzwbvUlXe8t0nN3kObOwXk+MdhIBMvoy7
	 lY0sOy62BzGQdESvM2nIK05YQ4yplJJAZTpFDXrsJWAtMwWLp2xqrKc35Io/FXJzNd
	 lkELjCCRlTmjFIyIsIj7oiy8sXA6ZI/tdSKs4KYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgBUHrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbgBUHr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:47:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1815D222C4;
        Fri, 21 Feb 2020 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271247;
        bh=3IvopkT27FOsq+8sijVVp9M6p5tv3XeeY25VMCYj45M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iuiv07VThuj6010lo3I5RryNeb409wey+q+Bb/znRogFTRj55nE8IjMhueS4DMYZ8
         petywk73Vzt0Y2rjmADM5ledkDxaGMJwKPf5lmy+/Lc98YLscHFnIMDUm6TeHqpLnP
         J3Q55p0ygwr365GTNaHmOUNGs9uKi16x8L8fXzYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sun Ke <sunke32@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 094/399] nbd: add a flush_workqueue in nbd_start_device
Date:   Fri, 21 Feb 2020 08:36:59 +0100
Message-Id: <20200221072411.495353985@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sun Ke <sunke32@huawei.com>

[ Upstream commit 5c0dd228b5fc30a3b732c7ae2657e0161ec7ed80 ]

When kzalloc fail, may cause trying to destroy the
workqueue from inside the workqueue.

If num_connections is m (2 < m), and NO.1 ~ NO.n
(1 < n < m) kzalloc are successful. The NO.(n + 1)
failed. Then, nbd_start_device will return ENOMEM
to nbd_start_device_ioctl, and nbd_start_device_ioctl
will return immediately without running flush_workqueue.
However, we still have n recv threads. If nbd_release
run first, recv threads may have to drop the last
config_refs and try to destroy the workqueue from
inside the workqueue.

To fix it, add a flush_workqueue in nbd_start_device.

Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
Signed-off-by: Sun Ke <sunke32@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b4607dd961852..78181908f0df6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1265,6 +1265,16 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args = kzalloc(sizeof(*args), GFP_KERNEL);
 		if (!args) {
 			sock_shutdown(nbd);
+			/*
+			 * If num_connections is m (2 < m),
+			 * and NO.1 ~ NO.n(1 < n < m) kzallocs are successful.
+			 * But NO.(n + 1) failed. We still have n recv threads.
+			 * So, add flush_workqueue here to prevent recv threads
+			 * dropping the last config_refs and trying to destroy
+			 * the workqueue from inside the workqueue.
+			 */
+			if (i)
+				flush_workqueue(nbd->recv_workq);
 			return -ENOMEM;
 		}
 		sk_set_memalloc(config->socks[i]->sock->sk);
-- 
2.20.1



