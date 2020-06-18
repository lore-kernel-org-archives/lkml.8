Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FA3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84AD2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446528;
	bh=jooARIFQyutBq1ygAucaUY+mBk/+xG06hczMM+cGxrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oFkQJ/ee9ZMID2kbs3VTDGVRCp5K8/wq2mlGyU2090ZzmRqsCdTj/UruNizGt6uG0
	 OiQNA6bDrGyvy0jOmQ3QE3rvPlNPAz0aAHkEMZq9yNMIWm443N/q6JxlBGNYj0lktc
	 +/XtH+bkjoOJDSfIR1WIMpqKuYz/sq3cdsA5eooY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbgFRCP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgFRBUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:20:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E76206F1;
        Thu, 18 Jun 2020 01:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443234;
        bh=jooARIFQyutBq1ygAucaUY+mBk/+xG06hczMM+cGxrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFQBSwXrObF4kZ+fWuQAYBmb6tpcDsznZ4etaApXK5ZY5ZAvkGEn+QaZZ4OhDiRjp
         1lTr+PGtdMByYgNxTI6ECFFPE5sRmK1mLDHUFWzOa3kJ38yLl/fW70NoWzHfABxOQ4
         rY5whY03Psjb/Hug46NBDUP/C1FJX2k51z/DQyCA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 187/266] mfd: stmfx: Fix stmfx_irq_init error path
Date:   Wed, 17 Jun 2020 21:15:12 -0400
Message-Id: <20200618011631.604574-187-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

[ Upstream commit 60c2c4bcb9202acad4cc26af20b44b6bd7874f7b ]

In case the interrupt signal can't be configured, IRQ domain needs to be
removed.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmfx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index fde6541e347c..1977fe95f876 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -287,14 +287,19 @@ static int stmfx_irq_init(struct i2c_client *client)
 
 	ret = regmap_write(stmfx->map, STMFX_REG_IRQ_OUT_PIN, irqoutpin);
 	if (ret)
-		return ret;
+		goto irq_exit;
 
 	ret = devm_request_threaded_irq(stmfx->dev, client->irq,
 					NULL, stmfx_irq_handler,
 					irqtrigger | IRQF_ONESHOT,
 					"stmfx", stmfx);
 	if (ret)
-		stmfx_irq_exit(client);
+		goto irq_exit;
+
+	return 0;
+
+irq_exit:
+	stmfx_irq_exit(client);
 
 	return ret;
 }
-- 
2.25.1

