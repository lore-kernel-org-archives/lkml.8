Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB5C4363E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98594208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892443;
	bh=bTEMXvdIvyE2iqBAS9NC+cQYJQ88tOHYymR7wqxovZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PiwbLKm5AIUbmTwRrAuwc4LWuQUXNjBXALTlXACkEXBY59IE0ukoMbdhApOOyuGv2
	 W/USkl+J335GQN52mfwYRPEVPYzf6nPZno1xwrLRKU7DNNWS5wO4qMY5IMKoKMjWGu
	 zHU9qXEHFwBSAPNlUyJ0uRuxK+wMIGsQObo5++f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgG0XYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgG0XYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF0F208E4;
        Mon, 27 Jul 2020 23:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892288;
        bh=bTEMXvdIvyE2iqBAS9NC+cQYJQ88tOHYymR7wqxovZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V69/zwzz+7QUYYZ7iVtxHCcWkXpkOL33h8ZREnEju3lZGjSyIhCtL7b+gkF8R38O3
         um0eMP8NrX0uw4ZT7cRyh/YFxr3yRijGYSw6KtozZDnzqwPrW1NjJDe0Es0rTtEPnq
         3Hk6lRhJZbLNCcEBp8uPD/p0A4CRwgKH8h140UtQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/10] nfc: s3fwrn5: add missing release on skb in s3fwrn5_recv_frame
Date:   Mon, 27 Jul 2020 19:24:36 -0400
Message-Id: <20200727232443.718000-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232443.718000-1-sashal@kernel.org>
References: <20200727232443.718000-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 1e8fd3a97f2d83a7197876ceb4f37b4c2b00a0f3 ]

The implementation of s3fwrn5_recv_frame() is supposed to consume skb on
all execution paths. Release skb before returning -ENODEV.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/s3fwrn5/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/s3fwrn5/core.c b/drivers/nfc/s3fwrn5/core.c
index 9d9c8d57a042d..64b58455e620b 100644
--- a/drivers/nfc/s3fwrn5/core.c
+++ b/drivers/nfc/s3fwrn5/core.c
@@ -209,6 +209,7 @@ int s3fwrn5_recv_frame(struct nci_dev *ndev, struct sk_buff *skb,
 	case S3FWRN5_MODE_FW:
 		return s3fwrn5_fw_recv_frame(ndev, skb);
 	default:
+		kfree_skb(skb);
 		return -ENODEV;
 	}
 }
-- 
2.25.1

