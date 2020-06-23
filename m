Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AEB20706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942467;
	bh=PrsyZ/ueag/T/vCKpzXyZb0B64vjwYmwBmaN+VAnHQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oisOoBMO1t0AYb03u9oBhrcLWlp1YszzmBsADMbxlK2ru7QYFyQBLdvdXoe7T/VaB
	 LcU1j0mTgOhNDle1V4edFvLlFVw53rJ5fDU65VGELg35BhjBPNg69faKTDAUQ6R4iz
	 Rhz34h12SZqRaK+vRFfyvUBSjzRDk5Vrz7r+rFbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgFWUBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbgFWUBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:01:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0A2206C3;
        Tue, 23 Jun 2020 20:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942462;
        bh=PrsyZ/ueag/T/vCKpzXyZb0B64vjwYmwBmaN+VAnHQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYwEYs//D/0X3Iu7dSGIzaeBhx5SEHPGVPya7d/DjpqvX0RgBS94sO56LxJz/hTLi
         vIb1X0Ikei3qtLrp9kXDVZeS4fzuvWqgOOatGw1BP++zpb387JT7SHb5xHRXWLFYiH
         Kg+evStpPG6VumCwKcm4RNbQfXp/xFPUaaVNME+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 001/477] staging: wfx: fix potential deadlock in wfx_tx_flush()
Date:   Tue, 23 Jun 2020 21:49:58 +0200
Message-Id: <20200623195407.652428032@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

[ Upstream commit a39e761aa4fefa2a8aaf549217329933b91da7c9 ]

wfx_tx_flush() wait there are no more frame in device buffer. However,
this event may never happens since wfx_tx_flush() don't forbid to
enqueue new frames.

Note that wfx_tx_flush() should only ensure that all frames currently in
hardware queues are sent. So the current code is more restrictive that
it should.

Note that wfx_tx_flush() release the lock before to return while
wfx_tx_lock_flush() keep the lock.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Link: https://lore.kernel.org/r/20200401110405.80282-31-Jerome.Pouiller@silabs.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wfx/queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
index 39d9127ce4b9f..8ae23681e29bc 100644
--- a/drivers/staging/wfx/queue.c
+++ b/drivers/staging/wfx/queue.c
@@ -35,6 +35,7 @@ void wfx_tx_flush(struct wfx_dev *wdev)
 	if (wdev->chip_frozen)
 		return;
 
+	wfx_tx_lock(wdev);
 	mutex_lock(&wdev->hif_cmd.lock);
 	ret = wait_event_timeout(wdev->hif.tx_buffers_empty,
 				 !wdev->hif.tx_buffers_used,
@@ -47,6 +48,7 @@ void wfx_tx_flush(struct wfx_dev *wdev)
 		wdev->chip_frozen = 1;
 	}
 	mutex_unlock(&wdev->hif_cmd.lock);
+	wfx_tx_unlock(wdev);
 }
 
 void wfx_tx_lock_flush(struct wfx_dev *wdev)
-- 
2.25.1



