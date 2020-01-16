Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23206C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D852824684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195468;
	bh=dzy2KhL75lDoksND+HhzTxU0ZmtY+fAKEeJElGLiyFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STwyunyqmH7V7F05mLxa5ZxHP44VEFyiKa0QNcpuXYkAO3YpLz2RT3VrfAm3HkokC
	 zML43V94wxjgpfusEYFRdRtnot4b+75uTuUYbRICo+ynSbnMe9kMg66AdF8Ktqw2pF
	 XtElX1hgzvmVxepnou5wWqRg/DwvKhOTzMS1DrR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391760AbgAPRY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391748AbgAPRYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DA324690;
        Thu, 16 Jan 2020 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195463;
        bh=dzy2KhL75lDoksND+HhzTxU0ZmtY+fAKEeJElGLiyFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXNqFbhqzN6N2aMhQVIA3PLsNCnEHKTkCvjvDmX7WRK7bUNVfNbcb5cHreVdxl2IT
         axasoSPsEwdih+zcp23EVd3hLKDnUDShXaud6dGX/NOfOvc9974Zgb/DT3gw269vcb
         keHR3zqAV6XC7wI5N9WSOkl98+3d8bHxeE9rhRBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Jian <liujian56@huawei.com>,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 071/371] driver: uio: fix possible memory leak in __uio_register_device
Date:   Thu, 16 Jan 2020 12:19:03 -0500
Message-Id: <20200116172403.18149-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit 1a392b3de7c5747506b38fc14b2e79977d3c7770 ]

'idev' is malloced in __uio_register_device() and leak free it before
leaving from the uio_get_minor() error handing case, it will cause
memory leak.

Fixes: a93e7b331568 ("uio: Prevent device destruction while fds are open")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/uio/uio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index fb5c9701b1fb..4e9b0ff79b13 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -939,8 +939,10 @@ int __uio_register_device(struct module *owner,
 	atomic_set(&idev->event, 0);
 
 	ret = uio_get_minor(idev);
-	if (ret)
+	if (ret) {
+		kfree(idev);
 		return ret;
+	}
 
 	idev->dev.devt = MKDEV(uio_major, idev->minor);
 	idev->dev.class = &uio_class;
-- 
2.20.1

