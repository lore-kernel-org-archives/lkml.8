Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2736C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E00420724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947915;
	bh=L15Vj8OeudxmTag2zQVdk1b8JpwbIF3FlYGHITujZPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2roFIjLC9zVufJ1pqx1SaKCRbwNDOcjc6FwgBybrGqmQ8+AmZUrf3/wB01J9uJuka
	 r3lYODQqsjIjgHgrm8QArDN+z8eaQZzHY6PrVyUQ4+cWWVHHf49CPxE/AFUEViawSK
	 UCYNQWqChKB0SCKIBhp92F3P2uI+sgUxmC73FU2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbgFWVby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389008AbgFWUMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:12:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA1B82145D;
        Tue, 23 Jun 2020 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943169;
        bh=L15Vj8OeudxmTag2zQVdk1b8JpwbIF3FlYGHITujZPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REbKA2P8Rr+8/ZAcrgnftA7q9+m8oXyrtDBvpqMw2tTyEyqFjPGl9fw9MnaqaaIhV
         idaQz06DQGAT5z1jDShRrKbFiGTQ+MRvCBSfdvQBKHynX4F447gzg99IOopkV5yTQ/
         GZe2e8ibQT2EKyIxyF5xHcH2SLtbBD0l1q+qulAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 269/477] mfd: stmfx: Reset chip on resume as supply was disabled
Date:   Tue, 23 Jun 2020 21:54:26 +0200
Message-Id: <20200623195420.292114342@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

[ Upstream commit e583649d87ec090444aa5347af0927cd6e8581ae ]

STMFX supply is disabled during suspend. To avoid a too early access to
the STMFX firmware on resume, reset the chip and wait for its firmware to
be loaded.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmfx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 857991cb3cbb8..fde6541e347c8 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -501,6 +501,13 @@ static int stmfx_resume(struct device *dev)
 		}
 	}
 
+	/* Reset STMFX - supply has been stopped during suspend */
+	ret = stmfx_chip_reset(stmfx);
+	if (ret) {
+		dev_err(stmfx->dev, "Failed to reset chip: %d\n", ret);
+		return ret;
+	}
+
 	ret = regmap_raw_write(stmfx->map, STMFX_REG_SYS_CTRL,
 			       &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
 	if (ret)
-- 
2.25.1



