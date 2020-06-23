Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B965C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B122064B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944139;
	bh=4nSZAdh0C+LyUZmGaYK7ICPBjH/eBkel2iGSn91HaAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqlFBdU/KaRWNtulVd3kHDYs2FlE+4lvQQQ8xHjw63+OwEQmoM/F6chcg5c3/FBA6
	 fT6nVvaY2kDsdlLSTeYfCvRmnJPt5LDpkaxp8GBwn/mRIwfMyHf/TDfYzUMWK17rs7
	 e80Q/Quy7sCHIsuGRuHmHUGO60bz1c1ZjDCGak0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390931AbgFWU25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390919AbgFWU2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:28:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED67206C3;
        Tue, 23 Jun 2020 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944130;
        bh=4nSZAdh0C+LyUZmGaYK7ICPBjH/eBkel2iGSn91HaAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r94067isYtuK0BXrVGTwGt11gIKm02uBypLrC7OnBpOabcOTropw0+huiyMQ3QEdB
         3r1YrgfXGnVVw8ViEpdA1fq+ykGdhmsw77lrtCL5+Yr7Kh85RPj8ZHaBM6RTFKLcRF
         KLzD2YZq1mihfiuVciFSHp0g2vSNC3xoowAmFd7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 184/314] mfd: stmfx: Fix stmfx_irq_init error path
Date:   Tue, 23 Jun 2020 21:56:19 +0200
Message-Id: <20200623195347.668219081@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index fde6541e347c8..1977fe95f876c 100644
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



