Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5DAC35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78612469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811706;
	bh=/cgqfmp8nwk5RY90ggAflTwKCmubantpkDVWc3yF89U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lp1OB0Q6OyhNBeCl0DyxbXepbrL5qofp39KPL6KhWZVFbLI6EkzU5V6Sf8b/RP2kr
	 AE+7z+qCXxBBijTrHxzEjoX76FvULTgcfFfXDHsWCPr2rfV+CAoyVKnn34bgLCjsDC
	 N+e2LoSb1i5QidSvaf0eGFf/fTKzDSGDrRDhhwWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgB0NzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731488AbgB0NzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:55:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179262469D;
        Thu, 27 Feb 2020 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811701;
        bh=/cgqfmp8nwk5RY90ggAflTwKCmubantpkDVWc3yF89U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAlwyptMBKYwB5gqr+U6s6B7f8GkaQGZShVsagr3uvNl8FfQL1mC2GKiXlYSwvaGn
         djNO2BdT3L+0hjbQJDbZC8+TY0p7Y5EOOylHOrJz8ke4tm7OKTu3dc5On0QS48P+Th
         pxsdwKgfpMTINF77nx/jWk6Sd7uhedRzrNLm3ruI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sun Ke <sunke32@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/237] nbd: add a flush_workqueue in nbd_start_device
Date:   Thu, 27 Feb 2020 14:34:41 +0100
Message-Id: <20200227132302.000021274@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
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
index 4c661ad91e7d3..8f56e6b2f114f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1203,6 +1203,16 @@ static int nbd_start_device(struct nbd_device *nbd)
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



