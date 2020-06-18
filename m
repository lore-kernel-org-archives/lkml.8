Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46908C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2082721974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442490;
	bh=3ixtTqSgLT06EGmTqWLRPWX9EpoK3ocTPIYY48k+Euc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NCT/cGMesOIvVBkcEWQWy/oUZXcK2zY3bgjlzBiayJWkOBYlj0WXo9v838kFU29J4
	 i9+4BAMkGzOxgDS08qRGtQV6E6w3D/FUsW/6Ra185ni9JLKiPjDzBXjCNmfwKWD7QE
	 Nbemgqt+1DqvYTI+1PJWaWgRWitW/mC3lls7E5qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgFRBIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFRBII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:08:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05FCD2193E;
        Thu, 18 Jun 2020 01:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442487;
        bh=3ixtTqSgLT06EGmTqWLRPWX9EpoK3ocTPIYY48k+Euc=;
        h=From:To:Cc:Subject:Date:From;
        b=QqIdWrNZKNKV+wqOJWLxGXAwpcmLF8Jz38jxeuIK1Th716Dys5IrnKlQV/E03VLhc
         nrXMVjaUGg0sPXXx/KZQaw1Nl3xzy2yVNAEmhDwtoe0BBt6sHYCl9WKNl0TaDjSNTF
         dUS6hLQJpm1/qmGueM7KQBgux1IygnMgrkM0Tj/k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.7 001/388] staging: wfx: fix potential deadlock in wfx_tx_flush()
Date:   Wed, 17 Jun 2020 21:01:38 -0400
Message-Id: <20200618010805.600873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index 39d9127ce4b9..8ae23681e29b 100644
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

