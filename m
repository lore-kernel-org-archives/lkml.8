Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB30EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE13B20706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946892;
	bh=K/4JzaY+ILlY4OM95wmDtD1aA5+zt7bNidlRQvr0BaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o9u/1iTsTISMOx/6tYpIzChuK+iKAcTdIs7nF4jN9PQsd8o+HjQaJBi37YgoYFoHP
	 VpbC7oerGnXUUMTtcY/awEVlrpHYiuZuIWvNGz9Ug7/DVcDCewVSqGnpIo81Tf5MaK
	 HCt14AXbikD6grqTu+gLRDftS9bA/RM9syQQGYCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbgFWVOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390926AbgFWU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:28:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B79AB2064B;
        Tue, 23 Jun 2020 20:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944133;
        bh=K/4JzaY+ILlY4OM95wmDtD1aA5+zt7bNidlRQvr0BaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f77YGjIggT3bENScBz1owFoYMQ5mmmG5e8zfzRBJhsOZGf7hkjHGsk35c0gETz0rr
         eqTECLJFQKcwdzQae8/+HZ1KqhfxLjjIRNif84sFPSeP6vRdlJr528FBPVHAFoUM14
         bMNx/4wQZMFrOH66WEo0189gJiy4CunbcIq4QFDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 185/314] mfd: stmfx: Disable IRQ in suspend to avoid spurious interrupt
Date:   Tue, 23 Jun 2020 21:56:20 +0200
Message-Id: <20200623195347.718453845@linuxfoundation.org>
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

[ Upstream commit 97eda5dcc2cde5dcc778bef7a9344db3b6bf8ef5 ]

When STMFX supply is stopped, spurious interrupt can occur. To avoid that,
disable the interrupt in suspend before disabling the regulator and
re-enable it at the end of resume.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmfx.c       | 6 ++++++
 include/linux/mfd/stmfx.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 1977fe95f876c..711979afd90a0 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -296,6 +296,8 @@ static int stmfx_irq_init(struct i2c_client *client)
 	if (ret)
 		goto irq_exit;
 
+	stmfx->irq = client->irq;
+
 	return 0;
 
 irq_exit:
@@ -486,6 +488,8 @@ static int stmfx_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	disable_irq(stmfx->irq);
+
 	if (stmfx->vdd)
 		return regulator_disable(stmfx->vdd);
 
@@ -529,6 +533,8 @@ static int stmfx_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	enable_irq(stmfx->irq);
+
 	return 0;
 }
 #endif
diff --git a/include/linux/mfd/stmfx.h b/include/linux/mfd/stmfx.h
index 3c67983678ec7..744dce63946e0 100644
--- a/include/linux/mfd/stmfx.h
+++ b/include/linux/mfd/stmfx.h
@@ -109,6 +109,7 @@ struct stmfx {
 	struct device *dev;
 	struct regmap *map;
 	struct regulator *vdd;
+	int irq;
 	struct irq_domain *irq_domain;
 	struct mutex lock; /* IRQ bus lock */
 	u8 irq_src;
-- 
2.25.1



