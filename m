Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C9EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481D820838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865450;
	bh=h+YsFhOrvxkG1rDExqndtKUWeCndh28lYygtKDg6LN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aE0yu294T4wV3IQRllcuZBnMdVij4WKFLPs2DX9BEpbeqIitJ/dTxKx4Kl2uFLg76
	 vzVj9gNOKyJMNJqLIGfNMbiBROxpmN2CMpBguH8n6ra9WnhQn9Gn1hIrwdyFqz/FN1
	 qmjZ1nil72Xpx0+lOoTWqBt+V4wXMQRDqFcAY9yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbgAXLat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404281AbgAXLaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:30:46 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA1BD2075D;
        Fri, 24 Jan 2020 11:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865445;
        bh=h+YsFhOrvxkG1rDExqndtKUWeCndh28lYygtKDg6LN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noJYTgMnxUpiXiNVyd7Z2dY+2uTUslxHMhFahJTk9IW0nI1DxxNOx/hbVxDmmo+iw
         XRfYSuJb3rG4lBshnI6NXrQsL4w/LXPYpPBAxDIo/izl+lSVeR3A5qQv+aaI6Slrmg
         b+k7KEWskvErl2xk6V+n6u8k9g1CH8dUJIsaSodQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 548/639] rtlwifi: Fix file release memory leak
Date:   Fri, 24 Jan 2020 10:31:58 +0100
Message-Id: <20200124093157.799661387@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 4c3e48794dec7cb568974ba3bf2ab62b9c45ca3e ]

When using single_open() for opening, single_release() should be
used instead of seq_release(), otherwise there is a memory leak.

This is detected by Coccinelle semantic patch.

Fixes: 610247f46feb ("rtlwifi: Improve debugging by using debugfs")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index d70385be99762..498994041bbcb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -109,7 +109,7 @@ static const struct file_operations file_ops_common = {
 	.open = dl_debug_open_common,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = single_release,
 };
 
 static int rtl_debug_get_mac_page(struct seq_file *m, void *v)
-- 
2.20.1



