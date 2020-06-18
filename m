Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72570C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEE521534
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448298;
	bh=wHkSkEP48QqY9sVrWec+oICiOy5IX+3I8wiXhfmvmRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vEUZolMY4ClCTTthXIaXz21FyPTBTTI9yZSt6d8sipRU9AoDHgxWxSyFpOcQgVjUo
	 radREhE78MV/RrjVqqmP1Uxh5xDCUXHwg5AAeXNi9q5zpQ2t6/qQixdtAcHQBd3Ryj
	 A0FtQ2MgeyP8fUMUMJtfYCJKYg0cI32UtkBjxpd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbgFRCo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFRBLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D482920CC7;
        Thu, 18 Jun 2020 01:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442667;
        bh=wHkSkEP48QqY9sVrWec+oICiOy5IX+3I8wiXhfmvmRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9iKAuFdKmGKhYomRpL9fpPnOYuqC5lzXtVElg1lWL1xRNx6T+OlI3waUafREB9X/
         ZwtEvw8Y3xqLY838lCYkeYaN03ylBmgJueEjsvQQqSdN4z9qOWqN1tWb6k8AIABe9O
         VoV6ZiycP0Wg+Jg2q7O1iOnN5v40Jz4k3uW4btsQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.7 137/388] staging: gasket: Fix mapping refcnt leak when register/store fails
Date:   Wed, 17 Jun 2020 21:03:54 -0400
Message-Id: <20200618010805.600873-137-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit e3436ce60cf5f5eaedda2b8c622f69feb97595e2 ]

gasket_sysfs_register_store() invokes get_mapping(), which returns a
reference of the specified gasket_sysfs_mapping object to "mapping" with
increased refcnt.

When gasket_sysfs_register_store() returns, local variable "mapping"
becomes invalid, so the refcount should be decreased to keep refcount
balanced.

The reference counting issue happens in one exception handling path of
gasket_sysfs_register_store(). When gasket_dev is NULL, the function
forgets to decrease the refcnt increased by get_mapping(), causing a
refcnt leak.

Fix this issue by calling put_mapping() when gasket_dev is NULL.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Link: https://lore.kernel.org/r/1587618941-13718-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/gasket/gasket_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index ad852ea1d4a9..af26bc9f184a 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -373,6 +373,7 @@ ssize_t gasket_sysfs_register_store(struct device *device,
 	gasket_dev = mapping->gasket_dev;
 	if (!gasket_dev) {
 		dev_err(device, "Device driver may have been removed\n");
+		put_mapping(mapping);
 		return 0;
 	}
 
-- 
2.25.1

